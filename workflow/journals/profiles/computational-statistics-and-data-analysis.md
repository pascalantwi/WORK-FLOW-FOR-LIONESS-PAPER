# Computational Statistics and Data Analysis

| Field | Value |
|-----------------|--------------------------------------------------------------|
| Publisher | Elsevier; official publication of CMStatistics and the International Association for Statistical Computing (IASC) [1] |
| Online ISSN | not stated on the pages read (ISSN 0167-9473 [1, 5]) |
| Profile written | 2026-10-27 |

## Sources

Every page below was read on the date shown. Bracketed numbers in the text point here.

1. [Computational Statistics and Data Analysis, Elsevier shop page (aims and scope)](https://shop.elsevier.com/journals/computational-statistics-and-data-analysis/0167-9473), read 2026-10-27.
2. [CMStatistics, Guide for Authors (submission to CSDA)](https://www.cmstatistics.org/submission.php), read 2026-10-27.
3. [CSDA Editorial Manager home page](https://www.editorialmanager.com/csda/default.aspx), read 2026-10-27.
4. [Elsevier, Generative AI policies for journals](https://www.elsevier.com/about/policies-and-standards/generative-ai-policies-for-journals), read 2026-10-27.
5. [Elsevier Article Publishing Charge price list (xlsx, "Prices as of date: 05-Oct-2026"), linked from the Elsevier journal pricing page](https://legacyfileshare.elsevier.com/els_com_pricing/article-publishing-charge.xlsx), read 2026-10-27.
6. [Elsevier Journal Finder, search result for the journal](https://journalfinder.elsevier.com/results?mode=search&query=computational+statistics+data+analysis), read 2026-10-27.
7. [CSDA Guide for Authors, ScienceDirect](https://www.sciencedirect.com/journal/computational-statistics-and-data-analysis/publish/guide-for-authors), read 2026-10-27 through Claude in Chrome (the ISSN form of the URL, https://www.sciencedirect.com/science/journal/01679473/publish/guide-for-authors, had returned HTTP 403 to automated readers earlier the same day).
8. [CSDA open access options, ScienceDirect](https://www.sciencedirect.com/science/journal/01679473/publish/open-access-options), could not be read (redirect target on ScienceDirect), tried 2026-10-27.
9. [Crossref REST API, works filtered to ISSN 0167-9473](https://api.crossref.org/works?filter=issn:0167-9473,from-pub-date:2021), queried 2026-10-27, and each DOI below confirmed at `https://api.crossref.org/works/<DOI>`.

## Scope

> "Computational Statistics and Data Analysis (CSDA), an Official Publication of the network Computational and Methodological Statistics (CMStatistics) and of the International Association for Statistical Computing (IASC), is an international journal dedicated to the dissemination of methodological research and applications in the areas of computational statistics and data analysis." [1]

In plain terms, CSDA publishes statistical methods where computing matters: algorithms, software, simulation, and data-analytic strategies. The journal says it has four refereed sections; both the shop page and the Guide for Authors describe only three [1, 7]. Section I, Computational Statistics, includes bioinformatics and the "development, evaluation and validation of statistical software and algorithms"; Section II, Statistical Methodology for Data Analysis, includes statistical genetics and biostatistics [7]. Section III, "Special Applications", explicitly covers "comparison of statistical methodologies" and "simulation experiments", plus "Advanced statistical analysis with real applications" including "medical statistics" [1, 7]. That is a direct home for our critique and simulation papers. Readers are computational statisticians, not genomics users, so the biology should be explained briefly.

| Paper type | Fit | Why |
|--------------------------------------------|----------|------------------------------------------------|
| Critique with a closed-form bias, simulation, fix, and application | good | Section III names comparison of statistical methodologies and simulation experiments with real applications. |
| Simulation and diagnostic, no closed form | good | Simulation experiments and software or algorithm evaluation are named in the scope. |
| Constructive method with theory, simulation, comparison, and application | good | Section II covers statistical methodology for data analysis, including statistical genetics and biostatistics [7], and new network methods with genomics applications appear (papers 2 and 3 below). |
| Short methods note | possible | The journal publishes short communications as well as research papers, though no length limit is given [7]. |
| Theory paper | poor | The journal centers computation and data analysis rather than theory without computation. |
| Applied analysis | possible | "Advanced statistical analysis with real applications" is in scope, though the analysis needs a methodological angle. |

## Article types that fit

| Article type | Length | Figures and tables | References | Source |
|-------------------|--------------------------|---------------------|-------------|--------|
| Research paper | not stated on the site | not stated on the site | not stated on the site | [7] |
| Short communication | not stated on the site | not stated on the site | not stated on the site | [7] |

"In addition to research papers and short communications, the journal welcomes review papers and book reviews." [7]

## Abstract

- Structured: no; a "concise and factual abstract" covering purpose, procedures, findings, and conclusions [7]
- Headings: none
- Word limit: 250 ("does not exceed 250 words") [7]; 1 to 7 keywords; highlights (3 to 5 bullets of at most 85 characters) are encouraged [7]

## Reference style

- The journal's stated style: "This journal does not set strict requirements on reference formatting at submission." "References can be in any style or format as long as the style is consistent." The journal style is applied at proof [7]. The Elsevier LaTeX template is encouraged and an editable source file is required, since a PDF is not accepted as source [7]; the CMStatistics page likewise asks LaTeX users to use the `elsarticle.cls` class and says the first submission can be a single PDF in any format, with the correct format required only at revision [2].
- CSL file: `dependent/computational-statistics-and-data-analysis.csl` in the official styles repository (github.com/citation-style-language/styles, commit d2cc420, 2026-10-24), a dependent style whose parent is `elsevier-harvard.csl`. The site accepts any consistent style at submission and applies its own style at proof, so this file matters only for a draft that should look like the published journal.
- File to use in Quarto: `csl/elsevier-harvard.csl`, which renders offline. The journal-named `csl/dependent/computational-statistics-and-data-analysis.csl` gives the same output but needs a network connection, because pandoc fetches the parent at render time.
- Rendering test: both files passed on 2026-10-27 (`csl/test-results.md`).

## Supplement, code, and data

- Supplementary material: submitted with the manuscript and published as received [7]. "Software and algorithms can be submitted with manuscripts and will be stored together with the online article." [1]
- Data availability statement: encouraged, not required. Under Elsevier's research data Option B, authors are encouraged to deposit, cite, and link their data, or to state why they cannot [7].
- Code: software and algorithms may be submitted and stored with the article [1, 7]; no public repository requirement, at submission or acceptance, is stated [7].

## AI-use policy

> "Authors must declare the use of generative AI tools in the manuscript preparation process upon submission of the paper." [7]

> "The use of AI tools in the manuscript preparation process must be declared by adding a statement at the end of the manuscript when the paper is first submitted. The statement will appear in the published work and should be placed in a new section before the reference list." [7]

> "AI tools must not be used to create or alter images that represent primary observed or experimental data" [4]

- The section title is "Declaration of generative AI and AI-assisted technologies in the manuscript preparation process" [7]. AI "may only be applied with human oversight and control," must not be an author, and is not declared for grammar, spelling, or reference tools [7]. AI may produce data visualizations derived reproducibly from the data, disclosed in the caption [7].
- The journal's Guide for Authors carries this Elsevier wording directly [7], so the publisher-wide policy [4] is confirmed as the journal's.
- Read at: https://www.sciencedirect.com/journal/computational-statistics-and-data-analysis/publish/guide-for-authors (journal) and https://www.elsevier.com/about/policies-and-standards/generative-ai-policies-for-journals (Elsevier), 2026-10-27.
- What the manuscript must do: include a separate declaration section, with the title above, just before the references, naming the tool and its purpose, and never list AI as an author.

## Open access and charges

- Model: hybrid (listed as "Hybrid Open Access" [5]; Journal Finder shows both an open access route and a subscription route with "No publishing charge" [6])
- Article processing charge: USD 3,540, excluding taxes (EUR 3,230, GBP 2,830, and JPY also listed), prices as of 05-Oct-2026, read 2026-10-27 [5, 6]
- Waivers and institutional agreements: Journal Finder says "Many institutions and Elsevier have agreements which cover some or all of the cost of publishing open access" and that country, funder, or society membership can reduce the price [6]. Journal-specific terms could not be read [8]; the Guide for Authors refers to the open access information page [7].

## Review

- Model: single anonymized ("This journal follows a single anonymized review process."), with at least two reviewers [7]. The journal is part of the Elsevier Article Transfer Service [7].
- Time to decision: Journal Finder lists "Submission to first decision 4 days" and "Acceptance to publication 6 days" [6]. The first figure is defined there as time from submission to the initial decision, which includes desk decisions, so it is not the time to a decision after full review.

## Recent papers like ours

1. Hapfelmeier A, Hornung R, Haller B (2023). Efficient permutation testing of variable importance measures by the example of random forests. *Computational Statistics and Data Analysis* 181:107689. https://doi.org/10.1016/j.csda.2022.107689. Examines how a widely used permutation procedure behaves and how to make it efficient, close to our permutation-test work.
2. Huang X, Zhang H (2021). Tests for differential Gaussian Bayesian networks based on quadratic inference functions. *Computational Statistics and Data Analysis* 159:107209. https://doi.org/10.1016/j.csda.2021.107209. Tests for group differences in network structure, the same question that sample-specific co-expression networks are used to answer.
3. Kim K (2022). On principal graphical models with application to gene network. *Computational Statistics and Data Analysis* 166:107344. https://doi.org/10.1016/j.csda.2021.107344. A gene-network method with a real genomics application, showing the journal takes co-expression network work.

## Not stated on the site, or could not be read

- Online ISSN: not stated on the pages read; only 0167-9473 appears [1, 5].
- Length, figure, table, and reference limits for research papers and short communications: not stated on the site (Guide for Authors, source 7).
- The journal's own reference style at proof: not named in the Guide for Authors (source 7).
- Journal-specific open access waivers: could not be read at https://www.sciencedirect.com/science/journal/01679473/publish/open-access-options.
- Fourth section: the scope says there are four refereed sections but both the shop page [1] and the Guide for Authors [7] describe only three.

Contradictions:

- None found between the Guide for Authors [7] and the earlier sources; its scope, software, and AI wording match sources 1 and 4.

## Table row

```
scope_5_words: computational statistics and data analysis
audience: methodologists
fit_critique: good
fit_sim_diagnostic: good
fit_constructive: good
fit_short_note: possible
fit_theory: poor
fit_applied: possible
abstract_format: unstructured
abstract_words: 250
length_limit: Research paper: not stated
apc: none required (open access USD 3,540)
oa_model: hybrid
ai_policy_3_words: declare before references
review_model: single
guidelines_read: yes
```
