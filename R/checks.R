#' Known-answer checks of the pilot
#'
#' Code-identity checks of the closed forms against literal LIONESS, checks of
#' the AUC on cases with a known answer, and, when the run's cell summaries
#' are given, the null cells (every AUC near 0.5) and the mean-shift formula.
#'
#' @param summaries Optional output of [SummarizeCells()] from the run.
#' @param seed Seed for the simulated inputs of the code-identity checks.
#' @param design The design the summaries come from ([PilotDesign()] or
#'   [PilotBDesign()]).
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
  if (!is.null(summaries)) {
    models <- intersect(c("R0", "R1", "E1", "E4", "E5", "F1R1", "N1R0", "N1R1"),
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
