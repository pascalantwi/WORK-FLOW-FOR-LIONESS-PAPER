# Pre-registration: [pilot folder, `pilot/` or `pilot-b/`]

| | |
|---|---|
| Proposal | `proposal.md`, section [the pilot plan, or the revision section this pilot follows] |
| Written | [date] |
| Committed | [hash], before any run |

<!-- Filled at stage 2, step 2, and committed alone before any run. A reading (section 5) or an
amendment (section 6) added later is dated and committed before the run it precedes. Delete the comments. -->

## 1. The three questions

1. Does the effect exist? [as the proposal states it]
2. Is it large enough to matter at realistic sizes? [as stated]
3. Is there a fix or a diagnostic? [as stated]

## 2. The pass rule

For each question, its clauses. Each clause names the estimator or quantity it refers to, the threshold, the cells it is judged in, and how a value within its Monte Carlo standard error of the threshold is read. No clause presumes the answer to another question. Every coverage criterion has a size criterion beside it (a set that includes nearly everything cannot fail coverage).

| Question | Clause | Quantity | Threshold | Cells | Within its MCSE |
|---|---|---|---|---|---|
| 1 | (a) | | | | |

**How the answers combine.** Pass when [...]. Fail when [...]. Close call when [...]: a close call is stated both ways at the verdict, with the reading that passes and the reading that fails.

## 3. Design

- Factors and levels: [...]
- Methods: [...]
- Measures: [...]
- Replicates per cell: [n], giving a Monte Carlo standard error of about [...] for [the measure that matters most]; set from the timing run and the time box.
- Seeds: one per cell from the design table; when the cells are fewer than the workers, seeded blocks of [m] replicates within a cell, the seed from the cell's seed and the block index.
- Cells with a known answer: [...]
- Time box: [an hour of compute by default], on [three cores, or the allowance the user gave for this run].

## 4. What is reported whatever the outcome

[The measures, the tables, the figures, the known-answer table.]

## 5. Readings of open cases

<!-- Filled when the rule is applied to a case it did not state (which estimator a clause meant, a largest gap between two thresholds). A reading is not a change to the rule; every reading is listed in the stop message. -->

- [date] [the case, and how it was read]

## 6. Amendments before the run

<!-- A change made after this file was committed and before the run it governs (a known-answer check that failed, a definition corrected), each dated and committed before the run. Nothing here is written after a run. -->

- [date] [what changed, why, commit]
