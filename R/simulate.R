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
#' @param level For `"ifn"`, `"none"`, `"small"`, `"moderate"`, `"large"`, or
#'   `"very large"` (shift and SD ratio of `f` in class 1: 0 and 1, 0.25 and
#'   1.25, 0.5 and 1.5, 1 and 2.25, 1.5 and 3); for `"shift"`, the
#'   mean shift; for `"network"`, the correlation change; ignored for null.
#' @param n1,n0 Sizes of class 1 and class 0.
#' @param p Number of genes (50 in the pilot).
#' @param noise `"normal"`, or `"t5"` or `"t3"` for noise drawn from a t
#'   distribution with 5 or 3 degrees of freedom scaled to unit variance
#'   (before the module's correlation is applied).
#' @return A list with `x` (samples by genes), `y` (0 or 1), `age`, `sex`,
#'   `comp`, and `f`.
#' @export
SimulateCohort <- function(mechanism, level, n1, n0, p = 50,
                           noise = c("normal", "t5", "t3")) {
  noise <- match.arg(noise)
  stopifnot(p >= 50)
  n <- n1 + n0
  y <- c(rep(1L, n1), rep(0L, n0))
  f <- stats::rnorm(n)
  if (mechanism == "ifn") {
    sk <- switch(level, none = c(0, 1), small = c(0.25, 1.25),
                 moderate = c(0.5, 1.5), large = c(1, 2.25),
                 `very large` = c(1.5, 3))
    stopifnot(!is.null(sk))
    f[y == 1] <- sk[1] + sk[2] * f[y == 1]
  }
  comp <- stats::rnorm(n)
  load_f <- c(rep(0.8, 20), rep(0, p - 20))
  load_c <- c(rep(0, 30), rep(0.4, 20), rep(0, p - 50))
  module <- 21:30
  eps <- switch(noise,
    normal = matrix(stats::rnorm(n * p), n, p),
    t5 = matrix(stats::rt(n * p, df = 5) / sqrt(5 / 3), n, p),
    t3 = matrix(stats::rt(n * p, df = 3) / sqrt(3), n, p))
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

#' The third pilot's design table
#'
#' The 9 cells of `pilot-c/preregistration.md`, section 3, with the seed and
#' the noise distribution of each cell. Seeds are `20361103 + 1000c`, so that
#' no replicate stream overlaps those of [PilotDesign()] or [PilotBDesign()].
#'
#' @return A data frame as [PilotBDesign()].
#' @export
PilotCDesign <- function() {
  d <- data.frame(
    cell = 1:9,
    mechanism = c("null", "ifn", "ifn", "ifn", "shift", rep("network", 4)),
    level = c("", "large", "moderate", "large", "0.5", "0.4", "0.4", "0.2",
              "0.4"),
    stress = c("", "", "", "t5 noise", "", "", "", "", "t5 noise"),
    share = c(0.5, 0.5, 0.5, 0.5, 0.3, 0.5, 0.5, 0.5, 0.5),
    n1 = c(80, 80, 80, 80, 80, 80, 40, 80, 80),
    stringsAsFactors = FALSE
  )
  d$n0 <- round(d$n1 * (1 - d$share) / d$share)
  d$seed <- 20361103L + 1000L * d$cell
  d$noise <- ifelse(d$stress == "t5 noise", "t5", "normal")
  d$n_score <- 5L
  d
}

#' The design of the full simulation study (protocol.md)
#'
#' S1, the unequal-groups law: nine settings of the share of the smaller class
#' and the mean shift, with the total size held at 400. S2: 25 settings, one
#' factor varied at a time around two base settings (S2-A, the interferon
#' artifact; S2-B, equivalence, parametrization, and power). The seven test
#' settings rerun the S2-B settings with a module change and the large and very
#' large IFN settings through the real-data test procedure ([TestReplicate()]).
#'
#' @return A list of three data frames, `s1`, `s2`, and `test`, each with a
#'   `cell` identifier and a `seed`.
#' @export
StudyDesign <- function() {
  s1 <- expand.grid(share = c(0.5, 0.3, 0.15), level = c("0.25", "0.5", "1"),
                    stringsAsFactors = FALSE)
  s1$cell <- seq_len(nrow(s1))
  s1$mechanism <- "shift"
  s1$n1 <- round(400 * s1$share)
  s1$n0 <- 400 - s1$n1
  s1$seed <- 20461103L + 1000L * s1$cell
  row <- function(study, mechanism, level, n1 = 80, share = 0.5, noise = "normal",
                  n_score = 5L, alpha = 0.5, varied = "base") {
    data.frame(study = study, mechanism = mechanism, level = level, n1 = n1,
               share = share, noise = noise, n_score = n_score, alpha = alpha,
               varied = varied, stringsAsFactors = FALSE)
  }
  a <- rbind(
    do.call(rbind, lapply(c("none", "small", "moderate", "large", "very large"),
                          function(l) row("S2-A", "ifn", l, varied = "IFN difference"))),
    row("S2-A", "ifn", "large", n_score = 2L, varied = "score genes"),
    row("S2-A", "ifn", "large", n_score = 10L, varied = "score genes"),
    row("S2-A", "ifn", "large", noise = "t5", varied = "noise"),
    do.call(rbind, lapply(c(40, 150, 300), function(n)
      row("S2-A", "ifn", "large", n1 = n, varied = "size"))))
  b <- rbind(
    do.call(rbind, lapply(c("0", "0.1", "0.2", "0.3", "0.4"), function(l)
      row("S2-B", "network", l, varied = "module change"))),
    do.call(rbind, lapply(c(40, 150, 300), function(n)
      row("S2-B", "network", "0.2", n1 = n, varied = "size"))),
    row("S2-B", "network", "0.2", share = 0.3, varied = "share"),
    row("S2-B", "network", "0.2", share = 0.15, varied = "share"),
    row("S2-B", "network", "0.4", noise = "t5", varied = "noise"),
    row("S2-B", "network", "0.4", noise = "t3", varied = "noise"),
    row("S2-B", "network", "0.4", alpha = 0, varied = "mixing"),
    row("S2-B", "network", "0.4", alpha = 1, varied = "mixing"))
  s2 <- rbind(a, b)
  s2$cell <- seq_len(nrow(s2))
  s2$n0 <- round(s2$n1 * (1 - s2$share) / s2$share)
  s2$seed <- 20561103L + 1000L * s2$cell
  test <- s2[(s2$study == "S2-B" & s2$varied == "module change") |
               (s2$study == "S2-A" & s2$varied == "IFN difference" &
                  s2$level %in% c("large", "very large")), ]
  test$s2_cell <- test$cell
  test$cell <- seq_len(nrow(test))
  test$seed <- 20661103L + 1000L * test$cell
  rownames(test) <- NULL
  list(s1 = s1, s2 = s2, test = test)
}

#' One replicate of the unequal-groups law (S1)
#'
#' Simulates a mean-shift cohort and compares the class difference in mean
#' LIONESS edge over the module pairs with proposal equation (3).
#'
#' @param design_row One row of `StudyDesign()$s1`.
#' @param rep Replicate index; the seed is the cell seed plus `rep`.
#' @return A one-row data frame: `cell`, `rep`, `observed`, `predicted`, `gap`.
#' @export
S1Replicate <- function(design_row, rep) {
  set.seed(design_row$seed + rep)
  coh <- SimulateCohort("shift", design_row$level, design_row$n1,
                        design_row$n0)
  g <- coh$x[, 21:30]
  e <- LionessEdges(g)
  observed <- colMeans(e[coh$y == 1, , drop = FALSE]) -
    colMeans(e[coh$y == 0, , drop = FALSE])
  predicted <- MeanShiftEdgeDifference(g, coh$y)
  data.frame(cell = design_row$cell, rep = rep, observed = mean(observed),
             predicted = mean(predicted), gap = mean(observed - predicted))
}
