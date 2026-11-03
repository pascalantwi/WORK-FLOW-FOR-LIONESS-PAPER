# References

<!-- The project's reference list. This project keeps no Zotero library: this file is the only source
for anything cited in a deliverable from the proposal onward (workflow/rules.md, section 2).

- The agent writes each entry from a record it opened (the DOI's Crossref record or the publisher's
  page, PubMed, arXiv, bioRxiv, CRAN or Bioconductor for software) and names that record, with the
  date, in the `record` field. Nothing is written from memory.
- `references.bib` is generated from this file by
  `python3 -I manuscript/build-bib.py references/references.md manuscript/references.bib --citations manuscript/citations.csv`
  and is never edited by hand. Faults go to `reference-fixes.md`.
- The quoted line under each heading is rewritten by build-bib.py on every run: edit the fields, not
  the quoted line.
- The passage each citation rests on is recorded in `citations.csv`, not here.
- `full_text` says where the full text was read: a URL (an open copy), `references/pdfs/<key>.pdf`
  (a PDF the user added; the folder is git-ignored), `abstract only` (allowed for a supporting
  citation), or `pending` (a core citation still waiting for its full text).
- The user reviews this file once, at the end (workflow/03-manuscript.md, step 6, the reference review).

Entry form (fields: type, author, editor, title, journal, booktitle, publisher, address, series,
edition, institution, school, year, volume, number, pages, doi, url, note, record, full_text):

### key2024

- type: article
- author: Family, Given and Family, Given
- title: Title in sentence case, with {R} or {LIONESS} in braces to keep the capitals
- journal: Journal Name
- year: 2024
- volume: 1
- number: 2
- pages: 10-20
- doi: 10.xxxx/xxxxx
- record: Crossref record for the DOI, opened 2026-11-03
- full_text: https://... (open copy), or references/pdfs/key2024.pdf, or abstract only, or pending
-->

## Seed entries

Cited by every manuscript of this workflow (the ADEMP sentence and the reproducibility paragraph).

### morris2019

> Morris, T. P., White, I. R., & Crowther, M. J. (2019). Using simulation studies to evaluate statistical methods. *Statistics in Medicine*, 38(11), 2074-2102. https://doi.org/10.1002/sim.8086

- type: article
- author: Morris, Tim P. and White, Ian R. and Crowther, Michael J.
- title: Using simulation studies to evaluate statistical methods
- journal: Statistics in Medicine
- year: 2019
- volume: 38
- number: 11
- pages: 2074-2102
- doi: 10.1002/sim.8086
- record: seed entry carried from the research-workflow template's references.bib
- full_text: abstract only

### marwick2018

> Marwick, B., Boettiger, C., & Mullen, L. (2018). Packaging data analytical work reproducibly using R (and friends). *The American Statistician*, 72(1), 80-88. https://doi.org/10.1080/00031305.2017.1375986

- type: article
- author: Marwick, Ben and Boettiger, Carl and Mullen, Lincoln
- title: Packaging data analytical work reproducibly using {R} (and friends)
- journal: The American Statistician
- year: 2018
- volume: 72
- number: 1
- pages: 80-88
- doi: 10.1080/00031305.2017.1375986
- record: seed entry carried from the research-workflow template's references.bib
- full_text: abstract only

## Project entries

<!-- Entries added from stage 1 onward, in the order they were added. -->

### kuijjer2019lioness

> Kuijjer, M. L., Tung, M. G., Yuan, G., Quackenbush, J., & Glass, K. (2019). Estimating sample-specific regulatory networks. *iScience*, 14, 226-240.

- type: article
- author: Kuijjer, Marieke Lydia and Tung, Matthew George and Yuan, GuoCheng and Quackenbush, John and Glass, Kimberly
- title: Estimating sample-specific regulatory networks
- journal: iScience
- year: 2019
- volume: 14
- pages: 226-240
- note: arXiv:1505.06440; PMID 30981959
- record: not opened: web search result only, 2026-11-03; the session's network policy blocked the publisher, PubMed, and Crossref (author list, volume, and pages from a bib file in the user's earlier repository, to be checked)
- full_text: pending

### kuijjer2019lionessr

> [no author] (2019). lionessR: single sample network inference in R. *BMC Cancer*. https://doi.org/10.1186/s12885-019-6235-7

- type: article
- title: lionessR: single sample network inference in R
- journal: BMC Cancer
- year: 2019
- doi: 10.1186/s12885-019-6235-7
- record: not opened: web search result only, 2026-11-03; the session's network policy blocked the publisher, PubMed, and Crossref
- full_text: pending

### devlin1975robust

> Devlin, S. J., Gnanadesikan, R., & Kettenring, J. R. (1975). Robust estimation and outlier detection with correlation coefficients. *Biometrika*, 62, 531-545.

- type: article
- author: Devlin, Susan J. and Gnanadesikan, R. and Kettenring, J. R.
- title: Robust estimation and outlier detection with correlation coefficients
- journal: Biometrika
- year: 1975
- volume: 62
- pages: 531-545
- record: not opened: web search result only, 2026-11-03; the session's network policy blocked the publisher, PubMed, and Crossref (citation as given in the reference list of Croux and Dehon, 2010)
- full_text: pending

### croux2010influence

> Croux, C., & Dehon, C. (2010). [no title]. *Statistical Methods and Applications*. https://doi.org/10.1007/s10260-010-0142-z

- type: article
- author: Croux, Christophe and Dehon, Catherine
- journal: Statistical Methods and Applications
- year: 2010
- doi: 10.1007/s10260-010-0142-z
- record: not opened: web search result only, 2026-11-03; the session's network policy blocked the publisher, PubMed, and Crossref
- full_text: pending

### yu2017iena

> Yu, X., Zhang, J., Sun, S., Zhou, X., Zeng, T., & Chen, L. (2017). Individual-specific edge-network analysis for disease prediction. *Nucleic Acids Research*, 45(20), e170. https://doi.org/10.1093/nar/gkx787

- type: article
- author: Yu, Xiangtian and Zhang, Jingsong and Sun, Shaoyan and Zhou, Xin and Zeng, Tao and Chen, Luonan
- title: Individual-specific edge-network analysis for disease prediction
- journal: Nucleic Acids Research
- year: 2017
- volume: 45
- number: 20
- pages: e170
- doi: 10.1093/nar/gkx787
- record: not opened: web search result only, 2026-11-03; the session's network policy blocked the publisher, PubMed, and Crossref
- full_text: pending

### liu2016ssn

> [no author] (2016). Personalized characterization of diseases using sample-specific networks. *Nucleic Acids Research*, 44(22), e164. https://doi.org/10.1093/nar/gkw772

- type: article
- title: Personalized characterization of diseases using sample-specific networks
- journal: Nucleic Acids Research
- year: 2016
- volume: 44
- number: 22
- pages: e164
- doi: 10.1093/nar/gkw772
- record: not opened: web search result only, 2026-11-03; the session's network policy blocked the publisher, PubMed, and Crossref (first author Liu; full author list not seen)
- full_text: pending

### npj2024evaluation

> [no author] (2024). Evaluation of single-sample network inference methods for precision oncology. *npj Systems Biology and Applications*. https://doi.org/10.1038/s41540-024-00340-w

- type: article
- title: Evaluation of single-sample network inference methods for precision oncology
- journal: npj Systems Biology and Applications
- year: 2024
- doi: 10.1038/s41540-024-00340-w
- record: not opened: web search result only, 2026-11-03; the session's network policy blocked the publisher, PubMed, and Crossref
- full_text: pending

### kuijjer2026challenges

> [no author] (2026). Challenges and opportunities in single-sample network modeling. bioRxiv preprint; PMID 41867852. https://doi.org/10.64898/2026.02.27.708608

- type: misc
- title: Challenges and opportunities in single-sample network modeling
- year: 2026
- doi: 10.64898/2026.02.27.708608
- note: bioRxiv preprint; PMID 41867852
- record: not opened: web search result only, 2026-11-03; the session's network policy blocked the publisher, PubMed, and Crossref (search results name Kuijjer and colleagues; author list not seen)
- full_text: pending

### jpr2020metabolomics

> [no author] (2020). Evaluation of single sample network inference methods for metabolomics-based systems medicine. *Journal of Proteome Research*. https://doi.org/10.1021/acs.jproteome.0c00696

- type: article
- title: Evaluation of single sample network inference methods for metabolomics-based systems medicine
- journal: Journal of Proteome Research
- year: 2020
- doi: 10.1021/acs.jproteome.0c00696
- record: not opened: web search result only, 2026-11-03; the session's network policy blocked the publisher, PubMed, and Crossref (year inferred from the DOI; to be checked)
- full_text: pending

### bonobo2024

> [no author] (2024). Bayesian inference of sample-specific coexpression networks. *Genome Research*, 34(9), 1397.

- type: article
- title: Bayesian inference of sample-specific coexpression networks
- journal: Genome Research
- year: 2024
- volume: 34
- number: 9
- pages: 1397
- record: not opened: web search result only, 2026-11-03; the session's network policy blocked the publisher, PubMed, and Crossref
- full_text: pending

### sweet2023

> [no author] (n.d.). SWEET: a single-sample network inference method for deciphering individual features in disease. *[no journal]*.

- type: article
- title: {SWEET}: a single-sample network inference method for deciphering individual features in disease
- note: PMC10025435
- record: not opened: web search result only, 2026-11-03; the session's network policy blocked the publisher, PubMed, and Crossref (journal and year not seen)
- full_text: pending

### pseudovalue2023microbiome

> [no author] (2023). Differential co-abundance network analyses for microbiome data adjusted for clinical covariates using jackknife pseudo-values. arXiv:2303.13702. https://arxiv.org/abs/2303.13702

- type: misc
- title: Differential co-abundance network analyses for microbiome data adjusted for clinical covariates using jackknife pseudo-values
- year: 2023
- url: https://arxiv.org/abs/2303.13702
- note: arXiv:2303.13702
- record: not opened: web search result only, 2026-11-03; the session's network policy blocked the publisher, PubMed, and Crossref
- full_text: pending

### elsherbiny2018twoscore

> El-Sherbiny, Y. M., & others (2018). A novel two-score system for interferon status segregates autoimmune diseases and correlates with clinical features. *Scientific Reports*. https://doi.org/10.1038/s41598-018-24198-1

- type: article
- author: El-Sherbiny, Yasser M. and others
- title: A novel two-score system for interferon status segregates autoimmune diseases and correlates with clinical features
- journal: Scientific Reports
- year: 2018
- doi: 10.1038/s41598-018-24198-1
- record: not opened: web search result only, 2026-11-03; the session's network policy blocked the publisher, PubMed, and Crossref (full author list not seen)
- full_text: pending

### barturen2021precisesads

> Barturen, G., & others (2021). Integrative analysis reveals a molecular stratification of systemic autoimmune diseases. *Arthritis & Rheumatology*, 73(6), 1073-1085.

- type: article
- author: Barturen, Guillermo and others
- title: Integrative analysis reveals a molecular stratification of systemic autoimmune diseases
- journal: Arthritis & Rheumatology
- year: 2021
- volume: 73
- number: 6
- pages: 1073-1085
- record: not opened: web search result only, 2026-11-03; the session's network policy blocked the publisher, PubMed, and Crossref (full author list not seen)
- full_text: pending

### precisesads2021data

> PRECISESADS Consortium (2021). PRECISESADS: molecular reclassification to find clinically useful biomarkers for systemic autoimmune diseases. ELIXIR Luxembourg, controlled access. https://doi.org/10.17881/th9v-xt85

- type: misc
- author: {PRECISESADS Consortium}
- title: {PRECISESADS}: molecular reclassification to find clinically useful biomarkers for systemic autoimmune diseases
- year: 2021
- doi: 10.17881/th9v-xt85
- note: ELIXIR Luxembourg, controlled access
- record: not opened: web search result only, 2026-11-03; the session's network policy blocked the publisher, PubMed, and Crossref (year of deposit not seen)
- full_text: not needed (definitional)

### tasaki2018multiomics

> Tasaki, S., & others (2018). Multi-omics monitoring of drug response in rheumatoid arthritis in pursuit of molecular remission. *Nature Communications*, 9(1), 2755.

- type: article
- author: Tasaki, Shinya and others
- title: Multi-omics monitoring of drug response in rheumatoid arthritis in pursuit of molecular remission
- journal: Nature Communications
- year: 2018
- volume: 9
- number: 1
- pages: 2755
- note: PMID 30013029
- record: not opened: web search result only, 2026-11-03; the session's network policy blocked the publisher, PubMed, and Crossref (full author list and DOI not seen)
- full_text: pending

### varma2006bias

> Varma, S., & Simon, R. (2006). Bias in error estimation when using cross-validation for model selection. *BMC Bioinformatics*, 7, 91. https://doi.org/10.1186/1471-2105-7-91

- type: article
- author: Varma, Sudhir and Simon, Richard
- title: Bias in error estimation when using cross-validation for model selection
- journal: BMC Bioinformatics
- year: 2006
- volume: 7
- pages: 91
- doi: 10.1186/1471-2105-7-91
- record: not opened: web search result only, 2026-11-03; the session's network policy blocked the publisher, PubMed, and Crossref
- full_text: not needed (definitional)
