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
#' @return Invisibly, the matrix of means; called for the plot.
#' @export
PlotGains <- function(summaries, design, quantities,
                      cols = c("#B2182B", "#2166AC", "#E08214", "#1B7837",
                               "#762A83")[seq_along(quantities)]) {
  get <- function(cl, q) summaries[summaries$cell == cl & summaries$quantity == q, ]
  stress <- if (is.null(design$stress)) "" else design$stress
  lab <- ifelse(design$mechanism == "null", sprintf("%d null", design$cell),
                sprintf("%d %s %s", design$cell, design$mechanism, design$level))
  lab <- paste0(lab, ifelse(stress == "", "", paste0(", ", stress)),
                sprintf(" (pi %.1f, n %d)", design$share, design$n1))
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
