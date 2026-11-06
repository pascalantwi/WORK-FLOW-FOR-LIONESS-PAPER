# Protocol: LIONESS edges, the interferon score, and SLE versus RA

| | |
|---|---|
| Proposal | `proposal.md`, revision 4 (2026-11-06) |
| Design chosen | by the user, 2026-11-06: the ten models with E1 as the base, E4 kept, 400 replicates per S2 setting (`log/01-idea-review.md`, D21; `log/03-manuscript.md`, step 3.2) |
| Pilots | `pilot/` (failed), `pilot-b/` (close call read as a pass), `pilot-c/` (passed, the design of revision 4) |
| Written | 2026-11-06, before any run it governs |
| Code | `analysis/01_simulation.R` (simulation), `analysis/02_replication.R` (public data), `R/` |

## 1. Aims

1. Equivalence: do LIONESS edges added to E1 and first-order edges added to E1 give the same out-of-sample AUC?
2. Artifact and fix: when the classes differ only in an interferon factor, how much do edges gain over a baseline without the squared IFN score ($R_0$), and does the base E1, which holds the square, remove the gain? How does the answer depend on the IFN difference, the reliability of the score, heavy tails, and the sample size?
3. Parametrization: with a true change in co-expression, how much more do edges gain than the same quadratic information entered as separate products and squares, and does the gap depend on the penalty?
4. The unequal-groups law: does the class difference in mean edge under a pure mean shift follow $(1 - 2\pi)[\Delta_i \Delta_j - \tfrac{r}{2}(\Delta_i^2 + \Delta_j^2)]$?
5. The real-data procedure: what are the level and power of the superiority test of $\Delta_1$, and how often is equivalence of $\Delta_2$ declared?

## 2. Data-generating mechanisms

**Fixed in every setting** (`SimulateCohort()`), as in the three pilots, so that the results stay comparable to them: 50 genes; genes 1 to 20 load 0.8 on an interferon factor $F$; genes 21 to 30 form a module with within-class noise correlation 0.3; genes 31 to 50 load 0.4 on a composition factor $C$, observed without error; age and sex unrelated to class. The IFN score is the mean of the first five genes (two or ten in two settings), standardized by the training fold. The gene set is genes 6 to 50 (genes 11 to 50 with the ten-gene score, so that the score and the edges share no gene). Composition observed without error and a fixed gene set are limitations, named in the paper.

**S1, the unequal-groups law** (aim 4). A mean shift of $\Delta$ pooled standard deviations on the module genes in class 1; total size 400, so that balance is not confounded with size. Nine settings: share of the smaller class $\pi \in \{0.5, 0.3, 0.15\}$ crossed with $\Delta \in \{0.25, 0.5, 1\}$. Equation (3) predicts zero at $\pi = 0.5$.

**S2, 25 settings, one factor at a time** (aims 1 to 3). $n$ is the size of class 1 (the smaller class when $\pi < 0.5$).

| Family | Factor varied | Levels | Held at | Reason |
|---|---|---|---|---|
| S2-A, artifact and fix | IFN difference in class 1 (mean shift of $F$, SD ratio) | none (0, 1); small (0.25, 1.25); moderate (0.5, 1.5); large (1, 2.25); very large (1.5, 3) | $n$ 80, $\pi$ 0.5, five score genes, normal noise | From no difference to beyond the pilots' largest; the application places PRECISESADS on this axis |
| S2-A | score genes | 2, 5, 10 | large IFN difference | The fix depends on how well the score measures $F$ |
| S2-A | noise | normal, $t_5$ | large IFN difference | Outliers enlarge the remainder of the first-order form |
| S2-A | $n$ | 40, 80, 150, 300 | large IFN difference | From a small untreated cohort to a large one |
| S2-B, equivalence, parametrization, power | module correlation change $\Delta\rho$ in class 1 | 0, 0.1, 0.2, 0.3, 0.4 | $n$ 80, $\pi$ 0.5, normal noise, mixing 0.5 | From no co-expression difference (the null of the superiority test) to a large one |
| S2-B | $n$ | 40, 80, 150, 300 | $\Delta\rho$ 0.2 | Power and equivalence by size |
| S2-B | $\pi$ | 0.5, 0.3, 0.15 | $\Delta\rho$ 0.2, $n$ 80 | Imbalance, the condition of equation (3) |
| S2-B | noise | normal, $t_5$, $t_3$ | $\Delta\rho$ 0.4 | Equivalence under heavy tails |
| S2-B | elastic-net mixing | 0 (ridge), 0.5, 1 (lasso) | $\Delta\rho$ 0.4 | The parametrization effect is a property of the penalty |

**Test settings (7)** (aim 5): the five $\Delta\rho$ settings of S2-B and the large and very large IFN settings of S2-A, each replicate running the real-data procedure of section 4.

**Known answers.** The S2 settings with no class difference (IFN difference "none", $\Delta\rho = 0$) have every AUC near 0.5; S1 has equation (3); the closed forms of the edges, the add-one form, and the partial-correlation edges are tested against literal implementations (`tests/testthat/`, `KnownAnswerChecks()`).

## 3. Estimands

For a model $M$ fitted on a sample of the setting's size, $\mathrm{AUC}(M)$ is the probability that a random class-1 sample outranks a random class-0 sample under $M$'s out-of-sample score. The contrasts, each a paired difference within a cohort:

- $\Delta_1 = \mathrm{AUC}(\text{N1}) - \mathrm{AUC}(\text{E1})$: edges beyond the IFN score, its square, composition, and the gene levels.
- $\Delta_2 = \mathrm{AUC}(\text{N1}) - \mathrm{AUC}(\text{F1})$: edges beyond their own first-order formula.
- $A = \mathrm{AUC}(\text{N1 with } R_0) - \mathrm{AUC}(R_0)$: the interferon artifact.
- $P = \mathrm{AUC}(\text{N1}) - \mathrm{AUC}(\text{E5})$: the parametrization effect.
- Beside them, $\mathrm{AUC}(\text{N2}) - \mathrm{AUC}(\text{E1})$ and $\mathrm{AUC}(\text{E4}) - \mathrm{AUC}(\text{E1})$.
- In S1, the class difference in mean LIONESS edge over the 45 module pairs, minus equation (3).

## 4. Methods

**Models** (proposal, section 7.1). $R_0$: logistic regression on age, sex, composition, and the residual IFN score (the score's residual on composition, from the training fold). $R_1$: $R_0$ with the squared residual score and squared composition. Elastic net (`glmnet::cv.glmnet`, binomial, mixing 0.5 unless varied, penalty by 5-fold inner cross-validation on deviance, `lambda.min`), with the $R_1$ terms unpenalized: E1 (the genes); E5 (the genes, their pairwise products, and squares, standardized by the training fold); F1 (the genes and the first-order edges, with the training fold's correlation and standardization); N1 (the genes and the exact LIONESS edges: leave-one-out within the training fold for training samples, the add-one form against the training fold for test samples); N2 (the genes and the LIONESS edges of the partial correlation given the IFN score and composition, computed directly). E4: regularized discriminant analysis on the genes, composition, and the residual score, $\lambda$ and $\gamma$ on the grid 0, 0.25, ..., 1 by inner 5-fold cross-validation on AUC. N1 with $R_0$: the edges with the $R_0$ terms unpenalized. B1 and B2 need batch and are fitted only in real data.

**S2 replicates.** Outer stratified 5-fold cross-validation; every derived quantity computed inside the training fold; the AUC of the pooled out-of-fold scores (`RunReplicate()`).

**Test replicates** (`TestReplicate()`), the procedure of the application: five repeats of stratified 5-fold cross-validation of E1, N1, and F1; the AUC in each of the 25 test folds; $\Delta_1$ tested by the corrected resampled $t$-test (variance $(1/25 + 1/4)\,s^2$, 24 degrees of freedom), one-sided at 5% (superiority); equivalence of $\Delta_2$ declared when the 90% interval with the same variance lies inside $\pm 0.01$ (two one-sided tests).

## 5. Performance measures

- Each model's mean AUC and the mean of each contrast, with its Monte Carlo standard error (MCSE, the replicate standard deviation over the square root of the replicates). A contrast is called nonzero only when it exceeds three MCSE.
- S1: the mean of (observed minus equation 3), with its MCSE; the bias relative to the observed difference.
- Test settings: the rejection rate of the $\Delta_1$ test (its level at $\Delta\rho = 0$ and in the IFN settings, where N1 should add nothing to E1; its power at $\Delta\rho > 0$) and the rate of declared equivalence of $\Delta_2$, each with its binomial MCSE. Power is planned to run from low to about 80% across $\Delta\rho$ (`rules.md`, section 3); the quick run checks it, and if the levels do not span that range they are moved by a dated amendment before production.

## 6. Replicates, seeds, runtime

| Part | Replicates | MCSE it gives |
|---|---|---|
| S2, each of 25 settings | 400 | about 0.002 for a contrast with replicate SD 0.04 |
| Test settings, each of 7 | 300 | about 0.013 for a rate near 0.05; about 0.023 near 0.5 |
| S1, each of 9 settings | 1,000 | well below the effects |

Seeds (`StudyDesign()`): S1 setting $c$ has $20461103 + 1000c$, S2 $20561103 + 1000c$, the test settings $20661103 + 1000c$; replicate $r$ uses the setting's seed plus $r$; no stream overlaps another's or any pilot's (`tests/testthat/test-study.R`). Settings are split into seeded blocks of replicates (10 in S2, 5 in the test settings, 250 in S1), the tasks of `parLapplyLB(chunk.size = 1)` on three PSOCK workers with the BLAS pinned.

Runtime, from one timed replicate of each kind on one core (`log/03-design-timing-rev4.rds`): 6.5 s for an S2 setting at 80 per class, 23.6 s at 300 per class, 19.1 s at a share of 0.15, 13.0 s for a test replicate; about 218 s for one replicate of all 25 S2 settings. Production: about 8.1 hours for S2 and 2.5 hours for the test settings on three cores, about 10.5 hours in all. Quick run: 20 S2 replicates, 10 test replicates, and 100 S1 replicates per setting, about 30 minutes.

## 7. The application (PRECISESADS)

As `proposal.md`, section 7.4: untreated SLE against untreated RA (all patients with treatment indicators if fewer than 40 untreated remain per disease), whole-blood RNA-seq, flow-cytometry composition, centre and batch; the ten models and N1 with $R_0$; the gene set of 50 genes chosen in each training fold; outer 5-fold cross-validation stratified by disease and batch, repeated 20 times; $\Delta_1$ and $\Delta_2$ tested as in section 4, in that order; validation on the inception cohort, or leave-centre-out. The data are under controlled access and not yet requested; the analysis is written when access is granted, under this protocol, and until then the manuscript's application chunks are guarded and carry a marker.

## 8. Replication in public data, fixed before either dataset is analysed

The simulation's findings are checked inside each of two public datasets, never pooled. Script: `analysis/02_replication.R`, from the raw files of `analysis/00_download.R`. GSE235508 (proposal section 7.5) is not downloaded; GSE326777 is added at the user's request (2026-11-06).

**GSE17755** (two-colour arrays, GPL1291, normalized log2 ratios against a pooled healthy reference; peripheral blood cells). Patients: female SLE and female RA (the record lists 22 and 93). Probes: those with a gene symbol in the platform table, observed in at least 80% of the included samples; probes of one gene averaged; missing values filled with the training fold's gene mean inside each fold. IFN score: the mean of the standardized EPSTI1, IFI44L, LY6E, OAS3, and RSAD2. Composition: not measured, so composition terms are dropped and the residual IFN score is the score itself (a limitation). Covariates: age. Submission date is not modelled, since 10 of the SLE samples form a submission batch with no RA; a sensitivity analysis keeps only the SLE submitted with the RA samples.

**GSE326777** (RNA-seq of sorted neutrophils). Patients: SLE and RA as the sample titles label them (the records list 34 and 15). Expression: log2 counts per million plus one, per sample; genes with at least one count per million in at least a quarter of the included samples. IFN score genes by Ensembl identifier (Ensembl REST records opened 2026-11-06): EPSTI1 ENSG00000133106, IFI44L ENSG00000137959, LY6E ENSG00000160932, OAS3 ENSG00000111331, RSAD2 ENSG00000134321. A single cell type, so no composition term; no age or sex in the records, so $R_0$ holds the IFN score alone. Eleven SLE titles end in "N", as do some control titles, with no meaning stated in the record; a sensitivity analysis drops them.

**In both.** Gene set: the 50 genes with the largest variance after regressing out the IFN score in the training fold, the IFN-score genes excluded (1,225 edges). Models: $R_0$, $R_1$, E1, E4, E5, F1, N1, N2 (given the IFN score), N1 with $R_0$. Outer stratified 5-fold cross-validation repeated 20 times; pooled out-of-fold AUC per repeat, averaged over repeats; $\Delta_1$ and $\Delta_2$ by the procedure of section 4 on the 100 test folds.

| Simulation finding | Check on real data | Confirmed if |
|---|---|---|
| Edges equal their first-order formula | Across all samples, for each of the 1,225 pairs, the correlation between the exact and the first-order edge; and $\Delta_2$ | median correlation above 0.99; the 90% interval of $\Delta_2$ inside $\pm 0.01$, or its point estimate inside $\pm 0.01$ when the interval is wider (reported as such) |
| Interferon enters the edges as its square | For the 10 pairs of IFN-score genes, the correlation across samples between the edge and the squared centred IFN score | positive for most pairs, median above 0.3 |
| The base with the squared score removes the artifact | $A$ beside $\Delta_1$ | $\Delta_1$ smaller than $A$ |
| Edge form against separate products | $P$ | reported only: the truth is unknown in real data |

Every number is reported with its uncertainty, whatever it shows.

## 9. What is reported whatever the outcome

Every model's AUC and every contrast of section 3 in every setting with its MCSE; the S1 table; the test settings' rates; the known-answer table; the replication tables of section 8; figures of the contrasts by setting.

## 10. Amendments before the production run

- 2026-11-06, after the quick run and the replication, before the production run (revision round 2, at the user's request: "if A and B will help go ahead"). The interferon artifact did not appear in the two public series, where the IFN score alone separates SLE from RA (AUC 0.94 and 0.84), so two analyses are added to check it where interferon differs without deciding the comparison. Both are written here before any of their data are opened.
  - **A, the overlapping-interferon subsets.** In GSE17755 and GSE326777, the SLE and RA patients whose IFN score (computed on all samples of the series) lies between the 5th and 95th percentiles of the other disease's scores, the common-support rule of section 7. Analysed as in section 8 (20 repeats of five-fold cross-validation, the same models and contrasts). Reported whatever the size of the subsets; with few patients the contrasts are expected to be imprecise.
  - **B, a semi-synthetic analysis in real blood.** GSE65391 (whole blood, paediatric SLE, Illumina GPL10558), one sample per patient (the first visit), expression as given in the series matrix, gene symbols from the platform table. Real expression with artificial labels: in each replicate every patient is assigned to class 1 with probability $\mathrm{logit}^{-1}\{\beta (t_q - \bar t)/\mathrm{sd}(t)\}$, where $t_q$ is either the patient's IFN score (scheme "level") or its square (scheme "spread"), the IFN score being the mean standardized expression of the five IFN-score genes; $\beta \in \{0, 1, 2\}$. The labels depend on interferon alone, so no class difference in co-expression exists beyond what interferon carries. Models and features as in section 8, with composition the neutrophil percentage recorded in the series: $R_0$, $R_1$, E1, F1, N1, and N1 with $R_0$; one five-fold cross-validation per replicate; 100 replicates per setting (the setting $\beta = 0$ shared by the two schemes), seed $20861103 + 1000c + r$. Measures: $A$, $\Delta_1$, $\Delta_2$, and the AUC of $R_0$, each with its MCSE. Prediction: in scheme "spread", $A > 0$ by more than three MCSE at $\beta = 2$ while $|\Delta_1|$ stays within $\max(0.01, 3$ MCSE$)$; in scheme "level", both near zero; at $\beta = 0$, every contrast near zero. GSE65391 is downloaded by `analysis/00_download.R` (series matrix, 87 MB, and the GPL10558 platform table); the raw files above 50 MB are git-ignored and fetched by the script.

## 11. Changes after production

| Date | Change | Reason |
|---|---|---|
| | | |
