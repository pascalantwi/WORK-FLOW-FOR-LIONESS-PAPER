# PLOS ONE

| Field | Value |
|-----------------|--------------------------------------------------------------|
| Publisher | Public Library of Science (PLOS), a nonprofit; no society |
| Online ISSN | 1932-6203 |
| Profile written | 2026-10-27 |

## Sources

Every page below was read on the date shown. Bracketed numbers in the text point here.

1. [Journal information (scope, criteria summary, journal timings table)](https://journals.plos.org/plosone/s/journal-information), read 2026-10-27.
2. [Criteria for publication](https://journals.plos.org/plosone/s/criteria-for-publication), read 2026-10-27.
3. [Submission guidelines](https://journals.plos.org/plosone/s/submission-guidelines), read 2026-10-27.
4. [Ethical publishing practice (PLOS-wide; includes "Artificial Intelligence Tools and Technologies")](https://journals.plos.org/plosone/s/ethical-publishing-practice), read 2026-10-27.
5. [Materials, software, and code sharing](https://journals.plos.org/plosone/s/materials-software-and-code-sharing), read 2026-10-27.
6. [Data availability](https://journals.plos.org/plosone/s/data-availability), read 2026-10-27.
7. [Editorial and peer review process](https://journals.plos.org/plosone/s/editorial-and-peer-review-process), read 2026-10-27.
8. [PLOS publication fees (PLOS-wide; includes fee assistance and Research4Life terms)](https://plos.org/publish/fees/), read 2026-10-27.
9. [PLOS metrics (PLOS-wide, 2025 figures)](https://plos.org/metrics/), read 2026-10-27.
10. [Publishing information (eISSN)](https://journals.plos.org/plosone/s/publishing-information), read 2026-10-27.

## Scope

> "PLOS ONE welcomes original research submissions from the natural sciences, medical research, engineering," [1] ... "We evaluate research on the basis of scientific validity, strong methodology, and high ethical standards" [1]

In plain terms, PLOS ONE is a very broad journal that asks one question of a paper: is it done and reported correctly? It does not ask whether the result is new or important. The journal information page says its criteria rest on "scientific validity, strong methodology, and high ethical standards" and "not perceived significance" [1]. The seven publication criteria [2] are, in short: (1) the study presents original research; (2) the results have not been published elsewhere; (3) experiments, statistics, and other analyses are "performed to a high technical standard" and described in sufficient detail; (4) conclusions are presented appropriately and "supported by the data"; (5) the article is intelligible and in standard English; (6) the research meets ethics and research-integrity standards; and (7) the article follows reporting guidelines and community standards for data availability. Readers are a general science audience, so a genomics critique will reach applied users more than methodologists. A soundness-only bar suits our critique and simulation papers, including ones whose main message is "this popular method does not estimate what you think."

| Paper type | Fit | Why |
|--------------------------------------------|----------|------------------------------------------------|
| Critique with a closed-form bias, simulation, fix, and application | good | The criteria reward a correct, well-documented analysis rather than novelty [2], and evaluations of widely used genomics methods appear in the journal (papers 1 and 2 below). |
| Simulation and diagnostic, no closed form | good | Simulation-based method comparisons are published here (paper 1 below), and the bar is technical soundness [2]. |
| Constructive method with theory, simulation, comparison, and application | possible | The soundness bar [2] accepts a new method with its comparison, but few of the general readers evaluate methods, and the papers found are evaluations rather than new procedures. |
| Short methods note | possible | There is no separate short format, but there are no length limits [3], and short notes on a standard test appear as research articles (paper 3 below). |
| Theory paper | possible | Statistics are named in criterion 3 [2], but a paper with no data or simulation would be unusual for a journal centered on original research. |
| Applied analysis | good | Original research on any natural-science or medical question is in scope [1], judged only on soundness [2]. |

## Article types that fit

| Article type | Length | Figures and tables | References | Source |
|-------------------|--------------------------|---------------------|-------------|--------|
| Research Article | no limit: "There are no restrictions on word count, number of figures" | no limit stated | not stated on the site | [3] |

## Abstract

- Structured: no; the guidelines ask for objectives, how the study was done "without methodological detail," and the main results, with no labeled headings required [3]
- Headings: none
- Word limit: 300 [3]

## Reference style

- The journal's stated style: numbered Vancouver. "PLOS uses "Vancouver" style," based on the ICMJE sample references; references are "numbered in the order that they appear in the text," and "PLOS uses the numbered citation (citation-sequence) method and first six authors, et al." [3]. No citations in the abstract [3].
- CSL file: `dependent/plos-one.csl` in the official styles repository (github.com/citation-style-language/styles, commit d2cc420, 2026-10-24), a dependent style whose parent is `plos.csl`.
- File to use in Quarto: `csl/plos.csl`, which renders offline. The journal-named `csl/dependent/plos-one.csl` gives the same output but needs a network connection, because pandoc fetches the parent at render time.
- Rendering test: both files passed on 2026-10-27 (`csl/test-results.md`).

## Supplement, code, and data

- Supplementary material: supporting information files must be under 20 MB each, are peer reviewed, are named with an "S" and a number (for example "S1 Appendix"), have captions listed at the end of the manuscript, and are published as supplied without copyediting [3].
- Data availability statement: required for every article, including ones with no data; it is entered in the submission form and published with the article. It must name repositories and give DOIs or accession numbers; restricted data need a named non-author access contact; data must be public "at the time of publication," and placeholders are allowed at submission [6].
- Code: "We expect all researchers with submissions to PLOS in which author-generated code underpins the findings in the manuscript to make all author-generated code available without restrictions upon publication of the work." [5] So code must be public at publication, not at submission; a repository that issues DOIs is encouraged but none is named [5]. Software papers must be open source (BSD, LGPL, or MIT suggested), deposited in an open archive, and runnable by reviewers [5]. No formal reproducibility review is stated.

## AI-use policy

> "AI tools may be used to support development or revision of a PLOS submission." "AI tools cannot be listed as authors." [4]

- Use that generates or revises content must be disclosed; disclosures "should be in the body of the article, either in a dedicated section of the Methods, in the Acknowledgement section, or in the relevant figure legend(s)" and must give the name of each tool and how it was used [4].
- Figures: "Authors can use AI-generated figures for illustrative purposes or to summarize results," provided AI content does not misrepresent primary research outputs, with disclosure in the figure legend [4].
- The policy sits on the PLOS ethical publishing practice page, which says its policies "apply to all PLOS journals, unless otherwise noted" [4].
- Read at: https://journals.plos.org/plosone/s/ethical-publishing-practice, 2026-10-27.
- What the manuscript must do: include a short AI-use statement in a dedicated Methods subsection (or the Acknowledgments) naming each tool and saying how it was used, and note any AI help with a figure in that figure's legend.

## Open access and charges

- Model: fully open access [8]
- Article processing charge: USD 2,477 for research articles ("All other articles"), read 2026-10-27; the page lists only USD, gives no effective date, and says fees are those in effect on the submission date [8]
- Waivers and institutional agreements: PLOS Publication Fee Assistance is for authors "unable to pay all or part of their publication fees," must be requested at submission after other funding is exhausted, with decisions usually within 10 business days; authors in Research4Life Group A countries without funding publish free, and Group B authors pay USD 940; institutional partnerships can cover fees for affiliated authors [8].

## Review

- Model: single anonymized: "PLOS One uses single-anonymized peer review." Reviewers may sign their reviews, and authors may opt in to publish the peer review history [7].
- Time to decision: median 32 days to first decision and 209 days to publication in 2025, with a 26% acceptance rate [9]. The journal's own timings table (medians in days) runs only to January to June 2023: 45 days to first decision, 188 days to acceptance, and 30.74% acceptance for that half-year [1]. Reviewers typically get 10 days [7].

## Recent papers like ours

1. Li D, Zand MS, Dye TD, Goniewicz ML, Rahman I, Xie Z (2022). An evaluation of RNA-seq differential analysis methods. *PLOS ONE*. https://doi.org/10.1371/journal.pone.0264246. Simulation study of eight widely used RNA-seq tools (edgeR, DESeq2, voom, and others) across sample sizes and distributions, with a real-data comparison.
2. Khomich M, Måge I, Rud I, Berget I (2021). Analysing microbiome intervention design studies: Comparison of alternative multivariate statistical methods. *PLOS ONE*. https://doi.org/10.1371/journal.pone.0259973. Compares PERMANOVA and other community-level and taxon-level methods on simulated data and five published trials, close to our permutation-test work.
3. Neuhäuser M, Ruxton GD (2024). A note on the Wilcoxon-Mann-Whitney test and tied observations. *PLOS ONE*. https://doi.org/10.1371/journal.pone.0309074. A short note on how a standard test behaves under a common data feature, a model for our short methods note.

## Not stated on the site, or could not be read

- Reference limits: not stated on the site (submission guidelines [3]).
- Figure and table limits: none stated; the guidelines say there are no restrictions [3].
- Reproducibility or code review: not stated on the site [5].
- Journal-specific timings after June 2023: not stated on the journal information page [1]; PLOS-wide metrics give 2025 medians [9].
- APC effective date and non-USD prices: not stated on the site [8].

## Table row

```
scope_5_words: soundness-only broad science journal
audience: general science
fit_critique: good
fit_sim_diagnostic: good
fit_constructive: possible
fit_short_note: possible
fit_theory: possible
fit_applied: good
abstract_format: unstructured
abstract_words: 300
length_limit: Research Article, no limit
apc: USD 2,477
oa_model: open access
ai_policy_3_words: disclose, no authorship
review_model: single
guidelines_read: yes
```
