# Log, stage 1: idea review

Workflow 0.2.4-md. Started 2026-11-03.

First message to the user (step 1.4), sent before any search: the question as read is whether, within IFN-low and within IFN-high patients, LIONESS edges (Pearson or partial correlation) improve the classification of SLE against RA over a reference model that already holds the residual IFN score, clinical covariates, and cell composition, or add nothing beyond quadratic expression models. Paper type as read: a critique with a large benchmark. The other reading, a benchmark judged on classification alone, was named; the critique was picked because the first-order formula is what decides the comparators.

## 1. Inventory of `idea.md`

| Element | What `idea.md` says | Stated, implied, or absent |
|---|---|---|
| Question | Whether and when LIONESS adds information beyond the IFN score, clinical and cell-composition baselines, expression classifiers, and network methods | stated |
| Procedure | LIONESS with Pearson and partial correlation | stated |
| Setting | SLE against RA within IFN-low and within IFN-high strata, blood expression | stated (the tissue implied) |
| Mechanism | The first-order edge: product of standardized deviations plus a term in the reference correlation | stated, without derivation |
| Estimand | Not named | absent |
| Claimed theory | The first-order approximation for Pearson and partial correlation | stated |
| Aims | Approximation; seventeen-model nested cross-validation with a reference holding the residual IFN score; application with four safeguards | stated; the seventeen models are not listed |
| Literature | LIONESS (Kuijjer and colleagues, 2019) | stated |
| User's prior work | An osteosarcoma LIONESS pipeline in another repository | stated; the user asked mid-stage that earlier work not be relied on, so it is not used (D2) |
| Datasets | none named | absent |
| Journal | none | absent |
| Constraints | References kept in Markdown, no Zotero | stated |

Setup: `DESCRIPTION` still names `projecttemplate`, so `tools/init.R` has not been run; the first message proposed `Rscript tools/init.R lionessifn --title "LIONESS in IFN-Stratified SLE and RA"`. R is not installed in this session.

## 2. Paper test

| Question | Answer | What is missing |
|---|---|---|
| 1. Procedure in wide use | LIONESS, Pearson default in lionessR; edges compared with limma or used as features | the default confirmed only through search results |
| 2. Setting not built for | Whole blood in SLE and RA: one latent IFN factor and cell composition move many genes; IFN level, treatment, and batch differ | a confirmed dataset |
| 3. Estimand as a functional | $\rho_{ij}(P_q)$, the correlation in the subpopulation the sample comes from; for groups, $\rho_{ij}(P_1) - \rho_{ij}(P_0)$ | evidence of how users read edges |
| 4. Target and bias term | $\rho_{ij}(P) + \mathrm{IF}_P(x_q)$; the group mean differs from $\rho_{ij}(P_g)$ by mean-shift and variance-ratio terms (mixture algebra applied to $E_g[z_i z_j]$ and $E_g[z^2]$) | remainder bound; regularized partial correlation |
| 5. Simulation | Pilot of the proposal, section 7 | to run |
| 6. Fix or diagnostic | Matched quadratic benchmark and the squared IFN term; conditioning on $F$ | pilot |
| 7. Application | IFN-stratified SLE against RA, untreated, one study | dataset |

## 3. Searches

Session constraint, found at the first fetch: the network policy denied every host the shell or the fetch tool tried (api.crossref.org, eutils.ncbi.nlm.nih.gov, www.ncbi.nlm.nih.gov, pmc.ncbi.nlm.nih.gov, ftp.ncbi.nlm.nih.gov, www.ebi.ac.uk, arxiv.org, www.biorxiv.org, doi.org, www.nature.com, bmcbiol.biomedcentral.com, www.cell.com, bioconductor.org, api.openalex.org, api.semanticscholar.org). Only the web search tool worked. Every source below was therefore read from search-result summaries, a partial reading: no abstract and no full text was opened. The user was told which setting to change.

| # | Date | Source | Query | What it gave | Time |
|---|---|---|---|---|---|
| 1 | 2026-11-03 | web search (extended) | LIONESS single-sample network edge jackknife pseudo-value influence function correlation | LIONESS papers, lionessR, the 2024 npj evaluation, a microbiome pseudo-value paper; no source linking LIONESS to the influence function | 1 min |
| 2 | 2026-11-03 | web search (extended) | single-sample networks LIONESS critique benchmark evaluation classification | 2024 npj evaluation (SSN and LIONESS edges near-linear), J Proteome Res metabolomics evaluation | 1 min |
| 3 | 2026-11-03 | web search | interferon signature IFN score whole blood SLE RA IFN-high IFN-low | El-Sherbiny 2018 two-score system; RA IFN studies | 1 min |
| 4 | 2026-11-03 | web search (extended) | LIONESS Pearson edge weight equivalent product of z-scores | no source stating the equivalence | 1 min |
| 5 | 2026-11-03 | fetch | PMC13001488 | blocked | |
| 6-8 | 2026-11-03 | fetch | arXiv 1505.06440, nature.com npj article, BMC Biology review | blocked | |
| 9 | 2026-11-03 | web search (extended) | iENA individual-specific edge network sPCC | Yu 2017 NAR, doi 10.1093/nar/gkx787; formula in its supplement, not seen | 1 min |
| 10 | 2026-11-03 | web search | Liu 2016 NAR sample-specific networks | doi 10.1093/nar/gkw772 | 1 min |
| 11 | 2026-11-03 | web search | influence function of Pearson correlation, Devlin 1975 | the form $xy - \rho(x^2+y^2)/2$, attributed to Devlin, Gnanadesikan, and Kettenring (1975), restated by Croux and Dehon (2010) | 1 min |
| 12 | 2026-11-03 | web search (extended) | BONOBO, SWEET | Genome Research 34(9) 1397; SWEET PMC10025435; a 2026 critique by Kuijjer and colleagues | 1 min |
| 13 | 2026-11-03 | web search (extended) | "Challenges and Opportunities in Single-Sample Network Modeling" | PMID 41867852, bioRxiv 2026; accuracy-specificity trade-off; no derivation seen | 1 min |
| 14 | 2026-11-03 | web search (extended) | LIONESS edges dominated by expression deviation | nothing direct | 1 min |
| 15 | 2026-11-03 | web search | jackknife pseudo-values and influence function | pseudo-value equals estimate plus influence function, asymptotically (arXiv 2606.24024, 2411.17533; Lifetime Data Anal 2023) | 1 min |
| 16 | 2026-11-03 | web search (extended) | GSE45291 | conflicting descriptions: SLE only, or SLE and RA | 1 min |
| 17 | 2026-11-03 | web search | GSE93272 | RA and controls, GPL570, drug-response groups, PMID 30013029 | 1 min |
| 18 | 2026-11-03 | web search (extended) | one GEO study with both SLE and RA whole blood, untreated | none confirmed | 1 min |
| 19 | 2026-11-03 | web search | GSE17755 | PBMC, RA, SLE, JIA, healthy, 248 patients | 1 min |
| 20 | 2026-11-03 | web search (extended) | PRECISESADS whole blood multi-disease | PRECISESADS SLE analyses; no GEO accession | 1 min |
| 21 | 2026-11-03 | web search (extended) | Barturen 2021 PRECISESADS data availability | ELIXIR Luxembourg, controlled access, doi 10.17881/th9v-xt85 | 1 min |
| 22 | 2026-11-03 | web search | nested CV Varma Simon; Nadeau Bengio corrected t-test | doi 10.1186/1471-2105-7-91; correctR implements the corrected test | 1 min |
| 23 | 2026-11-03 | web search | DGCA; WGCNA | DGCA doi 10.1186/s12918-016-0349-1 (archived on CRAN 2024-05-04); WGCNA not returned | 1 min |
| 24 | 2026-11-03 | web search | whole-blood deconvolution, CIBERSORT, ABIS | CIBERSORT validated on whole blood (PMC4739640); Monaco 2019 not returned | 1 min |
| 25 | 2026-11-03 | web search (extended) | SLE against RA blood transcriptome classifier | no validated IFN-independent SLE-vs-RA classifier found; lupus arthritis vs RA study (small RA arm) | 1 min |

Budget: 21 search queries against about 20, plus four blocked fetches; the overrun went to the dataset question, where every query was needed to rule out a single-study public source. Stop rule: queries 23 to 25 added no source the proposal's argument rests on. No full text was read (budget of ten unused, all blocked).

## 4. Theory check

D5. Pearson. Exact LIONESS edges ($e_q = N r - (N-1) r_{(-q)}$) against $r + z_i z_j - \tfrac{r}{2}(z_i^2 + z_j^2)$, $z$ standardized with divisor $N$. Script: `log/01-idea-review-theory-check.py`, numpy 2.3.4 in a scratch environment outside the project, seed 20261103, run 2026-11-03. Output:

```
PEARSON  dist   rho   N   cor(exact,approx)  max|exact-approx|  sd(exact)  cor(exact, zx*zy)
  normal  0.0   20   0.99958              0.4678          1.234     0.9980
  normal  0.0   50   0.99975              0.2736          0.942     0.9877
  normal  0.0  100   0.99925              0.7475          1.111     0.9880
  normal  0.0  500   1.00000              0.0561          1.005     0.9991
  normal  0.5   20   0.99872              0.2202          0.660     0.8734
  normal  0.5   50   0.99970              0.2171          0.768     0.8569
  normal  0.5  100   0.99987              0.2785          0.854     0.8428
  normal  0.5  500   0.99999              0.0855          0.729     0.8836
  normal  0.9   20   0.99744              0.1142          0.311     0.6636
  normal  0.9   50   0.99888              0.0616          0.143     0.8149
  normal  0.9  100   0.99969              0.0270          0.169     0.7141
  normal  0.9  500   0.99999              0.0123          0.190     0.7529
  t3      0.0   20   0.99821              0.5009          1.015     0.9984
  t3      0.0   50   0.99736              1.0428          1.116     0.8885
  t3      0.0  100   0.99551              6.1725          2.584     0.9906
  t3      0.0  500   0.99977              0.8847          1.434     0.9262
  t3      0.5   20   0.99525              0.2695          0.437     0.8376
  t3      0.5   50   0.99886              0.4650          1.068     0.9544
  t3      0.5  100   0.99749              2.6321          1.492     0.5988
  t3      0.5  500   0.97935              3.5648          0.780     0.2181
  t3      0.9   20   0.99312              0.2084          0.230     0.9186
  t3      0.9   50   0.99322              0.4850          0.289     0.8557
  t3      0.9  100   0.98530              1.3843          0.358     0.9531
  t3      0.9  500   0.99693              0.4800          0.276     0.5640
```

D6. Partial correlation. With raw standardized deviations (the idea's wording) the approximation correlated 0.874 to 0.986 with the exact edge, largest error up to 2.7: the claim as worded fails. Re-derived: the influence function of the partial correlation uses the standardized residuals of $i$ and $j$ on the conditioning set; with the precision-matrix form $\varepsilon = \Omega x / \sqrt{\operatorname{diag}\Omega}$, whose $\varepsilon_i, \varepsilon_j$ correlate at $-\rho$, the second term changes sign. The derivation goes through $d\Omega = -\Omega(xx^\top - \Sigma)\Omega$ and $\rho = -\omega_{ij}/\sqrt{\omega_{ii}\omega_{jj}}$; it is the agent's and labeled as a sketch. Both corrected forms agree to machine precision:

```
PARTIAL  p   N   cor(exact,resid-form)  max|err|   cor(exact,precision-form)  max|err|  sd(exact)
          4   50   0.99936              0.3549    0.99936                 0.3549    0.947
          4  100   0.99854              0.6015    0.99854                 0.6015    0.897
          4  500   0.99998              0.1227    0.99998                 0.1227    0.977
         10   50   0.99254              1.2559    0.99254                 1.2559    0.985
         10  100   0.99832              0.6925    0.99832                 0.6925    0.915
         10  500   0.99996              0.2318    0.99996                 0.2318    0.983
         30   50   0.98781              3.7355    0.98781                 3.7355    2.004
         30  100   0.99448              1.6379    0.99448                 1.6379    1.294
         30  500   0.99989              0.5674    0.99989                 0.5674    0.991
```

D7. Shared-factor sketch (the agent's): two genes $x_k = F + e_k$, classes differing only in the spread of $F$ (SD 0.5 against 1.5), $N$ = 200. Mean LIONESS edge 0.234 against 0.799; correlation of the edge with $F^2$ 0.743; after regressing both genes on $F$, 0.007. This is a sketch for the mechanism, never a result.

## 5. Datasets

No accession could be opened (section 3). Candidates, each `verify`: PRECISESADS (ELIXIR Luxembourg, controlled access; SLE, RA, and other diseases with controls, whole-blood RNA-seq, flow cytometry); GSE45291 (descriptions conflict on whether RA is included); GSE17755 (PBMC, RA and SLE in one series); GSE93272 (RA only). D8: a cross-study combination is ruled out for the primary analysis because disease would equal study. Recommended PRECISESADS with GSE45291 as fallback, both pending.

## 6. Journal worksheet

1. Main contribution: users of LIONESS who compare or classify samples get edges that are, to first order, quadratic functions of each sample's expression, so a network gain must beat the matched quadratic model and a reference holding the square of any shared factor. Who must read it: both users and methodologists.
2. Paper type: critique (with a benchmark). Rows rated good for a critique in the users and both groups: Bioinformatics, BMC Genomics, NAR Genomics and Bioinformatics, Bioinformatics Advances, BMC Bioinformatics, Cell Reports Methods, Frontiers in Genetics, Genome Biology, Journal of Applied Statistics, Journal of Computational Biology, JASA Applications and Case Studies, npj Systems Biology and Applications, SAGMB, Statistics in Biosciences.
3. Length: a seventeen-model benchmark with derivations needs room; journals with a short fixed length (Bioinformatics, 7 pages; Cell Reports Methods, 7,000 words) drop.
4. Charge and AI policy: "no drafting" policies (Bioinformatics, Bioinformatics Advances, Journal of Applied Statistics, JASA) conflict with this workflow's drafting and drop.
5. Remaining: BMC Bioinformatics (good critique, both audiences, no stated length, disclose AI use), SAGMB (good critique and simulation, both audiences, no charge required), npj Systems Biology and Applications (published the 2024 evaluation).

Target: BMC Bioinformatics.
Fallback: Statistical Applications in Genetics and Molecular Biology.
Target's limits and AI policy: structured abstract (Background, Results, Conclusions), 350 words; research article length not stated; AI use disclosed, AI not an author.

## Decisions

- D0. The idea's text was copied into `idea.md` word for word under "The idea in a paragraph"; the other headings restate it.
- D1. Paper type: critique, with the benchmark reading named (first message).
- D2. The user asked mid-stage that earlier work not be relied on: the osteosarcoma repository is listed in `idea.md` but used for nothing in the proposal, except that the LIONESS author list, volume, and pages in `references.md` came from a bib file there and are marked to be checked.
- D3. Network blocked: the stage was completed on search-result readings; every source carries `record: not opened`, every dataset `verify`, and `usable` = `no` in `citations.csv` until the reference check opens the records.
- D4. The reference check (step 9) is deferred until the hosts are allowed; it is listed for the user, not run.
- D5 to D7. Theory checks, section 4.
- D8. Cross-study combination ruled out for the primary analysis.
- D10. Stop 1, first answer (2026-11-03): the user does not want IFN-low and IFN-high strata. Applied to `proposal.md` (dated entry in its Revisions section) and noted at the end of `idea.md`, whose paragraph is kept as written. The pilot's IFN factor now varies the mean and the spread of $F$ together, since without strata the two diseases differ in both; the pass criterion names the moderate level instead of a spread ratio. Two open questions follow from the change: whether IFN-matched controls are kept, and how the score is defined. The stop stays open for the other questions.
- D9. The proposal proposes a list of seventeen models as a `[TO CONFIRM]` for the user to replace, and adds the squared IFN term to the reference as a `[TO CONFIRM]`.

## Revision 2 (2026-11-03): refinement before the pilot

The user answered stop 1 with "not final, refine the idea until perfect before the pilot". No hosts were newly allowed (a fetch of PMC still failed), so the round worked offline. Script: `log/01-idea-review-exact-forms.py`, seed 20261103.

- D11. Exact Pearson edge, equation (1) of the proposal: removing one sample is a rank-one downdate of the moments. Max |LIONESS - exact| at N = 10, 50, 500, rho = 0 and 0.7, with a sixfold outlier: 1.4e-14 to 6.8e-13.
- D12. Exact partial-correlation edge, equation (2), by Sherman-Morrison: max error 7.1e-15 to 1.3e-12 for p = 4 to 45. The inflation factor (N-1)/(N-1-m_q) explains the growth of the first-order error with p/N found in D6. First-order form against exact: cor 0.9986 (p 4, N 50), 0.9979 (10, 50), 0.9903 (30, 50), 0.9951 (30, 100), 0.9063 (45, 50); the Mahalanobis-scaled form: 0.99922, 0.99960, 0.99407, 0.99968, 0.92407. Mean m_q/(N-1): 0.08, 0.20, 0.61, 0.30, 0.92. Decision: partial-correlation LIONESS only for p <= N/4; the conditioned network (partial correlation given the IFN score and composition) keeps the conditioning set small.
- D13. Group means of edges under a pure mean shift (400 replicates, N = 200, Delta = (1, 0.6), no co-expression): observed 0.0013 (MCSE 0.0057), 0.1884 (0.0071), 0.3540 (0.0105) at pi = 0.5, 0.3, 0.15; the (1 - 2 pi) formula gives 0.0000, 0.1862, 0.3620. Decision: group balance becomes a pilot factor.
- D14. Test sample against a training reference: closed form equals the direct (N+1) r(+q) - N r(train) to ten decimals (-1.4556250470 both). Decision: test edges by the closed form, so the LIONESS reference never holds the test sample.
- D15. Design choices made as recommendations, each a marker in section 9 of the proposal: R1 as the reference of both primary contrasts; two primary contrasts in fixed sequence; the 17 models with reference covariates unpenalized; the gene set G (50 genes in each training fold, IFN-score genes excluded); every preprocessing step inside the training fold; outer 5-fold repeated 20 times, inner 5-fold, corrected resampled t-test; the five-gene IFN score; the untreated definition with a fallback when fewer than 40 per disease remain; common-support trimming in place of IFN matching; PRECISESADS as data source.
- New sources: mai2021ifn5, nadeau2003inference, mckenzie2016dgca, newman2015cibersort, from search results already logged (queries 3, 22, 23, 24); records not opened.

Revision pass (markdown form): the proposal was rewritten in full. Pass 1 put each section's answer first (the summary now opens with the closed form). Pass 2 split the long sentences of section 4, removed a claim of agreement "within 1.1 Monte Carlo standard errors" that the numbers did not support (corrected to 0.8), and corrected the stated condition of the 0.9997 correlation. The changes exceeded three sentences per section, so a second pass was made over sections 1, 4, and 7; it changed two sentences.

Process feedback: the stage file has no step for a refinement round requested at stop 1 before the proposal is final; this run treated it as a revision round (dated entry in the proposal's Revisions, a log section, a commit).

## Step 9: the reference check (2026-11-03)

- D16. The user answered "YES" to accepting every recommendation. Section 9 of the proposal became a list of decisions; one marker stays (the novelty verdict).
- D17. Step 9 run without network: no record of the 21 entries could be opened (PMC fetch failed again this turn). Every entry keeps `record: not opened`; `usable` stays `no`; build-bib.py lists 27 faults, all missing fields that the records would supply. Per `rules.md`, section 2, the list is returned to the user and the stage goes on. The check is to be rerun, and the faults cleared, once the hosts are allowed; the pilot cites none of these sources, so it does not block stage 2.

## Step 9 rerun: the reference check with network access (2026-11-03)

The user allowed the hosts. From the shell (the fetch tool stayed blocked): api.crossref.org, eutils.ncbi.nlm.nih.gov (PubMed, PMC, GEO), pmc.ncbi.nlm.nih.gov, www.ncbi.nlm.nih.gov/geo, arxiv.org, and the ELIXIR Luxembourg catalogue answered; www.biorxiv.org answered 429 (rate limit); bioinfo.genyo.es did not answer.

- D18. Records: every entry was looked up by DOI in Crossref or by PMID in PubMed and rewritten from the record (authors, title, journal, volume, issue, pages, DOI); missing DOIs found for Devlin 1975, Nadeau and Bengio 2003, Newman 2015, Saha 2024, Chen 2023, Tasaki 2018, Barturen 2021, and the published version of the pseudo-value preprint. Six keys renamed to first author and year. Full texts read from PMC for 13 sources and from a repository PDF for Barturen 2021; Devlin 1975 and Croux 2010 have no open full text (one fault left in `reference-fixes.md`).
- D19. Novelty, from the full texts: Yu 2017 (iENA) equation 5 reduces per-sample changes in correlation to the product of standardized deviations for large reference sets, the leading term of Result 1; Kuijjer, De Marzio, and Glass 2026 recast the linear methods in common variables and observed, on GTEx esophagus data, higher LIONESS edge weights in the smaller subpopulation for an edge with differential expression only, which is Result 3's direction. Their Supplement 1 (the recast equations) could not be downloaded (PMC 404, bioRxiv 429); the verdict became "partly known" with a marker for the supplement. Correction: the metabolomics evaluation (Jahagirdar and Saccenti 2021) found ssPCC edges better or equal in 13 of 22 data sets and LIONESS edges better in 5 of 22; the earlier description, taken from a search snippet, was wrong.
- D20. Datasets, from the GEO records and every sample record: GSE45291 has SLE 292, RA DMARD-IR 378, RA TNF-IR 115, controls 20, and every one of 18 processing dates (sample title prefixes) holds one group only, with separate gcrma normalization per set: disease is aliased with batch, and all RA were treated; ruled out. GSE17755: SLE 22. GSE235508: 25 SLE and 38 RA pregnancies. GSE149050: no RA. GEO search (db=gds, lupus and rheumatoid and blood, human series): 36 series, none other usable. PRECISESADS: ELIXIR-LU ELU-2-E592B0-1, 955 patients with 7 diseases and 267 controls, 18 centres, treatment groups recorded, flow cytometry; controlled access for non-commercial SAD research. Recommended action: request access now. New open item: the contingency if access fails.
- Mai 2021: the IFN5 score sums log2 NanoString expression; the proposal's score is described as adapted from it.

| # | Date | Source | Query or record | What it gave |
|---|---|---|---|---|
| 26 | 2026-11-03 | Crossref API | 15 DOIs; bibliographic queries for Devlin 1975, Nadeau and Bengio 2003, Barturen 2021, BONOBO | records, missing DOIs |
| 27 | 2026-11-03 | PubMed esummary | PMIDs 30981959, 30013029, 41867852, 33497037, 25822800; PMC 10025435, 4739640 | records, PMC ids |
| 28 | 2026-11-03 | PMC efetch | 14 full texts | passages in `citations.csv` |
| 29 | 2026-11-03 | GEO | GSE45291, GSE17755, GSE93272, GSE93777, GSE235508, GSE149050, GSE326777, GSE45536 series and sample records | section 6 |
| 30 | 2026-11-03 | GEO esearch (db=gds) | (lupus OR SLE) AND rheumatoid AND human AND gse AND (blood OR PBMC) | 36 series |
| 31 | 2026-11-03 | ELIXIR Luxembourg catalogue | ELU-2-E592B0-1 | access conditions |

## Revision pass (markdown form, `03-manuscript.md`, step 4.7)

Pass 1 (paragraphs): each section's first sentence was checked to state its answer; the summary was reordered to give the verdict on the formula before the data problem. Pass 2 (sentences): a claim of LIONESS being the most cited method had no source and became a `[CITE]` marker; the variance remark was labeled as the agent's step; long sentences in section 4 were split. No section changed by more than three sentences after the first pass, so no second pass was due.

## Time

| Step | Time |
|---|---|
| 1. Inventory and first message | 5 min |
| 2-3. Paper test and searches (including the network diagnosis) | 35 min |
| 4. Theory check | 15 min |
| 5. Datasets | within the searches |
| 6-7. Pilot plan, impact, worksheet | 10 min |
| 8. Proposal, references, revision pass | 25 min |

## Process feedback

1. The stage file assumes the session can open publisher pages and GEO. When it cannot, the rules leave no clear route: this run kept going on search-result readings, marked everything, and deferred the reference check. A sentence in `01-idea-review.md` on what to do when every record host is blocked would help.
2. The stage has no place for a theory-check script; it went to `log/01-idea-review-theory-check.py`. A stated home (for example `log/` with a fixed name) would remove the guess.
3. The step 9 reference check could run partly offline if `build-bib.py` accepted a flag marking entries whose record was not opened, so that its fault list separates "not yet checked" from "checked and wrong".
4. The idea named "seventeen models" without listing them; the inventory step could ask for every list the idea counts.
