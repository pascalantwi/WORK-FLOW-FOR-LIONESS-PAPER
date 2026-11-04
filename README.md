# LIONESS Beyond the IFN Score in SLE and RA

LIONESS turns a group of gene-expression samples into one network per sample, and those networks are compared between patient groups or used to classify patients. This project shows that each LIONESS edge is a closed-form quadratic function of the sample's own expression, and asks what that means in practice: do LIONESS edges help tell systemic lupus erythematosus from rheumatoid arthritis in blood, once the interferon score, its square, cell composition, and the matching quadratic expression model are accounted for?

Authors: set by `tools/authors.R` before the final render. Target journal: BMC Bioinformatics. Status: see `STATUS.md`.

## This copy of the workflow

This repository runs the workflow of [tgrimes/research-workflow](https://github.com/tgrimes/research-workflow) (version 0.2.4) for the LIONESS paper, with one change: no Zotero library is used. The references live in a Markdown file, `references/references.md`. The agent writes each entry from a record it opened, such as the DOI's Crossref record, PubMed, or the publisher's page. `manuscript/build-bib.py` generates `manuscript/references.bib` from that list for the render. You review `references.md` once, at the end, at the reference review of stage 3, step 6. Full texts help the agent during planning but are optional: put a PDF in `references/pdfs/<key>.pdf` (not committed) whenever the agent lists a core citation as `pending`. `workflow/CHANGELOG.md`, under 0.2.4-md, lists every file that changed.

## What this repository is

A research project run with a fixed workflow: an idea is reviewed and verified into a proposal, a pilot decides whether the idea survives, a manuscript is drafted and revised, a background report expands its literature and proofs, three mock reviewers critique it, and a talk and a poster present it. The instructions for every stage are in `workflow/`, one file per stage, so that anyone can see what the agent was asked to do at each step. The repository is also a research compendium: an R package with its tests, the analysis scripts, the results they produce, and the manuscript that reads them.

## Starting a project

1. Create a repository from this template on GitHub and clone it.
2. Run the setup script from the project root. It names the package, removes the template's examples, and fills the headers:

```bash
Rscript tools/init.R <packagename> --title "Short Title" [--no-python]
```

The authors are not needed yet: `tools/authors.R` sets them in DESCRIPTION, LICENSE, this file, and the manuscript before the final render.

3. Restore the environments. renv installs itself on the first start of R in the project root:

```r
renv::restore()
```

```bash
uv sync
```

4. Write `idea.md`. It may hold a paragraph or a full literature review; whatever it holds is verified.
5. Ask the agent to look at `idea.md`. From then on, `STATUS.md` says where the project is and what is waiting on you.

## The stages

| Stage | Instructions | You start it by | It ends with |
|---|---|---|---|
| 1. Idea review | `workflow/01-idea-review.md` | "look at idea.md" | `proposal.md`: novelty, fit, theory, datasets, a pilot plan with pass criteria, and the reference list started in `references/references.md` |
| 2. Pilot | `workflow/02-pilot.md` | "the proposal is final" | `project-spec.md`, the pre-registered pilot in `pilot/`, its report, and a pass or fail |
| 3. Manuscript | `workflow/03-manuscript.md` | "the pilot passed", or "dropped" or "parked" for a memo | `manuscript/manuscript.html`, then revision rounds on your comments; after the background report, the production run and the final render; after a dropped or parked pilot, the memo of the study, written once |
| 4. Background report | `workflow/04-background-report.md` | "the draft is settled" | `background/background.html`, with the literature in full and every proof walked through, for you to read before the production run; an issues list if it found errors |
| 3, step 6. Production run | `workflow/03-manuscript.md` | "run production", after the report | the reference review (you read `references/references.md` once), then the final render of the manuscript |
| 5. Mock review | `workflow/05-mock-review.md` | "run the review" | `review/round-1/reviewer_1.md`, `_2`, `_3`; then responses and further rounds |
| 6. Slides | `workflow/06-slides.md` | "make the slides" | `slides/` (not yet written) |
| 7. Poster | `workflow/07-poster.md` | "make the poster" | `poster/` (not yet written) |
| 8. Publish | `workflow/08-publish.md` | "publish it" | a clean copy of the project outside this repository, with only the code, data, results, and manuscript, verified from a fresh restore |

Every stage ends at a stop: one file for you to read, committed at the stop, and nothing moves until you answer. `STATUS.md` names that file. The rest of the repository (`workflow/`, `templates/`, `tools/`, `log/`, the pilot and analysis folders) is the agent's working material, and you need not read it. The rules that hold in every stage are in `workflow/rules.md`.

## Layout

| Path | What it holds |
|---|---|
| `idea.md`, `proposal.md`, `project-spec.md`, `protocol.md` | The idea, the verified proposal, the spec, and the ADEMP protocol |
| `STATUS.md` | The stage, the open stop, and the stage record |
| `workflow/` | The instructions, `rules.md`, the journal guide, and the changelog |
| `log/` | One log per stage: decisions, sources, process feedback; the manuscript's drafting log is `log/03-manuscript.md` |
| `templates/` | The forms the stages fill |
| `tools/` | `init.R`, `authors.R`, `export.R`, and scripts shared by stages |
| `R/`, `tests/testthat/` | Functions with roxygen comments, and their tests |
| `pilot/` | The pilot: pre-registration, script, results, decisions, report |
| `analysis/` | Numbered scripts that call the functions and write to `results/` |
| `data/raw/`, `data/processed/` | Untouched inputs, and data derived by scripts |
| `results/` | Everything `analysis/` produces; never edited by hand |
| `references/` | `references.md` (the reference list you review at the end), `reference-fixes.md` (faults found in the list), and `pdfs/` (full texts you add; not committed) |
| `manuscript/` | `manuscript.qmd` and `_supplement.qmd`, their helpers and checker, `citations.csv`, `references.bib` (generated from `references/references.md`) |
| `background/`, `review/`, `slides/`, `poster/` | The later stages' deliverables |
| `renv.lock`, `renv/`, `.Rprofile` | The R environment (renv) |
| `pyproject.toml`, `uv.lock`, `.python-version`, `inst/python/` | The Python environment (uv) and the Python package |
| `CLAUDE.md` | The conventions any AI assistant follows here |

## Run it end to end

From the project root, with the environments restored: the scripts in `analysis/` in order, then the render.

```bash
Rscript analysis/01_simulation.R --run production
quarto render manuscript/manuscript.qmd
```

Results land in `results/`. Every number in the manuscript, the report, the slides, and the poster is read from `results/` at render time, so rerunning a script and rendering again updates every number.

To work interactively, open R in the project root and run `devtools::load_all()`. Run `devtools::document()` after changing roxygen comments, `devtools::test()` to run the tests, and `devtools::check()` before you share the code. Python tests run with `uv run pytest`.

## Data

The application uses PRECISESADS (ELIXIR Luxembourg dataset ELU-2-E592B0-1, https://doi.org/10.17881/th9v-xt85), under controlled access for non-commercial research on systemic autoimmune diseases. It is not in this repository and cannot be downloaded by a script: access is requested through the ELIXIR Luxembourg data catalogue, and the files are then placed in `data/raw/` by hand, with the date and the version recorded here. [TO CONFIRM: the access request; until it is granted, `analysis/00_download.R` does not exist]{.tc} The simulation study needs no data.
