# NAR Genomics and Bioinformatics

| Field | Value |
|-----------------|--------------------------------------------------------------|
| Publisher | Oxford University Press; no society named on the pages read [3] |
| Online ISSN | 2631-9268 [3] |
| Profile written | 2026-10-27 |

## Sources

Every page below was read on the date shown. Bracketed numbers in the text point here.

1. [NAR Genomics and Bioinformatics: Author guidelines](https://academic.oup.com/nargab/pages/author-guidelines), read 2026-10-27.
2. [NAR Genomics and Bioinformatics: Scope and Criteria](https://academic.oup.com/nargab/pages/scope_and_criteria), read 2026-10-27.
3. [NAR Genomics and Bioinformatics: About](https://academic.oup.com/nargab/pages/About), read 2026-10-27.
4. [Nucleic Acids Research: General Instructions](https://academic.oup.com/nar/pages/General_Instructions), linked from [1] as the guidelines standard papers must follow, read 2026-10-27.
5. [OUP: Charges, licences, and self-archiving](https://academic.oup.com/pages/open-research/open-access/charges-licences-and-self-archiving), read 2026-10-27; its "What is the OA charge for my article?" calculator read 2026-10-27 through Claude in Chrome, with no Low and Middle Income Countries discount and no society membership selected.
6. [OUP: Policy on AI Use and Disclosure for OUP Journals Authors](https://academic.oup.com/pages/for-authors/journals/preparing-and-submitting-your-manuscript/ai-principles-for-oxford-journals/policy-on-ai-use-and-disclosure-for-oxford-journals-authors), read 2026-10-27.
7. [Crossref REST API record lookups for the DOIs under "Recent papers like ours"](https://api.crossref.org/works), read 2026-10-27.

## Scope

> "NAR Genomics and Bioinformatics is an interdisciplinary journal focused on genomics and bioinformatics large-scale data analysis ... It aims at providing the community with high quality results, analysis and methods" [2]

NAR Genomics and Bioinformatics is the open access sibling of Nucleic Acids Research for large-scale genomic data analysis. It wants methods that are benchmarked "against an adequate number of relevant alternative state of the art technologies," open source under an OSI licence, and suited to large data [2]. Readers are genomics and bioinformatics practitioners. A critique that ships an open-source fix and shows it on public RNA-seq data fits well, as does a short note on a single result.

| Paper type | Fit | Why |
|--------------------------------------------|----------|------------------------------------------------|
| Critique with a closed-form bias, simulation, fix, and application | good | A Standard or Methods paper that establishes "a novel result" with open-source code and explicit benchmarks matches the stated criteria [2]. |
| Simulation and diagnostic, no closed form | possible | Benchmark work fits, but Methods and Benchmark Surveys expect "an exhaustive combination of benchmarks" and a strong author track record [2]. |
| Constructive method with theory, simulation, comparison, and application | possible | A Methods paper fits if the method is open source and benchmarked "against an adequate number of relevant alternative state of the art technologies" [2], but the readers are practitioners, so the theory carries little weight. |
| Short methods note | good | Application Notes are brief communications on "a single result or method," at most 3,000 words [2]. |
| Theory paper | poor | The journal focuses on large-scale data analysis, not theory. |
| Applied analysis | possible | Standard papers can report a novel genomic result from large-scale data analysis [2]. |

## Article types that fit

| Article type | Length | Figures and tables | References | Source |
|-------------------|--------------------------|---------------------|-------------|--------|
| Standard Paper | not stated on the site | not stated on the site | not stated on the site | [2] |
| Methods Paper | not stated on the site | not stated on the site | not stated on the site | [2] |
| Application Note | at most 3,000 words | 3 figures or tables, or equivalent | 30 | [2] |
| Methods and Benchmark Survey | not stated on the site; contact the Editor first | not stated on the site | not stated on the site | [2] |

## Abstract

- Structured: not stated on the site [1, 2]; the manuscript preparation section of the NAR instructions that standard papers must follow could not be read [4].
- Headings: not stated on the site.
- Word limit: not stated on the site.

## Reference style

- The journal's stated style: not stated on the site. The guidelines say "Standard papers are expected to be compliant with" the NAR General Instructions [1, 4], but the manuscript preparation section of that page did not appear in the loaded text.
- CSL file: no file for this journal in the official styles repository (github.com/citation-style-language/styles, commit d2cc420, 2026-10-24). The site defers standard papers to the NAR General Instructions, so the substitute is `nucleic-acids-research.csl`.
- File to use in Quarto: `csl/nucleic-acids-research.csl`, a substitute chosen by the coordinator, not by the journal.
- Rendering test: `csl/nucleic-acids-research.csl` passed on 2026-10-27 (`csl/test-results.md`).

## Supplement, code, and data

- Supplementary material: data go first in a public repository, with supplementary files as the fallback when repositories are not possible [1].
- Data availability statement: required ("The inclusion of a data availability statement is a requirement for papers published in the Journal") [1].
- Code: required before submission. The journal "will only consider for publication contributions whose novel bioinformatics components are open source" [1]; "Software and source codes" are listed among the data types that "must be deposited prior to submission" [1]; software must carry an OSI-recognized licence and follow FAIR principles, with GitHub and Zenodo named [2]. Public web services must stay available two years without registration [2]. No reproducibility review is described.

## AI-use policy

> "Natural language processing tools driven by artificial intelligence (AI) do not qualify as authors, and the Journal will screen for them in author lists." [1]

> "The use of AI (for example, to help generate content or images, write code, process data, or for translation) should be disclosed both in cover letters to editors and in the Methods or Acknowledgements section of manuscripts." [1]

The journal's own section points to the COPE position statement on authorship and AI and does not restrict uses further [1]. Unlike the ISCB journals, it does not ban drafting with LLMs or require documentation in the supplement. OUP's publisher-wide policy [6] also applies to OUP journal authors: it treats substantial rewriting, translation, data analysis, and code generation as "typically permitted WITH disclosure," allows AI-generated illustrative images with disclosure, and forbids "Creating or altering primary factual, scientific, or technical images"; where a journal's guidance differs, the journal's wins.

- Read at: https://academic.oup.com/nargab/pages/author-guidelines, 2026-10-27.
- What the manuscript must do: disclose any AI use (writing, code, data processing, images, translation) in the cover letter and in the Methods or Acknowledgements, and list no AI tool as an author.

## Open access and charges

- Model: fully open access, four issues a year [1].
- Article processing charge: USD 3,035 for a Standard Article and USD 3,035 for a Methods Article, from OUP's charge calculator with no discount selected; prices exclude sales taxes and are "subject to change" [5].
- Waivers and institutional agreements: a Low and Middle Income Countries discount and Read and Publish agreements, as on the OUP charges page [1, 5].

## Review

- Model: single anonymized; manuscripts are "typically sent to 2 reviewers" [1].
- Time to decision: 2025 median of 44 days from submission to first decision [3].

## Recent papers like ours

1. Sturm G, List M, Zhang JD (2021). Tissue heterogeneity is prevalent in gene expression studies. *NAR Genomics and Bioinformatics* 3, lqab077. https://doi.org/10.1093/nargab/lqab077. Shows that unintended cell-composition differences are common across thousands of public datasets, the problem our composition-adjustment papers address [7].
2. Svoboda M, Frost HR, Bosco G (2022). Internal oligo(dT) priming introduces systematic bias in bulk and single-cell RNA sequencing count data. *NAR Genomics and Bioinformatics* 4, lqac035. https://doi.org/10.1093/nargab/lqac035. Documents a systematic bias in a near-universal RNA-seq step across public data, a critique of a widely used procedure [7].
3. Schlegel L, Gómez Cano F, Marand AP, Johannes F (2026). Power-law penalties correct distance bias in single-cell co-accessibility and deep-learning chromatin interaction predictions. *NAR Genomics and Bioinformatics* 8, lqag063. https://doi.org/10.1093/nargab/lqag063. Identifies a systematic bias in widely used co-accessibility scores and gives a model-based correction, the critique-then-fix pattern [7].

## Not stated on the site, or could not be read

- Abstract format and word limit: not stated on [1] or [2]; the manuscript preparation section of https://academic.oup.com/nar/pages/General_Instructions did not appear in the loaded text (could not be read).
- Reference style: same as above.
- Length, figure, and reference limits for Standard and Methods papers: not stated on [2].
- Reproducibility review: not stated on the site.

## Table row

```
scope_5_words: large-scale genomics data analysis methods
audience: genomics users
fit_critique: good
fit_sim_diagnostic: possible
fit_constructive: possible
fit_short_note: good
fit_theory: poor
fit_applied: possible
abstract_format: not stated
abstract_words: not stated
length_limit: Application Note, 3,000 words; Standard Paper not stated
apc: USD 3,035
oa_model: open access
ai_policy_3_words: disclose, no authorship
review_model: single
guidelines_read: partly
```
