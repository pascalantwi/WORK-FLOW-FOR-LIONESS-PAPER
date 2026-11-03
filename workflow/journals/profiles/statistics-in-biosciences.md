# Statistics in Biosciences

| Field | Value |
|-----------------|--------------------------------------------------------------|
| Publisher | Springer, for the International Chinese Statistical Association ("Journal of the International Chinese Statistical Association") [4] |
| Online ISSN | 1867-1772 [4] |
| Profile written | 2026-10-27 |

## Sources

Every page below was read on the date shown. Bracketed numbers in the text point here.

1. [Submission guidelines, Statistics in Biosciences](https://link.springer.com/journal/12561/submission-guidelines), read 2026-10-27.
2. [Aims and scope, Statistics in Biosciences](https://link.springer.com/journal/12561/aims-and-scope), read 2026-10-27.
3. [How to publish with us, Statistics in Biosciences](https://link.springer.com/journal/12561/how-to-publish-with-us), read 2026-10-27.
4. [Journal home page, Statistics in Biosciences](https://link.springer.com/journal/12561), read 2026-10-27.
5. [Journal policies, Springer](https://link.springer.com/brands/springer/journal-policies) (the target of the journal's link to "Springer's policy on generative AI images"), read 2026-10-27.
6. Crossref REST API records (`https://api.crossref.org/works/<DOI>`) for the papers under "Recent papers like ours", read 2026-10-27.

## Scope

> "It aims at development and application of statistical methods and their interface with other quantitative methods, such as computational and mathematical methods, in biological and life science, health science, and biopharmaceutical and biotechnological science." [2]

Statistics in Biosciences is a smaller journal, published three times a year, that sits between methods and practice in biology and health. It has two primary sections: Original Articles for new methods, and Bioscience Case Studies and Practice Articles, which explicitly include "evaluation of existing methods and data sources" and "novel software tools" [2]. That second section matches our critique and simulation papers closely, and an R package can be part of the contribution. The journal also says "Substantive science is essential in motivating and demonstrating the methodological development" [2], so the lupus application belongs in every paper. Readers are biostatisticians and quantitative bioscientists.

| Paper type | Fit | Why |
|--------------------------------------------|----------|------------------------------------------------|
| Critique with a closed-form bias, simulation, fix, and application | good | Case Studies and Practice explicitly takes "evaluation of existing methods" [2], and the fix can go to Original Articles. |
| Simulation and diagnostic, no closed form | good | An evaluation of an existing method with a new diagnostic fits Case Studies and Practice [2]. |
| Constructive method with theory, simulation, comparison, and application | good | Original Articles are the section for new methods, and the journal wants substantive science "motivating and demonstrating the methodological development" [2]. |
| Short methods note | possible | Commentaries cover "reactions to an article published in the journal, and scholarly essays" [2]; no length is stated. |
| Theory paper | poor | The journal requires substantive science to motivate the work [2]. |
| Applied analysis | possible | Case studies and "innovative applications of existing methods that further understanding of subject-matter science" fit [2]; a routine analysis would not. |

## Article types that fit

| Article type | Length | Figures and tables | References | Source |
|-------------------|--------------------------|---------------------|-------------|--------|
| Original Article | not stated on the site | not stated on the site | not stated on the site | [1, 2] |
| Bioscience Case Studies and Practice Article | not stated on the site | not stated on the site | not stated on the site | [1, 2] |
| Commentary | not stated on the site | not stated on the site | not stated on the site | [1, 2] |

## Abstract

- Structured: no; no format is prescribed [1]
- Headings: none
- Word limit: "Please provide an abstract of 150 to 250 words"; 4 to 6 keywords [1]

## Reference style

- The journal's stated style: author-year. "Cite references in the text by name and year in parentheses"; the reference list is alphabetized by the first author's last name; DOIs should be given as full links where available [1].
- CSL file: `dependent/statistics-in-biosciences.csl` in the official styles repository (github.com/citation-style-language/styles, commit d2cc420, 2026-10-24), a dependent style whose parent is `springer-basic-brackets.csl`, a numbered style. That does not match the site, which asks for author-year citations.
- File to use in Quarto: `csl/springer-basic-author-date.csl`, the Springer author-year style, chosen by the coordinator to match the site. The repository's journal file (`csl/dependent/statistics-in-biosciences.csl`) is kept for the record only.
- Rendering test: both files passed on 2026-10-27 (`csl/test-results.md`).

## Supplement, code, and data

- Supplementary material: accepted as online supplementary files in standard formats; datasets should preferably go to a repository [1].
- Data availability statement: the guidelines list "Data, Material and/or Code availability" among the declarations that go under a "Statements and Declarations" heading, and warn that "submissions that do not include relevant declarations will be returned as incomplete" [1]. The journal "operates a type 1 research data policy" and "encourages authors, where possible and applicable, to deposit data" in a public repository [1]. A data availability statement is therefore expected but not stated as mandatory.
- Code: no journal-specific code policy. Authors should ensure "software application or custom code support their published claims" [1]. No repository requirement at submission or acceptance and no reproducibility check is stated.

## AI-use policy

> "Large Language Models (LLMs), such as ChatGPT, do not currently satisfy our authorship criteria." "Use of an LLM should be properly documented in the Methods section (and if a Methods section is not available, in a suitable alternative part) of the manuscript." "The use of an LLM (or other AI-tool) for "AI assisted copy editing" purposes does not need to be declared." [1]

- For images, the guidelines say to "check Springer's policy on generative AI images" [1]; that link now leads to Springer's journal policies page, which lists "Creating photorealistic images (deepfakes)" and assigning authorship to AI as not permitted, and "Extensive copy editing or writing support" as permitted with disclosure [5].
- Read at: https://link.springer.com/journal/12561/submission-guidelines and https://link.springer.com/brands/springer/journal-policies, 2026-10-27.
- What the manuscript must do: describe any LLM use beyond light copy editing in the Methods section, keep humans accountable for the text, and use no AI-generated photorealistic images.

## Open access and charges

- Model: hybrid ("Statistics in Biosciences is a hybrid journal") [3].
- Article processing charge: "£2290.00 GBP / $3190.00 USD / €2590.00 EUR", subject to VAT or local taxes, read 2026-10-27 [3].
- Waivers and institutional agreements: "Springer Nature offers agreements that enable institutions to cover open access publishing costs" [3]. No waiver is stated [3]. Open access licences are CC BY-NC-ND or CC BY [3].

## Review

- Model: single anonymized. "Statistics in Biosciences follows a single-blind peer review process"; usually two referees plus one Associate Editor, and "No article is accepted without two complete and final reviews" [1].
- Time to decision: "Submission to first decision (median)": 19 days, on the journal home page (no period or definition stated) [4].

## Recent papers like ours

1. Tai AS, Wang CC, Hsieh WP (2023). Detection of Cell Separation-Induced Gene Expression Through a Penalized Deconvolution Approach. *Statistics in Biosciences* 15(3):692 to 718. https://doi.org/10.1007/s12561-022-09344-8. Shows that a routine lab step (cell sorting) creates an artifact in expression data, builds a deconvolution method to detect it, and applies it to an immune-related disease dataset.
2. Wei X, Gabriel B, Rothman A, Wu Z (2025). Analyzing RNA-Seq Data in Complex Study Designs. *Statistics in Biosciences* 17(3):593 to 614. https://doi.org/10.1007/s12561-024-09446-5. Shows that standard RNA-seq pipelines leave sample-level heteroscedasticity after normalization, corrects for it, and checks the fix by simulation and on real data.
3. Hajihosseini M, Amini P, Saidi-Mehrabad A, Hajizadeh N, Kozyrskyj AL, Dinu I (2025). A Comprehensive Performance Comparison Study of Various Statistical Models that Accommodate Challenges of the Gut Microbiome Data. *Statistics in Biosciences* 17(1):216 to 231. https://doi.org/10.1007/s12561-024-09435-8. A simulation evaluation of widely used microbiome methods, our simulation and diagnostic paper type.

## Not stated on the site, or could not be read

- Length, figure, table, and reference limits for every article type: not stated [1, 2].
- Whether a data availability statement is mandatory: not stated plainly; it is listed among declarations, and missing "relevant declarations" lead to return [1].
- Code deposit requirement: not stated [1].
- APC waivers: not stated [3].
- Unclear: as for other Springer journals, the guidelines exempt AI-assisted copy editing from disclosure [1], while the linked Springer policy page encourages disclosing all AI use [5].

## Table row

```
scope_5_words: statistical methods and practice, biosciences
audience: both
fit_critique: good
fit_sim_diagnostic: good
fit_constructive: good
fit_short_note: possible
fit_theory: poor
fit_applied: possible
abstract_format: unstructured
abstract_words: 150 to 250
length_limit: not stated
apc: none required (open access USD 3,190)
oa_model: hybrid
ai_policy_3_words: disclose in methods
review_model: single
guidelines_read: yes
```
