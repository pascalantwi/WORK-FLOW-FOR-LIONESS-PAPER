#' Read a GEO series matrix file
#'
#' @param path Path to a `*_series_matrix.txt.gz` file.
#' @return A list: `samples`, a data frame with one row per sample (the GEO
#'   accession, the title, the submission date, and one column per
#'   characteristic key), and `table`, the expression table (rows are
#'   probes, columns are samples), or `NULL` when it is empty.
#' @export
ReadSeriesMatrix <- function(path) {
  lines <- readLines(gzfile(path), warn = FALSE)
  field <- function(tag) {
    l <- grep(paste0("^!Sample_", tag, "\t"), lines, value = TRUE)
    lapply(l, function(x) gsub('^"|"$', "", strsplit(x, "\t")[[1]][-1]))
  }
  acc <- field("geo_accession")[[1]]
  samples <- data.frame(geo = acc, title = field("title")[[1]],
                        submitted = field("submission_date")[[1]],
                        stringsAsFactors = FALSE)
  # characteristics rows may hold different keys for different samples
  for (row in field("characteristics_ch1")) {
    for (i in seq_along(row)) {
      kv <- regmatches(row[i], regexpr(": ", row[i]), invert = TRUE)[[1]]
      if (length(kv) != 2) next
      key <- make.names(kv[1])
      if (!key %in% names(samples)) samples[[key]] <- NA_character_
      samples[[key]][i] <- kv[2]
    }
  }
  b <- grep("^!series_matrix_table_begin", lines)
  e <- grep("^!series_matrix_table_end", lines)
  table <- NULL
  if (length(b) && e > b + 2) {
    tab <- utils::read.delim(text = lines[(b + 1):(e - 1)], check.names = FALSE,
                             na.strings = c("", "null", "NA"))
    table <- as.matrix(tab[, -1])
    rownames(table) <- tab[[1]]
  }
  list(samples = samples, table = table)
}

#' The GSE17755 replication cohort: female SLE and female RA
#'
#' Reads the series matrix and the GPL1291 platform table, keeps female SLE
#' and RA patients, keeps probes with a gene symbol observed in at least
#' `min_obs` of the kept samples, and averages the probes of each gene
#' (missing values stay missing, to be filled inside each training fold).
#'
#' @param matrix_path,platform_path Paths to the series matrix and to the
#'   platform table (the GEO text view of GPL1291).
#' @param min_obs Smallest share of kept samples in which a probe is observed.
#' @return A list: `x` (samples by gene symbols, log2 ratios), `y` (1 for SLE,
#'   0 for RA), `covariates` (age), `samples`, and `same_batch` (`TRUE` for
#'   samples submitted on the date the RA samples were).
#' @export
ReadGse17755 <- function(matrix_path, platform_path, min_obs = 0.8) {
  sm <- ReadSeriesMatrix(matrix_path)
  s <- sm$samples
  keep <- s$gender == "female" &
    s$disease %in% c("systemic lupus erythematosus", "rheumatoid arthritis")
  s <- s[keep, ]
  x <- sm$table[, s$geo, drop = FALSE]
  pl <- readLines(platform_path, warn = FALSE)
  b <- grep("^!platform_table_begin", pl)
  e <- grep("^!platform_table_end", pl)
  pt <- utils::read.delim(text = pl[(b + 1):(e - 1)], quote = "",
                          check.names = FALSE, stringsAsFactors = FALSE)
  sym <- pt$Symbol[match(rownames(x), pt$ID)]
  ok <- !is.na(sym) & sym != "" & rowMeans(!is.na(x)) >= min_obs
  x <- x[ok, , drop = FALSE]
  sym <- sym[ok]
  g <- rowsum(ifelse(is.na(x), 0, x), sym) /
    rowsum(ifelse(is.na(x), 0, 1), sym)
  g[!is.finite(g)] <- NA
  ra_date <- unique(s$submitted[s$disease == "rheumatoid arthritis"])
  list(x = t(g), y = as.integer(s$disease == "systemic lupus erythematosus"),
       covariates = cbind(age = as.numeric(s$age)), samples = s,
       same_batch = s$submitted %in% ra_date)
}

#' The GSE326777 replication cohort: SLE and RA neutrophils
#'
#' Reads the gene counts, keeps the SLE and RA samples named by the column
#' prefixes `NEU_SLE_` and `NEU_RA_`, computes log2 counts per million plus
#' one per sample, and keeps genes with at least `min_cpm` counts per million
#' in at least a quarter of the kept samples. Gene identifiers lose their
#' version suffix.
#'
#' @param counts_path Path to the gene counts matrix.
#' @param min_cpm Counts per million a gene must reach.
#' @return A list: `x` (samples by Ensembl identifiers), `y` (1 for SLE, 0 for
#'   RA), `covariates` (`NULL`: the records give no age or sex), `samples`,
#'   and `suffix_n` (`TRUE` for samples whose name ends in "N").
#' @export
ReadGse326777 <- function(counts_path, min_cpm = 1) {
  cnt <- utils::read.delim(gzfile(counts_path), check.names = FALSE)
  ids <- sub("\\..*$", "", cnt[[1]])
  m <- as.matrix(cnt[, -1])
  keep <- grepl("^NEU_(SLE|RA)_", colnames(m))
  m <- m[, keep, drop = FALSE]
  cpm <- sweep(m, 2, colSums(m), "/") * 1e6
  ok <- rowMeans(cpm >= min_cpm) >= 0.25 & !duplicated(ids)
  x <- t(log2(cpm[ok, , drop = FALSE] + 1))
  colnames(x) <- ids[ok]
  nm <- colnames(m)
  list(x = x, y = as.integer(grepl("^NEU_SLE_", nm)), covariates = NULL,
       samples = data.frame(name = nm, library_size = colSums(m)),
       suffix_n = grepl("N$", nm))
}

#' Features of the replication models, fitted on a training fold
#'
#' As [PilotFeatures()], for real data: missing values are filled with the
#' training fold's gene means; the IFN score is the mean of the score genes
#' standardized by the training fold; with no composition, the residual score
#' is the score itself; the gene set is the `n_genes` genes with the largest
#' training variance after regressing out the score, the score genes
#' excluded; the partial-correlation edges condition on the score.
#'
#' @param data A cohort from [ReadGse17755()] or [ReadGse326777()].
#' @param train Logical vector, `TRUE` for training samples.
#' @param score_genes Column names of the IFN score genes.
#' @param n_genes Size of the gene set.
#' @return A list with `train` and `test`, each holding `r0`, `r1`, `genes`,
#'   `quad`, `fo`, `edges`, and `pedges`; and `gene_set`.
#' @export
ReplicationFeatures <- function(data, train, score_genes, n_genes = 50) {
  x <- data$x
  mu <- colMeans(x[train, , drop = FALSE], na.rm = TRUE)
  miss <- which(is.na(x), arr.ind = TRUE)
  if (nrow(miss)) x[miss] <- mu[miss[, 2]]
  sc <- StandardizeN(x[train, score_genes, drop = FALSE])
  score <- rowMeans(StandardizeN(x[, score_genes, drop = FALSE], sc$center,
                                 sc$scale)$z)
  cov <- data$covariates
  r0 <- cbind(cov, ifn = score)
  r1 <- cbind(r0, ifn2 = score^2)
  cand <- setdiff(colnames(x), score_genes)
  xc <- x[train, cand, drop = FALSE]
  res <- qr.resid(qr(cbind(1, score[train])), xc)
  gene_set <- cand[order(-apply(res, 2, stats::var))[seq_len(n_genes)]]
  g <- x[, gene_set, drop = FALSE]
  gs <- StandardizeN(g[train, , drop = FALSE])
  z <- StandardizeN(g, gs$center, gs$scale)$z
  pairs <- PairIndex(n_genes)
  quad <- cbind(z[, pairs[, 1]] * z[, pairs[, 2]], z^2)
  r_tr <- stats::cor(g[train, , drop = FALSE])[pairs]
  r_mat <- matrix(r_tr, nrow = nrow(z), ncol = length(r_tr), byrow = TRUE)
  fo <- r_mat + z[, pairs[, 1]] * z[, pairs[, 2]] -
    r_mat / 2 * (z[, pairs[, 1]]^2 + z[, pairs[, 2]]^2)
  gtr <- g[train, , drop = FALSE]
  gte <- g[!train, , drop = FALSE]
  cond <- cbind(ifn = score)
  part <- function(rows, edges, pedges) {
    list(r0 = r0[rows, , drop = FALSE], r1 = r1[rows, , drop = FALSE],
         genes = g[rows, , drop = FALSE], quad = quad[rows, , drop = FALSE],
         fo = fo[rows, , drop = FALSE], edges = edges, pedges = pedges)
  }
  list(train = part(train, LionessEdges(gtr),
                    LionessPartialEdges(gtr, cond[train, , drop = FALSE])),
       test = part(!train, LionessTestEdges(gte, gtr),
                   LionessPartialTestEdges(gte, cond[!train, , drop = FALSE],
                                           gtr, cond[train, , drop = FALSE])),
       gene_set = gene_set)
}

#' One repeat of the replication analysis
#'
#' Stratified 5-fold cross-validation of the replication models; returns the
#' pooled out-of-fold AUC of each model and each model's AUC in each test
#' fold (for the corrected resampled tests).
#'
#' @param data A cohort from [ReadGse17755()] or [ReadGse326777()].
#' @param seed Seed of the repeat's folds.
#' @param score_genes Column names of the IFN score genes.
#' @param k Number of folds.
#' @return A list: `pooled` (named AUCs) and `folds` (a data frame of the
#'   fold AUCs of every model).
#' @export
ReplicationRepeat <- function(data, seed, score_genes, k = 5L) {
  set.seed(seed)
  y <- data$y
  folds <- StratifiedFolds(y, k)
  models <- c("R0", "R1", "E1", "E4", "E5", "F1", "N1", "N2", "N1R0")
  pred <- matrix(NA_real_, length(y), length(models),
                 dimnames = list(NULL, models))
  fold_auc <- NULL
  for (f in seq_len(k)) {
    tr <- folds != f
    ft <- ReplicationFeatures(data, tr, score_genes)
    a <- ft$train
    b <- ft$test
    ytr <- y[tr]
    en <- function(ra, pa, rb, pb) FitElasticNet(ra, pa, ytr, rb, pb)
    pred[!tr, "R0"] <- FitReference(a$r0, ytr, b$r0)
    pred[!tr, "R1"] <- FitReference(a$r1, ytr, b$r1)
    pred[!tr, "E1"] <- en(a$r1, a$genes, b$r1, b$genes)
    pred[!tr, "E4"] <- FitRda(cbind(a$genes, a$r0), ytr, cbind(b$genes, b$r0))
    pred[!tr, "E5"] <- en(a$r1, cbind(a$genes, a$quad), b$r1, cbind(b$genes, b$quad))
    pred[!tr, "F1"] <- en(a$r1, cbind(a$genes, a$fo), b$r1, cbind(b$genes, b$fo))
    pred[!tr, "N1"] <- en(a$r1, cbind(a$genes, a$edges), b$r1, cbind(b$genes, b$edges))
    pred[!tr, "N2"] <- en(a$r1, cbind(a$genes, a$pedges), b$r1, cbind(b$genes, b$pedges))
    pred[!tr, "N1R0"] <- en(a$r0, a$edges, b$r0, b$edges)
    yt <- y[!tr]
    fold_auc <- rbind(fold_auc, data.frame(
      fold = f, t(apply(pred[!tr, , drop = FALSE], 2, Auc, y = yt))))
  }
  list(pooled = apply(pred, 2, Auc, y = y), folds = fold_auc)
}

#' The two primary tests on fold differences from repeated cross-validation
#'
#' @param d1,d2 Fold differences `AUC(N1) - AUC(E1)` and `AUC(N1) - AUC(F1)`.
#' @param k Folds per repeat.
#' @param margin Equivalence margin.
#' @return A data frame: the mean of each difference, its corrected standard
#'   error `sqrt((1 / J + 1 / (k - 1)) s^2)`, the one-sided p-value of `d1`,
#'   and the 90% interval of `d2` with the equivalence decision.
#' @export
CorrectedTests <- function(d1, d2, k = 5L, margin = 0.01) {
  j <- length(d1)
  se <- function(d) sqrt((1 / j + 1 / (k - 1)) * stats::var(d))
  half <- stats::qt(0.95, j - 1) * se(d2)
  data.frame(d1 = mean(d1), d1_se = se(d1),
             d1_p_one_sided = 1 - stats::pt(mean(d1) / se(d1), j - 1),
             d2 = mean(d2), d2_se = se(d2), d2_lo90 = mean(d2) - half,
             d2_hi90 = mean(d2) + half,
             d2_equivalent = (mean(d2) - half > -margin) &&
               (mean(d2) + half < margin))
}

#' The mechanism checks of protocol section 8 on one cohort
#'
#' With all samples as the reference: for each gene pair of the gene set, the
#' correlation across samples between the exact LIONESS edge and the
#' first-order edge; and for each pair of IFN-score genes, the correlation
#' between the edge and the squared centred IFN score.
#'
#' @param data A cohort from [ReadGse17755()] or [ReadGse326777()].
#' @param score_genes Column names of the IFN score genes.
#' @param n_genes Size of the gene set.
#' @return A list: `formula_cor` (one value per pair of the gene set),
#'   `ifn_cor` (one value per pair of score genes), `gene_max_z` (each gene's
#'   largest absolute standardized value), `pair_max_z`, and
#'   `agreement_vs_max_z` (their Spearman correlation with `formula_cor`).
#' @export
MechanismChecks <- function(data, score_genes, n_genes = 50) {
  x <- data$x
  mu <- colMeans(x, na.rm = TRUE)
  miss <- which(is.na(x), arr.ind = TRUE)
  if (nrow(miss)) x[miss] <- mu[miss[, 2]]
  score <- rowMeans(StandardizeN(x[, score_genes, drop = FALSE])$z)
  cand <- setdiff(colnames(x), score_genes)
  res <- qr.resid(qr(cbind(1, score)), x[, cand, drop = FALSE])
  g <- x[, cand[order(-apply(res, 2, stats::var))[seq_len(n_genes)]],
         drop = FALSE]
  e <- LionessEdges(g)
  f <- LionessEdgesFirstOrder(g)
  formula_cor <- vapply(seq_len(ncol(e)), function(j) stats::cor(e[, j], f[, j]),
                        numeric(1))
  e_ifn <- LionessEdges(x[, score_genes, drop = FALSE])
  ifn_cor <- apply(e_ifn, 2, function(v) stats::cor(v, (score - mean(score))^2))
  # exploratory: the remainder of the first-order form grows with outlying
  # values, so the agreement is compared with each pair's largest |z|
  max_z <- apply(abs(StandardizeN(g)$z), 2, max)
  pr <- PairIndex(ncol(g))
  pair_max_z <- pmax(max_z[pr[, 1]], max_z[pr[, 2]])
  list(formula_cor = formula_cor, ifn_cor = ifn_cor, gene_max_z = max_z,
       pair_max_z = pair_max_z,
       agreement_vs_max_z = stats::cor(pair_max_z, formula_cor,
                                       method = "spearman"))
}
