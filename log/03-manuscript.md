# Drafting log (stage 3)

Status: the paper test holds for a critique whose claims are the equivalence of LIONESS edges and their first-order features, the shared-factor artifact and its fix, and the effect of parametrization; the application to PRECISESADS waits on data access, and the run will not cover real data until then.

Started 2026-11-04, after the user read the re-pilot's close call as a pass.

## Paper test

| Question | Answer | Where |
|---|---|---|
| 1. A procedure in wide use | LIONESS with Pearson correlation (the lionessR default), edges compared between groups or used as classifier features | `proposal.md`, sections 3 and 5 |
| 2. A setting it was not built for | Whole blood in SLE and RA: a shared IFN factor and composition move many genes; classes unbalanced; heavy-tailed expression | `proposal.md`, section 3; `pilot-b/` cells 2 to 5, 10, 11 |
| 3. The estimand, as a functional | The correlation of genes $i$ and $j$ in the sample's own subpopulation, $\rho_{ij}(P_q)$; for classification, the out-of-sample AUC gain of edges over a reference, and its difference from the gain of the first-order features | `proposal.md`, sections 2 and 12.3 |
| 4. The target and the bias term | Exact closed form (1); first-order form $r + z_i z_j - \tfrac r2(z_i^2 + z_j^2)$ with remainder $O_p(1/N)$; group means by equation (3) and the $(1 - 2\pi)$ law; the squared-factor term | `proposal.md`, section 4; `R/lioness.R`; tests |
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
