# Statistical Applications in Genetics and Molecular Biology

| Field | Value |
|-----------------|--------------------------------------------------------------|
| Publisher | De Gruyter Brill |
| Online ISSN | 1544-6115 [1, 7] |
| Profile written | 2026-10-27 |

## Sources

Every page below was read on the date shown. Bracketed numbers in the text point here.

1. [Statistical Applications in Genetics and Molecular Biology, De Gruyter Brill journal page (Overview, Submit, Ranking, and Supplementary Materials tabs)](https://www.degruyterbrill.com/journal/key/sagmb/html), read 2026-10-27 in the browser (WebFetch returned HTTP 405).
2. [SAGMB Instructions for Authors (PDF)](https://www.degruyterbrill.com/publication/journal_key/SAGMB/downloadAsset/SAGMB_Instructions%20for%20Authors.pdf), read 2026-10-27.
3. [SAGMB Template for Ethical and Legal Declarations (docx)](https://www.degruyterbrill.com/publication/journal_key/SAGMB/downloadAsset/SAGMB_Template%20for%20Ethical%20and%20Legal%20Declarations.docx), read 2026-10-27.
4. [SAGMB Publication Ethics and Publication Malpractice Statement (PDF)](https://www.degruyterbrill.com/publication/journal_key/SAGMB/downloadAsset/SAGMB_Publication_ethics_and_malpractice.pdf), read 2026-10-27.
5. [De Gruyter Brill, AI-Policy for Authors ("As of September 2026")](https://www.degruyterbrill.com/publishing/for-authors/author-policies/artificial-intelligence), read 2026-10-27.
6. [De Gruyter Brill, Publish in Open Access (journal authors)](https://www.degruyterbrill.com/publishing/for-authors/journal-authors/open-access), read 2026-10-27.
7. [2027 Price List for De Gruyter + Brill Journals (xlsx, dated October 6, 2026), linked from [6] as the "journals overview"](https://degruyter-live-craftcms-assets.s3.amazonaws.com/DGB_25/Documents/Journal-Price-Lists/2027-DGB-Journal-Price-List.xlsx), read 2026-10-27.
8. [Crossref REST API, works filtered to ISSN 1544-6115](https://api.crossref.org/works?filter=issn:1544-6115,from-pub-date:2021), queried 2026-10-27, and each DOI below confirmed at `https://api.crossref.org/works/<DOI>`.

## Scope

> "Statistical Applications in Genetics and Molecular Biology (SAGMB) is a peer reviewed journal dedicated to advancing statistical, machine learning, and artificial intelligence (AI) methodologies and their applications across the full spectrum of modern molecular biosciences." [1, 2]

In plain terms, SAGMB is a statistical genomics journal: methods for omics data, read by statisticians who work on genomics and by quantitative biologists. It welcomes "novel techniques" and "insightful applications of existing statistical, machine learning, and AI approaches to molecular biology" [2], and lists "Theoretical and computational innovations" among its benefits [1]. This is the closest scope match in this group of journals: it has recently published a critique of interaction-based cell-specific analysis in bulk samples, which is near our cell-composition work. The trade-off is a low impact factor (0.8 for 2025 [1]).

| Paper type | Fit | Why |
|--------------------------------------------|----------|------------------------------------------------|
| Critique with a closed-form bias, simulation, fix, and application | good | Omics methods are the core scope, and the journal has published critiques of widely used genomics procedures. |
| Simulation and diagnostic, no closed form | good | Rigorous evaluation of existing methods on high-dimensional biological data is in scope. |
| Constructive method with theory, simulation, comparison, and application | good | Advancing statistical methodologies for the molecular biosciences is the stated aim [1, 2], and the readers are statisticians who work on genomics. |
| Short methods note | possible | Software Application Notes (at most 4 typeset pages) exist, but no short methods-note type is listed. |
| Theory paper | possible | Theoretical innovations are named among the journal's benefits, provided the theory concerns biological data. |
| Applied analysis | possible | The aims welcome "insightful applications" of existing approaches to molecular biology. |

## Article types that fit

| Article type | Length | Figures and tables | References | Source |
|-------------------|--------------------------|---------------------|-------------|--------|
| Original Research Article | not stated on the site | not stated on the site | not stated on the site | [1, 2] |
| Software Application Note | at most 4 typeset pages | not stated on the site | not stated on the site | [2] |
| Tutorial | not stated on the site | not stated on the site | not stated on the site | [1, 2] |

## Abstract

- Structured: not stated on the site; the instructions ask only for an "Abstract containing 200 words or less" [2]
- Headings: none stated
- Word limit: 200 [2]
- The abstract is followed by 3 to 6 keywords [2].

## Reference style

- The journal's stated style: its own author-date style. In-text citations use "the author-date method of citation", and the reference list takes the form "Author(s) (Year): title, Journal name (abbreviated if more than one word), volume: page range" [2]. The example shows abbreviated journal titles, e.g. "Stat. Appl. Genet. Mol. Biol." [2].
- CSL file: no file for this journal in the official styles repository (github.com/citation-style-language/styles, commit d2cc420, 2026-10-24). The site describes its own author-date format with abbreviated journal titles; no repository style matches it, so the substitute is the ASA author-year style, and the journal titles must be abbreviated by hand or in the bib before submission.
- File to use in Quarto: `csl/american-statistical-association.csl`, a substitute chosen by the coordinator, not by the journal.
- Rendering test: `csl/american-statistical-association.csl` passed on 2026-10-27 (`csl/test-results.md`).

## Supplement, code, and data

- Supplementary material: the journal page has a Supplementary Materials tab listing author files (instructions, LaTeX template, ethics statement, declarations template) [1]; the instructions say nothing about supplementary files for articles [2].
- Data availability statement: required. "Data availability" is one of the mandatory statements in the Template for Ethical and Legal Declarations, which must be uploaded as a separate Word file at submission; authors are referred to the De Gruyter Data Sharing Policy, or write "Not applicable" when the study has no raw data [1, 3].
- Code: not required. "Software availability" is an optional statement in the same template [3]. No repository requirement at submission or acceptance is stated [2, 3]. The ethics statement asks that a paper "contain sufficient detail and references to permit others to replicate the work" [4].

## AI-use policy

> "We do not accept submissions that name Large Language Models (LLM), such as ChatGPT, Artificial Intelligence (AI) and Machine Learning Tools (MLT) as credited author(s) on a manuscript" [3]

> "Use of an LLM, AI or MLT should be properly documented in the manuscript and must be stated in this template." [3]

- The template's statement "Use of Large Language Models, AI and Machine Learning Tools" asks authors to "specify the tool and the purpose of its use", or write "None declared" [3]. These statements are printed between the main text and the reference list [3].
- The publisher-wide De Gruyter Brill policy adds: AI used in study design or methodology "should be clearly described in an acknowledgements section"; disclosure is needed "when their output has significantly contributed to any part of your manuscript", but not for "simple proofreading and copy-editing" [5]. AI-generated illustrative images are allowed if disclosed at submission, while using generative AI "to create, alter, manipulate, or enhance research data, figures, or experimental images is not permitted" [5].
- Read at: https://www.degruyterbrill.com/publishing/for-authors/author-policies/artificial-intelligence and [3], 2026-10-27.
- What the manuscript must do: fill the "Use of Large Language Models, AI and Machine Learning Tools" statement in the declarations template (tool and purpose, or "None declared"), describe any AI used in the methods in the acknowledgements, and never list AI as an author.

## Open access and charges

- Model: hybrid. The journal page says "authors have the option to publish their articles under an open access license" ("Hybrid Open Access") [1], and the price list gives the publishing model as "Hybrid" [7].
- Article processing charge: EUR 2,700 (APC column in EUR only; no USD figure given), from the 2027 price list dated October 6, 2026, read 2026-10-27 [7]. The instructions say "There are no page charges" and color figures are free [2].
- Waivers and institutional agreements: "authors from institutions with which we have a transformative agreement can publish open access without paying an article processing charge (APC)" [1]. The publisher page adds that an institution "may cover some or all of the cost" [6].

## Review

- Model: not stated on the site. The instructions say only that acceptance "is taken after an external peer-reviewing procedure" [2]. At submission "it is mandatory to suggest possible reviewers": at least three, none from the Editorial Board [2].
- Time to decision: not stated on the site; the page says only "Decisions on your submission made as soon as possible" [1].

## Recent papers like ours

1. Meier R, Nissen E, Koestler D (2021). Low variability in the underlying cellular landscape adversely affects the performance of interaction-based approaches for conducting cell-specific analyses of DNA methylation in bulk samples. *Statistical Applications in Genetics and Molecular Biology* 20(3):73 to 84. https://doi.org/10.1515/sagmb-2021-0004. A critique showing when a widely used cell-composition-based approach fails, by simulation and real data, very close to our main paper type.
2. Wu G, Li Y (2022). Distinct characteristics of correlation analysis at the single-cell and the population level. *Statistical Applications in Genetics and Molecular Biology* 21(1):20220015. https://doi.org/10.1515/sagmb-2022-0015. Examines what gene-gene correlation estimates at different levels of aggregation, the same "what does it actually estimate" question we asks of co-expression networks.
3. Shi Y, Shi W, Wang M, Lee J, Kang H, Jiang H (2023). Accurate and fast small p-value estimation for permutation tests in high-throughput genomic data analysis with the cross-entropy method. *Statistical Applications in Genetics and Molecular Biology* 22(1):20210067. https://doi.org/10.1515/sagmb-2021-0067. A methods paper on permutation tests in genomics, related to our permutation-test work.

## Not stated on the site, or could not be read

- Length, figure, table, and reference limits for Original Research Articles and Tutorials: not stated on the site [1, 2].
- Abstract structure or headings: not stated on the site [2].
- Code repository requirement: not stated on the site; software availability is an optional statement [3].
- Peer review model (single or double anonymized): not stated on the site [1, 2, 4].
- Time to first decision or acceptance: not stated on the site [1].
- APC in USD: not stated; the price list gives the APC in EUR only [7].

## Table row

```
scope_5_words: statistical methods for omics data
audience: both
fit_critique: good
fit_sim_diagnostic: good
fit_constructive: good
fit_short_note: possible
fit_theory: possible
fit_applied: possible
abstract_format: unstructured (no headings stated)
abstract_words: 200
length_limit: not stated (software notes 4 typeset pages)
apc: none required (open access EUR 2,700)
oa_model: hybrid
ai_policy_3_words: declare in template
review_model: not stated
guidelines_read: yes
```
