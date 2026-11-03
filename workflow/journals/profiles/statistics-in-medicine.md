# Statistics in Medicine

| Field | Value |
|-----------------|--------------------------------------------------------------|
| Publisher | Wiley |
| Online ISSN | 1097-0258 [1] |
| Profile written | 2026-10-27 |

## Sources

Every page below was read on the date shown. Bracketed numbers in the text point here.

1. [Statistics in Medicine, Wiley journal page](https://www.wiley.com/en-us/journals/Statistics+in+Medicine-p-10970258), read 2026-10-27.
2. [Using AI tools in your research (Wiley AI guidelines)](https://www.wiley.com/en-us/publishing/article/ai-guidelines), read 2026-10-27.
3. [Wiley Author Services, Ethics guidelines (AI section)](https://authors.wiley.com/ethics-guidelines/index.html), read 2026-10-27.
4. [Wiley Author Services, Article Publication Charges](https://authors.wiley.com/author-resources/Journal-Authors/open-access/article-publication-charges/index.html), read 2026-10-27.
5. [Wiley Author Services, Make your article open access in hybrid journals](https://authors.wiley.com/author-resources/Journal-Authors/open-access/hybrid-open-access/index.html), read 2026-10-27.
6. [Wiley Article Publication Charges for Hybrid Open Access Journals, price list (xlsx, "Updated: 12 October 2026")](https://authors.wiley.com/asset/Wiley-Journal-APCs-OnlineOpen.xlsx), read 2026-10-27.
7. [Statistics in Medicine author guidelines, Wiley Online Library](https://onlinelibrary.wiley.com/page/journal/10970258/homepage/forauthors.html), read 2026-10-27 through Claude in Chrome (automated readers had received HTTP 403 earlier the same day).
8. [Statistics in Medicine ScholarOne submission site](https://mc.manuscriptcentral.com/sim), could not be read (HTTP 403), tried 2026-10-27.
9. [Crossref REST API, works filtered to ISSN 0277-6715](https://api.crossref.org/works?filter=issn:0277-6715,from-pub-date:2021), queried 2026-10-27, and each DOI below confirmed at `https://api.crossref.org/works/<DOI>`.
10. [Statistics in Medicine overview (product information), Wiley Online Library](https://onlinelibrary.wiley.com/page/journal/10970258/homepage/productinformation.html), read 2026-10-27 through Claude in Chrome.
11. [Statistics in Medicine journal metrics, Wiley Online Library](https://onlinelibrary.wiley.com/journal/10970258/journal-metrics), read 2026-10-27 through Claude in Chrome.

## Scope

> "We publish research papers that apply statistical and quantitative methods to medical problems, and clearly explain the implications of the results. We welcome submissions that explain new methods or use existing methods creatively, demonstrated with substantive, real, motivating examples." [1]

> "The main criteria for publication are appropriateness of the statistical methods to a particular medical problem and clarity of exposition. Papers with primarily mathematical content will be excluded." [10]

In plain terms, this is the main methods journal for medical statisticians: new or creatively used methods, each shown working on a real medical data example. Readers are biostatisticians in clinical trials, epidemiology, and public health; the overview lists bioinformaticians among the readers and bioinformatics and human genetics among the keywords [10], and genomics papers appear (differential co-expression, single-cell, microbiome), but they are a minority topic. Besides research articles, the author guidelines name Tutorials in Biostatistics [7]. Our critique papers fit if the lupus application is framed as a medical problem and the method is one medical researchers use.

| Paper type | Fit | Why |
|--------------------------------------------|----------|------------------------------------------------|
| Critique with a closed-form bias, simulation, fix, and application | possible | The main criterion is that the methods suit "a particular medical problem" [10], which a critique with a fix and a lupus application can meet, but genomics is not the journal's core audience. |
| Simulation and diagnostic, no closed form | possible | A diagnostic with a real medical example fits the aims, though the journal stresses methods over pure simulation evidence. |
| Constructive method with theory, simulation, comparison, and application | good | The aims welcome "submissions that explain new methods" shown on real motivating examples [1], and new co-expression and distance-based methods for genomic data appear (papers 1 to 3 below), though "primarily mathematical content" is excluded [10]. |
| Short methods note | poor | The author guidelines name research articles and Tutorials in Biostatistics but no short article type [7]. |
| Theory paper | poor | "Papers with primarily mathematical content will be excluded" [10]. |
| Applied analysis | poor | The journal publishes statistical methods, not substantive data analyses. |

## Article types that fit

| Article type | Length | Figures and tables | References | Source |
|-------------------|--------------------------|---------------------|-------------|--------|
| Research article | not stated on the site | not stated on the site | not stated on the site | [7] |

## Abstract

- Structured: no; a concise summary without citations [7]
- Headings: none
- Word limit: 250 ("Enter an abstract of up to 250 words for all articles", book reviews excepted) [7]; up to six keywords [7]

## Reference style

- The journal's stated style: AMA style, numbered consecutively and cited with "Arabic superscript numerals", with journal names abbreviated as in Chemical Abstracts [7]. Under "Free Format submission", any consistent style is accepted at first submission [7]. LaTeX users can use the Wiley NJD template [7].
- CSL file: no file for this journal in the official styles repository (github.com/citation-style-language/styles, commit d2cc420, 2026-10-24). The site names AMA style with superscript numbers, so the substitute is `american-medical-association.csl` (AMA Manual of Style, 11th edition), which numbers references with superscripts.
- File to use in Quarto: `csl/american-medical-association.csl`, a substitute chosen by the coordinator to match the style the site names. Free Format submission means any consistent style is also accepted at first submission.
- Rendering test: `csl/american-medical-association.csl` passed on 2026-10-27 (`csl/test-results.md`).

## Supplement, code, and data

- Supplementary material: supporting data, code, and simulations are uploaded as "Data Files" at submission [7].
- Data availability statement: a data accessibility statement is published with the article [7]. The journal "expects that data supporting the results reported in the paper will be archived in an appropriate public repository" [7].
- Code: required. "The journal also requires authors to supply any supporting computer code or simulations that allow readers to institute any new methodology proposed in the published article." [7] Scripts used for the analyses should be publicly archived "whenever possible" [7]. So code goes in with the submission as Data Files; a public repository is expected for data and encouraged for scripts, with no stated deadline.

## AI-use policy

> "Authors are expected to carefully review any data generated by or analyzed using AI or related computational techniques and must carry out the final interpretation of the results presented in the manuscript. Additionally, authors are expected to write the initial version of the manuscript themselves, although the use of AI is allowed to assist with language editing in subsequent drafts. Use of AI technology for any purpose including generating scientific content or preparing the manuscript must be clearly described in the Experimental section of the manuscript in sufficient detail to be reproducible." [7]

> "these tools cannot fulfil the role of, nor be listed as, an author of an article." [2]

> "AI Technologies must not be used to generate, modify, or enhance these images, as they require verifiable accuracy." [2] (Here "these images" means factual and evidential images such as research data.)

- The journal's own rule [7] takes precedence over Wiley's publisher-wide guidance [2, 3]. It goes further than Wiley: AI may not draft the first version of the manuscript, only edit the language of later drafts, and every use is described in the Experimental section rather than in the Acknowledgments [7]. Wiley's guidance still applies on authorship and on research images [2], and Wiley says journal editors have final authority over whether AI use is appropriate [2, 3].
- Read at: https://onlinelibrary.wiley.com/page/journal/10970258/homepage/forauthors.html (journal) and https://www.wiley.com/en-us/publishing/article/ai-guidelines (Wiley), 2026-10-27.
- What the manuscript must do: write the first draft without AI; describe any AI use (language editing, analysis, code) in the Experimental section in enough detail to be reproducible; and never list AI as an author.

## Open access and charges

- Model: hybrid (subscription journal with an optional open access route, OnlineOpen); the author guidelines say "Open Access is available" [5, 6, 7]
- Article processing charge: USD 5,720 for hybrid open access (GBP 4,050 and EUR 4,940 also listed), from the price list updated 12 October 2026, read 2026-10-27 [6]. "There is no page charge to authors," and colour is free [7].
- Waivers and institutional agreements: "Author groups who meet specific eligibility criteria may qualify for a discount or waiver on APCs." A Wiley Open Access Account held by an institution, funder, or society may cover all or part of the APC; the price list adds that members of a Wiley transformational agreement may be covered [4, 6]. The author guidelines give no fee or journal-specific waiver [7].

## Review

- Model: single anonymized ("The peer-review process is single-anonymous.") [7]. The journal takes part in the Wiley Refer and Transfer program [7].
- Time to decision: for 2025, median 45 days from submission to first decision and median 275 days from submission to acceptance; acceptance rate 26% [11].

## Recent papers like ours

1. He L, Philipp I, Webster S, Hjelmborg J, Kulminski A (2023). A robust and fast two-sample test of equal correlations with an application to differential co-expression. *Statistics in Medicine* 42(16):2760 to 2776. https://doi.org/10.1002/sim.9747. A two-sample correlation test, the core of differential co-expression, checked by simulation and applied to gene expression data.
2. Bussing A, Marra G, Fan D, Shinohara R, Tu D, Ho Y (2025). scCOSMIX: A Mixed-Effects Framework for Differential Coexpression and Transcriptional Interactions Modeling in Single-Cell RNA-Seq. *Statistics in Medicine* 44(18-19):e70213. https://doi.org/10.1002/sim.70213. Shows the journal takes single-cell co-expression methods, the same territory as our sample-specific network work.
3. Liu J, Xu K, Ferguson J, Kang K, Wang Y, Qiu Y, Shao L, Tu S, Nguyen T, Lin T, Zhang X (2026). Novel Distance Regression for Repeated Outcomes With Missing Data: Applications to Longitudinal and Crossover Studies of Microbiome Beta-Diversity. *Statistics in Medicine* 45(15-17):e70654. https://doi.org/10.1002/sim.70654. A distance-based method for microbiome beta-diversity, the setting where PERMANOVA is the default we critiques.

## Not stated on the site, or could not be read

- Length, figure, table, and reference limits for research articles: not stated on the site (author guidelines, source 7).
- Meaning of "Experimental section" for a statistical methods paper with no section of that name: not stated on the site (source 7).
- Journal-specific APC waivers or society discounts: not stated on the site (source 7).
- ScholarOne submission site: could not be read (https://mc.manuscriptcentral.com/sim, HTTP 403).

Contradictions:

- AI disclosure: Wiley's publisher-wide guidance puts disclosure of drafting help in the Acknowledgments and of analysis help in the Methods [2], and this profile earlier followed it. The journal's guidelines require authors to write the initial version themselves and put every AI disclosure in the Experimental section [7]. The journal's rule governs.

## Table row

```
scope_5_words: statistical methods for medical problems
audience: methodologists
fit_critique: possible
fit_sim_diagnostic: possible
fit_constructive: good
fit_short_note: poor
fit_theory: poor
fit_applied: poor
abstract_format: unstructured
abstract_words: 250
length_limit: Research article: not stated
apc: none required (open access USD 5,720)
oa_model: hybrid
ai_policy_3_words: disclose, no drafting
review_model: single
guidelines_read: yes
```
