# Log, stage 2: project spec and pilot

Workflow 0.2.4-md. Started 2026-11-03, on the user's "START THE PILOT".

## Setup

- No setup questions were asked in a first message: `tools/init.R` was proposed in stage 1 (the package name `lionessifn`) and the user's instruction to start the pilot was taken as approval; no download was needed, since the pilot is a simulation only (proposal, section 7) and PRECISESADS is under controlled access.
- R was not installed. Installed R 4.6.2 from CRAN's Ubuntu repository (Ubuntu's own was 4.3.3; `renv.lock` recorded 4.5.2, and the snapshot updated it to 4.6.2). `renv::restore()` from Posit Package Manager binaries: 101 packages in 28 seconds. glmnet 5.2 added to `DESCRIPTION` and the lockfile. Quarto 1.11.9 installed from PyPI (`quarto-cli`), since GitHub release downloads are blocked by the network policy. The en_US.UTF-8 locale was generated so that `R CMD check` runs clean.
- `tools/init.R lionessifn --title "LIONESS Beyond the IFN Score in SLE and RA" --no-python`: the template's examples and the Python environment removed. `^references$` added to `.Rbuildignore`.

## Spec and pre-registration

- `project-spec.md` from the final proposal; section 3 holds the plan. Writing the spec did not change the pass criteria.
- `pilot/preregistration.md` committed alone (commit "Stage 2, step 2: pre-registration") before any code ran. Readings of four open cases were written before the run (section 5).

## Code

- Functions in `R/lioness.R`, `R/simulate.R`, `R/models.R`, `R/checks.R`; 34 tests pass; `devtools::check()`: 0 errors, 0 warnings, 0 notes. Committed ("Stage 2, step 3: code").
- One test first failed on sampling noise (a mean correlation of 0.287 against 0.3 with a relative tolerance of 3%); the check was changed to an absolute tolerance of 0.04, about four standard errors, before the code commit.

## Timing and run

- Timing run: 10 replicates per cell, three PSOCK workers, the run's own scheduling: 181 seconds (`pilot/results/timing.rds`). 200 replicates projected to about 3,620 seconds, over the one-hour box, so 180 replicates per cell, entered as an amendment and committed before the run.
- Run: `Rscript pilot/pilot.R --reps 180`, started 2026-11-03 in the background on three workers (machine of 4 cores).
- Run finished: 16 cells by 180 replicates in 3,239 seconds (`pilot/results/run_info.rds`), within the box; no restart.

## Verdict

- `Rscript pilot/verdict.R`: `piloted-fail` (`pilot/results/verdict.rds`). Question 1 failed on size, question 2 failed, 3(a) passed in all seven cells, 3(b) failed. No clause within three MCSE of its threshold; the readings of the pre-registration's section 5 were applied as written (the "all cells" reading of 3(a) and the paired-difference reading of 3(b) decided their clauses; neither open combination case arose).
- Known-answer checks: code identities to better than 1e-13; the null cells and the mean-shift formula within their MCSE (`pilot/results/known_answers.rds`).
- Exploratory probe after the verdict (`pilot/posthoc/probe_cell13.R`, decisions D9): first-order edges as features match the exact edges in cell 13; the shortfall of 3(b) lies in the pre-registered comparator. `LionessTestEdgesFirstOrder()` and its test were added for it after the results were read (35 tests pass).

## Report

- `pilot/pilot-report.qmd` rendered with Quarto 1.11.9; the checker reports no errors or warnings. Citeproc writes page ranges with en dashes, which the checker rejects; `pilot/no-en-dash.lua` runs citeproc inside the filter and replaces them, with `citeproc: false` in the YAML. Looked at the rendered page: the summary, the design diagram, the gains figure, the verdict and known-answer tables.
- Revision pass (`03-manuscript.md`, step 4, rendered form): the plain-language section and the Potential impact section were read as a reader new to the project. One sentence claimed LIONESS is "among the most used" methods without a source; replaced by what the sources state. No section changed by more than three sentences, so no second pass.

## Process feedback

1. The stage file assumes R and Quarto are installed. In a fresh cloud container they were not, and Quarto's GitHub releases were blocked; installing R from CRAN's Ubuntu repository and Quarto from PyPI took about ten minutes. A setup note in `02-pilot.md` would save the search.
2. The pass rule's "matched quadratic model" fixed a parametrization (products and squares as separate penalized features) that the theory does not single out. With penalized fitting, two models of the same information are not equivalent; a pre-registration should name the parametrization of a matched comparator and say why. This is the lesson of clause 3(b).
3. Clause 3(a) passed partly because neither model gained anything over $R_1$ in those cells; a clause of the form "A matches B" should be paired with a clause that A or B has something to match, or it can pass on two nulls.
4. The checker's dash rule meets the default citeproc output in any report that cites with a bibliography; the Lua filter in `pilot/` could move to `templates/pilot-report/`.
5. The pre-registered question 1 threshold (0.05) was set before any sense of scale; the timing run gave no effect sizes. A ten-replicate look at the effect, labelled and not used for the verdict, would have informed the threshold, but it would also have weakened the pre-registration; the trade-off belongs in the stage file.

Time: about two hours of agent time around 54 minutes of compute.

## Stop answered (2026-11-03)

- D-S1. The user answered the stage 2 stop with "do your recommendation, let me see": a revised proposal and a re-pilot. The revision is `proposal.md`, section 12 (revision 3): the claim becomes equivalence of edges and first-order edge features, the shared-factor artifact and its fix, and the effect of parametrization; a new model F1 (first-order edges); the second primary contrast becomes an equivalence test with margin 0.01; the re-pilot `pilot-b/` has 12 cells with heavy-tailed noise and a two-gene score as stress factors, and a pass rule whose matching clause is paired with a signal clause. Markdown revision pass: one pass over section 12; two sentences split in 12.2, no section changed by more than three sentences.
- "Let me see" is read as the user wanting to see the revision first, so the revised proposal gets its own stop before the re-pilot, as `02-pilot.md` requires unless the user says to go straight on.

# Re-pilot: pilot-b

- D-S2. The user approved revision 3 and its thresholds ("APROVE"), and asked for the revised research question, which is `proposal.md`, section 12.6, and `project-spec.md`, section 1.
- `pilot-b/preregistration.md` committed alone before any re-pilot code ("Stage 2, step 2 (pilot-b): pre-registration").
- Code for the re-pilot (commit "Stage 2, step 3 (pilot-b)"): t5 noise, first-order edge features, the F1R1 model, the score size, `PilotBDesign()`. The first pilot's replicates 1 of cells 3 and 13 reproduce exactly after the change. A test found that the pre-registered seeds collided with the first pilot's; corrected by an amendment before any run. 46 tests pass, with one glmnet convergence warning in a test that fits 990 features on 50 samples (glmnet returns the solutions for larger penalties; the run's cells are larger); `devtools::check()` clean.
- Timing: 146 seconds for 10 replicates per cell; 200 replicates per cell, entered as an amendment before the run.
- Run: 12 cells by 200 replicates in 2,822 seconds (`pilot-b/results/run_info.rds`); no restart. (The container had restarted once before the run started; the run itself was uninterrupted.)
- Verdict (`Rscript pilot-b/verdict.R`): `piloted-close-call`. Every clause passed except 2(a), at its threshold (0.0201, MCSE 0.0027, against 0.02). Neither open case of the pre-registration's section 5 arose.
- Known-answer checks: code identities hold; the null cell's AUCs sat 1.9 to 2.5 MCSE below 0.5 for every model (decisions D6), as the first pilot's did to a smaller degree.
- Report: `pilot-b/pilot-report.qmd`, reading the first pilot's dataset files read-only; the checker reports no errors or warnings; looked at the rendered summary and figure. Revision pass: the impact and plain-language sections read once as a new reader; no section changed by more than three sentences.

## Process feedback (re-pilot)

1. A test of the design table caught a seed collision that the pre-registration's own text denied; seed rules should be tested, not described.
2. The verdict script of the first pilot could be reused only by rewriting; a rule-table format (clause, quantity, cells, threshold, type) that one script reads would make re-pilots cheaper and less error-prone.
3. The first pilot's lesson (pair a matching clause with a signal clause) worked as intended: clause 1(a) showed there was a signal of 0.118 to match.

## Stop answered (2026-11-04)

- D-S3. The user read the re-pilot's close call as a pass ("Read the close call as a pass"). The stage record line says so. The question it leaves open, the size of the IFN artifact at a large IFN difference (0.0201, MCSE 0.0027, against 0.02), goes to stage 3's design proposal as a gradient of IFN differences.

# Third pilot: pilot-c (revision 4, the user's new idea)

- The user asked to redo the work up to stage 2 with the refined proposal and to see whether it passes before stage 3. Stage 1 was redone as revision 4 (`log/01-idea-review.md`, "Revision 4"), with stop 1 waived by the user.
- `project-spec.md` rewritten from revision 4 (commit "Stage 2, step 1 (pilot-c)"), then `pilot-c/preregistration.md` committed alone before any pilot-c code ("Stage 2, step 2 (pilot-c): pre-registration").
- Code (commit "Stage 2, step 3 (pilot-c): code"): `R/partial.R` (partial correlations and their LIONESS edges, computed directly, tested against a literal inverse-covariance implementation and against the Pearson edges with no conditioning set); the models built on E1 (`E5E1`, `F1E1`, `N1E1`, `N2E1`) in `RunReplicate()`; `PilotCDesign()`; `SummarizeCells()` now reads columns by exact name, since `$` would have matched `E5` to `E5E1` (found while writing the summaries, before any run). 77 tests pass (one glmnet convergence warning, as before); `devtools::check()` clean; the quick acceptance test reproduces the second pilot's replicates exactly.
- Timing: 174 seconds for 10 replicates per cell (`pilot-c/results/timing.rds`); 200 replicates per cell, entered as an amendment before the run.
- Run: 9 cells by 200 replicates in 3,316 seconds (`pilot-c/results/run_info.rds`, `pilot-c/run.log`); no restart.
- Verdict (`Rscript pilot-c/verdict.R`): `piloted-pass`. All 18 clause rows passed, none within three MCSE of its threshold; neither open case of the pre-registration's section 5 decided a clause.
- Known-answer checks: every code identity, including the new partial-correlation edges, below $10^{-13}$; the mean-shift formula held; the null cell's AUCs sat 2.8 to 4.3 MCSE below 0.5 for every model but E4 (decisions D7), as in both earlier pilots.
- Outside the rule (decisions D8): adding 990 edges to E1 cost about 0.05 in AUC in the mean-shift cell, where the signal is in the gene levels, so $\Delta_1$ can be negative in real data from penalty dilution alone.
- Report: `pilot-c/pilot-report.qmd`; the checker first gave one error (the spec section was titled "The spec", not "The draft spec") and two warnings (the word "survive", and no idea figure); fixed, and the checker then reported no errors or warnings. Looked at the rendered summary and the figure. Revision pass: the plain-language and impact sections read once as a new reader.

## Process feedback (third pilot)

1. `SummarizeCells()` read columns with `$`, which partially matches names; a new model name (`E5E1`) would have been read as an old one (`E5`). Summary code should read columns by exact name; caught before the run.
2. Moving new known-answer checks into the middle of `KnownAnswerChecks()` would have shifted the random stream and the rows an existing test asserts on; new checks belong at the end.
3. The workflow's revision rule (a dated section appended to the old proposal) conflicted with the user's request to replace the old files; a revision record section with a pointer to the git history kept both.

## Questions at the stage 2 stop (2026-11-06)

- D-S4. Asked whether other public data could answer the clinical question if PRECISESADS access fails, the user reviewed the options found in GEO and ArrayExpress (2026-11-06): within-SLE activity (GSE88884, GSE65391), tuberculosis (GSE19491), SLE against systemic JIA (GSE8650, GSE11907, GSE19491), Crohn's disease against ulcerative colitis and PBC against PSC (GSE119600), and the SLE and RA neutrophil series GSE326777 (34 SLE, 15 RA). The user decided to keep SLE against RA as the question ("let me maintain my own"); the proposal is unchanged. None of these datasets was downloaded or checked for batch aliasing. The stage 2 stop (the third pilot's pass) stays open.
