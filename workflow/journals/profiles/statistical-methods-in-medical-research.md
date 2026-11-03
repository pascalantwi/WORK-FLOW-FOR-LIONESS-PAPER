# Statistical Methods in Medical Research

| Field | Value |
|-----------------|--------------------------------------------------------------|
| Publisher | Sage |
| Online ISSN | 1477-0334 [3] |
| Profile written | 2026-10-27 |

## Sources

Every page below was read on the date shown. Bracketed numbers in the text point here.

1. [Submission Guidelines: Statistical Methods in Medical Research, Sage Journals (PDF copy of the guidelines page hosted on sagepub.com; file created 26 May 2026)](https://www.sagepub.com/docs/default-source/msg/SMM), read 2026-10-27.
2. [Sage Choice (hybrid open access) page](https://www.sagepub.com/en-us/nam/sage-choice), read 2026-10-27.
3. [Hybrid Open Access (Sage Choice) APCs 2026, price list (xlsx), linked from the Sage Choice page](https://www.sagepub.com/docs/default-source/rp-pages/info-for-authors/hybrid-oa-sage-choice/sage-choice-price-list-2026---external.xlsx?sfvrsn=4e6e819b_8), read 2026-10-27.
4. [Sage, Artificial intelligence policy](https://www.sagepub.com/journals/publication-ethics-policies/artificial-intelligence-policy), read 2026-10-27.
5. [Statistical Methods in Medical Research, Sage services journal page](https://services.sagepub.com/journal/statistical-methods-in-medical-research/), read 2026-10-27.
6. [Submission guidelines, live page on Sage Journals](https://journals.sagepub.com/author-instructions/SMM), read 2026-10-27 through Claude in Chrome.
7. [SMMR ScholarOne submission site](https://mc.manuscriptcentral.com/smmr), could not be read (HTTP 403), tried 2026-10-27.
8. [Crossref REST API, works filtered to ISSN 0962-2802](https://api.crossref.org/works?filter=issn:0962-2802,from-pub-date:2021), queried 2026-10-27, and each DOI below confirmed at `https://api.crossref.org/works/<DOI>`.

The live guidelines page [6] confirms Sage's PDF copy of it [1], dated 26 May 2026, so the guideline facts below hold on the live page as well.

## Scope

> "The aim of the journal is to publish both review types detailing the way particular statistical methods are (and could be) employed within medical research, and, accounts of innovative methodological developments or applications." [1]

In plain terms, SMMR publishes medical statistics methods papers written for a broad audience. The guidelines say papers "should include a motivating example" and that "material of a very technical nature should be relegated to an appendix" [1]. Sage describes it as "the leading vehicle for articles in all the main areas of medical statistics" [5]. Readers are medical statisticians. Our critique fits well if the derivations go to an appendix and the lupus data serve as the motivating example; genomics is a smaller topic here than clinical trials and epidemiology.

| Paper type | Fit | Why |
|--------------------------------------------|----------|------------------------------------------------|
| Critique with a closed-form bias, simulation, fix, and application | good | The journal wants accounts of how methods are and could be used, with a motivating example, which a critique with a fix supplies. |
| Simulation and diagnostic, no closed form | possible | A diagnostic with a motivating example fits, though the journal frames papers around methods and reviews. |
| Constructive method with theory, simulation, comparison, and application | good | The aims name "accounts of innovative methodological developments" [1], and new tests and distance-based methods with simulation and an application appear (papers 1 to 3 below), with technical material in an appendix [1]. |
| Short methods note | poor | The only short type is a 1,500-word letter to the editor; research papers are expected to run about 8,000 words. |
| Theory paper | poor | Very technical material is to be moved to an appendix, and papers must be accessible to a broad audience. |
| Applied analysis | poor | The journal publishes methods and reviews, not substantive analyses. |

## Article types that fit

| Article type | Length | Figures and tables | References | Source |
|-------------------|--------------------------|---------------------|-------------|--------|
| Paper (review of methods in use, or methodological development) | around 8,000 words; each diagram or table counts as about 200 words; appendix up to 2,500 words | counted within the word total | not stated on the site | [1], [6] |
| Letter to the Editor | at most 1,500 words, no abstract | at most 2 tables or illustrations | up to 20 | [1], [6] |

## Abstract

- Structured: no, "an unstructured abstract of up to 200 words" [1], [6]
- Headings: none; it should state "the purpose of the research, major findings, and conclusions" [1]
- Word limit: 200 [1], [6]
- At least 5 keywords follow the abstract [1], [6].

## Reference style

- The journal's stated style: "The journal follows the Sage Vancouver reference style." Papers not following the journal's reference style are returned to authors [1], [6].
- CSL file: `sage-vancouver.csl` in the official styles repository (github.com/citation-style-language/styles, commit d2cc420, 2026-10-24), an independent style. It is the Sage Vancouver style the site names.
- File to use in Quarto: `csl/sage-vancouver.csl`.
- Rendering test: passed on 2026-10-27 (`csl/test-results.md`).

## Supplement, code, and data

- Supplementary material: the journal "can host additional materials online (e.g. datasets, podcasts, videos, images etc.) alongside the full text of the article" [1].
- Data availability statement: the title page must include one [1]. Under the journal's data sharing policy, authors are "encouraged to" share data in a public repository and "Include a data availability statement linking to your data", or explain why data cannot be shared [1]. The live page confirms that sharing data and including a data availability statement are encouraged [6].
- Code: not stated on the site; no code policy or repository requirement appears in the guidelines [1], [6].
- A "Statements and Declarations" section on the title page is required, with each subheading present even when "Not applicable" [1].

## AI-use policy

> "Please note that AI chatbots, for example ChatGPT, should not be listed as authors." [1], [6]

> Sage distinguishes uses that are "assistive (and no longer requiring disclosure), generative (requiring disclosure), and prohibitive." [4]

- Generative AI use that "directly impacts the research methodology, analysis, results and/or conclusions" must be disclosed "upon submission so the editorial team can evaluate the content generated", within the methods or acknowledgements [4]. "Generated images that are presented as unique or novel research images" are prohibited; representative illustrations made with AI are allowed with disclosure [4].
- The journal guidelines point authors to Sage's Publication Ethics Policies, which include "authors' appropriate disclosure of AI use as well as a list of prohibited uses of AI" [1]; the Sage policy page [4] is that publisher-wide policy. The Sage page itself does not address AI authorship; the journal guidelines do [1].
- The live guidelines page [6] carries the same authorship sentence and links to the Sage-wide policy [4]; it adds no journal-specific AI rule.
- Read at: https://www.sagepub.com/journals/publication-ethics-policies/artificial-intelligence-policy, https://journals.sagepub.com/author-instructions/SMM, and [1], 2026-10-27.
- What the manuscript must do: disclose any generative AI use that affected methods, analysis, or results in the Methods or Acknowledgements at submission, skip disclosure for grammar-level help, and never list AI as an author.

## Open access and charges

- Model: hybrid. The guidelines list "Access: Subscription" and say "There are no fees payable to submit or publish in this journal" [1], [6], and "Optional open access publishing is available for a fee via the Sage Choice program" [1].
- Article processing charge: USD 4,710 for Sage Choice (about GBP 3,454 also listed), from the 2026 Sage Choice price list, read 2026-10-27 [3]. Color in print is charged separately, and "Open access fees do not cover color charges" [1].
- Waivers and institutional agreements: through Sage's open access agreements, authors may publish open access "either discounted or free of charge depending on the agreement with Sage", with eligibility set by the corresponding author's affiliation at acceptance [1]. The Sage Choice page adds that "Funding or discounted fees may be available through your institution or library" [2].

## Review

- Model: double anonymized. "The journal adheres to a rigorous double-anonymized reviewing policy", and two independent reviews are required to reach a Revise or Accept decision [1]. The live page lists "Identity transparency: Double-anonymized" and "Review information published: None", requires two independent reviews, and does not let authors recommend reviewers [6].
- Time to decision: not stated on the site [1], [6]; the journal metrics page on journals.sagepub.com could not be read.

## Recent papers like ours

1. Štefelová N, Palarea-Albaladejo J, Martín-Fernández J (2026). A permutation test of differences between externally or internally defined groupings in compositional data sets. *Statistical Methods in Medical Research* 35(3):601 to 625. https://doi.org/10.1177/09622802251413737. A permutation test for group differences in compositional data, close to our PERMANOVA and cell-composition work.
2. Qayed A, Han D (2021). High-dimensional covariance matrices tests for analyzing multi-tumor gene expression data. *Statistical Methods in Medical Research* 30(8):1904 to 1916. https://doi.org/10.1177/09622802211009257. Tests whether gene covariance structure differs between groups, the question behind differential co-expression, with real expression data.
3. Johns H, Bernhardt J, Churilov L (2021). Distance-based Classification and Regression Trees for the analysis of complex predictors in health and medical research. *Statistical Methods in Medical Research* 30(9):2085 to 2104. https://doi.org/10.1177/09622802211032712. A distance-based method with simulation and a medical application, the same distance-based family as PERMANOVA.

## Not stated on the site, or could not be read

- Reference limit for research papers: not stated on the site [1].
- Code policy and repository requirement: not stated on the site [1], [6].
- Time to first decision or acceptance: not stated in the guidelines [1], [6]; the metrics page on journals.sagepub.com could not be read.
- Aims and scope page: could not be read on journals.sagepub.com; the scope quotation comes from the Article types section of the guidelines [1].
- ScholarOne submission site: could not be read (HTTP 403) [7].

Contradictions:

- None found. The live guidelines page [6] matches the PDF copy [1] on access, fees, length, abstract, references, data, AI, and review.

## Table row

```
scope_5_words: medical statistics methods and reviews
audience: methodologists
fit_critique: good
fit_sim_diagnostic: possible
fit_constructive: good
fit_short_note: poor
fit_theory: poor
fit_applied: poor
abstract_format: unstructured
abstract_words: 200
length_limit: paper, around 8,000 words
apc: none required (open access USD 4,710)
oa_model: hybrid
ai_policy_3_words: disclose generative use
review_model: double
guidelines_read: yes
```
