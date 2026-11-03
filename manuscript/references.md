# References

<!-- The project's reference list. This project keeps no Zotero library: this file is the only source
for anything cited in a deliverable from the proposal onward (workflow/rules.md, section 2).

- The agent writes each entry from a record it opened (the DOI's Crossref record or the publisher's
  page, PubMed, arXiv, bioRxiv, CRAN or Bioconductor for software) and names that record, with the
  date, in the `record` field. Nothing is written from memory.
- `references.bib` is generated from this file by
  `python3 -I manuscript/build-bib.py manuscript/references.md manuscript/references.bib --citations manuscript/citations.csv`
  and is never edited by hand. Faults go to `reference-fixes.md`.
- The quoted line under each heading is rewritten by build-bib.py on every run: edit the fields, not
  the quoted line.
- The passage each citation rests on is recorded in `citations.csv`, not here.
- `full_text` says where the full text was read: a URL (an open copy), `manuscript/sources/<key>.pdf`
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
- full_text: https://... (open copy), or manuscript/sources/key2024.pdf, or abstract only, or pending
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
