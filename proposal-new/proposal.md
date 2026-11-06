# Proposal (working copy): LIONESS edges, the interferon score, and SLE against RA

| | |
|---|---|
| What this is | A refined, self-contained version of the proposal, for the user to edit. It consolidates `proposal.md` (sections 1 to 12, including revision 3), both pilots, and the stage 3 design. |
| Official record | `proposal.md` at the project root stays unchanged as the dated record the workflow follows. |
| Written | 2026-11-05; revised 2026-11-06 (models built on E1; model set reduced with E4 kept; 400 replicates; replication and validation plan) |
| Status | Draft for the user and Dr Grimes to refine; the full-study design is chosen by the user and awaits Dr Grimes's confirmation |

---

## 1. Summary in plain language

LIONESS is a popular method that gives each patient a score for every pair of genes, said to show how strongly the two genes work together in that patient. This project first asked whether those scores can tell systemic lupus erythematosus (SLE) from rheumatoid arthritis (RA) beyond what the interferon (IFN) score already tells us.

Checking the mathematics showed that a LIONESS score is a simple formula of the patient's own gene levels: roughly the product of the patient's two standardized gene values, plus a small correction. Two simulation studies then showed that this simple formula predicts exactly as well as LIONESS. Interferon leaks into LIONESS scores as interferon *squared*, and adding the squared IFN score to the comparison model removes that leak. LIONESS still detects real changes in how genes work together, because its formula packages that information well.

The project now asks whether LIONESS predicts SLE against RA beyond the IFN score, its square, cell composition, the ordinary gene levels, and its own simple formula, in all patients together.

## 2. The research problem

**In plain words.** Researchers treat LIONESS scores as each patient's own gene network and report differences as "network rewiring". Nobody has shown what a LIONESS score is made of. If it is a disguised formula of the patient's gene levels, then network findings may repeat ordinary expression, interferon can masquerade as rewiring, and unequal group sizes can create differences that are not real.

**Formally.** LIONESS single-sample edges are widely interpreted as patient-specific co-expression, but their mathematical content has not been derived. Without it, it is unclear whether edge-based findings reflect gene coordination or simpler functions of expression (the square of a shared factor, group imbalance, quadratic expression terms), and which comparisons a network claim must survive.

## 3. Research question

**Main question.** Is a LIONESS co-expression edge anything more than a closed-form quadratic function of each sample's own expression? And when classifying SLE against RA from whole blood, do LIONESS edges add information beyond the IFN score, its square, cell composition, the gene levels, and their own first-order features?

1. **Equivalence.** Do the exact LIONESS edges and their first-order features give the same out-of-sample classification, so that a network result can be reproduced without building a network?
2. **Artifact and fix.** When SLE and RA differ in IFN activity, how much do edges gain only by carrying the squared IFN level, and does a baseline with the squared score remove that gain?
3. **Parametrization.** Why does the edge form detect a real co-expression difference that the same information, entered as separate products and squares, does not?

## 4. How the idea changed

| | Original idea | Now |
|---|---|---|
| Task | Predict SLE against RA | Predict SLE against RA (unchanged) |
| Patients | Two comparisons: IFN-high SLE against IFN-high RA, and IFN-low SLE against IFN-low RA | All patients together; the user dropped the split |
| How interferon is handled | By the split | By the model: every patient's IFN score and its square |
| Key insight | An edge is mainly the product of the patient's standardized deviations plus a term in the reference correlation | The exact closed form, of which that insight is the first-order part |
| What LIONESS must beat | The IFN score, baselines, expression classifiers, network methods (17 models) | The IFN score and its square, composition, the gene levels (E1, the base of every richer model), quadratic discriminant analysis, separate products and squares, and the first-order formula (10 models); other network methods covered by the theory |
| Main message | Does LIONESS add information? | LIONESS edges are a formula; network claims must be checked against that formula and against the squared IFN score |

## 5. What is already known

- LIONESS builds the network of all samples and the network without one sample, and interpolates to give that sample's network [@kuijjer2019lioness]; its R implementation uses Pearson correlation by default [@kuijjer2019lionessr].
- For a related method (iENA), the per-sample change in correlation reduces, for a large reference set, to the product of standardized deviations [@yu2017iena].
- LIONESS and SSN edges are nearly linearly related [@deschildre2024evaluation].
- Smaller subpopulations receive higher LIONESS edge weights when two genes differ only in mean, observed in real data without a formula [@kuijjer2026challenges].
- Not found in any source read: the exact LIONESS form, the reference-correlation term and its size, the partial-correlation version, the $(1 - 2\pi)$ law, the squared-factor consequence, and the equivalence of edges with their first-order features as classifier inputs.

## 6. Theory

Notation: sample $q$ of $N$; genes $i$ and $j$; $r$ the Pearson correlation of all $N$ samples; $z_{qi}$ the expression of gene $i$ in sample $q$ standardized by the mean and standard deviation of all $N$ samples (divisor $N$); $a = 1/(N-1)$. LIONESS sets $e_q = N r - (N-1)\, r_{(-q)}$.

**Result 1 (exact Pearson edge).** Removing one sample is a rank-one change of the moments, so

$$
\begin{aligned}
r_{(-q)} &= \frac{r - a\, z_{qi} z_{qj}}{\sqrt{\left(1 - a\, z_{qi}^2\right)\left(1 - a\, z_{qj}^2\right)}}, \\[6pt]
e_q &= N r - (N-1)\, r_{(-q)} \\[4pt]
&= r + z_{qi} z_{qj} - \frac{r}{2}\left(z_{qi}^2 + z_{qj}^2\right) + O_p\!\left(N^{-1}\right).
\end{aligned}
\tag{1}
$$

The last line is the **first-order edge**: the reference correlation plus the influence function of the correlation at the sample [@devlin1975robust]. Checked against LIONESS to within $7 \times 10^{-13}$.

**Result 2 (partial correlation).** With residuals on the conditioning set, the same form holds, with a sample-specific inflation factor $(N-1)/(N-1-m_q)$, where $m_q$ is the sample's squared Mahalanobis distance; it is used only when the number of genes is at most $N/4$.

**Result 3 (unequal groups).** Under a pure mean shift $\Delta$ (pooled standard deviations) between groups with smaller share $\pi$,

$$
\mathrm{E}_1[e] - \mathrm{E}_0[e] \approx (1 - 2\pi)\left[\Delta_i \Delta_j - \frac{r}{2}\left(\Delta_i^2 + \Delta_j^2\right)\right],
\tag{2}
$$

zero for balanced groups. Simulation: 0.188 observed against 0.186 predicted at $\pi$ = 0.3.

**Result 4 (shared factor, the reason for the squared IFN score).** When genes $i$ and $j$ both follow a factor $F$ (interferon) with loadings $a_i$ and $a_j$,

$$
z_{qi}\, z_{qj} \approx a_i\, a_j\, F_q^2 ,
\tag{3}
$$

so their edge carries $F^2$. A baseline with the IFN score but not its square leaves room for edges to gain by repeating $F^2$. Hence the squared IFN score enters the baseline $R_1$ (section 7).

**Result 5 (test samples without leakage).** For a test sample scored against a training set of size $N$, with $b = 1/(N+1)$ and $z$ from the training set,

$$
\begin{aligned}
r_{(+q)} &= \frac{r + b\, z_{qi} z_{qj}}{\sqrt{\left(1 + b\, z_{qi}^2\right)\left(1 + b\, z_{qj}^2\right)}}, \\[6pt]
e_q &= (N+1)\, r_{(+q)} - N r .
\end{aligned}
\tag{4}
$$

## 7. The models

All models predict SLE against RA. Revised 2026-11-06 at the user's request: every model after E1 is built on **E1** (the baseline with the gene levels), not on $R_1$, so the models nest: $R_0 \subset R_1 \subset$ E1 $\subset$ E1 + further features. A model with genes or edges is an elastic net; the $R_1$ terms are unpenalized, and the genes and the added features are penalized.

| # | Name | Inputs | Purpose |
|---|---|---|---|
| 1 | B1 | age, sex, batch | Clinical baseline |
| 2 | B2 | B1 + cell composition | Composition |
| 3 | $R_0$ | B2 + residual IFN score (IFN score adjusted for composition) | The original baseline; shows the interferon artifact |
| 4 | $R_1$ | $R_0$ + **squared residual IFN score** + squared composition | The fair baseline (Result 4) |
| 5 | E1 | $R_1$ + gene levels | Ordinary expression model; **the base of every model below** |
| 6 | E4 | regularized discriminant analysis on the genes, with $R_1$ | Quadratic discriminant analysis, the textbook quadratic classifier |
| 7 | E5 | **E1** + products and squares of standardized genes as separate inputs | Same quadratic information as the edges, different parametrization |
| 8 | F1 | **E1** + first-order edges for every gene pair | The matched competitor of LIONESS |
| 9 | N1 | **E1** + LIONESS edges | **The main LIONESS model** |
| 10 | N2 | **E1** + LIONESS edges of the partial correlation given the IFN score and composition | The conditioned network |

**Models dropped (2026-11-06, the user's decision).** E2 (random forest), E3 (shrinkage linear discriminant analysis), and N3 to N8 (SSN, iENA, SWEET, BONOBO, module eigengenes, differential-correlation pairs) are not fitted. None answers one of the three questions of section 3; they only rank LIONESS against other methods. SSN, iENA, SWEET, and BONOBO are covered instead by a paragraph in the Discussion: each edge is also a closed-form function of the sample's own deviations, in the same quadratic family as the LIONESS edge [@liu2016ssn; @yu2017iena; @chen2023sweet; @saha2024bonobo]. Their functions stay in `R/networks.R` with their tests, unused by the simulation. This reverses the earlier choice to run SWEET and BONOBO in the simulation.

One model is kept outside the nesting on purpose: **N1 with $R_0$** ($R_0$ + LIONESS edges, no squared IFN score and no genes), which shows how much edges gain from interferon alone (the artifact of Result 4).

**The key comparisons.** (1) N1 against E1: do edges add anything beyond interferon, its square, composition, and the gene levels? (2) N1 against F1: do edges add anything beyond their own formula? Tested in that order. (3) N1 with $R_0$ against $R_0$, beside N1 against E1: the size of the interferon artifact and its removal.

**Note on the pilots.** Both pilots built these models on $R_1$, not E1. The equivalence of N1 and F1 compares two models on the same base, and E1 contains the squared IFN score, so the pilots' conclusions are expected to carry over; the full study tests the E1-based models directly, and its quick run shows it first.

## 8. Evidence so far

**Theory checks (stage 1).** Exact form matched LIONESS to $7 \times 10^{-13}$; first-order form correlated 0.997 or more with it; the product alone only 0.66 to 0.88 when $r$ was 0.5 or 0.9; the partial-correlation wording corrected; the $(1 - 2\pi)$ law confirmed; two IFN-driven genes gave edges correlated 0.74 with $F^2$, and 0.007 after adjusting for $F$.

**Pilot 1 (failed by its rule; 16 settings, 180 replicates).** The IFN artifact was real but small (+0.0067 in AUC at a moderate IFN difference, +0.031 at a large one) and $R_1$ removed it; edges gained +0.116 with a real co-expression change, but E5 reached only 0.029. A follow-up check, not pre-registered, showed first-order edges gaining 0.116 and exact edges 0.111: the competitor was wrong, the theory held.

**Pilot 2 (close call, read as a pass by the user; 12 settings, 200 replicates).**

| Question | Result |
|---|---|
| Real signal to match (edges over $R_1$, strong co-expression change) | +0.118 (MCSE 0.005) |
| Edges against first-order edges, all 12 settings | −0.0054 to +0.0017 |
| IFN artifact at a large IFN difference (edges over $R_0$) | 0.0201 (MCSE 0.0027), the close call |
| Co-expression signal at 40 per class | +0.048 |
| Squared IFN score removes the artifact (normal and heavy-tailed noise) | −0.0025 to −0.0019 |
| The same with a two-gene IFN score | −0.0022 |

## 9. The full study (design chosen; awaiting Dr Grimes)

- **S1, the unequal-groups law:** smaller-group share 0.5, 0.3, 0.15 by mean shift 0.25, 0.5, 1.
- **S2-A, the artifact and its fix:** IFN difference from none to very large; IFN score from 2, 5, or 10 genes; normal or heavy-tailed noise; 40 to 300 per class.
- **S2-B, equivalence, parametrization, and power:** co-expression change 0 to 0.4; 40 to 300 per class; smaller-group share down to 0.15; noise up to $t_3$; ridge, elastic net, or lasso.
- **Models:** the ten of section 7 that apply to simulated data ($R_0$, $R_1$, E1, E4, E5, F1, N1, N2) plus N1 with $R_0$; B1 and B2 need batch and are for real data only.
- **Tests:** in seven settings, the application's superiority test of edges over E1 and the equivalence test of edges against F1 (margin 0.01), to measure their error rates and power.
- **Size:** 400 replicates per setting (the user chose fewer than 500, 2026-11-06), a Monte Carlo standard error near 0.002 for a difference with replicate standard deviation 0.04. With fewer models, the run is expected to take about half the earlier 11.5 hours; the quick run measures it.

## 10. Real-data application

- **Data:** PRECISESADS (ELIXIR Luxembourg, controlled access) [@barturen2021precisesads]: 955 patients with seven systemic autoimmune diseases including SLE and RA, 267 controls, whole-blood RNA-seq, flow-cytometry cell counts, recorded treatment, 18 centres. The public GSE45291 is ruled out: every processing date holds one disease only.
- **IFN score:** the mean standardized expression of EPSTI1, IFI44L, LY6E, OAS3, and RSAD2, adapted from the IFN5 score [@mai2021ifn5]; the residual score is adjusted for cell composition; the score and its square enter $R_1$.
- **Patients:** untreated SLE against untreated RA; if fewer than 40 untreated patients per disease remain, all patients with treatment indicators, and the untreated subset as a sensitivity analysis.
- **Checks first:** disease by centre and by sequencing batch; untreated counts; IFN score distribution by disease.
- **Sensitivity analyses:** treated patients included; patients whose IFN scores overlap between diseases; batches holding both diseases.
- **Optional extra analysis:** the original IFN-high and IFN-low comparisons, beside the main analysis, to show that both give the same answer.

### 10.1 Replication of the simulation findings in two open data sets

The simulation findings are tested again on real patients by applying the same pipeline (the same models, the same nested cross-validation, the same AUC differences) inside each data set. Each data set is analysed on its own; they are never pooled with each other or with PRECISESADS, since disease would then equal study. The predictions are written into `protocol.md` before either data set is analysed.

| Data set | Patients used | Composition | Limits |
|---|---|---|---|
| GSE17755 (two-colour array, peripheral blood cells) | females only: 22 SLE, 93 RA | estimated from the genes (deconvolution) [@newman2015cibersort] | 10 of the 22 SLE were submitted seven months after every RA sample: a sensitivity analysis with the 12 SLE submitted with RA; no treatment recorded |
| GSE235508 (whole-blood RNA-seq, pregnancy) | one time point per pregnancy (time point 1: 16 SLE, 23 RA) | estimated from the genes | nearly all SLE treated (3 of 101 samples coded 0); pregnancy changes cells and IFN; N2 not run (too few samples for the partial correlation) |

| Simulation finding | Check on real data | Confirmed if |
|---|---|---|
| Edges equal their first-order formula | correlation of exact and first-order edges per sample; AUC of N1 against F1 | correlation above 0.99; AUC difference inside the equivalence margin, or its interval centred near 0 |
| The interferon artifact | edges among IFN genes against the squared residual IFN score; N1 with $R_0$ against $R_0$ | the edges track the squared score; a gain over $R_0$ |
| The squared score removes it | N1 against E1 beside N1 with $R_0$ against $R_0$ | the gain shrinks once the squared score is in the base |
| Edge form against separate products | N1 against E5 | reported only: the truth is unknown in real data |

Because the groups are small, AUC differences carry wide intervals (an AUC standard error of roughly 0.06 to 0.08); the checks of the formula and of the squared score do not depend on AUC and hold their meaning at these sizes. The cross-validation is repeated 20 times with new fold splits to steady the estimates.

### 10.2 Validation of the trained model

The PRECISESADS model is validated on the PRECISESADS inception cohort, an independent prospectively followed cohort [@barturen2021precisesads], if it is in the release; otherwise leave-centre-out across the 18 centres. New samples' edges use the add-one form against the training set, so a trained model applies unchanged on the same platform. A truly external whole-blood RNA-seq set (for example, the data of Sentis et al. 2026, 170 SLE and 19 RA, on request from the authors) is sought with Dr Grimes. GSE17755 and GSE235508 cannot validate the trained model: one is a different platform and tissue, the other a pregnancy population.

## 11. Contributions, impact, and risks

**Contributions.** The exact LIONESS formula and its first-order form; the equivalence of edges with that form as classifier inputs; the squared-factor artifact and its fix; the $(1 - 2\pi)$ law for unequal groups.

**Impact.** Users of single-sample networks gain two checks a network claim must pass (the first-order formula and the squared shared factor) and a fast replacement for the network computation.

**Risks.** Close prior work [@yu2017iena; @kuijjer2026challenges], to be met by framing what is new; simulation-only evidence until PRECISESADS access; modest effect sizes for the interferon artifact, so the paper leads with equivalence.

## 12. Open decisions

- [ ] Agree the main message with Dr Grimes (equivalence first; interferon second).
- [x] Full-study design chosen by the user (2026-11-06): models built on E1, E4 kept, E2, E3, and N3 to N8 dropped, 400 replicates per setting.
- [ ] Confirm the design with Dr Grimes before the production run.
- [ ] Ask in the PRECISESADS request for the inception cohort and the centre labels (section 10.2).
- [ ] Look for an external whole-blood RNA-seq validation set with Dr Grimes.
- [ ] Submit the PRECISESADS access request; decide the fallback if refused.
- [ ] Decide whether to contact the BONOBO authors about the difference between their code and their equation 8.
- [ ] Decide whether to keep the IFN-high and IFN-low comparison as an extra analysis.
- [ ] Confirm the target journal (BMC Bioinformatics; fallback Statistical Applications in Genetics and Molecular Biology).
- [ ] Obtain the full text of Devlin, Gnanadesikan, and Kettenring (1975).

## 13. Where things are

| File | What it holds |
|---|---|
| `proposal.md` | The official, dated proposal (sections 1 to 12) |
| `pilot/pilot-report.html`, `pilot-b/pilot-report.html` | The two pilot reports |
| `log/03-manuscript.md`, step 3.2 | The full-study design proposal |
| `R/lioness.R`, `R/networks.R`, `R/models.R` | LIONESS and the other methods; the models ($R_0$ and $R_1$ at lines 60 to 62 of `R/models.R`) |
| `references/references.md` | The reference list |
