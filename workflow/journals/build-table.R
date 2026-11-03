# Builds journals.csv and the summary table in README.md from the profiles.
#
# Each profile in profiles/ ends with a "Table row" block of key: value lines.
# This script reads those blocks, adds the CSL file named in each profile's
# "File to use in Quarto" line, writes journals.csv (one row per journal), and
# writes the Markdown summary table to summary-table.md, which is pasted into
# README.md between the "summary table" markers.
#
# Run from anywhere:  Rscript workflow/journals/build-table.R

args <- commandArgs(trailingOnly = FALSE)
here <- dirname(normalizePath(sub("^--file=", "", args[grep("^--file=", args)])))
files <- sort(list.files(file.path(here, "profiles"), pattern = "\\.md$", full.names = TRUE))

keys <- c("scope_5_words", "audience", "fit_critique", "fit_sim_diagnostic",
          "fit_constructive", "fit_short_note", "fit_theory", "fit_applied",
          "abstract_format",
          "abstract_words", "length_limit", "apc", "oa_model",
          "ai_policy_3_words", "review_model", "guidelines_read")

read_profile <- function(f) {
  x <- readLines(f, warn = FALSE, encoding = "UTF-8")
  journal <- sub("^# ", "", x[grep("^# ", x)[1]])
  pub <- grep("^\\| Publisher \\|", x, value = TRUE)[1]
  publisher <- trimws(sub("\\|\\s*$", "", sub("^\\| Publisher \\|", "", pub)))
  publisher <- trimws(gsub("\\s*\\[[0-9, ]+\\]", "", publisher))
  start <- grep("^## Table row", x)
  block <- x[start:length(x)]
  vals <- vapply(keys, function(k) {
    line <- grep(paste0("^", k, ": "), block, value = TRUE)[1]
    if (is.na(line)) stop("missing key ", k, " in ", basename(f))
    sub(paste0("^", k, ": "), "", line)
  }, character(1))
  use <- grep("^- File to use in Quarto:", x, value = TRUE)[1]
  csl <- regmatches(use, regexpr("`csl/[^`]+`", use))
  csl <- if (length(csl)) gsub("`", "", csl) else "none"
  slug <- sub("\\.md$", "", basename(f))
  c(slug = slug, journal = journal, publisher = publisher, vals,
    csl_file = csl, profile = file.path("profiles", basename(f)))
}

tab <- as.data.frame(do.call(rbind, lapply(files, read_profile)), stringsAsFactors = FALSE)
write.csv(tab, file.path(here, "journals.csv"), row.names = FALSE, fileEncoding = "UTF-8")

# The summary table, grouped by audience so that step 1 of the choosing
# procedure reads straight off it.
ord <- c("genomics users", "both", "general science", "methodologists")
tab$aud_rank <- match(tab$audience, ord)
tab <- tab[order(tab$aud_rank, tolower(tab$journal)), ]
cell <- function(v) gsub("\\|", "/", v)
lines <- c(
  "| Journal | Scope in five words | Audience | Critique | Simulation and diagnostic | Constructive method | Short note | Theory | Applied | Abstract | Length | Charge to publish | AI policy | Guidelines read |",
  "|--------------|----------|-------|-----|-----|-----|-----|-----|-----|--------------|-------------|----------|-------|-----|"
)
for (i in seq_len(nrow(tab))) {
  r <- tab[i, ]
  abs <- if (r$abstract_words %in% c("not stated", "could not be read")) r$abstract_format else
    paste0(r$abstract_format, "; words: ", r$abstract_words)
  lines <- c(lines, paste0(
    "| [", r$journal, "](", r$profile, ") | ", cell(r$scope_5_words), " | ", r$audience, " | ",
    r$fit_critique, " | ", r$fit_sim_diagnostic, " | ", r$fit_constructive, " | ",
    r$fit_short_note, " | ",
    r$fit_theory, " | ", r$fit_applied, " | ", cell(abs), " | ", cell(r$length_limit), " | ",
    cell(r$apc), " | ", cell(r$ai_policy_3_words), " | ", r$guidelines_read, " |"))
}
writeLines(lines, file.path(here, "summary-table.md"), useBytes = TRUE)
cat("Wrote journals.csv and summary-table.md for", nrow(tab), "journals\n")
