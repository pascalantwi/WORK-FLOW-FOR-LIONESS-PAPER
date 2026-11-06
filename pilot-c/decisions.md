# Decisions log: third pilot (pilot-c)

## D0. Literature pass

As for the earlier pilots (`pilot/decisions.md`, D0): the proposal's section 5, read in full text at the stage 1 reference check. For revision 4, PubMed and GEO were searched on 2026-11-06 (`log/01-idea-review.md`, searches 32 to 34); one entry was added to the reference list (`sentis2026lupusarthritis`), for the validation plan, not for this pilot. The pilot follows revision 4 of the proposal, section 12, the user's new idea.

## D1. Status call

**What.** `piloted-pass`, by the pre-registered rule (`pilot-c/results/verdict.rds`): all 18 clause rows passed, none within three MCSE of its threshold.
**The numbers.** 1(a): N1 gained 0.109 (MCSE 0.005) over E1 in the strong network cell. 1(b): N1 and F1 differed by -0.0038 to 0.0010 across all nine cells. 2(a): 0.044 (MCSE 0.005) at 40 per class. 2(b): N2 gained 0.101 (MCSE 0.005) over E1. 3(a): N1 against E1 in the IFN-only cells, -0.0006 to 0.0014. 3(b): N2 against E1, 0.0003 to 0.0013 (`pilot-c/results/cell_summaries.rds`).
**No close-call reading is needed.** Neither open case of the pre-registration's section 5 decided a clause: no value of 1(b), 3(a), or 3(b) came near the margin, on either side.
**What the user should check.** Whether to start stage 3, whose design stop writes `protocol.md` from the design of proposal section 7.3.

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

## D7. The null cell sits below 0.5, as in the earlier pilots

**What.** In the null cell the pooled out-of-fold AUC of every model except E4 sat 2.8 to 4.3 MCSE below 0.5 (0.481 to 0.487; `pilot-c/results/known_answers.rds`); E4 sat at 0.502.
**Why it does not affect the verdict.** The shortfall is shared by the models the clauses compare, so their paired differences in the null cell are 0.0009 to 0.0034; E4, which does not share it, sits 0.017 (MCSE 0.006) above E1 there, and no clause uses E4. Pooling out-of-fold scores across folds whose models differ is known to pull a no-signal AUC below 0.5; the second pilot showed the same (`pilot-b/decisions.md`, D6).
**What the user should check.** Whether the full study should also report the fold-averaged AUC, which the second pilot's report raised for stage 3.

## D8. Findings outside the rule, for the design

**What.** Three results that no clause judges, recorded because the full study and the application depend on them (`pilot-c/results/cell_summaries.rds`).
1. In the mean-shift cell, where the signal is in the gene levels, adding 990 edges (or products, or first-order edges) to E1 lowered the AUC by about 0.05 (N1 0.598 against E1 0.648): features without signal dilute the penalty. So $\Delta_1$ can be negative in real data without any harm from edges as such.
2. The artifact over $R_0$ was 0.029 (MCSE 0.003) at a large IFN difference, 0.021 with $t_5$ noise, and 0.009 at a moderate one, a little larger than the second pilot's 0.0201 on other seeds; E1, like $R_1$ before it, removed it.
3. The edge form beat separate products and squares ($P$) by 0.086 in the strong network cell, 0.029 at 40 per class, and 0.064 with $t_5$ noise; E4 gained 0.069 over E1 there, less than N1's 0.109.

## What was not done

- B1 and B2 (they need batch, absent from the simulation), and the application to real data: no patient data were analyzed.
- One penalty ($\alpha$ = 0.5), one heavy-tailed distribution, and a five-gene IFN score only; the full study varies all three.
- The gene levels in E1 carry class signal only in the mean-shift cell, so E1 is a weaker base here than it will be in blood.
