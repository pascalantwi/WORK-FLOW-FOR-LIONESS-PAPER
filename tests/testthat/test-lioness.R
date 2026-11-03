test_that("PairIndex lists each pair once in row order", {
  expect_equal(PairIndex(3), matrix(c(1, 1, 2, 2, 3, 3), ncol = 2))
  expect_equal(nrow(PairIndex(45)), 990)
})

test_that("StandardizeN uses the divisor N", {
  x <- matrix(c(1, 2, 3, 4), ncol = 1)
  z <- StandardizeN(x)$z
  expect_equal(mean(z), 0)
  expect_equal(mean(z^2), 1)
})

test_that("the exact closed form equals literal LIONESS", {
  set.seed(2)
  x <- matrix(rnorm(30 * 5), 30, 5)
  x[3, ] <- x[3, ] * 5
  expect_equal(LionessEdges(x), LionessEdgesDirect(x), tolerance = 1e-8)
})

test_that("the add-one form equals the literal add-one LIONESS edge", {
  set.seed(3)
  ref <- matrix(rnorm(40 * 4), 40, 4)
  new <- matrix(rnorm(3 * 4), 3, 4)
  expect_equal(LionessTestEdges(new, ref), LionessTestEdgesDirect(new, ref),
               tolerance = 1e-8)
})

test_that("the first-order form is close to the exact edge at large N", {
  set.seed(4)
  x <- matrix(rnorm(3000 * 3), 3000, 3)
  expect_lt(max(abs(LionessEdgesFirstOrder(x) - LionessEdges(x))), 0.05)
})

test_that("edges average to about the reference correlation", {
  set.seed(5)
  x <- matrix(rnorm(500 * 2), 500, 2) %*% chol(matrix(c(1, .6, .6, 1), 2))
  expect_equal(mean(LionessEdges(x)), cor(x)[1, 2], tolerance = 0.02)
})

test_that("the mean-shift prediction is zero for balanced classes", {
  set.seed(6)
  x <- matrix(rnorm(100 * 3), 100, 3)
  y <- rep(0:1, each = 50)
  x[y == 1, ] <- x[y == 1, ] + 0.7
  expect_equal(MeanShiftEdgeDifference(x, y), rep(0, 3))
})
