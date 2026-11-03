# npj Systems Biology and Applications

| Field | Value |
|-----------------|--------------------------------------------------------------|
| Publisher | Springer Nature (Nature Portfolio, npj Series), in partnership with the Systems Biology Institute |
| Online ISSN | 2056-7189 |
| Profile written | 2026-10-27 |

## Sources

Every page below was read on the date shown. Bracketed numbers in the text point here.

1. [Aims and scope](https://www.nature.com/npjsba/aims), read 2026-10-27.
2. [Journal home page (ISSN)](https://www.nature.com/npjsba/), read 2026-10-27.
3. [Journal information (open access, partnership)](https://www.nature.com/npjsba/journal-information), read 2026-10-27.
4. [Content types](https://www.nature.com/npjsba/content-types), read 2026-10-27.
5. [Submission guidelines](https://www.nature.com/npjsba/for-authors-and-referees/submission-guidelines), read 2026-10-27.
6. [Editorial process](https://www.nature.com/npjsba/for-authors-and-referees/editorial-process), read 2026-10-27.
7. [Editorial policies: peer review](https://www.nature.com/npjsba/editorial-policies/peer-review), read 2026-10-27.
8. [Editorial policies: artificial intelligence](https://www.nature.com/npjsba/editorial-policies/artificial-intelligence), read 2026-10-27.
9. [Editorial policies: reporting standards and availability of data, materials, code and protocols](https://www.nature.com/npjsba/editorial-policies/availability-data-code-materials), read 2026-10-27.
10. [Article processing charges](https://www.nature.com/npjsba/apc), read 2026-10-27.
11. [Journal metrics](https://www.nature.com/npjsba/journal-impact), read 2026-10-27.
12. [Springer Nature: AI use in manuscript preparation (publisher-wide; linked from source 8)](https://www.springernature.com/gp/policies/editorial-policies/ai-manuscript-preparation), read 2026-10-27.

## Scope

> "npj Systems Biology and Applications considers all aspects of research covering computational and mathematical approaches to analysis and modeling of complex biological systems." [1]

In plain terms, this is a systems biology journal for computational and mathematical work on biological systems, with listed topics that include "Network biology and interactome analysis", "Multi-omics data integration", and "Systems immunology and host-pathogen interactions" [1]. Readers are systems and computational biologists. Editors judge "novelty and significance and overall technical quality" before sending papers to review [6], so it is more selective than the BMC Series. It has published both an evaluation of single-sample network methods including LIONESS, SSN, and SWEET and an applied LIONESS study (papers 1 and 2 below), so our sample-specific network critiques are a natural fit; the PERMANOVA and cell-composition papers fit less well.

| Paper type | Fit | Why |
|--------------------------------------------|----------|------------------------------------------------|
| Critique with a closed-form bias, simulation, fix, and application | good | Network biology is a named topic [1], and a head-to-head evaluation of SSN, LIONESS, SWEET, and others appeared here (paper 1). |
| Simulation and diagnostic, no closed form | possible | In scope as a computational approach [1], but the novelty and significance criterion [6] favors papers with a clear systems biology payoff. |
| Constructive method with theory, simulation, comparison, and application | possible | A new computational approach is in scope [1], but the novelty and significance criterion [6] favors a method with a clear systems biology payoff over one judged by its statistical properties. |
| Short methods note | possible | Brief Communications cover concise studies that "do not fulfill the criteria of a full research article" [4]. |
| Theory paper | possible | "Mathematical approaches to analysis and modeling" are explicitly in scope [1], though the journal's content leans toward modeling of specific systems. |
| Applied analysis | possible | Applications to disease modeling and systems immunology are listed [1], and an applied LIONESS study of lung cancer appeared here (paper 2). |

## Article types that fit

| Article type | Length | Figures and tables | References | Source |
|-------------------|--------------------------|---------------------|-------------|--------|
| Article | no strict limit; "We do not impose strict limits on word count or page numbers" | no limit stated; legends at most 350 words per figure | "Limited to 60 references, though not strictly enforced" | [4] |
| Brief Communication | main text no more than 1,000 to 1,500 words (excluding abstract, methods, references, and legends), no subheadings | no limit stated; legends at most 350 words per figure | around 20, as a guide | [4] |

## Abstract

- Structured: no; "No subheadings permitted" [4]
- Headings: none
- Word limit: Article 150; Brief Communication 70 [4]

## Reference style

- The journal's stated style: "The npj Series journals use standard Nature referencing style." References are numbered in order of appearance, one publication per number; list all authors unless there are more than five, then first author followed by "et al." [5].
- CSL file: no file for this journal in the official styles repository (github.com/citation-style-language/styles, commit d2cc420, 2026-10-24). The site names standard Nature referencing style, so the substitute is `nature.csl`, the repository's Nature style (numbered, superscript).
- File to use in Quarto: `csl/nature.csl`, a substitute chosen by the coordinator, not by the journal.
- Rendering test: `csl/nature.csl` passed on 2026-10-27 (`csl/test-results.md`).

## Supplement, code, and data

- Supplementary material: one combined Supplementary Information file, preferably PDF; it is not edited; all methods must be in the main manuscript, not in the supplement [4], [5].
- Data availability statement: mandatory, as a "Data Availability" section after Methods and before References, covering the minimal dataset needed to interpret, replicate, and build on the findings [4], [5], [9].
- Code: a "Code availability" section is required for custom code central to the conclusions, placed after the data availability statement [9]. Code must be shared with editors and reviewers on request, and "npj series journals undertake peer review of custom code or mathematical algorithm, and software, when it is central to the manuscript" [9]. Public release at publication is "best practice", ideally in a DOI-minting repository such as Zenodo or Code Ocean and cited in the references [9]; it is not stated as an absolute requirement.
- Manuscript format: compiled PDF or Word at submission; LaTeX source is accepted only at the acceptance stage [5].

## AI-use policy

> "Large Language Models (LLMs), such as ChatGPT, do not currently satisfy our authorship criteria." [5]

> "Use of an LLM should be properly documented in the Methods section (and if a Methods section is not available, in a suitable alternative part) of the manuscript." [5]

> "Specific disclosure should be provided within the caption or legend of the visual content." [12]

The journal's AI page reproduces the Springer Nature risk framework: language polishing is permitted and disclosure is encouraged; suggesting methods, extensive writing support, or explaining model output are permitted with human oversight and disclosure; generating analyses or conclusions presented as human work, fabricating data or citations, or assigning authorship to AI are not permitted [8]. AI images not derived from verifiable data are not permitted [12].

- Read at: https://www.nature.com/npjsba/editorial-policies/artificial-intelligence and https://www.nature.com/npjsba/for-authors-and-referees/submission-guidelines, 2026-10-27.
- What the manuscript must do: describe in the Methods section which AI tools were used and for what, state that the authors checked the output and take responsibility, and label any AI-assisted figure in its legend.

## Open access and charges

- Model: fully open access [3], [10]
- Article processing charge: Original Research US$3,490 (also £2,690 and €2,990); Brief Communication, Perspective, Review, or Comment US$1,470 (also £945 and €1,055); subject to VAT or local taxes; read 2026-10-27 [10]
- Waivers and institutional agreements: Springer Nature waivers for authors in the lowest-income countries; discretionary waivers for financial need must be requested at submission; institutional open access agreements may cover the charge [10]

## Review

- Model: single anonymized. "The npj Series operate a single-anonymized peer review process." Referees are not identified to authors unless they ask [6]. Publication of reviewer reports is not stated on the pages read [6], [7].
- Time to decision: median 8 days from submission to first editorial decision, which the page defines as the time until a manuscript "is either sent out for peer review or rejected"; median 155 days from submission to acceptance, including review and revision [11].

## Recent papers like ours

1. Deschildre J, Vandemoortele B, Loers JU, De Preter K, Vermeirssen V (2024). Evaluation of single-sample network inference methods for precision oncology. *npj Systems Biology and Applications* 10:18. https://doi.org/10.1038/s41540-024-00340-w. It compares SSN, LIONESS, SWEET, iENA, CSN, and SSPGI on cancer cell line transcriptomes, the exact family of methods in our control-fraction paper.
2. López-Sánchez P, Ávila-Moreno F, Hernández-Lemus E, Kuijjer ML, Espinal-Enríquez J (2025). Patient-specific gene co-expression networks reveal novel subtypes and predictive biomarkers in lung adenocarcinoma. *npj Systems Biology and Applications* 11:44. https://doi.org/10.1038/s41540-025-00522-0. An applied LIONESS analysis of 334 patients, the kind of downstream use whose estimand our critiques examine.
3. O'Leary K, Zheng D (2024). Metacell-based differential expression analysis identifies cell type specific temporal gene response programs in COVID-19 patient PBMCs. *npj Systems Biology and Applications* 10:36. https://doi.org/10.1038/s41540-024-00364-2. It starts from a statistical flaw in common practice (treating single cells as independent replicates inflates statistics), proposes metacells as pseudo-replicates, and applies the fix to immune cell data, the critique-fix-application arc of our papers.

All three DOIs, titles, authors, years, and journal names were confirmed against Crossref and PubMed on 2026-10-27.

## Not stated on the site, or could not be read

- Length limit for Articles: not stated on the site; the content types page says strict limits are not imposed (source 4).
- Figure and table limits for Articles and Brief Communications: not stated on the site (source 4).
- Whether reviewer reports are published: not stated on the site (sources 6 and 7).
- Code in a public repository: recommended as best practice at publication, not stated as required at submission or acceptance (source 9).

## Table row

```
scope_5_words: computational modeling of biological systems
audience: both
fit_critique: good
fit_sim_diagnostic: possible
fit_constructive: possible
fit_short_note: possible
fit_theory: possible
fit_applied: possible
abstract_format: unstructured
abstract_words: 150
length_limit: Article: not stated; Brief Communication: 1,000 to 1,500 words
apc: USD 3,490 (Brief Communication USD 1,470)
oa_model: open access
ai_policy_3_words: disclose, no authorship
review_model: single
guidelines_read: yes
```
