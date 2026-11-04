# Acceptance test: the package's functions reproduce the re-pilot (pilot-b/).
# Gated, so that R CMD check stays fast:
#   LIONESSIFN_ACCEPTANCE=quick  replicates 1 to 3 of every cell, per-replicate AUCs
#   LIONESSIFN_ACCEPTANCE=full   every replicate, every per-cell summary
test_that("the package reproduces the re-pilot", {
  mode <- Sys.getenv("LIONESSIFN_ACCEPTANCE")
  skip_if(!mode %in% c("quick", "full"), "set LIONESSIFN_ACCEPTANCE")
  old <- readRDS(test_path("fixtures", "pilot_b_replicates.rds"))
  models <- c("R0", "R1", "E1", "E5", "F1R1", "N1R0", "N1R1")
  design <- PilotBDesign()
  n_rep <- if (mode == "quick") 3L else max(old$rep)
  new <- do.call(rbind, lapply(seq_len(nrow(design)), function(i) {
    do.call(rbind, lapply(seq_len(n_rep), function(r) {
      RunReplicate(design[i, ], r, models = models)
    }))
  }))
  ref <- old[old$rep <= n_rep, ]
  ref <- ref[order(ref$cell, ref$rep), ]
  new <- new[order(new$cell, new$rep), ]
  expect_equal(as.matrix(new[, models]), as.matrix(ref[, models]),
               tolerance = 1e-10, ignore_attr = TRUE)
  if (mode == "full") {
    expect_equal(SummarizeCells(new)$mean,
                 readRDS(test_path("fixtures", "pilot_b_cell_summaries.rds"))$mean,
                 tolerance = 1e-10)
  }
})
