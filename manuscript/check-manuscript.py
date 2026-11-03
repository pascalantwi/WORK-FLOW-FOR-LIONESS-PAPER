"""Check a manuscript draft against the rules in workflow/03-manuscript.md.

Usage:
  python3 -I check-manuscript.py manuscript.qmd manuscript.html
          [--citations citations.csv] [--bib references.bib]
          [--journals workflow/journals/journals.csv --journal <slug>] [--final | --memo]

Exit status is 1 if any ERROR is found. WARN lines need a human look. INFO lines are counts.
The checker reads the qmd for what was written and the HTML for what rendered. It ignores the
draft apparatus (the banner, the gap table, the marker table: fenced divs with class "apparatus").
It cannot judge tension, whether the estimand is a functional, or whether a passage supports its
sentence; a person does that.
"""
import csv
import html as htmlmod
import re
import sys

# ---- arguments ---------------------------------------------------------------------------
args = sys.argv[1:]
if len(args) < 2:
    sys.exit(__doc__)
qmd_path, html_path = args[0], args[1]
def opt(flag, default=None):
    if flag in args:
        i = args.index(flag)
        return True if flag in ("--final", "--memo") else args[i + 1]
    return default
cit_path = opt("--citations"); bib_path = opt("--bib"); journals_path = opt("--journals"); journal = opt("--journal")
final = bool(opt("--final", False))
memo = bool(opt("--memo", False))   # the memo of a study not carried further: pilot numbers without marks, no markers, no journal
mode = "memo" if memo else "final" if final else "draft"

import os as _os
qmd = open(qmd_path, encoding="utf-8").read()
page = open(html_path, encoding="utf-8").read()
errors, warns, info = [], [], []
if _os.path.getmtime(html_path) < _os.path.getmtime(qmd_path):
    print("ERROR: the rendered HTML is older than the qmd; render first, then check")
    sys.exit(1)

# ---- the qmd: body without YAML, chunks, comments; inline R and math tracked ----------------
body = re.sub(r"\A---\n.*?\n---\n", "", qmd, count=1, flags=re.S)
body = re.sub(r"<!--.*?-->", "", body, flags=re.S)
import os
def _expand_includes(text, base):
    def rep(m):
        path = os.path.join(base, m.group(1).strip())
        try:
            return open(path, encoding="utf-8").read()
        except OSError:
            return ""
    return re.sub(r"\{\{<\s*include\s+([^>]+?)\s*>\}\}", rep, text)
body = _expand_includes(body, os.path.dirname(os.path.abspath(qmd_path)))
body = re.sub(r"<!--.*?-->", "", body, flags=re.S)   # comments inside included files too
chunks = re.findall(r"```\{r[^\n]*\}\n(.*?)```", body, flags=re.S)
prose = re.sub(r"```\{r[^\n]*\}\n.*?```", "\n", body, flags=re.S)           # prose with chunks removed
prose = re.sub(r"\{\{<\s*include[^>]*>\}\}", "", prose)
prose_no_markers = re.sub(r"\[(TO CONFIRM|CITE|FILL)[^\]]*\](\{\.[a-z]+\})?", " ", prose)
prose_plain = re.sub(r"`r [^`]*`", " INLINE ", prose_no_markers)              # inline R replaced
prose_plain = re.sub(r"\$\$.*?\$\$", " MATH ", prose_plain, flags=re.S)
prose_plain = re.sub(r"\$[^$\n]+\$", " MATH ", prose_plain)
prose_plain = re.sub(r"`[^`\n]+`", " CODE ", prose_plain)
prose_plain = re.sub(r"@(fig|tbl|eq|sec|sfig|stbl)-[\w-]+", " XREF ", prose_plain)
prose_plain = re.sub(r"\[?-?@[A-Za-z][\w:.-]*(;\s*-?@[A-Za-z][\w:.-]*)*(,[^\]]*)?\]?", " CITE ", prose_plain)
prose_plain = re.sub(r"^#+ .*$", "", prose_plain, flags=re.M)

# sections of the prose, by top-level heading
def sections(text):
    out, name, buf = [], "(front)", []
    for line in text.splitlines():
        m = re.match(r"^# (.*?)\s*(\{[^}]*\})?\s*$", line)
        if m:
            out.append((name, "\n".join(buf))); name, buf = m.group(1).strip(), []
        else:
            buf.append(line)
    out.append((name, "\n".join(buf)))
    return out
secs = sections(prose)
def sec_text(pattern):
    return "\n".join(t for n, t in secs if re.search(pattern, n, flags=re.I))
def plainify(text):
    text = re.sub(r"\[(TO CONFIRM|CITE|FILL)[^\]]*\](\{\.[a-z]+\})?", " ", text)
    text = re.sub(r"`r [^`]*`", " INLINE ", text)
    text = re.sub(r"\$\$.*?\$\$", " MATH ", text, flags=re.S)
    text = re.sub(r"\$[^$\n]+\$", " MATH ", text)
    text = re.sub(r"`[^`\n]+`", " CODE ", text)
    text = re.sub(r"@(fig|tbl|eq|sec|sfig|stbl)-[\w-]+", " XREF ", text)
    return text

# results-like sections: any heading at any level whose title contains "Results"
def heading_sections(text, pattern):
    """Text under every heading (any level) matching pattern, up to the next heading of the same or higher level."""
    lines = text.splitlines(); out = []; i = 0
    while i < len(lines):
        m = re.match(r"^(#+) (.*)$", lines[i])
        if m and re.search(pattern, m.group(2), flags=re.I):
            level = len(m.group(1)); j = i + 1
            while j < len(lines):
                m2 = re.match(r"^(#+) ", lines[j])
                if m2 and len(m2.group(1)) <= level: break
                j += 1
            out.append("\n".join(lines[i + 1:j])); i = j
        else:
            i += 1
    return "\n".join(out)
results_text = heading_sections(prose, r"^Results")
methods_text = sec_text(r"^Methods")
abstract_text = sec_text(r"^Abstract")

# ---- the HTML: visible text, apparatus and TOC removed ----------------------------------------
visible = re.sub(r"<script.*?</script>|<style.*?</style>", "", page, flags=re.S)
own_html = re.sub(r'<nav id="TOC".*?</nav>', "", visible, flags=re.S)
own_html = re.sub(r'<div class="apparatus">.*?</div>\s*', "", own_html, flags=re.S)
own_html = re.sub(r'<header id="title-block-header".*?</header>', "", own_html, flags=re.S)
own_html = re.sub(r'<div id="refs".*?</div>\s*</div>', "", own_html, flags=re.S)   # the reference list: citeproc's dashes are not the paper's
# numeric in-text citations: citeproc writes a range such as [14-16] with an en dash (fixed in the SS1 copy)
own_html = re.sub(r'<span class="citation"[^>]*>.*?</span>', " CITE ", own_html, flags=re.S)
own = re.sub(r"\s+", " ", htmlmod.unescape(re.sub(r"<[^>]+>", " ", own_html)))

# ---- leftovers and broken references ----------------------------------------------------------
n_fill = None   # counted below, on the qmd plus its included parts, comments removed
if False:
    errors.append(f"{n_fill} unfilled [FILL] slots in the qmd")
if "?@" in own:
    errors.append("unresolved cross-reference (?@) in the rendered text")
if re.search(r"\[\^[A-Za-z0-9_-]+\]", own):
    errors.append("unresolved footnote marker in the rendered text")
if "`r " in own:
    errors.append("inline R was not evaluated (a backtick-r fragment is in the rendered text)")
if re.search("[—–]", own):
    errors.append("em or en dash in the rendered text")
if re.search(r"\d\.?\s*(NaN|NA)\b|\bNaN\b", own):
    warns.append("NaN or NA appears in the rendered text")

# ---- markers ------------------------------------------------------------------------------------
# markers are counted the way marker_scan() counts them: every line of the qmd (YAML and chunks included) plus included files
_whole = qmd + "".join(open(_os.path.join(_os.path.dirname(_os.path.abspath(qmd_path)), f.strip()), encoding="utf-8").read()
                        for f in re.findall(r"\{\{<\s*include\s+([^>]+?)\s*>\}\}", qmd) if _os.path.exists(_os.path.join(_os.path.dirname(_os.path.abspath(qmd_path)), f.strip())))
_whole = re.sub(r"<!--.*?-->", "", _whole, flags=re.S)   # instruction comments do not count
bare = re.findall(r"\[(TO CONFIRM|CITE)[^\]]*\](?!\{\.(tc|cite)\})", _whole)
if bare:
    errors.append(f"{len(bare)} marker(s) written without their span: use [TO CONFIRM: ...]{{.tc}} and [CITE: ...]{{.cite}}")
n_fill = len(re.findall(r"\[FILL", _whole))
if n_fill:
    errors.append(f"{n_fill} unfilled [FILL] slots in the qmd or its included parts")
n_tc = len(re.findall(r"\[TO CONFIRM", _whole)); n_cite = len(re.findall(r"\[CITE", _whole))
r_tc = len(re.findall(r'class="tc"', page)); r_cite = len(re.findall(r'class="cite"', page))
info.append(f"markers: {n_tc} to confirm, {n_cite} claims without a source, {n_fill} unfilled (in the source); rendered: {r_tc} to confirm, {r_cite} without a source")
if (final or memo) and (n_tc or n_cite or n_fill):
    errors.append(f"{mode} mode: markers remain")

# ---- hand-typed numbers ---------------------------------------------------------------------------
def number_hits(text):
    hits = []
    for m in re.finditer(r"(?<![\w.-])(\d+\.\d+%?|\d+%|\d{3,})(?![\w.-])", text):
        tok = m.group(1)
        if re.fullmatch(r"(19|20)\d\d", tok):
            continue
        hits.append(tok)
    return hits
hits_results = number_hits(plainify(results_text)) + number_hits(plainify(sec_text(r"^Application")))
hits_all = number_hits(prose_plain)
if hits_results:
    errors.append(f"hand-typed numbers in Results or Application prose: {', '.join(hits_results[:12])}" + (" ..." if len(hits_results) > 12 else ""))
elif hits_all:
    warns.append(f"digits typed in the prose outside Results (design levels are allowed if they also live in results/): {', '.join(hits_all[:12])}")

# ---- citations ------------------------------------------------------------------------------------
# citations in prose and in R chunks (a table built in R may cite), excluding e-mail addresses
_cite_src = prose + "\n" + "\n".join(c for c in chunks)
_cite_src = re.sub(r"[\w.+-]+@[\w-]+\.[\w.]+", " ", _cite_src)
cited = sorted(set(re.findall(r"@([A-Za-z][\w:.-]*?)(?=[\s;,\]\.\)\"\'])", _cite_src)) - {"fig", "tbl", "eq", "sec"})
cited = [k for k in cited if not re.match(r"(fig|tbl|eq|sec|sfig|stbl)-", k)]
bib_keys = set()
if bib_path:
    bib_keys = set(re.findall(r"^@\w+\{([^,]+),", open(bib_path, encoding="utf-8").read(), flags=re.M))
    missing = [k for k in cited if k not in bib_keys]
    if missing:
        errors.append(f"cited keys missing from the bib: {', '.join(missing)}")
    unused = sorted(bib_keys - set(cited))
    if unused:
        warns.append(f"bib entries never cited: {', '.join(unused)}")
if cit_path:
    rows = {r["key"]: r for r in csv.DictReader(open(cit_path, encoding="utf-8"))}
    no_row = [k for k in cited if k not in rows]
    if no_row:
        errors.append(f"cited keys with no row in the checklist: {', '.join(no_row)}")
    not_usable = [k for k in cited if k in rows and rows[k].get("usable", "").strip().lower() != "yes"]
    if not_usable:
        errors.append(f"cited keys the checklist marks not usable: {', '.join(not_usable)}")
    no_passage = [k for k in cited if k in rows and not rows[k].get("support_passage", "").strip()]
    if no_passage:
        errors.append(f"cited keys with no supporting passage (or 'definitional') in the checklist: {', '.join(no_passage)}")
    bad_id = [k for k, r in rows.items() if not r.get("identifier", "").strip()]
    if bad_id:
        errors.append(f"checklist rows whose identifier is neither filled nor 'none': {', '.join(bad_id)}")
    n_def = sum(1 for k in cited if k in rows and rows[k].get("support_passage", "").strip().lower() == "definitional")
    info.append(f"citations: {len(cited)} distinct keys, {n_def} definitional, {len(cited) - n_def} passage-backed")
else:
    info.append(f"citations: {len(cited)} distinct keys (no checklist given)")
in_results = re.findall(r"@[A-Za-z][\w:.-]*", re.sub(r"@(fig|tbl|eq|sec)-[\w-]+", "", results_text))
if in_results:
    errors.append(f"literature citations inside Results: {', '.join(sorted(set(in_results)))}")

# ---- figures and tables referenced ----------------------------------------------------------------
labels = []
for m in re.finditer(r"```\{r[^\n]*\}\n(.*?)```", body, flags=re.S):
    opts = m.group(1)
    lab = re.search(r"#\|\s*label:\s*((fig|tbl)-[\w-]+)", opts)
    if lab and not re.search(r"#\|\s*eval:\s*false", opts):
        labels.append(lab.group(1))
refs = set(re.findall(r"@((?:fig|tbl)-[\w-]+)", prose))
unref = [l for l in labels if l not in refs]
if unref:
    errors.append(f"figures or tables never referenced in the text: {', '.join(unref)}")
# Supplementary floats are fenced divs with ids sfig-... and stbl-... (Figure S1, Table S1), referenced as @sfig-...
sdivs = re.findall(r"^:::\s*\{#((?:sfig|stbl)-[\w-]+)\}", body, flags=re.M)
srefs = set(re.findall(r"@((?:sfig|stbl)-[\w-]+)", prose))
sunref = [l for l in sdivs if l not in srefs]
if sunref:
    errors.append(f"supplementary figures or tables never referenced in the text: {', '.join(sunref)}")

# ---- voice and style --------------------------------------------------------------------------------
own_prose = re.sub(r"\\\(.*?\\\)|\\\[.*?\\\]", " ", own)
own_prose = re.sub(r"\b(phase|type|class|stage|Table|Figure|Part|Type|Phase) I\b|Moran['’]s I\b", " ", own_prose)
if re.search(r"\bI\b(?!\.)|\bI'|\bmy\b|\bmine\b", own_prose):
    errors.append("first person singular in the paper's own text")
for n, t in secs:
    if re.search(r"^Abstract", n, flags=re.I):
        continue
    for para in re.split(r"\n\s*\n", t):
        p = para.strip()
        if re.match(r"^\*\*[^*]+\*\*[.:]", p):
            errors.append(f"bold lead-in in section '{n}': {p[:60]!r}")
            break
wf = re.findall(r"\b(harness(?: checks?)?|pilots?|re-pilots?|cards?|workers?|quick runs?|specs?|the report|too small to matter|pre-?registered|pre-?registrations?|pass rules?)\b", prose_plain, flags=re.I)
if wf:
    errors.append(f"workflow words in the paper's own text: {', '.join(sorted(set(w.lower() for w in wf)))}")
delete_words = ["considerably", "dramatically", "enormously", "exceptionally", "extremely", "highly", "quite", "remarkably",
                "substantially", "very", "actually", "basically", "clearly", "essentially", "in fact", "indeed", "just",
                "kind of", "of course", "really", "simply", "sort of", "certainly", "obviously", "undoubtedly", "important",
                "interesting", "notable", "remarkable", "considerable", "major", "minor", "substantial"]
justify_words = ["apparently", "arguably", "can", "conceivably", "could", "maybe", "may", "might", "perhaps", "potentially",
                 "possibly", "presumably", "probably", "likely", "seemingly", "would", "commonly", "frequently", "generally", "largely", "mostly",
                 "often", "rarely", "typically", "usually"]
low = own_prose.lower()
found = {w: len(re.findall(r"\b" + re.escape(w) + r"\b", low)) for w in delete_words}
found = {w: n for w, n in found.items() if n}
if found:
    warns.append("delete-on-sight words: " + ", ".join(f"{w} ({n})" for w, n in sorted(found.items(), key=lambda x: -x[1])))
found = {w: len(re.findall(r"\b" + re.escape(w) + r"\b", low)) for w in justify_words}
found = {w: n for w, n in found.items() if n}
if found:
    warns.append("words to justify or replace: " + ", ".join(f"{w} ({n})" for w, n in sorted(found.items(), key=lambda x: -x[1])))
n_not = len(re.findall(r",\s*not\s+\w", own_prose)) + len(re.findall(r"\bnot\s+[^,.;]{1,40},\s*(but|rather)\b", own_prose))
if n_not > 5:
    warns.append(f"{n_not} 'not X, Y' constructions; the conventions ask not to lean on them")
for w in ("trustworthy", "valid", "correct", "safe", "reliable"):
    n = len(re.findall(r"\b" + w + r"\b", low))
    if n:
        warns.append(f"evaluative word '{w}' used {n} time(s): say what it refers to")
if re.search(r"\bstatistic\b(?:\W+\w+){0,6}\W+estimand\b|\bestimand\b(?:\W+\w+){0,6}\W+statistic\b", low):
    warns.append("'statistic' within six words of 'estimand': check the vocabulary (a statistic is never an estimand)")
if re.search(r"\d+(\.\d+)?\s*%", plainify(methods_text)):
    warns.append("a percentage in Methods: a result may have strayed there")

# ---- tables with equal widths ----------------------------------------------------------------------
for m in re.finditer(r"<table.*?</table>", own_html, flags=re.S):
    cols = [int(c) for c in re.findall(r'<col style="width: (\d+)%', m.group(0))]
    if len(cols) >= 2 and max(cols) - min(cols) <= 2:
        first = re.sub(r"<[^>]+>", " ", m.group(0))[:60].strip()
        warns.append(f"table with equal-width columns {cols}: set widths in proportion to the text ({first!r})")

# ---- provenance ---------------------------------------------------------------------------------------
n_pilot = len(re.findall(r'class="prov-pilot"', page)); n_quick = len(re.findall(r'class="prov-quick"', page))
info.append(f"labeled numbers rendered: {n_pilot} pilot, {n_quick} quick (production numbers carry no mark)")
for _n, _t in sections(prose_plain):
    if re.search(r"^(Abstract|Introduction)", _n):
        _sents = [x for x in re.split(r"(?<=[.!?])\s+(?=[A-Z])", re.sub(r"\*\*[^*]+\*\*\s*", "", _t.strip())) if x.strip()]
        _long = [x for x in _sents if len(x.split()) > 35]
        _semi = [x for x in _sents if re.search(r";\s+[a-z]", x)]
        if _long:
            warns.append(f"{len(_long)} sentence(s) over 35 words in {_n}: split into the simple sentences they were built from ({_long[0][:70]!r})")
        if _semi:
            warns.append(f"{len(_semi)} sentence(s) joining clauses with a semicolon in {_n}: usually two sentences ({_semi[0][:70]!r})")
_caps = re.findall(r"^#\|\s*(?:fig|tbl)-cap:\s*\"(.*)\"\s*$", qmd, flags=re.M)
_capd = [x for x in _caps if re.search(r"\d", re.sub(r"\b[A-Za-z]+\d+(\.\d+)?\b", "", x))]   # a label such as S1 or S1.4 is not a number
if _capd:
    warns.append(f"{len(_capd)} caption(s) with typed digits: build the caption in the setup chunk and pass it with !expr ({_capd[0][:70]!r})")
    if re.search(r"^(Abstract|Introduction)", _n):
        _first = re.split(r"(?<=[.!?])\s+(?=[A-Z])", re.sub(r"\*\*[^*]+\*\*\s*", "", _t.strip()), maxsplit=1)[0]
        _nw = len(_first.split())
        if _nw > 30:
            warns.append(f"the first sentence of {_n} has {_nw} words: open with one idea in a simple sentence, up to three for a complex topic")
if re.search(r'tbl-cap:\s*"Notation', qmd):
    errors.append("a table of notation: define each symbol in the sentence or equation that introduces it instead")
if not re.search(r"`r\s+(prov|fpc|fint|range_mcse|lvl)\(", abstract_text):
    warns.append("the Abstract carries no computed number: every claim needs a numeric result with its uncertainty, through prov()")
if final and (n_pilot or n_quick):
    errors.append("final mode: numbers not labeled production remain")
if memo and (n_pilot or n_quick):
    errors.append("memo mode: highlighted numbers remain; render with -P draft:false -P memo:true")

# ---- journal limits -----------------------------------------------------------------------------------
def words(t): return len(re.findall(r"\b\w+\b", t))
html_secs = re.split(r"<h1[^>]*>", own_html)
sec_words = {}
for s in html_secs[1:]:
    name = re.sub(r"<[^>]+>", "", s.split("</h1>")[0]).strip()
    name = re.sub(r"^\d+(\.\d+)*\s*", "", name)
    txt = re.sub(r"\s+", " ", htmlmod.unescape(re.sub(r"<[^>]+>", " ", s.split("</h1>", 1)[1])))
    sec_words[name] = words(txt)
info.append("words per section: " + ", ".join(f"{k} {v}" for k, v in sec_words.items()))
if memo:
    info.append("memo mode: no journal limits apply")
elif journals_path and journal:
    rows = [r for r in csv.DictReader(open(journals_path, encoding="utf-8")) if r.get("slug") == journal]
    if not rows:
        warns.append(f"journal slug '{journal}' not found in {journals_path}")
    else:
        prof = rows[0]
        aw = re.search(r"\d+", prof.get("abstract_words", "") or "")
        a_words = sec_words.get("Abstract", words(plainify(abstract_text)))
        if aw and a_words > int(aw.group(0)):
            warns.append(f"abstract has {a_words} words; {prof['journal']} allows {aw.group(0)}")
        lw = re.search(r"(\d[\d,]*)\s*words", prof.get("length_limit", "") or "")
        body_words = sum(v for k, v in sec_words.items() if not re.search(r"^(References|Abstract)", k))
        if lw and body_words > int(lw.group(1).replace(",", "")):
            warns.append(f"body has {body_words} words; {prof['journal']} states a limit of {lw.group(1)} words")
        info.append(f"journal {prof['journal']}: abstract {prof.get('abstract_format', '')}; length: {prof.get('length_limit', '') or 'not stated by the journal'}")

# ---- counts ------------------------------------------------------------------------------------------
info.append(f"{page.count('<img')} images, {len(re.findall(r'<table', own_html))} tables, {len(labels)} figure or table chunks, {len(sdivs)} supplementary floats")

for label, items in (("ERROR", errors), ("WARN", warns), ("INFO", info)):
    for it in items:
        print(f"{label}: {it}")
if not errors and not warns:
    print("OK: no errors or warnings")
sys.exit(1 if errors else 0)
