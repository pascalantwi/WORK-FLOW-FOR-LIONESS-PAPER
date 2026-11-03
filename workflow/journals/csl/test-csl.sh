#!/bin/sh
# Renders the two-entry test document with every CSL file in this folder and
# writes the results to test-results.md. Run from anywhere:
#   sh pilots/manuscript-template/journals/csl/test-csl.sh
# A style passes when pandoc exits cleanly, prints no warning, and the output
# contains both first authors' surnames and both years.
# Dependent styles (the journal-named files in dependent/, which point to a parent) need a
# network connection, because pandoc fetches the parent from zotero.org.

cd "$(dirname "$0")" || exit 1
out=test-results.md
pv=$(quarto pandoc --version | head -1)
today=$(date +%Y-%m-%d)
{
  echo "# CSL rendering test"
  echo
  echo "Run on $today with $pv (through \`quarto pandoc\`), on the two-entry bibliography in \`test/test.bib\`."
  echo "A style passes when pandoc prints no warning and the output has both surnames (in any case, since some styles use small capitals) and both years."
  echo
  echo "| File | Kind | Result | First reference as rendered |"
  echo "|------------------------|------------|------|------------------------------------------------------------------|"
} > "$out"
fail=0
for f in *.csl dependent/*.csl; do
  if grep -q 'rel="independent-parent"' "$f"; then
    kind="dependent on $(grep -o 'styles/[^"]*" rel="independent-parent"' "$f" | sed -E 's#styles/([^"]*)".*#\1#')"
  else
    kind="independent"
  fi
  res=$(quarto pandoc --citeproc --csl "$f" --bibliography test/test.bib -t plain --wrap=none test/test.md 2>&1)
  status=$?
  if [ $status -eq 0 ] && ! printf '%s' "$res" | grep -qi "warning\|error" \
     && printf '%s' "$res" | grep -qi "Kuijjer" && printf '%s' "$res" | grep -qi "Morris" \
     && printf '%s' "$res" | grep -q "2019"; then
    r=pass
  else
    r=FAIL; fail=1
  fi
  first=$(printf '%s\n' "$res" | grep -i "Kuijjer" | tail -1 | sed 's/|/\\|/g' | cut -c1-200)
  echo "| \`$f\` | $kind | $r | $first |" >> "$out"
done
echo "Wrote $out"
exit $fail
