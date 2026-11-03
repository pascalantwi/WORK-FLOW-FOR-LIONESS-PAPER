# Biostatistics

| Field | Value |
|-----------------|--------------------------------------------------------------|
| Publisher | Oxford University Press |
| Online ISSN | 1468-4357 [3] |
| Profile written | 2026-10-27 |

## Sources

Every page below was read on the date shown. Bracketed numbers in the text point here.

1. [General Instructions (author guidelines), Biostatistics](https://academic.oup.com/biostatistics/pages/General_Instructions), read 2026-10-27.
2. [Author guidelines, Biostatistics](https://academic.oup.com/biostatistics/pages/author-guidelines), read 2026-10-27.
3. [About the journal, Biostatistics](https://academic.oup.com/biostatistics/pages/About), read 2026-10-27.
4. [Editorial Board, Biostatistics](https://academic.oup.com/biostatistics/pages/Editorial_Board), read 2026-10-27.
5. [Charges, licences, and self-archiving, Oxford Academic](https://academic.oup.com/pages/open-research/open-access/charges-licences-and-self-archiving), read 2026-10-27; its "What is the OA charge for my article?" calculator read 2026-10-27 through Claude in Chrome, with no Low and Middle Income Countries discount and no society membership selected.
6. [APC waiver and discount policy, Oxford Academic](https://academic.oup.com/pages/open-research/open-access/charges-licences-and-self-archiving/apc-waiver-policy), read 2026-10-27.
7. Crossref REST API records (`https://api.crossref.org/works/<DOI>`) for the papers under "Recent papers like ours", read 2026-10-27.

## Scope

> "The objective of Biostatistics is to advance statistical science and its application to problems of human health and disease, with the ultimate goal of advancing the public's health." [3]

Biostatistics publishes new statistical methods motivated by health and biomedical questions; the guidelines say papers "should focus on methods and applications" [1]. Its readers are methodologists in biostatistics, many of them working on genomics, and recent volumes carry several papers that show a common genomics workflow gives biased or invalid results and then fix it. Our main critique paper fits well. A short note fits the journal's Notes category, which is reserved for "good biostatistical practice" [1]. Pure theory and plain applied analyses do not fit.

| Paper type | Fit | Why |
|--------------------------------------------|----------|------------------------------------------------|
| Critique with a closed-form bias, simulation, fix, and application | good | The journal publishes method papers that expose bias in widely used genomics pipelines and correct it (see the papers below). |
| Simulation and diagnostic, no closed form | possible | Welcome if the diagnostic is framed as a new method; the guidelines ask for innovative methods, not comparisons alone. |
| Constructive method with theory, simulation, comparison, and application | good | New methods with applications are what the guidelines ask for [1], and the readers are biostatisticians, many of them working on genomics. |
| Short methods note | possible | Notes are short papers "on topics related to good biostatistical practice" [1], which suits a focused warning about a common procedure. |
| Theory paper | poor | The guidelines ask papers to "focus on methods and applications" [1]. |
| Applied analysis | poor | The journal publishes methods; an analysis with existing tools has no stated home. |

## Article types that fit

| Article type | Length | Figures and tables | References | Source |
|-------------------|--------------------------|---------------------|-------------|--------|
| Research paper | not stated on the site (the guidelines mention "overall length restrictions" without a number) | not stated on the site | not stated on the site | [1, 2] |
| Note | "generally one or two journal pages" | not stated on the site | not stated on the site | [1] |

## Abstract

- Structured: no; the summary "should take the form of a one-paragraph statement of the problem tackled", and simulations and data examples should preferably be mentioned [1]
- Headings: none
- Word limit: not stated on the site; no symbols, no text repeated from the main paper, followed by 5 to 10 keywords [1]

## Reference style

- The journal's stated style: "References and in-text citations can be provided in any consistent format" at first submission [1]. Later, "References and citations must be formatted, meticulously following the journal's conventions", which are author-year in the text (examples in the form Diggle 1998), all authors listed in the reference list, and "et al." in the text for longer author lists [1, 2]. The page points to a "style checklist" but gives no link [1].
- CSL file: `biostatistics.csl` in the official styles repository (github.com/citation-style-language/styles, commit d2cc420, 2026-10-24), an independent style.
- File to use in Quarto: `csl/biostatistics.csl`.
- Rendering test: passed on 2026-10-27 (`csl/test-results.md`).

## Supplement, code, and data

- Supplementary material: encouraged ("Authors are encouraged to present extensive supporting material"); editors may require detailed simulations or technical material as a condition of acceptance; "it is preferable to place all Supplementary Materials in a single file" [1].
- Data availability statement: not stated on the site as a required section. The journal "strongly encourages authors to make all data and software code" available where ethically feasible, and encourages repositories that issue DOIs [1].
- Code: not required. Under the reproducible research policy, papers are kite-marked "D" (data freely available), "C" (code freely available), or "R" (both), and "Data and code are published electronically on the journal's website as Supplementary Materials" [1]. No deadline (submission or acceptance) is stated. The guidelines do not mention an Associate Editor for Reproducibility, and the editorial board page lists no such role [1, 4]; no reproducibility check is described.

## AI-use policy

> "Natural language processing tools driven by artificial intelligence (AI) do not qualify as authors." "The use of AI (for example, to help generate content or images, write code, process data, or for translation) should be disclosed both in cover letters to editors and in the Methods or Acknowledgements section of manuscripts." [1]

- Read at: https://academic.oup.com/biostatistics/pages/General_Instructions, 2026-10-27.
- The page points to the COPE position statement on authorship and AI for details, and says nothing that bans AI-generated images; image generation is listed among uses to disclose [1].
- What the manuscript must do: state the AI use in the cover letter and again in the Methods or Acknowledgements section, naming what the tool did (writing, code, data processing, or images); never list an AI tool as an author.

## Open access and charges

- Model: hybrid; authors choose a standard licence (no charge) or an open access licence (CC BY, CC BY-NC, or CC BY-NC-ND) for a charge [1].
- Article processing charge: two OUP pages differ. The journal's instructions say "Current charge: $3018", excluding applicable sales taxes, payable in other currencies at a rate set at signing [1]. OUP's charge calculator gives USD 3,599 for an Article, with no discount selected; prices exclude sales taxes and are "subject to change" [5]. Both pages were read 2026-10-27.
- Waivers and institutional agreements: OUP Read and Publish agreements may cover the charge for corresponding authors at participating institutions; the corresponding author cannot be changed after submission to use one [1]. OUP's waiver and discount policy applies only to authors "publishing in a fully open access journal" [6], so it does not cover this hybrid journal. The journal has no colour or page charges [1].

## Review

- Model: single anonymized; manuscripts usually go to two reviewers; reviewers interact with editors only [1].
- Time to decision: 2025 median of 7 days from submission to first decision and 7 days from submission to final decision; 48 days from acceptance to publication [3]. The page does not say whether desk rejections are included.

## Recent papers like ours

1. Li T, Zhang Y, Patil P, Johnson WE (2023). Overcoming the impacts of two-step batch effect correction on gene expression estimation and inference. *Biostatistics* 24(3):635 to 652. https://doi.org/10.1093/biostatistics/kxab039. Shows that a standard preprocessing step in gene-expression analysis (two-step batch correction) distorts downstream estimates and tests, derives the induced correlation, and proposes a correction, which is our critique pattern.
2. Neufeld A, Gao LL, Popp J, Battle A, Witten D (2023). Inference after latent variable estimation for single-cell RNA sequencing data. *Biostatistics* 25(1):270 to 287. https://doi.org/10.1093/biostatistics/kxac047. Shows that the common single-cell workflow (cluster or estimate pseudotime, then test genes on the same data) loses Type 1 error control, and supplies a fix (count splitting) with simulations and real data.

## Not stated on the site, or could not be read

- Length limit for research papers: the guidelines refer to "overall length restrictions" and possible "further length reduction" but give no number [1, 2].
- Figure, table, and reference limits: not stated [1, 2].
- Summary word limit: not stated [1, 2].
- Data availability statement: not named as a required section [1, 2].
- Associate Editor for Reproducibility: not mentioned in the guidelines or on the editorial board page [1, 4].
- Style checklist for references: mentioned but not linked [1].
- Unclear: the in-text citation rule for three authors. One sentence lists all authors "when there are one, two, or three authors", the next uses the et al. form "When there are three or more authors" [1].
- Contradictions:
  - Article processing charge: the journal's instructions say "Current charge: $3018" [1], while OUP's charge calculator gives USD 3,599 for an Article [5], both read 2026-10-27.

## Table row

```
scope_5_words: statistical methods for human health
audience: methodologists
fit_critique: good
fit_sim_diagnostic: possible
fit_constructive: good
fit_short_note: possible
fit_theory: poor
fit_applied: poor
abstract_format: unstructured
abstract_words: not stated
length_limit: research paper not stated; Note one or two journal pages
apc: none required (open access USD 3,018 to 3,599, two OUP pages differ)
oa_model: hybrid
ai_policy_3_words: disclose, no authorship
review_model: single
guidelines_read: yes
```
