# The American Statistician

| Field | Value |
|-----------------|--------------------------------------------------------------|
| Publisher | Taylor & Francis (Informa UK); American Statistical Association [2] |
| Online ISSN | 1537-2731 (print 0003-1305) [12] |
| Profile written | 2026-10-27 |

## Sources

Every page below was read on the date shown. Bracketed numbers in the text point here.

1. [ASA, The American Statistician Welcomes Submissions](https://www.amstat.org/publications/q-and-as/the-american-statistician-welcomes-submissions), read 2026-10-27.
2. [ASA Style Guide (PDF on the Taylor & Francis file server; covers JASA, TAS, JCGS, and other ASA journals; undated)](https://files.taylorandfrancis.com/asa-style-guide.pdf), read 2026-10-27.
3. [Taylor & Francis Author Services, Defining authorship in your research paper](https://authorservices.taylorandfrancis.com/editorial-policies/defining-authorship-research-paper/), read 2026-10-27.
4. [Taylor & Francis Author Services, Using AI in your research and manuscript preparations](https://authorservices.taylorandfrancis.com/editorial-policies/using-ai-in-your-research-and-manuscript-preparations/), read 2026-10-27.
5. [Taylor & Francis Author Services, Images and figures](https://authorservices.taylorandfrancis.com/editorial-policies/images-and-figures/), read 2026-10-27.
6. [Taylor & Francis, AI Policy](https://taylorandfrancis.com/our-policies/ai-policy/), read 2026-10-27.
7. [Taylor & Francis Author Services, Publishing open access with Open Select](https://authorservices.taylorandfrancis.com/choose-open/publishing-open-access/open-select/), read 2026-10-27.
8. [Taylor & Francis Author Services, Open Access Cost Finder](https://authorservices.taylorandfrancis.com/choose-open/publishing-open-access/open-access-cost-finder/), read 2026-10-27 through Claude in Chrome (paged list under "Calculate your article publishing charge", country set to United States).
9. [Taylor & Francis Author Services, Understanding peer review](https://authorservices.taylorandfrancis.com/publishing-your-research/peer-review/), read 2026-10-27.
10. [Taylor & Francis Author Services, Data sharing policies](https://authorservices.taylorandfrancis.com/data-sharing-policies/), read 2026-10-27.
11. [ASA Publications: Journals](https://www.amstat.org/publications/journals), read 2026-10-27.
12. [Crossref journal record for ISSN 1537-2731](https://api.crossref.org/journals/1537-2731), read 2026-10-27.
13. Crossref work records at `https://api.crossref.org/works/<DOI>` for each paper under "Recent papers like ours", read 2026-10-27.
14. [The American Statistician Instructions for authors](https://www.tandfonline.com/action/authorSubmission?show=instructions&journalCode=utas20), read 2026-10-27 through Claude in Chrome.
15. [The American Statistician About this journal (aims, journal metrics)](https://www.tandfonline.com/journals/utas20/about-this-journal), read 2026-10-27 through Claude in Chrome.

## Scope

> "The American Statistician strives to publish articles of general interest to the statistical profession. Articles should be clearly written, address topics that are important for a broad group of statisticians, and ordinarily not be highly technical." [14]

The instructions list eight sections: Statistical Practice, General, Teacher's Corner, Statistical Computing and Graphics, Reviews, Letters, History Corner, and Interdisciplinary [14]; the ASA page lists the same eight [1], and the about page adds Data Science and Tutorial [15]. Two sections are closest to our work: Statistical Practice takes "discussions and comparisons of modern statistical methods, focusing on their usefulness in practice", and Interdisciplinary takes "critical reviews of statistical methodologies that are in common use outside of the statistical core" [14]. In plain terms, TAS publishes statistics for the whole profession: readable papers on practice, teaching, and pitfalls of common methods, read by working statisticians and teachers more than by specialists. Recent papers with titles such as "When Your Permutation Test is Doomed to Fail" and "A Cautionary Tale" show that a clear, accessible critique of a widely used procedure is a natural fit, provided the genomics detail is kept light enough for a general statistical reader.

| Paper type | Fit | Why |
|--------------------------------------------|----------|------------------------------------------------|
| Critique with a closed-form bias, simulation, fix, and application | good | The Interdisciplinary section takes critical reviews of methods in common use outside the statistical core [14], and the journal publishes critiques of common procedures, including permutation tests (Christensen and Zabriskie 2021). |
| Simulation and diagnostic, no closed form | good | Statistical Practice takes comparisons of methods focused on their usefulness in practice [14], and the journal publishes work on how simulation studies are run and reported (Pawel et al. 2025). |
| Constructive method with theory, simulation, comparison, and application | poor | A new procedure for one estimand is a specialist contribution, while articles should address topics "important for a broad group of statisticians" and "ordinarily not be highly technical" [14]. |
| Short methods note | good | Short cautionary papers appear (Hutson and Yu 2022, six pages), and a typical paper should be at most 25 pages [14]. |
| Theory paper | poor | Articles should "ordinarily not be highly technical" [14]. |
| Applied analysis | poor | A genomics analysis without a general statistical lesson does not address topics "important for a broad group of statisticians" [14]. |

## Article types that fit

| Article type | Length | Figures and tables | References | Source |
|-------------------|--------------------------|---------------------|-------------|--------|
| Statistical Practice article | a typical paper at most 25 pages, inclusive of the abstract, tables, references, figure captions, footnotes, and endnotes | count toward the 25 pages | count toward the 25 pages | [14] |
| General article | as for Statistical Practice | as for Statistical Practice | as for Statistical Practice | [14] |
| Statistical Computing and Graphics article | as for Statistical Practice | as for Statistical Practice | as for Statistical Practice | [14] |
| Interdisciplinary article | as for Statistical Practice | as for Statistical Practice | as for Statistical Practice | [14] |

Formatting that is stated: submissions must be 12 point and fully double spaced, "which we define as 26 lines of text per page", and appendices of more than two paragraphs go into online supplements [2].

## Abstract

- Structured: no; the ASA style guide asks the abstract to "summarize results, topics discussed, and main conclusions" with no displays, no complex mathematical notation, and no references, and names no headings [2].
- Headings: none.
- Word limit: 200 words, per the ASA style guide, which covers TAS; three to five key words follow [2]. The TAS instructions page gives no abstract rules beyond the abstract's place in the order of manuscript parts [14].

## Reference style

- The journal's stated style: ASA author-year style. The instructions say references give the author name and then the year in parentheses, are listed alphabetically, and follow the ASA Style Guide, and "Do not abbreviate journal titles"; the TAS LaTeX template is described as "compatible with Quarto and Overleaf" [14]. In the style guide, in-text citations give the author's surname and date ("Efron (2020)", or "(Lee 2008; Ludwig and Miller 2007)"); "et al." for three or more authors; the reference list is alphabetized, gives all authors (more than six may be cut to six plus "et al."), puts the year in parentheses followed by a comma, the article title in double quotation marks, the journal name spelled out in italics, volume, pages, and a DOI if available [2].
- CSL file: `dependent/the-american-statistician.csl` in the official styles repository (github.com/citation-style-language/styles, commit d2cc420, 2026-10-24), a dependent style whose parent is `american-statistical-association.csl`.
- File to use in Quarto: `csl/american-statistical-association.csl`, which renders offline. The journal-named `csl/dependent/the-american-statistician.csl` gives the same output but needs a network connection, because pandoc fetches the parent at render time.
- Rendering test: both files passed on 2026-10-27 (`csl/test-results.md`).

## Supplement, code, and data

- Supplementary material: appendices longer than two paragraphs must be online supplements, cited as "the online Appendix" or "online Appendix A"; the ASA "prefers that code and data are submitted as supplemental material" [2].
- Data availability statement: not recorded from the instructions page [14]. Taylor & Francis assigns each journal a data sharing tier stated in its Instructions for Authors [10].
- Code: required, at acceptance. "American Statistician requires authors to provide well-documented code that duplicates at least one table or figure of prominent empirical results from the paper." "The code, its execution and output, and its documentation may be evaluated along with the manuscript." [14] "Supplementary materials, including data and code, are expected upon acceptance, and may be submitted earlier." Materials sent before acceptance must be anonymous [14].

## AI-use policy

> "Declaration of generative AI use. Please include a statement disclosing whether and how generative AI has been used in the research and manuscript preparation process." [14]

> "You must not list AI tools as a co-author of your article." "Please add a Declaration of generative AI use statement disclosing whether and how generative AI has been used." [3]
>
> "Taylor & Francis does not allow generative AI to create a first draft of a manuscript or sections of a manuscript." [4]

The first quotation is a checklist item on the TAS instructions page [14]; the others are publisher-wide policies: the authorship page says its instructions "apply to all Taylor & Francis Group journals" [3], and the images page says the same [5]. Paraphrase of the rest: AI may improve spelling, grammar, and flow, but "cannot be used to create or conclude the argument of an article" [4]; AI may generate software code if the author reviews and verifies it [4]; the statement must give the tool's name and version, how and why it was used, and confirm that the authors take full responsibility for the content, including the accuracy of references [3, 4]; AI use in research methods must also be detailed in the methods section [4]; AI must not be used to create or manipulate images and figures from research data, AI help with data visualisations is allowed, and any AI-generated image needs a statement in its figure legend [5]. Reviewers and editors must not upload unpublished manuscripts to AI tools [6].

- Read at: https://www.tandfonline.com/action/authorSubmission?show=instructions&journalCode=utas20, https://authorservices.taylorandfrancis.com/editorial-policies/defining-authorship-research-paper/, and https://authorservices.taylorandfrancis.com/editorial-policies/using-ai-in-your-research-and-manuscript-preparations/, 2026-10-27.
- What the manuscript must do: carry a "Declaration of generative AI use" statement naming each tool and version, saying how and why it was used and that the authors take full responsibility, repeat any methodological AI use in the Methods, and contain no AI-drafted text; neither the checklist item [14] nor the publisher pages say where in the manuscript the statement goes.

## Open access and charges

- Model: hybrid. The instructions offer optional open access through Open Select [14], and the Cost Finder lists TAS under Open Select (hybrid) [8]. The ASA style guide says TAS is copyrighted by the ASA and "Authors are able to retain copyright and make articles Open Access through payment of the Article Processing Charge (APC)" [2]; Taylor & Francis calls this option Open Select, "often referred to as "hybrid open access"" [7].
- Article processing charge: none unless the authors choose open access. "There are no submission fees, publication fees or page charges for this journal." [14] The open access charge is USD 3,940 for "Statistical Practice", with the country set to United States; read 2026-10-27 [8].
- Waivers and institutional agreements: "You may be eligible for a reduced or fully-waivered APC if your institution has an agreement with Taylor & Francis." [7]

## Review

- Model: double anonymized. Papers are "double anonymous peer reviewed by independent, anonymous expert referees" [14].
- Time to decision: 53 days on average from submission to first decision; 123 days on average to the first post-review decision; 66 days on average from acceptance to online publication; acceptance rate 18% [15].

## Recent papers like ours

1. Christensen WF, Zabriskie BN (2021). When Your Permutation Test is Doomed to Fail. *The American Statistician*, 76(1), 53 to 63. https://doi.org/10.1080/00031305.2021.1902856. A critique of when a widely used permutation test breaks down, the same genre as our PERMANOVA work.
2. Hutson AD, Yu H (2022). The Sign Test, Paired Data, and Asymmetric Dependence: A Cautionary Tale. *The American Statistician*, 77(1), 35 to 40. https://doi.org/10.1080/00031305.2022.2110938. A short cautionary paper on what a standard test actually detects under a data structure users overlook, our critique framing in note length.
3. Pawel S, Bartoš F, Siepe BS, Lohmann A (2025). Handling Missingness, Failures, and Non-Convergence in Simulation Studies: A Review of Current Practices and Recommendations. *The American Statistician*, 80(1), 31 to 48. https://doi.org/10.1080/00031305.2025.2540002. A paper about how simulation studies are done and reported, relevant to our ADEMP-designed simulations.

## Not stated on the site, or could not be read

- Separate limits on figures, tables, and references: none recorded; they count toward the 25 pages [14].
- Abstract word limit and number of key words: not stated on the instructions page [14]; the values above come from the ASA style guide [2].
- Data availability statement and Taylor & Francis data sharing tier: not recorded from the instructions page [14].
- Where the Declaration of generative AI use goes in the manuscript: not stated in the checklist item [14].
- The submission link on the ASA page points to https://mc.manuscriptcentral.com/amstat [1]; that page was not read.

### Contradictions

- List of sections: the instructions [14] and the ASA page [1] list eight sections, while the about page also lists Data Science and Tutorial [15].

## Table row

```
scope_5_words: clear, general-interest articles for statisticians
audience: methodologists
fit_critique: good
fit_sim_diagnostic: good
fit_constructive: poor
fit_short_note: good
fit_theory: poor
fit_applied: poor
abstract_format: unstructured
abstract_words: 200
length_limit: typical paper: 25 pages
apc: none required (open access USD 3,940)
oa_model: hybrid
ai_policy_3_words: disclose, no drafting
review_model: double
guidelines_read: yes
```
