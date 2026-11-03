"""Build references.bib from the Markdown reference list, references.md.

Usage:
  python3 -I manuscript/build-bib.py references/references.md manuscript/references.bib
          [--citations citations.csv] [--fixes reference-fixes.md] [--qmd manuscript.qmd] [--check]

This project keeps no Zotero library. The reference list is `references/references.md`, written by the agent from
records it opened (the DOI's Crossref record or the publisher's page, PubMed, arXiv, bioRxiv, CRAN or
Bioconductor for software) and reviewed by the user at the end (workflow/03-manuscript.md, step 6).
references.bib is generated from it by this script and is never edited by hand.

Format of an entry in references.md: a level-3 heading holding the citation key, a quoted line (a
readable citation for the user's review, rewritten by this script on every run), and a list of
`- field: value` lines. Fields written to the bib: type, author, editor, title, journal, booktitle,
publisher, address, series, edition, institution, school, year, volume, number, pages, doi, url, note.
Authors are written "Family, Given and Family, Given". Pages use a single hyphen (2074-2102); the bib
gets the double hyphen. A URL is written to the bib only when the entry has no DOI. Fields kept in the
list only: record (where the fields were copied from, and the date) and full_text (where the full text
was read: a URL, `references/pdfs/<key>.pdf`, `abstract only`, or `pending`).

Faults are written to the fixes file, to be corrected in references.md (never in the bib): a missing
author, title, or year; an article without a journal or a DOI; a journal name in lower case; an author
list of exactly ten (often a cut list); a pages field that is not a page range; an entry with no record;
a duplicated key; a core citation whose full text is still pending; and, with --citations, a usable
checklist row with no entry in the list.

With --qmd, only the keys cited in the manuscript (and its {{< include >}} files) are written, so the
list can keep candidate sources that the draft does not cite.
"""
import csv
import os
import re
import shutil
import subprocess
import sys
from datetime import date

args = sys.argv[1:]
if len(args) < 2 or args[0].startswith("--"):
    sys.exit(__doc__)
md_path, out_path = args[0], args[1]


def opt(flag, default=None):
    if flag in args:
        i = args.index(flag)
        return True if flag == "--check" else args[i + 1]
    return default


cit_path = opt("--citations")
fixes_path = opt("--fixes", os.path.join(os.path.dirname(md_path) or ".", "reference-fixes.md"))
qmd_path = opt("--qmd")
do_check = bool(opt("--check", False))

BIB_FIELDS = ["author", "editor", "title", "journal", "booktitle", "publisher", "address", "series",
              "edition", "institution", "school", "year", "volume", "number", "pages", "doi", "url", "note"]
TYPES = {"article", "book", "incollection", "inproceedings", "misc", "techreport", "phdthesis",
         "mastersthesis", "manual", "unpublished"}


# ---- parse references.md -------------------------------------------------------------------
def parse_md(path):
    """Returns the file's lines and the entries as (key, heading line index, fields)."""
    lines = open(path, encoding="utf-8").read().split("\n")
    entries, cur, in_comment = [], None, False
    for i, line in enumerate(lines):
        if in_comment:
            in_comment = "-->" not in line
            continue
        if "<!--" in line:
            in_comment = "-->" not in line.split("<!--", 1)[1]
            continue
        h = re.match(r"^###\s+`?([A-Za-z][\w:.-]*)`?\s*$", line)
        if h:
            cur = (h.group(1), i, {})
            entries.append(cur)
            continue
        if line.startswith("#"):
            cur = None
            continue
        f = re.match(r"^\s*[-*]\s+([a-z_]+)\s*:\s*(.*?)\s*$", line)
        if cur and f and f.group(2):
            cur[2][f.group(1)] = f.group(2)
    return lines, entries


def strip_braces(s):
    return re.sub(r"[{}]", "", s or "")


def initials(given):
    out = []
    for p in given.split():
        if len(p) <= 2 and p.endswith("."):
            out.append(p)
        else:
            out.append("-".join(x[0] + "." for x in p.split("-") if x))
    return " ".join(out)


def apa_authors(field):
    names = [a.strip() for a in field.split(" and ") if a.strip()]
    fmt = []
    for n in names:
        if "," in n:
            fam, given = [x.strip() for x in n.split(",", 1)]
            fmt.append(f"{strip_braces(fam)}, {initials(strip_braces(given))}" if given else strip_braces(fam))
        else:
            fmt.append(strip_braces(n))  # an organization
    if len(fmt) > 20:
        fmt = fmt[:19] + ["...", fmt[-1]]
    if len(fmt) <= 1:
        return "".join(fmt)
    return ", ".join(fmt[:-1]) + ", & " + fmt[-1]


def formatted(f):
    """A readable APA-like citation for the user's review."""
    who = apa_authors(f.get("author", "")) or apa_authors(f.get("editor", "")) or "[no author]"
    s = f"{who} ({f.get('year', 'n.d.')}). {strip_braces(f.get('title', '[no title]')).rstrip('.')}."
    typ = f.get("type", "article")
    if typ == "article":
        s += f" *{f.get('journal', '[no journal]')}*"
        if f.get("volume"):
            s += f", {f['volume']}"
            if f.get("number"):
                s += f"({f['number']})"
        if f.get("pages"):
            s += f", {f['pages']}"
        s += "."
    elif typ in ("incollection", "inproceedings"):
        s += f" In *{strip_braces(f.get('booktitle', ''))}*"
        s += f" (pp. {f['pages']})." if f.get("pages") else "."
        if f.get("publisher"):
            s += f" {f['publisher']}."
    else:
        src = f.get("publisher") or f.get("institution") or f.get("school") or f.get("note")
        if src:
            s += f" {src}."
    if f.get("doi") and f["doi"].lower() != "none":
        s += f" https://doi.org/{f['doi']}"
    elif f.get("url"):
        s += f" {f['url']}"
    return s


def cited_keys(qmd):
    # @key, [@key], [-@key] in the qmd and in the files it includes
    text = open(qmd, encoding="utf-8").read()
    for inc in re.findall(r"\{\{<\s*include\s+([^\s>]+)\s*>\}\}", text):
        p = os.path.join(os.path.dirname(qmd), inc)
        if os.path.exists(p):
            text += "\n" + open(p, encoding="utf-8").read()
    text = re.sub(r"[\w.+-]+@[\w-]+\.[\w.]+", " ", text)
    keys = set(re.findall(r"@([A-Za-z][\w:.-]*?)(?=[\s;,\]\.\)\"\'])", text))
    return {k for k in keys if not re.match(r"(fig|tbl|eq|sec|sfig|stbl)-", k)}


lines, entries = parse_md(md_path)
fixes, seen = [], set()
for key, _, _ in entries:
    if key in seen:
        fixes.append((key, "key", "the key appears twice; give each source one entry"))
    seen.add(key)

checklist = {}
if cit_path and os.path.exists(cit_path):
    rows = list(csv.DictReader(open(cit_path, encoding="utf-8")))
    checklist = {r["key"]: r for r in rows if r.get("key")}
    for r in rows:
        if r.get("usable", "").strip().lower() == "yes" and r.get("key") and r["key"] not in seen:
            fixes.append((r["key"], "entry", "usable in citations.csv but has no entry in references.md"))

keep = cited_keys(qmd_path) if qmd_path else None

# ---- faults --------------------------------------------------------------------------------
for key, _, f in entries:
    typ = f.get("type", "article")
    if typ not in TYPES:
        fixes.append((key, "type", f"unknown type '{typ}'; use one of {', '.join(sorted(TYPES))}"))
    for need in ("title", "year"):
        if not f.get(need):
            fixes.append((key, need, "missing"))
    if not f.get("author") and not f.get("editor"):
        fixes.append((key, "author", "missing"))
    if typ == "article":
        if not f.get("journal"):
            fixes.append((key, "journal", "missing"))
        elif f["journal"] == f["journal"].lower():
            fixes.append((key, "journal", f"lower case ('{f['journal']}'); write it as the journal does"))
        if not f.get("doi"):
            fixes.append((key, "doi", "missing; add it from the publisher's page, or write 'doi: none' if it has none"))
    if len([a for a in f.get("author", "").split(" and ") if a.strip()]) == 10:
        fixes.append((key, "author", "exactly ten authors, often a cut list; check against the article"))
    pages = f.get("pages", "")
    if pages and not re.fullmatch(r"[A-Za-z]?\d+[A-Za-z]?(\s*-+\s*[A-Za-z]?\d+[A-Za-z]?)?", pages):
        fixes.append((key, "pages", f"'{pages}' does not look like a page range or an article number"))
    if not f.get("record"):
        fixes.append((key, "record", "missing: say where the fields were copied from, and the date"))
    row = checklist.get(key, {})
    if row.get("grade", "").strip() == "core" and (
            f.get("full_text", "").strip().lower() in ("", "pending", "abstract only")
            or row.get("pdf", "").strip().lower() == "pending"):
        fixes.append((key, "full_text", "core citation without its full text; find an open copy or ask the user for the PDF"))

# ---- write the bib -------------------------------------------------------------------------
out_entries = sorted(((k, f) for k, _, f in entries if keep is None or k in keep), key=lambda e: e[0].lower())
bib = [f"% references.bib generated {date.today()} by build-bib.py from {os.path.basename(md_path)}.",
       "% Do not edit this file: correct the entry in references.md and rerun build-bib.py.", ""]
for key, f in out_entries:
    bib.append(f"@{f.get('type', 'article')}{{{key},")
    for k in BIB_FIELDS:
        if k not in f or f[k].strip().lower() == "none":
            continue
        if k == "url" and f.get("doi", "none").lower() != "none":
            continue
        v = re.sub(r"\s*-+\s*", "--", f[k]) if k == "pages" else f[k]
        bib.append(f"  {k} = {{{v}}},")
    bib[-1] = bib[-1].rstrip(",")
    bib.append("}\n")
open(out_path, "w", encoding="utf-8").write("\n".join(bib))

# ---- rewrite the readable line under each heading ------------------------------------------
heads = {idx: f for _, idx, f in entries}
new_lines, i = [], 0
while i < len(lines):
    new_lines.append(lines[i])
    if i not in heads:
        i += 1
        continue
    j = i + 1
    while j < len(lines) and not lines[j].strip():
        j += 1
    if j < len(lines) and lines[j].startswith("> "):
        j += 1
        while j < len(lines) and not lines[j].strip():
            j += 1
    new_lines += ["", "> " + formatted(heads[i]), ""]
    i = j
open(md_path, "w", encoding="utf-8").write("\n".join(new_lines))

# ---- write the fixes -----------------------------------------------------------------------
fx = [f"# Reference list fixes ({date.today()})", "",
      "Each row is a correction to make in `references.md`, never in `references.bib`. Rerun build-bib.py "
      "after fixing; this file is rewritten on every run and should end up empty.", "",
      "| Key | Field | What to change |", "|---|---|---|"]
fx += [f"| `{key}` | {fld} | {what} |" for key, fld, what in fixes] or ["| | | none |"]
open(fixes_path, "w", encoding="utf-8").write("\n".join(fx) + "\n")

print(f"wrote {len(out_entries)} entries to {out_path}; {len(fixes)} faults in {fixes_path}")

# ---- optional citeproc check ----------------------------------------------------------------
if do_check and out_entries:
    test_md = os.path.join(os.path.dirname(os.path.abspath(out_path)), ".bib-check.md")
    open(test_md, "w", encoding="utf-8").write("---\nbibliography: " + os.path.basename(out_path) + "\n---\n\n" +
                                              " ".join(f"[@{k}]" for k, _ in out_entries) + "\n\n# References\n")
    cmd = ["quarto", "pandoc"] if shutil.which("quarto") else ["pandoc"]
    res = subprocess.run(cmd + [test_md, "--citeproc", "-t", "plain"], capture_output=True, text=True,
                         cwd=os.path.dirname(os.path.abspath(out_path)))
    os.remove(test_md)
    warn = [l for l in (res.stderr or "").splitlines() if "WARNING" in l or "ERROR" in l]
    print("citeproc: " + ("no warnings" if not warn and res.returncode == 0
                          else "\n  " + "\n  ".join(warn or [res.stderr.strip()])))
