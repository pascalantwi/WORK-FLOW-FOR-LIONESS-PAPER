# Drafting log (stage 3)

Status (revision 4, 2026-11-06): the paper test holds for a critique whose claims are the equivalence of LIONESS edges and their first-order features on a base with the gene levels (E1), the shared-factor artifact and its fix, and the effect of parametrization; the clinical answer (SLE against RA) waits on PRECISESADS access, and the run covers real data only through two small public datasets, GSE17755 and GSE326777.

Started 2026-11-04, after the user read the re-pilot's close call as a pass.

## Paper test

| Question | Answer | Where |
|---|---|---|
| 1. A procedure in wide use | LIONESS with Pearson correlation (the lionessR default), edges compared between groups or used as classifier features | `proposal.md`, sections 3 and 5 |
| 2. A setting it was not built for | Whole blood in SLE and RA: a shared IFN factor and composition move many genes; classes unbalanced; heavy-tailed expression | `proposal.md`, section 3; `pilot-b/` cells 2 to 5, 10, 11 |
| 3. The estimand, as a functional | The correlation of genes $i$ and $j$ in the sample's own subpopulation, $\rho_{ij}(P_q)$; for classification, the out-of-sample AUC gain of edges over a reference, and its difference from the gain of the first-order features | `proposal.md`, sections 2 and 12.3 |
| 4. The target and the bias term | Exact closed form (1); first-order form $r + z_i z_j - \tfrac{r}{2}(z_i^2 + z_j^2)$ with remainder $O_p\!\left(N^{-1}\right)$; group means by equation (3) and the $(1 - 2\pi)$ law; the squared-factor term | `proposal.md`, section 4; `R/lioness.R`; tests |
| 5. The simulation that confirms it | Two pilots: exact forms to $10^{-13}$; equivalence of exact and first-order edges within 0.0054 in AUC in 12 cells; artifact 0.02 at a large IFN difference | `pilot/results/`, `pilot-b/results/` |
| 6. A correction or a diagnostic | The squared shared factor in the reference (removes the artifact); the first-order edges as the matched comparator and as a replacement for the network | `pilot-b/results/verdict.rds` |
| 7. The application | PRECISESADS, untreated SLE against untreated RA; access not yet requested | `proposal.md`, section 6; `project-spec.md`, section 5 |

## Step 1: promote the pilot

- The re-pilot's functions were already in `R/` with tests; nothing to port. `analysis/01_simulation.R` carries the re-pilot's design (`PilotBDesign()`) in a parameter block until `protocol.md`; it writes per-replicate output, summaries, known answers, the design, `results/run_info.rds`, and `sessionInfo()`.
- Per-replicate output is about 100 KB per run, far below 50 MB; nothing is git-ignored.
- No `analysis/00_download.R`: PRECISESADS is under controlled access and cannot be fetched by a script; the README says so, with a marker for the access request.
- Known-answer and code-identity checks are tests (`tests/testthat/test-lioness.R`): the exact and add-one forms against literal LIONESS, the first-order forms at large $N$, the AUC on known cases. Coverage for the production design: every code path of `RunReplicate()` the re-pilot used (normal and $t_5$ noise, five-gene and two-gene scores, the seven models) is exercised by the acceptance test.
- Assumptions found in the pilots' code and decisions: the gene set is fixed (genes 6 to 50), not screened in each fold (`pilot/decisions.md`, D4); one outer split per replicate (D5); training edges leave one out of the training fold, test edges add one to it (D6); the null-cell AUC sits slightly below 0.5 for every model (`pilot-b/decisions.md`, D6).
- Plot code became `PlotGains()` in `R/figures.R`, with a test.
- Acceptance test (`tests/testthat/test-acceptance.R`, gated by `LIONESSIFN_ACCEPTANCE`): with `quick`, replicates 1 to 3 of all 12 re-pilot cells through the package functions; the seven models' AUCs equal the saved ones to 1e-10 (passed, 2 minutes 20 seconds, single core). The `full` mode (all 200 replicates and every per-cell summary) would take over two hours on one core and was not run; the quick mode shows identity at the replicate level, which is stricter than the per-cell comparison.
- No Python: the methods are all in R.

## Step 2: references

Inventory (key, grade, section, why, origin): every source of the proposal's section 10 and `manuscript/citations.csv` as stage 1 left it (21 entries, all records opened at the stage 1 reference check), the seeds morris2019 and marwick2018, and three added now for the methods: friedman2010glmnet (definitional, Methods, glmnet), schuirmann1987tost (definitional, Methods, the two one-sided tests of the equivalence contrast), langfelder2008wgcna (definitional, Methods, module eigengenes; it replaces a `[CITE]` marker in the proposal's model table). Records of the three opened in Crossref on 2026-11-04.

Lists: (1) available: 26 entries, every record opened; (2) core citations with full text pending: devlin1975robust (the PDF closes it); (3) records not opened: none. Build: `build-bib.py` with `--check`, one fault left (the Devlin full text). No stop.

## Equations (2026-11-04, at the user's request)

The user asked that the equations be typed and aligned properly. Every inline and display formula in the proposal, the spec, the pilots' decisions, reports, and logs (585 in all) was parsed with KaTeX 0.16.11 in strict mode: no errors. Typesetting changes:

- Display equations with more than one relation are `aligned` blocks with the alignment point at the relation sign (`&=`, `&\approx`), one relation per line, extra space between lines (`\\[4pt]` to `\\[8pt]`), and a comma or full stop at the end of each line. Equations (1) and (2) of the proposal had two relations on one line; equation (3) is broken before its second term; the mean-shift law is numbered (4); Result 5 became display equation (5).
- Expectation is the upright $\mathrm{E}$; remainders are written $O_p\!\left(N^{-1}\right)$; fractions inline are `\tfrac{r}{2}`, never `\tfrac r2`; parentheses around square-root factors are sized with `\left(` and `\right)`.
- The pre-registrations were not changed: they stay as committed before their runs.
- The rendered proposal (pandoc with KaTeX) and both pilot reports were inspected by eye.

These are the conventions for `manuscript.qmd`, where numbered displays take Quarto labels (`{#eq-name}`) so that the text refers to them as @eq-name.

## Step 3.1: purpose draft of the Introduction

Written in `manuscript/manuscript.qmd`, three paragraphs, from the proposal's sections 5 and 12, every sentence with a source opened at stage 1 or a marker; the lionessR osteosarcoma example was checked against the full text (53 biopsies; edges compared with limma between short and long metastasis-free survival, "to understand co-regulation differences between the groups"). One claim was narrowed while writing: the interferon program's degree differs "between the diseases", which El-Sherbiny et al. state; "and within" was dropped, since the passage read does not say it.

Claims, as questions (the aims of `proposal.md`, section 12.6):

1. Do the exact edges and their first-order features give the same out-of-sample classification?
2. When classes differ in a shared factor, how much do edges gain from its square, and does a reference holding the square remove the gain?
3. Why does the edge form detect a co-expression difference that the same products and squares, entered separately, do not?

## Step 3.2: design proposal (stop)

Timing (`log/03-design-timing.rds`, one replicate per model in a network cell, single core, labelled a timing run): all seven models together took 3.8 seconds at 80 per class and 11.2 seconds at 300 per class; the costliest single models at 300 per class were E5 (3.6 s), F1 (2.8 s), and the edges (2.8 s).

| Study and family | Factor | Levels | Held at | Reason | Question |
|---|---|---|---|---|---|
| S1: the mean-shift law | Share of the smaller class $\pi$ | 0.5, 0.3, 0.15 | | Equation (4) predicts zero at 0.5, growing with imbalance | Theory check |
| S1 | Mean shift $\Delta$ (pooled SD) | 0.25, 0.5, 1 | | From a small shift to a large one | Theory check |
| S2-A: artifact and fix | IFN difference (shift, SD ratio) | none (0, 1); small (0.25, 1.25); moderate (0.5, 1.5); large (1, 2.25); very large (1.5, 3) | $n$ 80, $\pi$ 0.5, five score genes, normal noise | From no difference to beyond the pilots' largest; PRECISESADS is placed on it by estimating the SLE-RA difference of the score | 2 |
| S2-A | Score genes | 2, 5, 10 | large IFN difference | The fix depends on how well the score measures the factor | 2 |
| S2-A | Noise | normal, $t_5$ | large IFN difference | Outlying samples enlarge the remainder of the first-order form | 2 |
| S2-A | Size of the smaller class $n$ | 40, 80, 150, 300 | large IFN difference | From a small untreated cohort to a large one | 2 |
| S2-B: equivalence, parametrization, power | Module correlation change $\Delta\rho$ | 0, 0.1, 0.2, 0.3, 0.4 | $n$ 80, $\pi$ 0.5, normal noise, $\alpha$ 0.5 | From no co-expression difference (the null of the superiority test) to a large one; the pilots gave gains of 0.002 at 0.1, 0.011 at 0.2, and 0.118 at 0.4, so 0.3 is added to fill the power curve | 1, 3 |
| S2-B | $n$ | 40, 80, 150, 300 | $\Delta\rho$ 0.2 | Power and equivalence by size | 1, 3 |
| S2-B | $\pi$ | 0.5, 0.3, 0.15 | $\Delta\rho$ 0.2, smaller class 80 | Imbalance, the condition of equation (4) | 1 |
| S2-B | Noise | normal, $t_5$, $t_3$ | $\Delta\rho$ 0.4 | Equivalence under heavy tails, where the remainder is largest | 1 |
| S2-B | Elastic-net mixing $\alpha$ | 0 (ridge), 0.5, 1 (lasso) | $\Delta\rho$ 0.4 | The parametrization effect is a property of the penalty, so it may change with it | 3 |
| Fixed | Genes 50 (20 on the IFN factor, a 10-gene module, 20 on composition); composition one factor observed without error; gene set fixed at the 45 non-score genes | | | As in the pilots, so that the results stay comparable to them; composition error and gene screening are named limitations | |

Twenty-five cells in S2 (one-at-a-time around the base cells, not a full factorial) and nine in S1.

**Methods (S2).** $R_0$, $R_1$, E1, E5, F1 with $R_1$, edges with $R_0$ and with $R_1$, as in the re-pilot; and, each with $R_1$, the four other single-sample methods of the proposal: SSN (N3), iENA's single-sample PCC (N4), SWEET (N5), and BONOBO (N6). The user chose on 2026-11-04 to include SWEET and BONOBO in the simulation, not only in the application (D-S4 below).

**Performance measures.** Out-of-fold AUC and the paired differences against $R_1$ (and against $R_0$ in S2-A), with Monte Carlo standard errors; the difference of edges and F1 (equivalence); F1 against E5 (parametrization). In S1, the bias of the class difference in mean edge against equation (4). Power, planned as `rules.md` section 3 requires: in the five $\Delta\rho$ cells of S2-B and in the large and very large IFN cells with $R_1$, each replicate runs the application's procedure (five repeats of 5-fold cross-validation, the corrected resampled t-test of $\Delta_1$ at the 5% level, and the two one-sided tests of $\Delta_2$ with margin 0.01), giving the rejection rate of $\Delta_1$ (level in the cells with no co-expression difference, power across $\Delta\rho$) and the rate at which equivalence of $\Delta_2$ is declared. The $\Delta\rho$ levels are checked with a few low-replicate cells in the quick run, and moved if the power does not run from low to about 80%.

**Replicates and runtime.** 500 replicates per S2 cell, which gives a Monte Carlo standard error near 0.002 for a difference with replicate standard deviation 0.04; 300 replicates in the seven test cells, a standard error of 0.013 for a rejection rate near 0.05; 1,000 per S1 cell. Projected from the timing with all eleven models (about 7.6 seconds per replicate at 80 per class and 27 seconds at 300, single core): about 12 hours for S2, 2 hours for the test cells, and seconds for S1, on three cores, so about 14 hours in all; at 400 replicates per S2 cell (standard error near 0.002 still), about 11.5 hours. A quick run at 40 and 30 replicates takes about 1.2 hours.

**Application plan.** PRECISESADS, untreated SLE against untreated RA, whole blood, flow-cytometry composition, recruitment centre and sequencing batch as covariates; the 18 models of `proposal.md` (sections 7 and 12.3) in repeated nested cross-validation; the primary contrasts $\Delta_1$ (superiority, corrected resampled t-test) and $\Delta_2$ (equivalence, two one-sided tests, margin 0.01), in fixed sequence; and the placement of the data on the two gradients (the SLE-RA difference of the IFN score in shift and SD ratio, and the largest co-expression differences of the IFN and composition modules). The test the application uses is the simulation's. Until access is granted the application chunk is guarded and carries a marker.

### Revision of the design proposal (2026-11-04)

- D-S4. The user chose SWEET and BONOBO in the simulation too ("stimulation too"). Correction to the earlier proposal: both have closed forms. SWEET's edge (Chen et al. 2023, equations 1 and 2) is $W_p\, n K \left(r_{(+p)} - r\right) + r$, where $r_{(+p)}$ is the correlation after adding a copy of sample $p$ to the reference, so it is the add-one update of equation (5) rescaled by a sample weight $W_p$ (from the sample-to-sample correlations) and $K = 0.1$. BONOBO's edge (Saha et al. 2024, equation 4) is the correlation of $\Sigma_i = \delta_i\, d_i d_i^\top + (1 - \delta_i) S_i$, a ratio, not a polynomial, in the sample's expression; it tests where the equivalence of section 12 stops.
- D-S5. BONOBO's weight $\delta_i$: equation 8 of the paper is $1/\left[3 + 2 \sum_k s_{kk}^2 / \sum_k \eta(k)\right]$ with $\eta(k)$ the variance of the leave-one-out variances of gene $k$; the authors' implementation (`compute_bonobo()` in netZooPy 0.11.0, installed from PyPI, read in full) computes $1/\left[3 + 2\, \overline{\sqrt{s_{kk}}} / \operatorname{var}_k(s_{kk})\right]$, the mean standard deviation over the variance of the gene variances. The two differ. The implementation, which users run, is followed (`BonoboDelta()`), and the paper will say so. The R functions were checked against netZooPy on a fixture (30 samples, 6 genes, one outlying sample): every edge and every $\delta_i$ agree to $10^{-8}$ (`tests/testthat/test-networks.R`; the reference values in `tests/testthat/fixtures/bonobo_netzoopy.csv` were written by netZooPy's own function in double precision).
- New functions in `R/networks.R` (SSN, iENA, SWEET, BONOBO, each with a test-sample form that uses the training fold only), tested against literal implementations of each definition (SWEET with an explicitly duplicated sample); models N3R1 to N6R1 in `RunReplicate()`. 62 tests pass; the re-pilot still reproduces.
- Timing of the four (`log/03-design-timing.rds`): 0.8 to 1.2 seconds per replicate at 80 per class and 3.8 to 4.1 at 300.


# Revision 4 (2026-11-06): stage 3 restarted after the third pilot

The user accepted the third pilot's pass (`pilot-c/`) and asked for stage 3 ("do 1 and 3 and stage 3"). Everything above this heading belongs to the design of revision 3 and stands as the record.

## Paper test (revision 4)

| Question | Answer | Where |
|---|---|---|
| 1. A procedure in wide use | LIONESS with Pearson correlation (the lionessR default), edges compared between groups or used as classifier features | `proposal.md`, sections 1 and 5 |
| 2. A setting it was not built for | Whole blood in SLE and RA: a shared IFN factor and composition move many genes; unbalanced classes; heavy tails | `proposal.md`, section 2; `protocol.md`, section 2 |
| 3. The estimand, as a functional | The correlation of genes $i$ and $j$ in the sample's own subpopulation; for classification, the out-of-sample AUC gain of edges over E1, and its difference from the gain of the first-order features | `protocol.md`, section 3 |
| 4. The target and the bias term | The exact closed form; the first-order form with remainder $O_p(N^{-1})$; equation (3) and the $(1 - 2\pi)$ law; the squared-factor term | `proposal.md`, section 4; `R/lioness.R`, `R/partial.R`; tests |
| 5. The simulation that confirms it | Three pilots; the third, on the E1 base: N1 against F1 within 0.0038 in nine cells, N1 over E1 0.109 with a co-expression change, N1 and N2 against E1 within 0.0014 when only interferon differs | `pilot-c/results/` |
| 6. A correction or a diagnostic | The squared IFN score in the base (E1 holds it); the first-order edges as the matched competitor and as a replacement for the network | `pilot-c/results/verdict.rds` |
| 7. The application | PRECISESADS, untreated SLE against untreated RA, access not yet requested; public replication in GSE17755 and GSE326777 | `protocol.md`, sections 7 and 8 |

## Step 1 (revision 4): the study promoted

- `analysis/01_simulation.R` now runs the full design of `protocol.md` (`StudyDesign()`): S1 (`S1Replicate()`), S2 (`RunReplicate()` with the nine simulated models), and the test settings (`TestReplicate()`), in seeded blocks of replicates on three workers.
- New code paths, each with a test (`tests/testthat/test-study.R`): IFN differences "none", "small", and "very large"; $t_3$ noise; the elastic-net mixing as a design column; the ten-gene score with the gene set 11 to 50; the S1 replicate against equation (3); the test replicate's two decisions; seeds that overlap no pilot's. The first two pilots' draws are unchanged (the existing tests, and the quick acceptance test against `pilot-b/`, pass).
- `analysis/00_download.R` fetches GSE17755 and GSE326777 (`log/02-pilot.md`, D-S5).
- Acceptance: the third pilot's functions are the study's; the quick acceptance test reproduces the second pilot's replicates exactly.

## Step 3.2 (revision 4): the design, chosen by the user

The design of `protocol.md` is the one the user chose on 2026-11-06 while refining the proposal: the models of revision 4 with E1 as the base, E4 kept, E2, E3, and N3 to N8 dropped, and 400 replicates per S2 setting ("ADD E_4, I WANT LESSER REPLICATE", choosing 400 over 500; `log/01-idea-review.md`, D21), with S1, S2, and the test settings as proposed at the first design stop (step 3.2 above) minus the dropped models. The user then asked for stage 3 to proceed ("do ... stage 3").

### Decisions made in place of the design stop

- D-S6. The design stop is taken as answered by those choices, since the user chose every element that changed and asked to go on; `protocol.md` records the design and can be amended before production. What the user should check: the runtime, about 10.5 hours for production (`protocol.md`, section 6), longer than the 6 to 7 hours estimated on 2026-11-06 before N2 was timed at large sizes.
- D-S7. Replication data: GSE17755 and GSE326777, as the user approved; GSE235508 is not downloaded. The checks and their criteria are fixed in `protocol.md`, section 8, before either dataset is opened beyond its first lines.
- D-S8. GSE17755 has no composition data; composition terms are dropped there rather than estimated from the genes (the proposal's plan), since no signature matrix is in the reference list. GSE326777 is a single cell type and needs none.

## Step 3.3 (revision 4): quick run

- `Rscript analysis/01_simulation.R --run quick --reps 20 --reps-test 10 --reps-s1 100`: S2 25 settings by 20 replicates, the test settings 7 by 10, S1 9 by 100, in 1,561 seconds on three workers (`results/run_info.rds`, `run = "quick"`; `results/quick_run.log`).
- Power check of `protocol.md`, section 5: the rejection rate of the $\Delta_1$ test ran from 0.0 at $\Delta\rho$ of 0 to 0.1, 0.5, and 1.0 at 0.2, 0.3, and 0.4 (10 replicates each), so the levels span low power to above 80%; no amendment.
- Finding for the design: equivalence of $\Delta_2$ within $\pm 0.01$ was declared in 0 to 20% of test replicates, although the mean $\Delta_2$ was within 0.007 of zero; at 80 per class the corrected interval of a fold-based AUC difference is wider than the margin. Reported in the Results and the Discussion; the user should judge whether the full study adds test settings at larger sizes (a design change, which would be an amendment before production).
- `analysis/02_replication.R` (`protocol.md`, section 8). Reading GSE17755 needs the platform table GPL1291 (probe to symbol), fetched by `analysis/00_download.R` from the GEO record; some symbols in that table are numbers (spreadsheet date conversions of gene names), which are dropped with the rest of the probes whose symbols match no expression column. All five IFN-score genes are present in both series.

### Decisions while building the replication

- D-S9. `FitElasticNet()` falls back to `ElasticNetFallback()` when `cv.glmnet` or its prediction fails, which happened only in the GSE17755 sensitivity subset (12 SLE): with few cases in an inner fold, glmnet's path stopped after one penalty value and `cv.glmnet` could not align the folds. The fallback uses the full fit's penalty sequence, stratified inner folds, coefficients read through `coef()`, the last available fit carried forward, and an intercept-only model for a fold with no path. A fit that `cv.glmnet` completes is unchanged: the quick acceptance test still reproduces the second pilot exactly, and all 101 tests pass.
- D-S10. In GSE17755 the gene levels separate the diseases almost perfectly (E1 AUC near 1 in a single repeat, also within the submission batch shared with RA), which suggests that disease and processing are confounded in that series and leaves no room for any model to gain. The Application states it with a marker; the mechanism checks (formula and IFN square) do not depend on classification and stand.

## Step 3.4 and the revision pass (revision 4)

Drafted on the quick-run numbers and the replication results: Methods (carried from `proposal.md`, sections 4 and 7, rewritten as prose with numbered equations @eq-lioness to @eq-contrasts), the design (from `protocol.md`, with the design table computed from `results/design.rds`), Results (new, every number through `prov()` from `results/`), Application (new, from `results/replication_*.rds`), Discussion (new; the novelty table from the proposal's section 5), the Introduction's last paragraph revised against the Results, then the Abstract. The supplementary note derives S1.1 to S1.5 and holds Table S1. The AI-use statement moved into the Methods, as the journal's profile requires; the citation style is `biomed-central.csl`.

Revision pass 1 (paragraphs): each Results subsection's first sentence now states its answer ("Edges gained from interferon alone, and the gain grew with the interferon difference"; "Edges found a true change in co-expression that the gene levels cannot show"; "The superiority test kept its level and gained power with the effect, but the equivalence test seldom reached a decision"); the first subsection's opening was recast from "reached the same AUC within" to "differed in AUC by". Pass 2 (sentences): modal and evaluative words removed where the checker flagged them ("can gain" to "gains", "may differ" to "differs", "could not be declared" to "was not declared", "rarely" replaced by the rate); "very large" kept only as the name of a design level. Fewer than four sentences changed in any section, so no second pass is due.

Checker (`check-manuscript.py`, journal bmc-bioinformatics): no errors. Warnings kept, with reasons: digits typed outside Results are design constants (loadings 0.8, correlations 0.3 and 0.4, the total of 400 in S1, the margin 0.01, the 90% interval), which also live in `results/design.rds` and `protocol.md`; bib entries not cited belong to the proposal and the reference list, not to this draft; "very" is the rendered design level "very large" in the design table; the percentage in the Methods is the 90% interval of the equivalence test, a design choice. Two errors found on the way and fixed: `morris2019` and `marwick2018` had no checklist rows and records never opened (both opened in Crossref on 2026-11-06); and reading the replication's run file through `read_run_info()` had relabelled every quick-run number as production, which would have hidden the quick label; the replication's numbers now carry their own run label.

Lists for the stop message: core citations with full text pending, devlin1975robust; records not opened, none; one claim without a source, the jackknife pseudo-value and its first-order agreement with the influence function (supplement S1.2).

## Time (revision 4)

| Step | Time |
|---|---|
| Promote the study (design functions, test replicate, tests) | 40 min |
| Protocol, with the timing of the costliest settings | 25 min |
| Quick run | 26 min (in the background) |
| Replication code and runs, including the glmnet fallback | 60 min |
| Draft, checker, revision pass | 75 min |
| Prove the clone | about 40 min (in the background) |

## Process feedback (revision 4)

1. The design stop was answered by the user's earlier choices rather than at a stop; the stage file could say how a design chosen during a proposal revision carries into step 3.2.
2. `read_run_info()` both reads a run file and sets the paper's run label; reading a second script's run file through it silently relabelled every number. A helper that reads without setting the label, or a guard against a second call, would prevent it.
3. `cv.glmnet` fails, rather than warns, when an inner fold's path stops after one penalty value; real data with few cases in a class reach that case, simulated data did not. A fallback in the package function is the robust place for it, with the default path untouched so that earlier runs reproduce.
4. The checker counts digits in captions written in the YAML option; building captions in the setup chunk from the start would save a round.
