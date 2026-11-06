# pilot-c/pilot.R
# The pre-registered third pilot (pilot-c/preregistration.md). Run from the project root:
#   Rscript pilot-c/pilot.R --timing        ten replicates per cell, timing only
#   Rscript pilot-c/pilot.R --reps <n>      the run
# Tasks are the 9 cells, on three PSOCK workers with the BLAS pinned to one
# thread, scheduled by parLapplyLB(chunk.size = 1). Each replicate's seed is
# the cell seed plus the replicate index (PilotCDesign()).

devtools::load_all(here::here(), quiet = TRUE)
library(parallel)

args <- commandArgs(trailingOnly = TRUE)
timing <- "--timing" %in% args
n_rep <- if (timing) 10L else as.integer(args[match("--reps", args) + 1])
stopifnot(!is.na(n_rep), n_rep >= 1)
n_workers <- 3L
out_dir <- here::here("pilot-c", "results")
dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)

design <- PilotCDesign()
models <- c("R0", "R1", "E1", "E4", "E5E1", "F1E1", "N1E1", "N2E1", "N1R0")
Sys.setenv(OPENBLAS_NUM_THREADS = "1", OMP_NUM_THREADS = "1",
           MKL_NUM_THREADS = "1")
cl <- makePSOCKcluster(n_workers)
clusterExport(cl, c("n_rep", "models"))
clusterEvalQ(cl, {
  Sys.setenv(OPENBLAS_NUM_THREADS = "1", OMP_NUM_THREADS = "1")
  devtools::load_all(here::here(), quiet = TRUE)
  NULL
})
start <- Sys.time()
# the largest cells first, so the load balances
order_cells <- order(-(design$n1 + design$n0))
res <- parLapplyLB(cl, split(design, design$cell)[order_cells], function(row) {
  t0 <- Sys.time()
  reps <- do.call(rbind, lapply(seq_len(n_rep), function(r) suppressWarnings(RunReplicate(row, r, models = models))))
  reps$seconds_cell <- as.numeric(difftime(Sys.time(), t0, units = "secs"))
  reps
}, chunk.size = 1)
stopCluster(cl)
elapsed <- as.numeric(difftime(Sys.time(), start, units = "secs"))
reps <- do.call(rbind, res)
reps <- reps[order(reps$cell, reps$rep), ]

if (timing) {
  per_cell <- unique(reps[, c("cell", "seconds_cell")])
  per_cell$seconds_per_rep <- per_cell$seconds_cell / n_rep
  saveRDS(list(per_cell = per_cell, elapsed = elapsed, n_rep = n_rep,
               n_workers = n_workers, date = Sys.time()),
          file.path(out_dir, "timing.rds"))
  print(per_cell)
  cat(sprintf("elapsed %.0f s for %d replicates per cell on %d workers\n",
              elapsed, n_rep, n_workers))
} else {
  saveRDS(reps, file.path(out_dir, "replicates.rds"))
  summaries <- SummarizeCells(reps)
  saveRDS(summaries, file.path(out_dir, "cell_summaries.rds"))
  saveRDS(KnownAnswerChecks(summaries, design = design), file.path(out_dir, "known_answers.rds"))
  saveRDS(design, file.path(out_dir, "design.rds"))
  saveRDS(list(run = "pilot", n_rep = n_rep, n_cells = nrow(design),
               date = Sys.time(), elapsed_seconds = elapsed,
               n_workers = n_workers,
               note = "pre-registered third pilot, pilot-c/preregistration.md",
               n_rep_production = NA_integer_),
          file.path(out_dir, "run_info.rds"))
  writeLines(capture.output(sessionInfo()), file.path(out_dir, "sessionInfo.txt"))
  cat(sprintf("done: %d cells x %d replicates in %.0f s\n", nrow(design), n_rep,
              elapsed))
}
