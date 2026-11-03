# Rules for every stage

These rules apply in every stage. A stage file may add rules; it may not remove one. Where a stage file and this file disagree, this file wins, and the disagreement is a lesson for `CHANGELOG.md`.

The files in `workflow/` and `templates/` are written for the agent that runs the stages. The user reads `STATUS.md` and the deliverables. So a stage file is a checklist the agent can execute and verify against, as long as it needs to be, and never ambiguous.

## 1. Stops, status, and commits

- Every stage ends at a stop with one deliverable the user reads. No stage starts itself; the user's message starts it.
- `STATUS.md` names the stage and the open stop. The agent updates it when it reaches a stop and when a stop is answered. On any message, the agent reads `STATUS.md` first, then the stage file it names, then the stage's log.
- Within a stage, the stops the stage file marks are real stops: the agent returns what the stop asks for and waits. If the user has switched the stops off for a run, the agent decides at each one, records the decision and its reason in the stage's log under "Decisions made in place of a stop", and marks in the deliverable what the user should look at.
- When a stop has been answered by a ruling, the agent applies the ruling. If the ruling's stated reason turns out to be wrong, the agent keeps the ruling, says so in the log with a dated note (and in `protocol.md` when the ruling concerns the design), and marks it in the deliverable.
- The user may change at any stop. Every user is treated the same, and nothing in a deliverable or a log names the user; a header in `idea.md` that names its author or links a document is not copied into any deliverable or log.
- While a stage is in progress, the Open stop row of `STATUS.md` reads `none: stage N in progress`; at a stop it names the stop and the deliverable.
- The agent commits without being asked at these points, and nowhere else unless asked: when a pre-registration or `protocol.md` is written, before any run it governs; when a pilot's code is complete and tested, before its run, with the lockfile if `DESCRIPTION` changed; at every stop, with the deliverable and its rendered file; after every revision round; at the end of a production run; at the end of a stage. A sync of the template into a project updates the version row of `STATUS.md` in the same commit. The commit message starts with the stage and the step ("Stage 2, step 2: pre-registration"). Nothing is pushed unless the user asks.
- A rendered deliverable (the pilot report, the manuscript, the background report) is committed at its stop and after each revision round, so that a handover carries what the user read. It is not committed after every render.

## 2. Sources

- This project keeps no Zotero library. The reference list is `references/references.md`, a Markdown file the agent keeps, and it is the only source for anything cited in a deliverable from the proposal onward. Each entry's fields are copied from a record the agent opened (the DOI's Crossref record or the publisher's page, PubMed, arXiv, bioRxiv, CRAN or Bioconductor for software), and its `record` field names that record and the date. `manuscript/references.bib` is generated from the list by `manuscript/build-bib.py` and never edited by hand. (Adapted 2026-11-03: the user does not use Zotero and reviews the reference list once, at the end.)
- A citation is an entry in `references.md` with the passage that supports the claim recorded in `manuscript/citations.csv` (started at the proposal stage) and the date it was read. A citation that only names a method or a dataset is marked `definitional`. A `supporting` citation, one that says only that an approach, a result, or a dataset exists, is cited from the abstract when the abstract states that, and needs no full text; a `core` citation, one the argument rests on or whose claim the abstract does not state, needs the full text. (Adopted 2026-10-28, from stage 1 of the first project.)
- Full text comes from an open copy the agent opened (PubMed Central, arXiv, bioRxiv, the publisher's open page), whose URL goes in the entry's `full_text` field, or from a PDF the user puts in `references/pdfs/<key>.pdf` (git-ignored, since publishers' PDFs are not shared). A core citation whose full text the agent cannot reach is drafted from the abstract with `full_text: pending` and `pdf` = `pending` in the checklist, and is listed for the user, who may add the PDF at any stop. Requests for PDFs never block a stage before the reference review; none may remain pending at the final render.
- Searching the literature (PubMed, bioRxiv, Consensus, the browser) is allowed only where a stage file says so (the idea review, the mock review's first and third reviewers), within the budget that stage file sets. Every search is logged with its query, source, and date. Nothing found is relied on until it has an entry in `references.md`, with full text where the citation is core, or `pending` as above.
- Nothing from memory. A fact about the literature or about a dataset points at a file or a page the agent opened. An identifier (DOI, accession) is one the agent saw, never one it reconstructed.
- A fault in an entry (a missing DOI, a lowercased journal, a cut author list, a date in the pages field) is corrected in `references.md` against the published article, and the correction is recorded in the checklist's `deviations_from_record`; it is never patched in the bib. `build-bib.py` lists remaining faults in `references/reference-fixes.md`.
- If a record cannot be opened (the network is down, a page refuses the fetch), the agent says so, leaves the entry's `record` field reading `not opened`, and lists it for the user; such an entry is not usable until its record is opened.
- The user reviews `references.md` once, at the reference review of `03-manuscript.md`, step 6, before the final render, and is not asked to maintain the list at earlier stops.

## 3. Numbers

- Every number in the manuscript, the background report, the slides, and the poster is computed from files in `results/` at render time, through `prov()` and the other helpers, and carries the label of the run that produced it (`pilot`, `quick`, `production`). Nothing is typed.
- Every analysis script writes its run file (`results/run_info.rds`, or `results/<name>_run_info.rds` for a second script) and `sessionInfo()`; a Python script writes the same fields to a JSON file.
- A simulated rate, bias, or coverage is reported with its Monte Carlo standard error. A difference is called nonzero only when it exceeds about three Monte Carlo standard errors; otherwise it is marked.
- A finding stated in prose is shown in a table or figure, and no cell that supports a finding is dropped from a display; a cell where a method misbehaves gets its own row, panel, or table.
- A simulation study always plans power, not only type I error. For every method whose type I error is controlled (under about 10% for a test at 5%), the design has cells with a true effect whose levels run from low power to about 80%, calibrated with a few low-replicate cells before the full run. A method whose type I error is not controlled is left out of the power cells, and the design says so.
- Every varied factor runs from a small effect to a large one, and the application places the real data on each gradient.

## 4. Writing

- Plain language first, then the formal statement, with full precision kept.
- One idea per sentence, in a simple structure. The reader's time is balanced against the reader's burden: a simple topic takes one sentence, a complex one up to three simple sentences that build on each other, never one sentence that packs them together and never a long preamble.
- Why before what. A sentence that leaves the reader asking why, followed by a description, loses the reader.
- Keep the paragraph's subject rather than introducing another to carry a fact about it ("these methods were developed to", not "their authors' aim was to").
- No claim without a source, the first sentence included. No em or en dashes. The Oxford comma. No bold lead-ins outside an abstract with required headings and the labels a template carries (a proposal's "Question:" line). No footnotes in a manuscript (a report may use them to define a term). "We", never "I".
- Keep estimand, estimator, statistic, and limit distinct. Say what "trustworthy", "safe", or "valid" refers to. No workflow vocabulary in a deliverable meant for readers outside the project (harness, pilot, re-pilot, pre-registration, pass rule, card, worker, quick run, spec, the report, too small to matter); a memo describes its design and its criteria as a study, without those names.
- The word lists below are the only copies; the manuscript checker carries the same lists, and a change is made in both places. Delete on sight: considerably, dramatically, enormously, exceptionally, extremely, highly, quite, remarkably, substantially, very, actually, basically, clearly, essentially, in fact, indeed, just, kind of, of course, really, simply, sort of, certainly, obviously, undoubtedly, important, interesting, notable, remarkable, considerable, major, minor, substantial. Justify or replace: apparently, arguably, can, conceivably, could, maybe, may, might, perhaps, potentially, possibly, presumably, probably, likely, seemingly, would, commonly, frequently, generally, largely, mostly, often, rarely, typically, usually.
- A table of notation is never included. A design table with a reason column is welcome; its caption defines every label it uses and its cells read on their own.
- An abstract gives numeric results with their uncertainty for every claim.
- Every deliverable goes through at least one revision pass for clarity before the user reads it: `03-manuscript.md`, step 4, for a rendered document, and its step 4.7 for a deliverable written in markdown (the proposal, the spec, a review, a response).

## 5. Environment

- R packages come from the project library (`renv::restore()`); Python from the project environment (`uv sync`). Nothing is installed outside them, and never through Homebrew, pyenv, or conda on the project's behalf. After a change to `DESCRIPTION` or `pyproject.toml`, snapshot and commit the lockfile.
- Parallel code uses PSOCK workers with the BLAS pinned to one thread in each; at most three cores at once, counting the workers, unless the user extends the cap for one run, which the decisions log records and which ends with that run. The tasks are the cells, or seeded blocks within a cell when the cells are fewer than the workers; `parLapplyLB()` takes `chunk.size = 1`, since cells differ in cost; a timing run loads every worker as the run will, and its projection uses the run's own scheduling. A background run is stopped with the task tool, never with `pkill`, and not for running long unless its pre-registration says so. Before restarting anything that looks dead, check `uptime` and the run's own log.
- While workers are up, no subagent runs R. The test files are frozen before the test and check runs that precede a run; a test edited afterwards means the suite runs again before the results are read.
- Every R command runs from the project root or from `manuscript/`, where `.Rprofile` activates the library. The first R call in a fresh clone makes renv install itself into `renv/` (its bootstrap) and nothing else; that is expected and not an install outside the project library.
- No simulation runs before `protocol.md` is written, except a pilot's own pre-registered run. A pre-registration or a protocol may be amended before any run it governs, as a dated entry committed before the run; after a run, a change is recorded, never applied to that run.

## 6. Logs and feedback

- Every stage keeps its log in `log/`, named for the stage file: `log/01-idea-review.md`, `log/02-pilot.md`, `log/03-manuscript.md` (the drafting log, whose opening paragraph the draft's banner reads), `log/04-background-report.md`, `log/05-mock-review.md`, `log/06-slides.md`, `log/07-poster.md`, `log/08-publish.md`. The log holds what was read, what was decided and why (decisions numbered D0, D1, ...), what was carried from where, what was unsure, and the time each step took. The pilot's `pilot/decisions.md` is part of the pilot's deliverable, which the report embeds, and is not the process log.
- Every stage's log ends with "Process feedback": what in the stage file was unclear, could be simplified, or was missing, with times. The user folds accepted lessons into the stage file and `CHANGELOG.md`.
- When the user's comment on a deliverable states a general rule, the agent applies the comment and proposes the rule for the stage file; the user decides whether it is adopted.

## 7. Workers

- A stage may be run by the agent in the conversation (the coordinator) or delegated to a worker. The worker's brief is the stage file itself, read in full, plus the section "Delegating this stage" at its end and the decisions already taken; a brief in a message adds only the decisions and the time box. A worker's report is a report, not proof: the coordinator verifies the files before relaying it.
- Workers do not install into the user's library, do not write outside the project, and do not edit the deliverables of earlier stages except where the stage file says a later stage may raise issues (the background report, the mock review).
- Two writers never touch the same files at once.

## 8. AI conduct

- Do not fabricate citations, numbers, or results. Say when something could not be verified.
- When asked for a derivation, also propose the numerical check that would catch an error in it.
- Flag scope creep against `proposal.md`, `project-spec.md`, and `protocol.md`.
- Explain first and fix second when asked why something is wrong.
- The user reviews every deliverable; the agent never marks a stop as answered on its own.

## 9. Vocabulary

The words the stage files use, so that none is guessed at.

- **Stop:** a point where the agent returns one message, named in the stage file, and waits for the user.
- **Deliverable:** the file the user reads at a stop; `STATUS.md` names it.
- **Settled:** a draft or report the user has declared ready for the next stage.
- **Marker:** `[TO CONFIRM: ...]{.tc}` for a decision that is the user's, `[CITE: ...]{.cite}` for a claim without a usable source, `[FILL: ...]` only in a template.
- **Run label:** the `run` field of a run file, one of `pilot`, `quick`, `production`. A quick run is the full design at a replicate count that finishes within an hour; a production run is the design at the replicate count `protocol.md` sets.
- **The paper test:** the seven questions in `01-idea-review.md`, which also defines the two paper types (a critique, a constructive method) and the three algebraic tools used to sketch a bias term.
- **Known-answer check:** a run of the simulation code on a case whose answer is known (a null cell, a closed form, a literal implementation), compared with that answer. It is a test in `tests/testthat/`, and the pilot report displays its outcome; it is never content of a manuscript.
- **Coordinator, worker:** the agent in the conversation, and an agent it delegates a stage or a step to.
- **Round:** one message of comments from the user on a draft, or one pass of the three mock reviewers.
- **Reading:** how an open case of a pass rule is decided when the rule is applied (which estimator a clause meant, a value between two thresholds), listed in the pre-registration and the stop message; a reading is not a change to the rule.
- **Memo:** the manuscript written once, in memo mode of stage 3, after a dropped or parked decision at the stage 2 stop: the same document in form, on the pilots' numbers, with APA references and no target journal, so that the review, the methods, the derivations, and the results are kept.
- **Core, supporting, definitional:** the grades of a citation in `citations.csv`. Core carries the argument and needs the full text; supporting says only that something exists and may rest on the abstract; definitional names a method or a dataset.
- **Reference list:** `references/references.md`, the Markdown list of every source the project cites, from which `references.bib` is generated. **Reference review:** the user's one reading of that list, at `03-manuscript.md`, step 6.
