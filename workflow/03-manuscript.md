# Stage 3: manuscript

## Purpose

Take a passed pilot and produce the manuscript: a first draft in draft mode on quick-run numbers, revision rounds on the user's comments until the draft is settled, then, after the background report of stage 4 has been read, the production run and the final render. The background report comes before the production run so that the user understands the literature and every derivation before the long run is spent. The repository is the research compendium, so every number is read from `results/` at render time, every claim rests on an entry of the reference list `references/references.md` with its passage recorded, and the draft carries its markers until the user closes them.

## Inputs

- `project-spec.md`, `proposal.md`, and `pilot/` (the pre-registration, the results, `decisions.md`, the report).
- `manuscript/`: the skeleton `manuscript.qmd` and `_supplement.qmd`, `manuscript-helpers.R`, `check-manuscript.py`, `build-bib.py`, `parts/`, `references.bib` (generated from the reference list), `citations.csv` (started at stage 1).
- `references/`: the reference list `references/references.md` (started at stage 1), `reference-fixes.md`, and the PDFs in `pdfs/`.
- `workflow/journals/`: the journal guide and `journals.csv`, which the helpers and the checker read.
- `workflow/rules.md`, in full.

## Preconditions

- `STATUS.md` says `2, piloted-pass`, and the spec's `[TO CONFIRM]` markers are resolved or will be carried into the draft as markers.
- A target journal and a fallback are chosen with the journal guide's worksheet and recorded in the spec's section 6.
- `renv::restore()` and `uv sync` have been run; R, Quarto, and uv are installed.
- No Zotero library is used; the reference list is `references/references.md`, and full texts are open copies or PDFs in `references/pdfs/` (`rules.md`, section 2).
- The stage's log is `log/03-manuscript.md`, the drafting log; the draft's banner reads its opening paragraph, and process feedback goes at its end.

## Procedure

Each step ends in a file someone can open. **Stop** marks a point where the step halts for the user's answer. When the stops are switched off for a run, or a stop has been answered by a ruling, `rules.md`, section 1, says what to do.

**0. Paper test.**

1. Answer the seven questions of the paper test (`01-idea-review.md`), each qualified by method and setting and each pointing at the file where it is met: the procedure, the setting, the estimand as a functional, the target and the bias term, the simulation that confirms it, the correction or diagnostic, the confirmed dataset with its "what to show" claim.
2. Keep them in a scratch note until step 1 creates the log, then write them in `log/03-manuscript.md` under `## Paper test` as a three-column table (question, answer, where).
3. Make the log's opening paragraph a one-line status: the paper test in a sentence, and anything the run will not cover. The banner repeats that line. A "no" on the estimand, the formula, or the fix is stated there, not written around.
4. Set `STATUS.md` to `3, drafting`.

**1. Promote the pilot.** The pilot's functions are already in `R/` with tests, so there is nothing to port.

1. Promote `pilot/pilot.R` to `analysis/01_simulation.R` with a parameter block (factor levels, replicate count, cores), a seed per cell from the design table, paths through `here::here()`, PSOCK workers with the BLAS pinned to one thread in each, per-replicate output, the design table, `sessionInfo()`, and `results/run_info.rds`, which the simulation script owns; every other script writes `results/<name>_run_info.rds` (see Provenance). Until the design stop, the script carries the pilot's design.
2. A per-replicate file above about 50 MB is git-ignored; the per-cell summaries the script computes from it are committed.
3. `analysis/00_download.R` fetches what `data/raw/` lacks. If it cannot be run in the session, the README says so and the log carries a marker.
4. Known-answer checks and code-identity checks are `tests/testthat/` tests covering every code path the production design uses, with the closed forms as expected values where they exist. Record in the log every assumption found in the pilot's code comments and decisions log, and the test coverage added for code paths the pilot did not run.
5. Plot code becomes figure functions in `R/` that the manuscript's chunks call, so the report, the slides, and the poster can draw the same figures.
6. Acceptance test: copy the pilot's saved summaries from `pilot/results/` into `tests/testthat/fixtures/` and write a testthat test, gated by an environment variable so that `R CMD check` stays fast, that runs the pilot's grid and seeds through the package's functions and compares every per-cell summary to floating-point precision. Record the result in the log; stop on a mismatch.
7. A method whose only implementation is Python is run through the uv environment as `CLAUDE.md` says (a package with `uv add 'name==version'`, scripts vendored into `inst/python/vendor/`, glue in `inst/python/<package>/` with pytest tests, an R wrapper in `R/`). When the environment cannot be built in the session, the method is drafted as planned with markers and its chunks left empty, and the decision is logged.
8. `devtools::document()`, `devtools::test()`, and `devtools::check()` run clean. Commit ("Stage 3, step 1: pilot promoted").

**2. References.** The reference list `references/references.md` is the only source of entries. No stop: the user reviews the list once, at step 6.

1. *Inventory:* every source the draft will cite, from the proposal's section 10 and `citations.csv` as stage 1 left it, the pilot's opened sources (D0, or the report's citations), the spec's reading list, and the seed entries of `references.md`, each with the claim and section that need it. Write it in the log as a table (key, grade core or supporting, section, why, origin). If the step was run before, the log points at the existing inventory and checklist rather than copying them.
2. *Availability:* for each candidate without an entry, open its record by DOI and then by title and write its entry in `references.md` (`rules.md`, section 2). Available means the record was opened, the entry is complete enough to cite, and either the full text was read or the citation is supporting and the abstract states the claim; a pre-1980 source or a book counts without a full text. A core citation without a full text is usable with `full_text: pending`.
3. Record in the log three lists: (1) available, with the count; (2) core citations with full text pending, each with the full citation, the identifier, and the claim it is needed for (the PDFs the user may add to `references/pdfs/` at any stop); (3) records that could not be opened. Mention lists 2 and 3 in the next stop message; they do not stop the stage.
4. *Build:* `python3 -I manuscript/build-bib.py references/references.md manuscript/references.bib --citations manuscript/citations.csv --check` writes the bib from the list (abstracts, file paths, and the list-only fields are never written), rewrites each entry's readable line, and writes any remaining faults to `references/reference-fixes.md`. Correct every fault in `references.md` and run it again.
5. The checklist `manuscript/citations.csv` has one row per candidate: `key, read_from, grade, section, why, origin, identifier, identifier_source, pdf, usable, deviations_from_record, support_passage, read_date, verified_by, verified_date`.

**3. Draft, in six parts.** Record in the log what each section was carried from and what was written new.

1. *Purpose draft of the Introduction* and the list of claims (the spec's aims, as questions). Three paragraphs: the procedure and what it is meant to estimate; what it estimates under the realistic condition, in words and then as a formula; what the paper does. The guidance is the skeleton, the first three questions of the paper test, and the section rules below.
2. *Design proposal.* **Stop.** Return the proposal as one table and one paragraph, and wait. It holds:
   - a table of factors, levels, and the reason for each, every element tied to the question it answers, every varied factor spanning a gradient from a small effect to a large one, with the application placing the real data on it;
   - the application plan: dataset, comparison, what to show, and the test the application uses (the spec's if it names one, otherwise the simulation's, marked);
   - one cell of each method timed at the largest sample size and at a typical one, so that the proposal carries a runtime bound;
   - the performance measures named by target: bias against the formula, empirical SE or MSE, coverage where intervals are reported, type I error and power;
   - the power cells, planned by default as `rules.md`, section 3, says: for every method whose type I error is controlled (a rejection rate under about 10% for a test at 5%), cells with a true difference whose levels run from low power to about 80%, the levels informed by the real data and checked with a few low-replicate cells before the full run, and the real data placed on that gradient; a method left out of the power cells is named with its type I error.
   On approval, write `protocol.md` once from the approved design (`STATUS.md`: `3, design stop` while waiting) and commit ("Stage 3, step 3: protocol").
3. *Quick run.* The full design at a replicate count set by the timing so that the grid finishes well within an hour, run in the background: the production code with only the replicate count reduced, and the application too if its code exists. Confirm `results/run_info.rds` says `run = "quick"`.
4. *Methods, the design section, Results, Discussion*, in that order, on the quick-run numbers, with `_supplement.qmd` holding the proofs.
   - Design levels in the prose go through `lvl()`, results through `prov()`, and a range with its Monte Carlo error through `range_mcse()`, so that no digit is typed.
   - When a result contradicts a claim in the spec, the Results state the fact, the Discussion interprets it with a guard, and a `[TO CONFIRM]` quotes the spec's sentence.
   - An exploratory probe that explains a result enters the paper only through a script that writes its numbers to `results/`; otherwise it stays in the log, and the interpretation it supports carries a marker.
   - The journal's CSL file is copied beside the qmd and named in the YAML from the start; the profile's placement of the AI-use statement and its required back-matter headings override the skeleton's.
   - Every attributing citation is written with the full text open (the open copy or the PDF in `references/pdfs/` that the entry's `full_text` field names), or with the abstract for a supporting citation, or for a core citation whose full text is pending (marked in the log), and its passage and date go in `citations.csv`; a citation that only names a method or a dataset is marked `definitional`. The passage reading may be delegated to other agents if each returns the quote, its location, and a verdict; the drafter spot-checks a sample against the full texts and says so in the log.
5. *Introduction revised* against the Results and Discussion; then the Abstract in the journal's headings.
6. *Second reference batch.* If drafting turned up sources not in the inventory, run the availability check and the build of step 2 on them as one batch. No stop.

**4. Revise for clarity, at least once.** Render the draft and read the rendered page from the title to the end of the Discussion as the journal's reader would, not as its author: someone who knows the field but has not read the spec, the protocol, or the log. Two passes over the text, three cross-checks, then a render.

1. *Paragraphs.* For each paragraph, write in the log the one question it answers for that reader. If its first sentence does not state the answer, rewrite the first sentence. Within the paragraph, why comes before what, and nothing is named (a method, a symbol, a study label) that the reader has not met without a phrase saying what it is.
2. *Sentences*, for the Abstract and the Introduction in full, the first paragraph of every other section, and every caption. Each sentence:
   - has a subject and a verb the reader can find, states one fact or one reason, and can be paraphrased by the reader;
   - loses any clause the reader would stumble on, replaced by what it meant;
   - is joined to the next or recast when it needs the next one to make sense;
   - is split into the simple sentences it was built from, in the order a reader can follow, when it packs several ideas and terms together (time against burden: one sentence for a simple topic, up to three for a complex one);
   - is given a source or removed when it makes a claim without one;
   - keeps the paragraph's subject rather than introducing another to carry a fact about it ("these methods were developed to", not "their authors' aim was to").
3. *Cross-checks.* Each claim in the Abstract carries a number with its uncertainty, and the same number appears in Results from the same expression. The Introduction's questions are answered in the Discussion in the same order and the same words. Every label a caption uses is defined in the caption or in the text before the display.
4. Settled points:
   - an opening the user has accepted is exempt from the paragraph pass;
   - where answer-first and why-first collide, the first sentence states the answer with its reason in the "why, so what" form when the reason is short, and otherwise the answer first and the reason in the next sentence;
   - "section" means every heading level, and the standard parts from `parts/` are exempt;
   - a caption's numbers are computed like the prose's (build the caption in the setup chunk and pass it with `!expr`);
   - a claim in the Abstract is a finding of the simulation or the application, not prior work or a recommendation;
   - a name every reader in the field knows (limma, the Welch test) needs no phrase;
   - a paragraph may be split, or sentences moved within a section, with the split logged.
5. Record what changed and why in the log under `## Revision pass`: the changes by section, quoting the rendered page, with one reason per block of like changes rather than per sentence. Render again and run the checker.
6. Make a second pass when the first changed more than three sentences in any section, and apply the same rule to the second; the third pass, when due, is the user's. The first pass lengthens a draft by splitting sentences, so the second pass also cuts what the splitting left redundant.
7. For a deliverable written in markdown (the proposal, the spec, a review, a response): passes 1 and 2 over the whole document, with the labels a template carries exempt; no cross-checks and no render; the changes recorded in the stage's log as in 5.

**5. Render and check. Stop.**

1. `quarto render manuscript/manuscript.qmd` in draft mode (the default).
2. `python3 -I manuscript/check-manuscript.py manuscript/manuscript.qmd manuscript/manuscript.html --citations manuscript/citations.csv --bib manuscript/references.bib --journals workflow/journals/journals.csv --journal <slug>`. Fix every error; answer every warning in the log as fixed or kept with a reason. The checker's word count splits a decimal and a possessive into two words, so it runs a few percent above a plain count; at a journal's limit, trust it rather than the plain count.
3. Finish the log: the opening status, the paper test, the inventory, the bounded literature pass (every source opened and what it said), the citation counts (passage-backed against definitional), every deviation from a source's record, every warning kept with its reason, the revision pass, the time per step, and the process feedback.
4. Prove the clone: clone the compendium to a scratch directory, delete `data/raw/` there so that `analysis/00_download.R` runs, run `renv::restore()` and `uv sync`, then the tests in both languages and `devtools::check()`, rerun the quick run, confirm the summaries match (downloaded files by checksum, files the script builds by content), and render. If any of that fails, say so and do not hand over.
5. Set `STATUS.md` to `3, draft at stop`, write the stage record line naming `manuscript/manuscript.html`, and commit with the rendered draft ("Stage 3, step 5: first draft").
6. Return the stop message (below). Wait.

**Revision rounds.** After the first draft, each message of comments from the user is a round.

1. Set `STATUS.md` to `3, revision round N`.
2. Apply every comment. Where a comment states a general rule, apply it and propose the rule for this file or `rules.md` in the return message, without adopting it.
3. Record the round in the log under a dated `## Revision N` heading as a table (comment, change, where).
4. Run the revision pass (step 4) again when the round changed more than three sentences in any section.
5. Render and check; after step 6 has run, render in final mode and check with `--final`. A round that changes the design is a change to `protocol.md` with a dated reason, and step 6 runs again.
6. Commit the round as one commit with the rendered page ("Stage 3, revision round N"). Return the table and the proposed rules.
7. The draft is settled when the user says so: `STATUS.md` becomes `3, settled`, and stage 4 (the background report) runs on the settled draft. Step 6 starts when the report is done (`4, done`) and the user says to run production; a blocking or substantive issue from the report is a revision round here first.

**6. Production run and final render.** When the background report is done (`STATUS.md` says `4, done`) and the user says to run production.

1. Set `STATUS.md` to `3, production run`. Confirm from `protocol.md` the production replicate count (`n_rep_production` in the run file) and that its "Changes after production" table is empty or explained.
2. Estimate the runtime from the quick run's time and the replicate ratio, and say it in the message that starts the run, with the cores it will use.
3. Run `analysis/01_simulation.R` at the production replicate count in the background, within the core cap, and the application script if its quick-run numbers came from a reduced version. Confirm `results/run_info.rds` says `run = "production"` and that `sessionInfo()` was saved.
4. Compare quick against production: for every number in the Abstract and Results, the quick-run value, the production value, and its Monte Carlo standard error, as a table in the log under `## Production run`. List every sentence whose claim changes (a difference called nonzero that is now within noise, or the reverse) and revise it; a changed claim goes through the revision pass (step 4), and anything the user should judge gets a marker.
5. *Reference review.* **Stop.** Run `build-bib.py` with `--qmd manuscript/manuscript.qmd --check` so that the bib holds only the cited keys, and return: the path to `references/references.md`; the count of entries cited; the core citations still `pending`, with the PDFs that would close them; `reference-fixes.md` if it is not empty; and the entries whose record was not opened. Set `STATUS.md` to `3, reference review`. The user reads the list and replies with corrections, PDFs, or "references checked". Apply every correction in `references.md`, read each added PDF and update the passage, rebuild, and fill `verified_by` (`user`) and `verified_date` in `citations.csv` for every row the user checked. A core citation still pending after the review becomes a `[CITE]` marker, or is downgraded to supporting with the user's agreement.
6. Set the authors: `Rscript tools/authors.R --author "Given Family" [--coauthor "Given Family"]... --email ADDRESS --affiliation "..."` writes DESCRIPTION, LICENSE, README.md, and the manuscript's YAML, which held placeholders until now; ask the user for the names if they are not in the log. Then resolve the markers: a final render refuses any marker, so every `[TO CONFIRM]`, `[CITE]`, and `[FILL]` must be closed. If any remain, **stop** with the list; the user closes them in a revision round.
7. Render in final mode: `quarto render manuscript/manuscript.qmd -P draft:false`. The banner and gap table disappear, `prov()` refuses anything not labeled production, and the checker in `--final` errors on any marker. Run the checker with `--final`; fix every error.
8. Set `STATUS.md` to `3, final`, write the stage record line, and commit with the final render ("Stage 3, step 6: production run and final render").
9. Render the background report again (`04-background-report.md`, step 5), since its numbers now carry the production label, and commit it. Return: the runtime and the replicate count; the comparison table's rows whose difference exceeds its Monte Carlo standard error; the sentences changed; the path to the final HTML. **Stop.** Stages 5 and 8 read the final render.

## Memo mode

When the user answers the stage 2 stop with `dropped` or `parked`, after whatever re-pilots were run, stage 3 writes a memo instead of a paper: the same document in form, on the pilots' numbers, with no target journal, so that the literature review, the methods, the derivations, and the results are kept as a complete null-finding manuscript. It is written once and covers every pilot folder. Time box: one working day of agent time.

1. Set `STATUS.md` to `3, memo`. Inputs: `proposal.md` with all its revision sections, every `pilot*/` folder (the pre-registration, the results, `decisions.md`, the report), `manuscript/citations.csv`.
2. Steps that apply, as written above: 0 (the paper test, with the answers the pilots gave); 2 (references, with APA as the style: copy `workflow/journals/csl/apa.csl` beside the qmd and set `csl: apa.csl`); 3.1, 3.4, 3.5, and 3.6 (the draft); 4 as one pass, with no second pass; 5.1 to 5.3 and 5.5 (render, check, log, commit). Revision rounds apply when the user comments.
3. Steps skipped: 1 (nothing is promoted; the memo reads the pilots' results through `read_results(name, dir = pilot_path())`, and `pilot_path(folder = "pilot-b")` for a re-pilot, with the run information from the last pilot's folder); 3.2 and 3.3 (no design stop, no quick run, no `protocol.md`); 5.4 (no clone test); 6 (no production run); and, after the memo, no background report, no mock review. Stage 8 can still export the project if the user decides to post the memo.
4. What differs in the sections. The memo opens with the paragraph from `memo_note()`, which says the study was not carried further; the Abstract is unstructured, with numbers, and has no word limit. The Simulation study's Design describes the pilots' design as a paper would: factors, levels, methods, measures, the replicate count with the Monte Carlo standard error it gives, the cells with a known answer, and the threshold a difference had to exceed, without the words pilot, pre-registration, or pass rule. The Results report every pilot's results. The Discussion answers the Introduction's questions in order and in the same words, saying for each what the results showed and whether the question is answered, what worked and what did not, in a paper's language; the novelty table stays; no future-work list is required.
5. Run the reference review of step 6.5 (the memo cites from the same list), then set the authors with `tools/authors.R` as in step 6.6, since the memo render refuses the placeholders. Render with `quarto render manuscript/manuscript.qmd -P draft:false -P memo:true`, and check with `--memo` and no `--journal`. In memo mode the numbers carry the pilots' label without marks, the banner and the gap table are off, the journal limits do not apply, and markers are errors: close every `[TO CONFIRM]` and `[CITE]` before the render, or list them and **stop**.
6. Commit with the rendered memo ("Stage 3: memo"). `STATUS.md` becomes `dropped (memo at manuscript/manuscript.html)` or `parked (memo at manuscript/manuscript.html)`, with the stage record line.
7. Return: the path to the memo and the log; the counts of figures, tables, and citations; the warnings kept and why; what the agent was unsure of. No summary of the findings: the user reads the memo.

## What each section must contain

**Abstract.** The headings and word limit of the target journal's profile. Every claim carries a numeric result with its uncertainty, through `prov()`: an estimate with its confidence interval or Monte Carlo standard error, a rate with its band, a count against its permutation or null count. In the first draft these are quick-run numbers; the final draft replaces them with production numbers in the same sentences.

**Introduction.** Three paragraphs.

- Paragraph 1 opens with why: the scientific question the procedure serves and what a user hopes to learn from it, before any method is named. The opening balances the reader's time against the reader's burden: a simple topic takes one sentence, a complex one up to three simple sentences that build on each other, never one sentence that packs the three together and never a page of preamble. Each sentence carries one idea in a simple structure, and no sentence, the first included, makes a claim without a source. Then the procedure people use, where it is used, and what its output is taken to estimate, ending with one concrete published example: the data, what was computed, and how its authors read the estimate. The model for that example, from an accepted draft: "In the paper that introduced lionessR, an R implementation of LIONESS, single-sample networks of osteosarcoma biopsies were computed with the whole cohort as the background, and their edges were compared with limma between patients who did and did not develop metastases [@kuijjer2019lionessr]. A group difference in mean edge is then read as a difference between the groups in how tightly the two genes move together." A first sentence that a reader could not paraphrase is rewritten in the revision pass.
- Paragraph 2: the realistic condition, what the procedure estimates under it, in words and then as a formula, and what has been observed or derived before, with what each source did and did not do, ending in what has not been derived.
- Paragraph 3: what this paper does, in the order of the sections. The paper's claims are the spec's aims, phrased as questions that can come out either way.
- Almost every sentence is a fact with a reference; the rest build the tension and resolve it.

**Methods.**

- *The estimand and the procedure:* the estimand as a feature of a population, as a functional, in plain words first; then each procedure as a recipe applied to data, with the equations one clause per line and each symbol defined in the sentence that introduces it or in the equation's own label. No table of notation: a symbol a reader has to look up in a table was introduced in the wrong place.
- *What the procedure estimates:* the target under the realistic condition and the bias as a formula, saying when it is zero and what makes it large; where no formula exists, say so. Proofs go to `_supplement.qmd`, included at the end of the paper as the supplementary note.
- *The fix or the diagnostic:* what to change, or what to check.
- *Data:* the cohort, accession, sizes, and processing.
- *Software and reproducibility:* the standard paragraph from `parts/`.
- Past tense, no results.

**Simulation study.**

- *Design:* the ADEMP sentence, then aims, data-generating mechanisms with the factors varied and fixed and the reason for each, estimands, methods precise enough to reimplement, performance measures, replicates and the Monte Carlo SE they give. The design table goes through `design_table()`; its caption defines every study label it uses (S1, S2), and its reason cells read as fragments a reader can parse, in the paper's words and not the workflow's ("a small effect", never "too small to matter").
- *Results:* one subsection per aim, each with its figure or table chunk reading `results/`, never hard-coding factor levels, and prose that states facts in past tense, cites nothing, and states a difference only when it exceeds about three Monte Carlo SEs, otherwise marks it `[TO CONFIRM: ...]{.tc}`. Every figure and table is referenced. Every finding the prose states is shown in a figure or a table, and no cell that supports a finding is dropped from a display: a condition under which a method misbehaves (heavy tails, undefined tests, a cell that would swamp an axis) gets its own row, panel, or table rather than an exclusion.

**Application.** The dataset and comparison, then the one thing the analysis shows, as a claim about a user's conclusion, with the real data placed on the simulation's gradient, in a table whose rows carry the design table's symbols beside the quantity each row reports, every row readable on its own. If the analysis has not been run, the claim stands with a marker and a guarded chunk.

**Discussion.** What was found and what a user should do differently; the novelty table (element, prior literature, this paper) through `novelty_table()`; limitations from the rows of the pilot report's "Critiquing the model" table that did not become design factors; future work from the spec's out-of-scope list, item by item.

**Supplementary note** (`_supplement.qmd`). A plain-language opening paragraph saying what the note derives and why; the notation in one sentence; then one subsection per result (`S1.1`, `S1.2`, ...), each with the derivation one step per line and the step's justification, ending with where the paper uses it and which test checks it. Its figures and tables are numbered Figure S1, Table S1, and so on by the skeleton's cross-reference kinds: each is a fenced div whose id starts with `sfig-` or `stbl-`, with the chunk inside and the caption as the last paragraph, referred to as `@sfig-name`; a chunk label of that form does not resolve.

**Statement on AI use** and **Data and code availability** from `parts/`, the first adapted to the journal's policy as quoted in its profile.

## Provenance

- Every number in the text comes through `prov(x, digits)`, which reads the run label from `results/run_info.rds` (fields `run`, one of `pilot`, `quick`, `production`; `n_rep`; `n_cells`; `date`; `note`; and `n_rep_production`, which `gap_register()` uses for its production column) and renders the number with a visible mark in draft mode. Every analysis script writes that file. A number from a second results file with a different run label takes `prov(x, run = "pilot")`.
- Design levels (a factor's value, a sample size, a nominal level) go through `lvl()`, which formats without a highlight; ranges with their Monte Carlo error go through `range_mcse()`, which reports the largest MCSE once.
- Markers are spans: `[TO CONFIRM: the decision]{.tc}` for any decision the user must make, `[CITE: the claim]{.cite}` for a claim without a usable source, `[FILL: ...]` only in the skeleton. A marker in the YAML (an author line, say) carries its span too, and Quarto renders it in the title block. The banner, the marker table, and the checker count markers in every line of the qmd (front matter and chunks included) and in every included file, so their counts agree; the checker also reports the count in the rendered page.
- `draft_banner()` opens the draft with the log's opening status line, the run label and replicate count, and the marker counts; `gap_table()` closes it with one row per figure or table (register each with `gap_register()` in its chunk) and `marker_table()` lists every marker with its section. All three are apparatus and the only place workflow words may appear.
- The checklist's `verified_by` and `verified_date` columns are filled before submission by whoever verifies each citation against the paper; no drafting step fills them.

## Rules for writing

The rules every stage obeys, the word lists included, are in `rules.md`, section 4. These are the manuscript's own, and the checker enforces them.

- No digit is typed in the prose: results through `prov()`, design levels through `lvl()`.
- The pilot report is a source of facts, never of sentences; its footnotes, figure guides, and worked examples do not appear in the paper.
- Real LaTeX for all mathematics; multi-clause displays with one clause per line, separated by `\\`.
- No workflow vocabulary in the paper: not "known-answer check", "harness check", "pilot", "card", "worker", "quick run", "spec", or "the report". Say plainly what was done.
- Methods in past tense with no results; Results with no interpretation and no citations; Discussion with no new results.
- Every citation that attributes a finding or a claim is written with the full text open, or with the abstract for a supporting citation without a PDF, and its supporting passage recorded in the checklist; a citation that only names a method or a dataset is marked `definitional` there.
- Table column widths in proportion to the text in each column (`kable_w()` takes `widths`).
- Format: Quarto, `embed-resources: true`, `toc`, `theme: cosmo`, `fig-cap-location: bottom`, `code-fold: true`, `echo: false`, `warning: false`; the journal's CSL file copied beside the qmd and named in the YAML.

## What the checker covers

Errors: a rendered page older than the qmd; a `[FILL]` left; an unresolved cross-reference or footnote; inline R that did not run; an em or en dash; a hand-typed number in the prose; a cited key missing from the bib, missing from the checklist, not usable, or without a supporting passage or `definitional`; a checklist identifier neither filled nor `none`; a figure or table never referenced; a citation inside Results; first person singular; a bold lead-in; a workflow word in the paper's own text; a marker written without its span; in final mode, any marker or any number not labeled production. Warnings: delete-on-sight and justify words with counts (the lists of `rules.md`, section 4); many "not X, Y" constructions; digits with a percent sign in Methods; the abstract or body over the journal's limits; evaluative words; "statistic" near "estimand"; tables with equal-width columns; unused bib entries. Info: numbers by label, markers by kind, figures, tables, citations, words per section. It cannot judge tension, whether the estimand is a functional, or whether a passage supports its sentence; the user does that, and spot-checks a handful of passages against the full texts.

## Journals

`workflow/journals/README.md` has the summary table, the choosing procedure, and a worksheet that ends in a target and a fallback. Each profile names the CSL file, the abstract headings and word limits, and the AI policy the statement is written to. `journal_profile(slug)` reads the row of `workflow/journals/journals.csv` that the checker also uses.

## Outputs

- `analysis/01_simulation.R` and the other scripts; `protocol.md`; `results/`.
- `manuscript/manuscript.qmd`, `_supplement.qmd`, `references.bib` (generated), `citations.csv`, the CSL file, `manuscript.html` (draft mode at the first stop, final mode after step 6).
- `references/references.md`, and `references/reference-fixes.md` if faults remain.
- `log/03-manuscript.md`.

## Checks before the stop

- The checker reports no errors, and every warning is answered in the log.
- The clone test of step 5.4 passed.
- Every number in the Abstract appears in Results from the same expression.
- Every figure and table is registered with `gap_register()` and referenced in the text.
- Every attributing citation has its passage in `citations.csv`.
- `STATUS.md` names the rendered page, and the rendered page is committed.

## What to return at the stop

One message with: the paper-test status; the path to the draft HTML, the qmd, and the log; the counts of markers by kind; the list of `[TO CONFIRM]` markers with their sections; the reference-list faults still open and the core citations whose full text is pending; the gap table; the warnings kept and why; and what the agent was unsure of. No summary of the paper's findings: the user reads the draft.

## Delegating this stage

A worker reads this file and `rules.md` in full, then `proposal.md`, `project-spec.md`, `pilot/` (the pre-registration, `decisions.md`, the report, and the saved result files), and `manuscript/citations.csv` as stage 1 left it. The brief adds:

- the decisions already taken, and whether the stops are on;
- the time box;
- that the worker writes nothing outside the repository, and never edits `idea.md`, `proposal.md`, `project-spec.md`, or anything in `pilot/`;
- that when something needs a decision, the worker writes a `[TO CONFIRM: ...]{.tc}` marker and goes on, and stops only at the marked stops;
- that the worker returns the stop message above and nothing else.

The coordinator opens the draft and the log, runs the checker, and checks the list under "Checks before the stop" before relaying.

## Lessons

- 2026-10-28, SS1 (first run and rerun): the stops were off and every decision the worker took alone was one the design stop exists to take; power is planned by default; no cell is dropped from a display; the Abstract carries numbers with uncertainty; no notation table; the opening balances time against burden; the revision pass was added as step 4.
- 2026-10-28, SS1: the runtime estimate from a typical cell fell short by half, which is why step 3.2 times the largest cell too. The first revision pass added about a tenth to the word count by splitting sentences, which is why the second pass also cuts. The "parent manuscript" the first version of this file named as a source of references was an SS1 particular; the inventory now starts from the proposal's list.
- 2026-10-28, workflow 0.2.0: the brief was folded into this file as "Delegating this stage"; the production run and the final render became step 6, since no step had owned them; the drafting log moved to `log/03-manuscript.md`.
