# Helpers for the manuscript (the manual is workflow/03-manuscript.md).
# From manuscript.qmd: source("manuscript-helpers.R")
#
# The rules these helpers enforce:
#   - every number in the text comes through prov(), which labels it with the run that
#     produced it (pilot, quick, or production), read from results/run_info.rds;
#   - in draft mode a pilot or quick number renders highlighted; in final mode anything
#     but production is an error; in memo mode (the memo of a study not carried further)
#     any label renders without a mark and markers are errors;
#   - the draft banner, the gap table, and the marker table are apparatus, wrapped in a
#     fenced div with class "apparatus", which the checker ignores and final mode drops.

.ms <- new.env(parent = emptyenv())
.ms$draft <- TRUE
.ms$memo <- FALSE
.ms$run_info <- NULL
.ms$prov <- list()
.ms$gap <- list()

# ---- the project root --------------------------------------------------------------------
# here::here() when the package is installed; otherwise the nearest ancestor directory that
# holds DESCRIPTION, which the compendium's root always does.
project_root <- function(start = getwd()) {
  if (requireNamespace("here", quietly = TRUE)) return(here::here())
  d <- normalizePath(start)
  repeat {
    if (file.exists(file.path(d, "DESCRIPTION"))) return(d)
    up <- dirname(d); if (identical(up, d)) stop("no project root found above ", start, " (a directory holding DESCRIPTION)")
    d <- up
  }
}
results_path <- function(...) file.path(project_root(), "results", ...)
# A pilot's results, for memo mode: pilot_path("run_info.rds"), pilot_path("cells.rds", folder = "pilot-b").
pilot_path <- function(..., folder = "pilot") file.path(project_root(), folder, "results", ...)

# ---- modes and run information --------------------------------------------------------

# Three render modes: draft (marks and apparatus), final (production numbers only, no markers), and
# memo (a pilot's numbers without marks, no markers, no apparatus).
prov_set_mode <- function(draft = TRUE, memo = FALSE) {
  .ms$memo <- isTRUE(memo)
  .ms$draft <- isTRUE(draft) && !.ms$memo
  invisible(prov_mode_name())
}
prov_mode <- function() .ms$draft
prov_memo <- function() .ms$memo
prov_mode_name <- function() if (.ms$memo) "memo" else if (.ms$draft) "draft" else "final"

# results/run_info.rds is written by every analysis script:
#   saveRDS(list(run = "quick", n_rep = 100, n_cells = 48, date = Sys.Date(),
#                note = "full design, replicate count set by runtime"),
#           here::here("results", "run_info.rds"))
# A Python script writes the same fields to results/run_info.json instead.
read_run_info <- function(path = results_path("run_info.rds")) {
  json <- sub("\\.rds$", ".json", path)
  if (!file.exists(path) && file.exists(json)) path <- json
  if (!file.exists(path)) {
    if (isTRUE(prov_mode())) {   # a draft may render before any script has run: the banner says so
      message("results/run_info.rds is missing: no analysis script has run yet; the draft renders with run = \"none\".")
      .ms$run_info <- list(run = "none", note = "no analysis script has run yet")
      return(invisible(.ms$run_info))
    }
    stop("results/run_info.rds is missing. Every analysis script writes it, for example ",
         "saveRDS(list(run = \"quick\", n_rep = 100, n_cells = 48, date = Sys.Date(), note = \"\"), ",
         "here::here(\"results\", \"run_info.rds\")). Run the scripts in analysis/ first.")
  }
  ri <- if (grepl("\\.json$", path)) jsonlite::fromJSON(path) else readRDS(path)
  if (!is.list(ri) || is.null(ri$run) || !ri$run %in% c("pilot", "quick", "production")) {
    stop("results/run_info.rds must be a list with run = \"pilot\", \"quick\", or \"production\".")
  }
  .ms$run_info <- ri
  invisible(ri)
}
run_info <- function() { if (is.null(.ms$run_info)) read_run_info(); .ms$run_info }

# ---- reading results -------------------------------------------------------------------

read_results <- function(name, dir = results_path()) {
  path <- file.path(dir, name)
  if (!file.exists(path)) stop("results file missing: ", path, ". Run the scripts in analysis/ first.")
  if (grepl("\\.rds$", name)) readRDS(path)
  else if (grepl("\\.json$", name)) jsonlite::fromJSON(path)
  else if (grepl("\\.csv$", name)) utils::read.csv(path, stringsAsFactors = FALSE)
  else readLines(path, warn = FALSE)
}
results_exist <- function(name, dir = results_path()) file.exists(file.path(dir, name))

# ---- number formatting -----------------------------------------------------------------

fmt <- function(x, digits = 3) formatC(x, digits = digits, format = "f")
# A design level (a factor's value, a sample size, a nominal level): formatted, never highlighted,
# so that no digit is typed in the prose and the checker can tell a level from a result.
lvl <- function(x, digits = NULL) {
  if (is.character(x)) return(x)
  if (is.null(digits)) digits <- if (all(x == round(x))) 0 else 2
  formatC(x, digits = digits, format = "f", big.mark = ",")
}
# A range with its Monte Carlo error reported once: "0.035 to 0.057 (MCSE at most 0.007)".
range_mcse <- function(est, se, digits = 3, se_digits = 3) sprintf("%s (MCSE at most %s)", fmt_range(est, digits), fmt(max(se), se_digits))
fmt_range <- function(x, digits = 3) paste(fmt(range(x), digits), collapse = " to ")
mcse <- function(est, se, digits = 3, se_digits = 4) sprintf("%s (MCSE %s)", fmt(est, digits), fmt(se, se_digits))

# ---- prov(): the only way a number enters the text ---------------------------------------
# prov(x)                 formats x with `digits` and labels it with run_info()$run
# prov(x, run = "pilot")  for a number from a results file of another run
# prov(text = "0.12 to 0.34")  for a string already formatted (fmt_range, mcse)
prov <- function(x = NULL, digits = 3, run = NULL, text = NULL) {
  run <- if (is.null(run)) run_info()$run else match.arg(run, c("pilot", "quick", "production"))
  s <- if (!is.null(text)) text else if (is.character(x)) x else fmt(x, digits)
  .ms$prov[[length(.ms$prov) + 1]] <- list(run = run, value = s)
  if (!.ms$draft) {
    if (!.ms$memo && run != "production") {
      stop("final mode: a number labeled '", run, "' is in the text (", s, "). ",
           "Run the production study, or render in draft mode.")
    }
    return(s)   # final and memo modes: no mark
  }
  if (run == "production") return(s)
  sprintf("[%s]{.prov-%s}", s, run)
}
prov_counts <- function() {
  r <- vapply(.ms$prov, function(p) p$run, character(1))
  table(factor(r, levels = c("pilot", "quick", "production")))
}

# ---- tables with hand-set column widths ---------------------------------------------------
# Pandoc applies the proportions of the separator row only when a line is longer than the
# page width; set widths in proportion to the text in each column.
kable_w <- function(df, widths, ...) {
  out <- knitr::kable(df, format = "pipe", row.names = FALSE, ...)
  dashes <- pmax(3, round(widths / sum(widths) * 100))
  out[2] <- paste0("|", paste(vapply(dashes, function(n) strrep("-", n), ""), collapse = "|"), "|")
  out
}
# Factor, Levels, Reason
design_table <- function(df, widths = c(18, 32, 50), ...) kable_w(df, widths, ...)
# Element, Prior literature, This paper
novelty_table <- function(df, widths = c(22, 39, 39), ...) kable_w(df, widths, ...)

# ---- journals ----------------------------------------------------------------------------
# One row of the journal guide's CSV, workflow/journals/journals.csv, which the checker also reads.
journal_profile <- function(slug, csv = file.path(project_root(), "workflow", "journals", "journals.csv")) {
  if (!file.exists(csv)) stop("journals.csv not found at ", csv)
  j <- utils::read.csv(csv, stringsAsFactors = FALSE)
  row <- j[j$slug == slug, ]
  if (nrow(row) != 1) stop("no journal with slug '", slug, "' in ", csv)
  as.list(row)
}

# ---- markers and the drafting log -----------------------------------------------------
# Markers are spans: [TO CONFIRM: ...]{.tc}, [CITE: ...]{.cite}; [FILL: ...] only in the skeleton.
# Every line of the qmd counts (YAML, prose, and R chunks, since a marker in a chunk's string renders too),
# plus every file brought in by {{< include >}}. The checker counts the same way, so the two agree.
marker_scan <- function(qmd = "manuscript.qmd") {
  x <- readLines(qmd, warn = FALSE)
  inc <- regmatches(x, regexpr("\\{\\{<\\s*include\\s+[^>]+>\\}\\}", x))
  for (f in trimws(sub("\\{\\{<\\s*include\\s+([^>]+?)\\s*>\\}\\}", "\\1", inc))) {
    if (file.exists(file.path(dirname(qmd), f))) x <- c(x, paste0("# (included: ", f, ")"), readLines(file.path(dirname(qmd), f), warn = FALSE))
  }
  x <- strsplit(gsub("(?s)<!--.*?-->", "", paste(x, collapse = "\n"), perl = TRUE), "\n")[[1]]   # instruction comments do not count
  section <- "(front matter)"
  out <- list()
  for (line in x) {
    if (grepl("^#+ ", line)) section <- sub("^#+ ", "", sub("\\s*\\{[^}]*\\}\\s*$", "", line))
    m <- regmatches(line, gregexpr("\\[(TO CONFIRM|CITE|FILL)[^]]*\\]", line))[[1]]
    for (mm in m) out[[length(out) + 1]] <- data.frame(kind = sub("^\\[(TO CONFIRM|CITE|FILL).*", "\\1", mm),
                                                        text = sub("^\\[(TO CONFIRM|CITE|FILL):?\\s*", "", sub("\\]$", "", mm)),
                                                        section = section, stringsAsFactors = FALSE)
  }
  if (!length(out)) return(data.frame(kind = character(0), text = character(0), section = character(0)))
  do.call(rbind, out)
}
check_no_markers <- function(qmd = "manuscript.qmd") {
  m <- marker_scan(qmd)
  if (nrow(m)) stop("final or memo mode: ", nrow(m), " marker(s) remain in ", qmd, " (", paste(unique(m$kind), collapse = ", "), ").")
  invisible(TRUE)
}
# Memo mode: the one-paragraph note that opens the memo, part of the document (not apparatus).
memo_note <- function() {
  ri <- run_info()
  sprintf("This memo reports a study that was not carried further. Its numbers come from a simulation of %s replicates per cell over %s cells%s.",
          if (is.null(ri$n_rep)) "an unstated number of" else format(ri$n_rep, big.mark = ","),
          if (is.null(ri$n_cells)) "an unstated number of" else format(ri$n_cells, big.mark = ","),
          if (is.null(ri$date)) "" else paste0(", run on ", format(ri$date)))
}
# The drafting log is the stage 3 log, log/03-manuscript.md at the project root.
drafting_log <- function() file.path(project_root(), "log", "03-manuscript.md")
# The log's opening paragraph: the first non-empty line after the title that is not a heading.
log_status <- function(path = drafting_log()) {
  if (!file.exists(path)) return(character(0))
  x <- readLines(path, warn = FALSE)
  x <- x[-grep("^# ", x)[1]]
  x <- x[nzchar(trimws(x)) & !grepl("^#", x)]
  if (length(x)) x[1] else character(0)
}
log_section <- function(path = drafting_log(), heading = "Paper test") {
  if (!file.exists(path)) return(character(0))
  x <- readLines(path, warn = FALSE)
  a <- grep(paste0("^## ", heading, "\\s*$"), x)
  if (!length(a)) return(character(0))
  b <- grep("^## ", x); b <- b[b > a[1]]
  x[(a[1] + 1):(if (length(b)) b[1] - 1 else length(x))]
}

# ---- apparatus: banner, gap table, marker table -------------------------------------------
# Each returns markdown inside a fenced div with class "apparatus"; print with cat() in a
# chunk that has results: asis and eval: !expr params$draft.
# c(...) then collapse: a vector argument (the paper-test lines) must not repeat the div once per element.
.apparatus <- function(...) paste0("\n::: {.apparatus}\n\n", paste(c(...), collapse = "\n"), "\n\n:::\n\n")

draft_banner <- function(log = drafting_log(), qmd = "manuscript.qmd") {
  ri <- run_info()
  m <- marker_scan(qmd)
  counts <- table(factor(m$kind, levels = c("TO CONFIRM", "CITE", "FILL")))
  status <- log_status(log)
  paste0(.apparatus(
    "**Draft.** This rendering is a draft: its numbers come from the run labeled below and will be replaced by the production run; highlighted numbers and markers are apparatus and are stripped in final mode.",
    "",
    sprintf("- Run: **%s**, %s replicates per cell over %s cells, %s%s.", ri$run,
            if (is.null(ri$n_rep)) "an unstated number of" else ri$n_rep,
            if (is.null(ri$n_cells)) "an unstated number of" else ri$n_cells,
            if (is.null(ri$date)) "undated" else format(ri$date),
            if (!is.null(ri$note) && nzchar(ri$note)) paste0("; ", ri$note) else ""),
    sprintf("- Markers: %d to confirm, %d claims without a usable source, %d unfilled slots (listed at the end).", counts[["TO CONFIRM"]], counts[["CITE"]], counts[["FILL"]]),
    "",
    if (length(status)) c("**Status** (the drafting log's opening line):", "", status, "", "The seven paper-test answers are in the drafting log.") else "**Status:** the drafting log has no opening status line yet."
  ))
}

# Register each figure or table in its chunk: gap_register("fig-bias", "mean edge difference by control fraction", cells = 10, n_rep = ri$n_rep)
# The production column is built from run_info()$n_rep_production when the run file carries it; pass production = "..." to override.
gap_register <- function(label, what, cells = NA, n_rep = NA, run = NULL, production = "", mcse_note = "") {
  if (!nzchar(production) && !is.null(run_info()$n_rep_production)) {   # the production column from the run file
    production <- paste0(format(cells, big.mark = ","), " cells, ", format(run_info()$n_rep_production, big.mark = ","), " replicates")
  }
  run <- if (is.null(run)) run_info()$run else run
  .ms$gap[[label]] <- data.frame(Output = label, `What it shows` = what, Run = run,
                                 `Cells and replicates now` = paste(cells, "cells,", n_rep, "replicates"),
                                 `Production run` = production, `Monte Carlo error` = mcse_note,
                                 check.names = FALSE, stringsAsFactors = FALSE)
  invisible(NULL)
}
gap_table <- function(widths = c(12, 28, 10, 18, 18, 14)) {
  if (!length(.ms$gap)) return(.apparatus("**Gap table.** No figure or table has been registered with `gap_register()` yet."))
  df <- do.call(rbind, .ms$gap)
  paste0(.apparatus("**Gap table.** One row per figure or table: the run and size behind it now, against the production run that replaces it.", "",
                    paste(kable_w(df, widths), collapse = "\n")))
}
marker_table <- function(qmd = "manuscript.qmd", widths = c(14, 60, 26)) {
  m <- marker_scan(qmd)
  if (!nrow(m)) return(.apparatus("**Markers.** None remain."))
  names(m) <- c("Marker", "Text", "Section")
  paste0(.apparatus("**Markers.** Every decision still open and every claim without a usable source, with its section.", "",
                    paste(kable_w(m, widths), collapse = "\n")))
}
