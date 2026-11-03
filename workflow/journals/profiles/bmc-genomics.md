# BMC Genomics

| Field | Value |
|-----------------|--------------------------------------------------------------|
| Publisher | BioMed Central (BMC), part of Springer Nature; no society |
| Online ISSN | 1471-2164 |
| Profile written | 2026-10-27 |

## Sources

Every page below was read on the date shown. Bracketed numbers in the text point here.

1. [Aims and scope](https://link.springer.com/journal/12864/aims-and-scope), read 2026-10-27.
2. [Journal home page (overview, metrics, ISSN)](https://link.springer.com/journal/12864), read 2026-10-27.
3. [Submission guidelines (general formatting, data, peer review policy)](https://link.springer.com/journal/12864/submission-guidelines), read 2026-10-27.
4. [Research article guidelines](https://link.springer.com/journal/12864/submission-guidelines/research-article), read 2026-10-27.
5. [Software article guidelines](https://link.springer.com/journal/12864/submission-guidelines/software-article), read 2026-10-27.
6. [How to publish with us (fees and funding)](https://link.springer.com/journal/12864/how-to-publish-with-us), read 2026-10-27.
7. [Ethics and disclosures](https://link.springer.com/journal/12864/ethics-and-disclosures), read 2026-10-27.
8. [BMC editorial policies (publisher-wide; linked from the journal's submission guidelines)](https://link.springer.com/brands/bmc/editorial-policies), read 2026-10-27.
9. [Springer Nature: AI use in manuscript preparation (publisher-wide; linked from the AI section of source 8)](https://www.springernature.com/gp/policies/editorial-policies/ai-manuscript-preparation), read 2026-10-27.
10. [Springer Nature: AI use in research practice (publisher-wide; linked from source 8)](https://www.springernature.com/gp/policies/editorial-policies/using-ai-in-research), read 2026-10-27.

## Scope

> "BMC Genomics is an open access, peer-reviewed journal that considers articles on all aspects of genetics, genomics, transcriptomics and proteomics." [1]

In plain terms, this journal publishes genome-scale biology across many organisms, from bench and field studies to analysis methods, and its readers are mostly genomics users rather than statisticians. It has a "Transcriptomic Methods" section [1], and its home page says it explores "functional genomics, epigenomics, proteomics and transcriptomics, including novel methods and techniques" [2]. Like other BMC Series journals it judges scientific soundness, not perceived impact [1]. Our critiques fit best when framed around a transcriptomic application such as the lupus RNA-seq analysis; pure theory does not fit.

| Paper type | Fit | Why |
|--------------------------------------------|----------|------------------------------------------------|
| Critique with a closed-form bias, simulation, fix, and application | good | Research articles may report "new experimental or computational methods" [4], there is a Transcriptomic Methods section [1], and a cell-composition critique of blood expression studies appeared here (paper 1 below). |
| Simulation and diagnostic, no closed form | possible | In scope as a computational method [4], but the readership is applied, so the paper needs a clear genomics use case. |
| Constructive method with theory, simulation, comparison, and application | possible | New computational methods are in scope [4], but the readers mostly use methods rather than evaluate them, so the theory carries little weight and the paper needs a clear genomics use case. |
| Short methods note | possible | No length limits are stated, so a short research article is allowed [3], [4], but there is no dedicated short methods format. |
| Theory paper | poor | The aims list biological domains and methods for them [1]; nothing suggests pure statistical theory is considered. |
| Applied analysis | good | Original primary genomics research is the journal's core content [1], [4]. |

## Article types that fit

| Article type | Length | Figures and tables | References | Source |
|-------------------|--------------------------|---------------------|-------------|--------|
| Research article | not stated on the site | no limit stated; figure and table titles at most 15 words, legends at most 300 words | not stated on the site | [3], [4] |
| Software article (for the R package) | not stated on the site | as for research articles | not stated on the site | [3], [5] |

## Abstract

- Structured: yes [4]
- Headings: Background, Results, Conclusions (no Methods heading) [4]
- Word limit: 350 [4]

## Reference style

- The journal's stated style: numbered Vancouver style; the research article page gives "Examples of the Vancouver reference style" [4]. Journal abbreviations follow Index Medicus/MEDLINE, and web links go in the numbered reference list with an access date [3].
- CSL file: `dependent/bmc-genomics.csl` in the official styles repository (github.com/citation-style-language/styles, commit d2cc420, 2026-10-24), a dependent style whose parent is `biomed-central.csl`.
- File to use in Quarto: `csl/biomed-central.csl`, which renders offline. The journal-named `csl/dependent/bmc-genomics.csl` gives the same output but needs a network connection, because pandoc fetches the parent at render time.
- Rendering test: both files passed on 2026-10-27 (`csl/test-results.md`).

## Supplement, code, and data

- Supplementary material: additional files of up to 20 MB each, cited as "Additional file 1" and so on [3].
- Data availability statement: required ("Availability of data and materials" section) [4]. The journal adds: "In the genomics field, there is a widely established research community expectation for data archiving in public repositories, and submission to a community-endorsed, public repository is mandatory." [4] BMC policy says mandated data must be available to editors and reviewers during review and public on publication [8].
- Code: BMC policy says unreported custom code "should be available for testing by editors and reviewers," with links to the latest version and to an archived version with a DOI [8]. So reviewers need access at submission and an archived DOI is expected by publication. For software articles the journal "recommends, but does not require" open source code [5]. No reproducibility review is stated on the site.

## AI-use policy

> "Large Language Models (LLMs), such as ChatGPT, do not currently satisfy our authorship criteria." [4]

> "Use of an LLM should be properly documented in the Methods section (and if a Methods section is not available, in a suitable alternative part) of the manuscript" [4]

> "Specific disclosure should be provided within the caption or legend of the visual content." [9]

The publisher-wide policy grades AI use by risk: language editing is permitted with disclosure; drafting, suggesting methods, or explaining model output are permitted with human oversight and disclosure; AI writing results or claims, fabricating data or citations, listing AI as an author, or AI images not derived from verifiable data are not permitted [8], [9]. AI-assisted analysis and code must be described and validated by the authors [10].

- Read at: https://link.springer.com/journal/12864/submission-guidelines/research-article and https://www.springernature.com/gp/policies/editorial-policies/ai-manuscript-preparation, 2026-10-27.
- What the manuscript must do: describe in the Methods section which AI tools were used and for what, state that the authors checked the output and take responsibility, and label any AI-assisted figure in its legend.

## Open access and charges

- Model: fully open access [6]
- Article processing charge: US$3,190 (also £2,390 and €2,790), plus VAT or local taxes where applicable, set by the acceptance date; read 2026-10-27 [6]
- Waivers and institutional agreements: part of Springer Nature's country-tiered APC pilot; discretionary waivers for financial need must be requested at submission; institutional open access agreements may cover the charge [6]

## Review

- Model: transparent peer review. Reviewer reports are published with the article under CC BY 4.0, but reviewers are not named [3], [7].
- Time to decision: median submission to first decision of 4 days, as shown under "Journal metrics" on the home page [2]. The page does not define whether this includes desk rejections.

## Recent papers like ours

1. Pellegrino-Coppola D, Claringbould A, Stutvoet M, BIOS Consortium, Boomsma DI, Ikram MA, Slagboom PE, Westra HJ, Franke L (2021). Correction for both common and rare cell types in blood is important to identify genes that correlate with age. *BMC Genomics* 22:184. https://doi.org/10.1186/s12864-020-07344-w. It shows that many reported age-associated genes in whole blood were driven by cell composition, and that adjusting for 33 more cell subtypes changes the answer, the same question we asks about cell-composition adjustment.
2. Wang J, Crowell HL, Robinson MD (2025). On feature selection to disentangle cell type and state transcriptional programs. *BMC Genomics* 26:1006. https://doi.org/10.1186/s12864-025-12085-9. It uses a simulation framework with competing cell type and cell state effects, plus an experimental dataset, to test how a routine step (feature selection) shapes downstream differential results, our simulation-plus-real-data design.
3. de la Fuente Cantó C, Vigouroux Y (2022). Evaluation of nine statistics to identify QTLs in bulk segregant analysis using next generation sequencing approaches. *BMC Genomics* 23:490. https://doi.org/10.1186/s12864-022-08718-y. It benchmarks widely used test statistics against simulated data with known truth and proposes simulation-based confidence intervals, showing the journal takes simulation-driven method evaluations.

All three DOIs, titles, authors, years, and journal names were confirmed against Crossref and PubMed on 2026-10-27.

## Not stated on the site, or could not be read

- Length limit for research and software articles: not stated on the site (sources 3, 4, and 5).
- Limits on number of figures, tables, or references: not stated on the site (sources 3 and 4).
- Reproducibility or code review: not stated on the site (sources 3, 4, and 8).
- Definition of "submission to first decision": not stated on the home page (source 2).

## Table row

```
scope_5_words: genetics, genomics, transcriptomics, proteomics research
audience: genomics users
fit_critique: good
fit_sim_diagnostic: possible
fit_constructive: possible
fit_short_note: possible
fit_theory: poor
fit_applied: good
abstract_format: structured: Background, Results, Conclusions
abstract_words: 350
length_limit: Research article: not stated
apc: USD 3,190
oa_model: open access
ai_policy_3_words: disclose, no authorship
review_model: open
guidelines_read: yes
```
