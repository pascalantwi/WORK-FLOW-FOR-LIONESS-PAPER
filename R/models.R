#' Area under the ROC curve
#'
#' The Mann-Whitney form: the probability that a random class-1 score exceeds
#' a random class-0 score, ties counted one half.
#'
#' @param score Numeric scores.
#' @param y Class labels, 0 or 1.
#' @return The AUC.
#' @export
Auc <- function(score, y) {
  n1 <- sum(y == 1)
  n0 <- sum(y == 0)
  rk <- rank(score)
  (sum(rk[y == 1]) - n1 * (n1 + 1) / 2) / (n1 * n0)
}

#' Stratified fold assignment
#'
#' @param y Class labels.
#' @param k Number of folds.
#' @return An integer vector of folds, balanced within each class.
#' @export
StratifiedFolds <- function(y, k = 5) {
  folds <- integer(length(y))
  for (cl in unique(y)) {
    idx <- which(y == cl)
    folds[idx] <- sample(rep_len(seq_len(k), length(idx)))
  }
  folds
}

#' Features of the pilot's models, fitted on a training fold
#'
#' The IFN score is the mean of genes 1 to 5 standardized by the training
#' fold; its residual on composition uses the training regression. The gene
#' set is genes 6 to 50. Products and squares use genes standardized by the
#' training fold (divisor N). LIONESS edges of training samples use the
#' training fold as reference; test samples are scored against it.
#'
#' @param cohort A list from [SimulateCohort()].
#' @param train Logical vector, `TRUE` for training samples.
#' @param score_genes,gene_set Column indices of the score genes and the
#'   network gene set.
#' @param extra Further edge features to compute: any of `"ssn"`, `"iena"`,
#'   `"sweet"`, `"bonobo"` ([SsnEdges()], [IenaEdges()], [SweetEdges()],
#'   [BonoboEdges()]), each with the training fold as reference, and
#'   `"partial"`, the LIONESS edges of the partial correlation given the IFN
#'   score and composition ([LionessPartialEdges()]), element `pedges`.
#' @return A list with `train` and `test` elements, each holding `r0`, `r1`
#'   (reference covariate matrices), `genes`, `quad`, `edges`, and `fo` (the
#'   first-order edge features, with the training fold's correlation and
#'   standardization for both parts).
#' @export
PilotFeatures <- function(cohort, train, score_genes = 1:5,
                          gene_set = 6:50, extra = character(0)) {
  x <- cohort$x
  sc <- StandardizeN(x[train, score_genes, drop = FALSE])
  score <- rowMeans(StandardizeN(x[, score_genes, drop = FALSE], sc$center,
                                 sc$scale)$z)
  fit <- stats::lm.fit(cbind(1, cohort$comp[train]), score[train])
  resid <- score - drop(cbind(1, cohort$comp) %*% fit$coefficients)
  r0 <- cbind(age = cohort$age, sex = cohort$sex, comp = cohort$comp,
              ifn = resid)
  r1 <- cbind(r0, ifn2 = resid^2, comp2 = cohort$comp^2)
  g <- x[, gene_set, drop = FALSE]
  gs <- StandardizeN(g[train, , drop = FALSE])
  z <- StandardizeN(g, gs$center, gs$scale)$z
  pairs <- PairIndex(length(gene_set))
  quad <- cbind(z[, pairs[, 1]] * z[, pairs[, 2]], z^2)
  edges_train <- LionessEdges(g[train, , drop = FALSE])
  edges_test <- LionessTestEdges(g[!train, , drop = FALSE],
                                 g[train, , drop = FALSE])
  r_tr <- stats::cor(g[train, , drop = FALSE])[pairs]
  r_mat <- matrix(r_tr, nrow = nrow(z), ncol = length(r_tr), byrow = TRUE)
  fo <- r_mat + z[, pairs[, 1]] * z[, pairs[, 2]] -
    r_mat / 2 * (z[, pairs[, 1]]^2 + z[, pairs[, 2]]^2)
  part <- function(rows, edges) {
    list(r0 = r0[rows, , drop = FALSE], r1 = r1[rows, , drop = FALSE],
         genes = g[rows, , drop = FALSE], quad = quad[rows, , drop = FALSE],
         edges = edges, fo = fo[rows, , drop = FALSE])
  }
  out <- list(train = part(train, edges_train), test = part(!train, edges_test))
  gtr <- g[train, , drop = FALSE]
  gte <- g[!train, , drop = FALSE]
  if ("ssn" %in% extra) {
    out$train$ssn <- SsnEdges(gtr)
    out$test$ssn <- SsnTestEdges(gte, gtr)
  }
  if ("iena" %in% extra) {
    out$train$iena <- IenaEdges(gtr, gtr)
    out$test$iena <- IenaEdges(gte, gtr)
  }
  if ("sweet" %in% extra) {
    out$train$sweet <- SweetEdges(gtr)
    out$test$sweet <- SweetTestEdges(gte, gtr)
  }
  if ("bonobo" %in% extra) {
    out$train$bonobo <- BonoboEdges(gtr)
    out$test$bonobo <- BonoboTestEdges(gte, gtr)
  }
  if ("partial" %in% extra) {
    # conditioning set: the IFN score (training standardization) and composition
    cond <- cbind(ifn = score, comp = cohort$comp)
    out$train$pedges <- LionessPartialEdges(gtr, cond[train, , drop = FALSE])
    out$test$pedges <- LionessPartialTestEdges(gte, cond[!train, , drop = FALSE],
                                               gtr, cond[train, , drop = FALSE])
  }
  out
}

#' Fit a logistic reference model and score a test set
#'
#' @param x_train,x_test Covariate matrices.
#' @param y Training labels.
#' @return Linear predictors for the test samples.
#' @export
FitReference <- function(x_train, y, x_test) {
  fit <- suppressWarnings(stats::glm.fit(cbind(1, x_train), y,
                                         family = stats::binomial()))
  b <- fit$coefficients
  b[is.na(b)] <- 0
  drop(cbind(1, x_test) %*% b)
}

#' Fit an elastic net with unpenalized reference terms and score a test set
#'
#' `cv.glmnet` with `alpha = 0.5`, 5 inner folds, binomial deviance, and
#' `lambda.min`; the reference columns have penalty factor 0.
#'
#' @param ref_train,ref_test Reference covariate matrices (unpenalized).
#' @param pen_train,pen_test Penalized feature matrices.
#' @param y Training labels.
#' @param alpha The elastic-net mixing parameter (0 ridge, 1 lasso).
#' @return Linear predictors for the test samples.
#' @export
FitElasticNet <- function(ref_train, pen_train, y, ref_test, pen_test,
                          alpha = 0.5) {
  xtr <- cbind(ref_train, pen_train)
  xte <- cbind(ref_test, pen_test)
  pf <- c(rep(0, ncol(ref_train)), rep(1, ncol(pen_train)))
  # cv.glmnet, or its prediction, fails when a path ends after one penalty
  # value (few cases in a fold, near-separable classes); only then the
  # fallback runs, so every fit that cv.glmnet completes is unchanged
  out <- tryCatch({
    fit <- glmnet::cv.glmnet(xtr, y, family = "binomial", alpha = alpha,
                             nfolds = 5, penalty.factor = pf,
                             type.measure = "deviance")
    drop(stats::predict(fit, newx = xte, s = "lambda.min", type = "link"))
  }, error = function(e) NULL)
  if (is.null(out)) out <- ElasticNetFallback(xtr, y, xte, pf, alpha)
  out
}

#' Regularized discriminant analysis scores
#'
#' Class covariances `(1 - lambda) S_c + lambda S_pooled`, then shrunk toward
#' their mean diagonal by `gamma`; the score is the log density ratio of
#' class 1 to class 0 plus the log prior ratio.
#'
#' @param x_train,x_test Feature matrices.
#' @param y Training labels.
#' @param lambda,gamma Regularization parameters in `[0, 1]`.
#' @return Scores for the test samples.
#' @export
RdaScore <- function(x_train, y, x_test, lambda, gamma) {
  d <- ncol(x_train)
  classes <- c(0L, 1L)
  mu <- lapply(classes, function(cl) colMeans(x_train[y == cl, , drop = FALSE]))
  s <- lapply(seq_along(classes), function(k) {
    xc <- sweep(x_train[y == classes[k], , drop = FALSE], 2, mu[[k]])
    crossprod(xc) / max(nrow(xc) - 1, 1)
  })
  nk <- vapply(classes, function(cl) sum(y == cl), numeric(1))
  pooled <- ((nk[1] - 1) * s[[1]] + (nk[2] - 1) * s[[2]]) / (sum(nk) - 2)
  loglik <- vapply(seq_along(classes), function(k) {
    sig <- (1 - lambda) * s[[k]] + lambda * pooled
    sig <- (1 - gamma) * sig + gamma * mean(diag(sig)) * diag(d)
    ch <- chol(sig + diag(1e-8, d))
    dev <- backsolve(ch, t(sweep(x_test, 2, mu[[k]])), transpose = TRUE)
    -0.5 * colSums(dev^2) - sum(log(diag(ch))) + log(nk[k] / sum(nk))
  }, numeric(nrow(x_test)))
  loglik[, 2] - loglik[, 1]
}

#' Regularized discriminant analysis tuned by inner cross-validation
#'
#' @inheritParams RdaScore
#' @param grid Values of `lambda` and `gamma` to search.
#' @param k Number of inner folds.
#' @return Scores for the test samples at the tuned parameters.
#' @export
FitRda <- function(x_train, y, x_test, grid = seq(0, 1, by = 0.25), k = 5) {
  folds <- StratifiedFolds(y, k)
  combos <- expand.grid(lambda = grid, gamma = grid)
  combos <- combos[!(combos$lambda == 0 & combos$gamma == 0), ]
  cv_auc <- vapply(seq_len(nrow(combos)), function(i) {
    sc <- numeric(length(y))
    for (f in seq_len(k)) {
      tr <- folds != f
      sc[!tr] <- RdaScore(x_train[tr, , drop = FALSE], y[tr],
                          x_train[!tr, , drop = FALSE],
                          combos$lambda[i], combos$gamma[i])
    }
    Auc(sc, y)
  }, numeric(1))
  best <- combos[which.max(cv_auc), ]
  RdaScore(x_train, y, x_test, best$lambda, best$gamma)
}

#' Run one replicate of a pilot cell
#'
#' Simulates a cohort, runs the outer 5-fold cross-validation for the seven
#' models, and returns the out-of-fold AUC of each. In mean-shift cells it
#' also compares the observed class difference in mean LIONESS edge over the
#' module pairs with proposal equation (3).
#'
#' @param design_row One row of [PilotDesign()].
#' @param rep Replicate index; the seed is the cell seed plus `rep`.
#' @param models Which models to fit: the first pilot's seven by default;
#'   `"F1R1"` adds the first-order edge features with the `R_1` terms, and
#'   `"N3R1"`, `"N4R1"`, `"N5R1"`, `"N6R1"` the SSN, iENA, SWEET, and BONOBO
#'   edges with the `R_1` terms. The models built on E1 (proposal revision 4)
#'   are `"E5E1"`, `"F1E1"`, `"N1E1"`, and `"N2E1"`: the genes plus the
#'   products and squares, the first-order edges, the LIONESS edges, or the
#'   partial-correlation LIONESS edges, penalized, with the `R_1` terms
#'   unpenalized.
#'   The row's optional `noise`, `n_score`, and `alpha` columns set the noise
#'   distribution, the number of score genes, and the elastic-net mixing
#'   (defaults `"normal"`, 5, and 0.5). With more than five score genes the
#'   gene set drops them, so that the score and the edges share no gene.
#' @return A one-row data frame.
#' @export
RunReplicate <- function(design_row, rep,
                         models = c("R0", "R1", "E1", "E4", "E5", "N1R0",
                                    "N1R1")) {
  set.seed(design_row$seed + rep)
  noise <- if (is.null(design_row$noise)) "normal" else design_row$noise
  n_score <- if (is.null(design_row$n_score)) 5L else design_row$n_score
  alpha <- if (is.null(design_row$alpha)) 0.5 else design_row$alpha
  gene_set <- if (n_score > 5) setdiff(6:50, seq_len(n_score)) else 6:50
  fit_en <- function(...) FitElasticNet(..., alpha = alpha)
  coh <- SimulateCohort(design_row$mechanism, design_row$level,
                        design_row$n1, design_row$n0, noise = noise)
  y <- coh$y
  folds <- StratifiedFolds(y, 5)
  pred <- matrix(NA_real_, length(y), length(models),
                 dimnames = list(NULL, models))
  for (f in 1:5) {
    tr <- folds != f
    extra_map <- c(N3R1 = "ssn", N4R1 = "iena", N5R1 = "sweet",
                   N6R1 = "bonobo", N2E1 = "partial")
    extra <- extra_map[intersect(models, names(extra_map))]
    ft <- PilotFeatures(coh, tr, score_genes = seq_len(n_score),
                        gene_set = gene_set, extra = extra)
    a <- ft$train
    b <- ft$test
    ytr <- y[tr]
    out <- list(
      R0 = function() FitReference(a$r0, ytr, b$r0),
      R1 = function() FitReference(a$r1, ytr, b$r1),
      E1 = function() fit_en(a$r1, a$genes, ytr, b$r1, b$genes),
      E4 = function() FitRda(cbind(a$genes, a$r0[, c("comp", "ifn")]), ytr,
                             cbind(b$genes, b$r0[, c("comp", "ifn")])),
      E5 = function() fit_en(a$r1, a$quad, ytr, b$r1, b$quad),
      N1R0 = function() fit_en(a$r0, a$edges, ytr, b$r0, b$edges),
      N1R1 = function() fit_en(a$r1, a$edges, ytr, b$r1, b$edges),
      F1R1 = function() fit_en(a$r1, a$fo, ytr, b$r1, b$fo),
      N3R1 = function() fit_en(a$r1, a$ssn, ytr, b$r1, b$ssn),
      N4R1 = function() fit_en(a$r1, a$iena, ytr, b$r1, b$iena),
      N5R1 = function() fit_en(a$r1, a$sweet, ytr, b$r1, b$sweet),
      N6R1 = function() fit_en(a$r1, a$bonobo, ytr, b$r1, b$bonobo),
      E5E1 = function() fit_en(a$r1, cbind(a$genes, a$quad), ytr,
                                      b$r1, cbind(b$genes, b$quad)),
      F1E1 = function() fit_en(a$r1, cbind(a$genes, a$fo), ytr,
                                      b$r1, cbind(b$genes, b$fo)),
      N1E1 = function() fit_en(a$r1, cbind(a$genes, a$edges), ytr,
                                      b$r1, cbind(b$genes, b$edges)),
      N2E1 = function() fit_en(a$r1, cbind(a$genes, a$pedges), ytr,
                                      b$r1, cbind(b$genes, b$pedges))
    )
    for (m in models) pred[!tr, m] <- out[[m]]()
  }
  auc <- apply(pred, 2, Auc, y = y)
  shift_gap <- NA_real_
  if (design_row$mechanism == "shift") {
    g <- coh$x[, 21:30]
    e <- LionessEdges(g)
    observed <- colMeans(e[y == 1, , drop = FALSE]) -
      colMeans(e[y == 0, , drop = FALSE])
    shift_gap <- mean(observed - MeanShiftEdgeDifference(g, y))
  }
  data.frame(cell = design_row$cell, rep = rep, t(auc),
             shift_gap = shift_gap, check.names = FALSE)
}

#' Summarize replicates by cell
#'
#' Means and Monte Carlo standard errors of each model's AUC and of the paired
#' gains the pass rule uses.
#'
#' @param reps Data frame of replicates from [RunReplicate()].
#' @return A long data frame: `cell`, `quantity`, `mean`, `mcse`, `n_rep`.
#' @export
SummarizeCells <- function(reps) {
  # exact column lookup: `$` would partially match E5 to E5E1
  col <- function(nm) {
    if (nm %in% names(reps)) reps[[nm]] else rep(NA_real_, nrow(reps))
  }
  q <- list(
    R0 = col("R0"), R1 = col("R1"), E1 = col("E1"), E4 = col("E4"), E5 = col("E5"),
    N1R0 = col("N1R0"), N1R1 = col("N1R1"),
    gain_N1R0_vs_R0 = col("N1R0") - col("R0"),
    gain_N1R1_vs_R1 = col("N1R1") - col("R1"),
    gain_E5_vs_R1 = col("E5") - col("R1"),
    gain_E1_vs_R1 = col("E1") - col("R1"),
    gain_E4_vs_R1 = col("E4") - col("R1"),
    diff_N1R1_vs_E5 = col("N1R1") - col("E5"),
    b_clause = (col("E5") - col("R1")) - 0.9 * (col("N1R1") - col("R1")),
    F1R1 = col("F1R1"),
    gain_F1R1_vs_R1 = col("F1R1") - col("R1"),
    diff_N1R1_vs_F1R1 = col("N1R1") - col("F1R1"),
    diff_F1R1_vs_E5 = col("F1R1") - col("E5"),
    N3R1 = col("N3R1"), N4R1 = col("N4R1"), N5R1 = col("N5R1"), N6R1 = col("N6R1"),
    diff_N3R1_vs_F1R1 = col("N3R1") - col("F1R1"),
    diff_N4R1_vs_F1R1 = col("N4R1") - col("F1R1"),
    diff_N5R1_vs_F1R1 = col("N5R1") - col("F1R1"),
    diff_N6R1_vs_F1R1 = col("N6R1") - col("F1R1"),
    gain_N5R1_vs_R1 = col("N5R1") - col("R1"),
    gain_N6R1_vs_R1 = col("N6R1") - col("R1"),
    E5E1 = col("E5E1"), F1E1 = col("F1E1"), N1E1 = col("N1E1"),
    N2E1 = col("N2E1"),
    d1_N1E1_vs_E1 = col("N1E1") - col("E1"),
    d2_N1E1_vs_F1E1 = col("N1E1") - col("F1E1"),
    g2_N2E1_vs_E1 = col("N2E1") - col("E1"),
    par_N1E1_vs_E5E1 = col("N1E1") - col("E5E1"),
    gain_F1E1_vs_E1 = col("F1E1") - col("E1"),
    gain_E5E1_vs_E1 = col("E5E1") - col("E1"),
    diff_E4_vs_E1 = col("E4") - col("E1"),
    diff_N2E1_vs_N1E1 = col("N2E1") - col("N1E1"),
    shift_gap = col("shift_gap")
  )
  out <- do.call(rbind, lapply(split(seq_len(nrow(reps)), reps$cell),
                               function(rows) {
    do.call(rbind, lapply(names(q), function(nm) {
      v <- q[[nm]][rows]
      v <- v[!is.na(v)]
      data.frame(cell = reps$cell[rows[1]], quantity = nm,
                 mean = if (length(v)) mean(v) else NA_real_,
                 mcse = if (length(v) > 1) stats::sd(v) / sqrt(length(v))
                 else NA_real_,
                 n_rep = length(v))
    }))
  }))
  rownames(out) <- NULL
  out
}

#' One replicate of a test setting: the real-data procedure on a simulated cohort
#'
#' Repeated stratified k-fold cross-validation of E1, N1 (E1 plus LIONESS
#' edges), and F1 (E1 plus first-order edges); the AUC in each test fold; and
#' the two primary tests of proposal section 7.2 on the fold differences:
#' the corrected resampled t-test (Nadeau and Bengio) of
#' `Delta_1 = AUC(N1) - AUC(E1)`, one-sided at 5%, and the two one-sided tests
#' of `Delta_2 = AUC(N1) - AUC(F1)` with margin `margin` (equivalence when the
#' 90% interval lies inside it), both with the corrected variance
#' `(1 / J + n_test / n_train) s^2` over the `J` folds.
#'
#' @param design_row One row of `StudyDesign()$test`.
#' @param rep Replicate index; the seed is the cell seed plus `rep`.
#' @param n_repeat,k Repeats and folds.
#' @param margin The equivalence margin.
#' @return A one-row data frame: `cell`, `rep`, the mean fold differences
#'   `d1` and `d2`, `reject_d1` (superiority of N1 over E1 declared),
#'   `equiv_d2` (equivalence of N1 and F1 declared).
#' @export
TestReplicate <- function(design_row, rep, n_repeat = 5L, k = 5L,
                          margin = 0.01) {
  set.seed(design_row$seed + rep)
  noise <- if (is.null(design_row$noise)) "normal" else design_row$noise
  coh <- SimulateCohort(design_row$mechanism, design_row$level,
                        design_row$n1, design_row$n0, noise = noise)
  y <- coh$y
  d1 <- d2 <- numeric(0)
  for (r in seq_len(n_repeat)) {
    folds <- StratifiedFolds(y, k)
    for (f in seq_len(k)) {
      tr <- folds != f
      ft <- PilotFeatures(coh, tr)
      a <- ft$train
      b <- ft$test
      e1 <- FitElasticNet(a$r1, a$genes, y[tr], b$r1, b$genes)
      n1 <- FitElasticNet(a$r1, cbind(a$genes, a$edges), y[tr],
                          b$r1, cbind(b$genes, b$edges))
      f1 <- FitElasticNet(a$r1, cbind(a$genes, a$fo), y[tr],
                          b$r1, cbind(b$genes, b$fo))
      yt <- y[!tr]
      d1 <- c(d1, Auc(n1, yt) - Auc(e1, yt))
      d2 <- c(d2, Auc(n1, yt) - Auc(f1, yt))
    }
  }
  j <- length(d1)
  ratio <- 1 / (k - 1)  # n_test / n_train for k folds
  se <- function(d) sqrt((1 / j + ratio) * stats::var(d))
  t1 <- mean(d1) / se(d1)
  half <- stats::qt(0.95, j - 1) * se(d2)
  data.frame(cell = design_row$cell, rep = rep, d1 = mean(d1), d2 = mean(d2),
             reject_d1 = isTRUE(1 - stats::pt(t1, j - 1) < 0.05),
             equiv_d2 = (mean(d2) - half > -margin) && (mean(d2) + half < margin))
}

#' Cross-validated elastic net that tolerates truncated paths
#'
#' The fallback of [FitElasticNet()] when `cv.glmnet` fails: the penalty
#' sequence of the fit on all training samples; stratified inner folds; each
#' fold's linear predictors computed from its coefficients, with the last
#' available fit carried forward where its path stops early; the penalty with
#' the smallest binomial deviance.
#'
#' @param xtr,xte Training and test feature matrices.
#' @param y Training labels.
#' @param pf Penalty factors.
#' @param alpha The elastic-net mixing parameter.
#' @param k Number of inner folds.
#' @return Linear predictors for the test samples.
#' @export
ElasticNetFallback <- function(xtr, y, xte, pf, alpha = 0.5, k = 5L) {
  fit_path <- function(x, yy, lambda = NULL) {
    suppressWarnings(glmnet::glmnet(x, yy, family = "binomial", alpha = alpha,
                                    penalty.factor = pf, lambda = lambda))
  }
  coefs <- function(g, n_lambda, yy) {
    # coef() returns the intercepts and slopes aligned; a fit that stopped
    # before its first penalty value has no usable path, and the
    # intercept-only model of its training labels stands in for it
    b <- tryCatch(as.matrix(stats::coef(g)), error = function(e) NULL)
    if (is.null(b) || ncol(b) == 0 || nrow(b) != ncol(xtr) + 1) {
      b <- matrix(c(stats::qlogis(mean(yy)), rep(0, ncol(xtr))), ncol = 1)
    }
    b[, pmin(seq_len(n_lambda), ncol(b)), drop = FALSE]
  }
  full <- fit_path(xtr, y)
  lam <- full$lambda
  folds <- StratifiedFolds(y, k)
  dev <- matrix(NA_real_, length(y), length(lam))
  for (f in seq_len(k)) {
    held <- folds == f
    g <- fit_path(xtr[!held, , drop = FALSE], y[!held], lambda = lam)
    eta <- cbind(1, xtr[held, , drop = FALSE]) %*% coefs(g, length(lam), y[!held])
    p <- pmin(pmax(stats::plogis(eta), 1e-12), 1 - 1e-12)
    dev[held, ] <- -2 * (y[held] * log(p) + (1 - y[held]) * log(1 - p))
  }
  best <- which.min(colMeans(dev))
  drop(cbind(1, xte) %*% coefs(full, length(lam), y)[, best])
}
