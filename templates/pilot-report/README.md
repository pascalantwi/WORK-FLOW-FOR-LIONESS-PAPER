# Pilot report template

This is the template for the pilot report of stage 2 (`workflow/02-pilot.md`). The report is written in `pilot/` (or `pilot-b/` for a re-pilot), with the template here in `templates/pilot-report/` and the spec, `project-spec.md`, at the project root.

A review report for one pilot: the idea, the model, the design, the results, the full draft spec, and the decisions log, in one self-contained HTML file. It is for the user reviewing the pilot and for the reader reading the project cold.

## Files

| File | What it is |
|-----|--------------------------------------------|
| `pilot-report-template.qmd` | The skeleton: every section, with `[FILL: ...]` slots and instructions in HTML comments |
| `report-helpers.R` | `read_md_part()` (spec and decisions, with `[TO CONFIRM]` highlighting), `design_diagram()`, `harness_row()`, `harness_table()`, the three known-answer readings, and the flag summary |
| `parts/critique-intro.md` | Standard opening paragraph for "Critiquing the model" |
| `parts/known-answer-intro.md` | Standard opening paragraphs for "Known-answer checks" |
| `parts/how-to-read-outputs.md` | Standard "How to read the outputs" text (four steps; bias, level, power; Monte Carlo error) |
| `parts/standard-footnotes.md` | Footnote definitions for terms every report may use: pilot, the pilot statuses, the agent, conditional draft, known-answer check, closed form, stress case, doublet, annotation. Unused definitions are dropped by Pandoc |
| `check-report.py` | Checks a rendered report against the rules below |

## Steps

1. Copy `pilot-report-template.qmd` into the pilot folder as `pilot-report.qmd`. The pilot folder holds `decisions.md` and the saved result files (in `results/`); `project-spec.md` is at the project root, one level up.
   Copy `manuscript/.Rprofile` to the pilot folder as `.Rprofile` if it is not there, so that Quarto's R finds the project library. Write the sections that describe the idea, the data, and the design during the run if you like; write the Summary, the findings, and "Potential impact" after the verdict, because they state what the pilot decided.
2. Fill the sections in order. Each section's requirements are below. Write the per-pilot figures in the qmd itself, reading the saved result files in the setup chunk.
3. Render with `quarto render pilot-report.qmd`.
4. Run `python3 -I ../templates/pilot-report/check-report.py pilot-report.qmd pilot-report.html`. Fix every ERROR and read every WARN.
5. Open the HTML and look at it. The checker cannot see a crowded figure or a badly wrapped table.

Reuse the standard parts as they are. If a pilot needs different wording, replace the include with edited text in that pilot's qmd and leave the shared part alone.

## What each section must contain

**Summary.** Scope (what the document is and what it was built from), Status (the status, in a sentence, with the pilot and status footnotes), a three-row table of the pilot's three questions (answer in a few words, evidence with numbers computed at render time), and what needs the user's decision.

**In plain language.** No formulas. One concrete example with small numbers. What is computed, where the problem comes from, when it matters. The user reads this section first, so it has to stand alone. Write it by the wording rules below: say concretely what is known and unknown, name the quantity being judged, and footnote every named method, distance, score, or package.

**Potential impact.** 250 to 450 words of prose, after "In plain language" and before the Application. Four things in order: how the project fits with the existing literature (what is known, what the closest prior work does, what is new here, citing only sources opened for this report); the problem it addresses (the procedure, who uses it, what goes wrong); why it matters (what a user would do differently); and what impact it could have (which published results or workflows change, in which fields). Then point explicitly at the pilot results that show impact, by cross-reference to the figure or table and with the number computed at render time (a gain in power, a restored level, a bias removed, a diagnostic that separates the cases). If no pilot output shows impact directly, name the analysis in the spec that will show it, concretely.

**Application: the study behind the data.** About 500 words of prose (up to about 650 when the citation, a table, and footnotes need the room), three subsections. State only what you verified in a source you opened, and say plainly which dataset the spec proposes when it could not be confirmed.
- *The study:* full citation with DOI, who was sampled, sample sizes, the findings relevant to the project, and where the open copy of the data lives. The cohort or dataset table goes here, with a caption.
- *Why [the estimand]:* why the quantity matters, with the plain-language sentence revisited, the estimand named, and the proposed analysis.
- *Did the original study compute it?* One paragraph, no table. Say yes, partly, or no, where in the paper, what it did not do, and why the question here is new.

There is no separate "why the data suit this project" section. Do not write callouts about uncertainty: the user verifies every claim.

**In symbols.** The first sentence maps each word to the notation it defines, in parentheses. Display equations put one clause on each line, separated by `\\`. A symbol table follows (widths set by hand), then the target quantity versus the computable quantity, and the key result in words. Include one figure of the problem on made-up numbers (labelled as an illustration, not pilot output) and one from the real data.

**Critiquing the model.** The standard intro, then a three-column table of six to nine rows: *Feature of the model* (named with its symbols), *Why it may not be realistic* (tied back to the formulas), *What should be done to check it* (actions). Never say what the pilot did; the reader finds that out later in Methods and Results. Always include a row for the parameter values that are not known and rows for structural simplifications. Footnote any technique a reader may not know (for example the delta method) at its first use.

**Methods.** *Design:* a paragraph, the design diagram (`design_diagram()`; at least one lane per part of the pilot, plus the known-answer strip), a table of parts, factors, and replicates, and definitions of the scenarios. The diagram's caption cross-references each output so a reader can go from a design row to the figure or table it produced. *Known-answer checks:* the standard intro, then `harness_table()` with a known answer and a computed reading on every row.

**Results.** The standard "How to read the outputs" text, then for every figure and table a guide paragraph before it: which part and setting, what the correct answer would be, what one point or entry is, what the reference line, bars, or band mean, and a "Look for" sentence of two or three prompts. Guides ask questions and do not give conclusions; the numbered findings give conclusions. The findings open with the standard sentence (read the claim, open the output, check you can see it) and each one cites its output. Captions name the part. End with a table that recomputes every number quoted in the spec.

**The draft spec and Decisions log.** Both come from the files through `read_md_part()`, never copied in. The `[TO CONFIRM]` markers become yellow "To confirm" items.

**Action items and limitations.** Decide the status, resolve the yellow items, verify citations written from memory, plus pilot-specific items. Limitations say what is a mechanism only, what is assumed, and what was not run.

## Rules for every report

- **Numbers.** Every number in the text, tables, and figures is computed from the saved result files when the document renders. No hand-typed results.
- **Voice.** No first person. Concise: details, but balanced. The document must flow without pointing at its own earlier sections ("as above", "see Section 3").
- **Concrete wording.** Replace shorthand with the claim it stands for. A reader should never have to guess what a phrase means.
  - Say what is unknown in terms of what has and has not been done. Not "the mathematics is not proved", but "a formula for how often the test is wrong has been derived for Euclidean distance, and none has been derived for Bray-Curtis, so it is not known whether the result applies".
  - Name the quantity being judged in plain words, with its standard name in parentheses. Not "whether the false alarms survive", but "whether the inflated false positive rate persists (the type I error rate: the share of cases with no true difference that the test calls different, which should be 5%)".
  - Footnote every named method, distance, score, or package on first use, in one or two sentences: what it computes, and, when it matters for the problem, why the usual theory does or does not cover it (for example, that Bray-Curtis cannot be written as a straight-line distance, which is why the Euclidean theory does not apply directly).
  - Avoid idioms and unexplained verbs: "quietly assumes", "survive", "carries over" without saying what carries over, "works" without saying by what measure.
- **Plain language first.** Introduce each technical idea in non-technical words, then give the formal statement, with full precision kept.
- **Math.** Real LaTeX for all mathematical notation. Backticks are for code, file names, and column names only.
- **Dashes.** No em or en dashes. Use commas, colons, parentheses, or "to" for ranges.
- **Footnotes.** Define non-statistical jargon (workflow terms, biology, data sources) in a footnote at its first use, in one or two plain sentences. Statistical terms do not need one.
- **Table widths.** Set the column widths in proportion to the text in each column by adjusting the dashes in the separator row (`|----|------------------------|`). Pandoc applies the proportions only when some row is longer than the line width. Tables from `knitr::kable()` size their columns by content already. Check the rendered `<col>` widths.
- **Figures.** At least one of the problem (made-up numbers, labelled as such), one of the real data, and one from the pilot, plus the design diagram. Look at each by eye.
- **Derived data files.** A small derived data file (a few KB or MB, for example counts per donor) may live in the pilot folder when a real-data figure needs it, with its source stated in the report. Reading a sibling project's results by relative path is allowed, read-only; say so in the Scope paragraph.
- **Quarto gotchas.** `fig-cap` and `tbl-cap` do not evaluate inline R, so a number in a caption must be avoided or built with the `!expr` option form. In a pipe table, write `\lvert t \rvert` and not `$|t|$`, because the bar splits the cell. Footnote definitions that no text refers to cause harmless Pandoc "not used" warnings.
- **Extending the standard text.** If a pilot reports a quantity that the standard "How to read the outputs" text does not define (for example a drift or a relative difference), append a short paragraph defining it after the include. Do not edit the shared part.
- **Known-answer readings.** Use `harness_reading_mcse()` when the check has a standard error, `harness_reading_pct()` for a relative gap, and `harness_reading_tol()` for exact identities or when the known answer is itself approximate. A gap above 2 MCSE is flagged "look for a bug" even if the tiny size makes it harmless; say in the report when that is so. `harness_reading_mcse()` takes `flag` for pilots whose own pass rule is not 2 MCSE, and `harness_flag_summary()` writes the one-sentence count of rows beyond the threshold for the line under the table. A checks table that is a maximum over many entries needs `harness_reading_tol()`, not the single-entry rule. `harness_table()` sets the column widths by hand (argument `widths`), so one long reading no longer squeezes the other columns. Checks that are findings or demonstrations and not pass-or-fail get custom reading text starting "Finding, not a pass".
- **Number formatting.** `fmt()` and `fmt_range()` in the helpers format numbers and ranges ("0.12 to 0.34") for inline R.
- **Format.** Quarto `.qmd` rendered to a self-contained HTML (`embed-resources: true`), with `toc: true`, `toc-depth: 3`, `theme: cosmo`, `fig-cap-location: bottom`, `code-fold: true`, and `echo: false`, `warning: false`. Deliver the `.qmd` and the `.html`.

## What the checker covers

Errors: a required section is missing, `[FILL]` placeholders remain, an unresolved cross-reference or footnote, inline R that did not run, an em or en dash, or highlighted `[TO CONFIRM]` items that do not match the spec. Warnings: first person in the report's own text, a callout, tables with equal-width columns, fewer than three images or five footnotes, NaN in the text, a critique table that mentions the pilot, and a `project-spec.md` that is not found at the project root (the `[TO CONFIRM]` check is then skipped). It does not judge whether the content is right.
