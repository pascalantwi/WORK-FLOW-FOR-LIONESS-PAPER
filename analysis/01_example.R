# 01_example.R
# Example analysis script. Calls functions from R/, reads nothing, and writes
# only to results/. Replace it with your own numbered scripts (02_..., 03_...).
#
# Run from the project root:  Rscript analysis/01_example.R

devtools::load_all()

# Design: one row per cell. Each cell gets its own seed, derived from the row
# index, so a cell can be rerun alone and no two cells share random numbers.
design <- expand.grid(shift = c(0, 1, 2), p_ctrl = c(0.2, 0.5), rho = 0.5)
design$seed <- 1000 + seq_len(nrow(design))

n_total <- 100  # fixed total N, so balance is not confounded with sample size
n_rep <- 200    # smoke-test size; use the R set in protocol.md for a real run

cells <- vector("list", nrow(design))
for (i in seq_len(nrow(design))) {
  cell <- design[i, ]
  set.seed(cell$seed)
  n_ctrl <- round(n_total * cell$p_ctrl)
  pooled_cor <- replicate(n_rep, {
    d <- SimulateCohort(n_ctrl, n_total - n_ctrl, shift = cell$shift,
                        rho = cell$rho)
    cor(d$gene_a, d$gene_b)
  })
  cells[[i]] <- data.frame(cell, rep = seq_len(n_rep), pooled_cor = pooled_cor,
                           row.names = NULL)
}
results <- do.call(rbind, cells)

# Save per-replicate results, never summaries only. Summaries are computed from
# these files when the manuscript renders.
saveRDS(results, here::here("results", "example_replicates.rds"))
writeLines(capture.output(sessionInfo()),
           here::here("results", "example_session_info.txt"))
