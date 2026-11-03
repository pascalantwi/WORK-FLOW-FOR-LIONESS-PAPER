#' Index of the gene pairs of a network
#'
#' @param p Number of genes.
#' @return A two-column integer matrix with one row per pair `i < j`, in the
#'   order of the upper triangle taken row by row.
#' @export
PairIndex <- function(p) {
  idx <- which(upper.tri(diag(p)), arr.ind = TRUE)
  idx <- idx[order(idx[, "row"], idx[, "col"]), , drop = FALSE]
  unname(idx)
}

#' Standardize columns with the divisor N
#'
#' @param x Numeric matrix, samples in rows.
#' @param center,scale Optional vectors of means and standard deviations (divisor
#'   N) to standardize with; computed from `x` when `NULL`.
#' @return A list with `z`, `center`, and `scale`.
#' @export
StandardizeN <- function(x, center = NULL, scale = NULL) {
  x <- as.matrix(x)
  if (is.null(center)) center <- colMeans(x)
  if (is.null(scale)) {
    scale <- sqrt(colMeans(sweep(x, 2, center)^2))
  }
  z <- sweep(sweep(x, 2, center), 2, scale, "/")
  list(z = z, center = center, scale = scale)
}

#' LIONESS Pearson edges by literal leave-one-out
#'
#' The definition, `N r - (N - 1) r_(-q)`, computed by refitting the
#' correlation without each sample. Slow; used to test [LionessEdges()].
#'
#' @param x Numeric matrix, samples in rows, genes in columns.
#' @return A matrix with one row per sample and one column per gene pair, in
#'   the order of [PairIndex()].
#' @export
LionessEdgesDirect <- function(x) {
  x <- as.matrix(x)
  n <- nrow(x)
  pairs <- PairIndex(ncol(x))
  r <- stats::cor(x)[pairs]
  t(vapply(seq_len(n), function(q) {
    n * r - (n - 1) * stats::cor(x[-q, , drop = FALSE])[pairs]
  }, numeric(nrow(pairs))))
}

#' LIONESS Pearson edges by the exact closed form
#'
#' Removing one sample is a rank-one downdate of the moments, so the
#' leave-one-out correlation is
#' `(r - a z_i z_j) / sqrt((1 - a z_i^2)(1 - a z_j^2))` with `a = 1/(N - 1)`
#' and `z` standardized by all `N` samples (divisor `N`).
#'
#' @inheritParams LionessEdgesDirect
#' @return As [LionessEdgesDirect()].
#' @export
LionessEdges <- function(x) {
  x <- as.matrix(x)
  n <- nrow(x)
  pairs <- PairIndex(ncol(x))
  z <- StandardizeN(x)$z
  r <- stats::cor(x)[pairs]
  a <- 1 / (n - 1)
  d <- 1 / sqrt(1 - a * z^2)
  zi <- z[, pairs[, 1], drop = FALSE]
  zj <- z[, pairs[, 2], drop = FALSE]
  r_mat <- matrix(r, nrow = n, ncol = length(r), byrow = TRUE)
  r_loo <- (r_mat - a * zi * zj) * d[, pairs[, 1], drop = FALSE] *
    d[, pairs[, 2], drop = FALSE]
  n * r_mat - (n - 1) * r_loo
}

#' First-order LIONESS Pearson edges
#'
#' `r + z_i z_j - (r / 2)(z_i^2 + z_j^2)`: the reference correlation plus the
#' influence function of the correlation at the sample.
#'
#' @inheritParams LionessEdgesDirect
#' @return As [LionessEdgesDirect()].
#' @export
LionessEdgesFirstOrder <- function(x) {
  x <- as.matrix(x)
  pairs <- PairIndex(ncol(x))
  z <- StandardizeN(x)$z
  r <- stats::cor(x)[pairs]
  r_mat <- matrix(r, nrow = nrow(x), ncol = length(r), byrow = TRUE)
  zi <- z[, pairs[, 1], drop = FALSE]
  zj <- z[, pairs[, 2], drop = FALSE]
  r_mat + zi * zj - r_mat / 2 * (zi^2 + zj^2)
}

#' LIONESS edges of new samples against a reference set, literal
#'
#' For each new sample, `(N + 1) r(reference + sample) - N r(reference)`.
#'
#' @param x_new Numeric matrix of new samples.
#' @param x_ref Numeric matrix of reference samples, same genes.
#' @return A matrix with one row per new sample and one column per gene pair.
#' @export
LionessTestEdgesDirect <- function(x_new, x_ref) {
  x_new <- as.matrix(x_new)
  x_ref <- as.matrix(x_ref)
  n <- nrow(x_ref)
  pairs <- PairIndex(ncol(x_ref))
  r <- stats::cor(x_ref)[pairs]
  t(vapply(seq_len(nrow(x_new)), function(q) {
    (n + 1) * stats::cor(rbind(x_ref, x_new[q, ]))[pairs] - n * r
  }, numeric(nrow(pairs))))
}

#' LIONESS edges of new samples against a reference set, exact form
#'
#' Adding a sample is the update the leave-one-out downdate reverses:
#' `r_(+q) = (r + b z_i z_j) / sqrt((1 + b z_i^2)(1 + b z_j^2))` with
#' `b = 1/(N + 1)` and `z` standardized by the reference (divisor `N`). Only
#' the reference moments are used, so the reference never holds the sample.
#'
#' @inheritParams LionessTestEdgesDirect
#' @return As [LionessTestEdgesDirect()].
#' @export
LionessTestEdges <- function(x_new, x_ref) {
  x_new <- as.matrix(x_new)
  x_ref <- as.matrix(x_ref)
  n <- nrow(x_ref)
  pairs <- PairIndex(ncol(x_ref))
  s <- StandardizeN(x_ref)
  z <- StandardizeN(x_new, s$center, s$scale)$z
  r <- stats::cor(x_ref)[pairs]
  b <- 1 / (n + 1)
  d <- 1 / sqrt(1 + b * z^2)
  zi <- z[, pairs[, 1], drop = FALSE]
  zj <- z[, pairs[, 2], drop = FALSE]
  r_mat <- matrix(r, nrow = nrow(z), ncol = length(r), byrow = TRUE)
  r_add <- (r_mat + b * zi * zj) * d[, pairs[, 1], drop = FALSE] *
    d[, pairs[, 2], drop = FALSE]
  (n + 1) * r_add - n * r_mat
}

#' Predicted class difference in mean LIONESS edge under a mean shift
#'
#' Proposal equation (3) with equal within-class covariances:
#' `(1 - 2 pi) [d_i d_j - (r / 2)(d_i^2 + d_j^2)]`, where `d` is the class
#' difference in means in units of the pooled standard deviation and `pi` the
#' share of class 1.
#'
#' @param x Numeric matrix, samples in rows.
#' @param y Class labels, 0 or 1.
#' @return A vector with one value per gene pair: predicted mean edge in class
#'   1 minus class 0.
#' @export
MeanShiftEdgeDifference <- function(x, y) {
  x <- as.matrix(x)
  pairs <- PairIndex(ncol(x))
  s <- StandardizeN(x)
  d <- (colMeans(x[y == 1, , drop = FALSE]) -
          colMeans(x[y == 0, , drop = FALSE])) / s$scale
  r <- stats::cor(x)[pairs]
  share <- mean(y == 1)
  di <- d[pairs[, 1]]
  dj <- d[pairs[, 2]]
  (1 - 2 * share) * (di * dj - r / 2 * (di^2 + dj^2))
}
