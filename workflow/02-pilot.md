# Stage 2: project spec and pilot

## Purpose

Write the project spec from the final proposal, then run the pre-registered pilot that decides whether the idea survives: pass, fail, or a close call stated both ways. The pilot's code is written as package functions with tests from the first day, so that a pass carries straight into stage 3 with no port.

## Inputs

- `proposal.md`, final, with its pilot plan and pass criteria (and, for a re-pilot, the dated revision section it follows).
- `templates/project-spec.md`, `templates/preregistration.md`, and `templates/pilot-report/` (its `README.md` is the report's manual).
- `manuscript/citations.csv` as stage 1 left it.
- `workflow/rules.md`, in full.

## Preconditions

- `STATUS.md` says `1, proposal final`, and the proposal's open questions are answered.
- The recommended dataset is `verified`, or the pilot is a simulation only and the proposal says so.
- `renv::restore()` and `uv sync` have been run.
- The first message of the stage asks, in one message, for everything that needs the user: the `tools/init.R` command if `DESCRIPTION` still names `projecttemplate` (no author line is needed), and approval of any download (the file names, the source, the sizes, and whether the raw files are committed), since a download needs the user's permission. The stage goes on with what does not depend on the answers.

## Procedure

**1. The spec.**

1. Set `STATUS.md` to `2, spec` and the Open stop row to `none: stage 2 in progress`.
2. Fill `templates/project-spec.md` as `project-spec.md` from the proposal: the question and why it matters, the mechanism, the pilot, the ADEMP skeleton, the application, the target journal (section 6 takes the last three lines of the journal worksheet in `log/01-idea-review.md`), the milestones, what is out of scope, and the reading with its questions. A decision the proposal left to the user carries a `[TO CONFIRM: ...]{.tc}` marker.
3. Section 3 (the pilot) is filled twice. Now it holds the plan: the code path the pilot will have, the three questions, and the pass rule, copied from the proposal. After step 5 it holds the three answers with their numbers and the path of the verdict file.
4. If writing the spec changes the pilot's pass criteria, **stop** and say why before running anything. Filling a case the rule left open (which estimator a clause means, a value between two thresholds) is a reading, not a change: it goes in the pre-registration's section 5 and in the stop message.

**2. Pre-register.**

1. Before any run, fill `templates/preregistration.md` as `pilot/preregistration.md`: the three questions; the pass rule, clause by clause, with how the answers combine into pass, fail, or close call; the design (factors, levels, methods, measures, replicates, seeds); the cells with a known answer; the time box (an hour of compute by default, on three cores unless the user extended the cap for this run); and what will be reported whatever the outcome.
2. Commit it alone ("Stage 2, step 2: pre-registration"), so that its timestamp precedes every result.
3. An amendment before the run (a known-answer check that failed, a definition corrected) is a dated entry in its section 6, committed before the run.

**3. Code.**

1. Copy `manuscript/.Rprofile` to `pilot/.Rprofile`, so that Quarto's R, started in `pilot/`, finds the project library.
2. Every function goes in `R/` with roxygen comments and a test; the data-generating mechanism, the methods, and the summaries are functions.
3. Known-answer checks (the null cell, a closed form, a code-identity check against a literal implementation) are one function, `KnownAnswerChecks()`, that returns a table (check, setting, known answer, what the code gave, Monte Carlo standard error). The testthat test asserts on it, and the pilot script saves it to `pilot/results/known_answers.rds`, which the report's "Known-answer checks" section reads.
4. The data: `analysis/00_download.R` fetches the approved files into `data/raw/`, skipping any that exist. When the pilot has no application part, a description script, `pilot/describe_data.R`, still writes the cohort summary the report's application section needs, to `pilot/results/data_summary.rds`, with its own run file. Every variable code used is read from the dataset's codebook, and the page is logged.
5. The pilot script is `pilot/pilot.R`: it calls `devtools::load_all()`, builds the design table, gives each cell its own seed (seeded blocks within a cell when the cells are fewer than the workers), runs the tasks with `parLapplyLB(chunk.size = 1)` on PSOCK workers with the BLAS pinned (`rules.md`, section 5), saves per-replicate output and per-cell summaries with their Monte Carlo standard errors to `pilot/results/`, writes `pilot/results/run_info.rds` with `run = "pilot"`, and saves `sessionInfo()`.
6. A method whose only implementation is Python goes through the uv environment as `CLAUDE.md` says.
7. Time every cell at ten replicates with every worker loaded as the run will be, project the run from that with the run's own scheduling, and set the replicate count from the time box.
8. A subagent may write tests, on the model `rules.md` section 7 allows, but it runs no R while workers are up and finishes before the timing run. After its last edit, `devtools::document()`, `devtools::test()`, and `devtools::check()` run clean, and the test files are frozen until the results are read.
9. Commit the code, with the lockfile if `DESCRIPTION` changed ("Stage 2, step 3: code").

**4. Run.**

1. Set `STATUS.md` to `2, pilot running`. Run the pilot in the background, within the core cap or the allowance the user gave for this run.
2. A run is not stopped for running longer than projected unless the pre-registration says so. If a run is stopped and restarted, say so and why in the decisions log, after checking `uptime` and the run's log.
3. The application part of the pilot, if the proposal has one, runs the same way with its own run file.

**5. Verdict.**

1. Answer the three questions with numbers against the pre-registered rule, clause by clause, and combine them as the rule says. A close call is stated both ways, with the reading that passes and the reading that fails.
2. The verdict is a table in `pilot/results/` written by a script (`pilot/verdict.R`), not a judgment typed into the report.
3. Complete section 3 of `project-spec.md` with the three answers and the verdict file's path.

**6. Decisions log.** `pilot/decisions.md`: D0, the literature pass (a pointer to the proposal's prior-work section and anything read since); D1, the status call with both readings; then every decision taken while building and running (what, the alternatives, why, what the user should check), each pointing at the file that holds its numbers; a final section on what was not done. Nothing in the log is a number that is not in a saved file. The process log (what was read, the timing, the run) is `log/02-pilot.md`.

**7. The report.**

1. Copy `templates/pilot-report/pilot-report-template.qmd` to `pilot/pilot-report.qmd` and fill it as `templates/pilot-report/README.md` says. The sections that describe the idea, the data, and the design may be written during the run; the Summary, the findings, and "Potential impact" are written after the verdict, since they state what the pilot decided.
2. Render; run `python3 -I templates/pilot-report/check-report.py pilot/pilot-report.qmd pilot/pilot-report.html` from the project root; look at the HTML.
3. Make one revision pass for clarity (`03-manuscript.md`, step 4).

**8. Status.**

1. Write `2, piloted-pass`, `2, piloted-fail`, or `2, piloted-close-call` in `STATUS.md` with the date, and the stage record line naming `pilot/pilot-report.html`.
2. Commit, with the rendered report ("Stage 2, step 8: pilot report, piloted-pass").

**Stop.** Return the report, the verdict, the decisions log, and the spec. The user decides.

- *Pass:* stage 3 starts. A close call the user reads as a pass, or a fail the user reads as a close call because a clause's premise failed or the shortfall is within its Monte Carlo error, is the user's reading: it goes in the stage record line, and the questions it leaves open go to stage 3's design proposal.
- *A revised proposal and a re-pilot:* the user revises the proposal, or asks the agent to. The revision is a dated section at the end of `proposal.md` that governs where it differs; the sections before it stand as the record; the markdown revision pass applies. The revised proposal and its pass rule get their own stop before the re-pilot, unless the user says to go straight on, in which case the revision carries a `[TO CONFIRM]` marker and the re-pilot's stop message names it. The re-pilot runs in `pilot-b/` (then `pilot-c/`) through steps 2 to 8, with its decisions in `pilot-b/decisions.md`, its process log under its own heading in `log/02-pilot.md` with the user's answers as decisions D-S1, D-S2, and so on, and the stage record keeping every stop line. A re-pilot's report may read an earlier pilot's data description from its folder, read-only.
- *A re-scope:* the same, with the revision changing the question or the aims.
- *Dropped or parked:* `STATUS.md` says `dropped (reason)` or `parked (reason)`, after which stage 3 writes the memo once, covering every pilot folder (`03-manuscript.md`, "Memo mode"). A memo is not written after each failed pilot of a sequence, only after the decision that ends it.

## Outputs

- `project-spec.md`.
- `pilot/preregistration.md`, `pilot/pilot.R`, `pilot/verdict.R`, `pilot/results/`, `pilot/decisions.md`, `pilot/pilot-report.qmd` and `.html`, `pilot/.Rprofile`; `pilot/describe_data.R` when the pilot has no application part.
- Functions in `R/` with tests, `KnownAnswerChecks()` among them.
- `log/02-pilot.md`: what was read, the timing, the run, the decisions by number, the process feedback; a re-pilot under its own heading.

## Checks before the stop

- The pre-registration's commit precedes every file in `pilot/results/`, and every amendment's commit precedes the run.
- The tests and `devtools::check()` pass on the frozen test files; the known-answer tests exist for every closed form the pilot uses, and `pilot/results/known_answers.rds` matches what the test asserted.
- Every number in the report and the decisions log is in a saved file.
- The verdict follows the pre-registered rule and its combination rule, or the deviation is stated and marked; every reading of an open case is listed.
- The report's checker reports no errors.
- Section 3 of the spec holds the answers and the verdict file's path.

## What to return at the stop

One message: the status; the three answers with their numbers; the pass rule they were judged against, with every reading of an open case; the close-call reading if there is one; the paths to the report, the verdict file, the decisions log, and the spec; the runtime, the replicate count, and the cores used; the spec's open markers; and what the agent was unsure of.

## Delegating this stage

A worker reads this file, `rules.md`, and `templates/pilot-report/README.md` in full; the brief adds the decisions already taken, the time box (the hour of compute, and two hours of agent time around it), and the core cap. The worker returns the stop message above and nothing else. The coordinator opens the report, checks the pre-registration's commit against the result files' timestamps, and runs the checker before relaying.

## Lessons

- 2026-10-29, pool-first-or-optimize-first (the first run: three pilots, 32 feedback items in its log): the setup questions go in one message, and a download needs approval; a pilot without an application part still needs a data description; variable codes come from the codebook; the pass rule needs a combination rule and a reading for a threshold near its Monte Carlo error, so `templates/preregistration.md` exists; filling an open case is a reading; every cell is timed at ten replicates with the workers loaded; known-answer checks are one function the test asserts and the script saves; a subagent runs no R while workers are up, and tests are frozen before the pre-run check; the code is committed before the run; `parLapplyLB()` chunks tasks unless told not to, and the cells are split into blocks when they are fewer than the workers; the impact section is written after the verdict; an amendment before the run is allowed; a revised proposal gets its own stop unless the user waives it; a re-pilot's log goes under its own heading; the user's reading at a stop is recorded; the agent's time was about forty minutes per pilot around the run, so the time box is two hours.
