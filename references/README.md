# References

The project's reference list. No Zotero library is used (`workflow/rules.md`, section 2).

| File | What it holds | Who edits it |
|---|---|---|
| `references.md` | Every source the project cites, one entry per source, copied from a record the agent opened | The agent; you review it once, at the end (stage 3, step 6) |
| `reference-fixes.md` | Faults `build-bib.py` found in the list (a missing DOI, a lower-case journal, ...) | Generated; should end up empty |
| `pdfs/` | Full texts you add as `pdfs/<key>.pdf` for core citations the agent lists as `pending`; optional until the end | You; not committed to git |

`manuscript/references.bib`, which the manuscript renders from, is generated from `references.md`:

```bash
python3 -I manuscript/build-bib.py references/references.md manuscript/references.bib --citations manuscript/citations.csv --check
```
