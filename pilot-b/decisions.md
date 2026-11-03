# Decisions log: re-pilot (pilot-b)

## D0. Literature pass

As for the first pilot (`pilot/decisions.md`, D0): the proposal's section 5, read in full text at the stage 1 reference check. Nothing new was read for the re-pilot. The re-pilot follows revision 3 of the proposal (section 12), written after the first pilot failed, and approved by the user with its thresholds.

## D1. Status call

STATUS_CALL

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

## What was not done

- No real data.
- Twelve of the 18 models of the revised design were not run (it ran $R_0$, $R_1$, E1, E5, F1, and N1): B1, B2, E2, E3, E4, and N2 to N8, as numbered in the proposal's section 7.
- No combined mechanisms; one heavy-tailed distribution ($t_5$); one reduced score (two genes).
