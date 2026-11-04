# analysis/01_simulation.R
# The simulation study. Until the design stop of stage 3 it carries the
# re-pilot's design (PilotBDesign()); protocol.md replaces it.
# Run from the project root:
#   Rscript analysis/01_simulation.R --run quick --reps 40
#   Rscript analysis/01_simulation.R --run production
# Writes results/simulation_replicates.rds, results/cell_summaries.rds,
# results/known_answers.rds, results/design.rds, results/run_info.rds, and
# results/sessionInfo.txt.

devtools::load_all(here::here(), quiet = TRUE)
library(parallel)

# ---- parameter block --------------------------------------------------------
design <- PilotBDesign()                 # the factor levels; protocol.md replaces it
models <- c("R0", "R1", "E1", "E5", "F1R1", "N1R0", "N1R1")
n_rep_production <- 200L                 # protocol.md sets it
n_workers <- 3L                          # the core cap (rules.md, section 5)
# ------------------------------------------------------------------------------

args <- commandArgs(trailingOnly = TRUE)
opt <- function(flag, default) {
  i <- match(flag, args)
  if (is.na(i)) default else args[i + 1]
}
run <- opt("--run", "quick")
stopifnot(run %in% c("quick", "production"))
n_rep <- if (run == "production") n_rep_production else as.integer(opt("--reps", 40))
out_dir <- here::here("results")
dir.create(out_dir, showWarnings = FALSE)

Sys.setenv(OPENBLAS_NUM_THREADS = "1", OMP_NUM_THREADS = "1", MKL_NUM_THREADS = "1")
cl <- makePSOCKcluster(n_workers)
clusterExport(cl, c("n_rep", "models"))
clusterEvalQ(cl, {
  Sys.setenv(OPENBLAS_NUM_THREADS = "1", OMP_NUM_THREADS = "1")
  devtools::load_all(here::here(), quiet = TRUE)
  NULL
})
start <- Sys.time()
order_cells <- order(-(design$n1 + design$n0))
res <- parLapplyLB(cl, split(design, design$cell)[order_cells], function(row) {
  do.call(rbind, lapply(seq_len(n_rep), function(r) RunReplicate(row, r, models = models)))
}, chunk.size = 1)
stopCluster(cl)
elapsed <- as.numeric(difftime(Sys.time(), start, units = "secs"))
reps <- do.call(rbind, res)
reps <- reps[order(reps$cell, reps$rep), ]

saveRDS(reps, file.path(out_dir, "simulation_replicates.rds"))
summaries <- SummarizeCells(reps)
saveRDS(summaries, file.path(out_dir, "cell_summaries.rds"))
saveRDS(KnownAnswerChecks(summaries, design = design), file.path(out_dir, "known_answers.rds"))
saveRDS(design, file.path(out_dir, "design.rds"))
saveRDS(list(run = run, n_rep = n_rep, n_cells = nrow(design), date = Sys.time(),
             elapsed_seconds = elapsed, n_workers = n_workers,
             note = "simulation study; design of pilot-b until protocol.md",
             n_rep_production = n_rep_production),
        file.path(out_dir, "run_info.rds"))
writeLines(capture.output(sessionInfo()), file.path(out_dir, "sessionInfo.txt"))
cat(sprintf("%s run: %d cells x %d replicates in %.0f s\n", run, nrow(design), n_rep, elapsed))
