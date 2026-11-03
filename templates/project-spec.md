# Project spec: [short title]

| | |
|---|---|
| Proposal | `proposal.md`, final [date] |
| Authors | as in `DESCRIPTION`, set by `tools/authors.R` before the final render |
| Written | [date] |
| Status | draft / final [date] |

## How to use this form

Fill it in at stage 2 (`workflow/02-pilot.md`, step 1), from the final proposal, before the pilot runs; section 3 is completed after the verdict. The spec is the question and the design. It is not instructions for writing code: the code is written as package functions with tests, and the user's time goes where an assistant is weak, which is choosing which factors to vary and why, noticing when a result is wrong, and deciding what the paper claims.

Keep it to two to four pages. Each section ends with a note on what good looks like; delete those notes in the filled copy.

Before the pilot runs:

- The pre-registration in `pilot/preregistration.md` is committed.
- The dataset is downloaded, and the path or accession in section 5 is right.
- The reading in section 9 has its questions.

The filled copy is `project-spec.md` at the project root, next to `protocol.md`. A filled spec is private until the paper is submitted.

---

## 1. Question and why it matters

**Question (one sentence):** [Does procedure X do Y when condition Z holds?]

**Why it matters:** [What changes for a user of the procedure if the answer is yes. Two or three sentences.]

> **What good looks like.** The question names a procedure people use and a condition they meet in real data, and it can be answered yes or no, or with a number. "Does the pooled correlation estimate the within-group correlation when the groups differ in mean, and does within-group standardization remove the gap?" is a question. "Study the properties of pooled correlations" is a topic. The "why it matters" sentence is about the user, not the field: what would they do differently on Monday?

## 2. Mechanism we suspect

[One paragraph.]

> **What good looks like.** The paragraph says what the procedure converges to under the realistic condition, compared with what the user thinks it estimates, and writes the gap as a formula if one is known. It says when the gap is zero and what makes it large, because those two facts become the null cell and the factors in section 4. It also says what the user should expect to see if the mechanism is wrong. It is not a literature review: citations go in section 9.

## 3. Pilot

Filled twice: the plan when the spec is written, the answers after the verdict (stage 2, step 5).

**Code:** [`pilot/pilot.R`, and the command that runs it]

**Pass rule:** [from the proposal, as numbers]

**Verdict file:** [`pilot/results/verdict.rds`, after the run]

**Plot:** [one figure, saved in `pilot/results/`, or pasted here]

**The three pilot answers:**

1. Does the effect exist? [yes or no, with the number]
2. Is it large enough to matter at realistic sample sizes? [the effect at the sample sizes in section 4]
3. Is there an obvious fix or diagnostic? [what it is, or "none yet"]

> **What good looks like.** The pilot is the smallest simulation that would show the effect if it exists, run for real, with the three answers in one line each and with numbers. It is the project's starting point, so it must run from a clean clone. If the answers are "yes, small, no", this is not a project yet.

## 4. ADEMP skeleton

This becomes `protocol.md` at the design stop of stage 3. Bullets are enough here; the full protocol is written once from the approved design, before anything beyond the pilot is run.

**Aims.** [Two or three questions with yes-or-no or numeric answers.]

**Data-generating mechanisms.**

- Factors varied, with levels: [sample size, balance, effect size, correlation structure, and so on]
- Factors fixed, and why: [each fixed factor with its reason]
- A cell where the answer is known: [a null, or a case with a closed form]

**Estimands.** [What each method is trying to estimate or test, defined without reference to any method.]

**Methods compared.** [The procedures, precisely enough to reimplement: statistic, reference distribution, number of permutations, software and version.]

**Performance measures.** [Level and power for tests; bias, empirical SE, and coverage for estimators.]

**Replicates and Monte Carlo SE target.** [R per cell, and the MCSE it gives for the measure that matters most. For a rejection rate near 0.05, about 1900 replicates give an MCSE of 0.005.]

> **What good looks like.** Every fixed factor has a reason, and the varied factors come from the mechanism in section 2, not from a list of everything that could be varied. The known-answer cell is there so that a bug shows up as a wrong answer. When balance varies, total N is held fixed, or the balance effect is confounded with a sample size effect. The estimand is defined before the methods, because in this kind of work the estimand and the method's target often differ and the simulation exists to measure that difference. The MCSE target is a number, chosen before any run.

## 5. Application

**Dataset:** [name, accession or path, and where it lives on disk]

**Comparison:** [which groups, how many samples per group, and the scale the measurements are on]

**What to show:** [the one thing the application should demonstrate]

> **What good looks like.** The dataset has been downloaded and opened by you before the spec is written, not just named. It is open data that matches the setting the idea names, single-cell or spatial where the question allows. "What to show" is a claim about the user's conclusion, for example "a comparison where the artifact changes which edges look different", not "run the method on the data". The application is there to show the effect matters in a real cohort. It is not a search for new biology.

## 6. Target journal

**Target journal:** [one journal]

**Fallback:** [one journal]

**The target's word limit and AI policy:** [copied from its profile, the worksheet's last line]

> **What good looks like.** The target is chosen with the journal guide's worksheet (`workflow/journals/`), with a fallback that takes a sound version of the same paper with little rework. Name the journal's word limit and its AI policy, because the disclosure in the paper follows that policy.

## 7. Milestones

One line per stage of the workflow: the file that ends it and the date it is due.

| Stage | Ends with | Due |
|---|---|---|
| 2. Pilot | `pilot/pilot-report.html`, the verdict file, `pilot/decisions.md` | [date] |
| 3. Manuscript, design stop | `protocol.md` from the approved design | [date] |
| 3. Manuscript, first draft | `manuscript/manuscript.html` in draft mode | [date] |
| 3. Manuscript, settled | the draft after the revision rounds | [date] |
| 4. Background report | `background/background.html` | [date] |
| 5. Mock review | the last `review/round-N/` | [date] |
| Submission | the final render and the checker in final mode | [date] |

Where a thesis or project report is required, it is the paper. Do not plan two documents.

> **What good looks like.** Every milestone is a file in the repository that someone else can open, not an activity. Each has a date.

## 8. Out of scope

The project must not add:

- [ ]
- [ ]
- [ ]

> **What good looks like.** This is the section that saves projects. Write it by listing what a user with an AI assistant will be tempted to add: one more method or distance, a second dataset, the next sample-specific method after the ones in scope, a predictive model (not the research direction), an R package or software paper (software is a byproduct, not a publication), or a theory result beyond the closed form in section 2. Each item is a different project, not a missing section of this one. If the extension is itself a research idea, say so, so that the user knows it is parked, not forgotten. When the user proposes something on this list, the answer is "later, as its own paper".

## 9. Reading

1. [Reference.] After reading, a reader can answer: [question].
2. [Reference.] After reading, a reader can answer: [question].
3. [Reference, optional.] After reading, a reader can answer: [question].

> **What good looks like.** Two or three papers, not ten. The first introduces the procedure, the second shows a related critique or fix, and the third (if any) is background a reader would otherwise skip. Each comes with a question that can only be answered by someone who read it. Every reference is checked against the actual paper before it goes in.
