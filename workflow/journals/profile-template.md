# [Journal name]

<!-- Copy this file to profiles/<slug>.md. Every fact comes from a page on the journal's or publisher's own site, cited by its number in Sources. Write "not stated on the site" when a page you read does not say, and "could not be read" when the page exists but would not load. Never fill a field from memory. -->

| Field | Value |
|-----------------|--------------------------------------------------------------|
| Publisher | [publisher; society, if any] |
| Online ISSN | [ISSN] |
| Profile written | [YYYY-MM-DD] |

## Sources

Every page below was read on the date shown. Bracketed numbers in the text point here.

1. [Page title](URL), read YYYY-MM-DD.
2. ...

## Scope

> "[Short quotation of the journal's own aims.]" [1]

[One plain-language paragraph: what the journal actually publishes, who reads it, and which of our paper types fit it.]

| Paper type | Fit | Why |
|--------------------------------------------|----------|------------------------------------------------|
| Critique with a closed-form bias, simulation, fix, and application | good / possible / poor | [one sentence] |
| Simulation and diagnostic, no closed form | good / possible / poor | [one sentence] |
| Constructive method with theory, simulation, comparison, and application | good / possible / poor | [one sentence] |
| Short methods note | good / possible / poor | [one sentence] |
| Theory paper | good / possible / poor | [one sentence] |
| Applied analysis | good / possible / poor | [one sentence] |

## Article types that fit

| Article type | Length | Figures and tables | References | Source |
|-------------------|--------------------------|---------------------|-------------|--------|
| [type] | [words or pages, or not stated on the site] | [limit] | [limit] | [n] |

## Abstract

- Structured: [yes or no] [n]
- Headings: [list, or none]
- Word limit: [number, or not stated on the site]

## Reference style

- The journal's stated style: [what the guidelines say] [n]
- CSL file: [name in the official styles repository, and the parent style if it is a dependent one]
- File to use in Quarto: `csl/[file].csl`
- Rendering test: [result of `quarto pandoc --citeproc` on the two-entry test bib, with the date]

## Supplement, code, and data

- Supplementary material: [n]
- Data availability statement: [required or not, and what it must say] [n]
- Code: [policy; whether a public repository is required at submission or at acceptance] [n]

## AI-use policy

> "[The operative sentences of the policy, quoted.]" [n]

- Read at: [URL], YYYY-MM-DD.
- What the manuscript must do: [one sentence: where the disclosure goes and what it says].

## Open access and charges

- Model: [fully open access, hybrid, or subscription with an open option] [n]
- Article processing charge: [amount and currency, as stated, with the date read] [n]
- Waivers and institutional agreements: [what the site says] [n]

## Review

- Model: [single anonymized, double anonymized, open, or not stated on the site] [n]
- Time to decision: [figure published by the journal, or not stated on the site] [n]

## Recent papers like ours

1. [Authors] ([year]). [Title]. *[Journal]*. https://doi.org/[DOI]. [One sentence on why it resembles our papers.]
2. ...

## Not stated on the site, or could not be read

- [Field: what was missing, and which page was checked.]

## Table row

<!-- One line per key. These values feed README.md and journals.csv. -->

```
scope_5_words: [five words]
audience: [genomics users | methodologists | both | general science]
fit_critique: [good | possible | poor]
fit_sim_diagnostic: [good | possible | poor]
fit_constructive: [good | possible | poor]
fit_short_note: [good | possible | poor]
fit_theory: [good | possible | poor]
fit_applied: [good | possible | poor]
abstract_format: [structured: headings | unstructured]
abstract_words: [number or not stated]
length_limit: [main article type and its limit, or not stated]
apc: [amount and currency, or none]
oa_model: [open access | hybrid | subscription]
ai_policy_3_words: [three words]
review_model: [single | double | open | not stated]
guidelines_read: [yes | partly | blocked: whether the journal's own author guidelines could be read]
```
