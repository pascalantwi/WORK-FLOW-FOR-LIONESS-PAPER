#' Leave-one-out correlations of every pair, exact form
#'
#' Row `q` holds the correlation of each gene pair without sample `q`:
#' `(r - a z_i z_j) / sqrt((1 - a z_i^2)(1 - a z_j^2))`, `a = 1/(N - 1)`.
#'
#' @param x Numeric matrix, samples in rows.
#' @return A matrix, one row per sample, one column per pair ([PairIndex()]).
#' @export
LooCorrelation <- function(x) {
  x <- as.matrix(x)
  n <- nrow(x)
  pairs <- PairIndex(ncol(x))
  z <- StandardizeN(x)$z
  r <- stats::cor(x)[pairs]
  a <- 1 / (n - 1)
  d <- 1 / sqrt(1 - a * z^2)
  r_mat <- matrix(r, nrow = n, ncol = length(r), byrow = TRUE)
  (r_mat - a * z[, pairs[, 1]] * z[, pairs[, 2]]) * d[, pairs[, 1]] * d[, pairs[, 2]]
}

#' Add-one correlations of every pair, exact form
#'
#' Row `q` holds the correlation of each gene pair after adding `x_new[q, ]`
#' to the reference: `(r + b z_i z_j) / sqrt((1 + b z_i^2)(1 + b z_j^2))`,
#' `b = 1/(N + 1)`, `z` standardized by the reference (divisor `N`).
#'
#' @param x_new New samples, in rows.
#' @param x_ref Reference samples, in rows.
#' @return A matrix, one row per new sample, one column per pair.
#' @export
AddOneCorrelation <- function(x_new, x_ref) {
  x_ref <- as.matrix(x_ref)
  n <- nrow(x_ref)
  pairs <- PairIndex(ncol(x_ref))
  s <- StandardizeN(x_ref)
  z <- StandardizeN(as.matrix(x_new), s$center, s$scale)$z
  r <- stats::cor(x_ref)[pairs]
  b <- 1 / (n + 1)
  d <- 1 / sqrt(1 + b * z^2)
  r_mat <- matrix(r, nrow = nrow(z), ncol = length(r), byrow = TRUE)
  (r_mat + b * z[, pairs[, 1]] * z[, pairs[, 2]]) * d[, pairs[, 1]] * d[, pairs[, 2]]
}

#' SSN edges (Liu et al. 2016), leave-one-out and add-one forms
#'
#' The change in correlation divided by its null standard deviation,
#' `(1 - r^2)/(n - 1)` with `n` the reference size. Training samples use the
#' other training samples as reference (the leave-one-out form of Kuijjer et
#' al. 2026); new samples use the training set.
#'
#' @param x Training samples, in rows.
#' @param x_new,x_ref New and reference samples for the add-one form.
#' @return A matrix, one row per sample, one column per pair.
#' @export
SsnEdges <- function(x) {
  x <- as.matrix(x)
  n <- nrow(x)
  r <- stats::cor(x)[PairIndex(ncol(x))]
  loo <- LooCorrelation(x)
  r_mat <- matrix(r, nrow = n, ncol = length(r), byrow = TRUE)
  (r_mat - loo) / ((1 - loo^2) / (n - 2))
}

#' @rdname SsnEdges
#' @export
SsnTestEdges <- function(x_new, x_ref) {
  x_ref <- as.matrix(x_ref)
  n <- nrow(x_ref)
  r <- stats::cor(x_ref)[PairIndex(ncol(x_ref))]
  add <- AddOneCorrelation(x_new, x_ref)
  r_mat <- matrix(r, nrow = nrow(add), ncol = length(r), byrow = TRUE)
  (add - r_mat) / ((1 - r_mat^2) / (n - 1))
}

#' iENA single-sample PCC (Yu et al. 2017)
#'
#' `(x_i - mu_i)(x_j - mu_j) / sqrt(V_i V_j)` with the reference mean and
#' variance (divisor `N`): the product of standardized deviations, without
#' the reference-correlation term of the first-order LIONESS edge.
#'
#' @param x_new Samples to score, in rows.
#' @param x_ref Reference samples, in rows.
#' @return A matrix, one row per sample, one column per pair.
#' @export
IenaEdges <- function(x_new, x_ref) {
  x_ref <- as.matrix(x_ref)
  pairs <- PairIndex(ncol(x_ref))
  s <- StandardizeN(x_ref)
  z <- StandardizeN(as.matrix(x_new), s$center, s$scale)$z
  z[, pairs[, 1], drop = FALSE] * z[, pairs[, 2], drop = FALSE]
}

#' SWEET sample weights (Chen et al. 2023, equation 1)
#'
#' `(mu_p - min(mu) + c) / (max(mu) - min(mu) + c)`, where `mu_p` is the mean
#' correlation, across genes, of sample `p` with the reference samples other
#' than itself, `mu` the reference samples' own values, and `c = 0.01`.
#'
#' @param x_ref Reference samples, in rows.
#' @param x_new Optional new samples; when `NULL` the weights of the reference
#'   samples are returned.
#' @param c The constant of equation 1.
#' @return A vector of weights.
#' @export
SweetWeights <- function(x_ref, x_new = NULL, c = 0.01) {
  x_ref <- as.matrix(x_ref)
  cc <- stats::cor(t(x_ref))
  diag(cc) <- NA
  mu_ref <- rowMeans(cc, na.rm = TRUE)
  mu <- if (is.null(x_new)) mu_ref else colMeans(stats::cor(t(x_ref), t(as.matrix(x_new))))
  (mu - min(mu_ref) + c) / (max(mu_ref) - min(mu_ref) + c)
}

#' SWEET edges (Chen et al. 2023, equation 2)
#'
#' `W_p n K (E(n + S_p) - E(n)) + E(n)`: the perturbed network adds a copy of
#' sample `p` to the `n` reference samples (for a training sample, which is
#' already among them) or the new sample itself; `K = 0.1`.
#'
#' @param x Training samples, in rows.
#' @param x_new,x_ref New and reference samples.
#' @param k The balance parameter `K`.
#' @return A matrix, one row per sample, one column per pair.
#' @export
SweetEdges <- function(x, k = 0.1) {
  SweetTestEdges(x, x, k = k, weights = SweetWeights(x))
}

#' @rdname SweetEdges
#' @param weights Sample weights; computed by [SweetWeights()] when `NULL`.
#' @export
SweetTestEdges <- function(x_new, x_ref, k = 0.1, weights = NULL) {
  x_ref <- as.matrix(x_ref)
  n <- nrow(x_ref)
  if (is.null(weights)) weights <- SweetWeights(x_ref, x_new)
  r <- stats::cor(x_ref)[PairIndex(ncol(x_ref))]
  add <- AddOneCorrelation(x_new, x_ref)
  r_mat <- matrix(r, nrow = nrow(add), ncol = length(r), byrow = TRUE)
  weights * n * k * (add - r_mat) + r_mat
}

#' BONOBO weight delta, as in netZooPy
#'
#' `1 / (3 + 2 mean(sqrt(diag S)) / var(diag S))`, with `var` the population
#' variance across genes (numpy's default), as `compute_bonobo()` of netZooPy
#' 0.11.0 computes it. Equation 8 of Saha et al. (2024) states a different
#' formula; the published code is followed (`log/03-manuscript.md`).
#'
#' @param s_diag Diagonal of the prior covariance matrix.
#' @return The weight.
#' @export
BonoboDelta <- function(s_diag) {
  v <- mean((s_diag - mean(s_diag))^2)
  1 / (3 + 2 * mean(sqrt(s_diag)) / v)
}

#' BONOBO edges (Saha et al. 2024), as netZooPy computes them
#'
#' For sample `i`, `Sigma_i = delta_i d_i d_i' + (1 - delta_i) S_i`, with
#' `d_i` the sample centered by the mean of all samples, `S_i` the covariance
#' (divisor `n - 1`) of the other samples, and `delta_i` from [BonoboDelta()];
#' the edge is the correlation of `Sigma_i`. New samples use the training set
#' as `S` and its mean as the center.
#'
#' @param x Training samples, in rows.
#' @param x_new,x_ref New and reference samples.
#' @return A matrix, one row per sample, one column per pair.
#' @export
BonoboEdges <- function(x) {
  x <- as.matrix(x)
  n <- nrow(x)
  pairs <- PairIndex(ncol(x))
  d <- sweep(x, 2, colMeans(x))
  cp <- crossprod(d)
  shrink <- n / (n - 1)
  out <- matrix(NA_real_, n, nrow(pairs))
  for (i in seq_len(n)) {
    s_i <- (cp - shrink * tcrossprod(d[i, ])) / (n - 2)
    delta <- BonoboDelta(diag(s_i))
    sig <- delta * tcrossprod(d[i, ]) + (1 - delta) * s_i
    sd <- sqrt(diag(sig))
    out[i, ] <- sig[pairs] / (sd[pairs[, 1]] * sd[pairs[, 2]])
  }
  out
}

#' @rdname BonoboEdges
#' @export
BonoboTestEdges <- function(x_new, x_ref) {
  x_ref <- as.matrix(x_ref)
  x_new <- as.matrix(x_new)
  pairs <- PairIndex(ncol(x_ref))
  s <- stats::cov(x_ref)
  delta <- BonoboDelta(diag(s))
  d <- sweep(x_new, 2, colMeans(x_ref))
  out <- matrix(NA_real_, nrow(x_new), nrow(pairs))
  for (i in seq_len(nrow(x_new))) {
    sig <- delta * tcrossprod(d[i, ]) + (1 - delta) * s
    sd <- sqrt(diag(sig))
    out[i, ] <- sig[pairs] / (sd[pairs[, 1]] * sd[pairs[, 2]])
  }
  out
}
