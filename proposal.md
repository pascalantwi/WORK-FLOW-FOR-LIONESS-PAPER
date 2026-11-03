# Proposal: When do LIONESS single-sample networks add information in IFN-stratified SLE and RA?

| | |
|---|---|
| From | `idea.md`, 2026-11-03 |
| Written | 2026-11-03, workflow 0.2.4-md |
| Status | draft, at stop 1 |

## 1. Summary and verdict

The idea asks whether LIONESS single-sample networks separate SLE from RA within IFN strata better than models that already hold the IFN score, clinical covariates, and cell composition. The review confirmed the idea's central formula for Pearson networks: a LIONESS edge is a jackknife pseudo-value, so to first order it equals the reference correlation plus the influence function of the correlation, a quadratic function of the sample's own standardized expression. In our numerical check the approximation correlated at 0.997 or more with the exact edge under normal data. The formula for partial correlation holds only after a correction (section 4) and only when there are far fewer genes than samples. No published source we could reach states the formula for LIONESS, although each of its parts is classical; the novelty verdict is "assembled from known parts, not stated for LIONESS", pending the full texts the session could not open (section 5). No public dataset holding both SLE and RA whole blood from one study was confirmed, and combining studies would make disease and batch inseparable. The recommendation is to pilot as proposed, by simulation, after the open questions on the data source and the model list are settled.

## 2. Question and why it matters

**Question (one sentence):** Within IFN-low patients, and within IFN-high patients, do LIONESS edges improve the cross-validated classification of SLE against RA over a reference model that holds the IFN score, clinical covariates, and cell composition, beyond what quadratic functions of expression already give?

**Why it matters:** LIONESS edges are read as each patient's own gene coupling, and differences in them are reported as network rewiring. If an edge is a quadratic function of the patient's expression, then a gain from edges is a gain from quadratic expression features, and a reference model without the square of the IFN score lets the IFN signal reappear as a network signal. The answer tells users which comparison a network claim must survive.

## 3. The paper test

| Step | Answer | What is missing |
|---|---|---|
| 1. A procedure in wide use | LIONESS with Pearson correlation as its network function (the lionessR default), edges then compared between groups with limma or used as classifier features [@kuijjer2019lioness; @kuijjer2019lionessr]. | The default's documentation was seen only through search results. |
| 2. A setting it was not built for | Whole-blood transcriptomes of SLE and RA, where one latent factor (type I IFN activity) and cell composition move hundreds of genes together, IFN level differs within and between diseases, and treatment and batch shift expression [@elsherbiny2018twoscore]. | A confirmed dataset (section 6). |
| 3. The estimand, as a functional | What users believe an edge estimates: the correlation of genes $i$ and $j$ in the subpopulation the sample comes from, $\rho_{ij}(P_q) = \operatorname{corr}_{P_q}(X_i, X_j)$, where $P_q$ is the distribution of samples in the same latent state as sample $q$. Between groups, the estimand of a "differential edge" is $\rho_{ij}(P_1) - \rho_{ij}(P_0)$. | Whether users read edges this way is argued from how papers report them, not measured. |
| 4. The target and the bias term | Sketch (section 4): a LIONESS edge targets $\rho_{ij}(P) + \mathrm{IF}_P(x_q)$, with $P$ the pooled reference. Its mean within group $g$ is $\rho_{ij}(P) + E_g[z_i z_j] - \tfrac{\rho_{ij}(P)}{2} E_g[z_i^2 + z_j^2]$, which differs from $\rho_{ij}(P_g)$ by terms in the group's mean shifts and variance ratios. | A full derivation of the remainder, and the regularized partial-correlation case. |
| 5. A simulation that confirms it | The pilot of section 7: classes that differ only in the IFN factor, only in means, or truly in conditional co-expression, with a null cell. | Run in stage 2. |
| 6. A correction or a diagnostic | Diagnostic: compare edges with the matched quadratic expression model (pairwise products and squares, QDA) and put the square of the IFN score in the reference. Correction for inference: condition on the IFN score before building networks. | The pilot tests both. |
| 7. The application | IFN-low SLE against IFN-low RA, and IFN-high SLE against IFN-high RA, untreated, from one study. | A confirmed single-study dataset with both diseases. |

## 4. Mechanism and theory

**The mechanism in words.** LIONESS builds a network from all $N$ samples and again without sample $q$, and scales the difference: $e_q = N\,r - (N-1)\,r_{(-q)}$ [@kuijjer2019lioness]. This is the jackknife pseudo-value of the correlation. A pseudo-value equals, to first order, the estimate plus the empirical influence function of the estimator at the left-out point [CITE: a textbook statement of the pseudo-value and influence-function link, for example Efron 1982]{.cite}. The influence function of the Pearson correlation at a point with standardized coordinates $(z_i, z_j)$ is $z_i z_j - \tfrac{\rho}{2}(z_i^2 + z_j^2)$ [@devlin1975robust], seen through its restatement in @croux2010influence.

**The sketch (Pearson), labeled as a sketch.** With $z$ standardized by the reference mean and the reference standard deviation (divisor $N$),

$$
e_q \approx r + z_{qi} z_{qj} - \frac{r}{2}\left(z_{qi}^2 + z_{qj}^2\right).
$$

Assumptions: finite fourth moments, a fixed number of genes, and the remainder of order $1/N$ times a polynomial in $z$ of degree up to four. The edge's average over samples is close to $r$, and its spread across samples does not shrink as $N$ grows (under normality its variance is near $(1-\rho^2)^2$, the asymptotic variance of $\sqrt{N}\,r$; this step is the agent's), which matches the wide edge ranges reported for LIONESS [@npj2024evaluation]. A full derivation needs the second-order term, to bound the error at large $|z|$.

**Numerical check (done in this stage, `log/01-idea-review.md`, D5).** Exact edges against the approximation, one pair of genes, seed 20261103:

| Data | $N$ | Correlation, exact vs approximation | Largest absolute error |
|---|---|---|---|
| Normal, $\rho$ = 0, 0.5, 0.9 | 20 to 500 | 0.997 to 1.000 | 0.012 to 0.75 |
| $t_3$ (heavy tails), same $\rho$ | 20 to 500 | 0.979 to 0.9998 | 0.21 to 6.2 |

The product term alone, without the reference-correlation term, correlated only 0.66 to 0.88 with the edge when $\rho$ = 0.5 or 0.9, so the idea is right to keep the second term. Heavy tails make single edges unstable, since the influence function is unbounded [@devlin1975robust].

**What the idea claims, and where it needs care.**

1. *Pearson.* Restated as above. Every step holds to first order. Numerical check: the table above, kept as a test in stage 2.
2. *Partial correlation.* As written ("the sample's standardized deviations from the reference mean") the formula does not hold: with raw deviations the approximation correlated only 0.87 to 0.98 with the exact edge. The first step that does not hold is the choice of deviations. The right ones are the standardized residuals of genes $i$ and $j$ on the conditioning set (without each other); equivalently, with $\varepsilon = \Omega x / \sqrt{\operatorname{diag}\Omega}$ from the precision matrix, the second term changes sign: $e_q \approx r + \varepsilon_i \varepsilon_j + \tfrac{r}{2}(\varepsilon_i^2 + \varepsilon_j^2)$. With that correction the approximation correlated 0.988 to 0.99998 with the exact edge, but its largest error grew with the number of genes $p$ against $N$ (3.7 at $p$ = 30, $N$ = 50). Genome-scale partial correlation needs a regularized estimator, for which the expansion has to be redone. [TO CONFIRM: which partial-correlation estimator the study uses (unregularized on a small gene set, or shrinkage), since the approximation covers only the first]{.tc}
3. *"Therefore indicates which expression-based models a network method must be compared with."* Supported, with a sharper statement: a linear classifier on all LIONESS edges is, to first order, a classifier on a quadratic form of the standardized expression, the same function class as quadratic discriminant analysis and as a linear model on pairwise products and squares. These are the matched comparators. Numerical check: in the pilot, the matched quadratic model's gain over the reference against the edges' gain.
4. *A consequence the idea does not state.* When two genes load on the IFN factor $F$, $z_i z_j \approx a_i a_j F^2$, so their edge carries $F^2$. In a sketch with two IFN-driven genes and classes that differ only in the spread of $F$, the mean edge was 0.23 in one class and 0.80 in the other, and the edge correlated 0.74 with $F^2$; after conditioning on $F$, the correlation fell to 0.007. A reference model with the residual IFN score but not its square leaves this gain to the network. [TO CONFIRM: that the reference model of the primary comparison holds the residual IFN score and its square (and, by the same argument, squares of the cell-composition terms)]{.tc}

## 5. Prior work and novelty

| Source | What it did | What it did not do | Relation to the idea |
|---|---|---|---|
| @kuijjer2019lioness | Introduced LIONESS as a linear interpolation between a network with and without a sample; validated it on simulated per-sample networks. | Did not give the edge in closed form for Pearson or partial correlation. | The procedure in question. |
| @kuijjer2019lionessr | lionessR, the R implementation, with Pearson correlation as the default. | No analysis of what the default's edges estimate. | The default the study evaluates. |
| @devlin1975robust | Derived the influence function of the Pearson correlation and showed it is unbounded. | Nothing on single-sample networks. | The second ingredient of the sketch. |
| @yu2017iena | iENA: single-sample Pearson correlation (sPCC) edges from a reference set, used for disease prediction. | Formula not opened in this stage; no comparison with quadratic expression models found. | The closest method whose edges may already be explicit products of deviations; its formula must be read before the novelty claim is final. |
| @liu2016ssn | SSN: per-sample change in Pearson correlation against a control set. | Not opened. | A leave-in perturbation like LIONESS. |
| @npj2024evaluation | Compared SSN, LIONESS, SWEET, iENA, CSN, and SSPGI on cell lines; reported a near-perfect linear relation between SSN and LIONESS edges sharing an aggregate network, and LIONESS edges ranging over tens of units. | No closed form; no classification against expression-based baselines in the snippets read. | Its findings follow from the sketch. |
| @kuijjer2026challenges | Compared five single-sample methods and reported an accuracy-specificity trade-off; noted that SWEET and BONOBO pull edges toward the background correlation. | Full text not reachable; whether it states the influence-function form is unknown. | The most recent and closest critique; must be read before the verdict is final. |
| @jpr2020metabolomics | Evaluated single-sample methods on metabolomics; edges separated patients from controls but not disease causes. | No derivation. | Evidence that edges may not add discrimination. |
| @bonobo2024 | BONOBO, a Bayesian single-sample covariance method. | Not compared with quadratic expression models. | A candidate established network method for the comparison. |
| @sweet2023 | SWEET, a sample-weighted variant to correct subpopulation size bias. | Same. | Same. |
| @pseudovalue2023microbiome | Used jackknife pseudo-values of co-abundance to adjust networks for covariates. | Not about LIONESS. | Shows the pseudo-value reading in a neighboring field. |

**Verdict:** the formula is assembled from known parts and was not found stated for LIONESS: the pseudo-value structure is visible in the LIONESS equation, and the influence function of the correlation is classical. What the idea adds beyond the closest sources is the explicit first-order form for Pearson and (corrected) partial correlation, the consequence that edges carry the square of any shared factor, and a benchmark built on that consequence. [TO CONFIRM: the verdict after reading the full texts of @kuijjer2026challenges and @yu2017iena, which this session could not open]{.tc}

Searches are logged in `log/01-idea-review.md`.

## 6. Datasets

No dataset could be opened in this stage: the network policy of the session blocked GEO, PubMed, and every publisher. Every status is `verify`.

| Dataset | Accession | What is deposited (samples by group, format, access) | Status | Opened |
|---|---|---|---|---|
| PRECISESADS | ELIXIR Luxembourg, doi 10.17881/th9v-xt85 | Whole-blood RNA-seq, methylome, flow cytometry, and clinical data on SLE, RA, and other systemic autoimmune diseases with controls, from one study [@barturen2021precisesads; @precisesads2021data]; controlled access on request. | verify | no |
| GSE45291 | GEO | Reported as a whole-blood array cohort; papers disagree on whether it holds SLE only (about 290 patients and 20 controls) or also about 490 RA patients. | verify | no |
| GSE17755 | GEO | PBMC arrays from one series: RA, SLE, two forms of juvenile arthritis, healthy children and adults, 248 patients in all; treatment information unknown. | verify | no |
| GSE93272 | GEO | Whole-blood arrays (GPL570) of RA with controls, with methotrexate, infliximab, and tocilizumab response groups [@tasaki2018multiomics]; RA only. | verify | no |

**Recommended:** PRECISESADS, with GSE45291 as the fallback if its GEO record confirms both diseases. Combining an SLE series with an RA series from another study (for example GSE93272) is ruled out for the primary analysis: disease would be identical to study, and no batch adjustment can separate them. **What the application shows:** whether, within each IFN stratum, LIONESS edges raise the cross-validated AUC for SLE against RA beyond the reference with the IFN score and its square, and beyond the matched quadratic expression model. [TO CONFIRM: the data source, and whether an access request to PRECISESADS is possible in the project's time frame]{.tc}

## 7. Pilot plan and pass criteria

**First simulation.** Two classes, 50 genes (20 loading on an IFN factor $F$, 30 not), class sizes 40, 80, and 150 per class.

| Factor | Levels | Reason |
|---|---|---|
| Mechanism | null; IFN only (classes differ in the spread of $F$); mean shift only; true network (conditional correlation of a 10-gene module differs) | One cell per route by which edges can differ, plus a null. |
| IFN spread ratio (IFN-only cells) | 1, 1.5, 2.25 | From no effect to a large one. |
| Conditional correlation change (network cells) | 0.1, 0.2, 0.4 | From a small effect to a large one. |
| Class size | 40, 80, 150 per class | The range of stratum sizes the candidate datasets suggest. |

Methods in the pilot (a subset of the 17): reference with clinical covariates and the IFN score (R0); R0 plus the square of the IFN score (R1); elastic-net logistic regression on genes; elastic net on pairwise products and squares of standardized genes (the matched quadratic model); regularized QDA; LIONESS-Pearson edges added to R0; LIONESS-Pearson edges added to R1. LIONESS edges for a test sample are computed against the training fold only, never a reference that holds the test sample. Measure: outer-fold AUC in 5-by-5 nested cross-validation [@varma2006bias], and its difference from R1, with Monte Carlo standard errors; per-sample correlation of exact and approximate edges. Known-answer cells: the null (every AUC near 0.5) and the approximation check. Replicates: 200 per cell, which gives a Monte Carlo standard error near 0.003 for an AUC difference whose replicate standard deviation is 0.04. Runtime, from operation counts and not from a run: about 12 cells by 200 replicates, under two hours on three cores; a timing run of ten replicates in stage 2 replaces this estimate.

**The three questions and the pass rule, decided before any run:**

1. Does the effect exist? Pass if, in the IFN-only cell with spread ratio 1.5 and 80 per class, LIONESS edges added to R0 raise the AUC by at least 0.05, and the gain exceeds three Monte Carlo standard errors; and if, in every normal cell, the median over edges of the per-sample correlation between exact and approximate edges is at least 0.99.
2. Is it large enough to matter at realistic sizes? Pass if the same gain is at least 0.03 at 40 per class.
3. Is there a fix or a diagnostic? Pass if (a) in the IFN-only and mean-shift cells, the gain of edges added to R1 over the matched quadratic model plus R1 lies within 0.01 of zero, or within three Monte Carlo standard errors of zero when that is wider; and (b) in the network cell with change 0.4 at 80 per class, the matched quadratic model reaches at least 90% of the AUC gain of the edges over R1.

A value within three Monte Carlo standard errors of a threshold is read as at the threshold and reported as a close call for that clause. Combination: pass if questions 1, 2, and 3 pass; close call if 1 and 3 pass and the gain of question 2 lies between 0.01 and 0.03; fail if question 1 or question 3(a) fails. A fail on question 1 turns the project into a benchmark without a critique; a fail on 3(a) means the safeguards do not remove the false signal and the design must change.

**Code and data that exist:** none in this repository. The user asked that earlier work not be relied on.

## 8. Impact and fit

LIONESS has an R implementation [@kuijjer2019lionessr] and its edges are tested between groups or fed to classifiers [CITE: a count or survey of LIONESS applications to group comparison and classification]{.cite}. In blood transcriptomes of IFN-driven diseases, many gene pairs share the IFN factor, so the artifact of section 4 can reach a large share of edges; its size at realistic class sizes is what question 2 measures. A diagnostic (the matched quadratic benchmark and the squared IFN term) is in sight, and a correction for inference (conditioning on the factor) is standard. The idea is a critique with a benchmark.

**Target journal:** BMC Bioinformatics, **fallback:** Statistical Applications in Genetics and Molecular Biology, from the journal guide's worksheet (`log/01-idea-review.md`).

## 9. Open questions for the user

- [TO CONFIRM: which partial-correlation estimator the study uses (section 4, item 2)]{.tc}
- [TO CONFIRM: the reference model includes the square of the residual IFN score and squared composition terms (section 4, item 4)]{.tc}
- [TO CONFIRM: the data source; PRECISESADS needs an access request (section 6)]{.tc}
- [TO CONFIRM: the list of seventeen models; a proposal follows, to be replaced by the user's list: (1) clinical covariates; (2) plus cell composition; (3) plus residual IFN score (R0); (4) R0 plus squared IFN and composition terms (R1); (5) elastic net on genes; (6) random forest on genes; (7) shrinkage LDA; (8) regularized QDA; (9) elastic net on pairwise products and squares; (10) LIONESS-Pearson edges; (11) LIONESS partial-correlation edges; (12) SSN; (13) iENA; (14) SWEET; (15) BONOBO; (16) WGCNA module eigengenes; (17) DGCA-selected gene pairs]{.tc}
- [TO CONFIRM: how IFN-low and IFN-high are defined (a cutoff from healthy controls, or a mixture fit), since the residual IFN score within a stratum has a truncated distribution that differs by disease]{.tc}
- [TO CONFIRM: the definition of "treated" for exclusion (any glucocorticoid, antimalarial, or DMARD at sampling), and the sample size left after exclusion]{.tc}
- [TO CONFIRM: the target journal]{.tc}

## 10. Reference list

Every source this proposal cites has an entry in `references/references.md`. None could be checked against its record in this session: the network policy blocked every publisher, PubMed, and Crossref, so each entry carries what web search results showed and `record: not opened`. The reference check (step 9 of the stage) runs once those hosts are allowed. All core citations have full text pending.

| Key | Grade | Identifier | Full text | Needed for |
|---|---|---|---|---|
| kuijjer2019lioness | core | arXiv 1505.06440; PMID 30981959 | pending | sections 3, 4, 5 |
| kuijjer2019lionessr | supporting | doi 10.1186/s12885-019-6235-7 | pending | sections 3, 5 |
| devlin1975robust | core | Biometrika 62, 531-545 | pending | section 4 |
| croux2010influence | supporting | doi 10.1007/s10260-010-0142-z | pending | section 4 |
| yu2017iena | core | doi 10.1093/nar/gkx787 | pending | section 5 |
| liu2016ssn | supporting | doi 10.1093/nar/gkw772 | pending | section 5 |
| npj2024evaluation | supporting | doi 10.1038/s41540-024-00340-w | pending | sections 4, 5 |
| kuijjer2026challenges | core | doi 10.64898/2026.02.27.708608; PMID 41867852 | pending | section 5 |
| jpr2020metabolomics | supporting | doi 10.1021/acs.jproteome.0c00696 | pending | section 5 |
| bonobo2024 | supporting | Genome Research 34(9), 1397 | pending | section 5 |
| sweet2023 | supporting | PMC10025435 | pending | section 5 |
| pseudovalue2023microbiome | supporting | arXiv 2303.13702 | pending | section 5 |
| elsherbiny2018twoscore | supporting | doi 10.1038/s41598-018-24198-1 | pending | section 3 |
| barturen2021precisesads | supporting | Arthritis Rheumatol 73(6), 1073-1085 | pending | section 6 |
| precisesads2021data | definitional | doi 10.17881/th9v-xt85 | not needed | section 6 |
| tasaki2018multiomics | supporting | PMID 30013029 | pending | section 6 |
| varma2006bias | definitional | doi 10.1186/1471-2105-7-91 | not needed | section 7 |

## 11. Revisions

[Dated entries after the stop: what the user decided, what changed.]
