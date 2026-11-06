# pilot-c/verdict.R
# Applies the pass rule of pilot-c/preregistration.md, section 2, clause by
# clause, and the combination rule, to pilot-c/results/cell_summaries.rds.
# Writes pilot-c/results/verdict.rds and pilot-c/results/auc_gains.png.
#   Rscript pilot-c/verdict.R

devtools::load_all(here::here(), quiet = TRUE)
res_dir <- here::here("pilot-c", "results")
s <- readRDS(file.path(res_dir, "cell_summaries.rds"))
design <- readRDS(file.path(res_dir, "design.rds"))
get <- function(cell, q) s[s$cell == cell & s$quantity == q, ]

# "ge": value at least threshold; "abs": |value| within max(0.01, 3 MCSE)
Judge <- function(value, mcse, threshold = NA, type = c("ge", "abs")) {
  type <- match.arg(type)
  if (type == "ge") {
    if (abs(value - threshold) <= 3 * mcse) return("close")
    return(if (value >= threshold) "pass" else "fail")
  }
  if (abs(value) <= max(0.01, 3 * mcse)) return("pass")
  if (abs(value) <= 0.01 + 3 * mcse) return("close")
  "fail"
}

rows <- list()
add <- function(question, clause, cell, quantity, g, threshold, outcome) {
  rows[[length(rows) + 1]] <<- data.frame(
    question = question, clause = clause, cell = cell, quantity = quantity,
    value = g$mean, mcse = g$mcse, threshold = threshold, outcome = outcome,
    stringsAsFactors = FALSE)
}
Combine <- function(o) {
  if (any(o == "fail")) "fail" else if (any(o == "close")) "close" else "pass"
}

# 1(a): a signal to match over E1, cell 6
g <- get(6, "d1_N1E1_vs_E1")
o1a <- Judge(g$mean, g$mcse, 0.05, "ge")
if (o1a == "pass" && g$mean <= 3 * g$mcse) o1a <- "fail"
add(1, "(a)", 6, "A(N1) - A(E1)", g, ">= 0.05 and > 3 MCSE", o1a)

# 1(b): equivalence of N1 and F1 in every cell
o1b <- character(0)
for (cl in design$cell) {
  g <- get(cl, "d2_N1E1_vs_F1E1")
  o <- Judge(g$mean, g$mcse, type = "abs")
  o1b <- c(o1b, o)
  add(1, "(b)", cl, "A(N1) - A(F1)", g,
      sprintf("|D| <= %.4f", max(0.01, 3 * g$mcse)), o)
}

# 2(a): the co-expression signal at 40 per class, cell 7
g <- get(7, "d1_N1E1_vs_E1")
o2a <- Judge(g$mean, g$mcse, 0.03, "ge")
add(2, "(a)", 7, "A(N1) - A(E1)", g, ">= 0.03", o2a)

# 2(b): the conditioned network keeps the signal, cell 6
g <- get(6, "g2_N2E1_vs_E1")
o2b <- Judge(g$mean, g$mcse, 0.05, "ge")
add(2, "(b)", 6, "A(N2) - A(E1)", g, ">= 0.05", o2b)

# 3(a): the E1 base removes the artifact, cells 2, 3, 4
o3a <- character(0)
for (cl in c(2, 3, 4)) {
  g <- get(cl, "d1_N1E1_vs_E1")
  o <- Judge(g$mean, g$mcse, type = "abs")
  o3a <- c(o3a, o)
  add(3, "(a)", cl, "A(N1) - A(E1)", g,
      sprintf("|E| <= %.4f", max(0.01, 3 * g$mcse)), o)
}

# 3(b): the same for N2
o3b <- character(0)
for (cl in c(2, 3, 4)) {
  g <- get(cl, "g2_N2E1_vs_E1")
  o <- Judge(g$mean, g$mcse, type = "abs")
  o3b <- c(o3b, o)
  add(3, "(b)", cl, "A(N2) - A(E1)", g,
      sprintf("|E| <= %.4f", max(0.01, 3 * g$mcse)), o)
}

clauses <- do.call(rbind, rows)
q <- c(q1a = o1a, q1b = Combine(o1b), q2a = o2a, q2b = o2b,
       q3a = Combine(o3a), q3b = Combine(o3b))
status <- if (any(q[c("q1a", "q1b", "q3a")] == "fail")) {
  "piloted-fail"
} else if (all(q == "pass")) {
  "piloted-pass"
} else {
  "piloted-close-call"
}
verdict <- list(clauses = clauses, status = status, reasons = q,
                date = Sys.time(),
                rule = "pilot-c/preregistration.md, sections 2 and 5")
saveRDS(verdict, file.path(res_dir, "verdict.rds"))
print(clauses, digits = 3)
cat("status:", status, "\n")

# Figure: differences by cell
lab <- with(design, ifelse(mechanism == "null", sprintf("%d null", cell),
                           sprintf("%d %s %s", cell, mechanism, level)))
lab <- paste0(lab, ifelse(design$stress == "", "", paste0(", ", design$stress)),
              sprintf(" (pi %.1f, n %d)", design$share, design$n1))
qs <- c(gain_N1R0_vs_R0 = "N1 with R0 vs R0 (the artifact)",
        d1_N1E1_vs_E1 = "N1 vs E1",
        g2_N2E1_vs_E1 = "N2 vs E1",
        gain_E5E1_vs_E1 = "E5 vs E1",
        d2_N1E1_vs_F1E1 = "N1 vs F1")
cols <- c("#B2182B", "#2166AC", "#E08214", "#1B7837", "#762A83")
png(file.path(res_dir, "auc_gains.png"), width = 2000, height = 1400, res = 220)
par(mar = c(4, 17, 1, 1))
m <- sapply(names(qs), function(q) sapply(design$cell, function(cl) get(cl, q)$mean))
e <- sapply(names(qs), function(q) sapply(design$cell, function(cl) get(cl, q)$mcse))
ypos <- rev(seq_len(nrow(design)))
plot(NA, xlim = range(c(m - 2 * e, m + 2 * e, 0)), ylim = c(0.5, nrow(design) + 0.5),
     yaxt = "n", ylab = "", xlab = "Paired AUC difference (mean, 2 MCSE bars)")
axis(2, at = ypos, labels = lab, las = 1, cex.axis = 0.72)
abline(v = 0, col = "grey50")
off <- seq(-0.32, 0.32, length.out = length(qs))
for (k in seq_along(qs)) {
  y <- ypos + off[k]
  segments(m[, k] - 2 * e[, k], y, m[, k] + 2 * e[, k], y, col = cols[k])
  points(m[, k], y, pch = 19, col = cols[k], cex = 0.65)
}
legend("topright", legend = qs, col = cols, pch = 19, cex = 0.7, bg = "white")
dev.off()
