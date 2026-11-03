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
#' @return A list with `train` and `test` elements, each holding `r0`, `r1`
#'   (reference covariate matrices), `genes`, `quad`, and `edges`.
#' @export
PilotFeatures <- function(cohort, train, score_genes = 1:5,
                          gene_set = 6:50) {
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
  part <- function(rows, edges) {
    list(r0 = r0[rows, , drop = FALSE], r1 = r1[rows, , drop = FALSE],
         genes = g[rows, , drop = FALSE], quad = quad[rows, , drop = FALSE],
         edges = edges)
  }
  list(train = part(train, edges_train), test = part(!train, edges_test))
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
#' @return Linear predictors for the test samples.
#' @export
FitElasticNet <- function(ref_train, pen_train, y, ref_test, pen_test) {
  xtr <- cbind(ref_train, pen_train)
  xte <- cbind(ref_test, pen_test)
  pf <- c(rep(0, ncol(ref_train)), rep(1, ncol(pen_train)))
  fit <- glmnet::cv.glmnet(xtr, y, family = "binomial", alpha = 0.5,
                           nfolds = 5, penalty.factor = pf,
                           type.measure = "deviance")
  drop(stats::predict(fit, newx = xte, s = "lambda.min", type = "link"))
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
#' @param models Which models to fit (all seven by default).
#' @return A one-row data frame.
#' @export
RunReplicate <- function(design_row, rep,
                         models = c("R0", "R1", "E1", "E4", "E5", "N1R0",
                                    "N1R1")) {
  set.seed(design_row$seed + rep)
  coh <- SimulateCohort(design_row$mechanism, design_row$level,
                        design_row$n1, design_row$n0)
  y <- coh$y
  folds <- StratifiedFolds(y, 5)
  pred <- matrix(NA_real_, length(y), length(models),
                 dimnames = list(NULL, models))
  for (f in 1:5) {
    tr <- folds != f
    ft <- PilotFeatures(coh, tr)
    a <- ft$train
    b <- ft$test
    ytr <- y[tr]
    out <- list(
      R0 = function() FitReference(a$r0, ytr, b$r0),
      R1 = function() FitReference(a$r1, ytr, b$r1),
      E1 = function() FitElasticNet(a$r1, a$genes, ytr, b$r1, b$genes),
      E4 = function() FitRda(cbind(a$genes, a$r0[, c("comp", "ifn")]), ytr,
                             cbind(b$genes, b$r0[, c("comp", "ifn")])),
      E5 = function() FitElasticNet(a$r1, a$quad, ytr, b$r1, b$quad),
      N1R0 = function() FitElasticNet(a$r0, a$edges, ytr, b$r0, b$edges),
      N1R1 = function() FitElasticNet(a$r1, a$edges, ytr, b$r1, b$edges)
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
  q <- list(
    R0 = reps$R0, R1 = reps$R1, E1 = reps$E1, E4 = reps$E4, E5 = reps$E5,
    N1R0 = reps$N1R0, N1R1 = reps$N1R1,
    gain_N1R0_vs_R0 = reps$N1R0 - reps$R0,
    gain_N1R1_vs_R1 = reps$N1R1 - reps$R1,
    gain_E5_vs_R1 = reps$E5 - reps$R1,
    gain_E1_vs_R1 = reps$E1 - reps$R1,
    gain_E4_vs_R1 = reps$E4 - reps$R1,
    diff_N1R1_vs_E5 = reps$N1R1 - reps$E5,
    b_clause = (reps$E5 - reps$R1) - 0.9 * (reps$N1R1 - reps$R1),
    shift_gap = reps$shift_gap
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
