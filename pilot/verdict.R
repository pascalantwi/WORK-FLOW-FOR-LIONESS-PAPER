# pilot/verdict.R
# Applies the pass rule of pilot/preregistration.md, section 2, clause by
# clause, and the combination rule, to pilot/results/cell_summaries.rds.
# Writes pilot/results/verdict.rds (the clause table and the status) and the
# figure pilot/results/auc_gains.png. Run from the project root:
#   Rscript pilot/verdict.R

devtools::load_all(here::here(), quiet = TRUE)
res_dir <- here::here("pilot", "results")
s <- readRDS(file.path(res_dir, "cell_summaries.rds"))
design <- readRDS(file.path(res_dir, "design.rds"))
get <- function(cell, q) s[s$cell == cell & s$quantity == q, ]

# outcome of one clause: "pass", "fail", or "close"
Judge <- function(value, threshold, mcse, direction = c("ge", "le_abs")) {
  direction <- match.arg(direction)
  if (direction == "ge") {
    if (abs(value - threshold) <= 3 * mcse) return("close")
    return(if (value >= threshold) "pass" else "fail")
  }
  bound <- max(0.01, 3 * mcse)
  if (abs(value) <= bound) return("pass")
  if (abs(value) <= 0.01 + 3 * mcse) return("close")
  "fail"
}

rows <- list()
add <- function(question, clause, cell, quantity, value, mcse, threshold,
                outcome) {
  rows[[length(rows) + 1]] <<- data.frame(
    question = question, clause = clause, cell = cell, quantity = quantity,
    value = value, mcse = mcse, threshold = threshold, outcome = outcome,
    stringsAsFactors = FALSE)
}

# Question 1: cell 3 (IFN only, moderate, share 0.5, n 80)
g1 <- get(3, "gain_N1R0_vs_R0")
o1 <- Judge(g1$mean, 0.05, g1$mcse, "ge")
if (o1 == "pass" && g1$mean <= 3 * g1$mcse) o1 <- "fail"
add(1, "(a)", 3, "A(N1+R0) - A(R0)", g1$mean, g1$mcse, ">= 0.05 and > 3 MCSE", o1)

# Question 2: cell 5 (IFN only, moderate, share 0.5, n 40)
g2 <- get(5, "gain_N1R0_vs_R0")
o2 <- Judge(g2$mean, 0.03, g2$mcse, "ge")
add(2, "(a)", 5, "A(N1+R0) - A(R0)", g2$mean, g2$mcse, ">= 0.03", o2)

# Question 3(a): every IFN-only and mean-shift cell
cells_3a <- design$cell[design$mechanism %in% c("ifn", "shift")]
o3a <- character(0)
for (cl in cells_3a) {
  d <- get(cl, "diff_N1R1_vs_E5")
  o <- Judge(d$mean, NA, d$mcse, "le_abs")
  o3a <- c(o3a, o)
  add(3, "(a)", cl, "A(N1+R1) - A(E5)", d$mean, d$mcse,
      sprintf("|D| <= max(0.01, 3 MCSE) = %.4f", max(0.01, 3 * d$mcse)), o)
}

# Question 3(b): cell 13 (network 0.4, share 0.5, n 80)
b <- get(13, "b_clause")
o3b <- Judge(b$mean, 0, b$mcse, "ge")
add(3, "(b)", 13, "[A(E5) - A(R1)] - 0.9 [A(N1+R1) - A(R1)]", b$mean, b$mcse,
    ">= 0", o3b)

clauses <- do.call(rbind, rows)

# Combination rule (section 2, with the readings of section 5)
q3a <- if (any(o3a == "fail")) "fail" else if (any(o3a == "close")) "close" else "pass"
status <- if (o1 == "fail" || q3a == "fail" || g2$mean < 0.01) {
  "piloted-fail"
} else if (o1 == "pass" && o2 == "pass" && q3a == "pass" && o3b == "pass") {
  "piloted-pass"
} else {
  "piloted-close-call"
}
reasons <- c(
  q1 = o1, q2 = o2, q3a = q3a, q3b = o3b,
  q2_below_001 = as.character(g2$mean < 0.01)
)
verdict <- list(clauses = clauses, status = status, reasons = reasons,
                date = Sys.time(),
                rule = "pilot/preregistration.md, sections 2 and 5")
saveRDS(verdict, file.path(res_dir, "verdict.rds"))
print(clauses, digits = 3)
cat("status:", status, "\n")

# Figure: gains by cell
lab <- with(design, ifelse(mechanism == "null", sprintf("%d null", cell),
                           sprintf("%d %s %s", cell, mechanism, level)))
lab <- paste0(lab, sprintf(" (pi %.1f, n %d)", design$share, design$n1))
qs <- c(gain_N1R0_vs_R0 = "edges + R0 vs R0",
        gain_N1R1_vs_R1 = "edges + R1 vs R1",
        gain_E5_vs_R1 = "matched quadratic vs R1",
        diff_N1R1_vs_E5 = "edges + R1 vs matched quadratic")
cols <- c("#B2182B", "#2166AC", "#1B7837", "#762A83")
png(file.path(res_dir, "auc_gains.png"), width = 2000, height = 1500, res = 220)
par(mar = c(4, 15, 1, 1))
m <- sapply(names(qs), function(q) sapply(design$cell, function(cl) get(cl, q)$mean))
e <- sapply(names(qs), function(q) sapply(design$cell, function(cl) get(cl, q)$mcse))
ypos <- rev(seq_len(nrow(design)))
plot(NA, xlim = range(c(m - 2 * e, m + 2 * e, 0)), ylim = c(0.5, nrow(design) + 0.5),
     yaxt = "n", ylab = "", xlab = "Paired AUC difference (mean, 2 MCSE bars)")
axis(2, at = ypos, labels = lab, las = 1, cex.axis = 0.75)
abline(v = 0, col = "grey50")
off <- c(-0.27, -0.09, 0.09, 0.27)
for (k in seq_along(qs)) {
  y <- ypos + off[k]
  segments(m[, k] - 2 * e[, k], y, m[, k] + 2 * e[, k], y, col = cols[k])
  points(m[, k], y, pch = 19, col = cols[k], cex = 0.7)
}
legend("bottomright", legend = qs, col = cols, pch = 19, cex = 0.7, bg = "white")
dev.off()
