# Pre-registration: `pilot-b/`

| | |
|---|---|
| Proposal | `proposal.md`, section 12 (revision 3, approved by the user 2026-11-03) |
| Written | 2026-11-03 |
| Committed | in the commit "Stage 2, step 2 (pilot-b): pre-registration", before any re-pilot code or run |

## 1. The three questions

1. Does the equivalence hold? Do LIONESS edges and their first-order features give the same out-of-sample AUC, in cells where the edges carry a real signal?
2. Is it large enough to matter at realistic sizes? Is the IFN artifact at least 0.02 in AUC at a large IFN difference, and is the co-expression signal of edges at least 0.03 at 40 per class?
3. Is there a fix or a diagnostic? Does a reference with the squared IFN score remove the artifact, with normal and heavy-tailed noise, and with a two-gene score?

## 2. The pass rule

Notation as in `pilot/preregistration.md`: $A(M)$ is the out-of-fold AUC of model $M$ in one replicate; a gain is a paired difference within a replicate, averaged over replicates; its MCSE is the replicate standard deviation of the difference divided by the square root of the number of replicates. F1 is the elastic net on the first-order edge features with $R_1$ unpenalized; "edges" is the elastic net on the exact LIONESS edges.

| Question | Clause | Quantity | Threshold | Cells | Within its MCSE |
|---|---|---|---|---|---|
| 1 | (a) | mean of $A(\text{edges}{+}R_1) - A(R_1)$ | $\ge 0.05$ and $> 3$ MCSE | 7 | $\lvert v - 0.05 \rvert \le 3$ MCSE: close call |
| 1 | (b) | $D_c$ = mean of $A(\text{edges}{+}R_1) - A(\text{F1}{+}R_1)$ | $\lvert D_c \rvert \le \max(0.01, 3\,\text{MCSE}_c)$ in every cell | 1 to 12 | $\max(0.01, 3\,\text{MCSE}_c) < \lvert D_c \rvert \le 0.01 + 3\,\text{MCSE}_c$: close call |
| 2 | (a) | mean of $A(\text{edges}{+}R_0) - A(R_0)$ | $\ge 0.02$ | 2 | $\lvert v - 0.02 \rvert \le 3$ MCSE: close call |
| 2 | (b) | mean of $A(\text{edges}{+}R_1) - A(R_1)$ | $\ge 0.03$ | 8 | $\lvert v - 0.03 \rvert \le 3$ MCSE: close call |
| 3 | (a) | $E_c$ = mean of $A(\text{edges}{+}R_1) - A(R_1)$ | $\lvert E_c \rvert \le \max(0.01, 3\,\text{MCSE}_c)$ in each cell | 2, 3, 5 | as clause 1(b) |
| 3 | (b) | $E_c$ as in 3(a) | as in 3(a) | 4 | as clause 1(b) |

**How the answers combine.** Pass when every clause passes. Fail when 1(a), 1(b), or 3(a) fails. Close call otherwise: when 2(a), 2(b), or 3(b) fails, or when any clause is a close call for itself. A close call is stated both ways at the verdict. A failure of 3(b) is reported as a dependence of the fix on the reliability of the score.

## 3. Design

- **Data-generating mechanism.** As in `pilot/preregistration.md`, section 3, with two stress options. Heavy-tailed noise: every noise term $\varepsilon_{qg}$ is drawn from a $t$ distribution with 5 degrees of freedom divided by $\sqrt{5/3}$ (unit variance) before the module's correlation is applied. Two-gene score: the IFN score is the mean of genes 1 and 2 standardized by the training fold, instead of genes 1 to 5.
- **Cells (12).** $n$ is the size of class 1 and $\pi$ its share.

| Cell | Mechanism | Level | Stress | $\pi$ | $n$ |
|---|---|---|---|---|---|
| 1 | null | | | 0.5 | 80 |
| 2 | IFN only | large | | 0.5 | 80 |
| 3 | IFN only | moderate | | 0.5 | 80 |
| 4 | IFN only | large | two-gene score | 0.5 | 80 |
| 5 | IFN only | large | $t_5$ noise | 0.5 | 80 |
| 6 | mean shift | 0.5 | | 0.3 | 80 |
| 7 | network | 0.4 | | 0.5 | 80 |
| 8 | network | 0.4 | | 0.5 | 40 |
| 9 | network | 0.2 | | 0.5 | 150 |
| 10 | network | 0.4 | $t_5$ noise | 0.5 | 80 |
| 11 | network | 0.4 | | 0.3 | 80 |
| 12 | network | 0.2 | | 0.5 | 80 |

- **Derived variables, inside each training fold.** As in the first pilot. The gene set $G$ is genes 6 to 50 in every cell, including cell 4, so that the edges are the same set of pairs throughout. First-order edge features: $r + z_i z_j - \tfrac r2 (z_i^2 + z_j^2)$ for every pair of $G$, with $r$ and the standardization from the training fold for both training and test samples.
- **Methods.** $R_0$, $R_1$, E1, E5, and edges with $R_0$ and with $R_1$, as in the first pilot; F1 with $R_1$ (elastic net on the 990 first-order edge features, the $R_1$ terms unpenalized, the same settings as the other elastic nets). E4 is not run.
- **Measures.** $A(M)$ for the seven models; the paired differences of section 2; also, for the record, $A(\text{F1}{+}R_1) - A(\text{E5})$ (the parametrization effect).
- **Replicates per cell.** From a timing run of ten replicates per cell with the workers loaded: 200 if the projected run fits one hour on three cores, otherwise the largest multiple of 20 that fits, not below 60; entered in section 6 and committed before the run.
- **Seeds.** Cell $c$ has seed $20261103 + 2000c$, different from every seed of the first pilot; replicate $r$ uses the cell seed plus $r$.
- **Cells with a known answer.** Cell 1 (every AUC near 0.5). The closed forms against literal LIONESS, and the first-order test edges against the exact add-one edges at large $N$ (tests).
- **Time box.** One hour of compute on three cores.

## 4. What is reported whatever the outcome

The AUC of every model in every cell with its MCSE; every paired difference of section 2 in every cell; the parametrization effect; the verdict table clause by clause; the known-answer table; one figure of the differences by cell (`pilot-b/results/auc_gains.png`).

## 5. Readings of open cases

- 2026-11-03, before the run. "In every cell" (clause 1(b)) includes the null and IFN-only cells, where edges and F1 may both carry nothing; clause 1(a) is the guard against passing on two nulls, and it is judged in cell 7 only.
- 2026-11-03, before the run. The combination rule lists the failing clauses for fail; a failure of 2(a) together with a failure of 2(b) is read as a close call, as the rule states, and the stop message says the paper would then rest on equivalence and the fix alone.

## 6. Amendments before the run

- 2026-11-03, before any run. Seeds corrected. Section 3 gave cell $c$ the seed $20261103 + 2000c$ and called it different from every seed of the first pilot; it is not ($2000c = 1000c'$ for $c' = 2c$, eight collisions), which a test caught. Corrected to $20261103 + 2000c + 500$, at least 500 from every seed of the first pilot, so that no replicate stream (cell seed plus 1 to 200) overlaps.
- 2026-11-03, after the timing run and before the run. Replicates per cell: 200. The timing run (10 replicates per cell, three workers loaded, the run's own scheduling; `pilot-b/results/timing.rds`) took 146 seconds, which projects 200 replicates to about 2,920 seconds, within the one-hour box. At 200 replicates the MCSE of a gain with replicate standard deviation 0.04 is about 0.003.
