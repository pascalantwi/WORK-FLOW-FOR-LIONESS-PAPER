test_that("StudyDesign has the protocol's settings and disjoint seeds", {
  d <- StudyDesign()
  expect_equal(nrow(d$s1), 9)
  expect_equal(nrow(d$s2), 25)
  expect_equal(nrow(d$test), 7)
  expect_equal(sum(d$s2$study == "S2-A"), 11)
  expect_equal(d$s1$n1 + d$s1$n0, rep(400, 9))
  expect_equal(d$s2$n0[d$s2$share == 0.15], round(80 * 0.85 / 0.15))
  expect_true(all(d$test$s2_cell %in% d$s2$cell))
  # the study's replicate streams (seed + 1 to seed + 1000) overlap neither
  # each other nor any pilot's
  new <- c(d$s1$seed, d$s2$seed, d$test$seed)
  old <- c(PilotDesign()$seed, PilotBDesign()$seed, PilotCDesign()$seed)
  g_new <- abs(outer(new, new, "-"))
  expect_gte(min(g_new[upper.tri(g_new)]), 1000)
  expect_gte(min(abs(outer(new, old, "-"))), 1000)
})

test_that("the new IFN levels and t3 noise behave as stated", {
  set.seed(31)
  a <- SimulateCohort("null", "", 50, 50)
  set.seed(31)
  b <- SimulateCohort("ifn", "none", 50, 50)
  expect_identical(a, b)
  set.seed(32)
  v <- SimulateCohort("ifn", "very large", 4000, 4000)
  expect_equal(mean(v$f[v$y == 1]), 1.5, tolerance = 0.05)
  expect_equal(sd(v$f[v$y == 1]), 3, tolerance = 0.05)
  set.seed(33)
  t3 <- SimulateCohort("null", "", 4000, 4000, noise = "t3")
  e <- as.vector(t3$x[, 6:20] - 0.8 * t3$f)
  expect_lt(abs(var(e) - 1), 0.1)
  expect_error(SimulateCohort("ifn", "huge", 10, 10))
})

test_that("S1Replicate matches equation (3) on average", {
  d <- StudyDesign()$s1
  g <- sapply(1:30, function(r) S1Replicate(d[d$share == 0.3 & d$level == "1", ], r)$gap)
  expect_lt(abs(mean(g)), 4 * sd(g) / sqrt(30) + 0.02)
})

test_that("RunReplicate takes the mixing parameter and a ten-gene score", {
  d <- StudyDesign()$s2
  r <- d[d$varied == "mixing", ][1, ]
  r$n1 <- r$n0 <- 25
  out <- suppressWarnings(RunReplicate(r, 1, models = c("E1", "N1E1")))
  expect_true(all(out[, c("E1", "N1E1")] >= 0 & out[, c("E1", "N1E1")] <= 1))
  r10 <- d[d$n_score == 10, ]
  r10$n1 <- r10$n0 <- 25
  out10 <- suppressWarnings(RunReplicate(r10, 1, models = c("N1E1")))
  expect_true(out10$N1E1 >= 0 && out10$N1E1 <= 1)
})

test_that("TestReplicate returns the two decisions", {
  d <- StudyDesign()$test[1, ]
  d$n1 <- d$n0 <- 30
  out <- suppressWarnings(TestReplicate(d, 1, n_repeat = 1, k = 3))
  expect_type(out$reject_d1, "logical")
  expect_type(out$equiv_d2, "logical")
  expect_true(abs(out$d1) <= 1 && abs(out$d2) <= 1)
})

test_that("the elastic-net fallback gives finite predictions near cv.glmnet's", {
  set.seed(61)
  x <- matrix(rnorm(120 * 6), 120, 6)
  y <- rbinom(120, 1, plogis(x[, 1]))
  pf <- c(0, rep(1, 5))
  p <- ElasticNetFallback(x[1:90, ], y[1:90], x[91:120, ], pf)
  expect_length(p, 30)
  expect_true(all(is.finite(p)))
  q <- FitElasticNet(x[1:90, 1, drop = FALSE], x[1:90, -1], y[1:90],
                     x[91:120, 1, drop = FALSE], x[91:120, -1])
  expect_gt(cor(p, q), 0.9)
})

test_that("CommonSupport keeps the patients inside the other class's range", {
  set.seed(71)
  x <- matrix(rnorm(200 * 3), 200, 3, dimnames = list(NULL, c("a", "b", "c")))
  y <- rep(0:1, each = 100)
  x[y == 1, 1:2] <- x[y == 1, 1:2] + 1.5
  keep <- CommonSupport(list(x = x, y = y), c("a", "b"))
  s <- rowMeans(StandardizeN(x[, c("a", "b")])$z)
  q0 <- quantile(s[y == 0], c(0.05, 0.95))
  expect_equal(keep[y == 1], s[y == 1] >= q0[1] & s[y == 1] <= q0[2])
  expect_lt(mean(keep), 1)
  expect_gt(mean(keep), 0)
})
