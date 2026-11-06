# analysis/02_replication.R
# The replication of protocol.md, section 8, in GSE17755 and GSE326777, each
# analysed on its own, with a sensitivity analysis in each, and the
# overlapping-interferon subsets of the amendment of section 10 (A). Run from the
# project root after analysis/00_download.R:
#   Rscript analysis/02_replication.R
# Writes results/replication_summary.rds, results/replication_repeats.rds,
# results/replication_mechanism.rds, results/02_replication_run_info.rds,
# and results/02_replication_sessionInfo.txt.

devtools::load_all(here::here(), quiet = TRUE)
set.seed(20761103)
n_repeat <- 20L
raw <- function(f) here::here("data", "raw", f)

g17 <- ReadGse17755(raw("GSE17755_series_matrix.txt.gz"),
                    raw("GPL1291_platform_table.txt"))
g32 <- ReadGse326777(raw("GSE326777_gene_counts_matrix.tsv.gz"))
score17 <- intersect(c("EPSTI1", "IFI44L", "LY6E", "OAS3", "RSAD2"), colnames(g17$x))
score32 <- intersect(c(EPSTI1 = "ENSG00000133106", IFI44L = "ENSG00000137959",
                       LY6E = "ENSG00000160932", OAS3 = "ENSG00000111331",
                       RSAD2 = "ENSG00000134321"), colnames(g32$x))
Subset <- function(d, keep) {
  d$x <- d$x[keep, , drop = FALSE]
  d$y <- d$y[keep]
  if (!is.null(d$covariates)) d$covariates <- d$covariates[keep, , drop = FALSE]
  d
}
analyses <- list(
  list(dataset = "GSE17755", analysis = "primary", data = g17, score = score17),
  list(dataset = "GSE17755", analysis = "same submission date",
       data = Subset(g17, g17$same_batch), score = score17),
  list(dataset = "GSE326777", analysis = "primary", data = g32, score = score32),
  list(dataset = "GSE326777", analysis = "no N suffix",
       data = Subset(g32, !g32$suffix_n), score = score32),
  # amendment A (protocol.md, section 10): the overlapping-interferon subsets;
  # appended last, so the seeds of the four analyses above are unchanged
  list(dataset = "GSE17755", analysis = "overlapping IFN",
       data = Subset(g17, CommonSupport(g17, score17)), score = score17),
  list(dataset = "GSE326777", analysis = "overlapping IFN",
       data = Subset(g32, CommonSupport(g32, score32)), score = score32))

contrasts <- list(d1 = c("N1", "E1"), d2 = c("N1", "F1"), A = c("N1R0", "R0"),
                  P = c("N1", "E5"), N2_E1 = c("N2", "E1"), E4_E1 = c("E4", "E1"),
                  E1_R1 = c("E1", "R1"), R1_R0 = c("R1", "R0"))
repeats <- list()
summary <- list()
start <- Sys.time()
for (i in seq_along(analyses)) {
  an <- analyses[[i]]
  reps <- lapply(seq_len(n_repeat), function(r) {
    suppressWarnings(ReplicationRepeat(an$data, 20761103L + 1000L * i + r, an$score))
  })
  pooled <- do.call(rbind, lapply(reps, `[[`, "pooled"))
  folds <- do.call(rbind, lapply(reps, `[[`, "folds"))
  repeats[[i]] <- data.frame(dataset = an$dataset, analysis = an$analysis,
                             repeat_id = seq_len(n_repeat), pooled)
  j <- nrow(folds)
  se <- function(d) sqrt((1 / j + 1 / 4) * stats::var(d))
  rows <- lapply(names(contrasts), function(cn) {
    m <- contrasts[[cn]]
    d <- folds[[m[1]]] - folds[[m[2]]]
    data.frame(contrast = cn, models = paste(m, collapse = " - "),
               pooled_mean = mean(pooled[, m[1]] - pooled[, m[2]]),
               fold_mean = mean(d), corrected_se = se(d))
  })
  tests <- CorrectedTests(folds$N1 - folds$E1, folds$N1 - folds$F1)
  summary[[i]] <- list(dataset = an$dataset, analysis = an$analysis,
                       n_sle = sum(an$data$y == 1), n_ra = sum(an$data$y == 0),
                       n_genes = ncol(an$data$x), score_genes = an$score,
                       auc = colMeans(pooled), contrasts = do.call(rbind, rows),
                       tests = tests)
}
mechanism <- lapply(analyses[c(1, 3)], function(an) {
  c(list(dataset = an$dataset), MechanismChecks(an$data, an$score))
})
elapsed <- as.numeric(difftime(Sys.time(), start, units = "secs"))
saveRDS(summary, here::here("results", "replication_summary.rds"))
saveRDS(do.call(rbind, repeats), here::here("results", "replication_repeats.rds"))
saveRDS(mechanism, here::here("results", "replication_mechanism.rds"))
saveRDS(list(run = "production", n_rep = n_repeat, n_cells = length(analyses),
             date = Sys.time(), elapsed_seconds = elapsed,
             n_rep_production = n_repeat,
             note = "replication in GSE17755 and GSE326777, protocol.md section 8"),
        here::here("results", "02_replication_run_info.rds"))
writeLines(capture.output(sessionInfo()),
           here::here("results", "02_replication_sessionInfo.txt"))
for (s in summary) {
  cat(sprintf("\n%s, %s: %d SLE, %d RA, %d genes\n", s$dataset, s$analysis,
              s$n_sle, s$n_ra, s$n_genes))
  print(s$contrasts, digits = 3)
  print(s$tests, digits = 3)
}
for (m in mechanism) {
  cat(sprintf("\n%s: formula correlation median %.4f (min %.4f); IFN-square correlation median %.3f; median largest |z| %.1f; Spearman(agreement, largest |z|) %.2f\n",
              m$dataset, stats::median(m$formula_cor), min(m$formula_cor),
              stats::median(m$ifn_cor), stats::median(m$gene_max_z),
              m$agreement_vs_max_z))
}
cat(sprintf("elapsed %.0f s\n", elapsed))
