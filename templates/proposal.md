# Proposal: [short title]

| | |
|---|---|
| From | `idea.md`, [date of the idea file] |
| Written | [date], workflow [version] |
| Status | draft / final [date] |

<!-- Filled by stage 1 (workflow/01-idea-review.md). Written in the proposal's own words, not by copying
idea.md. Every claim carries a source in manuscript/references.md or a [TO CONFIRM: ...]{.tc} marker. Delete the comments. -->

## 1. Summary and verdict

[Three or four sentences: what the idea proposes, what the review found on novelty, theory, and data, and the recommendation: pilot as proposed, pilot after the open questions are settled, or do not pilot, with the reason.]

## 2. Question and why it matters

**Question (one sentence):** [Does procedure X do Y when condition Z holds?]

**Why it matters:** [What changes for a user of the procedure if the answer is yes.]

## 3. The paper test

| Step | Answer | What is missing |
|---|---|---|
| 1. A procedure in wide use | | |
| 2. A setting it was not built for | | |
| 3. The estimand, as a functional | | |
| 4. The target and the bias term | | |
| 5. A simulation that confirms it | | |
| 6. A correction or a diagnostic | | |
| 7. The application | | |

## 4. Mechanism and theory

[The mechanism in words, then the first-order sketch with its assumptions, labeled as a sketch. For each result the idea claims: the restatement, the first step that does not hold or is not justified, and the numerical check that catches an error.]

## 5. Prior work and novelty

| Source | What it did | What it did not do | Relation to the idea |
|---|---|---|---|
| | | | |

**Verdict:** [new mechanism / known informally, no closed form and no fix / published, with the source]. [What the idea adds beyond the closest source.]

Searches are logged in `log/01-idea-review.md`.

## 6. Datasets

| Dataset | Accession | What is deposited (samples by group, format, access) | Status | Opened |
|---|---|---|---|---|
| | | | verified / verify / unavailable | [date] |

**Recommended:** [dataset], with [fallback]. **What the application shows:** [one sentence].

## 7. Pilot plan and pass criteria

**First simulation:** [factors and levels, methods, measures, known-answer cells, replicates, runtime estimate].

**The three questions and the pass rule, decided before any run:**

1. Does the effect exist? Pass if [a number, in which cells, beyond how many Monte Carlo standard errors].
2. Is it large enough to matter at realistic sizes? Pass if [a number at the sizes of the recommended dataset].
3. Is there a fix or a diagnostic? Pass if [what it must achieve].

**Code and data that exist:** [paths, or none].

## 8. Impact and fit

[User base; expected size of the artifact; correction or diagnostic; which of the two paper types the idea is (a critique or a constructive method, `workflow/01-idea-review.md`).]

**Target journal:** [one], **fallback:** [one], from the journal guide's worksheet.

## 9. Open questions for the user

- [TO CONFIRM: ...]{.tc}

## 10. Reference list

Every source this proposal cites has an entry in `manuscript/references.md`. Core citations whose full text is pending are listed here; the user may add their PDFs to `manuscript/sources/<key>.pdf` (optional until the reference review at the end).

| Key | Grade | Identifier | Full text | Needed for |
|---|---|---|---|---|
| | | | | |

## 11. Revisions

[Dated entries after the stop: what the user decided, what changed.]
