# Genome Biology

| Field | Value |
|-----------------|--------------------------------------------------------------|
| Publisher | BioMed Central (BMC), part of Springer Nature; no society |
| Online ISSN | 1474-760X |
| Profile written | 2026-10-27 |

## Sources

Every page below was read on the date shown. Bracketed numbers in the text point here.

1. [Aims and scope](https://link.springer.com/journal/13059/aims-and-scope), read 2026-10-27.
2. [Journal home page (overview, metrics, ISSN)](https://link.springer.com/journal/13059), read 2026-10-27.
3. [Submission guidelines (general formatting, data, peer review policy)](https://link.springer.com/journal/13059/submission-guidelines), read 2026-10-27.
4. [Research article guidelines](https://link.springer.com/journal/13059/submission-guidelines/research), read 2026-10-27.
5. [Methodology article guidelines](https://link.springer.com/journal/13059/submission-guidelines/methodology), read 2026-10-27.
6. [Brief Report guidelines](https://link.springer.com/journal/13059/submission-guidelines/brief-report), read 2026-10-27.
7. [Software article guidelines](https://link.springer.com/journal/13059/submission-guidelines/software), read 2026-10-27.
8. [How to publish with us (fees and funding)](https://link.springer.com/journal/13059/how-to-publish-with-us), read 2026-10-27.
9. [Ethics and disclosures](https://link.springer.com/journal/13059/ethics-and-disclosures), read 2026-10-27.
10. [Example published article showing the "Peer review information" note](https://link.springer.com/article/10.1186/s13059-026-04314-5), read 2026-10-27.
11. [BMC editorial policies (publisher-wide; linked from the journal's article-type guidelines)](https://link.springer.com/brands/bmc/editorial-policies), read 2026-10-27.
12. [Springer Nature: AI use in manuscript preparation (publisher-wide; linked from the AI section of source 11)](https://www.springernature.com/gp/policies/editorial-policies/ai-manuscript-preparation), read 2026-10-27.

## Scope

> "Genome Biology covers all areas of biology and biomedicine studied from a genomic and post-genomic perspective. Content includes research, new methods and software tools, and reviews." [1]

In plain terms, this is a selective, high-profile genomics journal with in-house editors. Unlike the BMC Series journals it judges "advance over previous studies, and interest levels" as well as soundness [4], so a paper must matter to a wide genomics audience. It has published influential critiques of popular methods (papers 1 and 2 below), so our strongest critique, with a clear fix and a real-data payoff, could fit as a Research or Methodology article. Methodology articles must show a clear advance over the state of the art, benchmarked on data with known ground truth and demonstrated on real data [5], which matches our simulation-plus-application design.

| Paper type | Fit | Why |
|--------------------------------------------|----------|------------------------------------------------|
| Critique with a closed-form bias, simulation, fix, and application | good | The journal publishes high-impact critiques of widely used genomics methods (papers 1 and 2), but only when the problem affects many users. |
| Simulation and diagnostic, no closed form | possible | A diagnostic could be a Methodology article if it beats existing practice on simulated ground truth and real data [5]; the bar for "wide audience" is high. |
| Constructive method with theory, simulation, comparison, and application | possible | A Methodology article must show a clear advance over the state of the art, benchmarked on known ground truth and on real data [5], which matches the shape, but the theory carries little weight and the advance must interest a wide genomics audience [4]. |
| Short methods note | possible | Brief Reports take a new method or a new version of one, shown in at most two figures or tables [6]. |
| Theory paper | poor | Methodology articles require benchmarking and real-data utility [5]; nothing suggests pure theory is considered. |
| Applied analysis | poor | Research articles must be "a substantial advance over previous studies" of wide interest [4]; a reanalysis of public lupus data is unlikely to meet that bar. |

## Article types that fit

| Article type | Length | Figures and tables | References | Source |
|-------------------|--------------------------|---------------------|-------------|--------|
| Research | not stated on the site | no limit stated; figure and table titles at most 15 words, legends at most 300 words | not stated on the site | [3], [4] |
| Methodology | not stated on the site | as for Research | not stated on the site | [3], [5] |
| Brief Report | main text around 1,000 to 1,500 words, no headings | at most 2 figures or tables in the main text; more in supplements | not stated on the site | [6] |
| Software (for the R package) | not stated on the site | as for Research | not stated on the site | [3], [7] |

## Abstract

- Structured: depends on article type. Research: yes [4]. Methodology, Brief Report, and Software: no, "The abstract should be unstructured." [5], [6], [7]
- Headings: Research: Background, Results, Conclusions [4]. Others: none.
- Word limit: Research 250 [4]; Methodology, Brief Report, and Software 100 [5], [6], [7]

## Reference style

- The journal's stated style: numbered Vancouver style; each article-type page gives "Examples of the Vancouver reference style" [4], [5], [6]. Journal abbreviations follow Index Medicus/MEDLINE, and web links go in the numbered reference list with an access date [3].
- CSL file: `dependent/genome-biology.csl` in the official styles repository (github.com/citation-style-language/styles, commit d2cc420, 2026-10-24), a dependent style whose parent is `springer-vancouver-brackets.csl`.
- File to use in Quarto: `csl/springer-vancouver-brackets.csl`, which renders offline. The journal-named `csl/dependent/genome-biology.csl` gives the same output but needs a network connection, because pandoc fetches the parent at render time.
- Rendering test: both files passed on 2026-10-27 (`csl/test-results.md`).

## Supplement, code, and data

- Supplementary material: additional files of up to 20 MB each [3]; the journal recommends organizing supplemental material for readers and reviewers [4].
- Data availability statement: required ("Availability of data and materials" section) [4]. The journal "operates a very strict open access, open source and open data policy"; private reviewer links to data should be given at submission if possible, and any third-party or previously published data used "must also be available as a condition of publication" [4], [5].
- Code: required to be public. "Source code for any in-house scripts that are used in analyses must be either deposited in a public repository or included in the supplementary materials." [5] For tools in Methodology or Software articles, code must be in a public repository with an OSI-compliant license, and a DOI-assigning archive of the described version is recommended and should be cited [5], [6]. The pages tie this to publication rather than to a submission deadline, though data links for reviewers are requested at submission [4]. Authors must also confirm the BMC Minimum Standards of Reporting Checklist at submission [5]. No separate reproducibility review is stated on the site.

## AI-use policy

> "Large Language Models (LLMs), such as ChatGPT, do not currently satisfy our authorship criteria." [5]

> "Use of an LLM should be properly documented in the Methods section (and if a Methods section is not available, in a suitable alternative part) of the manuscript" [5]

> "Specific disclosure should be provided within the caption or legend of the visual content." [12]

The publisher-wide policy grades AI use by risk: language editing is permitted with disclosure; drafting, suggesting methods, or explaining model output are permitted with human oversight and disclosure; AI writing results or claims, fabricating data or citations, listing AI as an author, or AI images not derived from verifiable data are not permitted [11], [12].

- Read at: https://link.springer.com/journal/13059/submission-guidelines/methodology and https://www.springernature.com/gp/policies/editorial-policies/ai-manuscript-preparation, 2026-10-27.
- What the manuscript must do: describe in the Methods section which AI tools were used and for what, state that the authors checked the output and take responsibility, and label any AI-assisted figure in its legend.

## Open access and charges

- Model: fully open access; "All content is open access immediately on publication." [1], [8]
- Article processing charge: US$5,690 (also £3,790 and €4,690); Brief Report US$4,280 (also £2,850 and €3,520); read 2026-10-27 [8]
- Waivers and institutional agreements: Springer Nature waivers for authors in the lowest-income countries; discretionary waivers for financial need must be requested at submission; institutional open access agreements may cover the charge [8]. Unlike the BMC Series journals, no country-tiered pilot is mentioned [8].

## Review

- Model: single anonymized. "Genome Biology operates a single-anonymous peer review system, where the reviewers are aware of the names and affiliations of the authors, but the reviewer reports provided to authors are anonymous." [3], [9] The home page also advertises "transparent peer review" [2], and published articles carry the note that "The peer-review history is available in the online version of this article." [10] So reviewer reports appear to be published with anonymous reviewers.
- Time to decision: median submission to first decision of 13 days under "Journal metrics" [2]; the overview text on the same page says "14 days to first decision" [2]. Neither is defined further.

## Recent papers like ours

1. Li Y, Ge X, Peng F, Li W, Li JJ (2022). Exaggerated false positives by popular differential expression methods when analyzing human population samples. *Genome Biology* 23:79. https://doi.org/10.1186/s13059-022-02648-4. A permutation-based critique showing that DESeq2 and edgeR fail to control the false discovery rate in large human cohorts, with a recommended alternative: our critique-plus-fix type applied to a very widely used method.
2. Cote AC, Young HE, Huckins LM (2022). Comparison of confound adjustment methods in the construction of gene co-expression networks. *Genome Biology* 23:44. https://doi.org/10.1186/s13059-022-02606-0. It shows that the choice of confound adjustment changes co-expression network structure and gives recommendations, the closest match to our co-expression and composition work.
3. Kanduri C, Mamica M, Olstad EW, Zucknick M, Li JJ, Sandve GK (2025). Beware of counter-intuitive levels of false discoveries in datasets with strong intra-correlations. *Genome Biology* 26:249. https://doi.org/10.1186/s13059-025-03734-z. It shows that the popular Benjamini and Hochberg correction can report many false positives when omics features are strongly dependent and recommends synthetic null data as a check, the diagnostic type of paper about a ubiquitous procedure.

All three DOIs, titles, authors, years, and journal names were confirmed against Crossref and PubMed on 2026-10-27.

## Not stated on the site, or could not be read

- Length limit for Research, Methodology, and Software articles: not stated on the site (sources 3, 4, 5, and 7).
- Reference limits for any type: not stated on the site (sources 4, 5, and 6).
- Whether code must be public at submission or only at publication: not stated explicitly (sources 4 and 5).
- Definition of "first decision": not stated on the home page (source 2).

## Table row

```
scope_5_words: biology from a genomic perspective
audience: both
fit_critique: good
fit_sim_diagnostic: possible
fit_constructive: possible
fit_short_note: possible
fit_theory: poor
fit_applied: poor
abstract_format: structured (Research): Background, Results, Conclusions; unstructured (Methodology, Brief Report)
abstract_words: 250 (Research), 100 (Methodology, Brief Report)
length_limit: Brief Report: about 1,000 to 1,500 words; Research and Methodology: not stated
apc: USD 5,690 (Brief Report USD 4,280)
oa_model: open access
ai_policy_3_words: disclose, no authorship
review_model: single
guidelines_read: yes
```
