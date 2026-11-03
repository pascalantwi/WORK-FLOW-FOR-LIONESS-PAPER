# Journal of Statistical Computation and Simulation

| Field | Value |
|-----------------|--------------------------------------------------------------|
| Publisher | Taylor & Francis (Informa UK); no society named on the pages read [9] |
| Online ISSN | 1563-5163 (print 0094-9655) [9] |
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
9. [Crossref journal record for ISSN 1563-5163](https://api.crossref.org/journals/1563-5163), read 2026-10-27.
10. Crossref work records at `https://api.crossref.org/works/<DOI>` for each paper under "Recent papers like ours", read 2026-10-27.
11. [JSCS About this journal (aims, review, journal metrics)](https://www.tandfonline.com/journals/gscs20/about-this-journal), read 2026-10-27 through Claude in Chrome.
12. [JSCS Instructions for authors](https://www.tandfonline.com/action/authorSubmission?show=instructions&journalCode=gscs20), read 2026-10-27 through Claude in Chrome.

## Scope

> "The Journal of Statistical Computation and Simulation (JSCS) is a leading subscription-based peer-reviewed journal covering significant contributions or novelty approaches involving Computation or Simulation." [11]

Two exclusions matter: "JSCS does not consider the analysis of specific data sets, except as examples." "JSCS does not consider new distributions or extensions of existing distributions." [11] In plain terms, the journal publishes computational statistics and simulation work, including simulation studies that compare or check the error rates of standard tests and new permutation procedures; the readers are methodologists. That makes it a reasonable home for our simulation-and-diagnostic papers and for critiques whose evidence is mostly simulation, and a weaker one for theory or applied analyses.

| Paper type | Fit | Why |
|--------------------------------------------|----------|------------------------------------------------|
| Critique with a closed-form bias, simulation, fix, and application | possible | Methods papers with simulation and a fix appear, though the papers found are less often genomics critiques. |
| Simulation and diagnostic, no closed form | good | The journal covers contributions "involving Computation or Simulation" [11] and publishes simulation studies that settle questions about the error rates of standard tests (Consiglio 2026). |
| Constructive method with theory, simulation, comparison, and application | good | New procedures evaluated by simulation are in scope [11], as with a new test for differential networks (Zhang et al. 2023), though the theory carries less weight than the computation. |
| Short methods note | possible | Article is the only research type, with a typical maximum of 10,000 words and no short format [12], though some papers are short (Consiglio 2026, 12 pages). |
| Theory paper | poor | The papers found are computational, not theoretical. |
| Applied analysis | poor | The journal "does not consider the analysis of specific data sets, except as examples" [11]. |

## Article types that fit

| Article type | Length | Figures and tables | References | Source |
|-------------------|--------------------------|---------------------|-------------|--------|
| Article | a typical paper at most 10,000 words, inclusive of the abstract, tables, references, figure or table captions, footnotes, and endnotes; a word count must be included | count toward the word count | count toward the word count | [12] |

The other listed types are Book Review, Editorial, Obituary, and Erratum; tutorials are by invitation [12].

## Abstract

- Structured: not stated on the site; the instructions page gives no structure [12].
- Headings: none stated [12]. Just before the abstract, authors state in braces the primary technique and area, for example "{Simulation is used to demonstrate a significant improvement in Quality Control.}" [11]
- Word limit: not stated on the site (instructions page [12]).

## Reference style

- The journal's stated style: any consistent style at submission. "References can be in any style or format, so long as a consistent scholarly citation format is applied." LaTeX submissions need a .bib file, and "The journal reference style will be applied to the paper post-acceptance by Taylor & Francis." [12] (The ASA author-year style guide does not cover this journal, which is not an ASA journal.)
- CSL file: `dependent/journal-of-statistical-computation-and-simulation.csl` in the official styles repository (github.com/citation-style-language/styles, commit d2cc420, 2026-10-24), a dependent style whose parent is `taylor-and-francis-national-library-of-medicine.csl`. The site accepts any consistent style at submission and applies the journal's style after acceptance, so this file matters only for a draft that should look like the published journal.
- File to use in Quarto: `csl/taylor-and-francis-national-library-of-medicine.csl`, which renders offline. The journal-named `csl/dependent/journal-of-statistical-computation-and-simulation.csl` gives the same output but needs a network connection, because pandoc fetches the parent at render time.
- Rendering test: both files passed on 2026-10-27 (`csl/test-results.md`).

## Supplement, code, and data

- Supplementary material: not recorded from the instructions page [12].
- Data availability statement: required "If there is a data set associated with the paper"; the journal follows the Taylor & Francis Basic Data Sharing Policy, under which data sharing is encouraged [12]. Basic is the first of Taylor & Francis's five data sharing tiers (Basic, Share upon reasonable request, Publicly available, Open data, and Open and FAIR) [8].
- Code: not stated on the site (instructions page [12]).

## AI-use policy

> "Declaration of generative AI use. Please include a statement disclosing whether and how generative AI has been used in the research and manuscript preparation process." [12]

> "You must not list AI tools as a co-author of your article." "Please add a Declaration of generative AI use statement disclosing whether and how generative AI has been used." [1]
>
> "Taylor & Francis does not allow generative AI to create a first draft of a manuscript or sections of a manuscript." [2]

The first quotation is a checklist item on the JSCS instructions page [12]; the others are publisher-wide policies: the authorship page says its instructions "apply to all Taylor & Francis Group journals" [1], and the images page says the same [3]. Paraphrase of the rest: AI may improve spelling, grammar, and flow, but "cannot be used to create or conclude the argument of an article" [2]; AI may generate software code if the author reviews and verifies it [2]; the statement must give the tool's name and version, how and why it was used, and confirm that the authors take full responsibility for the content, including the accuracy of references [1, 2]; AI use in research methods must also be detailed in the methods section [2]; AI must not be used to create or manipulate images and figures from research data, AI help with data visualisations is allowed, and any AI-generated image needs a statement in its figure legend [3]. The AI Policy page adds that "some journals may not allow use of Generative AI tools beyond language improvement" [4]; the journal's instructions carry the same declaration item as the other Taylor & Francis statistics journals, and no stricter rule was recorded from them [12]. Reviewers and editors must not upload unpublished manuscripts to AI tools [4].

- Read at: https://www.tandfonline.com/action/authorSubmission?show=instructions&journalCode=gscs20, https://authorservices.taylorandfrancis.com/editorial-policies/defining-authorship-research-paper/, and https://authorservices.taylorandfrancis.com/editorial-policies/using-ai-in-your-research-and-manuscript-preparations/, 2026-10-27.
- What the manuscript must do: carry a "Declaration of generative AI use" statement naming each tool and version, saying how and why it was used and that the authors take full responsibility, repeat any methodological AI use in the Methods, and contain no AI-drafted text; neither the checklist item [12] nor the publisher pages say where in the manuscript the statement goes.

## Open access and charges

- Model: hybrid. The about page calls JSCS "subscription-based" [11], and the instructions and the Cost Finder place it in Open Select [6], [12], Taylor & Francis's option "often referred to as "hybrid open access"" [5].
- Article processing charge: none unless the authors choose open access. "There are no submission fees, publication fees or page charges for this journal." [12] The open access charge is USD 3,565 for "Research Article", with the country set to United States; read 2026-10-27 [6].
- Waivers and institutional agreements: "You may be eligible for a reduced or fully-waivered APC if your institution has an agreement with Taylor & Francis." [5]

## Review

- Model: the two journal pages disagree. The instructions say papers are "single anonymous peer reviewed by two independent, anonymous expert" referees [12]; the about page says "All peer-review is double anonymized" [11]. Submission is through the Taylor & Francis Submission Portal [11].
- Time to decision: 3 days on average from submission to first decision; 80 days on average to the first post-review decision; 14 days on average from acceptance to online publication; acceptance rate 15% [11].

## Recent papers like ours

1. Consiglio JD (2026). A simulation study to resolve conflicting evidence on the error rates from MANOVA group tests. *Journal of Statistical Computation and Simulation*. https://doi.org/10.1080/00949655.2026.2706589. A simulation-only study of whether standard multivariate group tests keep their error rates, our simulation-and-diagnostic paper type.
2. ter Braak CJF (2021). Predictor versus response permutation for significance testing in weighted regression and redundancy analysis. *Journal of Statistical Computation and Simulation*, 92(10), 2041 to 2059. https://doi.org/10.1080/00949655.2021.2019256. Compares permutation schemes for a multivariate method whose significance is judged by permutation, as PERMANOVA's is, matching our permutation-test line.
3. Zhang Y, Liu Y, Feng L, Wang Z (2023). Testing the differential network between two gaussian graphical models with false discovery rate control. *Journal of Statistical Computation and Simulation*, 94(2), 424 to 445. https://doi.org/10.1080/00949655.2023.2252127. Testing for differences between two groups' networks, close to our comparison of co-expression networks between groups.

## Not stated on the site, or could not be read

- Abstract structure and word limit: not stated on the site (instructions page [12]); only the braces note before the abstract is asked for [11].
- Separate limits on figures, tables, and references: none recorded; they count toward the 10,000 words [12].
- Supplementary material rules: not recorded from the instructions page [12].
- Code policy: not stated on the site (instructions page [12]).
- Where the Declaration of generative AI use goes in the manuscript: not stated in the checklist item [12].
- No society page and no reachable guide-for-authors PDF on a Taylor & Francis domain was found for this journal.

### Contradictions

- Review model: the instructions say "single anonymous peer reviewed" [12]; the about page says "All peer-review is double anonymized" [11].

## Table row

```
scope_5_words: novel computation or simulation contributions
audience: methodologists
fit_critique: possible
fit_sim_diagnostic: good
fit_constructive: good
fit_short_note: possible
fit_theory: poor
fit_applied: poor
abstract_format: not stated
abstract_words: not stated
length_limit: Article: 10,000 words
apc: none required (open access USD 3,565)
oa_model: hybrid
ai_policy_3_words: disclose, no drafting
review_model: single
guidelines_read: yes
```
