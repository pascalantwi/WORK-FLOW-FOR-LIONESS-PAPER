# Biometrics

| Field | Value |
|-----------------|--------------------------------------------------------------|
| Publisher | Oxford University Press, on behalf of the International Biometric Society (OUP since 1 January 2024; Wiley until 31 December 2023) [1, 4] |
| Online ISSN | 1541-0420 [2] |
| Profile written | 2026-10-27 |

## Sources

Every page below was read on the date shown. Bracketed numbers in the text point here.

1. [General Instructions (author guidelines), Biometrics](https://academic.oup.com/biometrics/pages/general-instructions), read 2026-10-27.
2. [About the journal, Biometrics](https://academic.oup.com/biometrics/pages/about), read 2026-10-27.
3. [Why publish with Biometrics?](https://academic.oup.com/biometrics/pages/why-publish-with-biometrics), read 2026-10-27.
4. [Report of the Editors, 2023, *Biometrics* 80(1), ujae004](https://academic.oup.com/biometrics/article/80/1/ujae004/7628544), read 2026-10-27.
5. [Report of the Editors, 2024, *Biometrics* 81(1), ujaf004](https://academic.oup.com/biometrics/article/81/1/ujaf004/8006201), read 2026-10-27.
6. [Biometrics Journal, International Biometric Society](https://www.biometricsociety.org/publications/biometrics), read 2026-10-27.
7. [Charges, licences, and self-archiving, Oxford Academic](https://academic.oup.com/pages/open-research/open-access/charges-licences-and-self-archiving), read 2026-10-27; its "What is the OA charge for my article?" calculator read 2026-10-27 through Claude in Chrome, with no Low and Middle Income Countries discount and no society membership selected.
8. [APC waiver and discount policy, Oxford Academic](https://academic.oup.com/pages/open-research/open-access/charges-licences-and-self-archiving/apc-waiver-policy), read 2026-10-27.
9. Crossref REST API records (`https://api.crossref.org/works/<DOI>`) for the papers under "Recent papers like ours", read 2026-10-27.

## Scope

> "Its objectives are to promote and extend the use of statistical and mathematical methods in the principal disciplines of biosciences" [3]

Biometrics is the International Biometric Society's general methods journal for statistics in biology and medicine, read mostly by methodologists. It has two main sections. Biometric Methodology is for new methods; Biometric Practice is for papers that, among other things, "re-examine from a new perspective statistical practices that are widely used in biometric applications" [1], which describes our critique papers almost word for word. The Practice section also warns that "routine simulation-based comparisons of competing methods are generally not suitable" [1], so a simulation paper needs a real insight or a new diagnostic. A short reply to an earlier Biometrics paper can go in Reader Reaction.

| Paper type | Fit | Why |
|--------------------------------------------|----------|------------------------------------------------|
| Critique with a closed-form bias, simulation, fix, and application | good | Biometric Practice explicitly takes re-examinations of widely used practices, and Biometric Methodology takes the fix. |
| Simulation and diagnostic, no closed form | possible | Fits Biometric Practice only if it offers new insight; routine simulation comparisons are "generally not suitable" [1]. |
| Constructive method with theory, simulation, comparison, and application | good | Biometric Methodology is the section for new methods, and it takes proofs provided the derivations go to an appendix [1]. |
| Short methods note | possible | Reader Reaction (12 pages) fits only if it responds to a Biometrics article from about the last three years [1]. |
| Theory paper | possible | Methodology papers may carry proofs, but derivations should go to an appendix and an accessible introduction is required [1]. |
| Applied analysis | poor | Practice papers need "substantial new insight"; a plain analysis with existing tools has no stated home [1]. |

## Article types that fit

| Article type | Length | Figures and tables | References | Source |
|-------------------|--------------------------|---------------------|-------------|--------|
| Biometric Methodology | 25 pages, double-spaced, 12-point, one-inch margins, counting acknowledgements, references, and brief appendices but not tables and figures; longer new submissions are returned without review | "rarely have more than six (6) tables or figures combined" | not stated on the site | [1] |
| Biometric Practice | 25 pages, same basis as above | same as above | not stated on the site | [1] |
| Reader Reaction | 12 pages; must respond to a Biometrics article published within about three years | same as above | not stated on the site | [1] |

## Abstract

- Structured: no; one paragraph [1]
- Headings: none
- Word limit: "The summary should not exceed 225 words, should avoid mathematical symbols"; up to six keywords in alphabetical order [1]

## Reference style

- The journal's stated style: author-year citations in the text; for three authors all names on first citation and "et al." afterwards; for four or more, "et al." throughout; "Journal titles should be complete and not abbreviated" [1]. Example given: "Scharf, H. R., Hooten, M. B., and Johnson, D. S. (2017). Imputation approaches for animal movement modeling." [1]
- CSL file: `biometrics.csl` in the official styles repository (github.com/citation-style-language/styles, commit d2cc420, 2026-10-24), an independent style.
- File to use in Quarto: `csl/biometrics.csl`.
- Rendering test: passed on 2026-10-27 (`csl/test-results.md`).

## Supplement, code, and data

- Supplementary material: submitted with the manuscript and cited in the text as "Web Appendix A", "Web Table 1", "Web Figure 1", in one combined document; data files as a .zip; hosted by OUP or partners such as Dryad, not personal or institutional websites [1].
- Data availability statement: required. "The inclusion of a data availability statement is a requirement for papers published in the Journal"; it goes after the acknowledgments and before the references [1].
- Code: "Co-Editors are likely to ask authors to provide code during the editorial process", and "where it is deemed important, the Co-Editor will make provision of code a condition of acceptance" [1]. Code is posted as supplementary material, "preferably packaged in a zip or other permanent archive with a README file" [1]. Public repositories such as GitHub or CRAN may be cited, personal URLs may not [1]. So code is strongly encouraged at submission and may be required at acceptance. Optional Open Data and Open Materials badges are offered [1]. No reproducibility review is described.

## AI-use policy

> "Natural language processing tools driven by artificial intelligence (AI) do not qualify as authors" ... "The use of AI (for example, to help generate content, write code, or process data) should be disclosed both in cover letters to editors and in the Methods or Acknowledgements section" [1]

- Read at: https://academic.oup.com/biometrics/pages/general-instructions, 2026-10-27.
- The page refers to the COPE statement on AI and authorship and says nothing specific about AI-generated images [1].
- What the manuscript must do: disclose the AI use in the cover letter and in the Methods or Acknowledgements section, saying what the tool did; never list an AI tool as an author.

## Open access and charges

- Model: hybrid; a standard licence with no charge, or an open access licence (CC BY, CC BY-NC, or CC BY-NC-ND) for a charge [1].
- Article processing charge: not stated on the journal's pages [1, 2, 3]. For the open access option, OUP's charge calculator gives USD 4,128 for a Biometric Methodology article, with no discount selected; prices exclude sales taxes and are "subject to change" [7].
- Waivers and institutional agreements: Read and Publish agreements may cover the charge; the corresponding author cannot be changed after submission to use one [1, 3]. The journal page says the OUP low and middle income countries initiative "provides waivers for article processing charges" [3], but OUP's waiver policy limits waivers to authors "publishing in a fully open access journal" [8]; see the note below. Members of the society get free access to the journal [6].

## Review

- Model: single anonymized [1].
- Time to decision: the editors report a 2024 median review time of 1.9 months for all first submissions (time from receipt to the decision letter), 2.3 months for first submissions sent to external review, and 2.0 months for revisions [5]. Reviewers completed 95% of reviews within four months in 2023 [3]. Acceptance rate about 19.8% for 2023 [5].

## Recent papers like ours

1. Tian J, Lei J, Roeder K (2024). From local to global gene co-expression estimation using single-cell RNA-seq data. *Biometrics* 80(1). https://doi.org/10.1093/biomtc/ujae001. Studies cell-specific gene networks (the single-cell analogue of sample-specific networks), shows what their population average actually measures, and builds a test from it, which is close to our LIONESS and SSN work.
2. Gabriel EE, Sachs MC, Waernbaum I, Goetghebeur E, Blanche PF, Vansteelandt S, Sjölander A, Scheike T (2024). Propensity weighting plus adjustment in proportional hazards model is not doubly robust. *Biometrics* 80(3). https://doi.org/10.1093/biomtc/ujae069. A pure critique: states what applied users believe a common combination estimates, shows by simulation that it does not, and proposes an alternative.
3. Heiling HM, Wilson DR, Rashid NU, Sun W, Ibrahim JG (2023). Estimating Cell Type Composition Using Isoform Expression One Gene at a Time. *Biometrics* 79(2):854 to 865. https://doi.org/10.1111/biom.13614. A cell-composition estimation paper with simulation and real RNA-seq data, the adjustment step our composition papers examine.

## Not stated on the site, or could not be read

- Reference count limit: not stated [1].
- Contradiction: the journal's "Why publish" page says OUP's low and middle income countries initiative provides APC waivers [3], while OUP's waiver policy restricts waivers to fully open access journals [8], which Biometrics is not.
- The "since 2024" date for OUP comes from the 2023 Report of the Editors [4]; the journal's About page and the society page do not give a date [2, 6].

## Table row

```
scope_5_words: statistical methods for biosciences
audience: methodologists
fit_critique: good
fit_sim_diagnostic: possible
fit_constructive: good
fit_short_note: possible
fit_theory: possible
fit_applied: poor
abstract_format: unstructured
abstract_words: 225
length_limit: Methodology or Practice 25 double-spaced pages excluding tables and figures
apc: none required (open access USD 4,128)
oa_model: hybrid
ai_policy_3_words: disclose, no authorship
review_model: single
guidelines_read: partly
```
