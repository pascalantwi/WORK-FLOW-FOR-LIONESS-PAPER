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
#' @param noise `"normal"`, or `"t5"` for noise drawn from a t distribution
#'   with 5 degrees of freedom scaled to unit variance (before the module's
#'   correlation is applied).
#' @return A list with `x` (samples by genes), `y` (0 or 1), `age`, `sex`,
#'   `comp`, and `f`.
#' @export
SimulateCohort <- function(mechanism, level, n1, n0, p = 50,
                           noise = c("normal", "t5")) {
  noise <- match.arg(noise)
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
  eps <- if (noise == "normal") {
    matrix(stats::rnorm(n * p), n, p)
  } else {
    matrix(stats::rt(n * p, df = 5) / sqrt(5 / 3), n, p)
  }
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

#' The re-pilot's design table
#'
#' The 12 cells of `pilot-b/preregistration.md`, section 3, with the seed,
#' the noise distribution, and the number of score genes of each cell.
#'
#' @return A data frame as [PilotDesign()], plus `stress`, `noise`, and
#'   `n_score`.
#' @export
PilotBDesign <- function() {
  d <- data.frame(
    cell = 1:12,
    mechanism = c("null", "ifn", "ifn", "ifn", "ifn", "shift", rep("network", 6)),
    level = c("", "large", "moderate", "large", "large", "0.5", "0.4", "0.4",
              "0.2", "0.4", "0.4", "0.2"),
    stress = c("", "", "", "two-gene score", "t5 noise", "", "", "", "",
               "t5 noise", "", ""),
    share = c(rep(0.5, 5), 0.3, 0.5, 0.5, 0.5, 0.5, 0.3, 0.5),
    n1 = c(80, 80, 80, 80, 80, 80, 80, 40, 150, 80, 80, 80),
    stringsAsFactors = FALSE
  )
  d$n0 <- round(d$n1 * (1 - d$share) / d$share)
  # amended before the run: 2000c alone collided with the first pilot's 1000c
  d$seed <- 20261103L + 2000L * d$cell + 500L
  d$noise <- ifelse(d$stress == "t5 noise", "t5", "normal")
  d$n_score <- ifelse(d$stress == "two-gene score", 2L, 5L)
  d
}
