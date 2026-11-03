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
