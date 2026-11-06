# analysis/01_simulation.R
# The simulation study of protocol.md: S1 (the unequal-groups law), S2 (25
# settings: the interferon artifact, equivalence, parametrization), and the
# seven test settings (the real-data procedure's error rates and power).
# Run from the project root:
#   Rscript analysis/01_simulation.R --run quick --reps 20 --reps-test 10 --reps-s1 100
#   Rscript analysis/01_simulation.R --run production
# Each replicate's seed is its setting's seed plus the replicate index
# (StudyDesign()); settings are split into seeded blocks of replicates, the
# tasks of parLapplyLB(chunk.size = 1) on PSOCK workers with the BLAS pinned.
# Writes results/: s2_replicates.rds, cell_summaries.rds, test_replicates.rds,
# test_summaries.rds, s1_replicates.rds, s1_summaries.rds, known_answers.rds,
# design.rds, run_info.rds, sessionInfo.txt.

devtools::load_all(here::here(), quiet = TRUE)
library(parallel)

# ---- parameter block (protocol.md, section 4) --------------------------------
design <- StudyDesign()
models <- c("R0", "R1", "E1", "E4", "E5E1", "F1E1", "N1E1", "N2E1", "N1R0")
n_rep_production <- c(s2 = 400L, test = 300L, s1 = 1000L)
block <- c(s2 = 10L, test = 5L, s1 = 250L)  # replicates per task
n_workers <- 3L                             # the core cap (rules.md, section 5)
# ------------------------------------------------------------------------------

args <- commandArgs(trailingOnly = TRUE)
opt <- function(flag, default) {
  i <- match(flag, args)
  if (is.na(i)) default else args[i + 1]
}
run <- opt("--run", "quick")
stopifnot(run %in% c("quick", "production"))
n_rep <- if (run == "production") n_rep_production else
  c(s2 = as.integer(opt("--reps", 20)), test = as.integer(opt("--reps-test", 10)),
    s1 = as.integer(opt("--reps-s1", 100)))
out_dir <- here::here("results")
dir.create(out_dir, showWarnings = FALSE)

# tasks: (study, setting, first replicate, last replicate)
Tasks <- function(d, study) {
  do.call(rbind, lapply(seq_len(nrow(d)), function(i) {
    starts <- seq(1L, n_rep[[study]], by = block[[study]])
    data.frame(study = study, row = i, from = starts,
               to = pmin(starts + block[[study]] - 1L, n_rep[[study]]),
               size = d$n1[i] + d$n0[i])
  }))
}
tasks <- rbind(Tasks(design$s2, "s2"), Tasks(design$test, "test"),
               Tasks(design$s1, "s1"))
# the costliest first, so the load balances: test blocks repeat the
# cross-validation five times
cost <- tasks$size^1.5 * (tasks$to - tasks$from + 1) *
  ifelse(tasks$study == "test", 5, ifelse(tasks$study == "s1", 0.01, 1))
tasks <- tasks[order(-cost), ]

Sys.setenv(OPENBLAS_NUM_THREADS = "1", OMP_NUM_THREADS = "1", MKL_NUM_THREADS = "1")
cl <- makePSOCKcluster(n_workers)
clusterExport(cl, c("design", "models"))
clusterEvalQ(cl, {
  Sys.setenv(OPENBLAS_NUM_THREADS = "1", OMP_NUM_THREADS = "1")
  devtools::load_all(here::here(), quiet = TRUE)
  NULL
})
start <- Sys.time()
res <- parLapplyLB(cl, split(tasks, seq_len(nrow(tasks))), function(tk) {
  row <- design[[tk$study]][tk$row, ]
  out <- lapply(tk$from:tk$to, function(r) {
    switch(tk$study,
           s2 = suppressWarnings(RunReplicate(row, r, models = models)),
           test = suppressWarnings(TestReplicate(row, r)),
           s1 = S1Replicate(row, r))
  })
  list(study = tk$study, reps = do.call(rbind, out))
}, chunk.size = 1)
stopCluster(cl)
elapsed <- as.numeric(difftime(Sys.time(), start, units = "secs"))

Collect <- function(study) {
  r <- do.call(rbind, lapply(res[vapply(res, `[[`, "", "study") == study],
                             `[[`, "reps"))
  r[order(r$cell, r$rep), ]
}
s2 <- Collect("s2")
test <- Collect("test")
s1 <- Collect("s1")
saveRDS(s2, file.path(out_dir, "s2_replicates.rds"))
saveRDS(test, file.path(out_dir, "test_replicates.rds"))
saveRDS(s1, file.path(out_dir, "s1_replicates.rds"))

summaries <- SummarizeCells(s2)
saveRDS(summaries, file.path(out_dir, "cell_summaries.rds"))
RateSummary <- function(v) c(mean = mean(v), mcse = sqrt(mean(v) * (1 - mean(v)) / length(v)))
test_sum <- do.call(rbind, lapply(split(test, test$cell), function(t) {
  data.frame(cell = t$cell[1], n_rep = nrow(t),
             reject_d1 = mean(t$reject_d1),
             reject_d1_mcse = RateSummary(t$reject_d1)[["mcse"]],
             equiv_d2 = mean(t$equiv_d2),
             equiv_d2_mcse = RateSummary(t$equiv_d2)[["mcse"]],
             d1 = mean(t$d1), d1_mcse = stats::sd(t$d1) / sqrt(nrow(t)),
             d2 = mean(t$d2), d2_mcse = stats::sd(t$d2) / sqrt(nrow(t)))
}))
saveRDS(test_sum, file.path(out_dir, "test_summaries.rds"))
s1_sum <- do.call(rbind, lapply(split(s1, s1$cell), function(t) {
  data.frame(cell = t$cell[1], n_rep = nrow(t),
             observed = mean(t$observed), predicted = mean(t$predicted),
             gap = mean(t$gap), gap_mcse = stats::sd(t$gap) / sqrt(nrow(t)))
}))
saveRDS(s1_sum, file.path(out_dir, "s1_summaries.rds"))

# known answers: the S2 settings with no class difference are the null cells,
# and S1 checks equation (3)
ka_design <- design$s2
ka_design$mechanism[(ka_design$mechanism == "ifn" & ka_design$level == "none") |
                      (ka_design$mechanism == "network" & ka_design$level == "0")] <- "null"
ka <- KnownAnswerChecks(summaries, design = ka_design)
for (i in seq_len(nrow(s1_sum))) {
  d <- design$s1[design$s1$cell == s1_sum$cell[i], ]
  ka <- rbind(ka, data.frame(
    check = "Mean shift: class difference in mean edge minus equation (3)",
    setting = sprintf("S1 setting %d (share %.2f, shift %s SD, N 400), %d replicates",
                      d$cell, d$share, d$level, s1_sum$n_rep[i]),
    known = 0, computed = s1_sum$gap[i], mcse = s1_sum$gap_mcse[i],
    type = "mcse", stringsAsFactors = FALSE))
}
saveRDS(ka, file.path(out_dir, "known_answers.rds"))
saveRDS(design, file.path(out_dir, "design.rds"))
saveRDS(list(run = run, n_rep = n_rep[["s2"]], n_rep_test = n_rep[["test"]],
             n_rep_s1 = n_rep[["s1"]],
             n_cells = nrow(design$s2) + nrow(design$test) + nrow(design$s1),
             date = Sys.time(), elapsed_seconds = elapsed, n_workers = n_workers,
             note = "simulation study of protocol.md",
             n_rep_production = n_rep_production[["s2"]]),
        file.path(out_dir, "run_info.rds"))
writeLines(capture.output(sessionInfo()), file.path(out_dir, "sessionInfo.txt"))
cat(sprintf("%s run: S2 %d x %d, test %d x %d, S1 %d x %d replicates in %.0f s\n",
            run, nrow(design$s2), n_rep[["s2"]], nrow(design$test), n_rep[["test"]],
            nrow(design$s1), n_rep[["s1"]], elapsed))
