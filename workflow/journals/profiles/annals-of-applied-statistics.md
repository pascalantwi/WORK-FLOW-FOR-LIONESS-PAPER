# The Annals of Applied Statistics

| Field | Value |
|-----------------|--------------------------------------------------------------|
| Publisher | Institute of Mathematical Statistics [1] |
| Online ISSN | 1941-7330 (from the Crossref journal record, not from an IMS page) [5] |
| Profile written | 2026-10-27 |

## Sources

Every page below was read on the date shown. Bracketed numbers in the text point here.

1. [About The Annals of Applied Statistics, IMS Electronic Journal Management System (EJMS)](https://www.e-publications.org/ims/submission/AOAS/help/about/), read 2026-10-27.
2. [LaTeX support page for IMS journals (VTeX, for IMS)](https://www.e-publications.org/ims/support/ims-instructions.html), read 2026-10-27.
3. [AOAS LaTeX author package documentation](https://vtex-soft.github.io/texsupport.ims-aoas/) and its sample file `aoas-sample.tex` (https://github.com/vtex-soft/texsupport.ims-aoas), linked from [2], read 2026-10-27.
4. [Annals of Applied Statistics manuscript submission, IMS](https://imstat.org/journals-and-publications/annals-of-applied-statistics/annals-of-applied-statistics-manuscript-submission/), read 2026-10-27 through Claude in Chrome.
5. Crossref REST API records (`https://api.crossref.org/journals/1932-6157` and `https://api.crossref.org/works/<DOI>`) for the ISSN and the papers under "Recent papers like ours", read 2026-10-27.
6. [The Annals of Applied Statistics, IMS journal page](https://imstat.org/journals-and-publications/annals-of-applied-statistics/), read 2026-10-27 through Claude in Chrome.
7. [Annals of Applied Statistics guidelines for referees, IMS](https://imstat.org/journals-and-publications/annals-of-applied-statistics/annals-of-applied-statistics-guidelines-for-referees/), read 2026-10-27 through Claude in Chrome.
8. IMS site search for "artificial intelligence" on imstat.org, and the Annals of Statistics editorial policy page, read 2026-10-27 through Claude in Chrome (no URLs recorded).
9. Blocked pages (could not be read, 2026-10-27): the Project Euclid pages https://projecteuclid.org/journals/annals-of-applied-statistics and https://projecteuclid.org/journals/annals-of-applied-statistics/author-guidelines return a bot-protection block.

## Scope

> "The Annals of Applied Statistics, newest journal from the IMS, is aimed at papers in the applied half of this range." [1]

> "We hope to publish papers that have substantive applied origins and involve relevant datasets, while also being of interest beyond the specific application." [4]

The "range" is the span of statistical research "from direct subject-matter collaborations to pure mathematical theory" [1]. In plain terms, AoAS publishes methods that grow out of a real scientific problem and are shown on real data. The submission page asks that data analyses go "well beyond numerical illustrations of calculations of proposed new methodology, with particular emphasis put on comparative analyses and substantive findings" [4]. The referee guidelines rule out the opposite case: "Papers focused primarily on extending existing methodology, or developing new methodology without a clear application, are not suitable for AOAS." [7] The journal has a dedicated editor for computational biology, bioinformatics, genetics, and genomics [1], [6]. Its readers are methodologists who care about applications. Recent volumes include papers that question what a popular genomics procedure really estimates (cell-type deconvolution, differential network tests), so our critique paper fits well, provided the application yields real findings.

| Paper type | Fit | Why |
|--------------------------------------------|----------|------------------------------------------------|
| Critique with a closed-form bias, simulation, fix, and application | good | AoAS publishes critiques of genomics procedures with a fix and a real application (see the papers below), and it asks for "comparative analyses and substantive findings" [4]. |
| Simulation and diagnostic, no closed form | possible | Fits if the diagnostic answers a real applied question; new methodology "without a clear application" is not suitable [7]. |
| Constructive method with theory, simulation, comparison, and application | possible | New tests appear when a real genomics problem drives them (papers 2 and 3 below), but papers "developing new methodology without a clear application" are not suitable [7], so the application must yield substantive findings. |
| Short methods note | poor | The submission page names no short article type [4]. |
| Theory paper | poor | The journal is "aimed at papers in the applied half" of statistical research [1], and methodology without a clear application is not suitable [7]. |
| Applied analysis | possible | Papers should have "substantive applied origins" [4], but they must also be "of interest beyond the specific application" [4], so an analysis with off-the-shelf methods may be judged too thin. |

## Article types that fit

| Article type | Length | Figures and tables | References | Source |
|-------------------|--------------------------|---------------------|-------------|--------|
| Article | most published papers do not exceed 20 pages of about 500 words each; longer papers need "unusually compelling subject matter" | no separate limit; each figure counts as about one third of a page, each displayed equation as 30 words | not stated on the site | [4] |

Submission is through EJMS as a PDF, and "Manuscripts must be written in LaTeX using AOAS's template." [4] A Quarto draft therefore has to be moved into the AOAS LaTeX template before submission.

## Abstract

- Structured: no; the template asks for an abstract that "should summarize the contents of the paper" and should "not make reference to results, bibliography or formulas in the body" [3]
- Headings: none
- Word limit: not stated on the site [4]
- The submission page asks the abstract and introduction to say what question the paper addresses, why, and how, "in as non-technical a manner as possible" [4].

## Reference style

- The journal's stated style: "References should be in the name/year format." [4] The first citation in each section gives all names, for example Smith, Jones, and Roberts (1992), with "et al." for more than three authors [4]. The submission page points to the IMS LaTeX template with `natbib` and tells authors to delete the `[numbers]` option for name-year citations [4]. The official LaTeX author package loads `natbib` with the `authoryear` option and uses the `spr-ims-nameyear.bst` BibTeX style, and says to "List all authors when there are 9 or fewer; use "et al." starting at 10 authors" [3]. That is IMS author-year style.
- CSL file: no file for this journal in the official styles repository (github.com/citation-style-language/styles, commit d2cc420, 2026-10-24). The repository's IMS style (`institute-of-mathematical-statistics.csl`) is numbered, but the journal's LaTeX package uses IMS author-year, so the substitute is the ASA author-year style. Final production uses the journal's LaTeX class in any case.
- File to use in Quarto: `csl/american-statistical-association.csl`, a substitute chosen by the coordinator, not by the journal.
- Rendering test: `csl/american-statistical-association.csl` passed on 2026-10-27 (`csl/test-results.md`).

## Supplement, code, and data

- Supplementary material: "We strongly encourage submission of data sets, computer algorithms and supporting material" [4]. Supplements are included in the review and posted at Project Euclid with the article [4]. The LaTeX template says supplementary material, "including data sets and code", goes in a `supplement` environment with a title and short description, "cannot be available exclusively as external link", and "must be available to the reader on Project Euclid with the published article" [3]. The template also has a heading "APPENDICES MUST BE MOVED TO A SUPPLEMENT FILE" [3].
- Data availability statement: not stated on the site [4]. Sharing is encouraged, not required: "AOAS strongly encourages authors to make the data used in papers published in AOAS available" [4].
- Code: encouraged, not required; "computer algorithms" are part of the supporting material the journal strongly encourages [4], and code supplied as a supplement is hosted with the article on Project Euclid [3], [4]. No public repository is required [4].

## AI-use policy

> Not stated on the site. The manuscript submission page [4] and the journal page [6] have no AI policy, an IMS site search for "artificial intelligence" found none for AOAS, and the Annals of Statistics editorial policy page has no AI text either [8].

- Read at: https://imstat.org/journals-and-publications/annals-of-applied-statistics/annals-of-applied-statistics-manuscript-submission/ and https://imstat.org/journals-and-publications/annals-of-applied-statistics/, 2026-10-27, through Claude in Chrome.
- What the manuscript must do: no IMS rule applies; as a precaution, include a short AI-use statement in the acknowledgements naming the tools and tasks, and check the IMS pages again before submission.

## Open access and charges

- Model: not stated on the site (manuscript submission page [4] and journal page [6]).
- Article processing charge: not stated on the site [4], [6].
- Waivers and institutional agreements: not stated on the site [4], [6].

## Review

- Model: not stated on the site [4], [6]. The Editor in Chief screens each submission and assigns an Area Editor, who has full control [4]. The EJMS pages describe referees and Associate Editors and say report files are renamed "to preserve anonymity" [1], which does not settle whether authors are anonymized.
- Time to decision: not stated on the site [4].

## Recent papers like ours

1. Hunt GJ, Gagnon-Bartsch JA (2021). The role of scale in the estimation of cell-type proportions. *Annals of Applied Statistics* 15(1):270 to 286. https://doi.org/10.1214/20-aoas1395. Unifies widely used cell-type deconvolution methods, shows that the data scale they fit on changes what they estimate, and recommends a fix, close to our cell-composition critiques.
2. Zhao S, Shojaie A (2022). Network differential connectivity analysis. *Annals of Applied Statistics* 16(4):2166 to 2182. https://doi.org/10.1214/21-aoas1581. Shows that existing tests for differences between gene networks can mislead and proposes a test of the right hypothesis, the same move we makes for sample-specific networks.
3. Aw AJ, Spence JP, Song YS (2024). A simple and flexible test of sample exchangeability with applications to statistical genomics. *Annals of Applied Statistics* 18(1):858 to 881. https://doi.org/10.1214/23-aoas1817. A permutation-style test of an assumption that genomics analyses take for granted, with simulations and real data.

## Not stated on the site, or could not be read

- Figure, table, and reference limits: not stated on the site; the page guide only counts figures and equations toward length [4].
- Abstract word limit: not stated on the site [4].
- Data availability statement: not stated on the site; data sharing is encouraged, not required [4].
- AI policy: not stated on the site (sources 4, 6, and 8).
- Open access model, article processing charge, and waivers: not stated on the site (sources 4 and 6).
- Review model (single or double anonymized): not stated on the site (sources 4 and 6).
- Decision times: not stated on the site [4].
- Project Euclid journal and author guidelines pages: could not be read (bot protection) [9].
- Online ISSN taken from Crossref rather than an IMS page [5].

Contradictions:

- LaTeX citation option: the submission page tells authors to delete the `natbib` `[numbers]` option for name-year citations, which suggests a numbered default [4], while the AOAS LaTeX author package already loads `authoryear` [3]. Both lead to name-year citations; check the option in whichever template is downloaded.
- Author count before "et al.": the submission page uses "et al." for more than three authors [4], while the LaTeX package lists all authors up to nine [3]. The first rule is stated for citations in the text and the second for the reference list, so they may not conflict, but neither page says so.

## Table row

```
scope_5_words: applied problems driving statistical methods
audience: methodologists
fit_critique: good
fit_sim_diagnostic: possible
fit_constructive: possible
fit_short_note: poor
fit_theory: poor
fit_applied: possible
abstract_format: unstructured
abstract_words: not stated
length_limit: article, most at most 20 pages (about 500 words each)
apc: not stated
oa_model: not stated
ai_policy_3_words: not stated
review_model: not stated
guidelines_read: yes
```
