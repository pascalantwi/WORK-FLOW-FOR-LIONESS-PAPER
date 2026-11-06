# Project spec: LIONESS edges, the interferon score, and SLE versus RA

| | |
|---|---|
| Proposal | `proposal.md`, revision 4, final 2026-11-06 |
| Authors | as in `DESCRIPTION`, set by `tools/authors.R` before the final render |
| Written | 2026-11-06 (replaces the spec of 2026-11-03) |
| Status | final 2026-11-06; section 3 completed after the third pilot's verdict |

## 1. Question and why it matters

**Question (one sentence):** Is a LIONESS co-expression edge anything more than a closed-form quadratic function of each sample's own expression, and, when classifying SLE against RA from whole blood, do LIONESS edges add information beyond the IFN score, its square, cell composition, the gene levels, and their own first-order features?

**Why it matters:** LIONESS edges are read as each patient's own co-expression network, and differences between groups are reported as rewiring. If an edge is a quadratic function of the patient's own expression, a network finding must survive two comparisons before it means co-expression: against its own first-order formula, and against a baseline that holds the square of any shared factor such as interferon. In SLE and RA, where many gene pairs share the IFN factor, a network finding that skips these comparisons can be interferon in disguise.

## 2. Mechanism we suspect

The LIONESS edge is $e_q = N r - (N - 1) r_{(-q)}$, and its exact closed form (proposal, equation 2) equals, to first order, $r + z_{qi} z_{qj} - \tfrac{r}{2}(z_{qi}^2 + z_{qj}^2)$: the reference correlation plus the influence function of the correlation at the sample. Three gaps follow. Genes sharing a factor $F$ give $z_{qi} z_{qj} \approx a_i a_j F_q^2$, so edges gain over a baseline with $F$ but not $F^2$ whenever the classes differ in the distribution of $F$. A mean shift between unbalanced classes moves the group mean of an edge by $(1 - 2\pi)[\Delta_i \Delta_j - \tfrac{r}{2}(\Delta_i^2 + \Delta_j^2)]$ with no change in co-expression. And the classification gain of edges should equal that of their first-order formula. If the mechanism were wrong, edges would beat the formula, or would keep a gain over a baseline that holds $F^2$ and the gene levels when only $F$ differs.

## 3. Pilot

Filled twice: the plan now, the answers after the verdict (stage 2, step 5). This is the third pilot; the first two are summarized at the end of this section.

**Code:** `pilot-c/pilot.R`, run from the project root with `Rscript pilot-c/pilot.R --reps <n>`; functions in `R/`, tests in `tests/testthat/`; the verdict by `Rscript pilot-c/verdict.R`.

**Pass rule:** from the proposal, section 12, clause by clause in `pilot-c/preregistration.md`, section 2. $\Delta_1 = \mathrm{AUC}(\text{N1}) - \mathrm{AUC}(\text{E1})$ and $\Delta_2 = \mathrm{AUC}(\text{N1}) - \mathrm{AUC}(\text{F1})$, paired within a replicate.

1. Does the equivalence hold on the E1 base? (a) In the strong network cell (cell 6), $\Delta_1 \ge 0.05$ and above three MCSE. (b) In every cell, $\lvert \Delta_2 \rvert \le \max(0.01, 3\,\text{MCSE})$.
2. Does the signal survive at a small size and in the conditioned network? (a) At 40 per class (cell 7), $\Delta_1 \ge 0.03$. (b) In cell 6, N2 gains at least 0.05 over E1.
3. Does the E1 base remove the interferon artifact? (a) In the IFN-only cells (2, 3, 4), $\lvert \Delta_1 \rvert \le \max(0.01, 3\,\text{MCSE})$. (b) The same for N2 against E1.

Pass if every clause passes; fail if 1(a), 1(b), or 3(a) fails; close call otherwise, and for any clause within three MCSE of its threshold.

**Verdict file:** [FILL: after the run]

**Plot:** [FILL: after the run]

**The three pilot answers:** [FILL: after the run]

**The earlier pilots, for the record.** The first pilot (`pilot/`, 16 cells, 180 replicates) failed its rule: the IFN artifact was small (0.0067 at a moderate IFN difference) and the planned competitor, separate products and squares, reached only a quarter of the edges' gain with a true co-expression change, while first-order edges matched it. The second pilot (`pilot-b/`, 12 cells, 200 replicates) was a close call read as a pass: edges and first-order edges differed by -0.0054 to 0.0017 in AUC, the co-expression gain was 0.118 (MCSE 0.005), the artifact at a large IFN difference was 0.0201 (MCSE 0.0027) against a threshold of 0.02, and the squared score removed it. Both built the richer models on $R_1$.

## 4. ADEMP skeleton

**Aims.** (1) Do LIONESS edges and their first-order features give the same out-of-sample AUC? (2) How much do edges gain from the squared IFN level alone, and does a base with the squared score remove it? (3) Does the edge form detect a co-expression difference that separate products and squares miss? (4) Does equation (3) hold for unequal groups?

**Data-generating mechanisms.**

- Factors varied: share of the smaller class (0.5, 0.3, 0.15) and mean shift (0.25, 0.5, 1) in S1; IFN difference (none to very large), score genes (2, 5, 10), noise (normal, $t_5$), and size (40 to 300) in S2-A; module correlation change (0 to 0.4), size, share, noise (normal, $t_5$, $t_3$), and elastic-net mixing (0, 0.5, 1) in S2-B; one factor at a time around base settings (9 settings in S1, 25 in S2).
- Factors fixed: 50 genes (20 on the IFN factor, 5 of them the score; a 10-gene module; 20 on composition), as in the pilots, so the results stay comparable; composition observed without error and the gene set fixed at the 45 non-score genes, named as limitations.
- Known-answer cells: the null (every AUC near 0.5); equation (3) in S1; the closed forms against literal LIONESS (tests).

**Estimands.** The out-of-sample AUC of each model, the probability that a random class-1 sample outranks a random class-0 sample under the model fitted on a sample of the cell's size; the contrasts $\Delta_1$, $\Delta_2$, $A$, and $P$ of proposal equation (6).

**Methods compared.** $R_0$, $R_1$ (logistic regression); E1, E5, F1, N1, N2 (elastic net, mixing 0.5, penalty by inner 5-fold cross-validation, glmnet 5.2, the base terms unpenalized; E5, F1, N1, and N2 add their features to E1); E4 (regularized discriminant analysis on the genes with composition and the IFN score, tuned on a grid by inner 5-fold cross-validation); N1 with $R_0$. Outer 5-fold cross-validation stratified by class; LIONESS test edges by the add-one form.

**Performance measures.** Pooled out-of-fold AUC and the paired contrasts with Monte Carlo standard errors; in S1, the bias of the class difference in mean edge against equation (3); in seven test settings, the rejection rate of the $\Delta_1$ test and the rate at which equivalence of $\Delta_2$ (margin 0.01) is declared.

**Replicates and Monte Carlo SE target.** 400 per S2 setting (MCSE near 0.002 for a contrast with replicate standard deviation 0.04); 300 in the test settings (MCSE 0.013 for a rate near 0.05); 1,000 per S1 setting.

## 5. Application

**Dataset:** PRECISESADS, ELIXIR Luxembourg ELU-2-E592B0-1 (doi 10.17881/th9v-xt85), controlled access, not yet requested, so not on disk. [TO CONFIRM: the access request, asking for the inception cohort and the centre labels; the fallback if refused]{.tc} Replication: GSE17755 (22 SLE and 93 RA, females) and GSE235508 (16 SLE and 23 RA at one time point), public, not yet downloaded; the download needs the user's approval.

**Comparison:** untreated SLE against untreated RA in whole-blood RNA-seq, with flow-cytometry composition, centre, and batch.

**What to show:** whether edges keep any gain over E1 in real blood, whether that gain equals the first-order formula's, and whether the gain over $R_0$ is the squared IFN level.

The pilot is a simulation only, as the proposal states (section 12).

## 6. Target journal

**Target journal:** BMC Bioinformatics

**Fallback:** Statistical Applications in Genetics and Molecular Biology

**The target's word limit and AI policy:** structured abstract (Background, Results, Conclusions), 350 words; research article length not stated; AI use disclosed, AI not an author.

## 7. Milestones

| Stage | Ends with | Due |
|---|---|---|
| 2. Pilot | `pilot-c/pilot-report.html`, the verdict file, `pilot-c/decisions.md` | 2026-11-06 |
| 3. Manuscript, design stop | `protocol.md` from the approved design | [TO CONFIRM: date]{.tc} |
| 3. Manuscript, first draft | `manuscript/manuscript.html` in draft mode | [TO CONFIRM: date]{.tc} |
| 3. Manuscript, settled | the draft after the revision rounds | [TO CONFIRM: date]{.tc} |
| 4. Background report | `background/background.html` | [TO CONFIRM: date]{.tc} |
| 5. Mock review | the last `review/round-N/` | [TO CONFIRM: date]{.tc} |
| Submission | the final render and the checker in final mode | [TO CONFIRM: date]{.tc} |

## 8. Out of scope

The project must not add:

- Other single-sample methods (SSN, iENA, SWEET, BONOBO, CSN, SSPGI) as fitted models: the theory paragraph covers them, and a benchmark of them is a different paper.
- Population-level network methods (module eigengenes, differential-correlation pairs) and other classifiers (random forests, shrinkage linear discriminant analysis).
- A new or corrected single-sample network method: a constructive paper for later.
- Disease pairs beyond SLE and RA as main results, although PRECISESADS holds seven diseases; Sjögren's against RA is at most a replication of the artifact.
- A diagnostic classifier for clinical use: the classification task is the instrument, not the result.

## 9. Reading

1. @kuijjer2019lioness. After reading, a reader can answer: what are the aggregate and the background network, and how is the sample's edge obtained from them?
2. @yu2017iena. After reading, a reader can answer: under what condition does the per-sample change in Pearson correlation reduce to the product of standardized deviations, and what does that reduction drop?
3. @kuijjer2026challenges. After reading, a reader can answer: which edge type gets higher weights in the smaller subpopulation, and for which methods?
