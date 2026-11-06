# Decisions log: third pilot (pilot-c)

## D0. Literature pass

As for the earlier pilots (`pilot/decisions.md`, D0): the proposal's section 5, read in full text at the stage 1 reference check. For revision 4, PubMed and GEO were searched on 2026-11-06 (`log/01-idea-review.md`, searches 32 to 34); one entry was added to the reference list (`sentis2026lupusarthritis`), for the validation plan, not for this pilot. The pilot follows revision 4 of the proposal, section 12, the user's new idea.

## D1. Status call

[FILL: after the verdict]

## D2. What this pilot tests, and what it does not

**What.** The pass rule judges only what revision 4 changed: the richer models built on E1 (questions 1 and 3), the new partial-correlation edges N2 (clauses 2(b) and 3(b)), and the co-expression signal at a small size over the new base (clause 2(a)). The interferon artifact over $R_0$ is reported in every cell but judged in none.
**Alternatives.** Repeating the second pilot's clause on the artifact (at least 0.02 at a large IFN difference).
**Why.** The models of that clause ($R_0$ and N1 with $R_0$) did not change, and the second pilot measured it (0.0201, MCSE 0.0027, `pilot-b/results/cell_summaries.rds`); judging it again would test the same thing on new seeds.
**What the user should check.** That the rule asks the questions the new design raises (`pilot-c/preregistration.md`, section 2).

## D3. N2's conditioning set and its computation

**What.** N2 conditions each gene pair on the IFN score (the mean of genes 1 to 5 standardized by the training fold) and composition, and its edges are computed directly: the partial correlation of the training fold, and of the training fold without each sample (or with each test sample added), from residuals on an intercept and the two conditioning variables.
**Alternatives.** The first-order form of Result 2 with its Mahalanobis inflation factor; conditioning on the residual IFN score.
**Why.** The direct computation is the definition, so N2 needs no approximation, and it is checked against a literal inverse-covariance formula (`pilot-c/results/known_answers.rds`). The raw score and composition span the same space as the residual score and composition, so the partial correlations are the same.

## D4. E4's inputs

**What.** E4 is regularized discriminant analysis on the 45 genes, composition, and the residual IFN score, as in the first pilot, without the squared terms of $R_1$.
**Why.** A quadratic discriminant forms squares and products of its inputs itself; adding the squared terms as inputs would add them twice.

## D5. Warnings from the elastic net

**What.** `RunReplicate()` is wrapped in `suppressWarnings()` in `pilot-c/pilot.R`.
**Why.** `glmnet` warns when the path does not converge for its largest penalty values in small folds; it returns the solutions for the other values, and `lambda.min` is chosen among them. In the earlier pilots the same warnings were raised inside the parallel workers and not shown. Suppressing them changes no result.

## D6. Seeds

**What.** Cell $c$ has seed $20361103 + 1000c$.
**Why.** At least 75,000 from every seed of the first two pilots, so that no replicate stream overlaps theirs; a test checks it (`tests/testthat/test-partial.R`).

## What was not done

[FILL: after the verdict]
