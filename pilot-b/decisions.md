# Decisions log: re-pilot (pilot-b)

## D0. Literature pass

As for the first pilot (`pilot/decisions.md`, D0): the proposal's section 5, read in full text at the stage 1 reference check. Nothing new was read for the re-pilot. The re-pilot follows revision 3 of the proposal (section 12), written after the first pilot failed, and approved by the user with its thresholds.

## D1. Status call

**What.** `piloted-close-call`, by the pre-registered rule (`pilot-b/results/verdict.rds`). Every clause passed except 2(a), which is a close call for itself: the IFN artifact at a large IFN difference was 0.0201 (MCSE 0.0027) against a threshold of 0.02.
**The reading that passes.** The estimate is above the threshold, and two other cells with the same large IFN difference (the two-gene score and $t_5$ noise, not part of the clause) gave 0.032 and 0.023 (`pilot-b/results/cell_summaries.rds`).
**The reading that fails.** Three MCSE on either side of 0.0201 run from about 0.012 to 0.028, so the data do not exclude an artifact below 0.02 in the pre-registered cell.
**What it changes.** Nothing in the paper's main claims rests on clause 2(a): equivalence (1(a), 1(b)) and the fix (3(a), 3(b)) passed in every cell. The size of the artifact, about 0.02 in AUC at a large IFN difference and below 0.01 at a moderate one, is reported as it is.
**What the user should check.** Whether to read the close call as a pass and go on to stage 3.

## D2. Seeds amended before the run

**What.** The pre-registration gave cell $c$ the seed $20261103 + 2000c$ and said it differed from every seed of the first pilot; it collided in eight cells. A test written for the re-pilot caught it, and an amendment before any run changed the seed to $20261103 + 2000c + 500$.
**Why.** Replicate streams of the two pilots must not overlap, or the re-pilot would repeat part of the first pilot's data.
**Check.** The amendment's commit precedes every file in `pilot-b/results/` except the timing run, which used the corrected seeds.

## D3. Gene set with the two-gene score

**What.** In cell 4 the IFN score uses genes 1 and 2, and the gene set stays genes 6 to 50; genes 3 to 5, IFN genes outside the score, are in neither.
**Alternatives.** Moving genes 3 to 5 into the gene set.
**Why.** The pairs, and so the edges, stay the same in every cell, so that cell 4 differs from cell 2 only in the reliability of the score.

## D4. E4 not run

**What.** Regularized discriminant analysis was dropped.
**Why.** It ranked below $R_1$ in every IFN-only cell of the first pilot and its tuning grid was the costliest step; the revised rule does not use it.

## D5. Replicates

**What.** 200 per cell, from the timing run (146 seconds for ten), entered before the run.

## D6. Null-cell AUC below 0.5

**What.** In the null cell every model's AUC was about 0.49, between 1.9 and 2.5 MCSE below 0.5 (`pilot-b/results/known_answers.rds`); the first pilot's null cells were 0.49 to 0.50.
**Reading.** The models share it, so every paired difference is unaffected. The agent's explanation, not checked against a source: out-of-fold scores pooled across folds whose fitted intercepts differ tend to rank slightly against the labels under the null.
**Check.** Whether stage 3 should report fold-averaged AUC beside pooled AUC.

## What was not done

- No real data.
- Twelve of the 18 models of the revised design were not run (it ran $R_0$, $R_1$, E1, E5, F1, and N1): B1, B2, E2, E3, E4, and N2 to N8, as numbered in the proposal's section 7.
- No combined mechanisms; one heavy-tailed distribution ($t_5$); one reduced score (two genes).
