# Bioinformatics Advances

| Field | Value |
|-----------------|--------------------------------------------------------------|
| Publisher | Oxford University Press, published jointly with the International Society for Computational Biology (ISCB), which owns the journal [2, 3] |
| Online ISSN | 2635-0041 [2] |
| Profile written | 2026-10-27 |

## Sources

Every page below was read on the date shown. Bracketed numbers in the text point here.

1. [Bioinformatics Advances: Author guidelines](https://academic.oup.com/bioinformaticsadvances/pages/author-guidelines), read 2026-10-27.
2. [Bioinformatics Advances: About](https://academic.oup.com/bioinformaticsadvances/pages/About), read 2026-10-27.
3. [ISCB: Journals](https://www.iscb.org/journals), read 2026-10-27.
4. [OUP: Charges, licences, and self-archiving](https://academic.oup.com/pages/open-research/open-access/charges-licences-and-self-archiving), read 2026-10-27; its "What is the OA charge for my article?" calculator read 2026-10-27 through Claude in Chrome, with no Low and Middle Income Countries discount and no society membership selected.
5. [OUP: Policy on AI Use and Disclosure for OUP Journals Authors](https://academic.oup.com/pages/for-authors/journals/preparing-and-submitting-your-manuscript/ai-principles-for-oxford-journals/policy-on-ai-use-and-disclosure-for-oxford-journals-authors), read 2026-10-27.
6. [Crossref REST API record lookups for the DOIs under "Recent papers like ours"](https://api.crossref.org/works), read 2026-10-27.

## Scope

> "Bioinformatics Advances is an interdisciplinary journal on bioinformatics and computational biology. The journal covers bioinformatics methods, such as algorithms, statistics, databases and software" [1]

Bioinformatics Advances is the ISCB's fully open access companion to Bioinformatics, launched in 2021 [3]. It takes methods papers (statistics is named in the scope), software and data notes, and short "Discovery Notes" that report biological findings made with computational methods [1]. Its bar is broader than Bioinformatics', it sends papers to fewer reviewers, and it states firm page and reference limits. All six of our paper types have a plausible slot except pure theory.

| Paper type | Fit | Why |
|--------------------------------------------|----------|------------------------------------------------|
| Critique with a closed-form bias, simulation, fix, and application | good | An Original Article on a statistical method with software fits the stated scope, though the 8-page and 50-reference caps force a tight paper. |
| Simulation and diagnostic, no closed form | good | Methods evaluations fit the scope, and no rule against simulation-only work is stated. |
| Constructive method with theory, simulation, comparison, and application | good | Statistics is named among the methods in scope [1], and an Original Article on a new method with software fits, though the 8-page and 50-reference caps push the theory into the supplement. |
| Short methods note | possible | The Application Note (4 pages) is the short format, but it is framed around software or data resources. |
| Theory paper | poor | The scope is applied methods and software; nothing suggests appetite for theory alone. |
| Applied analysis | possible | Discovery Notes take "novel biomedical insights for whose discovery bioinformatics techniques are essential" [1]. |

## Article types that fit

| Article type | Length | Figures and tables | References | Source |
|-------------------|--------------------------|---------------------|-------------|--------|
| Original Article | up to 8 pages; sections Abstract, Introduction, Methods, Discussion, References | at most 6 figures and 6 tables | at most 50 | [1] |
| Application Note | up to 4 pages | at most 3 figures or tables | at most 15 | [1] |
| Discovery Notes | up to 6 pages | at most 5 figures or tables | at most 10 | [1] |

## Abstract

- Structured: not stated on the site [1].
- Headings: none stated.
- Word limit: 200 words for Original Articles, Application Notes, and Discovery Notes [1].

## Reference style

- The journal's stated style: not stated on the site; the guidelines give reference counts and ask that data and software be cited in full in the reference list, but name no format [1].
- CSL file: no file for this journal in the official styles repository (github.com/citation-style-language/styles, commit d2cc420, 2026-10-24). The site names no style, so any consistent style should do; the substitute is the OUP science and medicine author-date style, the parent of the repository's Bioinformatics file.
- File to use in Quarto: `csl/oxford-journals-scimed-author-date.csl`, a substitute chosen by the coordinator, not by the journal.
- Rendering test: `csl/oxford-journals-scimed-author-date.csl` passed on 2026-10-27 (`csl/test-results.md`).

## Supplement, code, and data

- Supplementary material: not described beyond the AI policy's requirement to document AI use in the supplementary materials [1].
- Data availability statement: required; it should say how the data can be accessed, ideally with a link or identifier, and data should be in the manuscript, supporting files, or a public repository [1].
- Code: the journal asks authors, "where ethically possible," "to publicly release all data and software code underlying any published paper as a condition of publication" [1]. Release is therefore required by publication; the page does not say whether a public repository is needed at submission. No reproducibility review is described.

## AI-use policy

> "It is not acceptable to use LLMs or related technologies to draft papers" [1]

> "LLMs cannot be listed as authors as they would not fulfil the requirements of authorship" [1]

> "should be disclosed both in cover letters to editors and in the Methods or Acknowledgements section of manuscripts." [1]

The journal follows the same ISCB acceptable-use policy as Bioinformatics. Any acceptable use of LLMs to produce part of the text, figures, or other content "should be explicitly declared and documented with sufficient details in the supplementary materials" [1]. Nothing separate is said about AI-generated images. OUP's publisher-wide policy [5] lets journals add their own requirements, which then take precedence; the journal's page does not link to it.

- Read at: https://academic.oup.com/bioinformaticsadvances/pages/author-guidelines, 2026-10-27.
- What the manuscript must do: disclose AI use in the cover letter and in the Methods or Acknowledgements, document it in the supplement, and confirm the text was written by the authors.

## Open access and charges

- Model: fully open access; the corresponding author pays an open access charge or uses a Read and Publish agreement [1, 2].
- Article processing charge: USD 3,048 for an Original Article, from OUP's charge calculator with no discount selected; prices exclude sales taxes and are "subject to change" [4]. No journal open access page exists (https://academic.oup.com/bioinformaticsadvances/pages/open-access returns 404).
- Waivers and institutional agreements: a Low and Middle Income Countries discount applied before other discounts, and Read and Publish agreements when the qualifying institution is the primary affiliation at submission [1, 4]. ISCB says "ISCB members will enjoy a 20% discount off publishing fees" [3].

## Review

- Model: single anonymized; reviewer reports are not published; manuscripts are "typically sent to one reviewers" [1].
- Time to decision: 2025 median of 37 days from submission to first decision [2].

## Recent papers like ours

1. Vathrakokoili Pournara A, Miao Z, Beker OY, Nolte N, Brazma A, Papatheodorou I (2024). CATD: a reproducible pipeline for selecting cell-type deconvolution methods across tissues. *Bioinformatics Advances* 4, vbae048. https://doi.org/10.1093/bioadv/vbae048. A systematic evaluation of 31 widely used cell-composition methods, close to our composition-adjustment work [6].
2. Li S, Vogtmann E, Graubard BI, Gail MH, Abnet CC, Shi J (2022). fast.adonis: a computationally efficient non-parametric multivariate analysis of microbiome data for large-scale studies. *Bioinformatics Advances* 2, vbac044. https://doi.org/10.1093/bioadv/vbac044. Revisits the adonis implementation of PERMANOVA and adds sampling-weight adjustment, a distance-based permutation test paper like our [6].
3. Karimnezhad A (2022). More accurate estimation of cell composition in bulk expression through robust integration of single-cell information. *Bioinformatics Advances* 2, vbac049. https://doi.org/10.1093/bioadv/vbac049. Argues existing composition estimators ignore covariance structure and offers a corrected estimator, a critique-and-fix pattern [6].

## Not stated on the site, or could not be read

- Abstract structure and headings: not stated on [1].
- Reference style: not stated on [1].
- Whether code must be public at submission: not stated on [1]; only "as a condition of publication."
- Reproducibility review: not stated on the site.

## Table row

```
scope_5_words: open access computational biology methods
audience: both
fit_critique: good
fit_sim_diagnostic: good
fit_constructive: good
fit_short_note: possible
fit_theory: poor
fit_applied: possible
abstract_format: not stated
abstract_words: 200
length_limit: Original Article, 8 pages, 6 figures, 6 tables, 50 references
apc: USD 3,048
oa_model: open access
ai_policy_3_words: disclose, no drafting
review_model: single
guidelines_read: partly
```
