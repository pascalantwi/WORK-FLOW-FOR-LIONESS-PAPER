#' The pilot's design table
#'
#' The 16 cells of `pilot/preregistration.md`, section 3, with the seed of
#' each cell.
#'
#' @return A data frame with one row per cell: `cell`, `mechanism`, `level`,
#'   `share` (of class 1), `n1` (size of class 1), `n0`, and `seed`.
#' @export
PilotDesign <- function() {
  d <- data.frame(
    cell = 1:16,
    mechanism = c("null", "null", rep("ifn", 5), rep("shift", 3),
                  rep("network", 6)),
    level = c("", "", "moderate", "large", "moderate", "moderate",
              "moderate", "0.5", "0.5", "0.5", "0.1", "0.2", "0.4", "0.2",
              "0.2", "0.2"),
    share = c(0.5, 0.3, 0.5, 0.5, 0.5, 0.5, 0.3, 0.5, 0.3, 0.3, 0.5, 0.5,
              0.5, 0.5, 0.5, 0.3),
    n1 = c(80, 80, 80, 80, 40, 150, 80, 80, 80, 40, 80, 80, 80, 40, 150, 80),
    stringsAsFactors = FALSE
  )
  d$n0 <- round(d$n1 * (1 - d$share) / d$share)
  d$seed <- 20261103L + 1000L * d$cell
  d
}

#' Simulate one cohort for a pilot cell
#'
#' Genes 1 to 20 load 0.8 on the IFN factor `f`, genes 31 to 50 load 0.4 on
#' composition `comp`, and genes 21 to 30 form a module whose noise
#' correlation is 0.3 (plus the cell's change in class 1 for the network
#' mechanism). Class 1 differs from class 0 only as the mechanism states.
#'
#' @param mechanism One of `"null"`, `"ifn"`, `"shift"`, `"network"`.
#' @param level For `"ifn"`, `"moderate"` or `"large"`; for `"shift"`, the
#'   mean shift; for `"network"`, the correlation change; ignored for null.
#' @param n1,n0 Sizes of class 1 and class 0.
#' @param p Number of genes (50 in the pilot).
#' @return A list with `x` (samples by genes), `y` (0 or 1), `age`, `sex`,
#'   `comp`, and `f`.
#' @export
SimulateCohort <- function(mechanism, level, n1, n0, p = 50) {
  stopifnot(p >= 50)
  n <- n1 + n0
  y <- c(rep(1L, n1), rep(0L, n0))
  f <- stats::rnorm(n)
  if (mechanism == "ifn") {
    sk <- switch(level, moderate = c(0.5, 1.5), large = c(1, 2.25))
    f[y == 1] <- sk[1] + sk[2] * f[y == 1]
  }
  comp <- stats::rnorm(n)
  load_f <- c(rep(0.8, 20), rep(0, p - 20))
  load_c <- c(rep(0, 30), rep(0.4, 20), rep(0, p - 50))
  module <- 21:30
  eps <- matrix(stats::rnorm(n * p), n, p)
  rho <- c(`0` = 0.3, `1` = 0.3)
  if (mechanism == "network") rho["1"] <- 0.3 + as.numeric(level)
  for (cl in c(0L, 1L)) {
    rows <- which(y == cl)
    r <- rho[as.character(cl)]
    sigma <- matrix(r, length(module), length(module))
    diag(sigma) <- 1
    eps[rows, module] <- eps[rows, module] %*% chol(sigma)
  }
  if (mechanism == "shift") {
    eps[y == 1, module] <- eps[y == 1, module] + as.numeric(level)
  }
  x <- outer(f, load_f) + outer(comp, load_c) + eps
  colnames(x) <- paste0("g", seq_len(p))
  list(x = x, y = y, age = stats::rnorm(n), sex = stats::rbinom(n, 1, 0.5),
       comp = comp, f = f)
}
