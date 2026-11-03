# BMC Medical Research Methodology

| Field | Value |
|-----------------|--------------------------------------------------------------|
| Publisher | BioMed Central (BMC), part of Springer Nature; no society |
| Online ISSN | 1471-2288 |
| Profile written | 2026-10-27 |

## Sources

Every page below was read on the date shown. Bracketed numbers in the text point here.

1. [Aims and scope](https://link.springer.com/journal/12874/aims-and-scope), read 2026-10-27.
2. [Journal home page (overview, metrics, ISSN)](https://link.springer.com/journal/12874), read 2026-10-27.
3. [Submission guidelines (general formatting, data, peer review policy)](https://link.springer.com/journal/12874/submission-guidelines), read 2026-10-27.
4. [Research article guidelines](https://link.springer.com/journal/12874/submission-guidelines/research-article), read 2026-10-27.
5. [Software article guidelines](https://link.springer.com/journal/12874/submission-guidelines/software-article), read 2026-10-27.
6. [How to publish with us (fees and funding)](https://link.springer.com/journal/12874/how-to-publish-with-us), read 2026-10-27.
7. [Ethics and disclosures](https://link.springer.com/journal/12874/ethics-and-disclosures), read 2026-10-27.
8. [BMC editorial policies (publisher-wide; linked from the journal's submission guidelines)](https://link.springer.com/brands/bmc/editorial-policies), read 2026-10-27.
9. [Springer Nature: AI use in manuscript preparation (publisher-wide; linked from the AI section of source 8)](https://www.springernature.com/gp/policies/editorial-policies/ai-manuscript-preparation), read 2026-10-27.
10. [Springer Nature: AI use in research practice (publisher-wide; linked from source 8)](https://www.springernature.com/gp/policies/editorial-policies/using-ai-in-research), read 2026-10-27.

## Scope

> "BMC Medical Research Methodology is an open access, peer-reviewed journal publishing original research articles in methodological approaches to healthcare research." [1]

In plain terms, this is a statistics and research-design journal for health research: trials, epidemiology, meta-analysis, and the data-analysis methods behind them, with "Data analysis, statistics, and modeling" as a listed topic [1]. Its readers are methodologists and biostatisticians, and it publishes many neutral simulation studies that check whether a common practice does what users think. Genomics is not its center, so a genomics critique would need to be framed as a lesson about statistical practice in biomedical data. The home page also says it "Does not publish articles describing scientific methods or techniques", which it directs to subject journals [2]; this appears to mean laboratory techniques, but it is a reason to frame the paper as research methodology.

| Paper type | Fit | Why |
|--------------------------------------------|----------|------------------------------------------------|
| Critique with a closed-form bias, simulation, fix, and application | possible | Data analysis and statistics are in scope [1], and a review of individual-specific networks appeared here (paper 3 below), but co-expression networks are far from the journal's clinical core. |
| Simulation and diagnostic, no closed form | possible | Neutral simulation studies of common practice are typical here (papers 1 and 2 below); the genomics setting is the stretch. |
| Constructive method with theory, simulation, comparison, and application | possible | New data-analysis methods for health research are in scope if "well tested" [4], but genomics is far from the journal's clinical core, and the home page's line against "scientific methods or techniques" [2] calls for a research-methodology framing. |
| Short methods note | possible | No length limit is stated for research articles [4], but there is no short methods format. |
| Theory paper | poor | The aims stress applied methodology for healthcare research, and research articles describing technical advances must be "well tested" [4]. |
| Applied analysis | poor | The journal does not publish substantive applied studies; descriptive single-institution results are restricted [4]. |

## Article types that fit

| Article type | Length | Figures and tables | References | Source |
|-------------------|--------------------------|---------------------|-------------|--------|
| Research article | not stated on the site | no limit stated; figure and table titles at most 15 words, legends at most 300 words | not stated on the site | [3], [4] |
| Software article (for the R package) | not stated on the site | as for research articles | not stated on the site | [3], [5] |

## Abstract

- Structured: yes [4]
- Headings: Background, Methods, Results, Conclusions; plus Trial registration when the article reports a health care intervention on human participants [4]
- Word limit: 350 [4]

## Reference style

- The journal's stated style: numbered Vancouver style; the research article page gives "Examples of the Vancouver reference style" [4]. Journal abbreviations follow Index Medicus/MEDLINE, and web links go in the numbered reference list with an access date [3].
- CSL file: `dependent/bmc-medical-research-methodology.csl` in the official styles repository (github.com/citation-style-language/styles, commit d2cc420, 2026-10-24), a dependent style whose parent is `biomed-central.csl`.
- File to use in Quarto: `csl/biomed-central.csl`, which renders offline. The journal-named `csl/dependent/bmc-medical-research-methodology.csl` gives the same output but needs a network connection, because pandoc fetches the parent at render time.
- Rendering test: both files passed on 2026-10-27 (`csl/test-results.md`).

## Supplement, code, and data

- Supplementary material: additional files of up to 20 MB each, cited as "Additional file 1" and so on [3].
- Data availability statement: required ("Availability of data and materials" section) [4]. Datasets are strongly encouraged to be available; community-mandated deposition applies where it exists [4], [8].
- Code: BMC policy says unreported custom code "should be available for testing by editors and reviewers," with links to the latest version and an archived version with a DOI [8]. So reviewers need access at submission and an archived DOI is expected by publication. For software articles the journal "recommends, but does not require" open source code [5]. No reproducibility review is stated on the site.

## AI-use policy

> "Large Language Models (LLMs), such as ChatGPT, do not currently satisfy our authorship criteria." [4]

> "Use of an LLM should be properly documented in the Methods section (and if a Methods section is not available, in a suitable alternative part) of the manuscript." [4]

> "Specific disclosure should be provided within the caption or legend of the visual content." [9]

The publisher-wide policy grades AI use by risk: language editing is permitted with disclosure; drafting, suggesting methods, or explaining model output are permitted with human oversight and disclosure; AI writing results or claims, fabricating data or citations, listing AI as an author, or AI images not derived from verifiable data are not permitted [8], [9]. Authors must be able to describe AI inputs, outputs, and validation when AI supports analysis [10].

- Read at: https://link.springer.com/journal/12874/submission-guidelines/research-article and https://www.springernature.com/gp/policies/editorial-policies/ai-manuscript-preparation, 2026-10-27.
- What the manuscript must do: describe in the Methods section which AI tools were used and for what, state that the authors checked the output and take responsibility, and label any AI-assisted figure in its legend.

## Open access and charges

- Model: fully open access [6]
- Article processing charge: US$3,090 (also £2,290 and €2,690), plus VAT or local taxes where applicable, set by the acceptance date; read 2026-10-27 [6]
- Waivers and institutional agreements: part of Springer Nature's country-tiered APC pilot; discretionary waivers for financial need must be requested at submission; institutional open access agreements may cover the charge [6]

## Review

- Model: transparent peer review. Reviewer reports are published with the article under CC BY 4.0, but reviewers are not named [3], [7].
- Time to decision: median submission to first decision of 7 days, as shown under "Journal metrics" on the home page [2]. The page does not define whether this includes desk rejections.

## Recent papers like ours

1. Schemet L, Friedrich-Welz S (2026). Statistical inference after variable selection in Cox models: a neutral simulation study. *BMC Medical Research Methodology* 26:143. https://doi.org/10.1186/s12874-026-02887-0. It separates the different targets that post-selection methods actually estimate before judging coverage and error rates, the same "what does it really estimate" move as our critiques.
2. Gao Y, Liu Y, Matsouaka R (2024). When does adjusting covariate under randomization help? A comparative study on current practices. *BMC Medical Research Methodology* 24:250. https://doi.org/10.1186/s12874-024-02375-3. A Monte Carlo evaluation of common adjustment practices with practical guidance, the simulation-and-diagnostic type of paper.
3. Gregorich M, Melograna F, Sunqvist M, Michiels S, Van Steen K, Heinze G (2022). Individual-specific networks for prediction modelling: a scoping review of methods. *BMC Medical Research Methodology* 22:62. https://doi.org/10.1186/s12874-022-01544-6. It reviews individual-specific network methods, the family that includes LIONESS and SSN, showing the topic has reached this journal's readers.

All three DOIs, titles, authors, years, and journal names were confirmed against Crossref and PubMed on 2026-10-27. Paper 3's Crossref title uses a dash before "A scoping review"; it is written here with a colon.

## Not stated on the site, or could not be read

- Length limit for research and software articles: not stated on the site (sources 3, 4, and 5).
- Limits on number of figures, tables, or references: not stated on the site (sources 3 and 4).
- Reproducibility or code review: not stated on the site (sources 3, 4, and 8).
- Definition of "submission to first decision": not stated on the home page (source 2).

## Table row

```
scope_5_words: statistical methodology for healthcare research
audience: methodologists
fit_critique: possible
fit_sim_diagnostic: possible
fit_constructive: possible
fit_short_note: possible
fit_theory: poor
fit_applied: poor
abstract_format: structured: Background, Methods, Results, Conclusions
abstract_words: 350
length_limit: Research article: not stated
apc: USD 3,090
oa_model: open access
ai_policy_3_words: disclose, no authorship
review_model: open
guidelines_read: yes
```
