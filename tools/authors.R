# tools/authors.R
# Sets the authors of the project, in DESCRIPTION, LICENSE, README.md, and the manuscript skeleton.
#
#   Rscript tools/authors.R --author "Given Family" [--coauthor "Given Family"]... [--email ADDRESS]
#          [--affiliation "Department, University"]
#
# Run it from the project root before the final render (stage 3, step 6) or before a memo; until
# then the four files keep the placeholders tools/init.R left. Names are given as "Given Family"
# (a one-word name is refused). --coauthor may be repeated. Rerunning replaces what an earlier run
# set. The email goes to the first author; the affiliation to every author, or the manuscript's
# affiliation slot stays a [FILL] marker, which the final render refuses.

args <- commandArgs(trailingOnly = TRUE)
usage <- "usage: Rscript tools/authors.R --author \"Given Family\" [--coauthor \"Given Family\"]... [--email ADDRESS] [--affiliation \"...\"]"
if (!file.exists("DESCRIPTION") || !file.exists("manuscript/manuscript.qmd")) {
  stop("run this from the project root (DESCRIPTION and manuscript/manuscript.qmd must be there)")
}
Values <- function(flag) { i <- which(args == flag); if (!length(i)) character(0) else args[i + 1] }
author <- Values("--author"); coauthors <- Values("--coauthor")
email <- Values("--email"); affiliation <- Values("--affiliation")
if (length(author) != 1) stop(usage)
if (length(email) > 1 || length(affiliation) > 1) stop(usage)
SplitName <- function(s) {
  p <- strsplit(trimws(s), "\\s+")[[1]]
  if (length(p) < 2) stop("give the name as \"Given Family\": ", s)
  c(given = paste(head(p, -1), collapse = " "), family = tail(p, 1))
}
people <- lapply(c(author, coauthors), SplitName)
Full <- function(p) paste(p["given"], p["family"])
names_full <- vapply(people, Full, character(1))
Esc <- function(s) gsub("\"", "\\\\\"", s)
if (!length(email)) email <- "author@example.com"

# ---- DESCRIPTION: the Authors@R block ------------------------------------------------------------
d <- readLines("DESCRIPTION", warn = FALSE)
a0 <- grep("^Authors@R:", d); nxt <- grep("^[A-Za-z@/]+:", d); a1 <- min(nxt[nxt > a0[1]]) - 1
PersonLine <- function(p, first) {
  if (first) sprintf('    person("%s", "%s", , "%s", role = c("aut", "cre"))', Esc(p["given"]), Esc(p["family"]), email)
  else sprintf('    person("%s", "%s", role = "aut")', Esc(p["given"]), Esc(p["family"]))
}
lines <- mapply(PersonLine, people, seq_along(people) == 1)
block <- if (length(people) == 1) c("Authors@R:", lines) else {
  c("Authors@R: c(", paste0(lines[-length(lines)], ","), paste0(lines[length(lines)], ")"))
}
d <- c(d[seq_len(a0[1] - 1)], block, d[seq(a1 + 1, length(d))])
writeLines(d, "DESCRIPTION")

# ---- LICENSE: the copyright holder --------------------------------------------------------------
if (file.exists("LICENSE")) {
  l <- readLines("LICENSE", warn = FALSE)
  holder <- if (length(names_full) == 1) names_full else if (length(names_full) == 2)
    paste(names_full, collapse = " and ") else
    paste0(paste(head(names_full, -1), collapse = ", "), ", and ", tail(names_full, 1))
  l <- sub("^COPYRIGHT HOLDER:.*$", paste0("COPYRIGHT HOLDER: ", holder), l)
  writeLines(l, "LICENSE")
}

# ---- README.md: the Authors line ---------------------------------------------------------------
if (file.exists("README.md")) {
  r <- readLines("README.md", warn = FALSE)
  i <- grep("^Authors: ", r)[1]
  if (!is.na(i)) {
    # keep what follows the authors on that line (the template puts "Target journal: ..." there)
    rest <- if (grepl("Target journal:", r[i], fixed = TRUE)) sub("^.*?(\\s*Target journal:.*)$", "\\1", r[i], perl = TRUE) else ""
    r[i] <- paste0("Authors: ", paste(names_full, collapse = ", "), ".", rest)
    writeLines(r, "README.md")
  }
}

# ---- the manuscript skeleton: the author block of the YAML -------------------------------------
q <- readLines("manuscript/manuscript.qmd", warn = FALSE)
y0 <- grep("^author:$", q)[1]; y1 <- grep("^date:", q)[1]
if (is.na(y0) || is.na(y1) || y1 <= y0) stop("manuscript/manuscript.qmd: no author block between 'author:' and 'date:' in the YAML")
aff <- if (length(affiliation)) Esc(affiliation) else "[FILL: affiliation]"
AuthorYaml <- function(p, first) {
  c(sprintf('  - name: "%s"', Esc(Full(p))),
    if (first) c("    corresponding: true", sprintf('    email: "%s"', email)),
    "    affiliations:", sprintf('      - name: "%s"', aff))
}
yaml <- unlist(mapply(AuthorYaml, people, seq_along(people) == 1, SIMPLIFY = FALSE))
q <- c(q[seq_len(y0)], yaml, q[seq(y1, length(q))])
writeLines(q, "manuscript/manuscript.qmd")

cat("authors set:\n  ", paste(names_full, collapse = ", "), "\n   email:", email,
    "\n   affiliation:", if (length(affiliation)) affiliation else "[FILL] (give --affiliation before the final render)",
    "\n   in DESCRIPTION, LICENSE, README.md, manuscript/manuscript.qmd\n")
