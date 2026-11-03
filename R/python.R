#' Simulate a two-group cohort with the Python twin of SimulateCohort()
#'
#' Calls `simulate_cohort()` from the compendium's Python package through
#' reticulate, in the project's uv-managed environment (`.venv/`, which
#' `.Rprofile` points reticulate at). This is a model for how a Python
#' function, including one that wraps a method whose only implementation is
#' Python, is reached from R: the Python side lives in `inst/python/` with its
#' own tests, and the R side is a thin wrapper whose test is skipped when the
#' environment is absent.
#'
#' @inheritParams SimulateCohort
#' @param seed Seed for Python's random number generator; `NULL` takes a fresh
#'   seed from the system.
#'
#' @return A data frame with the columns of [SimulateCohort()].
#'
#' @examples
#' \dontrun{
#' PySimulateCohort(n_ctrl = 20, n_pat = 80, shift = 2, seed = 1)
#' }
#'
#' @export
PySimulateCohort <- function(n_ctrl, n_pat, shift, rho = 0.5, seed = NULL) {
  if (!requireNamespace("reticulate", quietly = TRUE)) {
    stop("reticulate is needed; it is listed in Suggests")
  }
  py <- reticulate::import("projecttemplate.example")
  d <- py$simulate_cohort(as.integer(n_ctrl), as.integer(n_pat), shift, rho,
                          if (is.null(seed)) NULL else as.integer(seed))
  data.frame(group = factor(unlist(d$group), levels = c("control", "patient")),
             gene_a = unlist(d$gene_a), gene_b = unlist(d$gene_b))
}
