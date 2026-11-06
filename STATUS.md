# Status

| | |
|---|---|
| Workflow version | 0.2.4-md (2026-11-03): tgrimes/research-workflow 0.2.4 with a Markdown reference list and no Zotero |
| Project | LIONESS edges, the interferon score, and SLE versus RA |
| Package | lionessifn |
| Stage | 3, draft at stop |
| Open stop | first draft: read `manuscript/manuscript.html` and send comments (a revision round), or say the draft is settled |
| Last update | 2026-11-06 |

The Stage row reads "stage number, state". The states a stage can be in:

| Stage | States |
|---|---|
| 1. Idea review | `1, reviewing`; `1, proposal at stop 1`; `1, reference check`; `1, proposal final` |
| 2. Pilot | `2, spec`; `2, pilot running`; `2, piloted-pass`; `2, piloted-fail`; `2, piloted-close-call`; `dropped (reason)`; `parked (reason)` |
| 3. Manuscript | `3, design stop`; `3, drafting`; `3, draft at stop`; `3, revision round N`; `3, settled` (then stage 4 runs); `3, production run` (after `4, done`); `3, reference review`; `3, final`; after a dropped or parked pilot, `3, memo`, then `dropped (memo at manuscript/manuscript.html)` or `parked (memo at ...)` |
| 4. Background report | `4, in progress`; `4, report at stop`; `4, done`; it runs between `3, settled` and `3, production run` |
| 5. Mock review | `5, round N at stop`; `5, round N responses`; `5, complete after N rounds` |
| 6. Slides, 7. Poster | `6, in progress`; `6, at stop`; `6, done`; the same for 7 |
| 8. Publish | `8, exported`; `8, verified` |

## Stage record

One line per stage boundary, newest last: the date, the stage reached, the path of the deliverable the user reads, and the stop that is open. The agent writes the line when it reaches a stop; the user's answer is the next message in the conversation, and the agent records the decision in the stage's log.

| Date | Stage | Deliverable | Open stop |
|---|---|---|---|
| 2026-11-03 | 1, proposal at stop 1 | `proposal.md` | stop 1 |
| 2026-11-03 | 1, proposal final | `proposal.md` | none |
| 2026-11-03 | 2, piloted-fail | `pilot/pilot-report.html` | stage 2 stop |
| 2026-11-03 | 2, revised proposal (user's reading: revise and re-pilot) | `proposal.md`, section 12 | revised proposal stop |
| 2026-11-03 | 2, piloted-close-call (pilot-b) | `pilot-b/pilot-report.html` | stage 2 stop |
| 2026-11-04 | 2, piloted-pass (user's reading of the pilot-b close call) | `pilot-b/pilot-report.html` | none: stage 3 starts |
| 2026-11-04 | 3, design stop | `log/03-manuscript.md`, step 3.2 | design stop |
| 2026-11-06 | 1, proposal final (revision 4, the user's new idea; stop 1 waived by the user) | `proposal.md` | none: stage 2 starts |
| 2026-11-06 | 2, piloted-pass (pilot-c, revision 4) | `pilot-c/pilot-report.html` | stage 2 stop |
| 2026-11-06 | 2, piloted-pass accepted by the user ("do 1 and 3 and stage 3"); stage 3 starts | `pilot-c/pilot-report.html` | none |
| 2026-11-06 | 3, draft at stop (revision 4, quick-run numbers) | `manuscript/manuscript.html` | first draft |
| 2026-11-06 | 3, revision round 1 (novelty framing) | `manuscript/manuscript.html` | first draft, revised |
