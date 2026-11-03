# Stage 8: publication copy

## Purpose

Build the clean copy of the project that goes out with the paper: an R package with its tests, the analysis scripts, the data or the script that fetches it, the results the scripts produced, and the manuscript that reads them, and nothing of the workflow: no idea, proposal, spec, status file, instructions, templates, logs, pilots, background report, reviews, slides, or poster. The copy is verified from a fresh restore before it is handed over. The repository itself stays as it is.

## Inputs

- The repository at a clean commit after stage 3, step 6 (the final render), with the review's revision rounds applied.
- `tools/export.R`.
- `workflow/rules.md`, in full.

## Preconditions

- `STATUS.md` says `5, complete after N rounds`, or the user asks for the copy earlier and says so.
- The working tree is clean (`git status --porcelain` is empty); the script refuses otherwise.
- `manuscript/manuscript.html` is the final-mode render and is committed.
- The log is `log/08-publish.md`.

## Procedure

**1. Export.**

1. Set `STATUS.md` to `8, exported` once the export exists.
2. From the project root, run `Rscript tools/export.R` with a target outside the repository (the default is `../<package>-publication`). The script copies only tracked files from the allowlist in its header, writes a new `README.md` (title, authors, description, how to reproduce, the data section, the export's commit and date) and a new `.Rbuildignore`, and prints a manifest.
3. Read the manifest and the written `README.md`. Record the manifest in the log.

**2. Verify in the copy.** Run inside the target, in order, and record each result in the log:

1. `Rscript -e 'renv::restore()'`, then `uv sync` if `pyproject.toml` is there.
2. `Rscript -e 'devtools::test()'`, `uv run pytest` where there are Python tests, and `Rscript -e 'devtools::check()'`: no errors, no warnings; a note is recorded with its reason.
3. The download script, `Rscript analysis/00_download.R`, when the data are not in the copy; compare what it fetches with the project's `data/raw/` by checksum.
4. The render from the copied results: `quarto render manuscript/manuscript.qmd -P draft:false`, then compare its numbers with the committed final render (same expressions, same digits).
5. The simulation, `Rscript analysis/01_simulation.R`, at the quick replicate count when it fits in an hour, with the summaries compared against the quick run's committed summaries; at the production count only when the user asks. Record what was and was not rerun.

**3. Hand over.**

1. Read the copy's `README.md` as a stranger would: it says what the paper is, who wrote it, how to reproduce every number, and where the data come from. Edit it in the copy if it does not; the script's version is a start, not a rule.
2. Confirm that nothing in the copy names the workflow: `grep -rli -E 'workflow|proposal|pilot|TO CONFIRM' <target>` returns only the manuscript helpers and the ADEMP protocol, if anything.
3. Set `STATUS.md` to `8, verified`, write the stage record line naming the target path, and commit ("Stage 8: publication copy verified").

**Stop.** Return the target path, the manifest, the verification results, and anything the user should edit in the copy's README before it is pushed to a public repository or archived with a DOI, which the user does.

## Outputs

- The publication copy at the target path, outside the repository.
- `log/08-publish.md`: the manifest, every verification command with its result, what was not rerun and why, process feedback.

## Checks before the stop

- The target has none of: `idea.md`, `proposal.md`, `project-spec.md`, `STATUS.md`, `CLAUDE.md`, `workflow/`, `templates/`, `tools/`, `log/`, `pilot*/`, `background/`, `review/`, `slides/`, `poster/`, `manuscript/citations.csv`, `manuscript/check-manuscript.py`, `manuscript/build-bib.py`, `manuscript/reference-fixes.md`, `manuscript/sources/`.
- Tests and check pass in the copy; the render in the copy matches the committed final render.
- The copy's README reproduces every number from a fresh clone.

## What to return at the stop

One message: the target path; the manifest; the verification results, with what was rerun and what was not; the README's open points; what the agent was unsure of.

## Delegating this stage

A worker reads this file and `rules.md` in full; the brief adds the target path and whether the production run is to be repeated. The worker returns the stop message above; the coordinator lists the target and reruns `devtools::test()` there before relaying.

## Lessons

(None yet. This stage has not been run on a project; the script was tested on the template.)
