# Cell Reports Methods

| Field | Value |
|-----------------|--------------------------------------------------------------|
| Publisher | Cell Press, an imprint of Elsevier; no society |
| Online ISSN | 2667-2375 (as listed in Elsevier's APC price list [1]; the cell.com page that would label it could not be read) |
| Profile written | 2026-10-27 |

## Sources

Every page below was read on the date shown. Bracketed numbers in the text point here.

1. [Elsevier Article Publishing Charge price list (xlsx; "Prices as of date: 05-Oct-2026"), linked from source 2](https://legacyfileshare.elsevier.com/els_com_pricing/article-publishing-charge.xlsx), read 2026-10-27.
2. [Elsevier pricing policy page](https://www.elsevier.com/about/policies-and-standards/pricing), read 2026-10-27.
3. [Elsevier generative AI policies for journals (Elsevier-wide; does not name Cell Press)](https://www.elsevier.com/about/policies-and-standards/generative-ai-policies-for-journals), read 2026-10-27.
4. [Cell Reports Methods, Information for authors](https://www.cell.com/cell-reports-methods/information-for-authors), read 2026-10-27 through Claude in Chrome.
5. [Cell Reports Methods, Aims and scope](https://www.cell.com/cell-reports-methods/aims), read 2026-10-27 through Claude in Chrome.
6. [Cell Reports Methods, Article types](https://www.cell.com/cell-reports-methods/information-for-authors/article-types), read 2026-10-27 through Claude in Chrome.
7. [Cell Reports Methods, Journal policies](https://www.cell.com/cell-reports-methods/information-for-authors/journal-policies), read 2026-10-27 through Claude in Chrome.
8. [Cell Reports Methods, Publishing options](https://www.cell.com/cell-reports-methods/information-for-authors/publishing-options), read 2026-10-27 through Claude in Chrome.
9. [Cell Press, After you submit: peer review (Cell Press-wide)](https://www.cell.com/information-for-authors/after-you-submit#peer-review), read 2026-10-27 through Claude in Chrome.
10. [Cell Reports Methods, Revise manuscript](https://www.cell.com/cell-reports-methods/information-for-authors/revise-manuscript), read 2026-10-27 through Claude in Chrome.

## Scope

> "Cell Reports Methods is an open access, multidisciplinary journal from Cell Press publishing transformative methods, platforms, and analytical frameworks that advance how biological and biomedical research is performed." [5]

> "The primary criterion for publication in Cell Reports Methods is a robust, reproducible method that will spur scientific progress." [4]

In plain terms, Cell Reports Methods prints methods papers and method evaluations across the life sciences, including computational genomics, and welcomes "software and AI-driven approaches, community resources" [5]. Besides Articles and short Reports, it has a Resources type for "empirical studies that inform the use and interpretations of existing methods," which "do not present a new method per se" but let authors "re-evaluate current approaches in a data-driven way" [6]. That is a close description of our critique and diagnostic papers. Its published papers include benchmarks that expose a hidden bias in a standard pipeline and propose a correction (papers 1 and 2 below). Readers are experimental and computational life scientists who adopt methods.

| Paper type | Fit | Why |
|--------------------------------------------|----------|------------------------------------------------|
| Critique with a closed-form bias, simulation, fix, and application | good | The Resources type exists for data-driven re-evaluations of existing methods [6], and published papers expose biases in standard genomics pipelines and propose fixes (papers 1 and 2 below). |
| Simulation and diagnostic, no closed form | good | A diagnostic that re-evaluates a current approach without a new method is what the Resources type describes [6]. |
| Constructive method with theory, simulation, comparison, and application | possible | An Article presents a method, compares it with related methods, and validates it [6], which is this paper's shape, but the readers adopt methods rather than evaluate them, and the bar is a method that changes how research is done [4, 5]. |
| Short methods note | possible | Reports (under 4,000 words, at most four figures or tables) give a short format [6], but the journal's main criterion is a robust, reproducible method [4]. |
| Theory paper | poor | The aims center on methods, platforms, and analytical frameworks that change how research is done [5], not on statistical theory. |
| Applied analysis | poor | A methods journal; a disease reanalysis without a methodological contribution does not match its aims [4, 5]. |

## Article types that fit

| Article type | Length | Figures and tables | References | Source |
|-------------------|--------------------------|---------------------|-------------|--------|
| Article | under 7,000 words, excluding references and STAR Methods | at most seven figures and/or tables | not stated on the site | [6] |
| Resource | same as Articles: under 7,000 words | at most seven figures and/or tables | not stated on the site | [6] |
| Report | under 4,000 words | at most four figures and/or tables | not stated on the site | [6] |

An Article presents the method, compares it with related methods, and validates it [6]. Reviews run 4,000 to 5,000 words with up to 100 references [6].

## Abstract

- Structured: no; the Summary is "a single paragraph of no more than 150 words" covering background or purpose, principal results, and broader significance, with no citations, and claims of novelty are discouraged [10]
- Headings: none
- Word limit: 150 [10]

## Reference style

- The journal's stated style: "References should be sequentially numbered according to their first citation in the manuscript." [10] The journal provides CSL and EndNote styles [10]. Formatting is not required at initial submission [4].
- CSL file: `dependent/cell-reports-methods.csl` in the official styles repository (github.com/citation-style-language/styles, commit d2cc420, 2026-10-24), a dependent style whose parent is `cell.csl`, a numbered style. That matches the site, which asks for references numbered in order of first citation.
- File to use in Quarto: `csl/cell.csl`, which renders offline. The journal-named `csl/dependent/cell-reports-methods.csl` gives the same output but needs a network connection, because pandoc fetches the parent at render time.
- Rendering test: both files passed on 2026-10-27 (`csl/test-results.md`).

## Supplement, code, and data

- Supplementary material: general rules were not recorded; original code may be placed in the supplemental information instead of a repository [7].
- Data availability statement: required as part of a Resource availability section, which names a lead contact and covers materials availability and data and code availability [7]. Standardized data types, such as sequencing data, must be in recommended repositories before acceptance [7].
- Code: "All original code must be deposited in a repository that mints DOIs or included in the supplemental information before a paper is accepted for publication. If the code is deposited, its DOI must be reported in the published paper." [7] So a DOI-minting repository or the supplement is required by acceptance, not at submission.

## AI-use policy

> "Authors must declare the use of generative AI in scientific manuscript preparation upon submission of the paper" [7]

> "The use of generative AI and AI-assisted technologies in manuscript preparation must be declared by adding a statement at the end of the manuscript when the paper is first submitted. The statement will appear in the published work and should be placed in a new section after the "declaration of interests" section." [7]

- Allowed uses include helping "to synthesize complex literature, provide an overview of a field or research question, identify research gaps, generate ideas," and support with content organization, language, and readability; "The technology must be applied with human oversight and control" [7]. AI cannot be an author [7].
- AI used in the research itself is described reproducibly in the methods or STAR Methods, with the model name, version, and developer [7]. Explanatory images may be AI-made with a declaration; research and data images may not; data visualizations are allowed only if derived directly from the data and reported [7].
- The journal's own policy [7] takes precedence over Elsevier's general page [3], and it places the declaration differently (see Contradictions).
- Read at: https://www.cell.com/cell-reports-methods/information-for-authors/journal-policies, 2026-10-27.
- What the manuscript must do: add a section titled "Declaration of generative AI and AI-assisted technologies in the manuscript preparation process" right after the Declaration of interests, naming each tool and its use (the manuscript component list puts this section before STAR Methods and References [4]); describe any AI used in the analysis itself in the STAR Methods.

## Open access and charges

- Model: fully open access ("This journal is an open access journal, and publishing at the journal requires payment of an article processing charge") [1, 8]
- Article processing charge: USD 4,970, excluding taxes, prices as of 05-Oct-2026, read 2026-10-27; the list also gives EUR 4,530, GBP 3,980, and JPY 647,250 [1]. The charge is payable after acceptance and is "the only fee authors incur" [8].
- Waivers and institutional agreements: Elsevier institutional agreements may cover the charge, and a geographical pricing pilot sets open access prices by country income (GNI) [8].

## Review

- Model: single anonymized ("Cell Press uses single-anonymous peer review as the standard across all journals.") [9]. Authors may suggest reviewers [9].
- Time to decision: median 7 days to first editorial decision and median 26 days from acceptance to online publication, "median values calculated over a calendar year" [4]. Presubmission inquiries are answered in 1 to 3 business days, and Multi-Journal Submission is available [4].

## Recent papers like ours

1. Van den Berge K, Chou HJ, Roux de Bézieux H, Street K, Risso D, Ngai J, Dudoit S (2022). Normalization benchmark of ATAC-seq datasets shows the importance of accounting for GC-content effects. *Cell Reports Methods*. https://doi.org/10.1016/j.crmeth.2022.100321. Shows a sample-specific bias that standard normalization misses, proposes a fix, and benchmarks it on public datasets: our critique-plus-fix pattern.
2. Liu X, Yang M, Hu D, An Y, Wang W, Lin H, Pan Y, Ju J, Sun K (2024). Systematic biases in reference-based plasma cell-free DNA fragmentomic profiling. *Cell Reports Methods*. https://doi.org/10.1016/j.crmeth.2024.100793. Documents systematic bias in a widely used profiling approach.
3. Tekkey N, Garza JE, Zhang W, Albracht D, Tomlinson C, Belter EA, Xing X, Macias-Velasco JF, Wang T (2026). Quantifying reference alignment bias in functional genomics analyses. *Cell Reports Methods*. https://doi.org/10.1016/j.crmeth.2026.101461. Quantifies how a routine step (alignment to hg38) biases RNA-seq, ATAC-seq, and WGBS readouts, an evaluation of a default practice.

## Not stated on the site, or could not be read

- Reference limits for Articles, Resources, and Reports: not stated on the site (article types page, source 6).
- General rules for supplementary material (size, format): not recorded from the journal policies or revise manuscript pages (sources 7 and 10).
- STAR Methods guide: could not be read (https://www.cell.com/pb-assets/journals/research/cell/methods/Methods_Guide_general-1678470557763.pdf, HTTP 403).
- Online ISSN on a cell.com page: not recorded; the ISSN above comes from the price list [1].
- ScienceDirect journal page: could not be read (https://www.sciencedirect.com/journal/cell-reports-methods, HTTP 403).

Contradictions:

- AI declaration placement: Elsevier's general policy [3], which this profile earlier followed, puts the declaration immediately before the references. The journal's policy [7] puts it in a new section after the declaration of interests, and the manuscript component list [4] places it before STAR Methods and References. The journal's rule governs.

## Table row

```
scope_5_words: methods that advance biological research
audience: both
fit_critique: good
fit_sim_diagnostic: good
fit_constructive: possible
fit_short_note: possible
fit_theory: poor
fit_applied: poor
abstract_format: unstructured
abstract_words: 150
length_limit: Article or Resource: under 7,000 words, 7 figures and tables
apc: USD 4,970
oa_model: open access
ai_policy_3_words: declare after interests
review_model: single
guidelines_read: yes
```
