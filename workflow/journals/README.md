# Journal guide

This folder helps choose where a paper goes, and then tells the manuscript template what that journal wants. Choosing a journal is a matching problem. A paper has one main contribution and one group of readers who must see it. A journal has a readership, a length, a format, a price, and rules about code and AI. This guide puts those facts side by side for 37 journals, gives a procedure for choosing among them, and gives a one-page worksheet whose last three lines go into section 6 of the project spec: a target journal, a fallback, and the target's word limit and AI policy.

Once the target is chosen, the manuscript draft takes four things from the journal's profile: the abstract headings and word limit, the length limit, the reference style (through the CSL file in `csl/`), and the AI-use policy, which the manuscript's AI-use statement is written to.

Every journal is profiled on the same footing.

## What is in this folder

| File | What it is |
|------------------------|--------------------------------------------------------------------------|
| `README.md` | This guide: the summary table, the choosing procedure, the worksheet, and the open questions |
| `journals.csv` | One row per journal with the summary table's fields, the CSL file, and the profile path, for other tools to read |
| `profiles/<slug>.md` | One profile per journal: scope, article types and limits, abstract, reference style, code and data rules, AI policy, charges, review model, and two or three recent papers like ours, each fact with its source URL and the date it was read |
| `profile-template.md` | The blank profile, for adding a journal |
| `build-table.R` | Rebuilds `journals.csv` and `summary-table.md` from the profiles' "Table row" blocks |
| `summary-table.md` | The table below, as `build-table.R` writes it |
| `csl/` | The citation style files: independent styles at the top level, the journal-named dependent styles in `csl/dependent/`, a test document, the test script, and its results |

## Summary table

How to read it:

- **Audience** is who reads the journal: *genomics users* (people who run the procedures on their data), *methodologists* (statisticians who build and evaluate methods), *both*, or *general science* (broad journals that publish any sound paper).
- **The six fit columns** are the paper types: *critique* (a closed-form bias, a simulation study, a fix, and a real-data application), *simulation and diagnostic* (the same shape without a closed form), *constructive method* (a new procedure for a stated estimand, its properties shown by theory and simulation, a comparison with the existing methods for that estimand, and a real-data application), *short note*, *theory*, and *applied* analysis. Each is rated good, possible, or poor. The ratings are judgments made from the journal's stated aims and from the papers it publishes, not facts from the site; each profile gives the reason in one sentence.
- **Charge to publish** is the article processing charge as the site stated it on 2026-10-27. "None required" means a hybrid or subscription journal that charges only if the authors choose open access; the open-access fee follows in brackets.
- **AI policy** is a three-word summary. "No drafting" means the journal or its publisher forbids using AI to draft the paper's text, which matters for this workflow (step 7 of the procedure).
- **Guidelines read** says whether the journal's own author guidelines could be read: *yes*, *partly*, or *blocked*. For a blocked journal, most limits and rules are marked "could not be read" in its profile, and the fit ratings rest more on its published papers.

Rows are grouped by audience so that step 1 of the procedure reads straight off the table.

<!-- summary table: start (paste summary-table.md here after running build-table.R) -->
| Journal | Scope in five words | Audience | Critique | Simulation and diagnostic | Constructive method | Short note | Theory | Applied | Abstract | Length | Charge to publish | AI policy | Guidelines read |
|--------------|----------|-------|-----|-----|-----|-----|-----|-----|--------------|-------------|----------|-------|-----|
| [Bioinformatics](profiles/bioinformatics.md) | new computational biology methods software | genomics users | good | possible | good | possible | poor | poor | not stated | Original Paper, 7 pages (about 5,000 words) | USD 4,376 | disclose, no drafting | partly |
| [BMC Genomics](profiles/bmc-genomics.md) | genetics, genomics, transcriptomics, proteomics research | genomics users | good | possible | possible | possible | poor | good | structured: Background, Results, Conclusions; words: 350 | Research article: not stated | USD 3,190 | disclose, no authorship | yes |
| [Briefings in Bioinformatics](profiles/briefings-in-bioinformatics.md) | reviews and protocols for practitioners | genomics users | possible | possible | poor | poor | poor | poor | not stated | Problem solving protocol, 2,000 to 5,000 words | USD 4,079 | disclose, no drafting | partly |
| [GigaScience](profiles/gigascience.md) | open, reproducible big-data life science | genomics users | possible | possible | possible | possible | poor | possible | structured: Background, Results, Conclusions; words: 250 | Research, not stated; Brief Communication, 1,500 words | USD 2,895 | disclose, summarize, deposit | partly |
| [NAR Genomics and Bioinformatics](profiles/nar-genomics-and-bioinformatics.md) | large-scale genomics data analysis methods | genomics users | good | possible | possible | good | poor | possible | not stated | Application Note, 3,000 words; Standard Paper not stated | USD 3,035 | disclose, no authorship | partly |
| [Bioinformatics Advances](profiles/bioinformatics-advances.md) | open access computational biology methods | both | good | good | good | possible | poor | possible | not stated; words: 200 | Original Article, 8 pages, 6 figures, 6 tables, 50 references | USD 3,048 | disclose, no drafting | partly |
| [BMC Bioinformatics](profiles/bmc-bioinformatics.md) | computational methods for biological data | both | good | good | good | possible | possible | possible | structured: Background, Results, Conclusions; words: 350 | Research article: not stated | USD 3,090 | disclose, no authorship | yes |
| [Cell Reports Methods](profiles/cell-reports-methods.md) | methods that advance biological research | both | good | good | possible | possible | poor | poor | unstructured; words: 150 | Article or Resource: under 7,000 words, 7 figures and tables | USD 4,970 | declare after interests | yes |
| [Frontiers in Genetics](profiles/frontiers-in-genetics.md) | genetics and genomics, sectioned | both | good | good | good | good | possible | possible | not stated (single paragraph; IMRAD structure suggested) | Original Research, 12,000 words | CHF 3,150 (Brief Research Report CHF 2,500) | disclose in Acknowledgments | partly |
| [Genome Biology](profiles/genome-biology.md) | biology from a genomic perspective | both | good | possible | possible | possible | poor | poor | structured (Research): Background, Results, Conclusions; unstructured (Methodology, Brief Report); words: 250 (Research), 100 (Methodology, Brief Report) | Brief Report: about 1,000 to 1,500 words; Research and Methodology: not stated | USD 5,690 (Brief Report USD 4,280) | disclose, no authorship | yes |
| [Journal of Applied Statistics](profiles/journal-of-applied-statistics.md) | statistics motivated by real-world examples | both | good | possible | good | good | poor | possible | unstructured; words: 200 | Research Article: 20 pages | none required (open access USD 3,940) | disclose, no drafting | yes |
| [Journal of Computational Biology](profiles/journal-of-computational-biology.md) | computational biology and bioinformatics methods | both | good | possible | good | possible | possible | poor | structured: headings not stated; words: 250 | research article, 3,000 words (longer accepted) | USD 90 per page (open access USD 4,440) | disclose generative use | yes |
| [Journal of the American Statistical Association, Applications and Case Studies section](profiles/jasa-applications-and-case-studies.md) | statistical usage in real applications | both | good | possible | possible | possible | poor | good | unstructured; words: 200 | ACS article: 35 pages; Short Communication: 25 pages | none required (open access USD 4,320) | disclose, no drafting | yes |
| [npj Systems Biology and Applications](profiles/npj-systems-biology-and-applications.md) | computational modeling of biological systems | both | good | possible | possible | possible | possible | possible | unstructured; words: 150 | Article: not stated; Brief Communication: 1,000 to 1,500 words | USD 3,490 (Brief Communication USD 1,470) | disclose, no authorship | yes |
| [PLOS Computational Biology](profiles/plos-computational-biology.md) | computation advancing understanding of biology | both | possible | possible | possible | poor | poor | poor | unstructured; words: 300 | Research Article, no limit | USD 3,165 | disclose, no authorship | yes |
| [Statistical Applications in Genetics and Molecular Biology](profiles/sagmb.md) | statistical methods for omics data | both | good | good | good | possible | possible | possible | unstructured (no headings stated); words: 200 | not stated (software notes 4 typeset pages) | none required (open access EUR 2,700) | declare in template | yes |
| [Statistics in Biosciences](profiles/statistics-in-biosciences.md) | statistical methods and practice, biosciences | both | good | good | good | possible | poor | possible | unstructured; words: 150 to 250 | not stated | none required (open access USD 3,190) | disclose in methods | yes |
| [iScience](profiles/iscience.md) | broad interdisciplinary open access science | general science | good | possible | possible | poor | poor | possible | unstructured; words: 150 | Research Article: below 8,000 words advised | USD 3,240 | declare after interests | partly |
| [PeerJ](profiles/peerj.md) | soundness-only life and environment | general science | good | good | possible | possible | poor | possible | structured: Background, Methods, Results, Conclusions (headings not named on site); words: 500 | Research Article, not stated (surcharge over 35 typeset pages) | USD 2,155 | disclose in Methods | yes |
| [PLOS ONE](profiles/plos-one.md) | soundness-only broad science journal | general science | good | good | possible | possible | possible | good | unstructured; words: 300 | Research Article, no limit | USD 2,477 | disclose, no authorship | yes |
| [Scientific Reports](profiles/scientific-reports.md) | sound research across all sciences | general science | possible | possible | possible | good | poor | good | unstructured; words: 200 | Article: 4,500 words main text (recommended) | USD 2,850 | disclose, no authorship | yes |
| [Biometrical Journal](profiles/biometrical-journal.md) | biostatistical methods for life sciences | methodologists | good | good | good | good | poor | possible | unstructured | Research Article: 4,500 words recommended | none required (open access USD 3,930) | disclose, no authorship | yes |
| [Biometrics](profiles/biometrics.md) | statistical methods for biosciences | methodologists | good | possible | good | possible | possible | poor | unstructured; words: 225 | Methodology or Practice 25 double-spaced pages excluding tables and figures | none required (open access USD 4,128) | disclose, no authorship | partly |
| [Biostatistics](profiles/biostatistics.md) | statistical methods for human health | methodologists | good | possible | good | possible | poor | poor | unstructured | research paper not stated; Note one or two journal pages | none required (open access USD 3,018 to 3,599, two OUP pages differ) | disclose, no authorship | yes |
| [BMC Medical Research Methodology](profiles/bmc-medical-research-methodology.md) | statistical methodology for healthcare research | methodologists | possible | possible | possible | possible | poor | poor | structured: Background, Methods, Results, Conclusions; words: 350 | Research article: not stated | USD 3,090 | disclose, no authorship | yes |
| [Computational Statistics and Data Analysis](profiles/computational-statistics-and-data-analysis.md) | computational statistics and data analysis | methodologists | good | good | good | possible | poor | possible | unstructured; words: 250 | Research paper: not stated | none required (open access USD 3,540) | declare before references | yes |
| [Electronic Journal of Statistics](profiles/electronic-journal-of-statistics.md) | theoretical, computational, applied statistics | methodologists | possible | poor | good | good | good | poor | unstructured | not stated | none | not stated | partly |
| [Journal of Computational and Graphical Statistics](profiles/jcgs.md) | computational and graphical statistical methods | methodologists | possible | good | possible | good | possible | poor | unstructured; words: 200 | Article: about 8,000 words (35 pages) | none required (open access USD 3,940) | disclose, no drafting | yes |
| [Journal of Statistical Computation and Simulation](profiles/jscs.md) | novel computation or simulation contributions | methodologists | possible | good | good | possible | poor | poor | not stated | Article: 10,000 words | none required (open access USD 3,565) | disclose, no drafting | yes |
| [Journal of the American Statistical Association, Theory and Methods section](profiles/jasa-theory-and-methods.md) | statistical foundations, theory, and methodology | methodologists | good | poor | good | poor | good | poor | unstructured; words: 200 | Theory and Methods article: 35 pages | none required (open access USD 4,320) | disclose, no drafting | yes |
| [Journal of the Royal Statistical Society Series C: Applied Statistics](profiles/jrss-c.md) | applied problems motivating new methods | methodologists | possible | possible | possible | possible | poor | poor | unstructured; words: 200 | contributed paper 24 journal pages | none required (open access GBP 2,945) | disclose, no authorship | partly |
| [Stat](profiles/stat.md) | rapid short papers, all statistics | methodologists | possible | possible | possible | good | good | possible | unstructured; words: 200 | article, 10 pages excluding references, figures, and tables, including appendices | none required (open access USD 3,640) | disclose, no drafting | yes |
| [Statistical Methods in Medical Research](profiles/statistical-methods-in-medical-research.md) | medical statistics methods and reviews | methodologists | good | possible | good | poor | poor | poor | unstructured; words: 200 | paper, around 8,000 words | none required (open access USD 4,710) | disclose generative use | yes |
| [Statistics and Computing](profiles/statistics-and-computing.md) | statistics and computing methods | methodologists | possible | possible | possible | poor | possible | poor | unstructured; words: 150 to 250 | not stated | none required (open access USD 2,990) | disclose in methods | yes |
| [Statistics in Medicine](profiles/statistics-in-medicine.md) | statistical methods for medical problems | methodologists | possible | possible | good | poor | poor | poor | unstructured; words: 250 | Research article: not stated | none required (open access USD 5,720) | disclose, no drafting | yes |
| [The American Statistician](profiles/the-american-statistician.md) | clear, general-interest articles for statisticians | methodologists | good | good | poor | good | poor | poor | unstructured; words: 200 | typical paper: 25 pages | none required (open access USD 3,940) | disclose, no drafting | yes |
| [The Annals of Applied Statistics](profiles/annals-of-applied-statistics.md) | applied problems driving statistical methods | methodologists | good | possible | possible | poor | poor | possible | unstructured | article, most at most 20 pages (about 500 words each) | not stated | not stated | yes |
<!-- summary table: end -->

## How to choose a target journal

Work through the steps in order. Each one removes journals, so by the end two or three remain, and the worksheet below records the choice.

### Step 1. Name the main contribution, and who must read it

Write one sentence that says what the paper changes for its reader. For a critique paper it usually has this shape: "Users of procedure X who compare groups that differ in Y get Z, and doing W removes it."

Then decide who has to read that sentence for the paper to matter.

- **The procedure's users** are analysts and bioinformaticians who run the procedure on their own data. They read genomics and bioinformatics journals, and few of them read statistics journals. If the paper's value is that people stop misreading their results, they are the audience: look first at the *genomics users* and *both* rows.
- **Methodologists** are statisticians who build or evaluate methods. They care about the estimand, the derivation, and the general lesson more than about one procedure. If the paper's value is a way of thinking about a class of procedures (for example, that every per-sample score built from a pseudo-value estimates a first-order linearization), they are the audience: look first at the *methodologists* and *both* rows.

Most critique papers are for users, because the fix is something a user has to do. A paper whose closed form covers several procedures at once is for methodologists. The *general science* journals reach neither group in particular; they are fallbacks, not targets, unless cost or certainty decides.

### Step 2. Match the paper type

Find the paper's type in the fit columns and keep the journals rated good, adding the possible ones if the list is short.

The types want different readers, so a rating for one type does not carry over to another. A critique needs readers who use the procedure, because the fix is something they have to do. A constructive method paper needs readers who evaluate methods: they judge a new procedure by its properties and by how it compares with the existing procedures for the same estimand. It usually wants methodologists. Most of its good ratings are in the *methodologists* and *both* rows, and a *genomics users* journal rated good for a critique, such as BMC Genomics or NAR Genomics and Bioinformatics, is only possible for it.

### Step 3. Check length and theorem density

Count the words the paper needs and the displayed equations it cannot do without.

- A journal with a tight limit, such as Bioinformatics (seven pages for an Original Paper) or Scientific Reports (about 4,500 words recommended), fits only if the proofs can move to the supplement and the Methods can state the closed form in a few lines. Our papers already put proofs in the supplement, so this is often possible.
- A genomics journal accepts a closed form, but its readers need each term explained in words before the formula, and the formula has to earn its place by predicting something the reader then sees in the simulation.
- A statistics journal expects the derivation in the paper, with its assumptions stated, and asks for more generality than a genomics journal. One closed form for one procedure under one model can look thin there.
- Many profiles say "not stated" for length. Those journals set no number on their site, which is not the same as no limit; look at the recent papers listed in the profile to see what length gets published.

### Step 4. Check the cost

Three cases, from the charge column. All charges were read on 2026-10-27 for a US corresponding author with no discount, and exclude sales taxes.

- **Fully open-access journals** charge every accepted paper. Among the charges that could be read, a research article costs from USD 2,155 (PeerJ) to USD 5,690 (Genome Biology); shorter formats cost less at some journals. Each profile records the waivers and institutional agreements its site describes. UNF's own agreements with publishers are not on the journals' sites, so check them with the library before ruling a journal out.
- **Hybrid and subscription journals** ("none required") charge nothing unless the authors choose open access.
- **Free.** The Electronic Journal of Statistics charges no author fees, and Statistical Methods in Medical Research charges nothing to publish unless open access is chosen. The Annals of Applied Statistics states nothing about charges on its pages.

If there is no money for a charge, remove the fully open-access journals that offer no waiver.

### Step 5. Weigh selectivity against certainty

A selective journal brings more readers and more credit, at a higher chance of rejection, and every rejection costs a round of review. Four journals state on their own sites that they judge scientific soundness rather than perceived importance: PLOS ONE, PeerJ, BMC Bioinformatics, and BMC Genomics. Genome Biology, by contrast, also weighs the advance over previous work and its interest to a wide audience. Eight journals publish an acceptance rate on their own sites, and those rates are close together:

| Journal | Acceptance rate | Days to first decision | What the days measure |
|--------------------------------------|----------|----------|------------------------------|
| Journal of the American Statistical Association | 14% | 63 | average, Taylor & Francis |
| Journal of Applied Statistics | 14% | 9 | average, Taylor & Francis |
| Journal of Computational and Graphical Statistics | 15% | 15 | average, Taylor & Francis |
| Journal of Statistical Computation and Simulation | 15% | 3 | average, Taylor & Francis |
| Biometrical Journal | 16% | 31 | 2025 median, Wiley |
| The American Statistician | 18% | 53 | average, Taylor & Francis |
| Stat | 24% | 14 | 2025 median, Wiley |
| Statistics in Medicine | 26% | 45 | 2025 median, Wiley |

A short time to first decision usually means many desk rejections, not fast review. For the other journals, selectivity rests on their stated criteria and on the papers they publish; each profile gives any time-to-decision figure its site publishes.

For a paper with a fixed schedule, choose a target the paper has a real chance at and a fallback that will take a sound version of the same paper with little rework. The cheapest fallback has the same audience, a similar length, and the same abstract structure. The reference style costs nothing to change, because the CSL file changes it.

For a paper that sets out a general result and has no fixed schedule, the order can reverse: aim at the most selective journal that fits, because a rejection costs only time.

### Step 6. Look at where the procedure's own papers were published

Find the journal that published the procedure being critiqued, and the journals of its most-cited applications. This matters for three reasons.

- That journal's readers are the procedure's users, so a critique there reaches the right people.
- Its editors already judged the procedure worth publishing, so a paper that changes how it should be used is in scope by their own standard.
- The procedure's authors are likely reviewers wherever the paper goes. Write so that they can agree with it: state what the procedure does estimate, not only what it does not.

A journal that published the procedure is a strong candidate when it also passes steps 1 to 5. It is not a requirement, and a procedure published in a very selective journal does not make that journal a realistic target.

### Step 7. Check the AI-use policy against how the paper was written

This workflow drafts manuscripts with AI help, so the AI policy can rule a journal out. Eleven journals in the table forbid AI drafting of the text:

- **The three that follow the ISCB policy:** Bioinformatics, Bioinformatics Advances, and Briefings in Bioinformatics. Bioinformatics says that "papers must be written by researchers".
- **The six Taylor & Francis journals:** both JASA sections, JCGS, The American Statistician, JSCS, and Journal of Applied Statistics. Taylor & Francis says it "does not allow generative AI to create a first draft of a manuscript or sections of a manuscript".
- **Two Wiley journals with their own rule:** Statistics in Medicine and Stat say that authors "are expected to write the initial version of the manuscript themselves", with AI allowed for language editing of later drafts.

For those journals, the authors must write the submitted text themselves, using the AI draft only as notes, or the journal is out. Springer Nature and BMC journals allow drafting with human oversight and disclosure in the Methods. GigaScience requires the AI outputs to be deposited as a supplementary file. Each profile quotes the policy, with its URL and date, and ends with a sentence on what the manuscript's AI-use statement must do.

### Step 8. Check the practical items

Before the choice is final, open the target's and the fallback's profiles and confirm:

- **Code and data.** The rules differ in timing:
  - *At submission:* Bioinformatics, NAR Genomics and Bioinformatics, PeerJ, PLOS Computational Biology (for reviewers), and Statistics in Medicine (uploaded as data files). GigaScience wants it public by review. The BMC journals want it reachable by reviewers and archived with a DOI.
  - *At revision, then checked:* JASA (both sections), where a reproducibility editor reviews the materials, and Biometrical Journal, where a Reproducible Research Editor checks that the code reproduces the reported results.
  - *Before acceptance:* Cell Reports Methods and iScience, in a repository that mints DOIs.
  - *At acceptance:* The American Statistician, which requires code that reproduces at least one table or figure.
  Plan the repository and its Zenodo archive to the target's timing.
- **Review model.** Statistical Methods in Medical Research, both JASA sections, and The American Statistician use double-anonymized review, so the submitted manuscript cannot name the authors or link to a repository that identifies them; use an anonymized link until acceptance. JSCS and the Journal of Computational Biology each state both models on their own pages, so prepare an anonymized version for them too. BMC Bioinformatics, BMC Genomics, and BMC Medical Research Methodology publish the reviewer reports with the paper.
- **Abstract and length.** The draft's abstract is written to the target's headings and word limit, and the body to its length.

## Worksheet

Fill this in at stage 1, one line each, and keep it in `log/01-idea-review.md`; stage 2 copies its last three lines into section 6 of the spec.

| Question | Answer |
|---------------------------------------------------|--------------------------------------------------|
| 1. The paper's main contribution, in one sentence | |
| 2. Who must read it: the procedure's users, or methodologists | |
| 3. Paper type: critique, simulation and diagnostic, constructive method, short note, theory, or applied | |
| 4. Words needed, and displayed equations that must stay in the main text | |
| 5. Money for an open-access charge (amount, or none) | |
| 6. Schedule: is a first-round acceptance needed, or can the paper wait | |
| 7. Journal that published the procedure, and journals of its main applications | |
| 8. Candidates left after steps 1 to 6 (two to four) | |
| 9. For each candidate: AI policy compatible with how the paper is being written (yes or no) | |
| 10. For each candidate: code rule, review model, and abstract format, and anything that must change | |
| **Target journal** | |
| **Fallback journal**, with the reason it is cheap to switch to | |
| Target's word limit and AI policy, copied from its profile | |

The last three lines are what section 6 of the project spec records.

### A worked example: SS1

SS1 asks whether the control-fraction artifact of LIONESS edges carries over to SSN, SWEET, and BONOBO, with a closed form for SSN, a simulation study, within-group standardization as the fix, and a lupus RNA-seq application. Its spec names BMC Bioinformatics as the target and PLOS ONE as the fallback. Run through the worksheet, the choice holds up, as an illustration of the procedure rather than a new decision:

- The contribution is for the methods' users (standardize within group before building edges), so the paper is for genomics readers, and it is a critique.
- LIONESS was published in iScience (2019, https://doi.org/10.1016/j.isci.2019.03.021) and SSN in Nucleic Acids Research (2016, https://doi.org/10.1093/nar/gkw772). iScience has a Matters Arising format for papers that "directly and definitively challenge the main take-home message" of a published iScience paper, but it allows no revisions, and SS1 qualifies how LIONESS should be used rather than overturning it, so a regular research article fits better. NAR's sibling for analysis methods, NAR Genomics and Bioinformatics, is rated good for a critique and charges USD 3,035.
- BMC Bioinformatics is rated good for a critique, judges soundness, charges USD 3,090, asks for a structured abstract (Background, Results, Conclusions; 350 words), wants code reachable by reviewers and archived with a DOI, and allows AI drafting with disclosure in the Methods.
- PLOS ONE judges soundness, charges USD 2,477, takes an unstructured abstract of 300 words, and requires disclosure of AI use. Switching to it means rewriting the abstract and nothing else of substance.

## How the profiles were built, and what could not be read

All profiles were written on 2026-10-27 from the journals' own pages, their publishers' policy pages, and their societies' pages, each cited by URL with the date read. A field the site did not cover says "not stated on the site"; a field whose page would not load says "could not be read" and names the URL. Nothing was filled from memory or from third-party sites. Every recent paper listed was confirmed against Crossref (and PubMed where indexed); the year given is the year of the volume, which can be a year later than online publication.

The work went in two passes, both on 2026-10-27:

1. **Automated reading.** Several publishers block automated readers behind a "verify you are human" check or an outright refusal, and those checks were left alone. The author guidelines of 14 journals could not be read this way, and OUP shows its charges only in an interactive calculator.
2. **Reading in the user's own Chrome** (Claude in Chrome, read only, with non-essential cookies declined). This reached every blocked publisher: the Taylor & Francis instructions, aims pages, and open-access cost finder; the Wiley author guidelines and journal-metrics pages; the CSDA guide on ScienceDirect; the Cell Press author pages for Cell Reports Methods and iScience; the IMS pages for the Annals of Applied Statistics and the Electronic Journal of Statistics; the live Sage guideline pages, which confirmed the PDF copies used earlier; and the OUP charge calculator. Sources read this way are marked "read 2026-10-27 through Claude in Chrome" in each profile.

What is still missing after the second pass:

- **Pages that exist but say nothing on the point.** The IMS pages state no AI policy and no review model for the Annals of Applied Statistics or the Electronic Journal of Statistics, and nothing on charges for the Annals of Applied Statistics. Stat states no review model. Taylor & Francis states the AI declaration's contents but not where it goes in the manuscript. These are marked "not stated on the site".
- **Pages still unread.** Bioinformatics's manuscript-preparation section (abstract format and reference style), the Cell Press STAR Methods guides, Project Euclid's author pages for the Electronic Journal of Statistics, and the journals' ScholarOne submission sites. None blocks a choice of journal.

Each profile's last section lists exactly what it is missing and any contradiction between pages, with both sources.

## Reference styles in Quarto

Each profile's "Reference style" section names the CSL file to use. To render a manuscript in that style, copy the file next to `manuscript.qmd` and add it to the YAML header:

```yaml
bibliography: references.bib
csl: biomed-central.csl
```

Use the file at the top level of `csl/`, which is an independent style and renders offline. The official styles repository (github.com/citation-style-language/styles, commit d2cc420 of 2026-10-24) stores most journal styles as dependent files that only point to a parent style; those are kept in `csl/dependent/` under the journal's name for the record. Pandoc renders them too, but only with a network connection, because it fetches the parent at render time.

Every file was tested on 2026-10-27 by rendering a two-entry bibliography with `quarto pandoc --citeproc`; all 47 passed, and `csl/test-results.md` shows the first reference as each style renders it. To rerun the test after adding a file:

```bash
sh workflow/journals/csl/test-csl.sh
```

Some profiles needed a judgment call, and say so:

- **No file needed:** the Journal of Applied Statistics accepts any consistent style at submission and restyles references after acceptance. CSDA and JSCS also accept any style at submission; their files matter only for a draft that should look like the printed journal.
- **No file in the repository, substitute chosen to match the site:** Statistics in Medicine (AMA with superscript numbers, `american-medical-association.csl`), Biometrical Journal (APA, `apa.csl`; the site does not say which edition), Stat (APA 6th edition, `apa-6th-edition.csl`), and npj Systems Biology and Applications (Nature style, which the site names).
- **No file in the repository, closest style chosen:** Bioinformatics Advances (OUP author-date, since the site names no style), NAR Genomics and Bioinformatics (Nucleic Acids Research style, since the site defers to NAR's instructions), and SAGMB and the Annals of Applied Statistics (ASA author-year, the closest author-year style; SAGMB also abbreviates journal titles).
- **Repository file does not match the site:** Statistics in Biosciences (the repository's file is numbered, the site asks for author-year, so the Springer author-year style is used) and the Journal of Computational Biology (the repository's file predates the move to Sage, so the Sage Harvard style the site names is used).
- **Match rests on the repository, not the site:** Bioinformatics, whose style section is still unread.

## Adding or updating a journal

1. Copy `profile-template.md` to `profiles/<slug>.md` and fill every field from the journal's own pages, with URLs and dates.
2. Find the journal in the styles repository, put the independent style in `csl/` (and a dependent one in `csl/dependent/`), and run the test script.
3. Run `Rscript workflow/journals/build-table.R` from the project root (in the template repository itself add `--no-init-file`, so that renv does not activate there), then paste `summary-table.md` between the summary-table markers in this README.

Journal policies change, AI policies most of all. Reread a profile's sources before a submission if the profile is more than six months old.

## Open questions

1. **Journals to add or drop.** The 30 journals asked for are all profiled, plus six added because they take this kind of paper: Bioinformatics Advances, Statistics in Biosciences, Frontiers in Genetics, PeerJ, Journal of Applied Statistics, and Electronic Journal of Statistics (a free open-access home for a theory paper). Are there others you want, for example an autoimmune or rheumatology journal for an applied analysis, or Genetic Epidemiology? Are any on the list ones you would never use?
2. **Budget for charges.** Is there grant or departmental money for an open-access charge, and up to what amount? Does the institution have read-and-publish agreements with Springer Nature, OUP, Wiley, Elsevier, Taylor & Francis, or Sage? The answer decides step 4 for every paper.
3. **AI drafting.** Eleven journals forbid AI drafting of the text: the ISCB journals, all Taylor & Francis journals, Statistics in Medicine, and Stat. Should the workflow treat them as off limits for drafts it produces, or should the drafting step change for papers aimed at them?
4. **Unclear points the sites left open:**
   - Genome Biology calls its review single anonymized in its guidelines but advertises transparent peer review on its home page.
   - The Journal of Computational Biology gives both single and double anonymized review on the same live page, and both a 3,000-word limit and "longer articles may also be submitted". It also charges USD 90 per page on acceptance.
   - JSCS says single anonymous review in its instructions and double anonymized on its about page.
   - Briefings in Bioinformatics describes itself on one page as a review journal that does not publish pure original research and on another as publishing new methods.
   - Biostatistics's instructions give its open-access charge as USD 3,018, while OUP's calculator gives USD 3,599.
   - JASA's instructions give both "3 and 5" and "three to six" keywords, and the reproducibility guide and the instructions differ on whether the code checklist comes at submission or at revision.
   - Journal of Applied Statistics says format-free submission in its instructions and "must be prepared using the Journal's templates" on its about page.
   - Statistics in Medicine and Stat put the AI disclosure in an "Experimental section", which a statistics paper does not have, while Wiley's general guidance puts it in the Acknowledgments.
   - Springer Nature journals ask for AI use to be documented in the Methods, while the publisher-wide policy they link asks for an AI declaration, plus a statement in any figure legend for AI-assisted figures. Cell Press puts its AI declaration after the declaration of interests, while Elsevier's general page puts it before the references.
5. **Where this folder lives.** It is at `workflow/journals/` as asked. The brainstorm's open decision leans toward a top-level `manuscript-template/`. All paths inside the folder are relative, so it can move without edits.
