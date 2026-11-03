#' Simulate a two-group cohort with two correlated genes
#'
#' Generates expression for two genes in a control group and a patient group.
#' Within each group the genes are standard normal with correlation `rho`. The
#' patients are shifted by `shift` standard deviations in both genes. This is
#' the data-generating mechanism for the example analysis, and a model for how
#' a function in `R/` is documented and tested.
#'
#' @param n_ctrl Number of control samples.
#' @param n_pat Number of patient samples.
#' @param shift Mean shift for patients, in within-group standard deviations.
#' @param rho Within-group correlation between the two genes.
#'
#' @return A data frame with one row per sample and columns `group` (a factor
#'   with levels `control` and `patient`), `gene_a`, and `gene_b`.
#'
#' @examples
#' set.seed(1)
#' d <- SimulateCohort(n_ctrl = 20, n_pat = 80, shift = 2, rho = 0.5)
#' tapply(d$gene_a, d$group, mean)
#'
#' @importFrom stats rnorm
#' @export
SimulateCohort <- function(n_ctrl, n_pat, shift, rho = 0.5) {
  # Assumes bivariate normal genes with equal within-group variances.
  stopifnot(n_ctrl >= 1, n_pat >= 1, abs(rho) < 1)
  group <- factor(rep(c("control", "patient"), c(n_ctrl, n_pat)))
  n <- n_ctrl + n_pat
  z1 <- rnorm(n)
  z2 <- rho * z1 + sqrt(1 - rho^2) * rnorm(n)
  is_patient <- group == "patient"
  data.frame(group = group,
             gene_a = z1 + shift * is_patient,
             gene_b = z2 + shift * is_patient)
}
