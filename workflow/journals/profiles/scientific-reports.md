# Scientific Reports

| Field | Value |
|-----------------|--------------------------------------------------------------|
| Publisher | Springer Nature (Nature Portfolio); no society |
| Online ISSN | 2045-2322 |
| Profile written | 2026-10-27 |

## Sources

Every page below was read on the date shown. Bracketed numbers in the text point here.

1. [Aims and scope](https://www.nature.com/srep/about/aims), read 2026-10-27.
2. [Journal home page (ISSN, collections timing)](https://www.nature.com/srep/), read 2026-10-27.
3. [About Scientific Reports](https://www.nature.com/srep/about), read 2026-10-27.
4. [Editorial process](https://www.nature.com/srep/about/editorial-process), read 2026-10-27.
5. [Submission guidelines](https://www.nature.com/srep/author-instructions/submission-guidelines), read 2026-10-27.
6. [Checklist for initial submissions (PDF, linked from "Ready to submit")](https://www.nature.com/documents/srep-checklist-for-initial-submissions.pdf), read 2026-10-27.
7. [Journal policies: editorial policies (data, code)](https://www.nature.com/srep/journal-policies/editorial-policies), read 2026-10-27.
8. [Journal policies: artificial intelligence](https://www.nature.com/srep/journal-policies/ai), read 2026-10-27.
9. [Journal policies: peer review](https://www.nature.com/srep/journal-policies/peer-review), read 2026-10-27.
10. [Open access fees and funding](https://www.nature.com/srep/open-access), read 2026-10-27.
11. [Springer Nature: AI use in manuscript preparation (publisher-wide; linked from source 8)](https://www.springernature.com/gp/policies/editorial-policies/ai-manuscript-preparation), read 2026-10-27.

## Scope

> "We publish original research from all areas of the natural sciences, psychology, medicine and engineering." [1]

In plain terms, this is a very large, broad, open access journal that accepts any technically sound paper; editors and reviewers judge "the robustness and validity of your research" rather than its likely impact [4]. Readers are general scientists, so a genomics methods paper will reach fewer specialists than in a bioinformatics journal, but the bar for novelty is lower and short papers are welcome. It is a reasonable home for our applied analyses, short notes, and simulation studies; critiques can go here when a specialist journal declines.

| Paper type | Fit | Why |
|--------------------------------------------|----------|------------------------------------------------|
| Critique with a closed-form bias, simulation, fix, and application | possible | Sound methods papers are accepted [4], and a PERMANOVA-based evaluation with simulated and real data appeared here (paper 2 below), but the audience is general. |
| Simulation and diagnostic, no closed form | possible | Validity, not novelty, is the criterion [4], so a well-designed simulation study qualifies; it may get less attention from specialists. |
| Constructive method with theory, simulation, comparison, and application | possible | Validity, not novelty, is the criterion [4], so a sound new method can be published, but statistics is not a listed subject area [1] and the readers are general scientists. |
| Short methods note | good | Word limits are recommendations, and the journal suggests at most 4 display items for articles of 2,000 words or less [5], so short articles are normal. |
| Theory paper | poor | Mathematics and statistics are not among the listed subject areas [1]. |
| Applied analysis | good | Original research in biology and health sciences is the journal's core content [1], [3]. |

## Article types that fit

| Article type | Length | Figures and tables | References | Source |
|-------------------|--------------------------|---------------------|-------------|--------|
| Article | main text recommended at most 4,500 words (excluding Abstract, Methods, References, and figure legends); ideally at most 11 typeset pages; "we do not impose strict limits" | at most 8 display items; for 2,000 words or less, no more than 4 suggested; legends at most 350 words | "limited to 60 references, though not strictly enforced" | [5] |

## Abstract

- Structured: no; "Abstract should be unstructured, i.e. should not contain sections or subheadings." [5], [6]
- Headings: none. No references or figures in the abstract; it should serve as a general introduction and a brief, non-technical summary [5].
- Word limit: 200 (recommended) [5]

## Reference style

- The journal's stated style: "standard Nature referencing style", numbered sequentially, one publication per number; list all authors unless there are six or more, then first author followed by "et al." [5]. In-text citations are numbers in square brackets [6]. References are not copy edited, so they must be correct at submission [5].
- CSL file: `dependent/scientific-reports.csl` in the official styles repository (github.com/citation-style-language/styles, commit d2cc420, 2026-10-24), a dependent style whose parent is `nature-brackets.csl`.
- File to use in Quarto: `csl/nature-brackets.csl`, which renders offline. The journal-named `csl/dependent/scientific-reports.csl` gives the same output but needs a network connection, because pandoc fetches the parent at render time.
- Rendering test: both files passed on 2026-10-27 (`csl/test-results.md`).

## Supplement, code, and data

- Supplementary material: one combined Supplementary Information file, preferably PDF, submitted with the manuscript; not edited or typeset; no appendices in the main text [5].
- Data availability statement: mandatory, as a "Data Availability" section at the end of the main text before References [5], [6]. "Supporting data must be made available to Editorial Board Members and referees at the time of submission" [7].
- Code: authors "must provide any previously unreported custom computer code or algorithm used to generate results upon editor or reviewer request" and the Methods must include a "Code availability" statement [7]. A public repository is not required: the journal will publish the code as a Supplementary document or, when applicable, ask that it be kept in a version control repository [7]. No reproducibility review is stated on the site.

## AI-use policy

> "Large Language Models (LLMs), such as ChatGPT, do not currently satisfy our authorship criteria." [5]

> "Use of an LLM should be properly documented in the Methods section (and if a Methods section is not available, in a suitable alternative part) of the manuscript." [5]

> "Specific disclosure should be provided within the caption or legend of the visual content." [11]

The journal's AI page reproduces the Springer Nature risk framework: language polishing is permitted and disclosure is encouraged; suggesting methods, extensive writing support, or explaining model output are permitted with human oversight and disclosure; generating analyses or conclusions presented as human work, fabricating data or citations, or assigning authorship to AI are not permitted [8]. AI images not derived from verifiable data are not permitted [11].

- Read at: https://www.nature.com/srep/journal-policies/ai and https://www.nature.com/srep/author-instructions/submission-guidelines, 2026-10-27.
- What the manuscript must do: describe in the Methods section which AI tools were used and for what, state that the authors checked the output and take responsibility, and label any AI-assisted figure in its legend.

## Open access and charges

- Model: fully open access [10]
- Article processing charge: US$2,850 (also £2,290 and €2,490), subject to VAT or local taxes, set by the acceptance date; read 2026-10-27 [10]
- Waivers and institutional agreements: Springer Nature waivers for authors in the lowest-income countries; discretionary waivers for financial need must be requested at submission; institutional open access agreements may cover the charge [10]

## Review

- Model: reviewers are anonymous to authors: "By policy, referees are not identified to the authors, except at the request of the referee." [9] Author names appear on the manuscript title page [5], so this works as single anonymized review, although the site does not use that term. Publication of reviewer reports is not stated on the site.
- Time to decision: "We aim to make our first decisions on your manuscript within 45 days of submission." [4] This is a target, not a measured figure. The home page gives a median of 102 days from submission to acceptance for papers in Guest Edited Collections only [2]. No journal-wide measured figure is stated.

## Recent papers like ours

1. O'Connell GC (2023). Variability in donor leukocyte counts confound the use of common RNA sequencing data normalization strategies in transcriptomic biomarker studies performed with whole blood. *Scientific Reports* 13:15514. https://doi.org/10.1038/s41598-023-41443-4. It shows that standard normalizations assume similar transcriptome composition and are confounded by cell counts in blood, a cell-composition critique of routine practice checked against flow cytometry truth.
2. Horng H, Scott C, Winham S, Jensen M, Pantalone L, Mankowski W, Kerlikowske K, Vachon CM, Kontos D, Shinohara RT (2024). Multivariate testing and effect size measures for batch effect evaluation in radiomic features. *Scientific Reports* 14:13923. https://doi.org/10.1038/s41598-024-64208-z. It evaluates PERMANOVA and a robust effect size for detecting batch effects in simulated and real data, the same distance-based test we studies.
3. Wang B, Sun F, Luan Y (2024). Comparison of the effectiveness of different normalization methods for metagenomic cross-study phenotype prediction under heterogeneity. *Scientific Reports* 14:7024. https://doi.org/10.1038/s41598-024-57670-2. A systematic evaluation of widely used normalization choices for microbiome data under population, disease, and batch heterogeneity, the evaluation-of-common-practice type of paper in our microbiome-adjacent area.

All three DOIs, titles, authors, years, and journal names were confirmed against Crossref and PubMed on 2026-10-27.

## Not stated on the site, or could not be read

- Whether reviewer reports are published (transparent review): not stated on the site (sources 4, 7, and 9).
- A measured journal-wide time to first decision: not stated on the site (sources 2, 3, and 4); the URL `https://www.nature.com/srep/journal-impact` redirects to the About page, which lists citation metrics only.
- Which length limits are mandatory: the guidelines point to the submission checklist [5], and the checklist lists no word or page limit [6].

## Table row

```
scope_5_words: sound research across all sciences
audience: general science
fit_critique: possible
fit_sim_diagnostic: possible
fit_constructive: possible
fit_short_note: good
fit_theory: poor
fit_applied: good
abstract_format: unstructured
abstract_words: 200
length_limit: Article: 4,500 words main text (recommended)
apc: USD 2,850
oa_model: open access
ai_policy_3_words: disclose, no authorship
review_model: single
guidelines_read: yes
```
