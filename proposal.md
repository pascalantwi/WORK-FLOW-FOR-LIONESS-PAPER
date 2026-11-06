# Proposal: LIONESS edges, the interferon score, and SLE versus RA

| | |
|---|---|
| Working title | LIONESS edges are quadratic functions of expression: closed forms, an interferon artifact, and equivalence with first-order features |
| Student | Pascal Antwi |
| Supervisor | Dr Tyler Grimes, University of North Florida |
| Target journal | BMC Bioinformatics (fallback: Statistical Applications in Genetics and Molecular Biology) |
| Version | Revision 4, 6 November 2026: rewritten from `proposal-new/proposal.md`; governs the third pilot (`pilot-c/`) and every later stage |

## Abstract

Single-sample network methods such as LIONESS give every patient a weight for every gene pair, read as that patient's own co-expression network, and these edges are increasingly used to compare and classify patients. What an edge is made of has not been derived. We show that the LIONESS edge of a Pearson correlation has an exact closed form, and that to first order it equals the reference correlation plus the product of the patient's two standardized expression values, minus a small term in their squares: a quadratic function of the patient's own expression. Three consequences follow, each checked in simulation. First, edges and their first-order formula should classify patients equally well, so a network result can be reproduced without building a network. Second, when a shared factor such as the interferon (IFN) signature drives two genes, their edge carries the factor squared, so edges can appear informative only because the comparison model lacks the squared IFN score. Third, unequal group sizes alone create group differences in mean edge, in proportion to $(1 - 2\pi)$. We test these claims in a simulation study and apply them to the classification of systemic lupus erythematosus (SLE) against rheumatoid arthritis (RA) from whole-blood transcriptomes, in which both diseases include patients with high IFN activity. Two pilots support the plan: edges and their formula differed by at most 0.0054 in AUC, and adding the squared IFN score removed the IFN artifact.

## 1. Background

SLE and RA are systemic autoimmune diseases with overlapping symptoms. Both include patients with a high type I interferon signature, so an IFN score alone separates them only in part [@elsherbiny2018twoscore; @barturen2021precisesads].

Network biology proposes that diseases differ not only in which genes are expressed but in how genes are co-expressed. LIONESS [@kuijjer2019lioness] turns a population network into one network per sample: it builds the network of all $N$ samples and the network without sample $q$, and interpolates. With Pearson correlation, the default of its R implementation [@kuijjer2019lionessr], the edge of genes $i$ and $j$ in sample $q$ is

$$
e_q = N r - (N - 1)\, r_{(-q)},
\tag{1}
$$

where $r$ is the correlation of all samples and $r_{(-q)}$ the correlation without sample $q$. Related methods include SSN [@liu2016ssn], iENA [@yu2017iena], SWEET [@chen2023sweet], and BONOBO [@saha2024bonobo]. Edges from these methods are compared between patient groups and used as classifier inputs, and differences are reported as "network rewiring" (a survey of such uses is still to be cited).

## 2. Research problem

LIONESS edges are interpreted as patient-specific co-expression, but their mathematical content has not been derived. Without it, three questions cannot be answered:

1. Is an edge a measure of coordination between two genes, or a simpler function of each gene's level in that patient?
2. Can a strong factor shared by many genes, such as interferon, make edges look informative when the real signal is the factor itself?
3. Which models must a network-based classifier beat before its edges can be said to add information?

In blood transcriptomes of IFN-driven diseases many gene pairs share the IFN factor, so these questions decide whether a network finding in SLE or RA reflects co-expression or interferon.

## 3. Research question and aims

**Main question.** Is a LIONESS co-expression edge anything more than a closed-form quadratic function of each sample's own expression? And when classifying SLE against RA from whole blood, do LIONESS edges add information beyond the IFN score, its square, cell composition, the gene levels, and their own first-order features?

- **Aim 1, equivalence.** Do the exact LIONESS edges and their first-order features give the same out-of-sample classification, so that a network result can be reproduced without building a network?
- **Aim 2, artifact and fix.** When SLE and RA differ in IFN activity, how much do edges gain only by carrying the squared IFN level, and does a baseline with the squared score remove that gain?
- **Aim 3, parametrization.** Why does the edge form detect a real co-expression difference that the same information, entered as separate products and squares, does not?

## 4. Theory

**Notation.** Sample $q$ of $N$; genes $i$ and $j$; $r$ the Pearson correlation of all $N$ samples; $z_{qi}$ the expression of gene $i$ in sample $q$, standardized by the mean and standard deviation of all $N$ samples (divisor $N$); $a = 1/(N - 1)$.

**Result 1, the exact edge.** Removing one sample is a rank-one change of the means and moments, which gives the leave-one-out correlation in closed form and, from equation (1), the edge:

$$
\begin{aligned}
r_{(-q)} &= \frac{r - a\, z_{qi} z_{qj}}{\sqrt{\left(1 - a\, z_{qi}^2\right)\left(1 - a\, z_{qj}^2\right)}}, \\
e_q &= r + z_{qi} z_{qj} - \frac{r}{2}\left(z_{qi}^2 + z_{qj}^2\right) + O_p\left(N^{-1}\right).
\end{aligned}
\tag{2}
$$

The leading terms are the **first-order edge**: the reference correlation plus the influence function of the correlation at the sample [@devlin1975robust]. The edge is therefore a quadratic function of the sample's own standardized expression. The product term $z_{qi} z_{qj}$ alone is the single-sample correlation of iENA [@yu2017iena]; the term in $r$ is what LIONESS adds.

**Result 2, partial correlation.** For the partial correlation given a conditioning set, the same form holds with residuals on the conditioning set in place of $z$, with a sample-specific inflation factor $(N - 1)/(N - 1 - m_q)$, where $m_q$ is the sample's squared Mahalanobis distance. The approximation is used only when the number of genes is at most $N/4$.

**Result 3, unequal groups.** Suppose two groups differ only in their gene means, by $\Delta_i$ and $\Delta_j$ pooled standard deviations, and the smaller group has share $\pi$. Then the group difference in mean edge is

$$
\mathrm{E}_1[e] - \mathrm{E}_0[e] \approx (1 - 2\pi) \left[ \Delta_i \Delta_j - \frac{r}{2} \left( \Delta_i^2 + \Delta_j^2 \right) \right],
\tag{3}
$$

which is zero for balanced groups and grows with imbalance, although the two genes' co-expression is the same in both groups.

**Result 4, a shared factor.** When genes $i$ and $j$ both follow a factor $F$, such as interferon, with loadings $a_i$ and $a_j$,

$$
z_{qi}\, z_{qj} \approx a_i\, a_j\, F_q^2 .
\tag{4}
$$

The edge therefore carries $F^2$. A comparison model that holds the IFN score but not its square leaves room for edges to gain by repeating $F^2$. This is why the squared IFN score enters the baseline $R_1$ (section 7).

**Result 5, test samples without leakage.** A new sample is scored against a training set of size $N$ by adding it, with $b = 1/(N + 1)$ and $z$ standardized by the training set:

$$
\begin{aligned}
r_{(+q)} &= \frac{r + b\, z_{qi} z_{qj}}{\sqrt{\left(1 + b\, z_{qi}^2\right)\left(1 + b\, z_{qj}^2\right)}}, \\
e_q &= (N + 1)\, r_{(+q)} - N r .
\end{aligned}
\tag{5}
$$

Test samples never enter the training reference, so cross-validated performance is not inflated, and a trained model can score new patients measured on the same platform.

**Numerical checks already done.** Equation (2) matched LIONESS computed by refitting to within $7 \times 10^{-13}$. The first-order edge correlated 0.997 or more with the exact edge; the product term alone correlated only 0.66 to 0.88 when $r$ was 0.5 or 0.9, so the term in $r$ matters. Equation (3) predicted 0.186 where simulation gave 0.188 at $\pi = 0.3$. Two IFN-driven genes gave edges correlated 0.74 with $F^2$, and 0.007 after adjusting for $F$.

## 5. Prior work and what is new

| Known | Source |
|---|---|
| LIONESS interpolates between the networks with and without a sample | @kuijjer2019lioness |
| For iENA, the per-sample change in correlation reduces, for a large reference set, to the product of standardized deviations | @yu2017iena |
| LIONESS and SSN edges are nearly linearly related | @deschildre2024evaluation |
| Smaller subpopulations receive higher LIONESS edge weights when two genes differ only in mean, observed in real data without a formula | @kuijjer2026challenges |

**New in this project:** the exact closed form of the LIONESS edge and the size of its reference-correlation term; the partial-correlation version; the $(1 - 2\pi)$ law of equation (3); the squared-factor consequence of equation (4) and its fix; and the equivalence of edges with their first-order features as classifier inputs, tested in simulation and real data. None of these was found in any source read.

## 6. Evidence from two pilot simulations

Both pilots were pre-registered with pass rules before any run.

**Pilot 1 (16 settings, 180 replicates): failed its rule, and showed why.** The IFN artifact was real but small (+0.0067 in AUC at a moderate IFN difference, +0.031 at a large one), and $R_1$ removed it. With a true co-expression change, edges gained +0.116 over $R_1$, but the planned competitor (separate products and squares, E5) reached only +0.029. A follow-up check showed first-order edges gaining +0.116 and exact edges +0.111: the competitor was wrong, the theory held.

**Pilot 2 (12 settings, 200 replicates): close call, read as a pass.**

| Question | Result |
|---|---|
| Real signal to match (edges over $R_1$, strong co-expression change) | +0.118 (MCSE 0.005) |
| Edges against first-order edges, all 12 settings | −0.0054 to +0.0017 |
| IFN artifact at a large IFN difference (edges over $R_0$) | +0.0201 (MCSE 0.0027), at the 0.02 threshold: the close call |
| Co-expression signal at 40 per class | +0.048 |
| Squared IFN score removes the artifact (normal and heavy-tailed noise) | −0.0025 to −0.0019 |
| The same with a two-gene IFN score | −0.0022 |

Both pilots built the richer models on $R_1$. The full study builds them on E1 (section 7.1); the quick run tests that change first.

## 7. Methods

### 7.1 Models

All models predict SLE against RA. The models nest: $R_0 \subset R_1 \subset \text{E1} \subset \text{E1} + \text{one feature set}$, so each comparison asks whether one set of features adds to a fixed base.

| # | Model | Inputs | Role |
|---|---|---|---|
| 1 | B1 | age, sex, batch | clinical baseline |
| 2 | B2 | B1 + cell composition | composition |
| 3 | $R_0$ | B2 + residual IFN score | the original baseline; shows the artifact |
| 4 | $R_1$ | $R_0$ + squared residual IFN score + squared composition | the fair interferon baseline (Result 4) |
| 5 | E1 | $R_1$ + gene levels | the expression model, and the base of models 7 to 10 |
| 6 | E4 | regularized discriminant analysis on the genes, with $R_1$ | quadratic discriminant analysis |
| 7 | E5 | E1 + products and squares of standardized genes | the edges' information, entered separately |
| 8 | F1 | E1 + first-order edges | the formula: the matched competitor of LIONESS |
| 9 | N1 | E1 + LIONESS edges | **the main network model** |
| 10 | N2 | E1 + LIONESS partial-correlation edges, given the IFN score and composition | the conditioned network |
| 11 | N1 with $R_0$ | $R_0$ + LIONESS edges | the artifact, outside the nesting |

**Fitting.** Every model with genes or edges, except E4, is an elastic-net logistic regression [@friedman2010glmnet] with mixing parameter 0.5, the penalty chosen by inner 5-fold cross-validation on deviance; the baseline terms are unpenalized, so that genes and edges must earn their place. E4 chooses its two regularization parameters from a grid by inner 5-fold cross-validation.

**Methods not fitted.** Random forests, shrinkage linear discriminant analysis, SSN, iENA, SWEET, BONOBO, module eigengenes [@langfelder2008wgcna], and differential-correlation pairs [@mckenzie2016dgca] answer none of the three aims; they would only rank LIONESS against other methods. SSN, iENA, SWEET, and BONOBO edges are also closed-form functions of the sample's own deviations, and the Discussion shows how the results extend to them.

### 7.2 Estimands and tests

For a model $M$, $\mathrm{AUC}(M)$ is the probability that a randomly drawn SLE patient receives a higher out-of-sample score than a randomly drawn RA patient. The contrasts are

$$
\begin{aligned}
\Delta_1 &= \mathrm{AUC}(\text{N1}) - \mathrm{AUC}(\text{E1}), \\
\Delta_2 &= \mathrm{AUC}(\text{N1}) - \mathrm{AUC}(\text{F1}), \\
A &= \mathrm{AUC}(\text{N1 with } R_0) - \mathrm{AUC}(R_0), \\
P &= \mathrm{AUC}(\text{N1}) - \mathrm{AUC}(\text{E5}).
\end{aligned}
\tag{6}
$$

- $\Delta_1$ (primary): do edges add beyond interferon, its square, composition, and the gene levels? Superiority, corrected resampled $t$-test at the 5% level [@nadeau2003inference].
- $\Delta_2$ (primary): do edges add beyond their own formula? Equivalence, declared when the 90% confidence interval lies within $\pm 0.01$ (two one-sided tests) [@schuirmann1987tost].
- $\Delta_1$ and $\Delta_2$ are tested in that order (fixed sequence).
- $A$ beside $\Delta_1$ (secondary): the size of the interferon artifact and its removal.
- $P$ (secondary): the parametrization effect.

### 7.3 Simulation study

**Aims.** To check Results 3 and 4 numerically, and to measure, across realistic settings, the contrasts of equation (6) and the error rates and power of the tests of section 7.2.

**Data-generating mechanism.** Two classes, 50 genes: 20 load on an IFN factor (5 of them form the IFN score), a 10-gene module whose correlation can differ between classes, and 20 load on a composition factor, observed without error. The classes may differ in the mean and spread of the IFN factor, in gene means, or in the module correlation. The gene set is the 45 genes outside the IFN score (990 edges).

| Study | Factor | Levels | Held at | Aim |
|---|---|---|---|---|
| S1, unequal groups | share of the smaller class $\pi$ | 0.5, 0.3, 0.15 | | equation (3) |
| S1 | mean shift $\Delta$ (pooled SD) | 0.25, 0.5, 1 | | equation (3) |
| S2-A, artifact and fix | IFN difference (shift, SD ratio) | none (0, 1); small (0.25, 1.25); moderate (0.5, 1.5); large (1, 2.25); very large (1.5, 3) | 80 per class, $\pi = 0.5$, 5 score genes, normal noise | 2 |
| S2-A | score genes | 2, 5, 10 | large IFN difference | 2 |
| S2-A | noise | normal, $t_5$ | large IFN difference | 2 |
| S2-A | size of the smaller class | 40, 80, 150, 300 | large IFN difference | 2 |
| S2-B, equivalence and power | module correlation change $\Delta\rho$ | 0, 0.1, 0.2, 0.3, 0.4 | 80 per class, $\pi = 0.5$, normal noise, mixing 0.5 | 1, 3 |
| S2-B | size of the smaller class | 40, 80, 150, 300 | $\Delta\rho = 0.2$ | 1, 3 |
| S2-B | $\pi$ | 0.5, 0.3, 0.15 | $\Delta\rho = 0.2$ | 1 |
| S2-B | noise | normal, $t_5$, $t_3$ | $\Delta\rho = 0.4$ | 1 |
| S2-B | elastic-net mixing | 0 (ridge), 0.5, 1 (lasso) | $\Delta\rho = 0.4$ | 3 |

Factors vary one at a time around the base settings: 9 settings in S1 and 25 in S2.

**Methods.** The models of section 7.1 that apply to simulated data ($R_0$, $R_1$, E1, E4, E5, F1, N1, N2, and N1 with $R_0$), in stratified 5-fold cross-validation. In seven test settings each replicate also runs the full real-data procedure of section 7.2.

**Performance measures.** Pooled out-of-fold AUC and the paired contrasts of equation (6), each with its Monte Carlo standard error (MCSE); in S1, the bias of the group difference in mean edge against equation (3); in the test settings, the rejection rate of the $\Delta_1$ test (its level when $\Delta\rho = 0$, its power otherwise) and the rate at which equivalence of $\Delta_2$ is declared.

**Replicates.** 400 per S2 setting, giving an MCSE near 0.002 for a contrast whose replicate standard deviation is 0.04; 300 in the test settings (MCSE 0.013 for a rejection rate near 0.05); 1,000 per S1 setting. Each setting has its own seed from the design table. A quick run with 40 and 30 replicates comes first, to check the code and measure the runtime.

### 7.4 Real-data application

**Data.** PRECISESADS [@barturen2021precisesads; @precisesads2017data]: whole-blood RNA-seq, flow-cytometry cell counts, and recorded treatment for 955 patients with seven systemic autoimmune diseases, including SLE and RA, and 267 controls, from 18 centres; controlled access through ELIXIR Luxembourg. The public series GSE45291 is ruled out, because each of its processing dates holds one disease only.

**Patients.** Untreated SLE against untreated RA, where untreated means no systemic glucocorticoid, antimalarial, or conventional or biologic disease-modifying drug at sampling. If fewer than 40 untreated patients per disease remain, all patients are analysed with treatment indicators, and the untreated subset becomes a sensitivity analysis.

**IFN score.** The mean standardized expression of EPSTI1, IFI44L, LY6E, OAS3, and RSAD2, adapted from the IFN5 score, which sums their log2 expression [@mai2021ifn5]; the residual score is its residual on cell composition.

**Gene set.** The 50 genes with the largest variance after regressing out the residual IFN score, composition, and batch, chosen in each training fold, with the IFN-score genes excluded (1,225 edges). A secondary analysis uses the IFN gene module as the gene set, where Result 4 predicts the largest artifact.

**Preprocessing and validation.** Gene selection, standardization, the IFN score, batch terms, and the LIONESS reference are all computed inside each training fold, and test edges use equation (5). Outer 5-fold cross-validation, stratified by disease and batch, repeated 20 times, with inner 5-fold tuning [@varma2006bias].

**Checks before analysis.** Disease by centre and by sequencing batch; untreated counts; the IFN score's distribution by disease, which places the data on the IFN-difference axis of S2-A.

**Sensitivity analyses.** Treated patients included; patients within the common support of the IFN score (each patient's score between the 5th and 95th percentiles of the other disease); batches that hold both diseases.

### 7.5 Replication in two open datasets

The simulation's findings are tested again on real patients by running the same pipeline inside each of two public datasets. Each is analysed on its own and never pooled, since disease would then equal study. The predictions below are fixed in the protocol before either dataset is analysed. Cross-validation is repeated 20 times.

| Dataset | Patients used | Composition | Limits |
|---|---|---|---|
| GSE17755 (two-colour array, peripheral blood cells) | females only: 22 SLE, 93 RA | estimated from the genes [@newman2015cibersort] | 10 of the 22 SLE were submitted seven months after every RA sample (sensitivity analysis with the other 12); no treatment recorded |
| GSE235508 (whole-blood RNA-seq, pregnancy) | one time point per pregnancy (time point 1: 16 SLE, 23 RA) | estimated from the genes | nearly all SLE samples treated; pregnancy changes cells and IFN; N2 not run (too few samples) |

| Simulation finding | Check on real data | Confirmed if |
|---|---|---|
| Edges equal their first-order formula | correlation of exact and first-order edges per sample; $\Delta_2$ | correlation above 0.99; $\Delta_2$ near zero |
| The interferon artifact | edges among IFN genes against the squared residual IFN score; $A$ | edges track the squared score; $A > 0$ |
| The squared score removes it | $\Delta_1$ beside $A$ | the gain shrinks once the squared score is in the base |
| Edge form against separate products | $P$ | reported only: the truth is unknown in real data |

With 16 to 22 SLE patients, the standard error of an AUC is roughly 0.06 to 0.08, so small AUC contrasts are not decisive here; the checks of the formula and of the squared score do not depend on AUC.

### 7.6 Validation of the trained model

The model trained on the PRECISESADS cross-sectional cohort is validated unchanged on its independent inception cohort, which was followed prospectively [@barturen2021precisesads], if that cohort is in the data release; otherwise by leave-centre-out validation across the 18 centres. Because test edges use equation (5), a trained model applies directly to new patients on the same platform. A fully external whole-blood RNA-seq dataset will be sought with the supervisor; one candidate is a cohort of 170 SLE and 19 RA patients [@sentis2026lupusarthritis], whose data are not public. GSE17755 and GSE235508 cannot validate a trained model: one is a different platform and tissue, the other a pregnancy cohort.

## 8. Expected results and their interpretation

| Outcome | Interpretation |
|---|---|
| $\Delta_2$ within $\pm 0.01$ | Edges are their formula: a network result can be reproduced, and explained, without building a network. The main message. |
| $\Delta_2$ outside the margin | The higher-order terms of equation (2) matter; the simulation shows where (small samples, heavy tails). |
| $\Delta_1 > 0$ | Edges add information beyond expression levels; by $\Delta_2$, that information is the quadratic features of the formula. |
| $\Delta_1 \approx 0$ but $A > 0$ | Edges looked useful only against a baseline without the squared IFN score: the artifact of Result 4 seen in real patients. |
| $P > 0$ | The edge form packages the quadratic information in a way penalized regression uses better than separate terms (Aim 3). |

## 9. Contributions and significance

1. The exact LIONESS edge and its first-order form, which explain what single-sample networks measure.
2. The equivalence of edges with that form as classifier inputs, with a fast replacement for the network computation.
3. The squared-factor artifact and its fix: one extra term in the baseline.
4. The $(1 - 2\pi)$ law, which warns against comparing mean edges between unequal groups.

Users of single-sample networks gain two checks that a network claim must pass: against the first-order formula, and against the squared shared factor.

## 10. Risks and mitigations

| Risk | Mitigation |
|---|---|
| PRECISESADS access refused or delayed | The theory, the simulation, and the two replication datasets carry the paper; request access now. |
| Too few untreated patients | Analyse all patients with treatment indicators; untreated subset as sensitivity analysis. |
| Close prior work [@yu2017iena; @kuijjer2026challenges] | State precisely what is new (section 5). |
| The IFN artifact is modest | Lead with equivalence; report the artifact as a second check. |
| The E1-based models were not piloted | The quick run tests them before the production run. |

## 11. Work plan

1. Confirm the design with the supervisor; submit the PRECISESADS access request, asking for the inception cohort and the centre labels.
2. Write the simulation protocol; run the quick run; then the production run (an estimated six to seven hours on three cores, to be measured by the quick run).
3. Download GSE17755 and GSE235508 and run the replication analyses.
4. Draft the manuscript; write the background report; run the real-data application when access is granted.
5. Mock peer review, revision, slides, and poster.

## 12. Pilot plan and pass criteria

The two earlier pilots built the richer models on $R_1$. This third pilot (`pilot-c/`) tests the design as it now stands, before the full study: the richer models built on E1, the conditioned network N2, which no pilot has run, and E4. It is a simulation only, with the data-generating mechanism of section 7.3 and new seeds.

| Cell | Mechanism | Level | Stress | Share $\pi$ | Size of the smaller class |
|---|---|---|---|---|---|
| 1 | null | | | 0.5 | 80 |
| 2 | IFN only | large (shift 1, SD ratio 2.25) | | 0.5 | 80 |
| 3 | IFN only | moderate (shift 0.5, SD ratio 1.5) | | 0.5 | 80 |
| 4 | IFN only | large | $t_5$ noise | 0.5 | 80 |
| 5 | mean shift | 0.5 | | 0.3 | 80 |
| 6 | network | $\Delta\rho = 0.4$ | | 0.5 | 80 |
| 7 | network | $\Delta\rho = 0.4$ | | 0.5 | 40 |
| 8 | network | $\Delta\rho = 0.2$ | | 0.5 | 80 |
| 9 | network | $\Delta\rho = 0.4$ | $t_5$ noise | 0.5 | 80 |

The models are $R_0$, $R_1$, E1, E4, E5, F1, N1, N2, and N1 with $R_0$ (section 7.1). The three questions and the pass rule, in terms of the contrasts of equation (6), each a paired difference within a replicate averaged over replicates, with its Monte Carlo standard error (MCSE):

1. Does the equivalence hold on the E1 base? (a) In cell 6, $\Delta_1 \ge 0.05$ and $\Delta_1 > 3$ MCSE: there is a signal to match. (b) In every cell, $\lvert \Delta_2 \rvert \le \max(0.01, 3\,\text{MCSE})$.
2. Does the signal survive at a small size and in the conditioned network? (a) In cell 7, $\Delta_1 \ge 0.03$. (b) In cell 6, $\mathrm{AUC}(\text{N2}) - \mathrm{AUC}(\text{E1}) \ge 0.05$.
3. Does the E1 base remove the interferon artifact? (a) In cells 2, 3, and 4, $\lvert \Delta_1 \rvert \le \max(0.01, 3\,\text{MCSE})$. (b) In the same cells, $\lvert \mathrm{AUC}(\text{N2}) - \mathrm{AUC}(\text{E1}) \rvert \le \max(0.01, 3\,\text{MCSE})$.

A value within three MCSE of a threshold is a close call for its clause. Pass if every clause passes; fail if 1(a), 1(b), or 3(a) fails; close call otherwise. The artifact $A$, the parametrization effect $P$, and E4 against E1 are reported in every cell but judged in none. Time box: one hour of compute on three cores; 200 replicates per cell if the timing run fits that, otherwise the largest multiple of 20 that fits, not below 60.

## 13. Decisions still open

- Confirmation of this design by the supervisor.
- The fallback if PRECISESADS access is refused.
- Whether to keep the original IFN-high and IFN-low comparisons as an extra analysis.
- A fully external validation dataset.
- The full text of Devlin, Gnanadesikan, and Kettenring (1975), still to be obtained.

## 14. Revision record

- 2026-11-03, stop 1: no IFN-low and IFN-high strata; SLE against RA in all patients, with the IFN score as a continuous covariate.
- 2026-11-03, revision 2: the exact closed forms, the partial-correlation version, the $(1 - 2\pi)$ law, the leakage-free test form, 17 models on the base $R_1$, two primary contrasts in fixed sequence.
- 2026-11-03, the first pilot (`pilot/`) failed its rule: the matched competitor (separate products and squares) was the wrong one. Revision 3 added the first-order edge model F1 and made the second contrast an equivalence test.
- 2026-11-04, the second pilot (`pilot-b/`) was a close call, read by the user as a pass; stage 3 began, and SSN, iENA, SWEET, and BONOBO were implemented.
- 2026-11-06, revision 4 (this text), rewritten from the user's working copy `proposal-new/proposal.md`: the richer models built on E1; the model set reduced to ten, with E4 kept; 400 replicates per setting; replication in GSE17755 and GSE235508; validation on the PRECISESADS inception cohort; a third pilot before stage 3. The full text of revisions 1 to 3 is in the git history (`git show 65f660c:proposal.md`).

## 15. Reference list

Every source cited here has an entry in `references/references.md`, copied from a record opened on the date its entry gives, with its passage in `manuscript/citations.csv`.
