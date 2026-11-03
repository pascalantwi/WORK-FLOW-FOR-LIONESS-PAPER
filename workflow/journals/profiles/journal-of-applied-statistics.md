# Journal of Applied Statistics

| Field | Value |
|-----------------|--------------------------------------------------------------|
| Publisher | Taylor & Francis (Informa UK); no society named on the pages read [9] |
| Online ISSN | 1360-0532 (print 0266-4763) [9] |
| Profile written | 2026-10-27 |

## Sources

Every page below was read on the date shown. Bracketed numbers in the text point here.

1. [Taylor & Francis Author Services, Defining authorship in your research paper](https://authorservices.taylorandfrancis.com/editorial-policies/defining-authorship-research-paper/), read 2026-10-27.
2. [Taylor & Francis Author Services, Using AI in your research and manuscript preparations](https://authorservices.taylorandfrancis.com/editorial-policies/using-ai-in-your-research-and-manuscript-preparations/), read 2026-10-27.
3. [Taylor & Francis Author Services, Images and figures](https://authorservices.taylorandfrancis.com/editorial-policies/images-and-figures/), read 2026-10-27.
4. [Taylor & Francis, AI Policy](https://taylorandfrancis.com/our-policies/ai-policy/), read 2026-10-27.
5. [Taylor & Francis Author Services, Publishing open access with Open Select](https://authorservices.taylorandfrancis.com/choose-open/publishing-open-access/open-select/), read 2026-10-27.
6. [Taylor & Francis Author Services, Open Access Cost Finder](https://authorservices.taylorandfrancis.com/choose-open/publishing-open-access/open-access-cost-finder/), read 2026-10-27 through Claude in Chrome (paged list under "Calculate your article publishing charge", country set to United States).
7. [Taylor & Francis Author Services, Understanding peer review](https://authorservices.taylorandfrancis.com/publishing-your-research/peer-review/), read 2026-10-27.
8. [Taylor & Francis Author Services, Data sharing policies](https://authorservices.taylorandfrancis.com/data-sharing-policies/), read 2026-10-27.
9. [Crossref journal record for ISSN 1360-0532](https://api.crossref.org/journals/1360-0532), read 2026-10-27.
10. Crossref work records at `https://api.crossref.org/works/<DOI>` for each paper under "Recent papers like ours", read 2026-10-27.
11. [Journal of Applied Statistics Instructions for authors](https://www.tandfonline.com/action/authorSubmission?show=instructions&journalCode=cjas20), read 2026-10-27 through Claude in Chrome.
12. [Journal of Applied Statistics About this journal (aims, journal metrics)](https://www.tandfonline.com/journals/cjas20/about-this-journal), read 2026-10-27 through Claude in Chrome.

## Scope

> "Journal of Applied Statistics is a world-leading journal which provides a forum for communication among statisticians and practitioners for judicious application of statistical principles and innovations of statistical methodology motivated by current and important real-world examples across a wide range of disciplines" [12]

The listed disciplines include "genetics and genomics" and "biological and biomedical sciences" [12]. Theory is limited: "Purely theoretical papers are avoided but those on theoretical developments which clearly exhibit concrete applied potential may be considered." [12] In plain terms, the journal publishes statistical methods motivated by and applied to real data across many fields, including genomics (RNA-seq, differential networks, genomic prediction); readers include both methodologists and applied statisticians. A Research Article opens with one or two data challenges and the relevant data, then gives the methodology, an application (where "Simulation studies can be presented as a sub-section"), and a discussion [11]. A recent paper on the bias of cross-validation in genomic prediction, with a correction, has nearly the same shape as our critique papers, so the main paper type fits well.

| Paper type | Fit | Why |
|--------------------------------------------|----------|------------------------------------------------|
| Critique with a closed-form bias, simulation, fix, and application | good | The Research Article structure (data challenge, methodology, application with simulation) matches it [11], and the journal published a paper on the bias of a common genomics practice and its correction (Wang et al. 2026). |
| Simulation and diagnostic, no closed form | possible | Comparison and review papers driven by simulation appear, but most papers found pair a method with real data. |
| Constructive method with theory, simulation, comparison, and application | good | The aims name "innovations of statistical methodology motivated by current and important real-world examples" [12], and the Research Article structure (data challenge, methodology, application with simulation) fits a new method [11]. |
| Short methods note | good | The Application Note, at most 15 pages, is a short format in which simulation studies are expected [11]. |
| Theory paper | poor | "Purely theoretical papers are avoided" [12]. |
| Applied analysis | possible | "Routine applications of standard statistical methods to some data are not suitable as an Application Note", and a Research Article needs a Methodology section [11], so an analysis needs a methods angle. |

## Article types that fit

| Article type | Length | Figures and tables | References | Source |
|-------------------|--------------------------|---------------------|-------------|--------|
| Research Article | at most 20 pages | none recorded | none recorded | [11] |
| Application Note (General Application, or Software paper) | at most 15 pages | none recorded | none recorded | [11] |
| Review Article | 20 pages | none recorded | none recorded | [11] |

## Abstract

- Structured: no; Research Articles and Application Notes each take "an unstructured abstract of 200 words" [11].
- Headings: none [11].
- Word limit: 200 words, followed by three to six key words [11].

## Reference style

- The journal's stated style: any consistent style at submission. Submission is format-free, references may be in any consistent style, and Taylor & Francis applies the journal style after acceptance [11]. The about page instead says "All papers must be prepared using the Journal's templates." [12] See Contradictions below. (The ASA author-year style guide does not cover this journal, which is not an ASA journal.)
- CSL file: no file for this journal in the official styles repository (github.com/citation-style-language/styles, commit d2cc420, 2026-10-24). The site accepts any consistent style at submission and applies the Taylor & Francis style after acceptance.
- File to use in Quarto: none needed. Render without a `csl:` field (pandoc's default, Chicago author-date) or with any style in `csl/`; the journal restyles references after acceptance.
- Rendering test: not applicable.

## Supplement, code, and data

- Supplementary material: "Defer lengthy mathematical proofs to supplemental material whenever applicable." Software papers need a detailed manual as a supplement [11].
- Data availability statement: required if a data set is associated with the paper; depositing the data is optional [11]. Taylor & Francis assigns each journal one of five data sharing tiers (Basic, Share upon reasonable request, Publicly available, Open data, and Open and FAIR) [8].
- Code: not stated on the site (instructions page [11]).

## AI-use policy

> "Declaration of generative AI use. Please include a statement disclosing whether and how generative AI has been used in the research and manuscript preparation process." [11]

> "You must not list AI tools as a co-author of your article." "Please add a Declaration of generative AI use statement disclosing whether and how generative AI has been used." [1]
>
> "Taylor & Francis does not allow generative AI to create a first draft of a manuscript or sections of a manuscript." [2]

The first quotation is a checklist item on the Journal of Applied Statistics instructions page [11]; the others are publisher-wide policies: the authorship page says its instructions "apply to all Taylor & Francis Group journals" [1], and the images page says the same [3]. Paraphrase of the rest: AI may improve spelling, grammar, and flow, but "cannot be used to create or conclude the argument of an article" [2]; AI may generate software code if the author reviews and verifies it [2]; the statement must give the tool's name and version, how and why it was used, and confirm that the authors take full responsibility for the content, including the accuracy of references [1, 2]; AI use in research methods must also be detailed in the methods section [2]; AI must not be used to create or manipulate images and figures from research data, AI help with data visualisations is allowed, and any AI-generated image needs a statement in its figure legend [3]. The AI Policy page adds that "some journals may not allow use of Generative AI tools beyond language improvement" [4]; the journal's instructions carry the same declaration item as the other Taylor & Francis statistics journals, and no stricter rule was recorded from them [11]. Reviewers and editors must not upload unpublished manuscripts to AI tools [4].

- Read at: https://www.tandfonline.com/action/authorSubmission?show=instructions&journalCode=cjas20, https://authorservices.taylorandfrancis.com/editorial-policies/defining-authorship-research-paper/, and https://authorservices.taylorandfrancis.com/editorial-policies/using-ai-in-your-research-and-manuscript-preparations/, 2026-10-27.
- What the manuscript must do: carry a "Declaration of generative AI use" statement naming each tool and version, saying how and why it was used and that the authors take full responsibility, repeat any methodological AI use in the Methods, and contain no AI-drafted text; neither the checklist item [11] nor the publisher pages say where in the manuscript the statement goes.

## Open access and charges

- Model: hybrid. The instructions and the Cost Finder place the journal in Open Select [6], [11], Taylor & Francis's option "often referred to as "hybrid open access"" [5].
- Article processing charge: none unless the authors choose open access. "There are no submission fees, publication fees or page charges for this journal." [11] The open access charge is USD 3,940 for "Research Article", with the country set to United States; read 2026-10-27 [6].
- Waivers and institutional agreements: "You may be eligible for a reduced or fully-waivered APC if your institution has an agreement with Taylor & Francis." [5]

## Review

- Model: single anonymized. Papers are "single anonymous peer reviewed by two independent, anonymous expert referees, each delivering at least one report" [11].
- Time to decision: 9 days on average from submission to first decision; 101 days on average to the first post-review decision; 21 days on average from acceptance to online publication; acceptance rate 14% [12].

## Recent papers like ours

1. Wang D, Qian Y, Ding Q, Greenberg M, Long Q (2026). The bias of using cross-validation in genomic predictions and its correction. *Journal of Applied Statistics*. https://doi.org/10.1080/02664763.2026.2646570. A bias in a widely used genomics practice, plus a correction, which is our main paper type.
2. Yan H, Lu S, Zhang S (2023). The cluster D-trace loss for differential network analysis. *Journal of Applied Statistics*, 51(10), 1843 to 1860. https://doi.org/10.1080/02664763.2023.2245178. Differential network analysis between groups, close to our co-expression network comparisons.
3. Bi R, Liu P (2021). A semi-parametric Bayesian approach for detection of gene expression heterosis with RNA-seq data. *Journal of Applied Statistics*, 50(1), 214 to 230. https://doi.org/10.1080/02664763.2021.2004581. An RNA-seq gene expression method with real data, showing the journal takes our data type.

## Not stated on the site, or could not be read

- Separate limits on figures, tables, and references: none recorded from the instructions page [11].
- Code policy: not stated on the site (instructions page [11]).
- Which Taylor & Francis data sharing tier applies: not recorded from the instructions page [11].
- Where the Declaration of generative AI use goes in the manuscript: not stated in the checklist item [11].
- No society page and no reachable guide-for-authors PDF on a Taylor & Francis domain was found for this journal.

### Contradictions

- Manuscript format: the instructions say submission is format-free, with references in any consistent style [11]; the about page says "All papers must be prepared using the Journal's templates." [12]

## Table row

```
scope_5_words: statistics motivated by real-world examples
audience: both
fit_critique: good
fit_sim_diagnostic: possible
fit_constructive: good
fit_short_note: good
fit_theory: poor
fit_applied: possible
abstract_format: unstructured
abstract_words: 200
length_limit: Research Article: 20 pages
apc: none required (open access USD 3,940)
oa_model: hybrid
ai_policy_3_words: disclose, no drafting
review_model: single
guidelines_read: yes
```
