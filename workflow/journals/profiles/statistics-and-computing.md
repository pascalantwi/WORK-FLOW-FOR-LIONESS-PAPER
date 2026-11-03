# Statistics and Computing

| Field | Value |
|-----------------|--------------------------------------------------------------|
| Publisher | Springer (Springer Science+Business Media, LLC, part of Springer Nature) [2] |
| Online ISSN | 1573-1375 [2] |
| Profile written | 2026-10-27 |

## Sources

Every page below was read on the date shown. Bracketed numbers in the text point here.

1. [Submission guidelines, Statistics and Computing](https://link.springer.com/journal/11222/submission-guidelines), read 2026-10-27.
2. [Journal home page, Statistics and Computing](https://link.springer.com/journal/11222), read 2026-10-27.
3. [How to publish with us, Statistics and Computing](https://link.springer.com/journal/11222/how-to-publish-with-us), read 2026-10-27.
4. [Journal policies, Springer](https://link.springer.com/brands/springer/journal-policies) (the target of the journal's link to "Springer's policy on generative AI images"), read 2026-10-27.
5. Crossref REST API records (`https://api.crossref.org/works/<DOI>`) for the papers under "Recent papers like ours", read 2026-10-27.

## Scope

> "Statistics and Computing is a bi-monthly refereed journal publishing papers at the intersection of statistical and computing sciences." [2]

Statistics and Computing publishes computational statistics: algorithms, Monte Carlo and simulation-based inference, machine learning methods, and their theory. Its readers are computational statisticians, not genomics users. A critique paper fits when the procedure under study is itself computational (a resampling, permutation, or network-estimation algorithm), as in its 2021 paper arguing against permutation-based variable importance. A lupus application would be an illustration, not the point. No short article type is listed.

| Paper type | Fit | Why |
|--------------------------------------------|----------|------------------------------------------------|
| Critique with a closed-form bias, simulation, fix, and application | possible | The journal prints critiques of widely used computational procedures, but the genomics framing must give way to the algorithm. |
| Simulation and diagnostic, no closed form | possible | Simulation-based evaluation of a computational method fits the scope if the diagnostic is new and general. |
| Constructive method with theory, simulation, comparison, and application | possible | Fits when the new procedure is itself computational (an algorithm, or a resampling or Monte Carlo scheme); a new estimator for a genomics estimand is at the edge of a scope set at the intersection of statistics and computing [2]. |
| Short methods note | poor | The guidelines list no short article type or length [1]. |
| Theory paper | possible | Theory of computational procedures appears regularly; theory about a genomics estimand fits less well. |
| Applied analysis | poor | The scope is methods at the statistics and computing interface [2]. |

## Article types that fit

| Article type | Length | Figures and tables | References | Source |
|-------------------|--------------------------|---------------------|-------------|--------|
| Original research article | not stated on the site | not stated on the site | not stated on the site | [1] |

## Abstract

- Structured: no; no format is prescribed [1]
- Headings: none
- Word limit: "Please provide an abstract of 150 to 250 words." [1]

## Reference style

- The journal's stated style: author-year. "Cite references in the text by name and year in parentheses." "Reference list entries should be alphabetized by the last names of the first author of each work." DOIs should be given as full links where available [1].
- CSL file: `dependent/statistics-and-computing.csl` in the official styles repository (github.com/citation-style-language/styles, commit d2cc420, 2026-10-24), a dependent style whose parent is `springer-mathphys-author-date.csl`.
- File to use in Quarto: `csl/springer-mathphys-author-date.csl`, which renders offline. The journal-named `csl/dependent/statistics-and-computing.csl` gives the same output but needs a network connection, because pandoc fetches the parent at render time.
- Rendering test: both files passed on 2026-10-27 (`csl/test-results.md`).

## Supplement, code, and data

- Supplementary material: accepted and cited as "Online Resource"; research data should preferably go to a repository rather than the supplement [1].
- Data availability statement: required. "All original research must include a data availability statement", explaining how to access the data behind the results, with links or citations to archived datasets [1].
- Code: no journal-specific code policy. The guidelines ask authors to "make sure that all data and materials as well as software application or custom code support their published claims" [1]. No requirement to deposit code in a public repository, at submission or at acceptance, and no reproducibility check is stated.

## AI-use policy

> "Large Language Models (LLMs), such as ChatGPT, do not currently satisfy our authorship criteria." "Use of an LLM should be properly documented in the Methods section (and if a Methods section is not available, in a suitable alternative part) of the manuscript." "The use of an LLM (or other AI-tool) for "AI assisted copy editing" purposes does not need to be declared." [1]

- For images, the guidelines refer to Springer's policy [1]; that link now leads to Springer's journal policies page, whose risk framework lists "Creating photorealistic images (deepfakes)" and "Assigning authorship or accountability to AI systems or tools" as not permitted, and lists "Extensive copy editing or writing support" as permitted with disclosure [4]. The Springer page applies to Springer journals generally; the journal guidelines link to it.
- Read at: https://link.springer.com/journal/11222/submission-guidelines and https://link.springer.com/brands/springer/journal-policies, 2026-10-27.
- What the manuscript must do: describe any LLM use beyond light copy editing in the Methods section (what tool, for what task), keep humans accountable for the text, and use no AI-generated photorealistic images.

## Open access and charges

- Model: hybrid; authors choose subscription or open access after acceptance [3].
- Article processing charge: "£2090.00 GBP / $2990.00 USD / €2390.00 EUR", subject to VAT or local taxes, read 2026-10-27 [3]. The guidelines also say "The journal does not charge a submission fee or publication fee" [1].
- Waivers and institutional agreements: "Springer Nature offers agreements that enable institutions to cover open access publishing costs" [3]. No waiver is stated [3].

## Review

- Model: not stated on the site. The guidelines say standards vary "dependent on their peer review policies (i.e. single or double blind peer review)" without saying which this journal uses [1].
- Time to decision: "Submission to first decision (median)": 3 days, on the journal home page (no period or definition stated) [2]. The guidelines add: "In most cases, the decision is made in less than three months" [1].

## Recent papers like ours

1. Hooker G, Mentch L, Zhou S (2021). Unrestricted permutation forces extrapolation: variable importance requires at least one more model, or there is no free variable importance. *Statistics and Computing* 31(6). https://doi.org/10.1007/s11222-021-10057-z. A critique of a widely used permutation procedure that explains why it misleads under correlated features and proposes alternatives, the same shape as our critique papers.
2. McLatchie Y, Vehtari A (2024). Efficient estimation and correction of selection-induced bias with order statistics. *Statistics and Computing* 34(4). https://doi.org/10.1007/s11222-024-10442-4. Derives the bias that a routine practice (selecting models by cross-validation) introduces and gives a correction, checked by simulation.
3. Fan Y, White SR (2026). Neural posterior estimation on exponential random graph models: evaluating bias and implementation challenges. *Statistics and Computing* 36(4). https://doi.org/10.1007/s11222-026-10896-8. An evaluation of bias in a popular estimation approach for network models, close to our simulation and diagnostic paper type.

## Not stated on the site, or could not be read

- Article types and length, figure, table, and reference limits: not stated [1].
- Peer review model: not stated [1, 2, 3].
- Code deposit requirement: not stated [1].
- APC waivers: not stated [3].
- Unclear: the journal guidelines say AI-assisted copy editing "does not need to be declared" [1], while the linked Springer policy page encourages disclosure of all AI use and treats "extensive copy editing" as needing disclosure [4].

## Table row

```
scope_5_words: statistics and computing methods
audience: methodologists
fit_critique: possible
fit_sim_diagnostic: possible
fit_constructive: possible
fit_short_note: poor
fit_theory: possible
fit_applied: poor
abstract_format: unstructured
abstract_words: 150 to 250
length_limit: not stated
apc: none required (open access USD 2,990)
oa_model: hybrid
ai_policy_3_words: disclose in methods
review_model: not stated
guidelines_read: yes
```
