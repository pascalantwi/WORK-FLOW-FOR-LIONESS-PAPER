# The workflow's instructions

Everything the agent follows is in this folder, one file per stage, so that anyone can see what instructions were used for each step. The files are numbered in the order the stages run. They are written for the agent, not for the user: a stage file is a checklist to execute and verify against, as long as it needs to be and never ambiguous. The user reads `STATUS.md` and the deliverables.

| File | Stage | Starts when | Ends with |
|---|---|---|---|
| `rules.md` | all | | The rules every stage obeys, and the vocabulary |
| `01-idea-review.md` | 1 | the user asks the agent to look at `idea.md` | `proposal.md`, for the user to review; then the reference check |
| `02-pilot.md` | 2 | the proposal is final | `project-spec.md`, the pilot, its report, and a pass or fail |
| `03-manuscript.md` | 3 | the pilot passed, or the idea was dropped or parked | the manuscript draft, then revision rounds on the user's comments; after stage 4, the production run and the final render (step 6); or, in memo mode, the memo of a study not carried further |
| `04-background-report.md` | 4 | the draft is settled, before the production run | `background/background.html`, and an issues list if the report found errors in the manuscript; then the user decides on the production run |
| `05-mock-review.md`, `reviewers/` | 5 | the manuscript is final | `review/round-1/reviewer_{1,2,3}.md`, then responses and further rounds |
| `06-slides.md` | 6 | the review is complete | `slides/` (not yet written) |
| `07-poster.md` | 7 | the slides are done | `poster/` (not yet written) |
| `08-publish.md` | 8 | the user asks to publish | a clean copy of the project outside the repository, with only the code, data, results, and manuscript, verified from a fresh restore |
| `journals/` | 3 | | The journal guide: profiles, the choosing procedure, CSL files |
| `CHANGELOG.md` | | | Dated lessons from each project the workflow was applied to |

Each stage file has the same sections: purpose, inputs, preconditions, procedure (a numbered checklist with its stops marked), outputs, checks before the stop, what to return at the stop, delegating this stage, and lessons. A stage's log goes in `log/<stage file name>`; the templates it fills are in `templates/`; the scripts it runs are in `tools/` or beside the template they serve. The three reviewer files in `reviewers/` are separate because each is the whole context one reviewer agent receives.

## Revising the instructions

The instructions are meant to be revised after every project. The route is: a stage's log ends with process feedback from the agent that ran it; the user's comments on the deliverable are recorded in the same log; the user decides which lessons become rules; the stage file changes and `CHANGELOG.md` gets a dated line saying what changed and which project taught it. A project records the workflow version it ran under in `STATUS.md`, so a later reader knows which instructions produced it.

Three habits keep the files usable: a rule goes in `rules.md` when it applies to more than one stage and in the stage file otherwise, and the stage file cites the rule rather than copying it; a stage file's steps say what to do, and the reasons go in its Lessons section; a term the files use is defined in `rules.md`, section 9, not left to be guessed.
