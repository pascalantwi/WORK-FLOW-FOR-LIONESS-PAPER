test_that("Auc matches its definition", {
  expect_equal(Auc(1:10, rep(0:1, each = 5)), 1)
  expect_equal(Auc(10:1, rep(0:1, each = 5)), 0)
  expect_equal(Auc(rep(1, 6), c(0, 0, 0, 1, 1, 1)), 0.5)
  s <- c(0.1, 0.4, 0.35, 0.8)
  y <- c(0, 0, 1, 1)
  expect_equal(Auc(s, y), mean(outer(s[y == 1], s[y == 0], ">")))
})

test_that("StratifiedFolds balances each class", {
  set.seed(1)
  y <- rep(0:1, c(37, 13))
  f <- StratifiedFolds(y, 5)
  expect_true(all(table(f, y)[, "1"] %in% 2:3))
  expect_setequal(unique(f), 1:5)
})

test_that("PilotDesign has the 16 pre-registered cells", {
  d <- PilotDesign()
  expect_equal(nrow(d), 16)
  expect_equal(d$n0[d$cell == 7], round(80 * 0.7 / 0.3))
  expect_equal(unique(d$seed - 1000L * d$cell), 20261103L)
})

test_that("SimulateCohort follows the mechanism", {
  set.seed(7)
  d <- SimulateCohort("ifn", "moderate", 3000, 3000)
  expect_equal(sd(d$f[d$y == 1]), 1.5, tolerance = 0.05)
  expect_equal(mean(d$f[d$y == 1]), 0.5, tolerance = 0.06)
  n <- SimulateCohort("network", "0.4", 3000, 3000)
  r1 <- cor(n$x[n$y == 1, 21:30])
  r0 <- cor(n$x[n$y == 0, 21:30])
  # absolute tolerance: the standard error of each mean is about 0.01
  expect_lt(abs(mean(r1[upper.tri(r1)]) - 0.7), 0.04)
  expect_lt(abs(mean(r0[upper.tri(r0)]) - 0.3), 0.04)
  s <- SimulateCohort("shift", "0.5", 3000, 3000)
  expect_equal(mean(colMeans(s$x[s$y == 1, 21:30]) -
                      colMeans(s$x[s$y == 0, 21:30])), 0.5, tolerance = 0.05)
})

test_that("PilotFeatures never uses test samples in the reference", {
  set.seed(8)
  d <- SimulateCohort("null", "", 30, 30)
  tr <- rep(c(TRUE, FALSE), 30)
  a <- PilotFeatures(d, tr)
  d2 <- d
  d2$x[!tr, ] <- d2$x[!tr, ] + 100
  b <- PilotFeatures(d2, tr)
  expect_equal(a$train$edges, b$train$edges)
  expect_equal(a$train$quad, b$train$quad)
  expect_equal(ncol(a$test$edges), 990)
  expect_equal(ncol(a$test$quad), 990 + 45)
})

test_that("RdaScore with full pooling and no shrinkage is linear discriminant", {
  set.seed(9)
  x <- matrix(rnorm(200 * 3), 200, 3)
  y <- rep(0:1, each = 100)
  x[y == 1, 1] <- x[y == 1, 1] + 1
  s <- RdaScore(x, y, x, lambda = 1, gamma = 0)
  expect_gt(cor(s, x[, 1]), 0.95)
})

test_that("KnownAnswerChecks returns exact identities", {
  k <- KnownAnswerChecks()
  ident <- k[k$type == "identity", ]
  expect_true(all(abs(ident$computed[1:4] - ident$known[1:4]) < 1e-8))
  expect_lt(abs(ident$computed[5] - ident$known[5]), 0.05)
  expect_equal(ident$computed[6:7], ident$known[6:7])
})

test_that("RunReplicate returns one AUC per model", {
  d <- PilotDesign()[1, ]
  d$n1 <- 25
  d$n0 <- 25
  r <- RunReplicate(d, 1, models = c("R0", "R1", "E1"))
  expect_equal(nrow(r), 1)
  expect_true(all(r[, c("R0", "R1", "E1")] >= 0 & r[, c("R0", "R1", "E1")] <= 1))
})

test_that("PilotBDesign has the 12 pre-registered cells and new seeds", {
  d <- PilotBDesign()
  expect_equal(nrow(d), 12)
  expect_equal(d$n_score[d$cell == 4], 2L)
  expect_equal(d$noise[d$cell %in% c(5, 10)], c("t5", "t5"))
  # replicate streams are seed + 1 to seed + 200; no overlap with the first pilot
  gaps <- outer(d$seed, PilotDesign()$seed, "-")
  expect_gt(min(abs(gaps)), 200)
})

test_that("t5 noise has unit variance and heavier tails", {
  set.seed(12)
  d <- SimulateCohort("null", "", 4000, 4000, noise = "t5")
  e <- d$x[, 6:20] - 0.8 * d$f
  expect_lt(abs(var(as.vector(e)) - 1), 0.05)
  k <- mean(as.vector(e)^4) / var(as.vector(e))^2
  expect_gt(k, 4)
})

test_that("the default noise leaves the first pilot's draws unchanged", {
  set.seed(13)
  a <- SimulateCohort("ifn", "large", 20, 20)
  set.seed(13)
  b <- SimulateCohort("ifn", "large", 20, 20, noise = "normal")
  expect_identical(a, b)
})

test_that("first-order features use only the training fold", {
  set.seed(14)
  d <- SimulateCohort("null", "", 40, 40)
  tr <- rep(c(TRUE, FALSE), 40)
  a <- PilotFeatures(d, tr)
  d2 <- d
  d2$x[!tr, ] <- d2$x[!tr, ] + 50
  b <- PilotFeatures(d2, tr)
  expect_equal(a$train$fo, b$train$fo)
  expect_equal(a$train$fo, LionessEdgesFirstOrder(d$x[tr, 6:50]))
  expect_equal(a$test$fo, LionessTestEdgesFirstOrder(d$x[!tr, 6:50],
                                                      d$x[tr, 6:50]))
})

test_that("RunReplicate fits F1R1 and the two-gene score", {
  d <- PilotBDesign()[4, ]
  d$n1 <- 25
  d$n0 <- 25
  r <- RunReplicate(d, 1, models = c("R1", "F1R1"))
  expect_true(all(c("R1", "F1R1") %in% names(r)))
})

test_that("PlotGains draws from saved summaries", {
  s <- readRDS(test_path("fixtures", "pilot_b_cell_summaries.rds"))
  f <- tempfile(fileext = ".png")
  grDevices::png(f)
  m <- PlotGains(s, PilotBDesign(), c(gain_N1R1_vs_R1 = "edges", gain_F1R1_vs_R1 = "first order"))
  grDevices::dev.off()
  expect_equal(dim(m), c(12, 2))
  expect_true(file.exists(f))
})

test_that("RunReplicate fits the SSN, iENA, SWEET, and BONOBO models", {
  d <- PilotBDesign()[7, ]
  d$n1 <- 30
  d$n0 <- 30
  r <- suppressWarnings(RunReplicate(d, 1, models = c("R1", "N3R1", "N4R1", "N5R1", "N6R1")))
  expect_true(all(r[, c("N3R1", "N4R1", "N5R1", "N6R1")] >= 0 &
                    r[, c("N3R1", "N4R1", "N5R1", "N6R1")] <= 1))
})
