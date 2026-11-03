# PLOS Computational Biology

| Field | Value |
|-----------------|--------------------------------------------------------------|
| Publisher | Public Library of Science (PLOS), a nonprofit; no society named on the pages read |
| Online ISSN | 1553-7358 |
| Profile written | 2026-10-27 |

## Sources

Every page below was read on the date shown. Bracketed numbers in the text point here.

1. [Journal information (scope)](https://journals.plos.org/ploscompbiol/s/journal-information), read 2026-10-27.
2. [Submission guidelines (article types, abstract, Author Summary, references, supporting information)](https://journals.plos.org/ploscompbiol/s/submission-guidelines), read 2026-10-27.
3. [Code availability policy](https://journals.plos.org/ploscompbiol/s/code-availability), read 2026-10-27.
4. [Ethical publishing practice (PLOS-wide; includes "Artificial Intelligence Tools and Technologies")](https://journals.plos.org/ploscompbiol/s/ethical-publishing-practice), read 2026-10-27.
5. [Editorial and peer review process](https://journals.plos.org/ploscompbiol/s/editorial-and-peer-review-process), read 2026-10-27.
6. [PLOS publication fees (PLOS-wide; includes fee assistance and Research4Life terms)](https://plos.org/publish/fees/), read 2026-10-27.
7. [PLOS metrics (PLOS-wide, 2025 figures)](https://plos.org/metrics/), read 2026-10-27.
8. [Publishing information (eISSN)](https://journals.plos.org/ploscompbiol/s/publishing-information), read 2026-10-27.
9. [PLOS ONE data availability policy (PLOS-wide data policy, used here for the statement requirement)](https://journals.plos.org/plosone/s/data-availability), read 2026-10-27.

## Scope

> "PLOS Computational Biology features works of exceptional significance that further our understanding of living systems at all scales" [1]

In plain terms, this journal wants computational work that teaches us something new about biology, and it sets a high bar for significance. Readers are life and computational scientists [1]. Methods papers must describe "outstanding methods of exceptional importance," and "The method must already be widely adopted or have the promise of wide adoption by a broad community of users" [2]. Of most interest to us, the journal also has a designated Benchmarking article type for "good and comprehensive benchmarks" of publicly available tools in an active research area [2]. Computational findings should generally be validated on real data or by experiment [1]. A critique that shows a popular genomics method misleads users, with a theoretical explanation and real-data consequences, fits as a Research Article if the biological stakes are made clear; it also publishes critiques of widely used analysis practice (papers 1 and 3 below). A purely statistical theory paper or a routine applied analysis is a poor fit.

| Paper type | Fit | Why |
|--------------------------------------------|----------|------------------------------------------------|
| Critique with a closed-form bias, simulation, fix, and application | possible | Critiques of widely used metrics with theory and data appear here (paper 1 below), but the bar is "exceptional significance" for understanding living systems [1]. |
| Simulation and diagnostic, no closed form | possible | The Benchmarking type takes comprehensive, transparent comparisons of public tools [2], and simulation-based critiques appear (paper 3 below). |
| Constructive method with theory, simulation, comparison, and application | possible | A new adjustment method appeared here (paper 2 below), but Methods papers must describe "outstanding methods of exceptional importance" with "the promise of wide adoption by a broad community of users" [2]. |
| Short methods note | poor | No short research format is listed; only Software articles have a length cap [2], and the significance bar is high [1]. |
| Theory paper | poor | The journal's scope centers on biological insight from computation [1], not statistical theory for its own sake. |
| Applied analysis | poor | An applied reanalysis would need to deliver exceptional new biological understanding [1]. |

## Article types that fit

| Article type | Length | Figures and tables | References | Source |
|-------------------|--------------------------|---------------------|-------------|--------|
| Research Article | "Manuscripts can be any length." | no limit: "no restrictions on word count, number of figures, or amount of supporting information" | not stated on the site | [2] |
| Benchmarking | no limit stated | no limit stated | not stated on the site | [2] |
| Methods | no limit stated; cover letter must answer five questions on innovation, relevance, users, validation, and availability | no limit stated | not stated on the site | [2] |
| Software (for the R package) | "less than 3500 words, not including supplementary material" | not stated on the site | not stated on the site | [2] |

## Abstract

- Structured: no; the abstract is conceptually Background, Methodology/Principal Findings, and Conclusions/Significance, but authors must "not apply these distinct headings to the Abstract within the article file" [2]
- Headings: none in the article file
- Word limit: 300 [2]
- Also required: an Author Summary of 150 to 200 words, non-technical, in the first person, placed right after the abstract [2]

## Reference style

- The journal's stated style: numbered Vancouver: "PLOS uses "Vancouver" style, as outlined in the ICMJE sample references." [2]
- CSL file: `dependent/plos-computational-biology.csl` in the official styles repository (github.com/citation-style-language/styles, commit d2cc420, 2026-10-24), a dependent style whose parent is `plos.csl`.
- File to use in Quarto: `csl/plos.csl`, which renders offline. The journal-named `csl/dependent/plos-computational-biology.csl` gives the same output but needs a network connection, because pandoc fetches the parent at render time.
- Rendering test: both files passed on 2026-10-27 (`csl/test-results.md`).

## Supplement, code, and data

- Supplementary material: any file type, each under 20 MB; captions at the end of the manuscript; items named with an "S" and a number. Software submissions deposit archived code and test data as a supplemental file under 100 MB [2].
- Data availability statement: required under the PLOS data policy; it names repositories and identifiers, and data must be public at publication [9]. The PLOS Computational Biology code policy also routes restrictions through the Data Availability Statement [3].
- Code: mandatory. The policy "requires authors to make all author-generated code directly related to their study's findings publicly available." "Relevant code should be available to editors and reviewers at the time of submission," and "Upon publication of your article, you must share publicly any code that you created." A permanent repository that issues DOIs is strongly recommended. Exemptions "must be approved by an Editor, and must be requested at submission." [3] So code goes to reviewers at submission and becomes public at publication. No formal reproducibility review is stated.

## AI-use policy

> "AI tools cannot be listed as authors." Disclosures "should be in the body of the article, either in a dedicated section of the Methods" (or the Acknowledgements or figure legends). [4]

- Disclosure must give "the name(s) of any tools used," and "a description of how the tool(s) was/were used." [4]
- AI help with figures is allowed if "AI-generated content is not used to misrepresent primary research outputs," and "Any AI use for figure preparation should be clearly disclosed in the figure legend." [4]
- The page states "The following policies apply to all PLOS journals, unless otherwise noted," and the AI section carries no exception [4].
- Read at: https://journals.plos.org/ploscompbiol/s/ethical-publishing-practice, 2026-10-27.
- What the manuscript must do: include a dedicated Methods subsection (or Acknowledgments text) naming each AI tool and how it was used, plus a note in any affected figure legend.

## Open access and charges

- Model: fully open access [6]
- Article processing charge: USD 3,165 per Research Article, read 2026-10-27; only USD is listed and no effective date is given [6]
- Waivers and institutional agreements: PLOS Publication Fee Assistance for authors unable to pay, requested at submission; Research4Life Group A authors without funding publish free and Group B authors pay USD 940; institutional partnerships can cover fees. Community Action Publishing does not apply to this journal [6].

## Review

- Model: single anonymized: the journal "uses single-anonymized peer review." Reviewers may sign; authors may opt in to publish the peer review history [5].
- Time to decision: median 41 days to first decision and 230 days to publication in 2025, with a 33% acceptance rate [7]. Reviewers typically get 14 days [5].

## Recent papers like ours

1. Rathod DR, Silverman JD (2026). PCR bias impacts microbiome ecological analyses. *PLOS Computational Biology*. https://doi.org/10.1371/journal.pcbi.1013908. Shows with theory and data which widely used alpha and beta diversity measures are distorted by PCR bias and when to correct, the same "what does this metric really estimate" structure as our critiques.
2. Chen AA, Clark K, Dewey BE, DuVal A, Pellegrini N, Nair G, Jalkh Y, Khalil S, Zurawski J, Calabresi PA, Reich DS, Bakshi R, Shou H, Shinohara RT (2024). PARE: A framework for removal of confounding effects from any distance-based dimension reduction method. *PLOS Computational Biology*. https://doi.org/10.1371/journal.pcbi.1012241. A fix for confounding in distance-based analyses, close to our PERMANOVA and composition-adjustment work.
3. Gemo P, Barrero Guevara LA, Kussmaul C, Kramer SC, Domenech de Cellès M (2026). The pitfalls of incidence-based time series regression for inferring the effects of weather on infectious diseases. *PLOS Computational Biology*. https://doi.org/10.1371/journal.pcbi.1014797. A controlled simulation study showing a widely used regression design fails to recover known effects, our simulation and diagnostic type in another field.

## Not stated on the site, or could not be read

- Reference limits: not stated on the site [2].
- Length or figure limits for Benchmarking and Methods articles: not stated on the site [2].
- A data availability page specific to PLOS Computational Biology was not read; the PLOS-wide policy on the PLOS ONE site was used [9].
- Reproducibility or code review: not stated on the site [3].
- Journal timings table on the journal site: not on the journal information page, which points to plos.org/metrics [1], [7].
- APC effective date and non-USD prices: not stated on the site [6].

## Table row

```
scope_5_words: computation advancing understanding of biology
audience: both
fit_critique: possible
fit_sim_diagnostic: possible
fit_constructive: possible
fit_short_note: poor
fit_theory: poor
fit_applied: poor
abstract_format: unstructured
abstract_words: 300
length_limit: Research Article, no limit
apc: USD 3,165
oa_model: open access
ai_policy_3_words: disclose, no authorship
review_model: single
guidelines_read: yes
```
