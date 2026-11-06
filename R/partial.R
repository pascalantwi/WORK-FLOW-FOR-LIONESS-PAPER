#' Partial correlations of every gene pair given a conditioning set
#'
#' The correlation of the residuals of each gene on an intercept and the
#' conditioning variables, fitted by least squares within the samples given.
#'
#' @param x Numeric matrix, samples in rows, genes in columns.
#' @param cond Conditioning variables, samples in rows, or `NULL` for none
#'   (the intercept only, which gives the Pearson correlation).
#' @return A vector, one value per pair ([PairIndex()]).
#' @export
PartialCorrelationPairs <- function(x, cond = NULL) {
  x <- as.matrix(x)
  d <- if (is.null(cond)) matrix(1, nrow(x), 1) else cbind(1, as.matrix(cond))
  res <- qr.resid(qr(d), x)
  stats::cor(res)[PairIndex(ncol(x))]
}

#' LIONESS edges of the partial correlation given a conditioning set
#'
#' For each sample `q` of the reference, `N rho - (N - 1) rho_(-q)`, where
#' `rho` is the partial correlation of each gene pair given `cond` in all `N`
#' samples and `rho_(-q)` the same without sample `q`, both computed directly
#' ([PartialCorrelationPairs()]). New samples are scored by the add-one form
#' `(N + 1) rho_(+q) - N rho` against the reference.
#'
#' @param x Reference samples, in rows.
#' @param cond Conditioning variables of the reference samples, or `NULL`.
#' @param x_new,cond_new New samples and their conditioning variables.
#' @param x_ref,cond_ref Reference samples and their conditioning variables.
#' @return A matrix, one row per sample, one column per pair.
#' @export
LionessPartialEdges <- function(x, cond = NULL) {
  x <- as.matrix(x)
  if (!is.null(cond)) cond <- as.matrix(cond)
  n <- nrow(x)
  rho <- PartialCorrelationPairs(x, cond)
  out <- matrix(NA_real_, n, length(rho))
  for (q in seq_len(n)) {
    cq <- if (is.null(cond)) NULL else cond[-q, , drop = FALSE]
    out[q, ] <- n * rho - (n - 1) *
      PartialCorrelationPairs(x[-q, , drop = FALSE], cq)
  }
  out
}

#' @rdname LionessPartialEdges
#' @export
LionessPartialTestEdges <- function(x_new, cond_new, x_ref, cond_ref) {
  x_new <- as.matrix(x_new)
  x_ref <- as.matrix(x_ref)
  has_cond <- !is.null(cond_ref)
  if (has_cond) {
    cond_new <- as.matrix(cond_new)
    cond_ref <- as.matrix(cond_ref)
  }
  n <- nrow(x_ref)
  rho <- PartialCorrelationPairs(x_ref, if (has_cond) cond_ref else NULL)
  out <- matrix(NA_real_, nrow(x_new), length(rho))
  for (q in seq_len(nrow(x_new))) {
    cq <- if (has_cond) rbind(cond_ref, cond_new[q, , drop = FALSE]) else NULL
    out[q, ] <- (n + 1) *
      PartialCorrelationPairs(rbind(x_ref, x_new[q, , drop = FALSE]), cq) -
      n * rho
  }
  out
}
