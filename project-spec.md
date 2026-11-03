# Project spec: LIONESS beyond the IFN score in SLE and RA

| | |
|---|---|
| Proposal | `proposal.md`, final 2026-11-03 |
| Authors | as in `DESCRIPTION`, set by `tools/authors.R` before the final render |
| Written | 2026-11-03 |
| Status | final 2026-11-03; section 3 completed after the verdict, 2026-11-03 |

## 1. Question and why it matters

**Question (one sentence):** Is a LIONESS co-expression edge anything more than a closed-form quadratic function of each sample's own expression, and, when classifying SLE against RA from whole blood, do LIONESS edges add information beyond the IFN score, its square, cell composition, and their own first-order (influence-function) features? (Revised 2026-11-03 after the first pilot, `proposal.md`, section 12.6; the question before it asked only about the IFN score and the matched quadratic model.)

**Why it matters:** A LIONESS edge is a known quadratic function of the sample's own expression (proposal, section 4), so a network gain is a quadratic-expression gain unless it survives the matched comparison. In IFN-driven diseases, edges between IFN genes carry the square of the IFN factor, so a reference without that square credits IFN signal to the network. A user who reports network rewiring needs to know which comparisons the claim must survive.

## 2. Mechanism we suspect

The exact LIONESS Pearson edge is $e_q = N r - (N-1)(r - a z_{qi} z_{qj})/\sqrt{(1 - a z_{qi}^2)(1 - a z_{qj}^2)}$ with $a = 1/(N-1)$ (proposal, equation 1), which to first order is $r + z_{qi} z_{qj} - \tfrac{r}{2}(z_{qi}^2 + z_{qj}^2)$: the reference correlation plus the influence function of the correlation at the sample. Users read the edge as the correlation in the sample's own subpopulation. Three gaps follow. Genes sharing a factor $F$ give edges near $a_i a_j F^2$, so edges add information over a reference with $F$ but not $F^2$ (zero when the classes have the same distribution of $F$, large when they differ in its spread). A mean shift between unbalanced classes moves the group mean of an edge by $(1 - 2\pi)[\Delta_i \Delta_j - \tfrac r2(\Delta_i^2 + \Delta_j^2)]$ with no change in co-expression (zero at $\pi = 0.5$). And any classification gain from edges should be matched by a linear model on the products $z_i z_j$ and squares $z_i^2$. If the mechanism is wrong, edges would add information beyond the matched quadratic model in cells with no co-expression difference.

## 3. Pilot

Filled twice: the plan now, the answers after the verdict (stage 2, step 5).

**Code:** `pilot/pilot.R`, run from the project root with `Rscript pilot/pilot.R`; functions in `R/`, tests in `tests/testthat/`; the verdict by `Rscript pilot/verdict.R`.

**Pass rule:** from the proposal, section 7, as numbers; clause by clause in `pilot/preregistration.md`, section 2.

1. In the IFN-only cell with the moderate IFN difference, $\pi$ = 0.5, and 80 per class, LIONESS edges added to $R_0$ raise the out-of-fold AUC by at least 0.05, and by more than three Monte Carlo standard errors.
2. The same gain is at least 0.03 at 40 per class.
3. (a) In every IFN-only and mean-shift cell, the AUC of edges with $R_1$ lies within 0.01 of the AUC of the matched quadratic model with $R_1$ (or within three Monte Carlo standard errors when that is wider); (b) in the network cell with change 0.4, $\pi$ = 0.5, and 80 per class, the matched quadratic model reaches at least 90% of the AUC gain of the edges over $R_1$.

Pass if 1, 2, and 3 pass; close call if 1 and 3 pass and the gain of question 2 lies between 0.01 and 0.03; fail if 1 or 3(a) fails.

**Verdict file:** `pilot/results/verdict.rds` (status `piloted-fail`), from `Rscript pilot/verdict.R`; 180 replicates per cell, 16 cells, 54 minutes on three cores.

**Plot:** `pilot/results/auc_gains.png`.

**The three pilot answers:**

1. Does the effect exist? Yes, but small, and no by the rule: edges added to a reference without the squared IFN score raised the AUC by 0.0067 (MCSE 0.0022) in the moderate IFN cell, against a threshold of 0.05; 0.031 in the large cell.
2. Is it large enough to matter at realistic sample sizes? No: -0.0017 (MCSE 0.0019) at 40 per class.
3. Is there an obvious fix or diagnostic? The squared score in the reference removes the gain (edges with $R_1$ against $R_1$: within 0.003 of zero in every IFN-only cell), and clause 3(a) passed in all seven cells; but the pre-registered matched quadratic model reached only a quarter of the edges' gain in the network cell (clause 3(b) value -0.075, MCSE 0.003). An exploratory probe after the verdict found that first-order edges as features match the exact edges (`pilot/decisions.md`, D9).

**The re-pilot (`pilot-b/`, revision 3, after the first pilot failed):** verdict file `pilot-b/results/verdict.rds`, status `piloted-close-call`; 200 replicates per cell, 12 cells, 47 minutes on three cores.

1. Does the equivalence hold? Yes: edges with $R_1$ gained 0.118 (MCSE 0.005) over $R_1$ in the strong network cell, and edges and first-order edges differed by -0.0054 to 0.0017 in AUC across all 12 cells.
2. Is it large enough to matter at realistic sizes? The co-expression signal yes: 0.048 (MCSE 0.005) at 40 per class. The IFN artifact at a large IFN difference is a close call: 0.0201 (MCSE 0.0027) against 0.02.
3. Is there an obvious fix or diagnostic? Yes: with the squared score in the reference, edges added -0.0025 to -0.0019 in the IFN-only cells, and -0.0022 with a two-gene score.

## 4. ADEMP skeleton

**Aims.** (1) How much AUC do LIONESS edges add over a reference with the IFN score but not its square, when the classes differ only in the IFN factor? (2) Does the gain vanish against the matched quadratic model, in cells with and without a true co-expression difference? (3) How does the group mean of an edge depend on group balance under a pure mean shift?

**Data-generating mechanisms.**

- Factors varied: mechanism (null; IFN only; mean shift only; true network); IFN difference (moderate: mean of $F$ shifted 0.5 SD and SD ratio 1.5; large: shift 1 SD and ratio 2.25); conditional correlation change in a 10-gene module (0.1, 0.2, 0.4); share of the smaller class $\pi$ (0.5, 0.3); size of the smaller class (40, 80, 150).
- Factors fixed: 50 genes (genes 1 to 20 load 0.8 on $F$; genes 1 to 5 form the IFN score, as the five IFN5 genes do; genes 21 to 30 form a module with within-class noise correlation 0.3; genes 31 to 50 load 0.4 on composition $C$), so the IFN score and composition enter as they would in blood; Gaussian noise, so the known-answer cells have closed forms; age and sex unrelated to class, so the reference's clinical terms are present but carry no signal; mean shift of 0.5 SD on the module genes in the mean-shift cells.
- Known-answer cells: the null cells (every AUC near 0.5); the closed forms of the edges (tests).

**Estimands.** The out-of-sample AUC of each model, and its difference from $R_1$ (or $R_0$): the probability that a random case from class 1 outranks a random case from class 0 under the model fitted on a sample of the cell's size.

**Methods compared.** $R_0$ (logistic regression on age, sex, $C$, and the residual IFN score); $R_1$ ($R_0$ plus the squares of the residual score and $C$); E1 (elastic net on the 45 non-score genes with $R_1$ unpenalized); E4 (regularized discriminant analysis on the 45 genes, the residual score, and $C$); E5 (elastic net on the products and squares of the 45 standardized genes with $R_1$ unpenalized); N1 with $R_0$ and N1 with $R_1$ (elastic net on the 990 LIONESS-Pearson edges among the 45 genes, the reference unpenalized). Elastic net with $\alpha$ = 0.5 and $\lambda$ chosen by inner 5-fold cross-validation (glmnet 5.2); outer 5-fold cross-validation stratified by class. LIONESS edges for training samples use the training fold as reference (exact form); test samples are scored against the training fold (proposal, Result 5).

**Performance measures.** Out-of-fold AUC per model and replicate; paired differences from $R_0$ and $R_1$; Monte Carlo standard errors from the replicate standard deviation of the paired differences; in mean-shift cells, the observed group-mean edge difference against equation (3).

**Replicates and Monte Carlo SE target.** 200 per cell if the timing allows, giving a Monte Carlo standard error near 0.003 for an AUC difference with replicate standard deviation 0.04; the count is set from the timing run (pre-registration, section 3).

## 5. Application

**Dataset:** PRECISESADS, ELIXIR Luxembourg ELU-2-E592B0-1 (doi 10.17881/th9v-xt85), controlled access; not yet requested, so not on disk. [TO CONFIRM: the access request is submitted by the user and Dr Grimes; the contingency if refused is open in proposal section 6]{.tc}

**Comparison:** untreated SLE against untreated RA, whole-blood RNA-seq, with flow-cytometry composition; counts by diagnosis to be read from the paper's Supplementary Table 1 once accessed.

**What to show:** whether the AUC gain that edges show over a reference without the squared IFN score disappears against $R_1$ and against the matched quadratic model in real blood.

The pilot is a simulation only, as the proposal states (section 7).

## 6. Target journal

**Target journal:** BMC Bioinformatics

**Fallback:** Statistical Applications in Genetics and Molecular Biology

**The target's word limit and AI policy:** structured abstract (Background, Results, Conclusions), 350 words; research article length not stated; AI use disclosed, AI not an author.

## 7. Milestones

| Stage | Ends with | Due |
|---|---|---|
| 2. Pilot | `pilot/pilot-report.html`, the verdict file, `pilot/decisions.md` | 2026-11-04 |
| 3. Manuscript, design stop | `protocol.md` from the approved design | [TO CONFIRM: date]{.tc} |
| 3. Manuscript, first draft | `manuscript/manuscript.html` in draft mode | [TO CONFIRM: date]{.tc} |
| 3. Manuscript, settled | the draft after the revision rounds | [TO CONFIRM: date]{.tc} |
| 4. Background report | `background/background.html` | [TO CONFIRM: date]{.tc} |
| 5. Mock review | the last `review/round-N/` | [TO CONFIRM: date]{.tc} |
| Submission | the final render and the checker in final mode | [TO CONFIRM: date]{.tc} |

## 8. Out of scope

The project must not add:

- Single-sample methods beyond the six in the model list (CSN, SSPGI, LIONESS on mutual information): each is its own critique.
- A new single-sample network method, or a corrected LIONESS: a constructive paper for later.
- Diseases beyond SLE and RA, although PRECISESADS holds seven: a second application is a different paper.
- A biomarker or a diagnostic classifier for clinical use: the classification task is the instrument of the critique, not the result.
- Second-order theory beyond the exact forms (bounds for heavy tails, regularized partial correlation): parked as its own theory note.

## 9. Reading

1. @kuijjer2019lioness. After reading, a reader can answer: what are the aggregate and the background network, and how is the sample's edge obtained from them?
2. @yu2017iena. After reading, a reader can answer: under what condition does the per-sample change in Pearson correlation reduce to the product of standardized deviations, and what does that reduction drop?
3. @kuijjer2026challenges. After reading, a reader can answer: which edge type gets higher weights in the smaller subpopulation, and for which methods?
