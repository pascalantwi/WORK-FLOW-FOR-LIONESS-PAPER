# PeerJ

| Field | Value |
|-----------------|--------------------------------------------------------------|
| Publisher | PeerJ, part of Taylor & Francis Group (Informa PLC); no society |
| Online ISSN | 2167-8359 |
| Profile written | 2026-10-27 |

The journal formerly called PeerJ Life & Environment is now titled simply PeerJ [1]. Its author pages are still on peerj.com under `/journals/peerj/` (old `/about/` URLs redirect there); the site footer says "PeerJ is part of Taylor & Francis Group" [1]. WebFetch got HTTP 403 from peerj.com, so every page below was read in the built-in browser; no bot check appeared.

## Sources

Every page below was read on the date shown. Bracketed numbers in the text point here.

1. [PeerJ aims and scope (scope, article types, evaluation criteria, metrics, ISSN)](https://peerj.com/journals/peerj/aims-and-scope/), read 2026-10-27.
2. [Author instructions (sections, abstract, references, supplemental files, data and code repositories)](https://peerj.com/journals/peerj/author-instructions/), read 2026-10-27.
3. [Policies and procedures (data and code sharing, peer review, generative AI, fees and waivers, discipline standards, critique submissions)](https://peerj.com/journals/peerj/policies/), read 2026-10-27.
4. [Pricing (APC, memberships, time to first decision)](https://peerj.com/pricing/), read 2026-10-27.

## Scope

> "PeerJ evaluates articles based on objective criteria of scientific and methodological soundness, rather than subjective judgments of impact, novelty, or interest." [1]

In plain terms, PeerJ is a broad open access journal across biology, medicine, environmental science, chemistry, and engineering [1] that, like PLOS ONE, judges soundness and not importance. Reviewers score three things: basic reporting, experimental design, and validity of the findings [1]. Two policies matter for us. First, PeerJ has an explicit route for critiques: submissions that "critique or reanalyze a previously published article" are considered if they include "a substantial reanalysis of existing data or the presentation of new data," and the critiqued party is invited to review non-anonymously alongside at least two other reviewers [3]. Second, bioinformatics studies of public data (GEO, TCGA, and similar) must "Address a new biological question or reach a different conclusion than the original study" and validate findings with at least two of: independent public datasets, new clinical data, or new experimental data [3]. Readers are mostly life and environmental scientists who use methods rather than develop them.

| Paper type | Fit | Why |
|--------------------------------------------|----------|------------------------------------------------|
| Critique with a closed-form bias, simulation, fix, and application | good | Soundness-only review [1] and a stated critique-submission route [3] suit a paper showing a popular method's target differs from what users assume. |
| Simulation and diagnostic, no closed form | good | Method Papers must compare with existing approaches and quantify improvements [3], and simulation-based method evaluations appear (paper 1 below). |
| Constructive method with theory, simulation, comparison, and application | possible | Method Papers must compare with existing approaches and quantify the improvement [3], which this paper does, but the readers mostly use methods rather than evaluate them. |
| Short methods note | possible | There is no short format, but no word limit either; short R-package method papers appear (paper 3 below), and Bioinformatics Software Tools are a listed type [1]. |
| Theory paper | poor | Hypothesis papers are not published [1], and the review criteria center on experimental design and data [1]. |
| Applied analysis | possible | Research Articles are the main type [1], but an analysis of public data needs validation in at least two independent sources [3]. |

## Article types that fit

| Article type | Length | Figures and tables | References | Source |
|-------------------|--------------------------|---------------------|-------------|--------|
| Research Article | not stated on the site; a typeset PDF over 35 pages carries an extra service charge | no number limit; each table must fit one 8.5 by 11 inch page | not stated on the site | [1], [2] |
| Method Article (Method Paper) | not stated on the site | not stated on the site | not stated on the site | [1], [3] |
| Bioinformatics Software Tool (for the R package) | not stated on the site; package must include a script that reproduces the paper's results | not stated on the site | not stated on the site | [1], [3] |

## Abstract

- Structured: yes; "Subheadings must be bold, followed by a period, and start a new paragraph," with the example "Background." [2]
- Headings: not listed by name; the abstract must give the reason for the work, methodology, results, and conclusions [2], so Background, Methods, Results, Conclusions is the natural reading
- Word limit: 500 words (3,000 characters) [2]

## Reference style

- The journal's stated style: any full and consistent style at submission: "Submit your references in whatever style you like. Just make sure they're full, clear, and consistent and we'll standardize at production." [2] The house style is author-year: in-text "Smith, Jones & Johnson, 2004" for up to three authors and "Smith et al., 2005" for four or more; the list is sorted by author, year, title, with DOIs; a PeerJ Zotero style is offered [2].
- CSL file: `peerj.csl` in the official styles repository (github.com/citation-style-language/styles, commit d2cc420, 2026-10-24), an independent style. The journal accepts any consistent style at submission and restyles in production.
- File to use in Quarto: `csl/peerj.csl`.
- Rendering test: passed on 2026-10-27 (`csl/test-results.md`).

## Supplement, code, and data

- Supplementary material: named "Supplemental [Item] S[number]"; at most 50 MB total and 30 MB per file; larger material goes to a public repository with a DOI; review-only files are allowed [2].
- Data availability statement: not stated on the site as a separately named statement; instead "authors must make all materials, code, data, and associated protocols available at the time of submission," with accession numbers or identifiers included in the manuscript [3].
- Code: required at submission. "All code and raw data required to reproduce results must be made available either: In a repository such as GitHub or GitLab (with a DOI, e.g., via Zenodo), or As supplementary files published with the article" [3]. Google Drive, Dropbox, or OneDrive may be used for review only, then moved to a persistent repository on acceptance [2]. Software tools must be open source (MIT, GPL) and public, with unit tests recommended [3]. No formal reproducibility review is stated.

## AI-use policy

> "You must not list AI tools as a co-author of your article." "You must clearly acknowledge within your article use of Generative AI tools. Please add a statement in the Methods or Acknowledgments section" [3]

- The statement must give the tool's full name with version number, how it was used, and the reason for use [3].
- Copyediting and language refinement with AI are permitted, but the submission must include a declaration that the authors confirmed accuracy, name the tool and version, confirm they checked its terms of use, and take full responsibility; original and revised versions must be kept for the editor [3].
- Images: "We do not permit the use of Generative AI in the manipulation of images and figures, or original research data" [3]. AI help with data visualizations is allowed with retained prompts, a declaration, and a figure-legend statement naming the tool and version [3].
- The PeerJ policy page links to the Taylor & Francis AI policy for more detail [3]; that page was not read.
- Read at: https://peerj.com/journals/peerj/policies/, 2026-10-27.
- What the manuscript must do: put a statement in the Methods or Acknowledgments giving each AI tool's full name and version, how it was used, and why, and add the submission declaration if AI was used for language editing.

## Open access and charges

- Model: fully open access, CC BY [3], [4]
- Article processing charge: USD 2,155 plus local taxes, read 2026-10-27 [4]. Lifetime individual memberships are an alternative (Basic USD 755, Enhanced USD 865, Premium USD 970, plus taxes), but every author up to the first twelve then needs one [3], [4].
- Waivers and institutional agreements: authors from World Bank low-income economies may request a membership waiver for one publication per submitting author per year, or full waiver if all co-authors qualify; undergraduate co-authors may request a one-time waiver; waivers are requested in the "Confidential Notes to Staff" field at submission; Annual Institutional Memberships can cover APCs [3], [4].

## Review

- Model: single anonymized, with mandatory published peer review history: "Manuscripts deemed suitable for further consideration are subject to single-anonymized peer review" [3]. Full reviewer reports, the original submission, and decision letters and rebuttals are published with the article; reviewer names appear only if reviewers choose [3]. Opting out was possible only for submissions before 13 February 2023 [3].
- Time to decision: "30-35 Days to First Decision" (pricing page) [4]; 32 days from acceptance to publication and a 25% acceptance rate (aims page, period not stated) [1].

## Recent papers like ours

1. Yang T, Qin Y, Yan S, Guo S, Sun J, Huang J, Li J, Zhou Q, Jin X, Wang WJ (2025). Comprehensive evaluation of methods for identifying tissues or cell types of origin of the plasma cell-free transcriptome. *PeerJ*. https://doi.org/10.7717/peerj.19241. Evaluates seven deconvolution methods on simulated and real data, close to our cell-composition work.
2. Xu Z, MacIntosh AJ, Castellano-Navarro A, Macanás-Martínez E, Suzumura T, Duboscq J (2022). Linking parasitism to network centrality and the impact of sampling bias in its interpretation. *PeerJ*. https://doi.org/10.7717/peerj.14305. Uses knock-out simulations on real data to show how incomplete sampling distorts network-metric associations, the critique-by-simulation pattern.
3. Camargo A (2022). PCAtest: testing the statistical significance of Principal Component Analysis in R. *PeerJ*. https://doi.org/10.7717/peerj.12967. A short permutation-based method paper shipped as an R package, a model for our short methods note.

## Not stated on the site, or could not be read

- Word or page limits for Research Articles and Method Papers: not stated on the site (only the 35-page surcharge) [2].
- Figure-number and reference-number limits: not stated on the site [2].
- A separately named data availability statement: not stated on the site; the data policy requires deposition and identifiers in the manuscript [3].
- Abstract headings by name: not stated on the site [2].
- Taylor & Francis AI policy linked from [3]: not read, because the PeerJ page itself carries the operative text.
- Period covered by the acceptance-rate and acceptance-to-publication figures: not stated on the site [1].
- WebFetch returned HTTP 403 for https://peerj.com/journals/peerj/aims-and-scope/; all PeerJ pages were read through the built-in browser instead.

## Table row

```
scope_5_words: soundness-only life and environment
audience: general science
fit_critique: good
fit_sim_diagnostic: good
fit_constructive: possible
fit_short_note: possible
fit_theory: poor
fit_applied: possible
abstract_format: structured: Background, Methods, Results, Conclusions (headings not named on site)
abstract_words: 500
length_limit: Research Article, not stated (surcharge over 35 typeset pages)
apc: USD 2,155
oa_model: open access
ai_policy_3_words: disclose in Methods
review_model: single
guidelines_read: yes
```
