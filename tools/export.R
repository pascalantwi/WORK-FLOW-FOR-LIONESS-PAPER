# tools/export.R
# Builds the clean publication copy of the project (stage 8).
#
#   Rscript tools/export.R [<target-dir>] [--allow-dirty]
#
# It copies the tracked files of the compendium (the R package, the analysis
# scripts, data, results, the manuscript, and the R and Python environments)
# into <target-dir>, by default ../<package>-publication, and leaves out the
# workflow's files: the idea, proposal, spec, status, workflow/, templates/,
# tools/, log/, the pilots, background/, review/, slides/, and poster/. It
# writes a new README.md and .Rbuildignore there and prints a manifest. Run it
# from the project root with everything committed, or pass --allow-dirty to
# export the tracked files as they stand in the working tree.

usage <- "usage: Rscript tools/export.R [<target-dir>] [--allow-dirty]"
args <- commandArgs(trailingOnly = TRUE)
is_flag <- grepl("^--", args)
if (!all(args[is_flag] == "--allow-dirty") || sum(!is_flag) > 1) stop(usage)
allow_dirty <- "--allow-dirty" %in% args

root <- normalizePath(".")
if (!file.exists(file.path(root, "DESCRIPTION")) ||
    !file.exists(file.path(root, ".git"))) {
  stop("run this from the project root (DESCRIPTION and .git must be there)")
}
desc <- read.dcf(file.path(root, "DESCRIPTION"))[1, ]
for (field in c("Package", "Title", "Description")) {
  if (is.na(desc[field])) stop("DESCRIPTION has no ", field, " field")
}

# Absolute path, resolved through the deepest part that already exists.
AbsolutePath <- function(path) {
  path <- path.expand(path)
  if (!grepl("^(/|[A-Za-z]:)", path)) path <- file.path(root, path)
  rest <- character(0)
  while (!file.exists(path)) {
    rest <- c(basename(path), rest)
    path <- dirname(path)
  }
  do.call(file.path, as.list(c(normalizePath(path), rest)))
}
target <- if (any(!is_flag)) args[!is_flag] else
  file.path("..", paste0(desc[["Package"]], "-publication"))
target <- AbsolutePath(target)
if (target == root || startsWith(target, paste0(root, "/"))) {
  stop("the target must be outside the project root: ", target)
}
if (file.exists(target) && (!dir.exists(target) ||
    length(list.files(target, all.files = TRUE, no.. = TRUE)) > 0)) {
  stop("the target exists and is not empty: ", target)
}

# Runs git in the project root and stops if it fails.
Git <- function(...) {
  out <- suppressWarnings(
    system2("git", c("-c", "core.quotepath=off", ...), stdout = TRUE))
  if (!is.null(attr(out, "status"))) {
    stop("git ", paste(c(...), collapse = " "), " failed in ", root)
  }
  out
}
dirty <- Git("status", "--porcelain")
if (length(dirty) > 0 && !allow_dirty) {
  stop("uncommitted changes; commit them, or pass --allow-dirty:\n",
       paste0("  ", dirty, collapse = "\n"))
}
commit <- Git("rev-parse", "--short", "HEAD")

# ---- select: tracked files only, so no ignored replicates or scratch --------
tracked <- Git("ls-files")
tracked <- tracked[file_test("-f", tracked)]  # a deleted file in a dirty tree
root_files <- c("DESCRIPTION", "NAMESPACE", "LICENSE", ".Rprofile",
                ".gitignore", "renv.lock", "renv/activate.R",
                "renv/settings.json", "renv/.gitignore", "pyproject.toml",
                "uv.lock", ".python-version", "protocol.md")
folders <- c("R", "man", "tests", "inst", "analysis", "data", "results")
workflow_in_manuscript <- c("citations.csv", "check-manuscript.py",
                            "build-bib.py", "reference-fixes.md", "journals.csv",
                            "drafting-log.md")
top <- ifelse(grepl("/", tracked), sub("/.*$", "", tracked), "")
keep <- tracked %in% root_files | top %in% folders |
  (top == "manuscript" & !basename(tracked) %in% workflow_in_manuscript)
copied <- tracked[keep]

# ---- copy -------------------------------------------------------------------
dir.create(target, recursive = TRUE, showWarnings = FALSE)
for (d in unique(file.path(target, dirname(copied)))) {
  dir.create(d, recursive = TRUE, showWarnings = FALSE)
}
ok <- file.copy(copied, file.path(target, copied), copy.date = TRUE)
if (!all(ok)) stop("could not copy: ", paste(copied[!ok], collapse = ", "))

writeLines(c("^analysis$", "^data$", "^results$", "^manuscript$", "^renv$",
             "^renv\\.lock$", "^\\.Rprofile$", "^\\.venv$",
             "^pyproject\\.toml$", "^uv\\.lock$", "^\\.python-version$",
             "__pycache__", "^\\.pytest_cache$", "^protocol\\.md$"),
           file.path(target, ".Rbuildignore"))

# ---- README.md --------------------------------------------------------------
OneLine <- function(s) gsub("\\s+", " ", trimws(s))
authors <- if (!is.na(desc["Authors@R"])) {
  people <- eval(parse(text = desc[["Authors@R"]]))
  paste(format(people, include = c("given", "family")), collapse = ", ")
} else {
  OneLine(desc[["Author"]])
}

# Analysis scripts in sorted order; a Python script runs through uv.
has_python <- "pyproject.toml" %in% copied
scripts <- grep("^analysis/[^/]+\\.([Rr]|py)$", copied, value = TRUE)
scripts <- sort(scripts, method = "radix")
runner <- ifelse(grepl("\\.py$", scripts), "uv run", "Rscript")
reproduce <- c("Rscript -e 'renv::restore()'", if (has_python) "uv sync",
               paste(runner, scripts),
               "quarto render manuscript/manuscript.qmd -P draft:false")
tests <- if (has_python) {
  paste("`devtools::test()` in R runs the R tests, and `uv run pytest` runs",
        "the Python tests.")
} else {
  "`devtools::test()` in R runs the tests."
}

# The project README's Data section, verbatim; a heading inside a fenced
# block does not count.
readme <- if (file.exists("README.md")) readLines("README.md", warn = FALSE)
in_fence <- cumsum(grepl("^\\s*(```|~~~)", readme)) %% 2 == 1
h2 <- which(grepl("^## ", readme) & !in_fence)
start <- h2[grepl("^##\\s+Data\\s*$", readme[h2])][1]
if (is.na(start)) {
  data_section <- c("## Data", "",
                    "No data section was found in the project README.")
} else {
  end <- c(h2[h2 > start], length(readme) + 1)[1] - 1
  data_section <- readme[start:end]
  while (!nzchar(trimws(data_section[length(data_section)]))) {
    data_section <- data_section[-length(data_section)]
  }
}

stamp <- paste0("Exported from the project repository at commit ", commit,
                if (length(dirty) > 0) ", with uncommitted changes,",
                " on ", format(Sys.Date(), "%Y-%m-%d"), " by tools/export.R.")
writeLines(c(paste("#", OneLine(desc[["Title"]])), "",
             paste0("Authors: ", authors, "."), "",
             OneLine(desc[["Description"]]), "",
             "## Reproduce", "", "From the project root, in order:", "",
             "```bash", reproduce, "```", "", tests, "",
             data_section, "", stamp),
           file.path(target, "README.md"))

# ---- manifest ---------------------------------------------------------------
where <- ifelse(grepl("/", copied), paste0(sub("/.*$", "", copied), "/"),
                "(root)")
counts <- table(where)
counts <- counts[order(names(counts) != "(root)", names(counts))]
cat("exported to ", target, "\n", sep = "")
cat(sprintf("  %-14s %4d\n", names(counts), as.integer(counts)), sep = "")
cat(sprintf("  %-14s %4d\n", "total copied", length(copied)))
cat("  written: README.md, .Rbuildignore\n")
cat(sprintf("  excluded: %d tracked files\n", sum(!keep)))
