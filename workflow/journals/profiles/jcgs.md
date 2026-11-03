# Journal of Computational and Graphical Statistics

| Field | Value |
|-----------------|--------------------------------------------------------------|
| Publisher | Taylor & Francis (Informa UK); American Statistical Association, jointly with the Institute of Mathematical Statistics [2] |
| Online ISSN | 1537-2715 (print 1061-8600) [12] |
| Profile written | 2026-10-27 |

## Sources

Every page below was read on the date shown. Bracketed numbers in the text point here.

1. [ASA Publications: Journals](https://www.amstat.org/publications/journals), read 2026-10-27.
2. [ASA Style Guide (PDF on the Taylor & Francis file server; covers JASA, TAS, JCGS, and other ASA journals; undated)](https://files.taylorandfrancis.com/asa-style-guide.pdf), read 2026-10-27.
3. [Taylor & Francis Author Services, Defining authorship in your research paper](https://authorservices.taylorandfrancis.com/editorial-policies/defining-authorship-research-paper/), read 2026-10-27.
4. [Taylor & Francis Author Services, Using AI in your research and manuscript preparations](https://authorservices.taylorandfrancis.com/editorial-policies/using-ai-in-your-research-and-manuscript-preparations/), read 2026-10-27.
5. [Taylor & Francis Author Services, Images and figures](https://authorservices.taylorandfrancis.com/editorial-policies/images-and-figures/), read 2026-10-27.
6. [Taylor & Francis, AI Policy](https://taylorandfrancis.com/our-policies/ai-policy/), read 2026-10-27.
7. [Taylor & Francis Author Services, Publishing open access with Open Select](https://authorservices.taylorandfrancis.com/choose-open/publishing-open-access/open-select/), read 2026-10-27.
8. [Taylor & Francis Author Services, Open Access Cost Finder](https://authorservices.taylorandfrancis.com/choose-open/publishing-open-access/open-access-cost-finder/), read 2026-10-27 through Claude in Chrome (paged list under "Calculate your article publishing charge", country set to United States).
9. [Taylor & Francis Author Services, Understanding peer review](https://authorservices.taylorandfrancis.com/publishing-your-research/peer-review/), read 2026-10-27.
10. [Taylor & Francis Author Services, Data sharing policies](https://authorservices.taylorandfrancis.com/data-sharing-policies/), read 2026-10-27.
11. [JCGS ScholarOne Manuscripts login page](https://mc.manuscriptcentral.com/jcgs), read 2026-10-27.
12. [Crossref journal record for ISSN 1537-2715](https://api.crossref.org/journals/1537-2715), read 2026-10-27.
13. Crossref work records at `https://api.crossref.org/works/<DOI>` for each paper under "Recent papers like ours", read 2026-10-27.
14. [JCGS Instructions for authors](https://www.tandfonline.com/action/authorSubmission?show=instructions&journalCode=ucgs20), read 2026-10-27 through Claude in Chrome.
15. [JCGS About this journal (aims, journal metrics)](https://www.tandfonline.com/journals/ucgs20/about-this-journal), read 2026-10-27 through Claude in Chrome.

## Scope

> "The purpose of the Journal of Computational and Graphical Statistics (JCGS) is to improve and extend the use of computational and visualization methods in statistics and data analysis." [14]

> "Articles are written for readers who have a strong background in statistics but are not necessarily experts in computing." [15]

In plain terms, JCGS publishes new computational methods, algorithms, simulation design, and statistical graphics, read by statisticians who need not be computing experts [15]. Theory is welcome when it serves computation: "Articles of a theoretical nature are appropriate, provided that the results are relevant to computational statistics or data visualization" [14]. The ASA lists JCGS among its journals [1] and its style guide covers it [2]. Recent papers include a primer on designing simulation studies and several new permutation tests, so our simulation-and-diagnostic papers, especially ones that ship an R package and diagnostic plots, are the natural fit; a pure closed-form critique fits less well unless the fix is computational.

| Paper type | Fit | Why |
|--------------------------------------------|----------|------------------------------------------------|
| Critique with a closed-form bias, simulation, fix, and application | possible | Fits when the fix or diagnostic is a computational tool, as in the permutation-test papers found (Gómez et al. 2025). |
| Simulation and diagnostic, no closed form | good | The journal publishes simulation design work (Elliott et al. 2025) and computational tests evaluated by simulation. |
| Constructive method with theory, simulation, comparison, and application | possible | Fits when the new procedure is computational, like the new permutation and distance-correlation tests found (Gómez et al. 2025, Shen et al. 2021); a procedure whose novelty is statistical rather than computational is at the edge of the stated purpose [14]. |
| Short methods note | good | Short Technical Notes are one of the journal's two article types [14], so a short computational note has its own format. |
| Theory paper | possible | Theoretical articles are appropriate when "the results are relevant to computational statistics or data visualization" [14], though pure theory without that link is not. |
| Applied analysis | poor | No applied-analysis papers were found; applications appear only as illustrations of methods. |

## Article types that fit

| Article type | Length | Figures and tables | References | Source |
|-------------------|--------------------------|---------------------|-------------|--------|
| Article | the average paper "should be about 8,000 words, or the equivalent of approximately 35 double-spaced pages", including all appendices, references, tables, and figures | count toward the length | count toward the length | [14] |
| Short Technical Note | not recorded from the instructions page | not recorded | not recorded | [14] |

Formatting that is stated: submissions must be 12 point and fully double spaced, "which we define as 26 lines of text per page", and appendices of more than two paragraphs go into online supplements [2].

## Abstract

- Structured: no; the ASA style guide asks the abstract to "summarize results, topics discussed, and main conclusions" with no displays, no complex mathematical notation, and no references, and names no headings [2].
- Headings: none.
- Word limit: 200 words, per the ASA style guide, which covers JCGS [2]. The instructions page states no word limit or structure; it asks only that "The manuscript should contain an abstract and from three to 6 key words" [14]. The style guide says three to five key words (see Contradictions below) [2].

## Reference style

- The journal's stated style: ASA author-year style. The instructions say "Please use this ASA style guide", encourage BibTeX with the .bbl file submitted, and supply a LaTeX template as a zip file [14]. In the style guide, in-text citations give the author's surname and date ("Efron (2020)", or "(Lee 2008; Ludwig and Miller 2007)"); "et al." for three or more authors; the reference list is alphabetized, gives all authors (more than six may be cut to six plus "et al."), puts the year in parentheses followed by a comma, the article title in double quotation marks, the journal name spelled out in italics, volume, pages, and a DOI if available [2].
- CSL file: `dependent/journal-of-computational-and-graphical-statistics.csl` in the official styles repository (github.com/citation-style-language/styles, commit d2cc420, 2026-10-24), a dependent style whose parent is `american-statistical-association.csl`.
- File to use in Quarto: `csl/american-statistical-association.csl`, which renders offline. The journal-named `csl/dependent/journal-of-computational-and-graphical-statistics.csl` gives the same output but needs a network connection, because pandoc fetches the parent at render time.
- Rendering test: both files passed on 2026-10-27 (`csl/test-results.md`).

## Supplement, code, and data

- Supplementary material: supplements are subject to editorial review [14]. The style guide adds that appendices longer than two paragraphs must be online supplements, cited as "the online Appendix" or "online Appendix A"; the ASA "prefers that code and data are submitted as supplemental material" [2].
- Data availability statement: not recorded from the instructions page [14]. Taylor & Francis assigns each journal a data sharing tier stated in its Instructions for Authors [10].
- Code: expected with the manuscript. "Authors are expected to submit code and datasets as online supplements to the manuscript. Exceptions for reasons of security or confidentiality may be granted by the Editor." [14] The supplements are subject to editorial review [14]. Whether a public repository is required, and whether there is a reproducibility review beyond this editorial review, was not recorded from the instructions page [14].

## AI-use policy

> "Declaration of generative AI use. Please include a statement disclosing whether and how generative AI has been used in the research and manuscript preparation process." [14]

> "You must not list AI tools as a co-author of your article." "Please add a Declaration of generative AI use statement disclosing whether and how generative AI has been used." [3]
>
> "Taylor & Francis does not allow generative AI to create a first draft of a manuscript or sections of a manuscript." [4]

The first quotation is a checklist item on the JCGS instructions page [14]; the others are publisher-wide policies: the authorship page says its instructions "apply to all Taylor & Francis Group journals" [3], and the images page says the same [5]. Paraphrase of the rest: AI may improve spelling, grammar, and flow, but "cannot be used to create or conclude the argument of an article" [4]; AI may generate software code if the author reviews and verifies it [4]; the statement must give the tool's name and version, how and why it was used, and confirm that the authors take full responsibility for the content, including the accuracy of references [3, 4]; AI use in research methods must also be detailed in the methods section [4]; AI must not be used to create or manipulate images and figures from research data, AI help with data visualisations is allowed, and any AI-generated image needs a statement in its figure legend [5]. Reviewers and editors must not upload unpublished manuscripts to AI tools [6].

- Read at: https://www.tandfonline.com/action/authorSubmission?show=instructions&journalCode=ucgs20, https://authorservices.taylorandfrancis.com/editorial-policies/defining-authorship-research-paper/, and https://authorservices.taylorandfrancis.com/editorial-policies/using-ai-in-your-research-and-manuscript-preparations/, 2026-10-27.
- What the manuscript must do: carry a "Declaration of generative AI use" statement naming each tool and version, saying how and why it was used and that the authors take full responsibility, repeat any methodological AI use in the Methods, and contain no AI-drafted text; neither the checklist item [14] nor the publisher pages say where in the manuscript the statement goes.

## Open access and charges

- Model: hybrid. The instructions offer optional open access through Open Select [14], and the Cost Finder lists JCGS under Open Select (hybrid) [8]. The ASA style guide says JCGS is copyrighted by the ASA and "Authors are able to retain copyright and make articles Open Access through payment of the Article Processing Charge (APC)" [2]; Taylor & Francis calls this option Open Select, "often referred to as "hybrid open access"" [7].
- Article processing charge: none unless the authors choose open access. "There are no submission fees, publication fees or page charges for this journal." Colour in print costs $400 per figure [14]. The open access charge is USD 3,940 for "Original Article", with the country set to United States; read 2026-10-27 [8].
- Waivers and institutional agreements: "You may be eligible for a reduced or fully-waivered APC if your institution has an agreement with Taylor & Francis." [7]

## Review

- Model: single anonymized, with double anonymized on request. "JCGS is now reviewed using a single-anonymous system, with an author option for double-anonymous review." A PDF is submitted at initial submission [14].
- Time to decision: 15 days on average from submission to first decision; 116 days on average to the first post-review decision; 80 days on average from acceptance to online publication; acceptance rate 15% [15].

Practical note: the ScholarOne page says all new JCGS submissions go through Taylor & Francis's new Submission Portal, and ScholarOne is kept only for revisions of submissions started there [11].

## Recent papers like ours

1. Gómez JÁS, Zhang E, Liu Y (2025). Effective Permutation Tests for Differences Across Multiple High-Dimensional Correlation Matrices. *Journal of Computational and Graphical Statistics*, 35(2), 528 to 537. https://doi.org/10.1080/10618600.2025.2550527. Permutation testing of differences in correlation structure across groups, which is what co-expression comparisons do. (Crossref splits the first author's name as given name "José Á. Sánchez", family name "Gómez".)
2. Elliott CF, Duncan JPC, Tang TM, Behr M, Kumbier K, Yu B (2025). Designing a Data Science Simulation with MERITS: A Primer. *Journal of Computational and Graphical Statistics*, 35(2), 704 to 719. https://doi.org/10.1080/10618600.2025.2561905. A framework for designing simulation studies, the same concern as our ADEMP-designed simulations. (The title's "MERITS" is set in script letters in the Crossref record.)
3. Shen C, Panda S, Vogelstein JT (2021). The Chi-Square Test of Distance Correlation. *Journal of Computational and Graphical Statistics*, 31(1), 254 to 262. https://doi.org/10.1080/10618600.2021.1938585. A distance-based dependence test with a chi-square reference distribution, close to the distance-based tests, such as PERMANOVA, that we studies.

## Not stated on the site, or could not be read

- Length and format of Short Technical Notes: not recorded from the instructions page [14].
- Separate limits on figures, tables, and references: none recorded; they count toward the article length [14].
- Abstract word limit: not stated on the instructions page [14]; the 200 words above come from the ASA style guide [2].
- Data availability statement and Taylor & Francis data sharing tier: not recorded from the instructions page [14].
- When code is due (initial submission, revision, or acceptance) and whether a public repository is required: not stated in the code rule on the instructions page [14].
- Where the Declaration of generative AI use goes in the manuscript: not stated in the checklist item [14].
- The IMS journal page (https://imstat.org/journals-and-publications/journal-of-computational-and-graphical-statistics/) returned a bot check and was not passed.
- The ASA Q&A with a former JCGS editor (https://www.amstat.org/ASA/Publications/Q-and-As/Dianne-Cook.aspx) now returns 404.

### Contradictions

- Number of key words: the instructions ask for "from three to 6 key words" [14]; the ASA style guide says three to five [2].

## Table row

```
scope_5_words: computational and graphical statistical methods
audience: methodologists
fit_critique: possible
fit_sim_diagnostic: good
fit_constructive: possible
fit_short_note: good
fit_theory: possible
fit_applied: poor
abstract_format: unstructured
abstract_words: 200
length_limit: Article: about 8,000 words (35 pages)
apc: none required (open access USD 3,940)
oa_model: hybrid
ai_policy_3_words: disclose, no drafting
review_model: single
guidelines_read: yes
```
