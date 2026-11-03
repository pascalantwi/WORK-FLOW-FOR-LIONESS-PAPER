test_that("the Python twin matches the closed-form pooled correlation", {
  # The test needs the project's Python environment. It is skipped, not
  # failed, when .venv/ is absent (run `uv sync` to create it).
  py <- Sys.getenv("RETICULATE_PYTHON")
  skip_if_not(nzchar(py) && file.exists(py),
              "no uv environment (.venv/) for this project; run uv sync")
  skip_if_not_installed("reticulate")
  skip_if_not(reticulate::py_module_available("projecttemplate"),
              "projecttemplate is not installed in .venv/; run uv sync")

  rho <- 0.5
  shift <- 2
  p_ctrl <- 0.2
  n <- 2e5
  d <- PySimulateCohort(n * p_ctrl, n * (1 - p_ctrl), shift, rho, seed = 1)

  between <- p_ctrl * (1 - p_ctrl) * shift^2
  expect_equal(cor(d$gene_a, d$gene_b), (rho + between) / (1 + between),
               tolerance = 0.01)
  expect_equal(nrow(d), n)
  expect_equal(levels(d$group), c("control", "patient"))
})
