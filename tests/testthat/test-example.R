test_that("SimulateCohort matches the closed-form pooled correlation", {
  # Derivation: with control fraction p, the pooled correlation of two genes
  # shifted by `shift` in the patients is
  #   (rho + p (1 - p) shift^2) / (1 + p (1 - p) shift^2).
  # A derivation is not trusted until a simulation agrees with it.
  set.seed(1)
  rho <- 0.5
  shift <- 2
  p_ctrl <- 0.2
  n <- 2e5
  d <- SimulateCohort(n * p_ctrl, n * (1 - p_ctrl), shift, rho)

  between <- p_ctrl * (1 - p_ctrl) * shift^2
  expect_equal(cor(d$gene_a, d$gene_b), (rho + between) / (1 + between),
               tolerance = 0.01)

  # Within a group the correlation is rho, not the pooled value.
  ctrl <- d[d$group == "control", ]
  expect_equal(cor(ctrl$gene_a, ctrl$gene_b), rho, tolerance = 0.03)
  expect_equal(nrow(d), n)
})
