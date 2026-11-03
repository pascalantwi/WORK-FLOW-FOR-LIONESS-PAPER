[^pilot]: A pilot is a quick, small first run of the proposal's simulation, done before the project goes further, to check that the idea is worth the time. It asks three questions: does the effect exist, is it large enough at realistic sample sizes, and is there an obvious fix or diagnostic? The proposal (`proposal.md`) holds the pilot plan and its pass criteria.

[^pf]: `piloted-pass` means all three pilot questions got a clear yes. `piloted-fail` means at least one clearly did not, so the project should not go on as proposed. `piloted-close-call` means at least one answer could be read either way, so the call is stated both ways: the reading that passes and the reading that fails.

[^agent]: The AI agent that ran the pilot, wrote the files this document is built from, and kept a log of its decisions.

[^cond]: A draft that applies only if the proposal is re-scoped as described. If the proposal stays as written, it is a record only.

[^kac]: A known-answer check tests the simulation code itself. It runs a setting where the correct answer is known from theory (for example, a t-test on balanced data should reject 5% of the time at level 0.05) and confirms the code reproduces it, so that a bug shows up as a wrong answer before any new result is trusted.

[^closed]: A closed form is a formula that gives the exact answer without simulation, so the simulation can be checked against it.

[^stress]: A stress case is a deliberately extreme setting used to see whether a method breaks. It is not meant to resemble the real data.

[^doublet]: A droplet that captured two cells and reads them as one, so its counts mix two cell states.

[^annot]: Annotation: labeling each cell as a monocyte, NK cell, and so on, usually by clustering its gene expression and matching known marker genes.
