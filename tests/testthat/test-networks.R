test_that("LooCorrelation and AddOneCorrelation equal the literal correlations", {
  set.seed(41)
  x <- matrix(rnorm(25 * 4), 25, 4)
  pairs <- PairIndex(4)
  loo <- t(sapply(1:25, function(q) cor(x[-q, ])[pairs]))
  expect_equal(LooCorrelation(x), loo, tolerance = 1e-10)
  new <- matrix(rnorm(3 * 4), 3, 4)
  add <- t(sapply(1:3, function(q) cor(rbind(x, new[q, ]))[pairs]))
  expect_equal(AddOneCorrelation(new, x), add, tolerance = 1e-10)
})

test_that("SSN edges follow their definition", {
  set.seed(42)
  x <- matrix(rnorm(20 * 3), 20, 3)
  pairs <- PairIndex(3)
  r <- cor(x)[pairs]
  lit <- t(sapply(1:20, function(q) {
    rq <- cor(x[-q, ])[pairs]
    (r - rq) / ((1 - rq^2) / 18)
  }))
  expect_equal(SsnEdges(x), lit, tolerance = 1e-10)
  new <- matrix(rnorm(2 * 3), 2, 3)
  lit_new <- t(sapply(1:2, function(q) (cor(rbind(x, new[q, ]))[pairs] - r) / ((1 - r^2) / 19)))
  expect_equal(SsnTestEdges(new, x), lit_new, tolerance = 1e-10)
})

test_that("iENA edges are products of standardized deviations", {
  set.seed(43)
  x <- matrix(rnorm(15 * 3), 15, 3)
  z <- StandardizeN(x)$z
  expect_equal(IenaEdges(x, x), cbind(z[, 1] * z[, 2], z[, 1] * z[, 3], z[, 2] * z[, 3]))
})

test_that("SWEET edges equal the definition with a duplicated sample", {
  set.seed(44)
  x <- matrix(rnorm(18 * 5), 18, 5)
  pairs <- PairIndex(5)
  cc <- cor(t(x)); diag(cc) <- NA
  mu <- rowMeans(cc, na.rm = TRUE)
  w <- (mu - min(mu) + 0.01) / (max(mu) - min(mu) + 0.01)
  expect_equal(SweetWeights(x), w)
  r <- cor(x)[pairs]
  lit <- t(sapply(1:18, function(p) {
    w[p] * 18 * 0.1 * (cor(rbind(x, x[p, ]))[pairs] - r) + r
  }))
  expect_equal(SweetEdges(x), lit, tolerance = 1e-10)
})

test_that("BONOBO edges equal netZooPy 0.11.0 and the literal definition", {
  # fixtures/bonobo_netzoopy.csv: compute_bonobo() of netZooPy 0.11.0 on
  # fixtures/bonobo_input.csv, every sample, double precision (log/03-manuscript.md)
  x <- as.matrix(read.csv(test_path("fixtures", "bonobo_input.csv")))
  ref <- as.matrix(read.csv(test_path("fixtures", "bonobo_netzoopy.csv")))
  e <- BonoboEdges(x)
  expect_equal(unname(e), unname(ref[, -1]), tolerance = 1e-8)
  i <- 2
  s <- cov(x[-i, ])
  delta <- BonoboDelta(diag(s))
  expect_equal(delta, unname(ref[i, "delta"]), tolerance = 1e-10)
  d <- x[i, ] - colMeans(x)
  sig <- delta * outer(d, d) + (1 - delta) * s
  expect_equal(e[i, ], cov2cor(sig)[PairIndex(6)], tolerance = 1e-10)
})

test_that("test-sample forms use the reference only", {
  set.seed(45)
  ref <- matrix(rnorm(30 * 4), 30, 4)
  new <- matrix(rnorm(2 * 4), 2, 4)
  s <- cov(ref)
  delta <- BonoboDelta(diag(s))
  d <- new[1, ] - colMeans(ref)
  expect_equal(BonoboTestEdges(new, ref)[1, ],
               cov2cor(delta * outer(d, d) + (1 - delta) * s)[PairIndex(4)], tolerance = 1e-10)
  w <- SweetWeights(ref, new)
  expect_length(w, 2)
  expect_equal(SweetTestEdges(new, ref)[2, ],
               w[2] * 30 * 0.1 * (cor(rbind(ref, new[2, ]))[PairIndex(4)] - cor(ref)[PairIndex(4)]) +
                 cor(ref)[PairIndex(4)], tolerance = 1e-10)
})
