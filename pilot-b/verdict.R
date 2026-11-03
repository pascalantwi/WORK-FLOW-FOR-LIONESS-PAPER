# pilot-b/verdict.R
# Applies the pass rule of pilot-b/preregistration.md, section 2, clause by
# clause, and the combination rule, to pilot-b/results/cell_summaries.rds.
# Writes pilot-b/results/verdict.rds and pilot-b/results/auc_gains.png.
#   Rscript pilot-b/verdict.R

devtools::load_all(here::here(), quiet = TRUE)
res_dir <- here::here("pilot-b", "results")
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

# 1(a): signal to match, cell 7
g <- get(7, "gain_N1R1_vs_R1")
o1a <- Judge(g$mean, g$mcse, 0.05, "ge")
if (o1a == "pass" && g$mean <= 3 * g$mcse) o1a <- "fail"
add(1, "(a)", 7, "A(edges+R1) - A(R1)", g, ">= 0.05 and > 3 MCSE", o1a)

# 1(b): equivalence in every cell
o1b <- character(0)
for (cl in design$cell) {
  g <- get(cl, "diff_N1R1_vs_F1R1")
  o <- Judge(g$mean, g$mcse, type = "abs")
  o1b <- c(o1b, o)
  add(1, "(b)", cl, "A(edges+R1) - A(F1+R1)", g,
      sprintf("|D| <= %.4f", max(0.01, 3 * g$mcse)), o)
}

# 2(a): artifact at a large IFN difference, cell 2
g <- get(2, "gain_N1R0_vs_R0")
o2a <- Judge(g$mean, g$mcse, 0.02, "ge")
add(2, "(a)", 2, "A(edges+R0) - A(R0)", g, ">= 0.02", o2a)

# 2(b): co-expression signal at 40 per class, cell 8
g <- get(8, "gain_N1R1_vs_R1")
o2b <- Judge(g$mean, g$mcse, 0.03, "ge")
add(2, "(b)", 8, "A(edges+R1) - A(R1)", g, ">= 0.03", o2b)

# 3(a): the squared score removes the artifact, cells 2, 3, 5
o3a <- character(0)
for (cl in c(2, 3, 5)) {
  g <- get(cl, "gain_N1R1_vs_R1")
  o <- Judge(g$mean, g$mcse, type = "abs")
  o3a <- c(o3a, o)
  add(3, "(a)", cl, "A(edges+R1) - A(R1)", g,
      sprintf("|E| <= %.4f", max(0.01, 3 * g$mcse)), o)
}

# 3(b): the same with the two-gene score, cell 4
g <- get(4, "gain_N1R1_vs_R1")
o3b <- Judge(g$mean, g$mcse, type = "abs")
add(3, "(b)", 4, "A(edges+R1) - A(R1)", g,
    sprintf("|E| <= %.4f", max(0.01, 3 * g$mcse)), o3b)

clauses <- do.call(rbind, rows)
q <- c(q1a = o1a, q1b = Combine(o1b), q2a = o2a, q2b = o2b,
       q3a = Combine(o3a), q3b = o3b)
status <- if (any(q[c("q1a", "q1b", "q3a")] == "fail")) {
  "piloted-fail"
} else if (all(q == "pass")) {
  "piloted-pass"
} else {
  "piloted-close-call"
}
verdict <- list(clauses = clauses, status = status, reasons = q,
                date = Sys.time(),
                rule = "pilot-b/preregistration.md, sections 2 and 5")
saveRDS(verdict, file.path(res_dir, "verdict.rds"))
print(clauses, digits = 3)
cat("status:", status, "\n")

# Figure: differences by cell
lab <- with(design, ifelse(mechanism == "null", sprintf("%d null", cell),
                           sprintf("%d %s %s", cell, mechanism, level)))
lab <- paste0(lab, ifelse(design$stress == "", "", paste0(", ", design$stress)),
              sprintf(" (pi %.1f, n %d)", design$share, design$n1))
qs <- c(gain_N1R0_vs_R0 = "edges + R0 vs R0",
        gain_N1R1_vs_R1 = "edges + R1 vs R1",
        gain_F1R1_vs_R1 = "first-order edges + R1 vs R1",
        gain_E5_vs_R1 = "products and squares + R1 vs R1",
        diff_N1R1_vs_F1R1 = "edges vs first-order edges")
cols <- c("#B2182B", "#2166AC", "#E08214", "#1B7837", "#762A83")
png(file.path(res_dir, "auc_gains.png"), width = 2000, height = 1500, res = 220)
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
