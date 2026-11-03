# Decisions log: pilot

## D0. Literature pass

The literature behind the pilot is the proposal's section 5, read in full text at the reference check of stage 1 (`log/01-idea-review.md`, D18 and D19): the product-of-deviations form is published for per-sample changes in correlation (Yu et al. 2017), and the effect of differential expression and subpopulation size on LIONESS edges is documented empirically (Kuijjer, De Marzio, and Glass 2026). Nothing was read for the pilot beyond that.

## D1. Status call

STATUS_CALL

## D2. R version

**What.** R 4.6.2, not the 4.5.2 recorded in the template's `renv.lock`; the lockfile was updated by `renv::snapshot()`.
**Alternatives.** Ubuntu's R 4.3.3, older than the lockfile.
**Why.** The CRAN repository for Ubuntu 24.04 serves the current release only; every locked package installed as a binary.
**Check.** Nothing; the lockfile records the version.

## D3. Dependencies

**What.** glmnet 5.2 added for the elastic nets; regularized discriminant analysis written in base R (`RdaScore()`, `FitRda()`).
**Alternatives.** The klaR package for regularized discriminant analysis.
**Why.** One dependency earns its place (the elastic net on 1,035 features); the discriminant analysis is 40 lines with a test.
**Check.** That the shrinkage form (toward the pooled covariance, then toward the mean diagonal) is the one the paper should describe.

## D4. Gene set fixed in the pilot

**What.** The gene set is genes 6 to 50 in every fold, not the 50 most variable genes chosen in each training fold as the proposal's full design states.
**Alternatives.** Variance screening inside each fold.
**Why.** In the simulation every non-score gene is relevant by construction, and fixing the set keeps the matched quadratic model and the edges on the same genes; screening is a design choice for the real data.
**Check.** Whether stage 3 should test screening in the simulation too (the critique table of the report lists it).

## D5. One outer cross-validation per replicate

**What.** One outer 5-fold split per replicate, not the 20 repeats of the full design.
**Why.** Repeats average over splits of one fixed dataset; in a simulation the replicates already average over datasets and splits.
**Check.** Nothing.

## D6. Reference for training and test edges

**What.** Training samples' edges use the training fold as reference (leave-one-out, $N_{\text{train}}$ samples); test samples' edges add the sample to the training fold ($N_{\text{train}} + 1$).
**Alternatives.** Building every edge from the whole cohort, which lets the test fold shape the reference.
**Why.** The reference must never hold a test sample (proposal, Result 5); the scale of the two forms differs by one sample in $N$.
**Check.** That the small difference between leave-one-out and add-one scaling does not matter (it is of order $1/N$).

## D7. Replicates

**What.** 180 replicates per cell, from the timing run (`pilot/results/timing.rds`), entered in the pre-registration's section 6 and committed before the run.
**Why.** 200 replicates projected just over the one-hour box.

## D8. No data description

**What.** No `pilot/describe_data.R`: no data set was downloaded.
**Why.** PRECISESADS is under controlled access and not yet requested; the GEO candidates were ruled out at stage 1 from their records. The report's application section uses two small files of facts from the records opened (`candidate_datasets.csv`, `gse45291_processing_dates.csv`), whose processing dates are read from the date prefix of the GEO sample titles, an interpretation of the titles.
**Check.** The access request.

## What was not done

- No real data were analyzed.
- Eleven of the 17 models were not run in the pilot (it ran $R_0$, $R_1$, E1, E4, E5, and N1, the last with $R_0$ and with $R_1$): the clinical baselines B1 and B2, the random forest (E2), shrinkage linear discriminant analysis (E3), the partial-correlation edges (N2), SSN (N3), iENA (N4), SWEET (N5), BONOBO (N6), the module eigengenes (N7), and the differential-correlation pairs (N8).
- No heavy-tailed noise, no combined mechanisms, no variance screening of genes, no measurement error in composition.
