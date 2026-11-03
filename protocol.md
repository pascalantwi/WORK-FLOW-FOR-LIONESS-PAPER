# Simulation protocol (ADEMP)

[Project title]. Written [date], before any production simulation run. Changes after a production run are recorded at the bottom with the date and the reason.

*How to use this file. Copy the "Study S1" block for each study. Delete the italic notes. Pilot runs to debug code are fine, but nothing counts as a production run until this file is written and has been reviewed. The framework is ADEMP (Morris, White, and Crowther 2019).*

## Study S1: [name]

**Aim.** *Two or three questions with yes-or-no or numeric answers. "Does method A hold its level when groups are unbalanced?" is an aim. "Compare methods" is not.*

**Data-generating mechanisms.** *Every parameter named. Factors varied, with their levels. Factors fixed, and why each is fixed. The design (full factorial by default) and its number of cells. At least one cell where the answer is known, a null or a case with a closed form, so that a bug shows up as a wrong answer. Total N held fixed when balance varies.*

**Estimands.** *What each method is trying to estimate or test, defined without reference to any method.*

**Methods.** *Each procedure, precisely enough to reimplement: the statistic, the reference distribution, the number of permutations, any multiple-testing adjustment, the software and its version.*

**Performance measures.** *What is computed per replicate and how it is summarized: level and power for tests; bias, empirical SE, MSE, and coverage for estimators. The number of replicates R per cell, and the Monte Carlo SE it gives for the measure that matters most.*

## Common

*Seeds: one per cell, derived from the cell index plus a study offset (for example S1: 1000). Where per-replicate results are saved (`results/`). That summaries are computed when the manuscript renders. That `sessionInfo()` is saved with each production run. That every rejection-rate plot carries binomial 95% bands. Software versions.*

## Changes after production

| Date | Change | Reason |
|---|---|---|
| | | |
