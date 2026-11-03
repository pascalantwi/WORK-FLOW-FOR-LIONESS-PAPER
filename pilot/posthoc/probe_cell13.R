# pilot/posthoc/probe_cell13.R
# EXPLORATORY, NOT PRE-REGISTERED. Run after the verdict, to explain clause 3(b).
# In cell 13 (network, change 0.4, share 0.5, n 80), compares the edges with
# R1 (N1R1), the pre-registered matched quadratic model (E5: products and
# squares as separate features), and first-order edges as features (F1R1:
# r + z_i z_j - (r/2)(z_i^2 + z_j^2), same linear span as E5, one feature per
# pair). Seeds differ from the run's (cell seed + 100000 + replicate).
#   Rscript pilot/posthoc/probe_cell13.R
devtools::load_all(here::here(), quiet = TRUE)
library(parallel)
n_rep <- 60L
row <- PilotDesign()[13, ]
Sys.setenv(OPENBLAS_NUM_THREADS = "1")
cl <- makePSOCKcluster(3L)
clusterEvalQ(cl, devtools::load_all(here::here(), quiet = TRUE))
clusterExport(cl, "row")
res <- parLapplyLB(cl, seq_len(n_rep), function(r) {
  set.seed(row$seed + 100000L + r)
  coh <- SimulateCohort(row$mechanism, row$level, row$n1, row$n0)
  y <- coh$y
  folds <- StratifiedFolds(y, 5)
  pred <- matrix(NA_real_, length(y), 4, dimnames = list(NULL, c("R1", "E5", "N1R1", "F1R1")))
  for (f in 1:5) {
    tr <- folds != f
    ft <- PilotFeatures(coh, tr)
    a <- ft$train; b <- ft$test; ytr <- y[tr]
    g <- coh$x[, 6:50]
    fo_tr <- LionessEdgesFirstOrder(g[tr, ])
    fo_te <- LionessTestEdgesFirstOrder(g[!tr, ], g[tr, ])
    pred[!tr, "R1"] <- FitReference(a$r1, ytr, b$r1)
    pred[!tr, "E5"] <- FitElasticNet(a$r1, a$quad, ytr, b$r1, b$quad)
    pred[!tr, "N1R1"] <- FitElasticNet(a$r1, a$edges, ytr, b$r1, b$edges)
    pred[!tr, "F1R1"] <- FitElasticNet(a$r1, fo_tr, ytr, b$r1, fo_te)
  }
  apply(pred, 2, Auc, y = y)
}, chunk.size = 1)
stopCluster(cl)
auc <- do.call(rbind, res)
gains <- data.frame(
  quantity = c("A(E5) - A(R1)", "A(N1R1) - A(R1)", "A(F1R1) - A(R1)", "A(N1R1) - A(F1R1)"),
  mean = c(mean(auc[, "E5"] - auc[, "R1"]), mean(auc[, "N1R1"] - auc[, "R1"]),
           mean(auc[, "F1R1"] - auc[, "R1"]), mean(auc[, "N1R1"] - auc[, "F1R1"])),
  mcse = c(sd(auc[, "E5"] - auc[, "R1"]), sd(auc[, "N1R1"] - auc[, "R1"]),
           sd(auc[, "F1R1"] - auc[, "R1"]), sd(auc[, "N1R1"] - auc[, "F1R1"])) / sqrt(n_rep))
saveRDS(list(auc = auc, gains = gains, n_rep = n_rep, cell = 13,
             note = "exploratory, not pre-registered", date = Sys.time()),
        here::here("pilot", "results", "posthoc_cell13.rds"))
print(gains, digits = 3)
