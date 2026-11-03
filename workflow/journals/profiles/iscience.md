# iScience

| Field | Value |
|-----------------|--------------------------------------------------------------|
| Publisher | Cell Press, an imprint of Elsevier; no society |
| Online ISSN | 2589-0042 (as listed in Elsevier's APC price list [1]; the cell.com page that would label it could not be read) |
| Profile written | 2026-10-27 |

## Sources

Every page below was read on the date shown. Bracketed numbers in the text point here.

1. [Elsevier Article Publishing Charge price list (xlsx; "Prices as of date: 05-Oct-2026"), linked from source 2](https://legacyfileshare.elsevier.com/els_com_pricing/article-publishing-charge.xlsx), read 2026-10-27.
2. [Elsevier pricing policy page](https://www.elsevier.com/about/policies-and-standards/pricing), read 2026-10-27.
3. [Elsevier generative AI policies for journals (Elsevier-wide; does not name Cell Press)](https://www.elsevier.com/about/policies-and-standards/generative-ai-policies-for-journals), read 2026-10-27.
4. [iScience Editorial Manager home (submission system; links "Instructions For Authors" to cell.com)](https://www.editorialmanager.com/iscience/default.aspx), read 2026-10-27.
5. [iScience, Aims and scope](https://www.cell.com/iscience/aims), read 2026-10-27 through Claude in Chrome.
6. [iScience, Information for authors](https://www.cell.com/iscience/information-for-authors), read 2026-10-27 through Claude in Chrome.
7. [iScience, Article types](https://www.cell.com/iscience/information-for-authors/article-types), read 2026-10-27 through Claude in Chrome.
8. [iScience, Journal policies](https://www.cell.com/iscience/information-for-authors/journal-policies), read 2026-10-27 through Claude in Chrome.
9. [iScience, Revise manuscript](https://www.cell.com/iscience/information-for-authors/revise-manuscript), read 2026-10-27 through Claude in Chrome.
10. [Cell Press, After you submit: peer review (Cell Press-wide)](https://www.cell.com/information-for-authors/after-you-submit#peer-review), read 2026-10-27 through Claude in Chrome.

## Scope

> "iScience is a peer-reviewed journal from Cell Press that provides a platform for original research in the life, physical, earth, sustainability, and health sciences. We aim to fuel interdisciplinary thinking and consider research with significant contribution to a relevant field combined with robust results and underlying methodology." [5]

In plain terms, iScience is a broad open access Cell Press journal for original research across the sciences, read by a broad scientific audience. It says it will "consider replication studies and papers describing negative results, provided they offer clear value to the research community" [5], which opens the door to a critique. Two items on its out-of-scope list matter for we [5]:

> "Datamining studies using single datasets without experimental validation in original or external cohorts and strong originality, novelty and advance." [5]

> "Machine-learning or artificial intelligence methods without benchmarking against similar methods and demonstrated superior performance." [5]

The journal also runs Matters Arising, "a venue for research papers that directly and definitively challenge the main take-home message of a previously published iScience paper" [7]; LIONESS was published in iScience. Among its genomics papers are applied uses of sample-specific co-expression networks (paper 2 below), a critique of the standard normalization for a spatial transcriptomics platform with an alternative pipeline (paper 1 below), and simulation-backed limits on what single-cell data can estimate (paper 3 below).

| Paper type | Fit | Why |
|--------------------------------------------|----------|------------------------------------------------|
| Critique with a closed-form bias, simulation, fix, and application | good | The aims consider negative results of clear value [5], and Matters Arising, at full research-article length, exists for papers that challenge a published iScience paper such as LIONESS [7]. |
| Simulation and diagnostic, no closed form | possible | Simulation-backed limits on an estimation task appear (paper 3 below), but the journal asks for "significant contribution to a relevant field combined with robust results" [5]. |
| Constructive method with theory, simulation, comparison, and application | possible | The out-of-scope list rules out machine-learning methods only when they lack benchmarks against similar methods [5], so new methods are considered, but few of its broad readers evaluate statistical procedures, and the paper must make a "significant contribution to a relevant field" [5]. |
| Short methods note | poor | Research Articles and Matters Arising share one long format, and papers that "are technically accurate but do not report a significant contribution will not be considered" [7]. |
| Theory paper | poor | No pure statistical theory found among published genomics papers, and the aims ask for robust results and methodology in an applied field [5]. |
| Applied analysis | possible | Applied sample-specific network papers appear (paper 2 below), but single-dataset data mining without validation in an original or external cohort is out of scope [5], so a lupus reanalysis needs a second cohort. |

## Article types that fit

| Article type | Length | Figures and tables | References | Source |
|-------------------|--------------------------|---------------------|-------------|--------|
| Research Article | advised below 8,000 words; detailed methods go in STAR Methods | not stated on the site | not stated on the site | [7] |
| Matters Arising (only on papers published in iScience) | same format and length as Research Articles; no revisions permitted | not stated on the site | not stated on the site | [7] |

## Abstract

- Structured: no; "The summary is a single paragraph of no more than 150 words" [9]
- Headings: none
- Word limit: 150 [9]

## Reference style

- The journal's stated style: "References should be sequentially numbered according to their first citation in the manuscript." [9]
- CSL file: `dependent/iscience.csl` in the official styles repository (github.com/citation-style-language/styles, commit d2cc420, 2026-10-24), a dependent style whose parent is `cell.csl`, a numbered style. That matches the site, which asks for references numbered in order of first citation.
- File to use in Quarto: `csl/cell.csl`, which renders offline. The journal-named `csl/dependent/iscience.csl` gives the same output but needs a network connection, because pandoc fetches the parent at render time.
- Rendering test: both files passed on 2026-10-27 (`csl/test-results.md`).

## Supplement, code, and data

- Supplementary material: general rules were not recorded; original code may be placed in the supplemental information instead of a repository [8].
- Data availability statement: not recorded from the journal policies page (source 8).
- Code: "All original code must be deposited in a repository that mints DOIs or included in the supplemental information before a paper is accepted for publication." [8] So a DOI-minting repository or the supplement is required by acceptance, not at submission.

## AI-use policy

> "Authors must declare the use of generative AI in scientific manuscript preparation upon submission" [8]

- The declaration "should be placed in a new section after the "declaration of interests" section" [8]. This is the Cell Press text, and it takes precedence over Elsevier's general page [3] (see Contradictions).
- Elsevier's general policy adds: "Authors should not list AI tools as an author or co-author, nor cite AI tools as an author," and "AI tools must not be used to create or alter images that represent primary observed or experimental data." [3]
- Read at: https://www.cell.com/iscience/information-for-authors/journal-policies (journal), 2026-10-27, and https://www.elsevier.com/about/policies-and-standards/generative-ai-policies-for-journals (Elsevier, page says "Policy updated June 2026"), 2026-10-27.
- What the manuscript must do: declare AI use at submission in a new section right after the Declaration of interests, naming each tool and its use, and never list AI as an author.

## Open access and charges

- Model: fully open access ("Full Open Access") [1]
- Article processing charge: USD 3,240, excluding taxes, prices as of 05-Oct-2026, read 2026-10-27; the list also gives EUR 2,960, GBP 2,590, and JPY 421,950 [1]
- Waivers and institutional agreements: could not be read (https://www.cell.com/open-access returned 403); the Elsevier pricing page [2] does not mention Cell Press.

## Review

- Model: single anonymized; Cell Press uses single-anonymous peer review as its standard, and iScience does not take suggested reviewers [10].
- Time to decision: median 6 days to first editorial decision and median 4 days from acceptance to online publication [6].

## Recent papers like ours

1. van Hijfte L, Geurts M, Vallentgoed WR, Eilers PH, Sillevis Smitt PA, Debets R, French PJ (2023). Alternative normalization and analysis pipeline to address systematic bias in NanoString GeoMx Digital Spatial Profiling data. *iScience*. https://doi.org/10.1016/j.isci.2022.105760. Shows the vendor's standard pipeline biases results, offers a fix, and checks it on replicate and external data: our critique-plus-fix pattern.
2. Yin L, Traversa P, Elati M, Moreno Y, Marek-Trzonkowska N, Battail C (2025). Sample-specific network analysis identifies gene co-expression patterns of immunotherapy response in clear cell renal cell carcinoma. *iScience*. https://doi.org/10.1016/j.isci.2025.113061. Applies sample-specific co-expression networks to a clinical outcome, the very procedure family we critiques.
3. Nikhat A, Mandal T, Veerasubramanian N, Chakrabarti S (2026). Transcriptional noise sets fundamental limits to decoding circadian clock phase from single-cell RNA snapshots. *iScience*. https://doi.org/10.1016/j.isci.2026.115394. Uses simulation and data to show what a popular single-sample inference can and cannot recover.

## Not stated on the site, or could not be read

- Figure, table, and reference limits for Research Articles: not stated on the site (article types page, source 7).
- Data availability statement and general supplementary material rules: not recorded from the journal policies page (source 8).
- Publishing options and waivers: could not be read (https://www.cell.com/open-access, HTTP 403); no iScience publishing options page was read, so the model and APC rest on the price list [1].
- STAR Methods guides: could not be read (https://www.cell.com/pb-assets/journals/research/cell/methods/Methods_Guide_general-1678470557763.pdf and https://www.cell.com/pb-assets/journals/EM/MasterFFCs/ISCIFFC-1781892786367.pdf, HTTP 403).
- Online ISSN on a cell.com page: not recorded; the ISSN above comes from the price list [1].
- ScienceDirect journal page: could not be read (https://www.sciencedirect.com/journal/iscience, HTTP 403).

Contradictions:

- AI declaration placement: Elsevier's general policy [3], which this profile earlier followed, puts the declaration immediately before the references. The iScience policy [8] puts it in a new section after the declaration of interests. The journal's rule governs.

## Table row

```
scope_5_words: broad interdisciplinary open access science
audience: general science
fit_critique: good
fit_sim_diagnostic: possible
fit_constructive: possible
fit_short_note: poor
fit_theory: poor
fit_applied: possible
abstract_format: unstructured
abstract_words: 150
length_limit: Research Article: below 8,000 words advised
apc: USD 3,240
oa_model: open access
ai_policy_3_words: declare after interests
review_model: single
guidelines_read: partly
```
