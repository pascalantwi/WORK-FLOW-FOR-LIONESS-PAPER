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
- record: Crossref record for the DOI, opened 2026-11-06
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
- record: Crossref record for the DOI, opened 2026-11-06
- full_text: abstract only

## Project entries

<!-- Entries added from stage 1 onward, in the order they were added. -->

### kuijjer2019lioness

> Kuijjer, M. L., Tung, M. G., Yuan, G., Quackenbush, J., & Glass, K. (2019). Estimating sample-specific regulatory networks. *iScience*, 14, 226-240. https://doi.org/10.1016/j.isci.2019.03.021

- type: article
- author: Kuijjer, M. L. and Tung, M. G. and Yuan, G. and Quackenbush, J. and Glass, K.
- title: Estimating sample-specific regulatory networks
- journal: iScience
- year: 2019
- volume: 14
- pages: 226-240
- doi: 10.1016/j.isci.2019.03.021
- record: PubMed record PMID 30981959, opened 2026-11-03
- full_text: https://pmc.ncbi.nlm.nih.gov/articles/PMC6463816/ (read 2026-11-03)

### kuijjer2019lionessr

> Kuijjer, M. L., Hsieh, P.-H., Quackenbush, J., & Glass, K. (2019). lionessR: single sample network inference in R. *BMC Cancer*, 19(1), 1003. https://doi.org/10.1186/s12885-019-6235-7

- type: article
- author: Kuijjer, Marieke L. and Hsieh, Ping-Han and Quackenbush, John and Glass, Kimberly
- title: {lionessR}: single sample network inference in {R}
- journal: BMC Cancer
- year: 2019
- volume: 19
- number: 1
- pages: 1003
- doi: 10.1186/s12885-019-6235-7
- record: Crossref record for the DOI, opened 2026-11-03
- full_text: https://pmc.ncbi.nlm.nih.gov/articles/PMC6815019/ (read 2026-11-03)

### devlin1975robust

> Devlin, S. J., Gnanadesikan, R., & Kettenring, J. R. (1975). Robust estimation and outlier detection with correlation coefficients. *Biometrika*, 62(3), 531-545. https://doi.org/10.1093/biomet/62.3.531

- type: article
- author: Devlin, Susan J. and Gnanadesikan, R. and Kettenring, J. R.
- title: Robust estimation and outlier detection with correlation coefficients
- journal: Biometrika
- year: 1975
- volume: 62
- number: 3
- pages: 531-545
- doi: 10.1093/biomet/62.3.531
- record: Crossref record for the DOI, opened 2026-11-03
- full_text: pending

### croux2010influence

> Croux, C., & Dehon, C. (2010). Influence functions of the Spearman and Kendall correlation measures. *Statistical Methods & Applications*, 19(4), 497-515. https://doi.org/10.1007/s10260-010-0142-z

- type: article
- author: Croux, Christophe and Dehon, Catherine
- title: Influence functions of the {Spearman} and {Kendall} correlation measures
- journal: Statistical Methods & Applications
- year: 2010
- volume: 19
- number: 4
- pages: 497-515
- doi: 10.1007/s10260-010-0142-z
- record: Crossref record for the DOI, opened 2026-11-03
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
- record: Crossref record for the DOI, opened 2026-11-03
- full_text: https://pmc.ncbi.nlm.nih.gov/articles/PMC5714249/ (read 2026-11-03)

### liu2016ssn

> Liu, X., Wang, Y., Ji, H., Aihara, K., & Chen, L. (2016). Personalized characterization of diseases using sample-specific networks. *Nucleic Acids Research*, 44(22), e164. https://doi.org/10.1093/nar/gkw772

- type: article
- author: Liu, Xiaoping and Wang, Yuetong and Ji, Hongbin and Aihara, Kazuyuki and Chen, Luonan
- title: Personalized characterization of diseases using sample-specific networks
- journal: Nucleic Acids Research
- year: 2016
- volume: 44
- number: 22
- pages: e164
- doi: 10.1093/nar/gkw772
- record: Crossref record for the DOI, opened 2026-11-03
- full_text: https://pmc.ncbi.nlm.nih.gov/articles/PMC5159538/ (read 2026-11-03)

### deschildre2024evaluation

> Deschildre, J., Vandemoortele, B., Loers, J. U., De Preter, K., & Vermeirssen, V. (2024). Evaluation of single-sample network inference methods for precision oncology. *npj Systems Biology and Applications*, 10(1), 18. https://doi.org/10.1038/s41540-024-00340-w

- type: article
- author: Deschildre, Joke and Vandemoortele, Boris and Loers, Jens Uwe and De Preter, Katleen and Vermeirssen, Vanessa
- title: Evaluation of single-sample network inference methods for precision oncology
- journal: npj Systems Biology and Applications
- year: 2024
- volume: 10
- number: 1
- pages: 18
- doi: 10.1038/s41540-024-00340-w
- record: Crossref record for the DOI, opened 2026-11-03
- full_text: https://pmc.ncbi.nlm.nih.gov/articles/PMC10869342/ (read 2026-11-03)

### kuijjer2026challenges

> Kuijjer, M., De Marzio, M., & Glass, K. (2026). Challenges and opportunities in single-sample network modeling. bioRxiv preprint. https://doi.org/10.64898/2026.02.27.708608

- type: misc
- author: Kuijjer, Marieke and De Marzio, Margherita and Glass, Kimberly
- title: Challenges and opportunities in single-sample network modeling
- year: 2026
- doi: 10.64898/2026.02.27.708608
- note: bioRxiv preprint
- record: Crossref record for the DOI, opened 2026-11-03; PubMed PMID 41867852, opened 2026-11-03
- full_text: https://pmc.ncbi.nlm.nih.gov/articles/PMC13001488/ (read 2026-11-03); bioRxiv PDF of the main paper supplied by the user, read 2026-11-06 (references/pdfs/kuijjer2026challenges.pdf; Figure 1, the recast equations, and the Methods, which place the derivations in Supplemental File 1); Supplement 1 itself not yet read

### jahagirdar2021metabolomics

> Jahagirdar, S., & Saccenti, E. (2021). Evaluation of single sample network inference methods for metabolomics-based systems medicine. *Journal of Proteome Research*, 20(1), 932-949. https://doi.org/10.1021/acs.jproteome.0c00696

- type: article
- author: Jahagirdar, Sanjeevan and Saccenti, Edoardo
- title: Evaluation of single sample network inference methods for metabolomics-based systems medicine
- journal: Journal of Proteome Research
- year: 2021
- volume: 20
- number: 1
- pages: 932-949
- doi: 10.1021/acs.jproteome.0c00696
- record: Crossref record for the DOI, opened 2026-11-03
- full_text: https://pmc.ncbi.nlm.nih.gov/articles/PMC7786380/ (read 2026-11-03)

### saha2024bonobo

> Saha, E., Fanfani, V., Mandros, P., Ben Guebila, M., Fischer, J., Shutta, K. H., DeMeo, D. L., Lopes-Ramos, C. M., & Quackenbush, J. (2024). Bayesian inference of sample-specific coexpression networks. *Genome Research*, 34(9), 1397-1410. https://doi.org/10.1101/gr.279117.124

- type: article
- author: Saha, Enakshi and Fanfani, Viola and Mandros, Panagiotis and Ben Guebila, Marouen and Fischer, Jonas and Shutta, Katherine H. and DeMeo, Dawn L. and Lopes-Ramos, Camila M. and Quackenbush, John
- title: Bayesian inference of sample-specific coexpression networks
- journal: Genome Research
- year: 2024
- volume: 34
- number: 9
- pages: 1397-1410
- doi: 10.1101/gr.279117.124
- record: Crossref record for the DOI, opened 2026-11-03
- full_text: https://pmc.ncbi.nlm.nih.gov/articles/PMC11529861/ (read 2026-11-03)

### chen2023sweet

> Chen, H. H., Hsueh, C. W., Lee, C. H., Hao, T. Y., Tu, T. Y., Chang, L. Y., Lee, J. C., & Lin, C. Y. (2023). SWEET: a single-sample network inference method for deciphering individual features in disease. *Briefings in Bioinformatics*, 24(2). https://doi.org/10.1093/bib/bbad032

- type: article
- author: Chen, H. H. and Hsueh, C. W. and Lee, C. H. and Hao, T. Y. and Tu, T. Y. and Chang, L. Y. and Lee, J. C. and Lin, C. Y.
- title: {SWEET}: a single-sample network inference method for deciphering individual features in disease
- journal: Briefings in Bioinformatics
- year: 2023
- volume: 24
- number: 2
- doi: 10.1093/bib/bbad032
- record: PubMed Central record PMC10025435 (PMID 36719112), opened 2026-11-03
- full_text: https://pmc.ncbi.nlm.nih.gov/articles/PMC10025435/ (read 2026-11-03)

### ahn2024pseudovalue

> Ahn, S., & Datta, S. (2024). Differential network connectivity analysis for microbiome data adjusted for clinical covariates using jackknife pseudo-values. *BMC Bioinformatics*, 25(1), 117. https://doi.org/10.1186/s12859-024-05689-7

- type: article
- author: Ahn, Seungjun and Datta, Somnath
- title: Differential network connectivity analysis for microbiome data adjusted for clinical covariates using jackknife pseudo-values
- journal: BMC Bioinformatics
- year: 2024
- volume: 25
- number: 1
- pages: 117
- doi: 10.1186/s12859-024-05689-7
- note: preprint arXiv:2303.13702
- record: Crossref record for the DOI, opened 2026-11-03
- full_text: https://pmc.ncbi.nlm.nih.gov/articles/PMC10946111/ (read 2026-11-03)

### elsherbiny2018twoscore

> El-Sherbiny, Y. M., Psarras, A., Md Yusof, M. Y., Hensor, E. M. A., Tooze, R., Doody, G., Mohamed, A. A. A., McGonagle, D., Wittmann, M., Emery, P., & Vital, E. M. (2018). A novel two-score system for interferon status segregates autoimmune diseases and correlates with clinical features. *Scientific Reports*, 8(1), 5793. https://doi.org/10.1038/s41598-018-24198-1

- type: article
- author: El-Sherbiny, Y. M. and Psarras, A. and Md Yusof, M. Y. and Hensor, E. M. A. and Tooze, R. and Doody, G. and Mohamed, A. A. A. and McGonagle, D. and Wittmann, M. and Emery, P. and Vital, E. M.
- title: A novel two-score system for interferon status segregates autoimmune diseases and correlates with clinical features
- journal: Scientific Reports
- year: 2018
- volume: 8
- number: 1
- pages: 5793
- doi: 10.1038/s41598-018-24198-1
- record: Crossref record for the DOI, opened 2026-11-03
- full_text: https://pmc.ncbi.nlm.nih.gov/articles/PMC5895784/ (read 2026-11-03)

### mai2021ifn5

> Mai, L., Asaduzzaman, A., Noamani, B., Fortin, P. R., Gladman, D. D., Touma, Z., Urowitz, M. B., & Wither, J. (2021). The baseline interferon signature predicts disease severity over the subsequent 5 years in systemic lupus erythematosus. *Arthritis Research & Therapy*, 23(1), 29. https://doi.org/10.1186/s13075-021-02414-0

- type: article
- author: Mai, Lloyd and Asaduzzaman, Arundip and Noamani, Babak and Fortin, Paul R. and Gladman, Dafna D. and Touma, Zahi and Urowitz, Murray B. and Wither, Joan
- title: The baseline interferon signature predicts disease severity over the subsequent 5 years in systemic lupus erythematosus
- journal: Arthritis Research & Therapy
- year: 2021
- volume: 23
- number: 1
- pages: 29
- doi: 10.1186/s13075-021-02414-0
- record: Crossref record for the DOI, opened 2026-11-03
- full_text: https://pmc.ncbi.nlm.nih.gov/articles/PMC7811214/ (read 2026-11-03)

### barturen2021precisesads

> Barturen, G., Babaei, S., Catal\`a-Moll, F., & others (2021). Integrative analysis reveals a molecular stratification of systemic autoimmune diseases. *Arthritis & Rheumatology*, 73(6), 1073-1085. https://doi.org/10.1002/art.41610

- type: article
- author: Barturen, G. and Babaei, S. and Catal{\`a}-Moll, F. and others
- title: Integrative analysis reveals a molecular stratification of systemic autoimmune diseases
- journal: Arthritis & Rheumatology
- year: 2021
- volume: 73
- number: 6
- pages: 1073-1085
- doi: 10.1002/art.41610
- record: PubMed record PMID 33497037, opened 2026-11-03 (132 authors)
- full_text: https://publicatio.bibl.u-szeged.hu/21552/1/BarturenArthRheumatol2021.pdf (repository copy, read 2026-11-03)

### sentis2026lupusarthritis

> Sentis, G., Kalantzi, C., Flouda, S., Banos, A., Garantziotis, P., Manolakou, T., Chatzidionysiou, K., Kapsala, N., Pieta, A., Chavatza, K., Triantafyllias, K., Filia, A., Bertsias, G., Parodis, I., Boumpas, D. T., & Nikolopoulos, D. (2026). Whole-blood transcriptomics identifies a distinct metabolic and inflammatory signature in lupus arthritis compared with rheumatoid arthritis. *Journal of Autoimmunity*, 164, 103634. https://doi.org/10.1016/j.jaut.2026.103634

- type: article
- author: Sentis, George and Kalantzi, Chrysoula and Flouda, Sofia and Banos, Aggelos and Garantziotis, Panagiotis and Manolakou, Theodora and Chatzidionysiou, Katerina and Kapsala, Noemin and Pieta, Antigone and Chavatza, Katerina and Triantafyllias, Konstantinos and Filia, Anastasia and Bertsias, George and Parodis, Ioannis and Boumpas, Dimitrios T. and Nikolopoulos, Dionysis
- title: Whole-blood transcriptomics identifies a distinct metabolic and inflammatory signature in lupus arthritis compared with rheumatoid arthritis
- journal: Journal of Autoimmunity
- year: 2026
- volume: 164
- pages: 103634
- doi: 10.1016/j.jaut.2026.103634
- record: Crossref record for the DOI and PubMed record PMID 42743789, opened 2026-11-06
- full_text: abstract only (PubMed, read 2026-11-06); cited as supporting

### quenouille1956bias

> Quenouille, M. H. (1956). Notes on bias in estimation. *Biometrika*, 43(3-4), 353-360. https://doi.org/10.1093/biomet/43.3-4.353

- type: article
- author: Quenouille, M. H.
- title: Notes on bias in estimation
- journal: Biometrika
- year: 1956
- volume: 43
- number: 3-4
- pages: 353-360
- doi: 10.1093/biomet/43.3-4.353
- record: Crossref record for the DOI, opened 2026-11-06
- full_text: not read; pre-1980 source cited as definitional (the jackknife)

### miller1974jackknife

> Miller, R. G. (1974). The jackknife: a review. *Biometrika*, 61(1), 1-15. https://doi.org/10.1093/biomet/61.1.1

- type: article
- author: Miller, Rupert G.
- title: The jackknife: a review
- journal: Biometrika
- year: 1974
- volume: 61
- number: 1
- pages: 1-15
- doi: 10.1093/biomet/61.1.1
- record: Crossref record for the DOI, opened 2026-11-06
- full_text: not read; pre-1980 source cited as definitional (jackknife pseudo-values)

### precisesads2017data

> ELIXIR Luxembourg (2017). PRECISESADS: Cross Sectional Study & Inception Cohort data (V1.0). Data set, controlled access, ELU-2-E592B0-1. https://doi.org/10.17881/th9v-xt85

- type: misc
- author: {ELIXIR Luxembourg}
- title: {PRECISESADS}: Cross Sectional Study & Inception Cohort data (V1.0)
- year: 2017
- doi: 10.17881/th9v-xt85
- url: https://datacatalogue.elixir-luxembourg.org/e/dataset/ELU-2-E592B0-1
- note: Data set, controlled access, ELU-2-E592B0-1
- record: ELIXIR Luxembourg data catalogue landing page (the DOI resolves to it), opened 2026-11-03
- full_text: not needed (definitional)

### tasaki2018multiomics

> Tasaki, S., Suzuki, K., Kassai, Y., Takeshita, M., Murota, A., Kondo, Y., Ando, T., Nakayama, Y., Okuzono, Y., Takiguchi, M., Kurisu, R., Miyazaki, T., Yoshimoto, K., Yasuoka, H., Yamaoka, K., Morita, R., Yoshimura, A., Toyoshiba, H., & Takeuchi, T. (2018). Multi-omics monitoring of drug response in rheumatoid arthritis in pursuit of molecular remission. *Nature Communications*, 9(1), 2755. https://doi.org/10.1038/s41467-018-05044-4

- type: article
- author: Tasaki, S. and Suzuki, K. and Kassai, Y. and Takeshita, M. and Murota, A. and Kondo, Y. and Ando, T. and Nakayama, Y. and Okuzono, Y. and Takiguchi, M. and Kurisu, R. and Miyazaki, T. and Yoshimoto, K. and Yasuoka, H. and Yamaoka, K. and Morita, R. and Yoshimura, A. and Toyoshiba, H. and Takeuchi, T.
- title: Multi-omics monitoring of drug response in rheumatoid arthritis in pursuit of molecular remission
- journal: Nature Communications
- year: 2018
- volume: 9
- number: 1
- pages: 2755
- doi: 10.1038/s41467-018-05044-4
- record: PubMed record PMID 30013029, opened 2026-11-03
- full_text: https://pmc.ncbi.nlm.nih.gov/articles/PMC6048065/ (read 2026-11-03)

### varma2006bias

> Varma, S., & Simon, R. (2006). Bias in error estimation when using cross-validation for model selection. *BMC Bioinformatics*, 7(1), 91. https://doi.org/10.1186/1471-2105-7-91

- type: article
- author: Varma, Sudhir and Simon, Richard
- title: Bias in error estimation when using cross-validation for model selection
- journal: BMC Bioinformatics
- year: 2006
- volume: 7
- number: 1
- pages: 91
- doi: 10.1186/1471-2105-7-91
- record: Crossref record for the DOI, opened 2026-11-03
- full_text: not needed (definitional)

### nadeau2003inference

> Nadeau, C., & Bengio, Y. (2003). Inference for the generalization error. *Machine Learning*, 52(3), 239-281. https://doi.org/10.1023/A:1024068626366

- type: article
- author: Nadeau, Claude and Bengio, Yoshua
- title: Inference for the generalization error
- journal: Machine Learning
- year: 2003
- volume: 52
- number: 3
- pages: 239-281
- doi: 10.1023/A:1024068626366
- record: Crossref record for the DOI, opened 2026-11-03
- full_text: not needed (definitional)

### mckenzie2016dgca

> McKenzie, A. T., Katsyv, I., Song, W.-M., Wang, M., & Zhang, B. (2016). DGCA: a comprehensive R package for differential gene correlation analysis. *BMC Systems Biology*, 10(1), 106. https://doi.org/10.1186/s12918-016-0349-1

- type: article
- author: McKenzie, Andrew T. and Katsyv, Igor and Song, Won-Min and Wang, Minghui and Zhang, Bin
- title: {DGCA}: a comprehensive {R} package for differential gene correlation analysis
- journal: BMC Systems Biology
- year: 2016
- volume: 10
- number: 1
- pages: 106
- doi: 10.1186/s12918-016-0349-1
- record: Crossref record for the DOI, opened 2026-11-03
- full_text: not needed (definitional)

### newman2015cibersort

> Newman, A. M., Liu, C. L., Green, M. R., Gentles, A. J., Feng, W., Xu, Y., Hoang, C. D., Diehn, M., & Alizadeh, A. A. (2015). Robust enumeration of cell subsets from tissue expression profiles. *Nature Methods*, 12(5), 453-457. https://doi.org/10.1038/nmeth.3337

- type: article
- author: Newman, A. M. and Liu, C. L. and Green, M. R. and Gentles, A. J. and Feng, W. and Xu, Y. and Hoang, C. D. and Diehn, M. and Alizadeh, A. A.
- title: Robust enumeration of cell subsets from tissue expression profiles
- journal: Nature Methods
- year: 2015
- volume: 12
- number: 5
- pages: 453-457
- doi: 10.1038/nmeth.3337
- record: PubMed record PMID 25822800, opened 2026-11-03
- full_text: not needed (definitional)

### friedman2010glmnet

> Friedman, J., Hastie, T., & Tibshirani, R. (2010). Regularization paths for generalized linear models via coordinate descent. *Journal of Statistical Software*, 33(1). https://doi.org/10.18637/jss.v033.i01

- type: article
- author: Friedman, Jerome and Hastie, Trevor and Tibshirani, Robert
- title: Regularization paths for generalized linear models via coordinate descent
- journal: Journal of Statistical Software
- year: 2010
- volume: 33
- number: 1
- doi: 10.18637/jss.v033.i01
- record: Crossref record for the DOI, opened 2026-11-04
- full_text: not needed (definitional)

### schuirmann1987tost

> Schuirmann, D. J. (1987). A comparison of the two one-sided tests procedure and the power approach for assessing the equivalence of average bioavailability. *Journal of Pharmacokinetics and Biopharmaceutics*, 15(6), 657-680. https://doi.org/10.1007/BF01068419

- type: article
- author: Schuirmann, Donald J.
- title: A comparison of the two one-sided tests procedure and the power approach for assessing the equivalence of average bioavailability
- journal: Journal of Pharmacokinetics and Biopharmaceutics
- year: 1987
- volume: 15
- number: 6
- pages: 657-680
- doi: 10.1007/BF01068419
- record: Crossref record for the DOI, opened 2026-11-04
- full_text: not needed (definitional)

### langfelder2008wgcna

> Langfelder, P., & Horvath, S. (2008). WGCNA: an R package for weighted correlation network analysis. *BMC Bioinformatics*, 9(1), 559. https://doi.org/10.1186/1471-2105-9-559

- type: article
- author: Langfelder, Peter and Horvath, Steve
- title: {WGCNA}: an {R} package for weighted correlation network analysis
- journal: BMC Bioinformatics
- year: 2008
- volume: 9
- number: 1
- pages: 559
- doi: 10.1186/1471-2105-9-559
- record: Crossref record for the DOI, opened 2026-11-04 (article number from the DOI suffix)
- full_text: not needed (definitional)
