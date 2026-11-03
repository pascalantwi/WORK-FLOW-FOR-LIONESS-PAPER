"""Check a rendered pilot report against the report rules.

Usage: python3 -I check-report.py pilot-report.qmd pilot-report.html

Exit status is 1 if any ERROR is found. WARN lines need a human look.
"""
import html
import os
import re
import sys

qmd_path, html_path = sys.argv[1], sys.argv[2]
qmd = open(qmd_path, encoding="utf-8").read()
page = open(html_path, encoding="utf-8").read()

errors, warns, info = [], [], []

visible = re.sub(r"<script.*?</script>|<style.*?</style>", "", page, flags=re.S)
text = re.sub(r"\s+", " ", html.unescape(re.sub(r"<[^>]+>", " ", visible)))

# Required sections (headings as rendered).
heads = [re.sub(r"\s+", " ", html.unescape(re.sub(r"<[^>]+>", "", h))).strip()
         for h in re.findall(r"<h[1-3][^>]*>.*?</h[1-3]>", page, flags=re.S)]
required = ["Summary", "In plain language", "Application", "In symbols", "Critiquing the model",
            "Design", "Known-answer checks", "How to read the outputs", "Numbered findings",
            "The draft spec", "Decisions log", "Action items and limitations"]
for r in required:
    if not any(h.startswith(r) for h in heads):
        errors.append(f"missing section: {r}")

# The report's own text: without the table of contents and without the spec and the decisions log,
# which are the agent's documents and keep their own wording and table widths.
own_html = re.sub(r'<nav id="TOC".*?</nav>', '', visible, flags=re.S)   # the TOC repeats the agent's headings
a = own_html.find('id="draft-spec"')
b = own_html.find('id="action-items-and-limitations"')
if 0 <= a < b:
    own_html = own_html[:a] + own_html[b:]
own = re.sub(r"\s+", " ", html.unescape(re.sub(r"<[^>]+>", " ", own_html)))

# Leftovers and broken references.
n_fill = qmd.count("[FILL")
if n_fill:
    errors.append(f"{n_fill} unfilled [FILL] placeholders in the qmd")
if "?@" in text:
    errors.append("unresolved cross-reference (?@) in the rendered text")
if re.search(r"\[\^[A-Za-z0-9_-]+\]", text):
    errors.append("unresolved footnote marker in the rendered text")
if "`r " in text:
    errors.append("inline R code was not evaluated (a backtick-r fragment is in the rendered text)")
if re.search(r"\d+\.\d*\s*(NaN|NA)\b|\bNaN\b", own):
    warns.append("NaN or NA appears in the rendered text")

# Writing rules, checked on the report's own text. The spec and the decisions log are the
# agent's documents and are excluded from the first-person check.
if re.search("[\u2014\u2013]", text):
    errors.append("em or en dash in the rendered text")
own_prose = re.sub(r"\\\(.*?\\\)|\\\[.*?\\\]", " ", own)              # drop rendered math
own_prose = re.sub(r"\b(phase|type|class|stage|Table|Figure|Part|Type|Phase) I\b|Moran['\u2019]s I\b", " ", own_prose)
if re.search(r"\bI\b(?!\.)|\bI'", own_prose):
    warns.append("first person ('I') in the report's own text")
for phrase in ("not proved", "unproven", "survive", "quietly"):
    if phrase in own_prose.lower():
        warns.append(f"vague phrasing {phrase!r} in the report's own text: say concretely what is known or unknown (see README, Concrete wording)")
if "callout" in qmd and re.search(r"^:::\s*\{\.callout", qmd, flags=re.M):
    warns.append("callout used: uncertainty callouts are not wanted; keep only if essential")

# Tables: hand-set widths, not equal splits.
for m in re.finditer(r"<table.*?</table>", own_html, flags=re.S):
    cols = [int(c) for c in re.findall(r'<col style="width: (\d+)%', m.group(0))]
    if len(cols) >= 2 and max(cols) - min(cols) <= 2:
        first = re.sub(r"<[^>]+>", " ", m.group(0))[:60].strip()
        warns.append(f"table with equal-width columns {cols}: set widths in proportion to the text ({first!r})")

# Figures, footnotes, markers.
n_img = page.count("<img")
if n_img < 3:
    warns.append(f"only {n_img} images: need a design figure, an idea figure, and a pilot figure")
n_fn = len(re.findall(r'<li id="fn\d+"', page))
info.append(f"{n_fn} footnotes, {n_img} images, {len(heads)} headings")
if n_fn < 5:
    warns.append("fewer than 5 footnotes: check that non-statistical jargon is defined")
# The spec sits at the project root, the parent of the folder that holds the qmd.
spec_path = os.path.normpath(os.path.join(os.path.dirname(os.path.abspath(qmd_path)), "..", "project-spec.md"))
if os.path.isfile(spec_path):
    n_tc_src = len(re.findall(r"\[TO CONFIRM", open(spec_path, encoding="utf-8").read()))
else:
    n_tc_src = None
    warns.append(f"project-spec.md not found at {spec_path}: the TO CONFIRM check was skipped")
n_tc_html = page.count('class="tc"')
info.append(f"{n_tc_html} highlighted TO CONFIRM items" + (f" (spec has {n_tc_src})" if n_tc_src is not None else ""))
if n_tc_src is not None and n_tc_src != n_tc_html:
    errors.append("highlighted TO CONFIRM items do not match the spec")

# Critique table must not talk about the pilot.
i = text.find("Feature of the model")
j = text.find("Methods", i) if i >= 0 else -1
if i >= 0 and j > i:
    seg = text[i:j]
    if re.search(r"\bpilot\b|\bagent\b|first attempt", seg, flags=re.I):
        warns.append("critique table mentions the pilot or the agent: it should say what should be checked")

for label, items in (("ERROR", errors), ("WARN", warns), ("INFO", info)):
    for it in items:
        print(f"{label}: {it}")
if not errors and not warns:
    print("OK: no errors or warnings")
sys.exit(1 if errors else 0)
