# Journal of Computational Biology

| Field | Value |
|-----------------|--------------------------------------------------------------|
| Publisher | Sage (formerly Mary Ann Liebert; liebertpub.com now redirects to Sage Journals [6]); society affiliation RECOMB [2] |
| Online ISSN | 1557-8666 [4] |
| Profile written | 2026-10-27 |

## Sources

Every page below was read on the date shown. Bracketed numbers in the text point here.

1. [Submission Guidelines: Journal of Computational Biology, Sage Journals (PDF copy of the guidelines page hosted on sagepub.com; file created 21 May 2026)](https://www.sagepub.com/docs/default-source/msg/CPB), read 2026-10-27.
2. [Journal of Computational Biology, Sage services journal page](https://services.sagepub.com/journal/journal-of-computational-biology/), read 2026-10-27.
3. [Sage Choice (hybrid open access) page](https://www.sagepub.com/en-us/nam/sage-choice), read 2026-10-27.
4. [Hybrid Open Access (Sage Choice) APCs 2026, price list (xlsx), linked from the Sage Choice page](https://www.sagepub.com/docs/default-source/rp-pages/info-for-authors/hybrid-oa-sage-choice/sage-choice-price-list-2026---external.xlsx?sfvrsn=4e6e819b_8), read 2026-10-27.
5. [Sage, Artificial intelligence policy](https://www.sagepub.com/journals/publication-ethics-policies/artificial-intelligence-policy), read 2026-10-27.
6. [Journal of Computational Biology, Liebert page](https://www.liebertpub.com/journal/cmb), redirects to journals.sagepub.com, which could not be read, tried 2026-10-27.
7. [Submission guidelines, live page on Sage Journals](https://journals.sagepub.com/author-instructions/CPB), read 2026-10-27 through Claude in Chrome.
8. [Crossref REST API, works filtered to ISSN 1066-5277](https://api.crossref.org/works?filter=issn:1066-5277,from-pub-date:2021), queried 2026-10-27, and each DOI below confirmed at `https://api.crossref.org/works/<DOI>`.

The live guidelines page [7] matches Sage's PDF copy of it [1], dated 21 May 2026, including the two contradictions listed at the end of this profile.

## Scope

> "The leading peer-reviewed journal in computational biology and bioinformatics, publishing in-depth statistical, mathematical, and computational analysis of methods, as well as their practical impact." [2]

In plain terms, JCB is the RECOMB-affiliated methods journal for computational biology. Sage says it publishes "articles whose primary contributions are the development and application of new methods in computational biology, including algorithmic, statistical, mathematical, machine learning, and artificial intelligence contributions" [2]. Readers are computational biologists and bioinformaticians, many from computer science. The phrase "in-depth statistical, mathematical, and computational analysis of methods" fits our critique papers well, provided the fix is presented as a new method. Two practical points: mandatory page charges of $90 per page on acceptance, and a 3,000-word target for research articles [1], [7].

| Paper type | Fit | Why |
|--------------------------------------------|----------|------------------------------------------------|
| Critique with a closed-form bias, simulation, fix, and application | good | The journal publishes in-depth analysis of methods and their practical impact, and the fix supplies the new method it asks for. |
| Simulation and diagnostic, no closed form | possible | Evaluation of methods is in scope, but the primary contribution is expected to be a new method. |
| Constructive method with theory, simulation, comparison, and application | good | The primary contribution is expected to be "the development and application of new methods", statistical ones included [2], though the 3,000-word target pushes the theory into the supplement [1], [7]. |
| Short methods note | possible | Research articles have a 3,000-word limit and software articles run 2 to 4 pages, both suited to short work. |
| Theory paper | possible | Mathematical analysis of methods is named in the scope, though readers expect computational relevance. |
| Applied analysis | poor | The primary contribution must be a new method, not a data analysis. |

## Article types that fit

| Article type | Length | Figures and tables | References | Source |
|-------------------|--------------------------|---------------------|-------------|--------|
| Research Article | 3,000-word limit excluding tables, figures, legends, abstract, disclosure, and references; "Longer articles may also be submitted" | not stated on the site | not stated on the site | [1], [7] |
| Software Article | approximately 2 to 4 pages, with a cover letter stating the novel implementation and algorithmic challenges | not stated on the site | not stated on the site | [1], [7] |

## Abstract

- Structured: yes [1], [7]
- Headings: not stated on the site [1], [7]
- Word limit: 250 ("Structured abstract of no more than 250 words") [1], [7]
- At least 4 keywords follow the abstract [1].

## Reference style

- The journal's stated style: "The journal follows the Sage Harvard reference style." [1] The live page names the same Sage Harvard style [7].
- CSL file: `dependent/journal-of-computational-biology.csl` in the official styles repository (github.com/citation-style-language/styles, commit d2cc420, 2026-10-24), a dependent style whose parent is `mary-ann-liebert-harvard.csl`. That parent predates the journal's move to Sage; the site now names Sage Harvard, so use `sage-harvard.csl` instead.
- File to use in Quarto: `csl/sage-harvard.csl`, the style the site names. The repository's journal file (`csl/dependent/journal-of-computational-biology.csl`) is kept for the record only.
- Rendering test: both files passed on 2026-10-27 (`csl/test-results.md`).

## Supplement, code, and data

- Supplementary material: the journal "can host additional materials online (e.g. datasets, podcasts, videos, images etc.) alongside the full text of the article" [1].
- Data availability statement: the title page must include one, and the statements section has a "Data and Software Availability" heading [1]. Under the data policy, authors are "encouraged to" share data in a public repository and "Include a data availability statement linking to your data", or explain why data cannot be shared [1].
- Code: "If your manuscript includes empirical results generated from software you have developed, please include in this section a link to the software at a freely available and stable URL (e.g. github)." [1], [7] This applies at submission, since the statement is part of the submitted title page; the guidelines do not separately require a repository at acceptance.

## AI-use policy

> "Please note that AI chatbots, for example ChatGPT, should not be listed as authors." [1], [7]

> Sage distinguishes uses that are "assistive (and no longer requiring disclosure), generative (requiring disclosure), and prohibitive." [5]

- Generative AI use that "directly impacts the research methodology, analysis, results and/or conclusions" must be disclosed "upon submission so the editorial team can evaluate the content generated", within the methods or acknowledgements [5]. "Generated images that are presented as unique or novel research images" are prohibited; representative illustrations made with AI are allowed with disclosure [5].
- The journal guidelines point authors to Sage's Publication Ethics Policies, which include "authors' appropriate disclosure of AI use as well as a list of prohibited uses of AI" [1]; the Sage policy page [5] is that publisher-wide policy. The live guidelines page [7] links to the same Sage policy and adds no journal-specific AI rule.
- Read at: https://www.sagepub.com/journals/publication-ethics-policies/artificial-intelligence-policy, https://journals.sagepub.com/author-instructions/CPB, and [1], 2026-10-27.
- What the manuscript must do: disclose any generative AI use that affected methods, analysis, or results in the Methods or Acknowledgements at submission, skip disclosure for grammar-level help, and never list AI as an author.

## Open access and charges

- Model: hybrid. The guidelines list "Access: Subscription" [1], [7], and "Optional open access publishing is available for a fee via the Sage Choice program" [1]; the live page confirms the optional Sage Choice route [7]. The journal is online only [1].
- Article processing charge: USD 4,440 for Sage Choice (about GBP 3,256 also listed), from the 2026 Sage Choice price list, read 2026-10-27 [4]. Separately, every accepted paper pays mandatory "Page Charges (assessed upon acceptance): $90/page" [1], [7], and "Open access fees do not cover page or color charges" [1].
- Waivers and institutional agreements: through Sage's open access agreements, authors may publish open access "either discounted or free of charge depending on the agreement with Sage", with eligibility set by the corresponding author's affiliation at acceptance [1]. The Sage Choice page adds that "Funding or discounted fees may be available through your institution or library" [3]. No waiver of page charges is stated [1].

## Review

- Model: single anonymized, as listed in "Identity transparency: Single anonymized" [1], [7]. The same page contradicts this: it also says "The journal adheres to a rigorous double-anonymized reviewing policy" and asks for a fully anonymized manuscript [1], [7] with a separate title page [1]. The live page still carries both statements [7]. Prepare an anonymized manuscript to be safe.
- Time to decision: not stated on the site [1], [7]; the metrics page on journals.sagepub.com could not be read.

## Recent papers like ours

1. Lee C, Song D, Chen S, Li J (2026). ClusterDE: A Statistical Software Package for Removing Double-Dipping Bias in Post-Clustering Differential Expression Analysis. *Journal of Computational Biology* 33(1):36 to 42. https://doi.org/10.1177/15578666251383562. Addresses a bias in a widely used single-cell workflow and ships the fix as software, the same shape as our critique plus R package.
2. Zheng H, Ma C, Kingsford C (2022). Deriving Ranges of Optimal Estimated Transcript Expression due to Nonidentifiability. *Journal of Computational Biology* 29(2):121 to 139. https://doi.org/10.1089/cmb.2021.0444. Analyzes what a standard RNA-seq quantification actually identifies, close to our "what does it really estimate" question.
3. Mcloughlin A, Huang H (2022). Shared Differential Expression-Based Distance Reflects Global Cell Type Relationships in Single-Cell RNA Sequencing Data. *Journal of Computational Biology* 29(8):867 to 879. https://doi.org/10.1089/cmb.2021.0652. A distance-based analysis of cell types in expression data, related to our distance-based and cell-composition work.

## Not stated on the site, or could not be read

- Liebert page: https://www.liebertpub.com/journal/cmb redirects to journals.sagepub.com and could not be read [6].
- Figure, table, and reference limits for research and software articles: not stated on the site [1].
- Abstract headings: not stated on the site; only "structured" is specified [1], [7].
- Time to first decision or acceptance: not stated in the guidelines [1], [7]; the metrics page could not be read.

Contradictions:

- Peer review model: "Identity transparency: Single anonymized" in the summary, but "The journal adheres to a rigorous double-anonymized reviewing policy" in the peer review text. Both appear in the PDF copy [1] and on the live page [7].
- Research article length: a "3,000-word limit" alongside "Longer articles may also be submitted." Both appear in the PDF copy [1] and on the live page [7].

## Table row

```
scope_5_words: computational biology and bioinformatics methods
audience: both
fit_critique: good
fit_sim_diagnostic: possible
fit_constructive: good
fit_short_note: possible
fit_theory: possible
fit_applied: poor
abstract_format: structured: headings not stated
abstract_words: 250
length_limit: research article, 3,000 words (longer accepted)
apc: USD 90 per page (open access USD 4,440)
oa_model: hybrid
ai_policy_3_words: disclose generative use
review_model: single
guidelines_read: yes
```
