# Stat

| Field | Value |
|-----------------|--------------------------------------------------------------|
| Publisher | Wiley; International Statistical Institute (ISI) |
| Online ISSN | 2049-1573 [2] |
| Profile written | 2026-10-27 |

## Sources

Every page below was read on the date shown. Bracketed numbers in the text point here.

1. [Stat, International Statistical Institute journal page](https://isi-web.org/stat), read 2026-10-27.
2. [Stat, Wiley journal page](https://www.wiley.com/en-us/journals/Stat-p-20491573), read 2026-10-27.
3. [Using AI tools in your research (Wiley AI guidelines)](https://www.wiley.com/en-us/publishing/article/ai-guidelines), read 2026-10-27.
4. [Wiley Author Services, Ethics guidelines (AI section)](https://authors.wiley.com/ethics-guidelines/index.html), read 2026-10-27.
5. [Wiley Author Services, Article Publication Charges](https://authors.wiley.com/author-resources/Journal-Authors/open-access/article-publication-charges/index.html), read 2026-10-27.
6. [Wiley Author Services, Make your article open access in hybrid journals](https://authors.wiley.com/author-resources/Journal-Authors/open-access/hybrid-open-access/index.html), read 2026-10-27.
7. [Wiley Article Publication Charges for Hybrid Open Access Journals, price list (xlsx, "Updated: 12 October 2026")](https://authors.wiley.com/asset/Wiley-Journal-APCs-OnlineOpen.xlsx), read 2026-10-27.
8. [Stat author guidelines, Wiley Online Library](https://onlinelibrary.wiley.com/page/journal/20491573/homepage/forauthors.html), read 2026-10-27 through Claude in Chrome (automated readers had received HTTP 403 earlier the same day).
9. [Stat ScholarOne submission site](https://mc.manuscriptcentral.com/stat), could not be read (HTTP 403), tried 2026-10-27.
10. [Crossref REST API, works filtered to ISSN 2049-1573](https://api.crossref.org/works?filter=issn:2049-1573,from-pub-date:2021), queried 2026-10-27, and each DOI below confirmed at `https://api.crossref.org/works/<DOI>`.
11. [Stat journal metrics, Wiley Online Library](https://onlinelibrary.wiley.com/journal/20491573/journal-metrics), read 2026-10-27 through Claude in Chrome.

## Scope

> "Stat is an innovative journal for the rapid publication of novel and topical research results in all areas of statistical endeavour. Its purpose is to provide a means of rapid sharing of important new theoretical, methodological and applied research." [2]

> "Stat is an innovative electronic journal for the rapid publication of novel and topical research results, publishing compact articles of the highest quality in all areas of statistical endeavour." [8]

In plain terms, Stat is a fast, short-paper journal run by the ISI with Wiley, open to any area of statistics. The ISI page calls it "an online only, rapid communication research journal" and says its review process "aims to reach a decision within 20 days of submission" [1]. The author guidelines set a hard limit of 10 pages, with longer articles rejected, but proofs, code, and datasets can go in Supporting Information outside the 10 pages [8]. It suits a tight, single-result paper: a short note that a widely used procedure estimates something other than what users think, with a compact simulation. A full critique with closed form, simulation, fix, and lupus application would need to be cut hard to fit 10 pages.

| Paper type | Fit | Why |
|--------------------------------------------|----------|------------------------------------------------|
| Critique with a closed-form bias, simulation, fix, and application | possible | The topic fits the broad scope, but the 10-page limit forces a much shorter version of the full critique, even with proofs moved to Supporting Information [8]. |
| Simulation and diagnostic, no closed form | possible | A short diagnostic fits, though long simulation tables would strain the page limit. |
| Constructive method with theory, simulation, comparison, and application | possible | New methodological research is in scope [2], but the theory, simulation, comparison, and application must fit in 10 pages, with proofs moved to Supporting Information [8]. |
| Short methods note | good | Rapid, short research communications are the journal's stated purpose. |
| Theory paper | good | The aims name new theoretical research, and a short closed-form result suits the format. |
| Applied analysis | possible | The aims include applied research, but the readership is statisticians rather than genomics users. |

## Article types that fit

| Article type | Length | Figures and tables | References | Source |
|-------------------|--------------------------|---------------------|-------------|--------|
| Article | 10 pages at most, excluding references, figures, tables, and other exhibits but including appendix text; longer articles are rejected | not stated on the site | not stated on the site | [8] |

The ISI page words the limit differently (see Contradictions) [1].

## Abstract

- Structured: no; no citations in the abstract [8]
- Headings: none
- Word limit: 200 ("Enter an abstract of up to 200 words for all articles.") [8]; five or six keywords [8]

## Reference style

- The journal's stated style: APA 6th edition, author-date, as in "(Jones, 1998)", with a DOI for every reference [8]. Under Free Format submission, any consistent style is accepted at first submission [8].
- CSL file: no file for this journal in the official styles repository (github.com/citation-style-language/styles, commit d2cc420, 2026-10-24). The site names APA 6th edition, so the substitute is `apa-6th-edition.csl`.
- File to use in Quarto: `csl/apa-6th-edition.csl`, a substitute chosen by the coordinator to match the edition the site names. Free Format submission means any consistent style is accepted at first submission.
- Rendering test: `csl/apa-6th-edition.csl` passed on 2026-10-27 (`csl/test-results.md`).

## Supplement, code, and data

- Supplementary material: the ISI page says the journal "Includes electronic support materials, such as data, graphs, images, video and code" [1]. The author guidelines place Supporting Information (proofs, code, datasets) outside the 10-page limit [8].
- Data availability statement: expected, with a link to the repository [8]. "Stat expects that data supporting the results in the paper will be archived in an appropriate public repository." [8]
- Code: "Whenever possible the scripts and other artefacts used to generate the analyses presented in the paper should also be publicly archived." [8] Code is encouraged in a public archive, not required, and no deadline (submission or acceptance) is stated [8].

## AI-use policy

> "Additionally, authors are expected to write the initial version of the manuscript themselves, although the use of AI is allowed to assist with language editing in subsequent drafts." [8]

The same passage says any use of AI must be described "in the Experimental section" of the manuscript; it is the same journal text as in the Statistics in Medicine author guidelines [8].

> "these tools cannot fulfil the role of, nor be listed as, an author of an article." [3]

- The journal's own rule [8] takes precedence over Wiley's publisher-wide guidance [3, 4]. It goes further than Wiley: AI may not draft the first version of the manuscript, only edit the language of later drafts, and every use is described in the Experimental section rather than in the Acknowledgments [8]. Wiley's guidance still applies on authorship and on research images: AI "must not be used to generate, modify, or enhance" factual and evidential images such as research data [3]. Editors have final authority over whether AI use is appropriate [3, 4].
- Read at: https://onlinelibrary.wiley.com/page/journal/20491573/homepage/forauthors.html (journal) and https://www.wiley.com/en-us/publishing/article/ai-guidelines (Wiley), 2026-10-27.
- What the manuscript must do: write the first draft without AI; describe any AI use (language editing, analysis, code) in the Experimental section in enough detail to be reproducible; and never list AI as an author.

## Open access and charges

- Model: hybrid (Stat is on Wiley's hybrid open access price list [7]; the author guidelines offer optional open access for a fee [8]; the ISI page says the journal "is available through a paid subscription" [1])
- Article processing charge: USD 3,640 for hybrid open access (GBP 2,430 and EUR 3,000 also listed), from the price list updated 12 October 2026, read 2026-10-27 [7]. "There is no page charge to authors." [8]
- Waivers and institutional agreements: "Author groups who meet specific eligibility criteria may qualify for a discount or waiver on APCs." A Wiley Open Access Account held by an institution, funder, or society may cover all or part of the APC; the price list adds that members of a Wiley transformational agreement may be covered [5, 7]. No ISI member discount is stated on the ISI page [1].

## Review

- Model: not stated on the site (author guidelines, source 8).
- Time to decision: for 2025, median 14 days from submission to first decision and median 86 days from submission to acceptance; acceptance rate 24% [11]. The ISI page gives a target of a decision "within 20 days of submission" [1].

## Recent papers like ours

1. Rindt D, Sejdinovic D, Steinsaltz D (2021). Consistency of permutation tests of independence using distance covariance, HSIC and dHSIC. *Stat* 10(1):e364. https://doi.org/10.1002/sta4.364. A short theoretical paper on what distance-based permutation tests can detect, close to our PERMANOVA work.
2. Vondráček J, Dvořák J (2021). A cautionary note on the variance of empirical pair correlation function. *Stat* 10(1):e406. https://doi.org/10.1002/sta4.406. A short cautionary note about a commonly used estimator, the format a group short note would take, though the field is spatial statistics.
3. Song H, Wu M (2024). Multivariate differential association analysis. *Stat* 13(2):e704. https://doi.org/10.1002/sta4.704. A method for testing changes in association between groups, related to differential co-expression.

## Not stated on the site, or could not be read

- Figure, table, and reference limits: not stated on the site (ISI page [1]; author guidelines [8]).
- Peer review model: not stated on the site (author guidelines, source 8); the ScholarOne site https://mc.manuscriptcentral.com/stat could not be read (HTTP 403).
- Meaning of "Experimental section" for a statistics paper with no section of that name: not stated on the site (source 8).

Contradictions:

- Page limit: the ISI page [1] counts "10 pages of text, excluding abstract, key words, figures and tables", while the author guidelines [8] exclude "references, figures, tables and other forms of exhibit" but include "text in appendices". Follow the author guidelines, since they say longer articles are rejected.
- AI disclosure: Wiley's publisher-wide guidance puts disclosure of drafting help in the Acknowledgments [3], and this profile earlier followed it. The journal's guidelines require authors to write the initial version themselves and put every AI disclosure in the Experimental section [8]. The journal's rule governs.

## Table row

```
scope_5_words: rapid short papers, all statistics
audience: methodologists
fit_critique: possible
fit_sim_diagnostic: possible
fit_constructive: possible
fit_short_note: good
fit_theory: good
fit_applied: possible
abstract_format: unstructured
abstract_words: 200
length_limit: article, 10 pages excluding references, figures, and tables, including appendices
apc: none required (open access USD 3,640)
oa_model: hybrid
ai_policy_3_words: disclose, no drafting
review_model: not stated
guidelines_read: yes
```
