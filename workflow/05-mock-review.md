# Stage 5: mock review

## Purpose

Put the final manuscript through the review it would get at the target journal, from three reviewers with different habits, before it is submitted: one who reads for coherence and fit with the literature and knows when the work has been done before; one who distrusts every detail and derivation; and one who asks what more the paper could do. Then draft the responses and revisions the user decides on, and repeat until the user is satisfied.

## Inputs

- `manuscript/manuscript.html` rendered in final mode (stage 3, step 6), which holds the supplementary note, and the target journal's profile from `workflow/journals/`.
- `workflow/reviewers/reviewer-1.md`, `reviewer-2.md`, `reviewer-3.md`: the three reviewers' instructions, each the whole context one reviewer receives.
- `templates/review-report.md` and `templates/response.md`.
- For later rounds: the previous round's reviews and responses.
- `workflow/rules.md`, in full.

## Preconditions

- `STATUS.md` says `3, final`: the background report is done (`4, done` came before it), its issues are resolved, and the production run and the final render have been made.
- The log is `log/05-mock-review.md`.

## Procedure

**1. The packet.**

1. Make `review/round-1/` and put in it what a reviewer at the journal would get: a copy of the final render as `manuscript.html`, and the journal's reviewer criteria from the profile as `criteria.md`. A draft-mode render is never sent: its banner, marks, and gap table are apparatus.
2. A reviewer does not get `proposal.md`, `project-spec.md`, the logs, the pilot, or the background report. The packet is the same for all three.
3. Set `STATUS.md` to `5, round 1 at stop` once the reviews are in; until then `5, round 1 reviewing`.

**2. Three independent reviews.**

1. Run the three reviewers as separate agents with fresh context and no sight of each other's output. Each receives only its instruction file, the packet, and `templates/review-report.md`.
2. Reviewer 1 may search the literature within its file's budget and read the full texts the reference list names (open copies, or PDFs in `references/pdfs/`). Reviewer 2 may write and run code of its own to probe a claim (a small simulation, a recomputation from a formula) within about fifteen minutes of compute, and never reruns the manuscript's own analyses, which are tested already. Reviewer 3 may search for competing methods and datasets within its budget.
3. Each returns `review/round-1/reviewer_N.md` in the template's form: summary, major comments, minor comments, recommendation with confidence, searches made. A reviewer's claim about the literature names the source it saw. The coordinator checks that each file follows the template and that no reviewer saw another's review.

**3. The editor's summary.**

1. Read the three reviews. Write `review/round-1/summary.md`: the comments grouped by theme with duplicates merged, each with its reviewers' numbers, and a triage table for the user with one row per comment and an empty decision column (address, rebut, defer).
2. Say which comments, if any, contradict the manuscript's own evidence or the background report, with the file that shows it.
3. Write the stage record line naming `review/round-1/summary.md` and commit ("Stage 5, round 1: reviews and summary").

**Stop.** Return the three reviews and the summary. The user fills the decision column. Wait.

**4. Responses and revisions.**

1. Set `STATUS.md` to `5, round 1 responses`.
2. For each comment marked address: the change to the manuscript, made in a revision round of stage 3 (logged in `log/03-manuscript.md` under a dated "Revision from review round N" heading, with the revision pass applied, rendered in final mode, and checked with `--final`). For each marked rebut: the reply with its evidence. For each marked defer: the reply saying what would be needed.
3. Write `review/round-1/response.md` from the template: a point-by-point response in the order of the reviews, each reply quoting the comment and stating what changed and where, or why not.
4. Commit the round ("Stage 5, round 1: responses").

**5. Further rounds.**

1. When the user asks, make `review/round-2/` with the revised final render and, for each reviewer, its own previous review and the response to it, and not the others'.
2. Each reviewer judges whether its comments were met and raises what the revision opened.
3. Repeat steps 3 and 4.
4. The stage ends when the user declares the review complete; `STATUS.md` says `5, complete after N rounds`.

## Outputs

- `review/round-N/`: `manuscript.html`, `criteria.md`, `reviewer_1.md`, `reviewer_2.md`, `reviewer_3.md`, `summary.md`, `response.md`.
- Revision rounds in `log/03-manuscript.md`.
- `log/05-mock-review.md`: the agents run, their budgets and time, the triage, process feedback.

## Checks before the stop

- The packet holds the final render and nothing from the workflow.
- Each review follows the template and logs its searches or says "none".
- Every comment in the summary carries its reviewers' numbers.
- The summary is committed and `STATUS.md` names it.

## What to return at the stop

One message: the three recommendations; the major comments by theme with the reviewers' numbers; the comments that contradict the evidence, if any; the path to the summary and its triage table; what the coordinator was unsure of.

## Delegating this stage

The coordinator runs this stage; the reviewers are its workers, and their briefs are the files in `reviewers/` with the packet attached and nothing else. The editor's summary and the responses are the coordinator's.

## Lessons

(None yet. This stage has not been run.)
