# Frontiers in Genetics

| Field | Value |
|-----------------|--------------------------------------------------------------|
| Publisher | Frontiers Media SA; no society |
| Online ISSN | 1664-8021 |
| Profile written | 2026-10-27 |

## Sources

Every page below was read on the date shown. Bracketed numbers in the text point here.

1. [Frontiers in Genetics: about (mission, sections, out-of-scope rules, ISSN, review)](https://www.frontiersin.org/journals/genetics/about), read 2026-10-27.
2. [Statistical Genetics and Methodology section: about](https://www.frontiersin.org/journals/genetics/sections/statistical-genetics-and-methodology/about), read 2026-10-27.
3. [Computational Genomics section: about](https://www.frontiersin.org/journals/genetics/sections/computational-genomics/about), read 2026-10-27.
4. [Frontiers in Genetics: article types](https://www.frontiersin.org/journals/genetics/for-authors/article-types), read 2026-10-27.
5. [Frontiers author guidelines (Frontiers-wide; abstract, references, generative AI)](https://www.frontiersin.org/guidelines/author-guidelines), read 2026-10-27.
6. [Frontiers in Genetics: author guidelines (journal page, which repeats the Frontiers-wide text)](https://www.frontiersin.org/journals/genetics/for-authors/author-guidelines), read 2026-10-27.
7. [Frontiers policies and publication ethics (Frontiers-wide; data availability, code, review)](https://www.frontiersin.org/guidelines/policies-and-publication-ethics), read 2026-10-27.
8. [Frontiers in Genetics: publishing fees](https://www.frontiersin.org/journals/genetics/for-authors/publishing-fees), read 2026-10-27.
9. [Frontiers publishing fees and fee support (Frontiers-wide)](https://www.frontiersin.org/about/publishing-fees), read 2026-10-27.
10. [Frontiers journal reference style table (PDF on frontiersin.org, file dated 2023-08-11)](https://www.frontiersin.org/Design/pdf/Frontiers_Journal_style_table.pdf), read 2026-10-27.
11. [Frontiers in Genetics home page (metrics)](https://www.frontiersin.org/journals/genetics), read 2026-10-27.

## Scope

> "Frontiers in Genetics publishes research on genes and genomes relating to all the domains of life," [1]

In plain terms, this is a large open access genetics journal split into 21 specialty sections; a paper is submitted to one section [1]. Two sections fit us. Statistical Genetics and Methodology "is dedicated to publishing research focused on novel data analysis methods" and covers statistical methods for genomics, transcriptomics, and single-cell studies; it turns away disease-focused papers that lack "a strong statistical or methodological component" [2]. Computational Genomics covers work connecting "genomics with mathematics, statistics, and computer science," including multi-omics integration and statistical modeling of biological systems, and does not consider studies lacking sufficient quantitative analysis [3]. One journal-wide rule matters for applied work: "Manuscripts consisting solely of bioinformatics, computational analyses of public data which are not accompanied by" "validation (independent clinical or patient cohort, or biological validation in vitro or in vivo)" "or are not highly innovative are not suitable for publication in this journal." [1] Readers are mainly genomics researchers, with a methods-minded readership in the Statistical Genetics section.

| Paper type | Fit | Why |
|--------------------------------------------|----------|------------------------------------------------|
| Critique with a closed-form bias, simulation, fix, and application | good | The Statistical Genetics and Methodology section publishes statistical method work for transcriptomics [2], and co-expression method comparisons appear (paper 1 below). |
| Simulation and diagnostic, no closed form | good | Simulation studies of how a common analysis fails when its assumptions break appear in the journal (paper 2 below), and the section wants a strong methodological component [2]. |
| Constructive method with theory, simulation, comparison, and application | good | The Statistical Genetics and Methodology section "is dedicated to publishing research focused on novel data analysis methods" [2], and Methods is a listed article type [4]. |
| Short methods note | good | Brief Research Report is a listed type at up to 4,000 words and 4 figures or tables [4]. |
| Theory paper | possible | Hypothesis and Theory is a listed type [4], and the Statistical Genetics section is methods-focused [2], but pure theory with no data is uncommon. |
| Applied analysis | possible | Analyses of public data need independent validation or high innovation [1], so a lupus reanalysis would need a second cohort. |

## Article types that fit

| Article type | Length | Figures and tables | References | Source |
|-------------------|--------------------------|---------------------|-------------|--------|
| Original Research (A-type fee) | at most 12,000 words; sections Abstract, Introduction, Materials and Methods, Results, Discussion | not stated on the site | not stated on the site | [4] |
| Methods (A-type fee) | at most 12,000 words; sections include Materials and Equipment and (Anticipated) Results | not stated on the site | not stated on the site | [4] |
| Brief Research Report (B-type fee) | at most 4,000 words | at most 4 figures or tables | not stated on the site | [4] |
| Technology and Code (A-type fee; for the R package) | at most 12,000 words; must give project link, operating system, language, and any use restrictions | not stated on the site | not stated on the site | [4] |
| Hypothesis and Theory (A-type fee) | at most 12,000 words | not stated on the site | not stated on the site | [4] |

## Abstract

- Structured: not settled by the site: the Frontiers-wide guidelines say the abstract "should be structured, for example, according to the IMRAD format" yet also "no longer than a single paragraph," and defer to the article type's requirements [5], [6]; the article-types page gives no abstract format [4]
- Headings: none stated
- Word limit: not stated on the site [4], [5], [6]

## Reference style

- The journal's stated style: author-year (Frontiers Harvard). The guidelines say "Frontiers' journals use one of two reference styles, either Harvard (author-date) or Vancouver (numbered)" and point to a help-center table [5], [6]; the Frontiers journal style table PDF lists "Frontiers in Genetics" with "Frontiers Harvard" [10]. The help-center page itself returned HTTP 404 (see below), so the PDF, dated 2023, is the only confirmation.
- CSL file: `dependent/frontiers-in-genetics.csl` in the official styles repository (github.com/citation-style-language/styles, commit d2cc420, 2026-10-24), a dependent style whose parent is `frontiers.csl`.
- File to use in Quarto: `csl/frontiers.csl`, which renders offline. The journal-named `csl/dependent/frontiers-in-genetics.csl` gives the same output but needs a network connection, because pandoc fetches the parent at render time.
- Rendering test: both files passed on 2026-10-27 (`csl/test-results.md`).

## Supplement, code, and data

- Supplementary material: supplementary files are deposited to figshare and receive a DOI [5].
- Data availability statement: required: "Data availability statements are required for all articles published with Frontiers," and the submission form asks where the raw data are [7]. Deposited datasets go in the reference list [5].
- Code: encouraged, not required: "We strongly encourage authors to make available all statistical analysis code," and "where possible code should be uploaded to an online repository" such as GitHub or Code Ocean [7]. No deadline (submission or acceptance) is set, and no reproducibility review is stated. Technology and Code articles must give a project link [4].

## AI-use policy

> "Authors should not list a generative AI technology as a co-author or author of any submitted manuscript." Use "must be acknowledged in the acknowledgements section of the manuscript and the methods section if applicable." [5]

- "This explanation must list the name, version, model, and source of the generative AI technology." [5]
- Authors are encouraged to upload prompts and outputs as supplementary files, and are responsible for checking the factual accuracy of AI-generated content [5].
- Images: "Figures produced by or edited using a generative AI technology must be checked" to make sure they accurately reflect the manuscript's data [5].
- The policy is in the Frontiers-wide author guidelines, which the journal's own author-guidelines page repeats [5], [6].
- Read at: https://www.frontiersin.org/guidelines/author-guidelines, 2026-10-27.
- What the manuscript must do: put an AI statement in the Acknowledgments (and in the Methods if AI touched the analysis) giving each tool's name, version, model, and source.

## Open access and charges

- Model: fully open access [9]
- Article processing charge: CHF 3,150 for A-type articles (Original Research, Methods, Technology and Code) and CHF 2,500 for B-type articles (Brief Research Report), read 2026-10-27 [8]. Prices are given only in Swiss francs; no USD price and no effective date are stated; VAT or local taxes are added where applicable [8], [9].
- Waivers and institutional agreements: authors in World Bank low or lower-middle income countries may qualify for discounts, and a fee support application form is linked [8]; fee support requests "will in no way influence" acceptance [9]; partner institutions give full or partial APC support, including flat-fee agreements [8], [9].

## Review

- Model: single anonymized, with reviewer names published: "The reviewers' identities are not made visible to the author," and "Editor and Reviewer names and affiliations are published on all Frontiers' articles." Authors and reviewers interact in an interactive review stage [1], [7].
- Time to decision: not stated on the site [1], [11].

## Recent papers like ours

1. Arbet J, Zhuang Y, Litkowski E, Saba L, Kechris K (2021). Comparing Statistical Tests for Differential Network Analysis of Gene Modules. *Frontiers in Genetics*. https://doi.org/10.3389/fgene.2021.630215. A simulation comparison of tests for differential co-expression with an R package (discoMod), close to our co-expression network work.
2. Abbas-Aghababazadeh F, Xu W, Haibe-Kains B (2023). The impact of violating the independence assumption in meta-analysis on biomarker discovery. *Frontiers in Genetics*. https://doi.org/10.3389/fgene.2022.1027345. Shows by simulation and real pharmacogenomic data that a common practice biases a standard method, our critique structure.
3. Zhang W, Tian Z, Peng L (2025). Reference-free deconvolution of complex samples based on cross-cell-type differential analysis: Systematic evaluations with various feature selection options. *Frontiers in Genetics*. https://doi.org/10.3389/fgene.2025.1570781. A systematic evaluation of deconvolution choices, close to our cell-composition work.

## Not stated on the site, or could not be read

- Abstract word limit and whether headings are required: not stated on the site (article types [4], author guidelines [5], [6]).
- Figure and table limits for Original Research, Methods, and Technology and Code: not stated on the site [4].
- Reference limits: not stated on the site [4].
- Time to first decision or acceptance: not stated on the site (about page [1], home page [11]).
- APC in USD and fee effective date: not stated on the site [8], [9].
- Code deposition deadline: not stated on the site [7].
- The help-center page on reference styles, https://zendesk.frontiersin.org/hc/en-us/articles/360017860337-What-reference-style-does-each-journal-use-, could not be read (HTTP 404); the 2023 style-table PDF [10] was used instead.
- The section pages without `/about` (https://www.frontiersin.org/journals/genetics/sections/statistical-genetics-and-methodology and the Computational Genomics equivalent) gave no scope text; the `/about` pages [2], [3] did.

## Table row

```
scope_5_words: genetics and genomics, sectioned
audience: both
fit_critique: good
fit_sim_diagnostic: good
fit_constructive: good
fit_short_note: good
fit_theory: possible
fit_applied: possible
abstract_format: not stated (single paragraph; IMRAD structure suggested)
abstract_words: not stated
length_limit: Original Research, 12,000 words
apc: CHF 3,150 (Brief Research Report CHF 2,500)
oa_model: open access
ai_policy_3_words: disclose in Acknowledgments
review_model: single
guidelines_read: partly
```
