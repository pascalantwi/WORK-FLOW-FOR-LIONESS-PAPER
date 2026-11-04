# Drafting log (stage 3)

Status: the paper test holds for a critique whose claims are the equivalence of LIONESS edges and their first-order features, the shared-factor artifact and its fix, and the effect of parametrization; the application to PRECISESADS waits on data access, and the run will not cover real data until then.

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
