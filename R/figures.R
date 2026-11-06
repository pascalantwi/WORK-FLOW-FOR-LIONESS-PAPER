#' Plot paired AUC differences by cell
#'
#' One row per cell, one colored point per quantity, with bars of two Monte
#' Carlo standard errors; the figure of the pilot reports, as a function the
#' manuscript and the background report can call.
#'
#' @param summaries Output of [SummarizeCells()].
#' @param design The design table the summaries come from.
#' @param quantities Named character vector: names are quantities of
#'   `summaries`, values are legend labels.
#' @param cols Colors, one per quantity.
#' @param labels Row labels, one per cell; built from the design when `NULL`.
#' @return Invisibly, the matrix of means; called for the plot.
#' @export
PlotGains <- function(summaries, design, quantities,
                      cols = c("#B2182B", "#2166AC", "#E08214", "#1B7837",
                               "#762A83")[seq_along(quantities)],
                      labels = NULL) {
  get <- function(cl, q) summaries[summaries$cell == cl & summaries$quantity == q, ]
  stress <- if (is.null(design$stress)) "" else design$stress
  lab <- ifelse(design$mechanism == "null", sprintf("%d null", design$cell),
                sprintf("%d %s %s", design$cell, design$mechanism, design$level))
  lab <- paste0(lab, ifelse(stress == "", "", paste0(", ", stress)),
                sprintf(" (pi %.1f, n %d)", design$share, design$n1))
  if (!is.null(labels)) lab <- labels
  m <- sapply(names(quantities), function(q) sapply(design$cell, function(cl) get(cl, q)$mean))
  e <- sapply(names(quantities), function(q) sapply(design$cell, function(cl) get(cl, q)$mcse))
  m <- matrix(m, nrow = nrow(design))
  e <- matrix(e, nrow = nrow(design))
  ypos <- rev(seq_len(nrow(design)))
  old <- graphics::par(mar = c(4, 17, 1, 1))
  on.exit(graphics::par(old))
  graphics::plot(NA, xlim = range(c(m - 2 * e, m + 2 * e, 0), na.rm = TRUE),
                 ylim = c(0.5, nrow(design) + 0.5), yaxt = "n", ylab = "",
                 xlab = "Paired AUC difference (mean, 2 MCSE bars)")
  graphics::axis(2, at = ypos, labels = lab, las = 1, cex.axis = 0.72)
  graphics::abline(v = 0, col = "grey50")
  off <- seq(-0.32, 0.32, length.out = length(quantities))
  for (k in seq_along(quantities)) {
    y <- ypos + off[k]
    graphics::segments(m[, k] - 2 * e[, k], y, m[, k] + 2 * e[, k], y, col = cols[k])
    graphics::points(m[, k], y, pch = 19, col = cols[k], cex = 0.65)
  }
  graphics::legend("topright", legend = quantities, col = cols, pch = 19,
                   cex = 0.7, bg = "white")
  invisible(m)
}

#' Row labels for the settings of study S2
#'
#' @param d2 `StudyDesign()$s2`, or a subset of it.
#' @return One label per row: the family, the factor varied, and its level.
#' @export
S2Labels <- function(d2) {
  what <- ifelse(d2$varied == "IFN difference", paste("IFN", d2$level),
          ifelse(d2$varied == "module change", paste("module change", d2$level),
          ifelse(d2$varied == "size", paste("n", d2$n1),
          ifelse(d2$varied == "score genes", paste(d2$n_score, "score genes"),
          ifelse(d2$varied == "noise", paste(d2$noise, "noise"),
          ifelse(d2$varied == "share", paste("share", d2$share),
          ifelse(d2$varied == "mixing", paste("mixing", d2$alpha), "")))))))
  base <- ifelse(d2$study == "S2-A", "large IFN", "module 0.2")
  base[d2$varied %in% c("noise", "mixing")] <- ifelse(
    d2$study[d2$varied %in% c("noise", "mixing")] == "S2-A", "large IFN",
    "module 0.4")
  paste0(d2$study, ": ", what,
         ifelse(d2$varied %in% c("IFN difference", "module change"), "",
                paste0(" (", base, ")")))
}

#' Plot the rates of the two tests in the test settings
#'
#' For each test setting, the rate at which the superiority test of
#' `AUC(N1) - AUC(E1)` rejected and the rate at which equivalence of
#' `AUC(N1) - AUC(F1)` was declared, with bars of two binomial Monte Carlo
#' standard errors and a line at the 5% level.
#'
#' @param test_sum The test summaries written by `analysis/01_simulation.R`.
#' @param test_design `StudyDesign()$test`.
#' @return Invisibly, the rates; called for the plot.
#' @export
PlotTestRates <- function(test_sum, test_design) {
  d <- merge(test_design, test_sum, by = "cell")
  lab <- ifelse(d$mechanism == "network", paste("module change", d$level),
                paste("IFN", d$level))
  x <- seq_len(nrow(d))
  old <- graphics::par(mar = c(7, 4.2, 1, 1))
  on.exit(graphics::par(old))
  graphics::plot(NA, xlim = c(0.5, nrow(d) + 0.5), ylim = c(0, 1), xaxt = "n",
                 xlab = "", ylab = "Rate over replicates")
  graphics::axis(1, at = x, labels = lab, las = 2, cex.axis = 0.8)
  graphics::abline(h = 0.05, col = "grey50", lty = 2)
  pts <- list(list(v = d$reject_d1, e = d$reject_d1_mcse, col = "#2166AC", dx = -0.12),
              list(v = d$equiv_d2, e = d$equiv_d2_mcse, col = "#762A83", dx = 0.12))
  for (p in pts) {
    graphics::segments(x + p$dx, p$v - 2 * p$e, x + p$dx, p$v + 2 * p$e, col = p$col)
    graphics::points(x + p$dx, p$v, pch = 19, col = p$col)
  }
  graphics::legend("topleft", bg = "white", cex = 0.8, pch = 19,
                   col = c("#2166AC", "#762A83"),
                   legend = c("N1 over E1: superiority test rejected",
                              "N1 and F1: equivalence declared"))
  invisible(d[, c("cell", "reject_d1", "equiv_d2")])
}
