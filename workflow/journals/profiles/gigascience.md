# GigaScience

| Field | Value |
|-----------------|--------------------------------------------------------------|
| Publisher | GigaScience Press (the open access publishing division of BGI) with Oxford University Press [7] |
| Online ISSN | 2047-217X [1, 7] |
| Profile written | 2026-10-27 |

## Sources

Every page below was read on the date shown. Bracketed numbers in the text point here.

1. [GigaScience: Instructions to Authors](https://academic.oup.com/gigascience/pages/instructions_to_authors), read 2026-10-27.
2. [GigaScience: Research article instructions](https://academic.oup.com/gigascience/pages/research), read 2026-10-27.
3. [GigaScience: Technical Note instructions](https://academic.oup.com/gigascience/pages/technical_note), read 2026-10-27.
4. [GigaScience: Brief Communication instructions](https://academic.oup.com/gigascience/pages/brief-communication), read 2026-10-27.
5. [GigaScience: Editorial Policies and Reporting Standards](https://academic.oup.com/gigascience/pages/editorial_policies_and_reporting_standards), read 2026-10-27.
6. [GigaScience: Charges, Licensing and Self-Archiving](https://academic.oup.com/gigascience/pages/charges_licensing_and_self_archiving), read 2026-10-27.
7. [GigaScience: About](https://academic.oup.com/gigascience/pages/About), read 2026-10-27.
8. [OUP: Policy on AI Use and Disclosure for OUP Journals Authors](https://academic.oup.com/pages/for-authors/journals/preparing-and-submitting-your-manuscript/ai-principles-for-oxford-journals/policy-on-ai-use-and-disclosure-for-oxford-journals-authors), read 2026-10-27.
9. [Crossref REST API record lookups for the DOIs under "Recent papers like ours"](https://api.crossref.org/works), read 2026-10-27.
10. [OUP: Charges, licences, and self-archiving](https://academic.oup.com/pages/open-research/open-access/charges-licences-and-self-archiving), read 2026-10-27 through Claude in Chrome (the "What is the OA charge for my article?" calculator, with no Low and Middle Income Countries discount and no society membership selected).

## Scope

> "GigaScience is GigaScience Press' and OUP's flagship Open Science journal." [1] "GigaScience's scope covers 'big data' research from the life and biomedical sciences." [2]

GigaScience publishes large-scale life-science data work and judges papers on "reproducibility, usability and utility" rather than impact [1]. It is the strictest of these journals on openness: data must be available to reviewers before review starts, code must be in a public repository under an open licence, and anonymous reviewer reports are published with the paper [2, 5]. A critique fits as a Technical Note (a method "tested and compared with existing tools" [3]) or as a Research article if it rests on a large real dataset; theory has no home here.

| Paper type | Fit | Why |
|--------------------------------------------|----------|------------------------------------------------|
| Critique with a closed-form bias, simulation, fix, and application | possible | A Technical Note on an open-source corrected method compared with existing tools fits, but the closed-form derivation is not what the journal emphasizes. |
| Simulation and diagnostic, no closed form | possible | A diagnostic tool shipped as open software, tested against existing tools, can be a Technical Note [3]. |
| Constructive method with theory, simulation, comparison, and application | possible | A Technical Note takes a method "tested and compared with existing tools" [3], but the journal judges reproducibility, usability, and utility [1], not a method's theoretical properties. |
| Short methods note | possible | Brief Communications take concise observations in 1,500 words and up to 2 figures [4]. |
| Theory paper | poor | The scope is big-data research, judged on reproducibility and usability. |
| Applied analysis | possible | Research articles "present work utilising large scale data that provide some scientific insight and conclusions" [2]; a lupus RNA-seq reanalysis would need to be large scale. |

## Article types that fit

| Article type | Length | Figures and tables | References | Source |
|-------------------|--------------------------|---------------------|-------------|--------|
| Research | not stated on the site | not stated on the site | not stated on the site | [2] |
| Technical Note | not stated on the site; no maximum for the Findings section | not stated on the site | not stated on the site | [3] |
| Brief Communication | 1,500 words of main text, figures and legends excluded | up to 2 figures; tables not stated | up to 10 (stated in the past tense) | [4] |

## Abstract

- Structured: yes for Research and Technical Notes [2, 3].
- Headings: Research: Background, Results, Conclusions [2]. Technical Note: Background, Findings, Conclusions [3]. Brief Communication: not stated on the site [4].
- Word limit: "250 words maximum," with no citations [2, 3]. A graphical abstract may be added [1].

## Reference style

- The journal's stated style: "All references, including URLs, must be numbered consecutively, in square brackets" in order of citation, with journal abbreviations following Index Medicus/MEDLINE [1].
- CSL file: `gigascience.csl` in the official styles repository (github.com/citation-style-language/styles, commit d2cc420, 2026-10-24), an independent style.
- File to use in Quarto: `csl/gigascience.csl`.
- Rendering test: passed on 2026-10-27 (`csl/test-results.md`).

## Supplement, code, and data

- Supplementary material: each file name must include "supplementary material"; additional files are numbered and at most 20 MB each [1].
- Data availability statement: required for all papers, naming the repository and a persistent identifier; code snapshots are cited there [1, 2]. Data must be available to reviewers at submission: "all data should be made available to the journal for the purpose of peer review" [5], and after initial editorial assessment GigaDB curators help authors make it available [2, 3]. On publication data must be reusable under CC0 [2, 5].
- Code: required in a public repository by review. "GigaScience requires that source-code from software/papers with supporting code be made openly available in a trusted code repository" under an OSI-approved licence where practicable, with an "Availability and requirements" section [1]. For Technical Notes, code, test data, and documentation for a defined version must be in a recognized repository (GitHub, DockerHub, Code Ocean), and "Submissions that do not meet these requirements will be rejected without review" [3]; a snapshot can be archived in GigaDB or Software Heritage with a DOI at acceptance [3]. In-house editorial and curation teams check data and code; machine learning analyses must at least be reproducible [5].

## AI-use policy

> "Use of generative AI-writing tools such as ChatGPT is allowed as long as it is disclosed in a transparent manner and does not negatively affect empirical data and conclusions." [5]

> "A summary of use (particularly in the introduction or among methods) needs to be included at the end of the paper, and the outputs should also be included as a supplementary file hosted in GigaDB or other open repositories." [5]

> "Authors should not list AI-writing tools and other AI-assisted technologies as an author or co-author." [5]

The instructions add that AI tools must be cited in the references with version, model, date of use, and user, and that "Authors are forbidden to use AI- Assisted Technology such as generative AI to create or modify figures" [1]. Authors remain "fully responsible for text generated or refined by AI-writing tools" [5]. The journal's own policy is more specific than OUP's publisher-wide policy [8], which defers to journal rules where they differ.

- Read at: https://academic.oup.com/gigascience/pages/editorial_policies_and_reporting_standards and https://academic.oup.com/gigascience/pages/instructions_to_authors, 2026-10-27.
- What the manuscript must do: cite any AI writing tool in the text and references, put a summary of AI use at the end of the paper, deposit the AI outputs as a supplementary file in GigaDB or another open repository, and use no AI to make or alter figures.

## Open access and charges

- Model: fully open access, funded by an article processing charge [6].
- Article processing charge: USD 2,895 for a Research article, from OUP's charge calculator with no discount selected; prices exclude sales taxes and are "subject to change" [10]. The journal's own charges page shows only an interactive calculator [6].
- Waivers and institutional agreements: a Low and Middle Income Countries discount applied before other discounts, a 20% society membership discount line, and Read and Publish agreements when the qualifying institution is the primary affiliation at submission [6].

## Review

- Model: single anonymized, at least two reviewers; if the paper is accepted, "the anonymous reviewers' comments are published online alongside the article as part of a 'pre-publication history'" [5, 7].
- Time to decision: not stated on the site [5, 7].

## Recent papers like ours

1. Spisak T (2022). Statistical quantification of confounding bias in machine learning models. *GigaScience* 11, giac082. https://doi.org/10.1093/gigascience/giac082. Proposes a test for confounding bias with type I error control, checked by simulation and applied to real data, a statistical diagnostic paper of our kind [9].
2. Yang X, Liu W, Mao Z, Du Y, Lassiter C, Alakwaa FM, Benny PA, Garmire LX (2026). Cord blood DNA methylation and cell-type composition are not significantly associated with severe preeclampsia after cell-type and clinical covariate adjustment. *GigaScience* 15, giag002. https://doi.org/10.1093/gigascience/giag002. Shows earlier associations vanish after cell-composition adjustment, close to our composition-adjustment work [9].
3. Garach Vélez I, Ortuño Guzmán FM, Rojas Ruiz I, Herrera Maldonado LJ (2025). Exploring the role of normalization and feature selection in microbiome disease classification pipelines. *GigaScience* 14, giaf096. https://doi.org/10.1093/gigascience/giaf096. A systematic evaluation of widely used preprocessing choices across many datasets, like our simulation and diagnostic papers [9].

## Not stated on the site, or could not be read

- Length, figure, and reference limits for Research and Technical Notes: not stated on [2] or [3].
- Brief Communication abstract: not stated on [4].
- Time to decision: not stated on [5] or [7].

## Table row

```
scope_5_words: open, reproducible big-data life science
audience: genomics users
fit_critique: possible
fit_sim_diagnostic: possible
fit_constructive: possible
fit_short_note: possible
fit_theory: poor
fit_applied: possible
abstract_format: structured: Background, Results, Conclusions
abstract_words: 250
length_limit: Research, not stated; Brief Communication, 1,500 words
apc: USD 2,895
oa_model: open access
ai_policy_3_words: disclose, summarize, deposit
review_model: single
guidelines_read: partly
```
