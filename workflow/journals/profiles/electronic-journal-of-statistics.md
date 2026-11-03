# Electronic Journal of Statistics

| Field | Value |
|-----------------|--------------------------------------------------------------|
| Publisher | Institute of Mathematical Statistics and Bernoulli Society (sponsors) [1] |
| Online ISSN | 1935-7524 (from the Crossref journal record, not from an IMS page) [5] |
| Profile written | 2026-10-27 |

## Sources

Every page below was read on the date shown. Bracketed numbers in the text point here.

1. [About Electronic Journal of Statistics, IMS Electronic Journal Management System (EJMS)](https://www.e-publications.org/ims/submission/EJS/help/about/), read 2026-10-27.
2. [LaTeX support page for IMS co-sponsored journals (VTeX, for IMS)](https://www.e-publications.org/ims/support/imsco-instructions.html), read 2026-10-27.
3. [EJS LaTeX author package documentation](https://vtex-soft.github.io/texsupport.ims_cosponsored-ejs/) and its sample file `ejs-sample.tex` (https://github.com/vtex-soft/texsupport.ims_cosponsored-ejs), linked from [2], read 2026-10-27.
4. [Electronic Journal of Statistics, IMS journal page](https://imstat.org/journals-and-publications/electronic-journal-of-statistics/), read 2026-10-27 through Claude in Chrome.
5. Crossref REST API records (`https://api.crossref.org/journals/1935-7524` and `https://api.crossref.org/works/<DOI>`) for the ISSN and the papers under "Recent papers like ours", read 2026-10-27.
6. Blocked page (could not be read, 2026-10-27): the Project Euclid page https://projecteuclid.org/ejs returns a bot-protection block.
7. IMS site search for "artificial intelligence" on imstat.org, read 2026-10-27 through Claude in Chrome (no URL recorded).

## Scope

> "The Electronic Journal of Statistics (EJS) publishes research articles and short notes on theoretical, computational and applied statistics. The journal is open access." [1], [4]

EJS is an open-access general statistics journal from the IMS and the Bernoulli Society, and its articles "are held to the same standard as articles in other IMS journals" [1]. It charges no publication fee [4]. Most of what it prints is mathematical statistics: estimators, tests, and their properties. Readers are methodologists and theorists. It suits our theory paper best (for example, a paper that characterizes what an edge-level or distance-based statistic converges to), and a short note is an explicit article type. Genomics applications are rare in recent volumes.

| Paper type | Fit | Why |
|--------------------------------------------|----------|------------------------------------------------|
| Critique with a closed-form bias, simulation, fix, and application | possible | Fits if the closed-form result is the center of the paper; the genomics application would be secondary for this readership. |
| Simulation and diagnostic, no closed form | poor | Without a derivation the paper would be light for a journal held to IMS theory standards [1]. |
| Constructive method with theory, simulation, comparison, and application | good | New estimators and tests with their properties are most of what the journal prints (papers 2 and 3 below), provided the properties are proved and not only simulated. |
| Short methods note | good | "Short notes" are a stated article type [1], [4]. |
| Theory paper | good | The journal publishes theoretical statistics and is open access [1], [4]. |
| Applied analysis | poor | Applied statistics is in scope [1], but routine analyses are not what the journal prints. |

## Article types that fit

| Article type | Length | Figures and tables | References | Source |
|-------------------|--------------------------|---------------------|-------------|--------|
| Research article | not stated on the site | could not be read | could not be read | [1], [4], [6] |
| Short note | not stated on the site | could not be read | could not be read | [1], [4], [6] |

## Abstract

- Structured: no; the template asks for an abstract that "should summarize the contents of the paper" and should not refer to results, bibliography, or formulas in the body [3]
- Headings: none
- Word limit: not stated on the site [4]

## Reference style

- The journal's stated style: no written rule was recorded from the IMS journal page [4], and the Project Euclid page could not be read [6]. The official LaTeX author package loads `natbib` with the `numbers` option by default, with a commented alternative "uncomment this for author-year citations", and supplies three BibTeX styles: `acmtrans-ims.bst`, `imsart-nameyear.bst`, and `imsart-number.bst` [3]. So either numbered or IMS author-year style is supported by the template.
- CSL file: `dependent/electronic-journal-of-statistics.csl` in the official styles repository (github.com/citation-style-language/styles, commit d2cc420, 2026-10-24), a dependent style whose parent is `institute-of-mathematical-statistics.csl`. It is numbered, which matches the default of the journal's LaTeX package.
- File to use in Quarto: `csl/institute-of-mathematical-statistics.csl`, which renders offline. The journal-named `csl/dependent/electronic-journal-of-statistics.csl` gives the same output but needs a network connection, because pandoc fetches the parent at render time.
- Rendering test: both files passed on 2026-10-27 (`csl/test-results.md`).

## Supplement, code, and data

- Supplementary material: the LaTeX template says supplementary material, including data sets and code, goes in a `supplement` environment, cannot be available only as an external link, and must be available on Project Euclid with the article [3].
- Data availability statement: could not be read; no data rule was recorded from the IMS journal page [4], and the Project Euclid page is blocked [6].
- Code: could not be read; no code rule was recorded from the IMS journal page [4], and the Project Euclid page is blocked [6].

## AI-use policy

> Not stated on the site. The IMS journal page has no AI policy [4], and an IMS site search for "artificial intelligence" found none for EJS [7].

- Read at: https://imstat.org/journals-and-publications/electronic-journal-of-statistics/ and the IMS site search, 2026-10-27, through Claude in Chrome.
- What the manuscript must do: no IMS rule applies; as a precaution, include a short AI-use statement in the acknowledgements naming the tools and tasks, and check the IMS pages again before submission.

## Open access and charges

- Model: fully open access ("The journal is open access") [1], [4], with articles under CC BY 4.0 [4].
- Article processing charge: none. "Author or publication fees are not required. Voluntary fees or donations to the Open Access Fund are accepted." Read 2026-10-27 [4].
- Waivers and institutional agreements: none needed, since no fee is required [4].

## Review

- Model: not stated on the site [4]. "Articles are refereed" [1].
- Time to decision: could not be read [6]. "Articles become publicly available shortly after they are accepted" [1].

## Recent papers like ours

1. Rossell D, Zwiernik P (2021). Dependence in elliptical partial correlation graphs. *Electronic Journal of Statistics* 15(2):4236 to 4263. https://doi.org/10.1214/21-ejs1891. Asks what a widely used network statistic (a zero partial correlation) actually means outside the Gaussian case and answers in closed form, the theory version of our critiques.
2. Molstad AJ, Ekvall KO, Suder PM (2024). Direct covariance matrix estimation with compositional data. *Electronic Journal of Statistics* 18(1):1702 to 1748. https://doi.org/10.1214/24-ejs2222. Shows why standard covariance estimators fail on compositional microbiome data and builds an estimator that compares dependence across populations.
3. De Santis R, Goeman JJ, Davenport S, Hemerik J, Finos L (2025). Permutation-based multiple testing when fitting many generalized linear models. *Electronic Journal of Statistics* 19(2):3317 to 3332. https://doi.org/10.1214/25-ejs2409. A permutation-based testing method for the many-models setting of high-dimensional omics, robust to misspecified variances, close to our permutation-test work.

## Not stated on the site, or could not be read

- Length limit for research articles and short notes: not stated on the IMS journal page [4].
- Figure, table, and reference limits: could not be read; the Project Euclid page is blocked [6].
- Abstract word limit: not stated on the site [4].
- Reference style: no written rule was recorded from the IMS journal page [4]; inferred from the official LaTeX template, which supports both numbered and author-year citations [3].
- Data availability and code policy: could not be read [6].
- AI policy: not stated on the site (sources 4 and 7).
- Review model: not stated on the site [4].
- Decision times: could not be read [6].
- Online ISSN taken from Crossref rather than an IMS page [5].

Contradictions:

- None found. The IMS journal page [4] repeats the scope and open access wording of the EJMS page [1].

## Table row

```
scope_5_words: theoretical, computational, applied statistics
audience: methodologists
fit_critique: possible
fit_sim_diagnostic: poor
fit_constructive: good
fit_short_note: good
fit_theory: good
fit_applied: poor
abstract_format: unstructured
abstract_words: not stated
length_limit: not stated
apc: none
oa_model: open access
ai_policy_3_words: not stated
review_model: not stated
guidelines_read: partly
```
