# Proposal: When do LIONESS single-sample networks add information beyond the IFN score in SLE and RA?

| | |
|---|---|
| From | `idea.md`, 2026-11-03 |
| Written | 2026-11-03, workflow 0.2.4-md |
| Status | final 2026-11-03 (after revision 2 and the user's acceptance of every recommendation) |

## 1. Summary and verdict

A LIONESS edge has an exact closed form. For Pearson correlation it is a function of the reference correlation and the sample's two standardized expression values only, and for partial correlation it adds the sample's Mahalanobis distance; we checked both against LIONESS to machine precision. To first order, each edge is the reference correlation plus the influence function of the correlation, a quadratic function of the sample's own expression, as the idea proposed; for partial correlation the deviations must be residuals on the conditioning set, and the edge is inflated by a factor that grows with the sample's distance from the rest. Three consequences shape the study. First, a classifier on edges is, to first order, a classifier on a quadratic form of expression, so its matched comparators are quadratic discriminant analysis and a linear model on pairwise products and squares. Second, edges between genes that share a factor carry the square of that factor, so a reference model with the IFN score but not its square leaves IFN signal to be counted as network signal. Third, a pure difference in mean expression between unbalanced groups shifts the group mean of an edge in proportion to one minus twice the smaller group's share, with no change in co-expression. The leading product term was published for a related method, and the subpopulation effect was documented empirically; the exact forms, the reference-correlation term, the inflation factor, the formula behind the subpopulation effect, and the squared-factor consequence were found in no source read (section 5). The one public data set holding SLE and RA whole blood from one study (GSE45291) has disease aliased with processing batch; PRECISESADS, under controlled access, is the only usable candidate (section 6). Recommendation: pilot as specified in section 7, with the decisions of section 9.

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
| 1. A procedure in wide use | LIONESS with Pearson correlation as its network function (the lionessR default), edges then compared between groups or used as classifier features [@kuijjer2019lioness; @kuijjer2019lionessr]. | none |
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

zero for balanced groups and growing with imbalance. Numerical check (D13, 400 replicates of $N$ = 200, two genes with no co-expression in either group): at $\pi$ = 0.5, 0.3, and 0.15 the observed differences were 0.001, 0.188, and 0.354 against 0.000, 0.186, and 0.362 from the formula, each within 0.8 Monte Carlo standard errors. This is a mechanism for the "subpopulation size bias" that SWEET was built to remove [@chen2023sweet]; the formula says where it comes from.

**Result 4 (shared factor).** When genes load on a factor $F$, $z_{qi} z_{qj} \approx a_i a_j F_q^2$, so their edge carries $F^2$. Sketch (D7): with classes differing only in the spread of $F$, the mean edge was 0.23 in one class and 0.80 in the other and correlated 0.74 with $F^2$; after conditioning on $F$, 0.007. A reference model holding the IFN score but not its square therefore credits the squared IFN signal to the network.

**Result 5 (test samples without leakage).** For a test sample scored against a training reference of size $N$, adding the sample is the update that (1) reverses: $e_q = (N+1)\, r_{(+q)} - N r$ with $r_{(+q)} = (r + b z_i z_j)/\sqrt{(1 + b z_i^2)(1 + b z_j^2)}$, $b = 1/(N+1)$, and $z$ standardized by the training moments. Numerical check (D14): equal to the direct computation to ten decimals. Edges for test samples thus need only the training moments, which makes leakage-free cross-validation cheap.

**What the idea claims, and where it stands now.**

1. *Pearson first-order form:* holds; strengthened to the exact form (1).
2. *Partial-correlation first-order form:* holds after two corrections (residuals on the conditioning set; the Mahalanobis inflation of (2)), and only for $p \le N/4$.
3. *"Indicates which expression-based models a network method must be compared with":* holds. A linear classifier on all edges is, to first order, a linear function of the products $z_i z_j$ and squares $z_i^2$: the same function class as quadratic discriminant analysis and as a linear model on pairwise products and squares. These are the matched comparators, and the second primary contrast tests against them.
4. *Primary comparison against a reference with the residual IFN score:* needs the square of the score (Result 4), and by the same argument squared composition terms.

## 5. Prior work and novelty

The sources below were read in full text from PubMed Central (2026-11-03), except where marked.

| Source | What it did | What it did not do | Relation to the idea |
|---|---|---|---|
| @kuijjer2019lioness | Introduced LIONESS, which reverse engineers sample-specific networks from aggregate networks by a linear interpolation between the network with and without a sample; validated it on simulated per-sample networks. | No closed form for Pearson or partial-correlation edges. | The procedure in question. |
| @kuijjer2019lionessr | lionessR; "the default network inference algorithm in netFun() is Pearson correlation". | No analysis of what the default's edges estimate. | The default the study evaluates. |
| @devlin1975robust | Derived the influence function of the Pearson correlation (full text not read; the form is stated through @croux2010influence and checked numerically in D5). | Nothing on single-sample networks. | The first-order form of Result 1. |
| @yu2017iena | iENA. Showed that per-sample changes in Pearson correlation reduce, when the reference set is large, to a single-sample PCC, $\mathrm{sPCC} = (x_i - \mu_i)(x_j - \mu_j)/\sqrt{V_i V_j}$: the product of the sample's standardized deviations (their equation 5). | No term in the reference correlation; not about LIONESS; no comparison with quadratic expression models. | The leading term of Result 1 is published here. Result 1 adds the term in $r$, without which the product correlated only 0.66 to 0.88 with the edge when $r$ was 0.5 or 0.9 (D5). |
| @liu2016ssn | SSN: the per-sample change in Pearson correlation against a reference set, with its mean and variance under the null. | No closed form in standardized expression. | Result 5 gives its edge in closed form, since its change in correlation is $r_{(+q)} - r$. |
| @deschildre2024evaluation | Compared SSN, LIONESS, SWEET, iENA, CSN, and SSPGI on cell lines; "an almost perfect linear relationship between edge weights of LIONESS and SSN" sharing an aggregate network; LIONESS edges ranged over $[-25, 30]$ in lung samples. | No closed form; no classification against expression-based baselines. | Both findings follow from (1): the two methods share $z_i z_j$, and the edge's spread does not shrink with $N$. |
| @kuijjer2026challenges | Recast LIONESS::PCC, SSN, SWEET, and BONOBO in common variables (a differential-correlation term, scale factors, and a background-correlation term). On GTEx esophagus data with varied subpopulation shares, found that for an edge with differential expression and no differential correlation "all methods predict higher edge weights for samples from the smaller population". | No closed form in standardized expression in the main text; Supplement 1, which holds the recast equations, could not be downloaded; no formula for the subpopulation effect. | The closest critique. Result 3 is the formula for their empirical finding, with the same direction: for $r$ near 0 and both genes shifted the same way, the smaller group's mean edge is higher by $(1-2\pi)\Delta_i\Delta_j$. |
| @chen2023sweet | SWEET, built to "address the network edge number bias caused by sample size differences". | No closed form for the bias. | Result 3 gives the bias's form. |
| @jahagirdar2021metabolomics | Evaluated ssPCC and LIONESS on metabolomics; in random-forest classification, ssPCC edges gave better or equal accuracy than concentrations in 13 of 22 data sets, LIONESS edges better in 5 of 22. | No reference model with quadratic features; no derivation. | Evidence that edge gains are inconsistent; the matched comparison explains when they arise. |
| @saha2024bonobo | BONOBO, a Bayesian model for sample-specific coexpression matrices. | Not compared with quadratic expression models. | One of the network comparators. |
| @ahn2024pseudovalue | SOHPIE-DNA, a regression on jackknife pseudo-values of network connectivity, adjusted for covariates. | Not about LIONESS. | The pseudo-value reading of a network statistic, in a neighboring field. |

**Verdict:** partly known. The product-of-deviations form is published for per-sample changes in correlation [@yu2017iena], and the effect of differential expression and subpopulation size on LIONESS edges is documented empirically [@kuijjer2026challenges]. New, in no source read: the exact closed forms (1) and (2); the term in the reference correlation and the size of the error without it; the Mahalanobis inflation of partial-correlation edges; the $(1-2\pi)$ formula behind the documented subpopulation effect; the squared-factor consequence for a reference model; and a benchmark designed from them. The paper frames Results 1 to 3 as the closed-form account of what @yu2017iena reduced to its leading term and @kuijjer2026challenges observed. [TO CONFIRM: that Supplement 1 of @kuijjer2026challenges does not already give the closed form; it could not be downloaded in this session]{.tc}

Searches are logged in `log/01-idea-review.md`.

## 6. Datasets

Opened 2026-11-03: the GEO series records and every sample record of the GEO series below, the ELIXIR Luxembourg landing page of PRECISESADS, and the PRECISESADS paper [@barturen2021precisesads]. A search of GEO for human series naming lupus and rheumatoid arthritis in blood returned 36 series; those with both diseases and at least 50 samples are listed.

| Dataset | Accession | What is deposited (samples by group, format, access) | Status | Opened |
|---|---|---|---|---|
| PRECISESADS | ELIXIR Luxembourg ELU-2-E592B0-1, doi 10.17881/th9v-xt85 | Cross-sectional cohort of 955 patients with 7 systemic autoimmune diseases (SLE and RA among them) and 267 healthy controls, plus an inception cohort of 113; whole-blood transcriptome and methylome, flow cytometry of B and T lymphocytes, monocytes, and neutrophils, treatment groups (steroids, biologics, immunosuppressants, antimalarials, antibiotics), 18 recruitment centres [@barturen2021precisesads; @precisesads2017data]. Controlled access on request; use limited to non-commercial research on systemic autoimmune diseases, with acknowledgement and notification of publications. Counts by diagnosis are in the paper's Supplementary Table 1, not read. | verified (records opened; data not accessed) | 2026-11-03 |
| GSE45291 | GEO, GPL13158 | 805 whole-blood arrays at baseline: SLE 292, RA DMARD-inadequate responders 378, RA TNF-inadequate responders 115, controls 20. Every processing date holds one group only (RA from March 2009 to April 2010, controls March 2010, SLE July 2010), and each set was normalized separately. No age, sex, or treatment fields. | verified, unusable: disease is aliased with processing batch, and every RA patient was treated | 2026-11-03 |
| GSE17755 | GEO, GPL1291 | Peripheral blood cells: RA 112, SLE 22, polyarticular JIA 6, systemic JIA 51, healthy 53. | verified, too few SLE (22) | 2026-11-03 |
| GSE235508 | GEO, GPL20301 | 335 whole-blood RNA-seq samples from 84 pregnancies (SLE 25, RA 38, healthy 21) at up to seven time points; medication and prednisolone fields; processed counts only (raw data withheld under Norwegian law). | verified, too few patients and a pregnancy population; a secondary data set at most | 2026-11-03 |
| GSE93272 | GEO, GPL570 (SubSeries of GSE93777) | Whole-blood arrays of RA with and without methotrexate, infliximab, or tocilizumab, and healthy volunteers [@tasaki2018multiomics]. | verified, RA only | 2026-11-03 |
| GSE149050 | GEO | Sorted immune cells of SLE (203 samples) and healthy controls (85); no RA. | verified, no RA | 2026-11-03 |

**Recommended:** PRECISESADS, the only data set found that holds SLE and RA from one study with measured composition and recorded treatment. Submit the access request now, since the stage 3 application depends on it. GSE45291, the previous fallback, is ruled out: a classifier trained on it learns processing date along with disease. **What the application shows:** whether LIONESS edges raise the cross-validated AUC for SLE against RA beyond $R_1$, and beyond the matched quadratic model.

**Checks on PRECISESADS before any analysis** (a data-description script in stage 2): diagnosis by recruitment centre and by sequencing batch (centres or batches with one disease only are dropped or analyzed as a sensitivity); untreated counts by disease (at least 40 per disease needed); IFN score distribution by disease; composition by disease.

[TO CONFIRM: the contingency if PRECISESADS access is refused or delayed past stage 3. Recommended: the paper stands on the theory and the simulation, and GSE45291 enters only as a cautionary example of disease aliased with batch, not as an application]{.tc}

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
| 14 | N5 | $R_1$ + SWEET edges [@chen2023sweet] | a size-weighted method |
| 15 | N6 | $R_1$ + BONOBO edges [@saha2024bonobo] | a Bayesian method |
| 16 | N7 | $R_1$ + co-expression module eigengenes [CITE: WGCNA]{.cite} | population-level modules |
| 17 | N8 | $R_1$ + products $z_i z_j$ of the pairs selected by differential correlation [@mckenzie2016dgca] | population-level differential correlation |

**The gene set $G$:** the 50 genes with the largest variance after regressing out the residual IFN score, composition, and batch, chosen within each training fold (1,225 edges); the genes of the IFN score are excluded from $G$ so that the score and the edges do not share genes. A secondary analysis uses the IFN gene module as $G$, where Result 4 predicts the largest artifact.

**Preprocessing, all inside each training fold:** gene selection; standardization; the IFN score; composition estimates if not measured [@newman2015cibersort]; batch terms; the LIONESS reference (test edges by Result 5). The IFN score is the mean of standardized expression of a pre-specified gene set (EPSTI1, IFI44L, LY6E, OAS3, RSAD2), adapted from the IFN5 score, which sums their log2 expression [@mai2021ifn5]; the residual IFN score is its residual on composition.

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
- Data source: PRECISESADS through an access request. (The fallback GSE45291 was ruled out at the reference check, section 6; the contingency is open.)
- The seventeen models are those of section 7.
- The IFN score is the mean standardized expression of EPSTI1, IFI44L, LY6E, OAS3, and RSAD2; the residual score is adjusted for composition.
- "Untreated" means no systemic glucocorticoid, antimalarial, or conventional or biologic DMARD at sampling; if fewer than 40 untreated patients per disease remain, the primary analysis uses all patients with treatment indicators and the untreated subset becomes the sensitivity analysis.
- IFN-matched controls are replaced by the common-support sensitivity analysis.
- The gene set $G$ is 50 genes chosen in each training fold, the IFN-score genes excluded.
- Target journal: BMC Bioinformatics; fallback: Statistical Applications in Genetics and Molecular Biology.

Two items stay open: the supplement check of the novelty verdict (section 5) and the data contingency (section 6).

## 10. Reference list

Every source this proposal cites has an entry in `references/references.md`, copied from its Crossref, PubMed, or PubMed Central record, opened 2026-11-03. Passages are recorded in `manuscript/citations.csv`. Full texts were read from PubMed Central or an open repository copy, except for @devlin1975robust and @croux2010influence (full text pending; a PDF in `references/pdfs/` would close them).

## 11. Revisions

- 2026-11-03, at stop 1: the user does not want IFN-low and IFN-high strata. The comparison is SLE against RA in all untreated patients, with the IFN score as a continuous covariate in the reference model.
- 2026-11-03, revision 2, at the user's request to refine the idea before the pilot (not yet final). Added: the exact closed forms of the Pearson and partial-correlation edges (Results 1 and 2) and their checks; the Mahalanobis inflation and the $p \le N/4$ limit; the group-mean formula and the $(1 - 2\pi)$ law (Result 3); the leakage-free test-sample form (Result 5); two primary estimands in fixed sequence; the full 17-model table with $R_1$ as the reference and the reference covariates unpenalized; the gene set, the preprocessing inside folds, the cross-validation, and the sensitivity analyses; dataset checks; group balance as a pilot factor. Every open question now carries a recommended answer.
- 2026-11-03, final: the user accepted every recommended answer ("YES"); section 9 lists the decisions. Step 9, the reference check, was run as far as the session allows: no record could be opened (the network policy blocks every publisher, PubMed, GEO, and Crossref), so all 21 entries keep `record: not opened`, `usable` stays `no` in `citations.csv`, and the check is carried forward to stage 2, where the pilot cites none of them. The novelty verdict stays marked until the two closest full texts are read.
- 2026-11-03, reference check (step 9), once the hosts were allowed: every record opened and every entry corrected from it; 19 full texts or abstracts read. Section 5 changed: @yu2017iena already gives the product-of-deviations form, and @kuijjer2026challenges already documents the subpopulation effect empirically, so the verdict became "partly known" with the new parts named; the metabolomics evaluation was misdescribed from a search snippet and is corrected. Section 6 changed: GSE45291 is aliased with processing batch and is ruled out; GSE17755 and GSE235508 are too small; PRECISESADS is the only candidate, and the contingency is a new open item. The IFN score is described as adapted from IFN5, which sums log2 expression. Six citation keys were renamed to match first author and year.

## 12. Revision 3 (2026-11-03): after the pilot

This section governs where it differs from sections 1 to 11, which stand as the record. It follows the stage 2 stop: the pilot failed by its rule (`pilot/pilot-report.html`, `pilot/results/verdict.rds`), and the user chose a revised proposal and a re-pilot in `pilot-b/`.

### 12.1 What the pilot showed

- The IFN artifact exists but is small: edges added to a reference without the squared IFN score raised the AUC by 0.0067 (MCSE 0.0022) with a moderate IFN difference and 0.031 (MCSE 0.0033) with a large one, and by -0.0017 at 40 per class. Adding the squared score removed it in every IFN-only cell.
- Edges carry a real co-expression signal: with a module correlation change of 0.4, edges gained 0.116 in AUC over $R_1$.
- The pre-registered matched quadratic model (products and squares as separate penalized features) reached only 0.029 of that gain. An exploratory probe after the verdict (`pilot/posthoc/probe_cell13.R`) found that the first-order edge features, $r + z_i z_j - \tfrac r2 (z_i^2 + z_j^2)$ computed from the training moments, gained as much as the exact edges. The two quadratic models hold the same information; the elastic-net penalty treats the two parametrizations differently.

### 12.2 The revised claim

The paper's central claim changes from "edges inflate classification through the IFN factor" to three statements, in order of weight:

1. **Equivalence.** A LIONESS Pearson edge is its first-order form plus a remainder of order $1/N$ (Result 1), and as classifier features the exact edges and the first-order edges perform the same. A network result can therefore be reproduced, and checked, without building any network.
2. **The shared-factor artifact and its fix.** When classes differ in a factor that many genes share, edges carry its square; a reference with the factor's square removes the artifact. Its size depends on how much the classes differ in the factor.
3. **Parametrization.** Under penalized fitting, the first-order edge form detects co-expression differences that the same quadratic information, entered as separate products and squares, does not. This is the positive content of LIONESS: a good feature construction, not a network.

The paper type stays a critique; the "correction" of question 6 of the paper test is now the first-order edge features themselves, and the diagnostic is the comparison of edges with them.

### 12.3 Changes to the study design (section 7)

- **New model F1** (first-order edges): an elastic net on the first-order edge features of the gene set $G$, with $R_1$ unpenalized; test samples use the training fold's correlation and standardization only. It joins the 17 models as an 18th.
- **The second primary contrast** becomes an equivalence test: $\Delta_2 = \mathrm{AUC}(R_1 + \text{edges}) - \mathrm{AUC}(R_1 + \text{F1})$, with equivalence declared when the 90% confidence interval lies within $\pm 0.01$ (two one-sided tests). E5 stays as a secondary model that shows the parametrization effect.
- **Pre-registration lesson.** A clause that one model "matches" another is paired with a clause that the model has something to match, so that it cannot pass on two nulls.

### 12.4 The re-pilot (`pilot-b/`)

Twelve cells, a subset of the first pilot's design plus two stress factors the critique table asked for: heavy-tailed noise ($t$ with 5 degrees of freedom, scaled to unit variance) and a less reliable IFN score (two genes instead of five). New seeds (cell seed $20261103 + 2000c$).

| Cell | Mechanism | Level | Stress | $\pi$ | $n$ |
|---|---|---|---|---|---|
| 1 | null | | | 0.5 | 80 |
| 2 | IFN only | large | | 0.5 | 80 |
| 3 | IFN only | moderate | | 0.5 | 80 |
| 4 | IFN only | large | two-gene score | 0.5 | 80 |
| 5 | IFN only | large | $t_5$ noise | 0.5 | 80 |
| 6 | mean shift | 0.5 | | 0.3 | 80 |
| 7 | network | 0.4 | | 0.5 | 80 |
| 8 | network | 0.4 | | 0.5 | 40 |
| 9 | network | 0.2 | | 0.5 | 150 |
| 10 | network | 0.4 | $t_5$ noise | 0.5 | 80 |
| 11 | network | 0.4 | | 0.3 | 80 |
| 12 | network | 0.2 | | 0.5 | 80 |

Models: $R_0$, $R_1$, E1, E5, F1 with $R_1$, edges with $R_0$, edges with $R_1$ (E4 is dropped: it ranked below $R_1$ in every IFN-only cell of the first pilot, and its tuning grid was the costliest step). Replicates from a timing run, within one hour on three cores.

**The three questions and the pass rule, decided before any run:**

1. Does the equivalence hold? (a) In cell 7, edges with $R_1$ gain at least 0.05 in AUC over $R_1$, by more than three MCSE (there is a signal to match). (b) In every cell, $\lvert \mathrm{AUC}(\text{edges} + R_1) - \mathrm{AUC}(\text{F1} + R_1) \rvert \le \max(0.01, 3\,\text{MCSE})$.
2. Is it large enough to matter at realistic sizes? (a) In cell 2, edges with $R_0$ gain at least 0.02 over $R_0$ (the artifact at a large IFN difference). (b) In cell 8 (40 per class), edges with $R_1$ gain at least 0.03 over $R_1$ (the co-expression signal at a small size).
3. Is there a fix or a diagnostic? (a) In cells 2, 3, and 5, $\lvert \mathrm{AUC}(\text{edges} + R_1) - \mathrm{AUC}(R_1) \rvert \le \max(0.01, 3\,\text{MCSE})$: the squared score removes the artifact, with normal and heavy-tailed noise. (b) The same in cell 4, with the two-gene score.

A value within three MCSE of a threshold is a close call for its clause. Combination: pass if every clause passes; fail if 1(a), 1(b), or 3(a) fails; close call otherwise (a failure of 2(a), 2(b), or 3(b), or any clause at its threshold). A failure of 3(b) means the fix depends on the reliability of the score, which the paper would then report as a limitation.

The thresholds of 2(a) and 2(b) were set after the first pilot, which showed gains of 0.031 and, at 80 per class, 0.116 in the corresponding cells; the re-pilot uses new seeds, and the thresholds are the smallest gains the paper would describe as mattering to a user. [TO CONFIRM: the thresholds 0.02 for the artifact and 0.03 for the co-expression signal at 40 per class]{.tc}

### 12.5 What is unchanged

The question of section 2 with $\Delta_2$ as revised above, the data plan and its open contingency (section 6), the decisions of section 9, the target journal, and the reference list.
