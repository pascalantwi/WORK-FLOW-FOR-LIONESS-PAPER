# BMC Bioinformatics

| Field | Value |
|-----------------|--------------------------------------------------------------|
| Publisher | BioMed Central (BMC), part of Springer Nature; no society |
| Online ISSN | 1471-2105 |
| Profile written | 2026-10-27 |

## Sources

Every page below was read on the date shown. Bracketed numbers in the text point here.

1. [Aims and scope](https://link.springer.com/journal/12859/aims-and-scope), read 2026-10-27.
2. [Journal home page (metrics, ISSN)](https://link.springer.com/journal/12859), read 2026-10-27.
3. [Submission guidelines (general formatting, data, peer review policy)](https://link.springer.com/journal/12859/submission-guidelines), read 2026-10-27.
4. [Research article guidelines](https://link.springer.com/journal/12859/submission-guidelines/research-article), read 2026-10-27.
5. [Software article guidelines](https://link.springer.com/journal/12859/submission-guidelines/software-article), read 2026-10-27.
6. [Matters Arising guidelines](https://link.springer.com/journal/12859/submission-guidelines/matters-arising), read 2026-10-27.
7. [How to publish with us (fees and funding)](https://link.springer.com/journal/12859/how-to-publish-with-us), read 2026-10-27.
8. [Ethics and disclosures](https://link.springer.com/journal/12859/ethics-and-disclosures), read 2026-10-27.
9. [BMC editorial policies (publisher-wide; linked from the journal's submission guidelines)](https://link.springer.com/brands/bmc/editorial-policies), read 2026-10-27.
10. [Springer Nature: AI use in manuscript preparation (publisher-wide; linked from the AI section of source 9)](https://www.springernature.com/gp/policies/editorial-policies/ai-manuscript-preparation), read 2026-10-27.
11. [Springer Nature: AI use in research practice (publisher-wide; linked from source 9)](https://www.springernature.com/gp/policies/editorial-policies/using-ai-in-research), read 2026-10-27.

## Scope

> "BMC Bioinformatics is an open access, peer-reviewed journal that considers articles describing novel computational algorithms and software, models and tools, including statistical methods, machine learning and artificial intelligence, for the modelling and analysis of all kinds of biological data, as well as systems biology." [1]

In plain terms, this is a home for computational and statistical methods aimed at biological data, read by people who build and use bioinformatics tools. Its listed areas include network analysis and transcriptome analysis [1]. As a BMC Series journal it judges papers on scientific soundness, not on perceived interest or impact [1], which suits a careful critique that shows a popular method estimates something other than what users assume. Our main critique type, the simulation and diagnostic type, and the R package (as a software article) all fit.

| Paper type | Fit | Why |
|--------------------------------------------|----------|------------------------------------------------|
| Critique with a closed-form bias, simulation, fix, and application | good | Statistical methods, network analysis, and transcriptome analysis are named areas, and the soundness-only criterion rewards a careful critique [1]. |
| Simulation and diagnostic, no closed form | good | Research articles may present a new computational "test or procedure" [4], and benchmark-style evaluations of single-sample methods appear in the journal (paper 2 below). |
| Constructive method with theory, simulation, comparison, and application | good | Novel statistical methods for biological data are the stated scope [1], and a new regression method for cell-type-specific expression, checked in simulation, appeared here (paper 3 below). |
| Short methods note | possible | There is no short research format; Matters Arising is limited to comments on papers published in this journal [6], so a short note would go in as a brief research article. |
| Theory paper | possible | Statistical methods are in scope [1], but a paper with no computational tool or data analysis would sit at the edge of what the journal publishes. |
| Applied analysis | possible | Research articles may report original primary research [4], but the aims center on methods and tools [1]. |

## Article types that fit

| Article type | Length | Figures and tables | References | Source |
|-------------------|--------------------------|---------------------|-------------|--------|
| Research article | not stated on the site | no limit stated; figure and table titles at most 15 words, legends at most 300 words | not stated on the site | [3], [4] |
| Software article (for the R package) | not stated on the site | as for research articles | not stated on the site | [3], [5] |
| Matters Arising (only on papers published in BMC Bioinformatics) | ideally at most 1,200 words | one or two small figures or tables | up to 15 | [6] |

## Abstract

- Structured: yes [4]
- Headings: Background, Results, Conclusions (no Methods heading) [4]; the software article uses the same three headings [5]
- Word limit: 350 [4]

## Reference style

- The journal's stated style: numbered Vancouver style; the research article page gives "Examples of the Vancouver reference style" [4]. Journal abbreviations follow Index Medicus/MEDLINE, and every web link goes in the numbered reference list with an access date [3].
- CSL file: `dependent/bmc-bioinformatics.csl` in the official styles repository (github.com/citation-style-language/styles, commit d2cc420, 2026-10-24), a dependent style whose parent is `biomed-central.csl`.
- File to use in Quarto: `csl/biomed-central.csl`, which renders offline. The journal-named `csl/dependent/bmc-bioinformatics.csl` gives the same output but needs a network connection, because pandoc fetches the parent at render time.
- Rendering test: both files passed on 2026-10-27 (`csl/test-results.md`).

## Supplement, code, and data

- Supplementary material: additional files of up to 20 MB each, cited in sequence as "Additional file 1" and so on; results that would be "data not shown" must go in additional files [3].
- Data availability statement: required. Every manuscript must include an "Availability of data and materials" section stating where the minimal dataset behind the results can be found, using one of the template forms [4]. Datasets are strongly encouraged to be shared; deposition in a community repository is mandatory where the field expects it (for example novel sequence data) [4], [9].
- Code: BMC policy says unreported custom code "should be available for testing by editors and reviewers," with the Availability section linking both the latest version and an archived version with a DOI (Zenodo is recommended for GitHub code) [9]. So code must be reachable by reviewers at submission and archived with a DOI by publication. For software articles the journal "recommends, but does not require" open source code [5]. No reproducibility review is stated on the site.

## AI-use policy

> "Large Language Models (LLMs), such as ChatGPT, do not currently satisfy our authorship criteria." [4]

> "Use of an LLM should be properly documented in the Methods section (and if a Methods section is not available, in a suitable alternative part) of the manuscript" [4]

> "AI generated visual content that is not derived from independently verifiable data, source material, methods, computational outputs or author-developed content is considered opaque and is not permitted by Springer Nature policy." [10]

The publisher-wide policy grades AI use by risk: language polishing and formatting are permitted with disclosure; drafting, suggesting methods, or explaining model output are permitted with human oversight and disclosure; AI writing results or claims, fabricating data or citations, or being listed as an author are not permitted [9], [10]. AI-assisted figures built from verifiable data are allowed if disclosed in an AI declaration and in the figure legend [10]. Code generated with AI must be reviewed and validated by the authors [10], [11].

- Read at: https://link.springer.com/journal/12859/submission-guidelines/research-article and https://www.springernature.com/gp/policies/editorial-policies/ai-manuscript-preparation, 2026-10-27.
- What the manuscript must do: describe in the Methods section which AI tools were used and for what, state that the authors checked the output and take responsibility, and label any AI-assisted figure in its legend.

## Open access and charges

- Model: fully open access [7]
- Article processing charge: US$3,090 (also £2,290 and €2,590), plus VAT or local taxes where applicable, set by the acceptance date; read 2026-10-27 [7]
- Waivers and institutional agreements: the journal is in Springer Nature's country-tiered APC pilot, which may lower the charge by country; discretionary waivers for financial need must be requested at submission; Springer Nature institutional open access agreements may cover the charge [7]

## Review

- Model: transparent peer review. Reviewer reports are published with the article under CC BY 4.0, but reviewers are not named [3], [8]. Typically two or more experts review each manuscript [3].
- Time to decision: median submission to first decision of 5 days, as shown under "Journal metrics" on the home page [2]. The page does not define whether this includes desk rejections.

## Recent papers like ours

1. McGovern KC, Silverman JD (2025). Replacing normalizations with interval assumptions enhances differential expression and differential abundance analyses. *BMC Bioinformatics* 26:164. https://doi.org/10.1186/s12859-025-06177-2. It shows that a routine step (normalization) carries a hidden assumption about unmeasured scale that biases differential expression results, then offers a fix, much like our "what does it actually estimate" critiques.
2. Wieder C, Lai RPJ, Ebbels TMD (2022). Single sample pathway analysis in metabolomics: performance evaluation and application. *BMC Bioinformatics* 23:481. https://doi.org/10.1186/s12859-022-05005-1. It benchmarks widely used single-sample methods (ssGSEA, GSVA, and others) on semi-synthetic data with known truth and then applies them to disease data, the same design as our sample-specific network evaluations.
3. Takeuchi F, Kato N (2021). Nonlinear ridge regression improves cell-type-specific differential expression analysis. *BMC Bioinformatics* 22:141. https://doi.org/10.1186/s12859-021-03982-3. It identifies scaling and collinearity problems in the standard cell-composition interaction model, proposes a fix, and checks it in simulation, close to our cell-composition adjustment work.

All three DOIs, titles, authors, years, and journal names were confirmed against Crossref and PubMed on 2026-10-27.

## Not stated on the site, or could not be read

- Length limit for research and software articles: not stated on the site (checked sources 3, 4, and 5).
- Limits on number of figures, tables, or references for research articles: not stated on the site (sources 3 and 4).
- Reproducibility or code review: not stated on the site (sources 3, 4, and 9).
- Definition of "submission to first decision": not stated on the home page (source 2).

## Table row

```
scope_5_words: computational methods for biological data
audience: both
fit_critique: good
fit_sim_diagnostic: good
fit_constructive: good
fit_short_note: possible
fit_theory: possible
fit_applied: possible
abstract_format: structured: Background, Results, Conclusions
abstract_words: 350
length_limit: Research article: not stated
apc: USD 3,090
oa_model: open access
ai_policy_3_words: disclose, no authorship
review_model: open
guidelines_read: yes
```
