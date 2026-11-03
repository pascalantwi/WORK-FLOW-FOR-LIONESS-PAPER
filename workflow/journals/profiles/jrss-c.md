# Journal of the Royal Statistical Society Series C: Applied Statistics

| Field | Value |
|-----------------|--------------------------------------------------------------|
| Publisher | Oxford University Press, for the Royal Statistical Society (OUP from 1 January 2023) [1, 3] |
| Online ISSN | 1467-9876 [2] |
| Profile written | 2026-10-27 |

## Sources

Every page below was read on the date shown. Bracketed numbers in the text point here.

1. [General Instructions (author guidelines), JRSS Series C](https://academic.oup.com/jrsssc/pages/general-instructions), read 2026-10-27.
2. [About the journal, JRSS Series C](https://academic.oup.com/jrsssc/pages/about), read 2026-10-27.
3. [Change in publisher in 2023, Royal Statistical Society](https://rss.org.uk/news-publication/publications/change-in-publisher-2023/), read 2026-10-27.
4. [Journals, Royal Statistical Society](https://rss.org.uk/news-publication/publications/journals/), read 2026-10-27.
5. [Charges, licences, and self-archiving, Oxford Academic](https://academic.oup.com/pages/open-research/open-access/charges-licences-and-self-archiving), read 2026-10-27; its "What is the OA charge for my article?" calculator read 2026-10-27 through Claude in Chrome, with no Low and Middle Income Countries discount and no society membership selected.
6. [APC waiver and discount policy, Oxford Academic](https://academic.oup.com/pages/open-research/open-access/charges-licences-and-self-archiving/apc-waiver-policy), read 2026-10-27.
7. Crossref REST API records (`https://api.crossref.org/works/<DOI>`) for the papers under "Recent papers like ours", read 2026-10-27.

## Scope

> "Series C seeks to publish papers that tackle genuine problems in applied statistics where applications are central to the paper and provide the motivation for the work presented." [1]

Series C is the Royal Statistical Society's applied journal, read by statisticians who work on real problems in every field (ecology, energy, health, and genomics among them). Its About page sets a firm bar: "Series C papers make a novel contribution to statistics by adapting or developing new statistical methodology", and "Papers that use well-established statistical methods to analyze data are not suitable for JRSS-C" [2]. A critique paper fits only if the lupus or genomics application is the motivation and the paper delivers a new or adapted method (the fix). Genomics papers appear, but they are a small share of the journal.

| Paper type | Fit | Why |
|--------------------------------------------|----------|------------------------------------------------|
| Critique with a closed-form bias, simulation, fix, and application | possible | Fits if the real-data problem drives the paper and the fix is presented as new methodology [1, 2]. |
| Simulation and diagnostic, no closed form | possible | A new diagnostic motivated by a real application qualifies; a simulation comparison alone does not [2]. |
| Constructive method with theory, simulation, comparison, and application | possible | Developing new statistical methodology is what the journal asks for [2], but only when the application is central and motivates the work [1]. |
| Short methods note | possible | The guidelines say "Short communications may also be appropriate" but give no length or format [1]. |
| Theory paper | poor | Applications must be central and motivate the work [1]. |
| Applied analysis | poor | "Papers that use well-established statistical methods to analyze data are not suitable" [2]. |

## Article types that fit

| Article type | Length | Figures and tables | References | Source |
|-------------------|--------------------------|---------------------|-------------|--------|
| Contributed paper | "manuscripts that are longer than 24 journal pages are unlikely to be accepted for publication" | not stated on the site | not stated on the site | [1] |
| Short communication | not stated on the site | not stated on the site | not stated on the site | [1] |

## Abstract

- Structured: not stated on the site; no headings are prescribed [1]
- Headings: none
- Word limit: "Abstracts have a maximum length of 200 words"; no citations or abbreviations in the abstract; five or six keywords in alphabetical order [1]

## Reference style

- The journal's stated style: "You may format references in any readable style at submission." For LaTeX, "please use modern, medium, single column, numbered headings, and author-year references" (the OUP template) [1].
- CSL file: `journal-of-the-royal-statistical-society.csl` in the official styles repository (github.com/citation-style-language/styles, commit d2cc420, 2026-10-24), an independent style. The file covers all series of the journal.
- File to use in Quarto: `csl/journal-of-the-royal-statistical-society.csl`.
- Rendering test: passed on 2026-10-27 (`csl/test-results.md`).

## Supplement, code, and data

- Supplementary material: "Supplementary material will be available online only and will not be copyedited or typeset"; files no larger than 2 MB each [1].
- Data availability statement: required. "Authors must include a Data Availability Statement in their published article", as a separate section before the Acknowledgements; datasets or code with a DOI are cited in the text and the reference list [1]. Data must be made available to editors and reviewers on request, and data that cannot be released "must be justified clearly at the time of submission" [1].
- Code: "Source code for any specialized, in-house scripts or programs, that are necessary for the reproduction of results, must be deposited in a public repository (e.g., GitHub), or uploaded as Supplementary material" [1]. Published papers should say where the data and code can be found [1]. The page does not say whether this is due at submission or at acceptance, and describes no reproducibility check.

## AI-use policy

> "The use of AI (for example, to help generate content or images, write code, process data, or for translation) must be disclosed both in cover letters to editors and in the Methods or Acknowledgements section of manuscripts." [1]

- AI tools "do not qualify as authors, and OUP will screen for them in author lists" [1]. Nothing specific on AI-generated images beyond the disclosure sentence.
- Read at: https://academic.oup.com/jrsssc/pages/general-instructions, 2026-10-27.
- What the manuscript must do: disclose the AI use in the cover letter and in the Methods or Acknowledgements section, saying what the tool did; never list an AI tool as an author.

## Open access and charges

- Model: hybrid; open access under a Creative Commons licence is optional and "There is a charge to publish under an open access licence" [1].
- Article processing charge: not stated on the journal's pages [1, 2] or the society's pages [3, 4]. For the open access option, OUP's charge calculator gives GBP 2,945 for an Original Article, with no discount selected and only GBP shown; prices exclude sales taxes and are "subject to change" [5]. The journal does charge "£50 per printed colour image", exclusive of VAT [1].
- Waivers and institutional agreements: Read and Publish agreements may cover the charge for eligible institutions [1]. OUP's waiver policy applies only to fully open access journals [6], so it does not cover Series C. No RSS member discount is stated [1, 3, 4].

## Review

- Model: single anonymized ("This journal uses single blind peer review") [1].
- Time to decision: not stated on the site [1, 2].

## Recent papers like ours

1. Neuvial P, Randriamihamison N, Chavent M, Foissac S, Vialaneix N (2024). A two-sample tree-based test for hierarchically organized genomic signals. *JRSS Series C* 73(3):774 to 795. https://doi.org/10.1093/jrsssc/qlae011. A distance-based two-sample test for genomic matrices (Hi-C), validated by simulation and applied to real data, close to our PERMANOVA-type work.
2. Bodinier B, Filippi S, Nøst TH, Chiquet J, Chadeau-Hyam M (2023). Automated calibration for stability selection in penalised regression and graphical models. *JRSS Series C* 72(5):1375 to 1393. https://doi.org/10.1093/jrsssc/qlad058. Revisits how a widely used tool (stability selection for graphical models) is calibrated, fixes it, and applies it to transcriptomic and epigenetic networks with an R package.
3. Momal R, Robin S, Ambroise C (2021). Accounting for Missing Actors in Interaction Network Inference from Abundance Data. *JRSS Series C* 70(5):1230 to 1258. https://doi.org/10.1111/rssc.12509. Shows that unobserved variables create apparent edges in network inference from count data and corrects for them, the same "what does this edge really mean" question we asks.

## Not stated on the site, or could not be read

- Figure, table, and reference limits: not stated [1].
- Length or format of short communications: not stated [1].
- Abstract structure: not stated [1].
- When code must be deposited (submission or acceptance): not stated [1].
- Time to decision: not stated [1, 2].

## Table row

```
scope_5_words: applied problems motivating new methods
audience: methodologists
fit_critique: possible
fit_sim_diagnostic: possible
fit_constructive: possible
fit_short_note: possible
fit_theory: poor
fit_applied: poor
abstract_format: unstructured
abstract_words: 200
length_limit: contributed paper 24 journal pages
apc: none required (open access GBP 2,945)
oa_model: hybrid
ai_policy_3_words: disclose, no authorship
review_model: single
guidelines_read: partly
```
