# Briefings in Bioinformatics

| Field | Value |
|-----------------|--------------------------------------------------------------|
| Publisher | Oxford University Press; no society named on the pages read |
| Online ISSN | 1477-4054 [3] |
| Profile written | 2026-10-27 |

## Sources

Every page below was read on the date shown. Bracketed numbers in the text point here.

1. [Briefings in Bioinformatics: Author guidelines](https://academic.oup.com/bib/pages/author-guidelines) (same content at [General_Instructions](https://academic.oup.com/bib/pages/General_Instructions)), read 2026-10-27.
2. [Briefings in Bioinformatics: msprep submission (Instructions to authors, types of manuscript and manuscript preparation)](https://academic.oup.com/bib/pages/msprep_submission), read 2026-10-27.
3. [Briefings in Bioinformatics: About](https://academic.oup.com/bib/pages/About), read 2026-10-27.
4. [Briefings in Bioinformatics: Open Access](https://academic.oup.com/bib/pages/open-access), read 2026-10-27.
5. [OUP: Charges, licences, and self-archiving](https://academic.oup.com/pages/open-research/open-access/charges-licences-and-self-archiving), read 2026-10-27; its "What is the OA charge for my article?" calculator read 2026-10-27 through Claude in Chrome, with no Low and Middle Income Countries discount and no society membership selected.
6. [OUP: Policy on AI Use and Disclosure for OUP Journals Authors](https://academic.oup.com/pages/for-authors/journals/preparing-and-submitting-your-manuscript/ai-principles-for-oxford-journals/policy-on-ai-use-and-disclosure-for-oxford-journals-authors), read 2026-10-27.
7. [Crossref REST API record lookups for the DOIs under "Recent papers like ours"](https://api.crossref.org/works), read 2026-10-27.

## Scope

> "aims to provide an indispensable resource for the experimental practitioner seeking awareness of the disparate sources of data and analytical tools of contemporary biology" [1]

Briefings in Bioinformatics describes itself as a review journal: its manuscript-preparation page says it "is a review journal and does not publish articles that are pure original research" and does not publish "work on new methods that have not yet been described elsewhere" [2]. Its About page is broader, listing "reviews, new methods, case studies, and opinion articles" [3]. In practice the route for we is a Problem Solving Protocol or a benchmarking review that evaluates existing, widely used tools, and the readership is applied bioinformaticians. A critique of existing methods can be framed this way; a new estimator, a theory paper, or an applied lupus analysis cannot.

| Paper type | Fit | Why |
|--------------------------------------------|----------|------------------------------------------------|
| Critique with a closed-form bias, simulation, fix, and application | possible | As an evaluation of existing tools (LIONESS, SSN, SWEET) it fits a protocol or review frame, but the stated ban on pure original research makes the new fix a risk. |
| Simulation and diagnostic, no closed form | possible | A systematic benchmark of established methods suits a review or Problem Solving Protocol. |
| Constructive method with theory, simulation, comparison, and application | poor | The manuscript-preparation page excludes "work on new methods that have not yet been described elsewhere" [2], although the About page lists new methods [3] and SWEET appeared here (paper 1 below). |
| Short methods note | poor | The short types are opinion articles, letters critiquing a BIB paper, and software reviews by non-originators, each 500 to 1,000 words [2]. |
| Theory paper | poor | The aims address experimental practitioners, not theory. |
| Applied analysis | poor | Case studies must be "applied to clinical practice" and the journal does not take pure original research [2]. |

## Article types that fit

| Article type | Length | Figures and tables | References | Source |
|-------------------|--------------------------|---------------------|-------------|--------|
| Problem solving protocol | 2,000 to 5,000 words | not stated on the site | not stated on the site | [2] |
| Review | 2,000 to 7,000 words; no new results of the authors' own | not stated on the site | not stated on the site | [2] |
| Opinion article | 500 to 1,000 words | not stated on the site | not stated on the site | [2] |

## Abstract

- Structured: not stated on the site; reviews and software or website reviews need "a short abstract, outlining the aims and subject matter" [2].
- Headings: none stated.
- Word limit: not stated on the site.
- Also required: Key Points, "3-5 brief sentences" shown at the end of the article, up to six keywords, and a roughly 30-word biography for each author [2].

## Reference style

- The journal's stated style: numbered citations "in square brackets before the punctuation," and a reference list styled "to be consistent with PubMed," for example: Attwood T.K. The role of pattern databases in sequence analysis. Brief Bioinform 2000;1:45 to 59 (page range written with an en dash on the site) [2].
- CSL file: `dependent/briefings-in-bioinformatics.csl` in the official styles repository (github.com/citation-style-language/styles, commit d2cc420, 2026-10-24), a dependent style whose parent is `cse-citation-sequence-brackets-8th-edition.csl`.
- File to use in Quarto: `csl/cse-citation-sequence-brackets-8th-edition.csl`, which renders offline. The journal-named `csl/dependent/briefings-in-bioinformatics.csl` gives the same output but needs a network connection, because pandoc fetches the parent at render time.
- Rendering test: both files passed on 2026-10-27 (`csl/test-results.md`).

## Supplement, code, and data

- Supplementary material: not described as its own topic; data may go in "additional supporting files" [2], and AI use must be documented in the supplementary materials [1].
- Data availability statement: required ("The inclusion of a data availability statement is a requirement for papers published in the Journal"), placed in the end matter under the heading "Data availability" [1, 2].
- Code: encouraged, not required. "Where ethically feasible, the Journal strongly encourages authors to make all data and software code" available; authors depositing data are "required to select a repository that issues DOIs" [1]. No timing (submission or acceptance) and no reproducibility review is stated.

## AI-use policy

> "It is not acceptable to use LLMs or related technologies to draft papers ... from a prompt text. In essence, papers must be written by researchers." [1]

> "Natural language processing tools driven by artificial intelligence (AI) do not qualify as authors, and the Journal will screen for them in author lists." [1]

> "The use of AI (for example, to help generate content or images, write code, process data, or for translation) should be disclosed both in cover letters to editors and in the Methods or Acknowledgements section of manuscripts." [1]

The journal follows the ISCB acceptable-use policy for large language models. LLM-generated text snippets may appear as examples if "clearly labelled, and their use explained," and any acceptable use that produces part of the text or figures must be "explicitly declared and documented with sufficient details in the supplementary materials" [1]. AI-generated images are covered only by the disclosure sentence above. OUP's publisher-wide policy [6] defers to journal-specific rules; the journal's page links to ISCB and COPE, not to the OUP page.

- Read at: https://academic.oup.com/bib/pages/author-guidelines, 2026-10-27.
- What the manuscript must do: disclose AI use in the cover letter and in the Methods or Acknowledgements, document it in the supplement, and confirm the authors wrote the paper.

## Open access and charges

- Model: fully open access since Volume 25 (January 2024), CC BY or CC BY-NC [1, 4].
- Article processing charge: USD 4,079 for a Problem solving protocol, from OUP's charge calculator with no discount selected; prices exclude sales taxes and are "subject to change" [5]. The open access page says charges apply "From October 2023" [4].
- Waivers and institutional agreements: automatic waivers for Letters to the Editor and Corrigenda, waivers through OUP's Low and Middle Income Countries initiative, discretionary waivers if requested before acceptance [4], and Read and Publish agreements [1, 4].

## Review

- Model: single anonymized; manuscripts are "typically sent to 3 reviewers" [1].
- Time to decision: the guidelines say "The average to before first decision is around 20 days" and the journal aims "to give a decision within two months in all cases"; it receives over 2,000 submissions a year and publishes "less than a quarter" [1]. The About page gives a 2025 median of 8 days from submission to first decision and 8 days to final decision [3].

## Recent papers like ours

1. Chen H-H, Hsueh C-W, Lee C-H, Hao T-Y, Tu T-Y, Chang L-Y, Lee J-C, Lin C-Y (2023). SWEET: a single-sample network inference method for deciphering individual features in disease. *Briefings in Bioinformatics* 24, bbad032. https://doi.org/10.1093/bib/bbad032. Introduces one of the single-sample network methods our LIONESS follow-up critiques, so the journal is the natural audience for that critique [7].
2. Meng G, Tang W, Huang E, Li Z, Feng H (2023). A comprehensive assessment of cell type-specific differential expression methods in bulk data. *Briefings in Bioinformatics* 24, bbac516. https://doi.org/10.1093/bib/bbac516. A simulation and real-data benchmark of composition-aware methods, like our composition-adjustment work [7].
3. Burns JJR, Shealy BT, Greer MS, Hadish JA, McGowan MT, Biggs T, Smith MC, Feltus FA, Ficklin SP (2022). Addressing noise in co-expression network construction. *Briefings in Bioinformatics* 23, bbab495. https://doi.org/10.1093/bib/bbab495. Shows that many co-expression edges are artifacts of mixed experimental conditions and proposes a remedy, a co-expression critique with a fix [7].

## Not stated on the site, or could not be read

- Abstract structure and word limit: not stated on [2].
- Figure, table, and reference limits: not stated on [2].
- Code timing (submission or acceptance): not stated on [1].
- Reproducibility review: not stated on the site.
- Contradiction: [2] still describes open access as an option chosen after acceptance and says the journal is a review journal, while [1] and [4] say it is fully open access since 2024 and [3] lists "new methods" among what it publishes. [2] appears older than [1]; its article types and reference style are used here because [1] gives none.

## Table row

```
scope_5_words: reviews and protocols for practitioners
audience: genomics users
fit_critique: possible
fit_sim_diagnostic: possible
fit_constructive: poor
fit_short_note: poor
fit_theory: poor
fit_applied: poor
abstract_format: not stated
abstract_words: not stated
length_limit: Problem solving protocol, 2,000 to 5,000 words
apc: USD 4,079
oa_model: open access
ai_policy_3_words: disclose, no drafting
review_model: single
guidelines_read: partly
```
