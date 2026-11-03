# Stage 1: idea review

## Purpose

Turn `idea.md`, in whatever state it is in, into a proposal the user can judge: is the idea new, does it fit the literature, is its theory sound, is there a usable dataset, and what would a pilot have to show. Everything the idea claims is verified; everything it lacks is supplied or marked. The deliverable is `proposal.md`.

## Inputs

- `idea.md`. It may hold a paragraph or a full plan with aims, a literature review, a derivation, and datasets. Nothing in it is taken as verified. A header that names its author or links a document is not copied into any deliverable or log.
- `templates/proposal.md`, the form this stage fills.
- `workflow/journals/`, for the target journal.
- `workflow/rules.md`, in full.

## Preconditions

- No Zotero library is used (`rules.md`, section 2). The reference list `manuscript/references.md` holds the seed entries; this stage adds every source the proposal cites. If the user has put PDFs in `manuscript/sources/`, they are read as full texts.
- The search tools, as the session sees them: the PubMed connector (its metadata tool returns about twenty records per call and spills to a file beyond about twelve, so batch twelve identifiers per call); the bioRxiv connector (no keyword search; cover bioRxiv and medRxiv by a web search restricted to their domains); Consensus (about three hits per query); web search and page fetches (Google Scholar, GitHub, GEO, the data portals). Searching is allowed in this stage within the budget of step 3; every search is logged.
- `log/01-idea-review.md` is started at the first step and holds the inventory, the searches, the decisions, and the process feedback.

## The paper test, the two paper types, and the three tools

**The two paper types.** A *critique* asks what a procedure in wide use estimates in a setting it was not built for: it states the estimand, derives the target and the bias term, confirms them by simulation, offers a correction or a diagnostic, and shows the effect on real data. A *constructive method paper* proposes a procedure for a stated estimand, shows its properties by theory and simulation, compares it with the existing methods for the same estimand, and applies it. Every idea is one or the other, and the proposal says which. An idea that carries a critique and a new procedure as co-primary aims is read as the type its main claim belongs to, and both readings are named in the first message (step 1.4).

**The paper test** is seven questions, written for a critique. For a constructive idea, read question 1 as the estimand and the gap the existing methods leave, question 2 as the proposed procedure, question 4 as its properties under the stated conditions (bias, variance, consistency), and question 6 as the comparison with the existing methods; questions 3, 5, and 7 stay as they are.

1. A procedure in wide use: which, in which package, with what default, and how its output is read.
2. A setting it was not built for but is used in: the heterogeneity in question (means, variances, composition, group size, observations per subject, architecture, batch).
3. The estimand, stated as a functional of a specific distribution: what users believe the output estimates.
4. The target and the bias term: what the procedure converges to under the setting, and the difference from the estimand, sketched with one of the three tools below where one applies. The sketch is labeled as a sketch, states its assumptions (which moments are finite, what is held fixed as the sample grows), and says what a full derivation would need.
5. Confirmation by simulation: the smallest design that would show the effect, with a null cell and a cell with a known answer.
6. A correction or a diagnostic, read off the formula, or "none yet".
7. The application: a confirmed dataset and the one thing it would show.

A "no" on question 3 or 4 is stated plainly; it is the most common reason an idea is not yet a project.

**The three tools** for sketching a target and a bias term.

- *Mixture algebra.* When a statistic is computed on data pooled across groups, every moment of the pooled data is a mixture of the group moments: the pooled mean is the fraction-weighted mean of the group means, the pooled variance is the fraction-weighted within-group variance plus the between-group spread of the means, and the pooled covariance follows the same pattern. Write the statistic's population version in these mixture moments and compare it with the within-group quantity the user has in mind; the difference is the bias term, as a function of the group fractions and the differences between groups.
- *Projection algebra.* When a procedure centers, regresses out, residualizes, or leaves one sample out, each step is a linear projection of the data. Write the procedure as the composition of its projections and ask what the estimand looks like after each: the target is the projected quantity, and the bias term is what the projection kept that the estimand excludes.
- *The second-order expansion.* When the statistic is a nonlinear function of sample moments (a ratio, a correlation, a logarithm), expand it to second order around its population value. The first-order term is the influence of one observation, which is what a leave-one-out or jackknife procedure measures; the second-order term is the first-order bias of the statistic. This is the delta method carried one order further.

## Procedure

**1. Inventory the idea.**

1. Read `idea.md`. In the log, write what it states for each of: the question, the procedure in question, the setting, the mechanism, the estimand, any claimed theory, the aims, the literature it cites, the user's own prior work, the datasets it names, the journal, and constraints. For each, say whether it is stated, implied, or absent. Do not fill a gap yet.
2. If `DESCRIPTION` still names `projecttemplate`, `tools/init.R` has not been run: the first message says so and proposes the command (`Rscript tools/init.R <name> --title "..."`, with a package name derived from the idea's title; no author line is needed, `tools/authors.R` sets the authors before the final render). The stage goes on without it.
3. Set `STATUS.md` to `1, reviewing` and the Open stop row to `none: stage 1 in progress`.
4. Send one message before any search: the question as read, in one sentence, and the paper type as read; when the idea carries a correction or a critique as a primary aim beside a new procedure, both readings, the pick, and a one-line reason. Do not wait for an answer; a misreading is caught at once, and the stage goes on. In a session that cannot deliver a message before its turn ends, write the same lines at the top of the log and go on.

**2. The paper test.** Answer the seven questions as far as the idea allows, each with what is missing named. Write the answers in the log as a three-column table (question, answer, what is missing).

**3. Prior work and novelty.**

1. Read `manuscript/references.md` and `manuscript/sources/` first: what they already hold is not looked up again. Then open the record of every title and DOI the idea cites (outside the budget, as an identifier lookup). Log these lookups with the queries.
2. Search for what has been done: the procedure's own papers and their critiques, the mechanism in other fields (measurement error, meta-analysis, psychometrics, mixed models are frequent homes), benchmarks that observed the artifact, and fixes that exist. For a constructive idea, the existing methods for the same estimand and their comparisons.
3. Budget: about twenty literature queries across the sources, a PubMed or web query counting one and a Consensus query one third. A lookup made only to see the identifier of a source the idea already cites is outside the budget. Read the abstract of every hit whose title could be relevant, except that an applied paper whose abstract names no method is logged by count, not read. Read the full text of at most ten sources; a page summary with quotations, used when the connector returns an empty full text, is a partial reading and is marked so in the log. Stop when two consecutive queries on different sources add no relevant source. Log every query with its source, the date, which hits were read, and the time spent.
4. Delegation to workers pays only when a source family needs more than about ten queries, or when a full text must be read in whole by a second reader; otherwise the coordinator searches. A worker, one per source family, returns its log rows and, for each relevant source, what it did and what it did not do, read from the abstract or the full text and never from a title. The coordinator reads the full text of every source the verdict rests on.
5. Give one verdict with its reason: the mechanism is new; the artifact is known informally with no closed form and no fix; or the result is published, with the source. Say what the idea adds beyond the closest source. If the user's own prior work is named in `idea.md`, say how the idea relates to it.
6. List every source the proposal will cite, with the full citation, the identifier as seen on the page, and the grade it will carry (`core` needs the full text, `supporting` needs the abstract; `rules.md`, section 2), as entries for `manuscript/references.md`, each marked with whether an open full text was found.

**4. Theory check.** For each derivation, proof sketch, or claimed result in the idea: restate it, check each step, name the first step that does not hold or is not justified, and propose the numerical check (a simulation or a special case with a known answer) that would catch an error in it. For the suspected mechanism, give the first-order sketch from question 4 with its assumptions. A sketch the idea lacks may be added, labeled as the agent's. Do not present a sketch as a result.

**5. Datasets.**

1. Find open datasets that fit the setting: the groups the question needs, the sample sizes, the measurement type, and single-cell or spatial where the question allows. Open at most five candidates; a dataset with several files or cycles is one candidate.
2. For each candidate, open the accession or portal and record what is deposited (samples by group, format, processing level, access conditions, size), with the date. When a fetch fails, find the current page by web search before marking the dataset `verify`.
3. Mark each `verified` (opened and matches), `verify` (named in the literature, not opened), or `unavailable`.
4. Recommend one with a fallback, and say what the application would show on it.

**6. Feasibility and the pilot plan.**

1. Write the first simulation: the design cells, the methods, the measures, the known-answer cells, and an estimate of runtime. The estimate may come from a timing run of at most ten replicates of one cell, labeled as a timing run and never reported as a result; otherwise from operation counts, labeled as such.
2. Write the three pilot questions with pass criteria as numbers, decided before any run: does the effect exist; is it large enough to matter at realistic sizes; is there a fix or a diagnostic. Each clause names the quantity it refers to, the threshold, the cells, and how a value within its Monte Carlo standard error is read; no clause presumes the answer to another question; every coverage criterion has a size criterion beside it; and the plan says how the three answers combine into pass, fail, or close call (`templates/preregistration.md` is the form stage 2 fills from this).
3. A design choice in the plan (a threshold, a replicate count, a bandwidth rule) carries a reason in the table; it is neither a claim that needs a source nor a decision that needs a marker.
4. Say what code and data already exist. This is the draft pre-registration that stage 2 carries into `pilot/preregistration.md`.

**7. Impact and fit.** The size of the user base and how often the output is read the vulnerable way; the plausible size of the artifact at realistic sizes, from the mechanism; whether a correction or only a diagnostic is in sight; the paper type. Fill the journal guide's worksheet (`workflow/journals/README.md`) in this stage's log, ending in a target and a fallback; stage 2 copies its last three lines into section 6 of the spec.

**8. Write `proposal.md`.**

1. Fill `templates/proposal.md` in the proposal's own words, not by copying `idea.md`. Every claim has a source or a `[TO CONFIRM: ...]{.tc}` marker. Every decision that is the user's carries a marker. The last two sections before the Revisions are the open questions and the reference list.
2. Make one revision pass for clarity in the markdown form (`03-manuscript.md`, step 4.7) before the stop.
3. Set `STATUS.md` to `1, proposal at stop 1` with the Open stop row naming the stop and `proposal.md`, write the stage record line, and commit ("Stage 1, step 8: proposal").

**Stop 1.** Return `proposal.md` and the log. The user reviews it and answers the open questions. The user may also add PDFs to `manuscript/sources/` for the core citations whose full text the agent could not open; this is optional at this stop. The user is not asked to maintain the reference list. Wait.

**9. The reference check.** When the user has answered stop 1 (the agent does this itself; no library update is waited for):

1. Set `STATUS.md` to `1, reference check`.
2. For each cited source, open its record by DOI (the Crossref record at `https://api.crossref.org/works/<doi>` or the DOI's landing page), then by title, and a book by author, and write or correct its entry in `manuscript/references.md` from that record, with the `record` field naming it and the date. A source is available when its record was opened, its entry is complete enough to cite, and either its full text was read (an open copy, or a PDF in `manuscript/sources/`) or the citation is supporting and the abstract states the claim (`rules.md`, section 2); a pre-1980 source or a book counts without a full text. A core citation without a full text stays usable with `full_text: pending`.
3. Start `manuscript/citations.csv` with one row per source, under the header the skeleton ships: `key, read_from, grade, section, why, origin, identifier, identifier_source, pdf, usable, deviations_from_record, support_passage, read_date, verified_by, verified_date`. `read_from` is the URL or file the passage was read from; grade is `core`, `supporting`, or `definitional`; section is the proposal's section; `pdf` is `yes` (full text read), `no` (a supporting citation read from its abstract), or `pending` (a core citation waiting for its full text); the passage is the one that supports the claim, quoted from the text read, with the date read; a scanned PDF without a text layer gets the passage `unreadable (no text layer)`, stays usable, and is listed for the user; `verified_by` and `verified_date` stay empty until the reference review.
4. Run `python3 -I manuscript/build-bib.py manuscript/references.md manuscript/references.bib --citations manuscript/citations.csv` and correct every fault it lists in `references.md`, recording each correction in `deviations_from_record`.
5. Rebuild the proposal's citations from the checklist: align the author-date years with the entries and list the keys in section 10, with the core citations still `pending`. Add a dated entry to the proposal's Revisions section, set `STATUS.md` to `1, proposal final`, and commit ("Stage 1, step 9: proposal final"). No stop follows unless a record could not be opened; then return that list in one message and go on.

## Outputs

- `proposal.md`, final after the reference check.
- `log/01-idea-review.md`: the inventory, the paper test, every search, the datasets opened, the journal worksheet, the decisions (D-numbered), the time per step, and the process feedback.
- `manuscript/citations.csv` started; `manuscript/references.md` holds an entry for every source the proposal cites, and `references.bib` is rebuilt from it.

## Checks before the stop

- Every source the proposal cites has an entry in `manuscript/references.md` with an identifier the agent saw, the record it was copied from, and its grade.
- Every dataset marked `verified` was opened in this stage, with the date and what was seen.
- Every search is logged with query, source, and date, and the budget of step 3 was kept or the overrun is explained in the log.
- The proposal states the estimand as a functional, or says plainly that it cannot yet.
- The proposal says which paper type the idea is.
- The pilot plan has pass criteria as numbers, and every design choice in it has a reason.
- No claim without a source or a marker; the writing rules of `rules.md`, section 4, hold; nothing from the `idea.md` header is in the proposal or the log.

## What to return at the stop

One message: the verdict in a sentence; the path to `proposal.md` and the log; the novelty verdict with the closest source; the recommended dataset and its status; the pilot's pass criteria; the count of open questions in the proposal; the reference list's count, and the core citations whose full text is pending (the PDFs the user may add to `manuscript/sources/`, optional); what the agent was unsure of; and, on a separate line, any workflow matter waiting on the user (the `tools/init.R` author line), which is not counted among the open questions.

## Delegating this stage

A worker reads this file and `rules.md` in full; the brief adds the decisions already taken, the time box (two hours of agent time for steps 1 to 8; the first run took half that), and whether the worker also runs step 9 after the user's answer. The worker returns the stop message above and nothing else. The coordinator opens `proposal.md` and the log and checks the list under "Checks before the stop" before relaying.

## Lessons

- 2026-10-28, pool-first-or-optimize-first (the first run, 29 feedback items in its log): the tools are named as the session sees them, with Consensus at a third of a query and the PubMed batching note; identifier lookups are outside the budget; applied papers without a method in the abstract are counted, not read; a page summary is a partial reading; Zotero is searched first; delegation has a threshold; sketches the idea lacks may be added; a dataset is one candidate whatever its files; a failed fetch is followed by a web search; a timing run of ten replicates is allowed; design choices need reasons, not sources; the worksheet lives in this log; the markdown revision pass; the Open stop phrase; the init reminder; the `idea.md` header is not copied; both paper-type readings are named when a correction is a primary aim (the first reading went the wrong way and cost three sections); the Zotero check's DOI query, complete record mode, one full-text search per passage, scanned PDFs, deferred faults, and what the rebuild means (in this copy the Zotero check became the reference check of step 9, 2026-11-03); the time box fell from a day to two hours. The abstract rule for supporting citations is in `rules.md`, section 2.
