#' Known-answer checks of the pilot
#'
#' Code-identity checks of the closed forms against literal LIONESS, checks of
#' the AUC on cases with a known answer, and, when the run's cell summaries
#' are given, the null cells (every AUC near 0.5) and the mean-shift formula.
#'
#' @param summaries Optional output of [SummarizeCells()] from the run.
#' @param seed Seed for the simulated inputs of the code-identity checks.
#' @param design The design the summaries come from ([PilotDesign()],
#'   [PilotBDesign()], or [PilotCDesign()]).
#' @return A data frame: `check`, `setting`, `known`, `computed`, `mcse`
#'   (`NA` for exact identities), and `type` (`"identity"` or `"mcse"`).
#' @export
KnownAnswerChecks <- function(summaries = NULL, seed = 1L,
                              design = PilotDesign()) {
  set.seed(seed)
  rows <- list()
  add <- function(check, setting, known, computed, mcse = NA_real_,
                  type = "identity") {
    rows[[length(rows) + 1]] <<- data.frame(
      check = check, setting = setting, known = known, computed = computed,
      mcse = mcse, type = type, stringsAsFactors = FALSE)
  }
  for (n in c(12, 60)) {
    x <- matrix(stats::rnorm(n * 6), n, 6)
    x[1, ] <- x[1, ] * 6
    add("Exact LIONESS Pearson edge equals leave-one-out LIONESS",
        sprintf("N = %d, 6 genes, one outlier; largest absolute difference", n),
        0, max(abs(LionessEdges(x) - LionessEdgesDirect(x))))
    x_new <- matrix(stats::rnorm(5 * 6), 5, 6)
    add("Exact add-one edge equals (N + 1) r(+q) - N r",
        sprintf("reference N = %d, 5 new samples; largest absolute difference",
                n),
        0, max(abs(LionessTestEdges(x_new, x) -
                     LionessTestEdgesDirect(x_new, x))))
  }
  x <- matrix(stats::rnorm(4000 * 2), 4000, 2) %*% chol(matrix(c(1, .5, .5, 1), 2))
  add("First-order edge approaches the exact edge as N grows",
      "N = 4000, r = 0.5; largest absolute difference", 0,
      max(abs(LionessEdgesFirstOrder(x) - LionessEdges(x))))
  add("AUC of perfectly separated scores", "5 against 5", 1,
      Auc(1:10, rep(0:1, each = 5)))
  add("AUC of tied scores", "all scores equal", 0.5,
      Auc(rep(1, 10), rep(0:1, each = 5)))
  # partial-correlation LIONESS edges against the inverse-covariance formula
  x <- matrix(stats::rnorm(30 * 4), 30, 4)
  cond <- cbind(stats::rnorm(30), stats::rnorm(30))
  x[, 1:2] <- x[, 1:2] + cond[, 1]
  PcorLit <- function(xx, cc) {
    p <- ncol(xx)
    pr <- PairIndex(p)
    apply(pr, 1, function(ij) {
      pm <- solve(stats::cov(cbind(xx[, ij], cc)))
      -pm[1, 2] / sqrt(pm[1, 1] * pm[2, 2])
    })
  }
  rho <- PcorLit(x, cond)
  lit <- t(sapply(seq_len(30), function(q) {
    30 * rho - 29 * PcorLit(x[-q, ], cond[-q, ])
  }))
  add("Partial-correlation LIONESS edge equals the inverse-covariance formula",
      "N = 30, 4 genes, 2 conditioning variables; largest absolute difference",
      0, max(abs(LionessPartialEdges(x, cond) - lit)))
  x_new <- matrix(stats::rnorm(3 * 4), 3, 4)
  c_new <- cbind(stats::rnorm(3), stats::rnorm(3))
  lit_new <- t(sapply(1:3, function(q) {
    31 * PcorLit(rbind(x, x_new[q, ]), rbind(cond, c_new[q, ])) - 30 * rho
  }))
  add("Partial-correlation add-one edge equals the inverse-covariance formula",
      "reference N = 30, 3 new samples; largest absolute difference", 0,
      max(abs(LionessPartialTestEdges(x_new, c_new, x, cond) - lit_new)))
  add("Partial-correlation edge with no conditioning set equals the Pearson edge",
      "N = 30, 4 genes; largest absolute difference", 0,
      max(abs(LionessPartialEdges(x) - LionessEdges(x))))
  if (!is.null(summaries)) {
    models <- intersect(c("R0", "R1", "E1", "E4", "E5", "F1R1", "N1R0", "N1R1",
                          "E5E1", "F1E1", "N1E1", "N2E1"),
                        unique(summaries$quantity[!is.na(summaries$mean)]))
    for (cl in design$cell[design$mechanism == "null"]) {
      for (m in models) {
        s <- summaries[summaries$cell == cl & summaries$quantity == m, ]
        add(sprintf("Null cell: AUC of %s is 0.5", m),
            sprintf("cell %d (share %.1f, n %d), %d replicates", cl,
                    design$share[cl], design$n1[cl], s$n_rep),
            0.5, s$mean, s$mcse, "mcse")
      }
    }
    for (cl in design$cell[design$mechanism == "shift"]) {
      s <- summaries[summaries$cell == cl & summaries$quantity == "shift_gap", ]
      add("Mean shift: class difference in mean edge minus equation (3)",
          sprintf("cell %d (share %.1f, n %d), module pairs, %d replicates",
                  cl, design$share[cl], design$n1[cl], s$n_rep),
          0, s$mean, s$mcse, "mcse")
    }
  }
  do.call(rbind, rows)
}
