# Helpers for pilot reports (see README.md in this folder).
# From a pilot folder: source("../templates/pilot-report/report-helpers.R")

# ---- Reading the agent's files -------------------------------------------------

# Read a markdown file for inclusion in the report. Drops the first H1 (the document
# supplies its own title) and, for the spec, turns each [TO CONFIRM: ...] marker into a
# highlighted span (the .tc style is defined in the report's YAML header).
# Use inside a chunk with results: asis, as cat(read_md_part("project-spec.md", highlight_to_confirm = TRUE), "\n").
read_md_part <- function(path, drop_title = TRUE, highlight_to_confirm = FALSE) {
  x <- readLines(path, warn = FALSE)
  if (drop_title) {
    i <- grep("^# ", x)[1]
    if (!is.na(i)) x <- x[-i]
  }
  txt <- paste(x, collapse = "\n")
  if (highlight_to_confirm) {
    txt <- gsub("\\[TO CONFIRM: ([^]]*)\\](\\{\\.tc\\})?", "[**To confirm:** \\1]{.tc}", txt)   # either marker form, no doubled class
  }
  txt
}

# ---- Known-answer table --------------------------------------------------------

# One row of the known-answer table. Every row states the setting, the known answer, what the
# simulation gave, and a reading produced by one of the three functions below, so rows are
# judged the same way.
harness_row <- function(check, setting, known, gave, reading) {
  list(check = check, setting = setting, known = known, gave = gave, reading = reading)
}

# Reading for a result with a Monte Carlo standard error: the gap in MCSE units.
# `flag` is the number of MCSE above which the gap is called too large (default 2); use the same
# threshold the pilot's own pass rule used, and say so in the report if it is not 2.
harness_reading_mcse <- function(sim, truth, mcse, thing = "the known value", extra = "", flag = 2) {
  g <- abs(sim - truth) / mcse
  sprintf("%.1f MCSE from %s, so the gap is %s.%s", g, thing,
          ifelse(g < flag, "noise", "too large: look for a bug"),
          ifelse(nzchar(extra), paste0(" ", extra), ""))
}

# One sentence counting how many rows sit beyond `flag` MCSE, for the line under the table.
# gaps is the vector of gaps in MCSE units (abs(sim - truth) / mcse), one per row that has an MCSE.
harness_flag_summary <- function(gaps, flag = 2) {
  sprintf("%d of %d rows with a standard error are more than %g MCSE from the known value.",
          sum(gaps > flag, na.rm = TRUE), sum(!is.na(gaps)), flag)
}

# Reading for a result with no standard error: the relative gap in percent.
harness_reading_pct <- function(sim, truth, thing = "the target", extra = "") {
  sprintf("%.1f%% from %s.%s", 100 * abs(sim - truth) / abs(truth), thing,
          ifelse(nzchar(extra), paste0(" ", extra), ""))
}

# Reading for a check judged against a tolerance instead of a standard error (exact identities,
# or a known answer that is itself only approximate, for example a large-N limit).
harness_reading_tol <- function(sim, truth, tol, thing = "the known value", extra = "") {
  g <- abs(sim - truth)
  sprintf("%.4g from %s, against a tolerance of %.4g, so the check %s.%s", g, thing, tol,
          ifelse(g <= tol, "passes", "fails: look for a bug"),
          ifelse(nzchar(extra), paste0(" ", extra), ""))
}

# Build the five-column known-answer table from a list of harness_row() results. Column widths are set
# by hand through the dashes in the separator row (Pandoc uses their proportions when a line is
# long), because the default sizes each column by its longest cell and one long reading squeezes
# the others. Adjust `widths` (relative; Check, Setting, Known answer, Simulation gave, How to read it).
harness_table <- function(rows, widths = c(14, 24, 22, 18, 22)) {
  df <- do.call(rbind, lapply(rows, function(r) {
    data.frame(Check = r$check, Setting = r$setting, `Known answer` = r$known,
               `Simulation gave` = r$gave, `How to read it` = r$reading,
               check.names = FALSE, stringsAsFactors = FALSE)
  }))
  out <- knitr::kable(df, row.names = FALSE, format = "pipe")
  dashes <- pmax(3, round(widths / sum(widths) * 100))
  out[2] <- paste0("|", paste(vapply(dashes, function(n) strrep("-", n), ""), collapse = "|"), "|")
  out
}

# ---- Number formatting -----------------------------------------------------------

# fmt(x, 3) gives "0.123"; fmt_range(c(a, b), 2) gives "0.12 to 0.34" (no dashes in running text).
fmt <- function(x, digits = 3) formatC(x, digits = digits, format = "f")
fmt_range <- function(x, digits = 3) paste(fmt(range(x), digits), collapse = " to ")

# ---- Design diagram ------------------------------------------------------------

# Draw the design diagram: a shared input box on the left and one lane per part of the
# pilot, read left to right (simulate, vary, estimate or test, measure, shown as).
#   input   text for the input box (use \n for paragraph breaks)
#   lanes   list of list(label, fill, sim, vary, est, meas, out); label is printed bold
#           above sim, and \n separates lines inside a box
#   harness optional list(text, out): a strip below the lanes for the known-answer checks
# Text wraps by character count, so keep each box to a few short lines. Check the figure
# by eye after rendering. Call it inside a chunk with fig-width 11 and fig-height 5.
design_diagram <- function(input, lanes, harness = NULL,
                           heads = c("Simulate", "Vary", "Estimate or test", "Measure", "Shown as"),
                           input_head = "Input") {
  op <- par(mar = c(0, 0, 0, 0)); on.exit(par(op))
  plot.new(); plot.window(xlim = c(0, 100), ylim = c(0, 100))
  cols <- list(c(14, 27), c(29, 44), c(46, 62), c(64, 83), c(85, 100))
  wrap <- c(22, 28, 27, 33, 24)
  keys <- c("sim", "vary", "est", "meas", "out")
  nx <- c(28.8, 45.8, 63.8, 84.8)

  box_txt <- function(x0, x1, y0, y1, txt, fill, wrap, bold_first = FALSE, bold = FALSE, cex = 0.72) {
    rect(x0, y0, x1, y1, col = fill, border = "grey30", lwd = 1.2)
    lines <- unlist(lapply(strsplit(txt, "\n")[[1]], function(s) strwrap(s, wrap)))
    fonts <- rep(if (bold) 2 else 1, length(lines))
    if (bold_first) fonts[1] <- 2
    yy <- (y0 + y1) / 2 + (length(lines) - 1) / 2 * 3.6 - (seq_along(lines) - 1) * 3.6
    for (i in seq_along(lines)) text((x0 + x1) / 2, yy[i], lines[i], cex = cex, font = fonts[i])
  }
  arr <- function(x0, y0, x1, y1) arrows(x0, y0, x1, y1, length = 0.07, col = "grey40", lwd = 1.2)

  for (k in seq_along(heads)) text(mean(cols[[k]]), 97, heads[k], font = 2, cex = 0.85)
  text(6, 97, input_head, font = 2, cex = 0.85)

  n <- length(lanes)
  y_top <- 92; y_bot <- if (is.null(harness)) 4 else 22; gap <- 3
  h <- (y_top - y_bot - gap * (n - 1)) / n
  for (i in seq_len(n)) {
    ln <- lanes[[i]]
    y1 <- y_top - (i - 1) * (h + gap); y0 <- y1 - h
    for (k in seq_along(keys)) {
      txt <- if (keys[k] == "sim") paste(ln$label, ln$sim, sep = "\n") else ln[[keys[k]]]
      box_txt(cols[[k]][1], cols[[k]][2], y0, y1, txt, fill = if (keys[k] == "out") "grey92" else ln$fill,
              wrap = wrap[k], bold_first = (keys[k] == "sim"), bold = (keys[k] == "out"))
    }
    yc <- (y0 + y1) / 2
    arr(12.2, yc, 13.8, yc)
    for (k in seq_along(nx)) arr(cols[[k]][2] + 0.2, yc, nx[k], yc)
  }
  box_txt(0, 12, y_bot, y_top, input, fill = "grey96", wrap = 14)
  if (!is.null(harness)) {
    box_txt(14, 83, 4, 15, harness$text, fill = "#fff8e1", wrap = 95, bold_first = TRUE)
    box_txt(85, 100, 4, 15, harness$out, fill = "grey92", wrap = 24, bold = TRUE)
    arr(83.2, 9.5, 84.8, 9.5)
  }
  invisible(NULL)
}
