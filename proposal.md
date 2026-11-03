# Proposal: When do LIONESS single-sample networks add information beyond the IFN score in SLE and RA?

| | |
|---|---|
| From | `idea.md`, 2026-11-03 |
| Written | 2026-11-03, workflow 0.2.4-md |
| Status | final 2026-11-03 (after revision 2 and the user's acceptance of every recommendation) |

## 1. Summary and verdict

A LIONESS edge has an exact closed form. For Pearson correlation it is a function of the reference correlation and the sample's two standardized expression values only, and for partial correlation it adds the sample's Mahalanobis distance; we checked both against LIONESS to machine precision. To first order, each edge is the reference correlation plus the influence function of the correlation, a quadratic function of the sample's own expression, as the idea proposed; for partial correlation the deviations must be residuals on the conditioning set, and the edge is inflated by a factor that grows with the sample's distance from the rest. Three consequences shape the study. First, a classifier on edges is, to first order, a classifier on a quadratic form of expression, so its matched comparators are quadratic discriminant analysis and a linear model on pairwise products and squares. Second, edges between genes that share a factor carry the square of that factor, so a reference model with the IFN score but not its square leaves IFN signal to be counted as network signal. Third, a pure difference in mean expression between unbalanced groups shifts the group mean of an edge in proportion to one minus twice the smaller group's share, with no change in co-expression. No reachable source states these results for LIONESS; the verdict waits on two full texts this session could not open (section 5). No public dataset holding SLE and RA whole blood from one study was confirmed. Recommendation: pilot as specified in section 7, with the decisions of section 9.

## 2. Question and why it matters

**Question (one sentence):** Do LIONESS edges improve the cross-validated classification of untreated SLE against untreated RA over a reference model that holds the continuous IFN score, its square, clinical covariates, and cell composition, and do they add anything beyond the quadratic expression model their closed form implies?

**Why it matters:** LIONESS edges are read as each patient's own gene coupling, and differences in them are reported as network rewiring. If an edge is a known quadratic function of the patient's expression, a gain from edges is a gain from quadratic expression features unless it survives the matched comparison. In SLE and RA, where the IFN factor moves many genes together, the squared factor is the first quadratic feature a network would pick up. The answer tells users which comparisons a network claim must survive, and gives them the closed form to check it.

**Primary estimands.** For a model $M$, $\mathrm{AUC}(M)$ is the probability that a randomly drawn untreated SLE patient from the cohort's population receives a higher out-of-sample score than a randomly drawn untreated RA patient, for $M$ fitted on a sample of the cohort's size. The two primary contrasts, tested in this order (fixed sequence, each at the 5% level):

1. $\Delta_1 = \mathrm{AUC}(R_1 + \text{edges}) - \mathrm{AUC}(R_1)$: do edges add beyond the reference?
2. $\Delta_2 = \mathrm{AUC}(R_1 + \text{edges}) - \mathrm{AUC}(R_1 + \text{matched quadratic})$: do edges add beyond their own first-order form?

$R_1$ is defined in section 7. The second contrast is tested only if the first is significant, which keeps the family-wise error at 5%.

## 3. The paper test

| Step | Answer | What is missing |
|---|---|---|
| 1. A procedure in wide use | LIONESS with Pearson correlation as its network function (the lionessR default), edges then compared between groups or used as classifier features [@kuijjer2019lioness; @kuijjer2019lionessr]. | The default was confirmed only through search results. |
| 2. A setting it was not built for | Whole blood in SLE and RA: one latent factor (type I IFN activity) and cell composition move many genes together; the IFN score differs between the diseases in level and spread; disease groups are unbalanced; treatment and batch shift expression [@elsherbiny2018twoscore]. | A confirmed dataset (section 6). |
| 3. The estimand, as a functional | What users believe an edge estimates: $\rho_{ij}(P_q) = \operatorname{corr}_{P_q}(X_i, X_j)$, the correlation in the subpopulation $P_q$ the sample comes from; for groups, $\rho_{ij}(P_1) - \rho_{ij}(P_0)$. | How users read edges is argued from how papers report them, not measured. |
| 4. The target and the bias term | Exact: equations (1) and (2). First order: $\rho_{ij}(P) + \mathrm{IF}_P(x_q)$ with $P$ the pooled reference. Group mean: equation (3); the mean-shift part is proportional to $(1 - 2\pi)$. | The remainder bound in closed form for heavy tails. |
| 5. A simulation that confirms it | Section 7, with null, IFN-only, mean-shift, and true-network cells, at two group balances. | Run in stage 2. |
| 6. A correction or a diagnostic | Diagnostic: the matched quadratic comparator and the squared IFN term in the reference. Correction for group comparisons of edges: condition on the shared factors (partial correlation given the IFN score and composition) and compare within-group correlations directly. | The pilot tests both. |
| 7. The application | Untreated SLE against untreated RA from one study, all patients together, the IFN score continuous. | A confirmed single-study dataset with both diseases. |

## 4. Mechanism and theory

**Notation.** Sample $q$ of $N$; genes $i$ and $j$; $r$ the Pearson correlation of all $N$ samples; $z_{qi}$ the expression of gene $i$ in sample $q$ standardized by the mean and standard deviation of all $N$ samples (divisor $N$); $a = 1/(N-1)$. LIONESS sets $e_q = N r - (N-1) r_{(-q)}$, where $r_{(-q)}$ leaves sample $q$ out [@kuijjer2019lioness].

**Result 1 (exact Pearson edge).** Removing one sample is a rank-one downdate of the first and second moments, which gives

$$
r_{(-q)} = \frac{r - a\, z_{qi} z_{qj}}{\sqrt{(1 - a z_{qi}^2)(1 - a z_{qj}^2)}}, \qquad
e_q = N r - (N-1)\, r_{(-q)}. \tag{1}
$$

The derivation is the agent's and is labeled a sketch until written out in full in stage 3. Numerical check (`log/01-idea-review.md`, D11): equation (1) matched LIONESS to within $7 \times 10^{-13}$ at $N$ = 10, 50, and 500, with a sixfold outlier in the data. Expanding (1) in $a$ gives the idea's first-order form,

$$
e_q = r + z_{qi} z_{qj} - \frac{r}{2}\left(z_{qi}^2 + z_{qj}^2\right) + O_p(1/N),
$$

the reference correlation plus the influence function of the correlation [@devlin1975robust; @croux2010influence]. The first-order form correlated 0.997 or more with the exact edge under normal data and 0.979 or more under $t_3$ data (D5). The product term alone correlated only 0.66 to 0.88 when $r$ was 0.5 or 0.9, so the reference-correlation term is needed. Equation (1) also shows where the first order fails: when $z_{qi}^2$ approaches $N - 1$, a single outlying sample, the denominator vanishes.

**Result 2 (exact partial-correlation edge).** Let $\Omega$ be the inverse of the covariance of the $p$ genes in the network (divisor $N$), $d_q$ the centered sample, $u_q = \Omega d_q$, $\varepsilon_{qi} = u_{qi}/\sqrt{\omega_{ii}}$, $m_q = d_q^\top \Omega d_q$ the squared Mahalanobis distance of the sample, and $c_q = 1/(N - 1 - m_q)$. The Sherman-Morrison formula for the downdated inverse gives

$$
r_{(-q)} = \frac{r - c_q\, \varepsilon_{qi} \varepsilon_{qj}}{\sqrt{(1 + c_q \varepsilon_{qi}^2)(1 + c_q \varepsilon_{qj}^2)}}, \qquad
e_q \approx r + \frac{N-1}{N-1-m_q}\left[\varepsilon_{qi} \varepsilon_{qj} + \frac{r}{2}\left(\varepsilon_{qi}^2 + \varepsilon_{qj}^2\right)\right]. \tag{2}
$$

The second term has a plus sign because $\varepsilon_{qi}$ and $\varepsilon_{qj}$ are residuals on all other genes, partner included, and correlate at $-r$; written with residuals on the conditioning set alone, the form matches the Pearson one. Numerical check (D12): the exact form matched LIONESS to within $1.3 \times 10^{-12}$ for $p$ from 4 to 45 at $N$ = 50 and 100. The inflation factor $(N-1)/(N-1-m_q)$ is sample-specific: on average $m_q$ is close to $p$, so edges of samples far from the rest are inflated most, and every edge becomes unstable as $p$ approaches $N$ (at $p$ = 45 and $N$ = 50, errors of the first-order form reached 35). This corrects the idea's wording, which used raw standardized deviations (D6), and sets a working limit: partial-correlation LIONESS is used only when $p \le N/4$, a little stricter than the checked case $p$ = 30, $N$ = 100 (mean $m_q/(N-1)$ of 0.30), where the scaled form in (2) correlated 0.9997 with the exact edge.

**Result 3 (group means of edges).** Let group $g$ have share $\pi_g$, mean $\mu_g$, and within-group covariance $C_g$, all in units of the pooled standard deviations, with $\delta_g = \mu_g - \mu$ the group's deviation from the pooled mean. Averaging the first-order form over group $g$ gives

$$
E_g[e] \approx r + C_{g,ij} + \delta_{gi}\delta_{gj} - \frac{r}{2}\left(C_{g,ii} + \delta_{gi}^2 + C_{g,jj} + \delta_{gj}^2\right). \tag{3}
$$

For two groups with mean difference $\Delta$ (pooled units), $\delta_1 = (1-\pi)\Delta$ and $\delta_0 = -\pi\Delta$, so a pure mean shift with equal within-group covariances moves the difference in mean edges by

$$
E_1[e] - E_0[e] \approx (1 - 2\pi)\left[\Delta_i \Delta_j - \frac{r}{2}\left(\Delta_i^2 + \Delta_j^2\right)\right],
$$

zero for balanced groups and growing with imbalance. Numerical check (D13, 400 replicates of $N$ = 200, two genes with no co-expression in either group): at $\pi$ = 0.5, 0.3, and 0.15 the observed differences were 0.001, 0.188, and 0.354 against 0.000, 0.186, and 0.362 from the formula, each within 0.8 Monte Carlo standard errors. This is a mechanism for the "subpopulation size bias" that SWEET was built to remove [@sweet2023]; the formula says where it comes from.

**Result 4 (shared factor).** When genes load on a factor $F$, $z_{qi} z_{qj} \approx a_i a_j F_q^2$, so their edge carries $F^2$. Sketch (D7): with classes differing only in the spread of $F$, the mean edge was 0.23 in one class and 0.80 in the other and correlated 0.74 with $F^2$; after conditioning on $F$, 0.007. A reference model holding the IFN score but not its square therefore credits the squared IFN signal to the network.

**Result 5 (test samples without leakage).** For a test sample scored against a training reference of size $N$, adding the sample is the update that (1) reverses: $e_q = (N+1)\, r_{(+q)} - N r$ with $r_{(+q)} = (r + b z_i z_j)/\sqrt{(1 + b z_i^2)(1 + b z_j^2)}$, $b = 1/(N+1)$, and $z$ standardized by the training moments. Numerical check (D14): equal to the direct computation to ten decimals. Edges for test samples thus need only the training moments, which makes leakage-free cross-validation cheap.

**What the idea claims, and where it stands now.**

1. *Pearson first-order form:* holds; strengthened to the exact form (1).
2. *Partial-correlation first-order form:* holds after two corrections (residuals on the conditioning set; the Mahalanobis inflation of (2)), and only for $p \le N/4$.
3. *"Indicates which expression-based models a network method must be compared with":* holds. A linear classifier on all edges is, to first order, a linear function of the products $z_i z_j$ and squares $z_i^2$: the same function class as quadratic discriminant analysis and as a linear model on pairwise products and squares. These are the matched comparators, and the second primary contrast tests against them.
4. *Primary comparison against a reference with the residual IFN score:* needs the square of the score (Result 4), and by the same argument squared composition terms.

## 5. Prior work and novelty

| Source | What it did | What it did not do | Relation to the idea |
|---|---|---|---|
| @kuijjer2019lioness | Introduced LIONESS as a linear interpolation between a network with and without a sample; validated it on simulated per-sample networks. | No closed form for Pearson or partial-correlation edges. | The procedure in question. |
| @kuijjer2019lionessr | lionessR, with Pearson correlation as the default. | No analysis of what the default's edges estimate. | The default the study evaluates. |
| @devlin1975robust | Derived the influence function of the Pearson correlation and showed it is unbounded. | Nothing on single-sample networks. | The first-order form of Result 1. |
| @yu2017iena | iENA: single-sample Pearson correlation (sPCC) edges from a reference set, used for disease prediction. | Formula not opened in this stage. | The closest method whose edges may already be explicit products of deviations; must be read before the verdict is final. |
| @liu2016ssn | SSN: per-sample change in Pearson correlation against a control set. | Not opened. | A perturbation of the same kind; Result 5 gives its edge in closed form, since its change in correlation is $r_{(+q)} - r$. |
| @npj2024evaluation | Compared SSN, LIONESS, SWEET, iENA, CSN, and SSPGI on cell lines; reported a near-perfect linear relation between SSN and LIONESS edges sharing an aggregate network, and LIONESS edges ranging over tens of units. | No closed form; no classification against expression-based baselines in the snippets read. | Both findings follow from (1): the two methods share $z_i z_j$, and the edge's spread does not shrink with $N$. |
| @kuijjer2026challenges | Compared five single-sample methods and reported an accuracy-specificity trade-off; noted that SWEET and BONOBO pull edges toward the background correlation. | Full text not reachable. | The most recent and closest critique; must be read before the verdict is final. |
| @sweet2023 | SWEET, a sample-weighted variant built to correct subpopulation size bias. | No closed form for the bias seen. | Result 3 gives the bias's form, $(1 - 2\pi)$. |
| @jpr2020metabolomics | Evaluated single-sample methods on metabolomics; edges separated patients from controls but not disease causes. | No derivation. | Evidence that edges add little discrimination. |
| @bonobo2024 | BONOBO, a Bayesian single-sample covariance method. | Not compared with quadratic expression models. | One of the network comparators. |
| @pseudovalue2023microbiome | Used jackknife pseudo-values of co-abundance to adjust networks for covariates. | Not about LIONESS. | The pseudo-value reading in a neighboring field. |

**Verdict:** new as stated, built from known parts. The first-order form is assembled from classical results; the exact forms (1) and (2), the Mahalanobis inflation, and the $(1 - 2\pi)$ law were not found in any source reached. What the study adds beyond the closest sources: the closed forms, the three consequences of section 1, and a benchmark designed from them. [TO CONFIRM: the verdict after reading the full texts of @kuijjer2026challenges and @yu2017iena, which this session could not open]{.tc}

Searches are logged in `log/01-idea-review.md`.

## 6. Datasets

No dataset could be opened in this stage: the network policy of the session blocked GEO, PubMed, and every publisher. Every status is `verify`.

| Dataset | Accession | What is deposited (samples by group, format, access) | Status | Opened |
|---|---|---|---|---|
| PRECISESADS | ELIXIR Luxembourg, doi 10.17881/th9v-xt85 | Whole-blood RNA-seq, methylome, flow cytometry, and clinical data on SLE, RA, and other systemic autoimmune diseases with controls, from one study [@barturen2021precisesads; @precisesads2021data]; controlled access on request. | verify | no |
| GSE45291 | GEO | Reported as a whole-blood array cohort; papers disagree on whether it holds SLE only (about 290 patients and 20 controls) or also about 490 RA patients. | verify | no |
| GSE17755 | GEO | PBMC arrays from one series: RA, SLE, two forms of juvenile arthritis, healthy children and adults, 248 patients in all; treatment information unknown. | verify | no |
| GSE93272 | GEO | Whole-blood arrays (GPL570) of RA with controls and drug-response groups [@tasaki2018multiomics]; RA only. | verify | no |

**Recommended:** PRECISESADS, because its flow cytometry measures cell composition instead of estimating it, and its clinical data record treatment; GSE45291 is the fallback if its GEO record confirms both diseases. Combining an SLE series with an RA series from another study is ruled out: disease would equal study, and no batch adjustment separates them. **What the application shows:** whether LIONESS edges raise the cross-validated AUC for SLE against RA beyond $R_1$, and beyond the matched quadratic model.

**Checks on the chosen dataset before any analysis** (a data-description script in stage 2): disease by batch table (batches with one disease only are dropped or analyzed as a sensitivity); untreated counts by disease (the design needs at least 40 per disease, the pilot's smallest size); IFN score distribution by disease (overlap reported); composition by disease.

## 7. Study design and pilot plan

**The models (17), all fitted with elastic-net logistic regression unless named otherwise, the reference covariates unpenalized so that added features must earn their place:**

| # | Model | Features | What it controls for |
|---|---|---|---|
| 1 | B1 | age, sex, batch | the clinical baseline |
| 2 | B2 | B1 + cell composition | composition |
| 3 | $R_0$ | B2 + residual IFN score | the idea's reference |
| 4 | $R_1$ | $R_0$ + squared residual IFN score + squared composition terms | the shared-factor squares of Result 4; the reference of both primary contrasts |
| 5 | E1 | $R_1$ + genes of the gene set $G$ | linear expression |
| 6 | E2 | random forest on $R_1$ covariates and $G$ | nonlinear expression, untargeted |
| 7 | E3 | shrinkage linear discriminant analysis on $G$, with $R_1$ | the linear Gaussian classifier |
| 8 | E4 | regularized discriminant analysis between linear and quadratic on $G$, with $R_1$ | quadratic discriminant analysis |
| 9 | E5 | $R_1$ + $z_i z_j$ and $z_i^2$ for $i, j \in G$ | the matched quadratic model, first-order twin of LIONESS |
| 10 | N1 | $R_1$ + LIONESS-Pearson edges on $G$ | the primary network model |
| 11 | N2 | $R_1$ + LIONESS edges of the partial correlation given the IFN score and composition | the conditioned network |
| 12 | N3 | $R_1$ + SSN edges [@liu2016ssn] | a sister perturbation method |
| 13 | N4 | $R_1$ + iENA sPCC edges [@yu2017iena] | an explicit-deviation method |
| 14 | N5 | $R_1$ + SWEET edges [@sweet2023] | a size-weighted method |
| 15 | N6 | $R_1$ + BONOBO edges [@bonobo2024] | a Bayesian method |
| 16 | N7 | $R_1$ + co-expression module eigengenes [CITE: WGCNA]{.cite} | population-level modules |
| 17 | N8 | $R_1$ + products $z_i z_j$ of the pairs selected by differential correlation [@mckenzie2016dgca] | population-level differential correlation |

**The gene set $G$:** the 50 genes with the largest variance after regressing out the residual IFN score, composition, and batch, chosen within each training fold (1,225 edges); the genes of the IFN score are excluded from $G$ so that the score and the edges do not share genes. A secondary analysis uses the IFN gene module as $G$, where Result 4 predicts the largest artifact.

**Preprocessing, all inside each training fold:** gene selection; standardization; the IFN score; composition estimates if not measured [@newman2015cibersort]; batch terms; the LIONESS reference (test edges by Result 5). The IFN score is the mean of standardized expression of a pre-specified gene set (recommended: EPSTI1, IFI44L, LY6E, OAS3, RSAD2 [@mai2021ifn5]); the residual IFN score is its residual on composition.

**Cross-validation:** outer 5-fold, stratified by disease and batch, repeated 20 times; inner 5-fold for tuning [@varma2006bias]. Out-of-fold AUC per repeat; the contrasts $\Delta_1$ and $\Delta_2$ are averaged over repeats, with the corrected resampled t-test for their uncertainty [@nadeau2003inference].

**Sensitivity analyses:** all patients with treatment indicators in the reference; patients within the common support of the IFN score (each patient's score between the 5th and 95th percentiles of the other disease), which replaces the idea's IFN-matched controls; batches holding both diseases only.

**The pilot (stage 2) is a simulation of this design.** Two classes, 50 genes (20 loading on an IFN factor $F$, 30 not), the full 17-model pipeline replaced by the seven models that decide the critique ($R_0$, $R_1$, E1, E4, E5, N1 with $R_0$, N1 with $R_1$).

| Factor | Levels | Reason |
|---|---|---|
| Mechanism | null; IFN only (classes differ in the mean and spread of $F$); mean shift only (non-IFN genes); true network (conditional correlation of a 10-gene module differs) | One cell per route by which edges differ between classes, plus a null. |
| IFN difference (IFN-only cells) | none; moderate (mean of $F$ shifted by 0.5 SD, spread ratio 1.5); large (shift 1 SD, ratio 2.25) | From no effect to a large one; SLE and RA differ in both level and spread. |
| Conditional correlation change (network cells) | 0.1, 0.2, 0.4 | From a small effect to a large one. |
| Share of the smaller class $\pi$ | 0.5, 0.3 | Result 3: the mean-shift artifact is zero at 0.5 and present at 0.3. |
| Class size (smaller class) | 40, 80, 150 | From the design's minimum to the size candidate datasets suggest. |

Measures: out-of-fold AUC differences against $R_1$, with Monte Carlo standard errors; the bias of the group-mean edge difference against equation (3). Known-answer checks, as tests in stage 2, never as results: equation (1) and Result 5 equal LIONESS to $10^{-8}$; the null cell gives AUC near 0.5. Replicates: 200 per cell, which gives a Monte Carlo standard error near 0.003 for an AUC difference whose replicate standard deviation is 0.04. Runtime, from operation counts, not from a run: about 20 cells (not a full factorial: the class-size and balance levels are crossed with the middle effect level only) by 200 replicates, under three hours on three cores with the closed-form edges; a timing run of ten replicates in stage 2 replaces this estimate.

**The three questions and the pass rule, decided before any run:**

1. Does the effect exist? Pass if, in the IFN-only cell with the moderate IFN difference, $\pi$ = 0.5, and 80 per class, LIONESS edges added to $R_0$ raise the AUC by at least 0.05, and the gain exceeds three Monte Carlo standard errors.
2. Is it large enough to matter at realistic sizes? Pass if the same gain is at least 0.03 at 40 per class.
3. Is there a fix or a diagnostic? Pass if (a) in the IFN-only and mean-shift cells, the gain of N1 with $R_1$ over E5 lies within 0.01 of zero, or within three Monte Carlo standard errors of zero when that is wider; and (b) in the network cell with change 0.4, $\pi$ = 0.5, and 80 per class, E5 reaches at least 90% of the AUC gain of N1 over $R_1$.

A value within three Monte Carlo standard errors of a threshold is read as at the threshold and reported as a close call for that clause. Combination: pass if questions 1, 2, and 3 pass; close call if 1 and 3 pass and the gain of question 2 lies between 0.01 and 0.03; fail if question 1 or question 3(a) fails. A fail on question 1 turns the project into a benchmark without a critique; a fail on 3(a) means the safeguards do not remove the false signal and the design changes before any real data are touched.

**Code and data that exist:** the numerical checks in `log/01-idea-review-theory-check.py` and `log/01-idea-review-exact-forms.py`; nothing else. The user asked that earlier work not be relied on.

## 8. Impact and fit

LIONESS has an R implementation [@kuijjer2019lionessr] and its edges are tested between groups or fed to classifiers [CITE: a count or survey of LIONESS applications to group comparison and classification]{.cite}. The closed forms let any user compute what an edge is made of without leave-one-out refits, and the $(1 - 2\pi)$ law and the squared-factor result give two checks a network claim must pass. In blood transcriptomes of IFN-driven diseases many gene pairs share the IFN factor, so the artifact of Result 4 reaches a large share of edges; question 2 of the pilot measures its size at realistic class sizes. The idea is a critique with a benchmark.

**Target journal:** BMC Bioinformatics, **fallback:** Statistical Applications in Genetics and Molecular Biology, from the journal guide's worksheet (`log/01-idea-review.md`).

## 9. Decisions

The user accepted every recommended answer on 2026-11-03. The design above already uses them.

- The partial-correlation network is the partial correlation given the IFN score and composition (model N2); full-conditional partial correlation among the genes of $G$ is used only when $p \le N/4$ (Result 2).
- $R_1$, the reference of both primary contrasts, holds the squared residual IFN score and squared composition terms (Result 4).
- The two primary contrasts $\Delta_1$ and $\Delta_2$ are tested in fixed sequence.
- Data source: PRECISESADS through an access request, GSE45291 as fallback.
- The seventeen models are those of section 7.
- The IFN score is the mean standardized expression of EPSTI1, IFI44L, LY6E, OAS3, and RSAD2; the residual score is adjusted for composition.
- "Untreated" means no systemic glucocorticoid, antimalarial, or conventional or biologic DMARD at sampling; if fewer than 40 untreated patients per disease remain, the primary analysis uses all patients with treatment indicators and the untreated subset becomes the sensitivity analysis.
- IFN-matched controls are replaced by the common-support sensitivity analysis.
- The gene set $G$ is 50 genes chosen in each training fold, the IFN-score genes excluded.
- Target journal: BMC Bioinformatics; fallback: Statistical Applications in Genetics and Molecular Biology.

One item stays open and is carried to the reference check: the novelty verdict of section 5, which waits on the full texts of @kuijjer2026challenges and @yu2017iena.

## 10. Reference list

Every source this proposal cites has an entry in `references/references.md`. None could be checked against its record in this session: the network policy blocked every publisher, PubMed, and Crossref, so each entry carries what web search results showed and `record: not opened`. The reference check (step 9 of the stage) runs once those hosts are allowed. Core citations have full text pending.

| Key | Grade | Identifier | Full text | Needed for |
|---|---|---|---|---|
| kuijjer2019lioness | core | arXiv 1505.06440; PMID 30981959 | pending | sections 3, 4, 5 |
| kuijjer2019lionessr | supporting | doi 10.1186/s12885-019-6235-7 | pending | sections 3, 5, 8 |
| devlin1975robust | core | Biometrika 62, 531-545 | pending | section 4 |
| croux2010influence | supporting | doi 10.1007/s10260-010-0142-z | pending | section 4 |
| yu2017iena | core | doi 10.1093/nar/gkx787 | pending | sections 5, 7 |
| liu2016ssn | supporting | doi 10.1093/nar/gkw772 | pending | sections 5, 7 |
| npj2024evaluation | supporting | doi 10.1038/s41540-024-00340-w | pending | section 5 |
| kuijjer2026challenges | core | doi 10.64898/2026.02.27.708608; PMID 41867852 | pending | section 5 |
| jpr2020metabolomics | supporting | doi 10.1021/acs.jproteome.0c00696 | pending | section 5 |
| bonobo2024 | supporting | Genome Research 34(9), 1397 | pending | sections 5, 7 |
| sweet2023 | supporting | PMC10025435 | pending | sections 4, 5, 7 |
| pseudovalue2023microbiome | supporting | arXiv 2303.13702 | pending | section 5 |
| elsherbiny2018twoscore | supporting | doi 10.1038/s41598-018-24198-1 | pending | section 3 |
| mai2021ifn5 | supporting | doi 10.1186/s13075-021-02414-0 | pending | section 7 |
| barturen2021precisesads | supporting | Arthritis Rheumatol 73(6), 1073-1085 | pending | section 6 |
| precisesads2021data | definitional | doi 10.17881/th9v-xt85 | not needed | section 6 |
| tasaki2018multiomics | supporting | PMID 30013029 | pending | section 6 |
| varma2006bias | definitional | doi 10.1186/1471-2105-7-91 | not needed | section 7 |
| nadeau2003inference | definitional | not seen | not needed | section 7 |
| mckenzie2016dgca | definitional | doi 10.1186/s12918-016-0349-1 | not needed | section 7 |
| newman2015cibersort | definitional | PMC4739640 | not needed | section 7 |

## 11. Revisions

- 2026-11-03, at stop 1: the user does not want IFN-low and IFN-high strata. The comparison is SLE against RA in all untreated patients, with the IFN score as a continuous covariate in the reference model.
- 2026-11-03, revision 2, at the user's request to refine the idea before the pilot (not yet final). Added: the exact closed forms of the Pearson and partial-correlation edges (Results 1 and 2) and their checks; the Mahalanobis inflation and the $p \le N/4$ limit; the group-mean formula and the $(1 - 2\pi)$ law (Result 3); the leakage-free test-sample form (Result 5); two primary estimands in fixed sequence; the full 17-model table with $R_1$ as the reference and the reference covariates unpenalized; the gene set, the preprocessing inside folds, the cross-validation, and the sensitivity analyses; dataset checks; group balance as a pilot factor. Every open question now carries a recommended answer.
- 2026-11-03, final: the user accepted every recommended answer ("YES"); section 9 lists the decisions. Step 9, the reference check, was run as far as the session allows: no record could be opened (the network policy blocks every publisher, PubMed, GEO, and Crossref), so all 21 entries keep `record: not opened`, `usable` stays `no` in `citations.csv`, and the check is carried forward to stage 2, where the pilot cites none of them. The novelty verdict stays marked until the two closest full texts are read.
