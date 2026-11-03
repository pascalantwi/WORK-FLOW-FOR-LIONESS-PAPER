# Biometrical Journal

| Field | Value |
|-----------------|--------------------------------------------------------------|
| Publisher | Wiley |
| Online ISSN | 1521-4036 [1] |
| Profile written | 2026-10-27 |

## Sources

Every page below was read on the date shown. Bracketed numbers in the text point here.

1. [Biometrical Journal, Wiley journal page](https://www.wiley.com/en-us/journals/Biometrical+Journal-p-15214036), read 2026-10-27.
2. [Using AI tools in your research (Wiley AI guidelines)](https://www.wiley.com/en-us/publishing/article/ai-guidelines), read 2026-10-27.
3. [Wiley Author Services, Ethics guidelines (AI section)](https://authors.wiley.com/ethics-guidelines/index.html), read 2026-10-27.
4. [Wiley Author Services, Article Publication Charges](https://authors.wiley.com/author-resources/Journal-Authors/open-access/article-publication-charges/index.html), read 2026-10-27.
5. [Wiley Author Services, Make your article open access in hybrid journals](https://authors.wiley.com/author-resources/Journal-Authors/open-access/hybrid-open-access/index.html), read 2026-10-27.
6. [Wiley Article Publication Charges for Hybrid Open Access Journals, price list (xlsx, "Updated: 12 October 2026")](https://authors.wiley.com/asset/Wiley-Journal-APCs-OnlineOpen.xlsx), read 2026-10-27.
7. [Biometrical Journal author guidelines, Wiley Online Library](https://onlinelibrary.wiley.com/page/journal/15214036/homepage/forauthors.html), read 2026-10-27 through Claude in Chrome (automated readers had received HTTP 403 earlier the same day).
8. [Crossref REST API, works filtered to ISSN 0323-3847](https://api.crossref.org/works?filter=issn:0323-3847,from-pub-date:2021), queried 2026-10-27, and each DOI below confirmed at `https://api.crossref.org/works/<DOI>`.
9. [Biometrical Journal journal metrics, Wiley Online Library](https://onlinelibrary.wiley.com/journal/15214036/journal-metrics), read 2026-10-27 through Claude in Chrome.

## Scope

> "The Biometrical Journal publishes papers on statistical methods showcasing their applications in life sciences. Our scope encompasses medicine, environmental sciences, and agriculture." [1]

> "Biometrical Journal publishes articles on statistical methods and their applications in life sciences including clinical and experimental medicine, public health, environmental sciences, biology, agriculture and forestry." [7]

In plain terms, Biometrical Journal is a European biostatistics methods journal that cares about methods being used well in practice. The journal page says "Case studies, reviews and letters to the editors are welcome" and that "Authors are strongly encouraged to submit computer code and data sets used to illustrate new methods" [1]. The author guidelines add that "Articles containing only extensive mathematical theory or solely computational material are not suitable for publication in Biometrical Journal," and that analyses of a single dataset with no methodological advance are generally not suitable, while novel case studies are welcome [7]. Its recent output includes critiques of research practice, such as overoptimism in gene set analysis and questionable practices in simulation studies, which is close to our critique papers. Readers are methodologists; the R package and Quarto workflow match the journal's reproducibility check, in which a Reproducible Research Editor reruns the submitted code after acceptance [7].

| Paper type | Fit | Why |
|--------------------------------------------|----------|------------------------------------------------|
| Critique with a closed-form bias, simulation, fix, and application | good | The journal publishes statistical methods with life-science applications and has recently published critiques of widely used genomics practice. |
| Simulation and diagnostic, no closed form | good | It publishes work on how simulation studies and method comparisons can mislead, and the guidelines send "extensive simulation work" to online supporting information [7]. |
| Constructive method with theory, simulation, comparison, and application | good | Statistical methods with life-science applications are the stated scope [1], and the journal asks for the code and data "used to illustrate new methods" [1], so a new procedure with simulation and an application is its core content. |
| Short methods note | good | The journal has a Short Communication type with a recommended length of 2,000 words [7]. |
| Theory paper | poor | Articles "containing only extensive mathematical theory" are not suitable [7]. |
| Applied analysis | possible | Novel case studies are welcome, but single-dataset analyses without a methodological advance generally are not [7]. |

## Article types that fit

| Article type | Length | Figures and tables | References | Source |
|-------------------|--------------------------|---------------------|-------------|--------|
| Research Article | 4,500 words recommended; unstructured abstract; data availability statement, IRB statement, and code and software required | not stated in the article types table | not stated in the article types table | [7] |
| Short Communication | 2,000 words recommended | not stated in the article types table | not stated in the article types table | [7] |
| Case Study | 4,500 words recommended | not stated in the article types table | not stated in the article types table | [7] |
| Letter | 1,000 words recommended | not stated in the article types table | not stated in the article types table | [1, 7] |

The table also lists Review Articles (8,000 words, to be discussed with the Editor in Chief first) and Discussion papers [7].

## Abstract

- Structured: no ("Yes, unstructured" for Research Articles) [7]
- Headings: none
- Word limit: not stated on the site (author guidelines, source 7); up to five keywords, in alphabetical order [7]

## Reference style

- The journal's stated style: "This journal uses the APA reference style." [7] Under Free Format submission, any consistent style is accepted at first submission [7].
- CSL file: no file for this journal in the official styles repository (github.com/citation-style-language/styles, commit d2cc420, 2026-10-24). The site names APA style, so the substitute is `apa.csl` (APA 7th edition).
- File to use in Quarto: `csl/apa.csl`, a substitute chosen by the coordinator to match the style the site names. The site does not say which APA edition; Free Format submission means any consistent style is accepted at first submission.
- Rendering test: `csl/apa.csl` passed on 2026-10-27 (`csl/test-results.md`).

## Supplement, code, and data

- Supplementary material: "Online supporting information is appropriate for material that is not an integral part of the article such as extensive simulation work." [7]
- Data availability statement: required for all accepted manuscripts [7].
- Code: code and data are "strongly encouraged" [1, 7]. They are "submitted at revision and will be reviewed by the Reproducible Research Editor after acceptance," uploaded as one ZIP file labelled "Data and Software," with the mandatory Checklist for Code and Data Supplements [7]. "It is mandatory that results reported in the manuscript coincide with results produced by the software code submitted." [7] A public repository is not stated as required; the code goes to the journal as an upload at revision [7].

## AI-use policy

> "Authors must disclose the use of AI Technologies when submitting their Material to a Wiley-published journal." [2]

> "these tools cannot fulfil the role of, nor be listed as, an author of an article." [2]

- Where the disclosure goes, per Wiley: in the Acknowledgments for help with drafting, editing, translation, or formatting; in the Methods when AI assists with research methodology, data collection, or analysis; and in figure captions when AI generates or edits visual content [2]. AI "must not be used to generate, modify, or enhance" factual and evidential images such as research data [2]. Simple grammar correction and word-choice suggestions "typically do not require disclosure" [2]. Editors have final authority over whether AI use is appropriate [2, 3].
- This is Wiley's publisher-wide guidance addressed to authors submitting to any Wiley-published journal [2, 3]. The Biometrical Journal author guidelines have no journal-specific AI statement [7], so the Wiley guidance stands.
- Read at: https://www.wiley.com/en-us/publishing/article/ai-guidelines, 2026-10-27.
- What the manuscript must do: declare AI use at submission, with a sentence in the Acknowledgments (writing help) or Methods (analysis help) naming the tool and its purpose, and never list AI as an author.

## Open access and charges

- Model: hybrid; the journal is "part of Wiley's hybrid open access program" [5, 6, 7]
- Article processing charge: USD 3,930 for hybrid open access (GBP 2,650 and EUR 3,290 also listed), from the price list updated 12 October 2026, read 2026-10-27 [6]. "This journal does not charge submission fees." [7]
- Waivers and institutional agreements: "Author groups who meet specific eligibility criteria may qualify for a discount or waiver on APCs." A Wiley Open Access Account held by an institution, funder, or society may cover all or part of the APC; the price list adds that members of a Wiley transformational agreement may be covered [4, 6]. The author guidelines point to Wiley's Open Access page for the APC and give no journal-specific waiver [7].

## Review

- Model: single anonymized ("This journal operates under a single-blind peer review model.") [7]. The journal may transfer papers to Stat and accepts transfers from Statistics in Medicine and Pharmaceutical Statistics [7].
- Time to decision: for 2025, median 31 days from submission to first decision and median 256 days from submission to acceptance; acceptance rate 16% [9].

## Recent papers like ours

1. Wünsch M, Sauer C, Herrmann M, Hinske L, Boulesteix A (2025). To Tweak or Not to Tweak. How Exploiting Flexibilities in Gene Set Analysis Leads to Overoptimism. *Biometrical Journal* 67(1):e70016. https://doi.org/10.1002/bimj.70016. A critique of how a widely used genomics procedure is applied, shown on real expression data, which is our main paper type.
2. Pawel S, Kook L, Reeve K (2024). Pitfalls and potentials in simulation studies: Questionable research practices in comparative simulation studies allow for spurious claims of superiority of any method. *Biometrical Journal* 66(1):2200091. https://doi.org/10.1002/bimj.202200091. A paper about simulation-study design, the same concern behind our ADEMP-designed simulations.
3. Duda J, Kappenberg F, Rahnenführer J (2022). Model selection characteristics when using MCP-Mod for dose-response gene expression data. *Biometrical Journal* 64(5):883 to 897. https://doi.org/10.1002/bimj.202000250. Evaluates how an established procedure behaves on gene expression data, with simulation and real data.

## Not stated on the site, or could not be read

- Figure, table, and reference limits: not stated in the article types table of the author guidelines (source 7).
- Abstract word limit: not stated on the site (source 7).
- Public repository requirement for code or data: not stated on the site; code and data go to the journal as a ZIP at revision (source 7).
- Journal-specific APC waivers or society discounts: not stated on the site (source 7).

Contradictions:

- None found. The author guidelines [7] agree with the journal page [1] on scope, case studies, letters, and code, and add detail.

## Table row

```
scope_5_words: biostatistical methods for life sciences
audience: methodologists
fit_critique: good
fit_sim_diagnostic: good
fit_constructive: good
fit_short_note: good
fit_theory: poor
fit_applied: possible
abstract_format: unstructured
abstract_words: not stated
length_limit: Research Article: 4,500 words recommended
apc: none required (open access USD 3,930)
oa_model: hybrid
ai_policy_3_words: disclose, no authorship
review_model: single
guidelines_read: yes
```
