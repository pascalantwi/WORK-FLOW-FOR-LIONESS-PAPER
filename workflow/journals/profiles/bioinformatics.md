# Bioinformatics

| Field | Value |
|-----------------|--------------------------------------------------------------|
| Publisher | Oxford University Press; journal of the International Society for Computational Biology (ISCB) [2] |
| Online ISSN | 1367-4811 [2] |
| Profile written | 2026-10-27 |

## Sources

Every page below was read on the date shown. Bracketed numbers in the text point here.

1. [Bioinformatics: Author guidelines](https://academic.oup.com/bioinformatics/pages/author-guidelines), read 2026-10-27.
2. [Bioinformatics: About](https://academic.oup.com/bioinformatics/pages/About), read 2026-10-27.
3. [Bioinformatics: Open Access](https://academic.oup.com/bioinformatics/pages/open-access), read 2026-10-27.
4. [OUP: Charges, licences, and self-archiving](https://academic.oup.com/pages/open-research/open-access/charges-licences-and-self-archiving), read 2026-10-27; its "What is the OA charge for my article?" calculator read 2026-10-27 through Claude in Chrome, with no Low and Middle Income Countries discount and no society membership selected.
5. [OUP: Policy on AI Use and Disclosure for OUP Journals Authors](https://academic.oup.com/pages/for-authors/journals/preparing-and-submitting-your-manuscript/ai-principles-for-oxford-journals/policy-on-ai-use-and-disclosure-for-oxford-journals-authors), read 2026-10-27.
6. [Crossref REST API record lookups for the DOIs under "Recent papers like ours"](https://api.crossref.org/works), read 2026-10-27.

## Scope

> "provides a forum for the exchange of information in the fields of computational molecular biology and genome bioinformatics ... with emphasis on new algorithms and databases that advance the progress of bioinformatics and biomedical research in a significant manner." [1]

Bioinformatics is the ISCB's flagship methods journal. It publishes new algorithms, software, and databases for computational biologists, and expects each Original Paper to work on real biological data: the guidelines say "Only in extremely well-justified cases can simulated data alone be used instead of real data" [1]. A critique paper fits when it ends in a fix shipped as software and is shown on real data, which is how we writes its main papers. A pure simulation study, a theory paper, or an applied analysis fits poorly.

| Paper type | Fit | Why |
|--------------------------------------------|----------|------------------------------------------------|
| Critique with a closed-form bias, simulation, fix, and application | good | An Original Paper offering a corrected method plus an R package, tested on real lupus data, matches the stated emphasis on new methods with real data. |
| Simulation and diagnostic, no closed form | possible | Acceptable only if the diagnostic is a usable tool shown on real data, since simulated data alone is accepted only in well-justified cases. |
| Constructive method with theory, simulation, comparison, and application | good | New methods shipped as software and shown on real data are the stated emphasis [1], though the seven-page limit pushes the theory into the supplement. |
| Short methods note | possible | The Application Note (4 pages) fits only if the note is centered on freely available software. |
| Theory paper | poor | The aims stress algorithms and databases, not mathematical results. |
| Applied analysis | poor | The journal wants methodological advances, not biological findings from existing methods. |

## Article types that fit

| Article type | Length | Figures and tables | References | Source |
|-------------------|--------------------------|---------------------|-------------|--------|
| Original Paper | up to 7 pages, about 5,000 words excluding figures | not stated on the site | not stated on the site | [1] |
| Application Note | up to 4 pages, about 2,600 words, or 2,000 words plus one figure | one figure in the 2,000-word option; otherwise not stated | not stated on the site | [1] |

## Abstract

- Structured: could not be read. The author guidelines [1] point to a "Preparing your manuscript" section (anchor `#Manuscript Prep`) that did not appear in the page text that loaded; the visible text only says the software URL goes "in the availability section of the abstract" [1].
- Headings: could not be read (see above).
- Word limit: could not be read (see above).

## Reference style

- The journal's stated style: could not be read. The guidelines say only that public datasets must be "fully referenced in the reference list with an accession number or unique identifier" [1]; the manuscript preparation section that would give the format did not load.
- CSL file: `dependent/bioinformatics.csl` in the official styles repository (github.com/citation-style-language/styles, commit d2cc420, 2026-10-24), a dependent style whose parent is `oxford-journals-scimed-author-date.csl`. The journal's own style section could not be read, so this match rests on the repository, not on the site.
- File to use in Quarto: `csl/oxford-journals-scimed-author-date.csl`, which renders offline. The journal-named `csl/dependent/bioinformatics.csl` gives the same output but needs a network connection, because pandoc fetches the parent at render time.
- Rendering test: both files passed on 2026-10-27 (`csl/test-results.md`).

## Supplement, code, and data

- Supplementary material: submitted as separate files and referred to in the main text; it "cannot be altered or replaced after the paper has been accepted for publication" and is hosted on the journal site [1].
- Data availability statement: required ("The inclusion of a data availability statement is a requirement for papers published in the Journal"); data underlying the paper should be in stable public repositories and cited with an accession number or DOI [1].
- Code: required at submission. Authors must "make the software and the source code freely available at stable URLs" without request to non-commercial users at the time of submission, archive the version and test data "at dedicated repositories such as Zenodo, Figshare, Software Heritage, CRAN, and Bioconductor", and give the URL in the abstract's availability section; documentation, test data, and reproduction instructions are required, and Code Ocean is encouraged [1]. No reproducibility review is described.

## AI-use policy

> "It is not acceptable to use LLMs or related technologies to draft papers (including but not limited to text, figures, tables, and references) from a prompt text. In essence, papers must be written by researchers." [1]

> "LLMs cannot be listed as authors" [1]

> "The use of AI (for example, to help generate content, write code, or process data) should be disclosed both in cover letters to editors and in the Methods or Acknowledgements section of manuscripts." [1]

The journal follows the ISCB acceptable-use policy for large language models, linked from its guidelines. Acceptable uses named there are correcting text, aiding translation, code assistance, and drafting documentation, with the researcher responsible for correctness [1]. Any acceptable use that produces part of the text, figures, or other content "should be explicitly declared and documented with sufficient details in the supplementary materials" [1]. The guidelines say nothing separate about AI-generated images beyond counting figures in the drafting ban. OUP's publisher-wide policy [5] allows journals to add their own requirements and tells authors to follow the journal's guidance where they differ; the journal's page links to the ISCB policy, not the OUP page.

- Read at: https://academic.oup.com/bioinformatics/pages/author-guidelines, 2026-10-27.
- What the manuscript must do: disclose any AI use in the cover letter and in the Methods or Acknowledgements, document it in detail in the supplement, and make clear the text was written by the authors and not drafted from prompts.

## Open access and charges

- Model: fully open access, CC BY, since the 2023 volume [1, 3].
- Article processing charge: USD 4,376 for an Original paper, from OUP's charge calculator with no discount selected; prices exclude sales taxes and are "subject to change" [4]. The calculator also lists Applications notes [4]. Letters, editorials, and similar items are free [3].
- Waivers and institutional agreements: waivers for authors in OUP's Low and Middle Income Countries initiative and discretionary waivers if applied for before acceptance [3]; Read and Publish agreements may pay the charge if the qualifying institution is the corresponding author's primary affiliation at submission [1]. ISCB members get a 15% discount on the open access page [3], while the guidelines' calculator lists a 20% "Society membership discount" [1].

## Review

- Model: single anonymized; manuscripts are typically sent to three reviewers, and less significant papers are returned without review after pre-screening [1].
- Time to decision: 2025 median of 23 days from submission to first decision, and 23 days from submission to final decision [2].

## Recent papers like ours

1. Hsieh P-H, Lopes-Ramos CM, Zucknick M, Sandve GK, Glass K, Kuijjer ML (2023). Adjustment of spurious correlations in co-expression measurements from RNA-Sequencing data. *Bioinformatics* 39, btad610. https://doi.org/10.1093/bioinformatics/btad610. It shows a widely used preprocessing step (quantile-based normalization) creates false co-expression and proposes a correction, the same critique-then-fix pattern as the LIONESS work [6].
2. Hu Y-J, Satten GA (2022). A rarefaction-without-resampling extension of PERMANOVA for testing presence-absence associations in the microbiome. *Bioinformatics* 38, 3689 to 3697. https://doi.org/10.1093/bioinformatics/btac399. It addresses confounding by library size in PERMANOVA and gives a fixed version of the test, close to our permutation-test papers [6].
3. Dietrich A, Sturm G, Merotto L, Marini F, Finotello F, List M (2022). SimBu: bias-aware simulation of bulk RNA-seq data with variable cell-type composition. *Bioinformatics* 38, ii141 to ii147. https://doi.org/10.1093/bioinformatics/btac499. A simulation framework for evaluating methods under varying cell composition, relevant to our composition-adjustment papers [6].

## Not stated on the site, or could not be read

- Abstract structure, headings, and word limit: could not be read; the "Preparing your manuscript" section linked from https://academic.oup.com/bioinformatics/pages/author-guidelines did not appear in the loaded text (plain download returns HTTP 403, and the browser hit a "verify you are human" check, which was not attempted).
- Reference style: could not be read, same page and same reason.
- Figure, table, and reference limits for Original Papers: not stated in the text that loaded [1].
- Article processing charge for Application Notes and Reviews: the calculator lists Applications notes [4], but only the Original paper amount was recorded.
- Reproducibility review: not stated on the site.

## Table row

```
scope_5_words: new computational biology methods software
audience: genomics users
fit_critique: good
fit_sim_diagnostic: possible
fit_constructive: good
fit_short_note: possible
fit_theory: poor
fit_applied: poor
abstract_format: not stated
abstract_words: not stated
length_limit: Original Paper, 7 pages (about 5,000 words)
apc: USD 4,376
oa_model: open access
ai_policy_3_words: disclose, no drafting
review_model: single
guidelines_read: partly
```
