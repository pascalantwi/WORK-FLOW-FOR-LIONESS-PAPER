# Pre-registration: `pilot/`

| | |
|---|---|
| Proposal | `proposal.md`, section 7 (final 2026-11-03, revision 2) |
| Written | 2026-11-03 |
| Committed | in the commit "Stage 2, step 2: pre-registration", before any run |

## 1. The three questions

1. Does the effect exist? When the classes differ only in the IFN factor, do LIONESS edges raise the AUC over a reference that holds the residual IFN score but not its square?
2. Is it large enough to matter at realistic sizes? Does the gain persist at 40 per class?
3. Is there a fix or a diagnostic? Does the matched quadratic model, with the squared score in the reference, take the edges' place: no gain from edges over it where there is no co-expression difference, and most of the edges' gain where there is one?

## 2. The pass rule

Notation: $A(M)$ is the out-of-fold AUC of model $M$ in one replicate; a gain is a paired difference within a replicate, averaged over replicates; its Monte Carlo standard error (MCSE) is the replicate standard deviation of the paired difference divided by the square root of the number of replicates.

| Question | Clause | Quantity | Threshold | Cells | Within its MCSE |
|---|---|---|---|---|---|
| 1 | (a) | $G_1$ = mean of $A(\text{N1}{+}R_0) - A(R_0)$ | $G_1 \ge 0.05$ and $G_1 > 3$ MCSE | IFN-only, moderate, $\pi$ = 0.5, $n$ = 80 | $\lvert G_1 - 0.05 \rvert \le 3$ MCSE: close call for this clause |
| 2 | (a) | $G_2$ = mean of $A(\text{N1}{+}R_0) - A(R_0)$ | $G_2 \ge 0.03$ | IFN-only, moderate, $\pi$ = 0.5, $n$ = 40 | $\lvert G_2 - 0.03 \rvert \le 3$ MCSE: close call for this clause |
| 3 | (a) | $D_c$ = mean of $A(\text{N1}{+}R_1) - A(\text{E5})$ in each cell $c$ | $\lvert D_c \rvert \le \max(0.01, 3\,\text{MCSE}_c)$ in every cell | every IFN-only and every mean-shift cell (7 cells) | a cell with $\max(0.01, 3\,\text{MCSE}_c) < \lvert D_c \rvert \le 0.01 + 3\,\text{MCSE}_c$ is a close call for this clause |
| 3 | (b) | $B$ = mean of $[A(\text{E5}) - A(R_1)] - 0.9\,[A(\text{N1}{+}R_1) - A(R_1)]$ | $B \ge 0$ | network, change 0.4, $\pi$ = 0.5, $n$ = 80 | $\lvert B \rvert \le 3$ MCSE: close call for this clause |

E5 is the matched quadratic model with $R_1$ unpenalized (section 3). Clause 3(b) is written as one paired difference so that it has its own MCSE; it is the proposal's "at least 90% of the gain" with no division.

**How the answers combine.** Pass when 1, 2, 3(a), and 3(b) pass. Fail when 1 fails or 3(a) fails, or when $G_2 < 0.01$. Close call otherwise: when any clause is a close call for itself, when 1 and 3 pass and $0.01 \le G_2 < 0.03$, or when 1, 2, and 3(a) pass and 3(b) fails. A close call is stated both ways at the verdict, with the reading that passes and the reading that fails.

## 3. Design

- **Data-generating mechanism.** Two classes (0 and 1, class 1 the smaller); 50 genes; for sample $q$, $x_{qg} = a_g F_q + b_g C_q + \varepsilon_{qg}$ with $a_g$ = 0.8 for genes 1 to 20 and 0 otherwise, $b_g$ = 0.4 for genes 31 to 50 and 0 otherwise, $C_q \sim N(0, 1)$ in both classes, and $\varepsilon_q \sim N(\mu_{c}, \Sigma_{c})$ where $\Sigma_c$ is the identity except a block for genes 21 to 30 with off-diagonal correlation $\rho_c$. Class 0: $F \sim N(0, 1)$, $\mu = 0$, $\rho_0$ = 0.3. Age $\sim N(0,1)$ and sex $\sim$ Bernoulli(0.5), independent of everything.
- **Mechanisms.** Null: class 1 as class 0. IFN only: class 1 has $F \sim N(s, k^2)$, with $(s, k)$ = (0.5, 1.5) moderate or (1, 2.25) large. Mean shift: class 1 has $\mu_g$ = 0.5 for genes 21 to 30. Network: class 1 has $\rho_1 = 0.3 + \Delta$, $\Delta \in \{0.1, 0.2, 0.4\}$.
- **Cells (16).** $n$ is the size of class 1 and $\pi$ its share; class 0 has $n(1-\pi)/\pi$, rounded.

| Cell | Mechanism | Level | $\pi$ | $n$ |
|---|---|---|---|---|
| 1 | null | | 0.5 | 80 |
| 2 | null | | 0.3 | 80 |
| 3 | IFN only | moderate | 0.5 | 80 |
| 4 | IFN only | large | 0.5 | 80 |
| 5 | IFN only | moderate | 0.5 | 40 |
| 6 | IFN only | moderate | 0.5 | 150 |
| 7 | IFN only | moderate | 0.3 | 80 |
| 8 | mean shift | 0.5 | 0.5 | 80 |
| 9 | mean shift | 0.5 | 0.3 | 80 |
| 10 | mean shift | 0.5 | 0.3 | 40 |
| 11 | network | 0.1 | 0.5 | 80 |
| 12 | network | 0.2 | 0.5 | 80 |
| 13 | network | 0.4 | 0.5 | 80 |
| 14 | network | 0.2 | 0.5 | 40 |
| 15 | network | 0.2 | 0.5 | 150 |
| 16 | network | 0.2 | 0.3 | 80 |

- **Derived variables, inside each training fold.** The IFN score is the mean of genes 1 to 5 standardized by the training fold (as the five IFN5 genes); the residual score is its residual on $C$ (training-fold regression applied to test samples). The gene set $G$ is genes 6 to 50 (45 genes, 990 pairs), fixed, so that the score and the edges share no gene. Products and squares for E5 use genes standardized by the training-fold mean and standard deviation (divisor $N$).
- **Methods.** $R_0$: logistic regression on age, sex, $C$, and the residual score. $R_1$: $R_0$ plus the squared residual score and $C^2$. E1: elastic net on the 45 genes, $R_1$ terms unpenalized. E4: regularized discriminant analysis (class covariance $(1-\lambda)\hat\Sigma_c + \lambda\hat\Sigma_{\text{pooled}}$, then shrunk toward its mean diagonal by $\gamma$) on the 45 genes, the residual score, and $C$, with $(\lambda, \gamma)$ from the grid $\{0, 0.25, 0.5, 0.75, 1\}^2$ by inner 5-fold cross-validated AUC. E5: elastic net on the 990 products and 45 squares, $R_1$ terms unpenalized. N1 with $R_0$ and N1 with $R_1$: elastic net on the 990 LIONESS-Pearson edges, the reference terms unpenalized; training edges from the training fold by the exact form, test edges against the training fold by the add-one form (proposal, Results 1 and 5). Elastic net: glmnet 5.2, $\alpha$ = 0.5, $\lambda$ = `lambda.min` of `cv.glmnet` with 5 folds and binomial deviance. Outer loop: 5 folds stratified by class; out-of-fold predictions pooled into one AUC per model and replicate.
- **Measures.** $A(M)$ for the seven models; paired differences from $R_0$ and $R_1$, and $A(\text{N1}{+}R_1) - A(\text{E5})$; in mean-shift cells, the mean over module pairs of the observed class difference in mean LIONESS edge minus the value from proposal equation (3) with the sample's own pooled moments.
- **Replicates per cell.** Set from the timing run before the main run: 200 if the projected run fits the time box, otherwise the largest multiple of 20 that fits, not below 60; the count is entered in section 6 and committed before the run. At 200, the MCSE of a gain with replicate standard deviation 0.04 is about 0.003.
- **Seeds.** Cell $c$ has seed $20261103 + 1000c$; when the cells are fewer than the workers, blocks of replicates within a cell use the cell seed plus the block index. Each replicate draws from its own stream: the cell seed plus the replicate index.
- **Cells with a known answer.** Cells 1 and 2 (every AUC near 0.5, every gain near 0). The closed-form edges against literal leave-one-out and add-one LIONESS (tests, to $10^{-8}$).
- **Time box.** One hour of compute on three cores (PSOCK workers, BLAS pinned to one thread).

## 4. What is reported whatever the outcome

The AUC of every model in every cell with its MCSE; the gains of section 2 in every cell; the verdict table clause by clause; the known-answer table; the mean-shift edge-difference check against equation (3); one figure of the gains by cell (`pilot/results/auc_gains.png`).

## 5. Readings of open cases

- 2026-11-03, before the run. "In the IFN-only and mean-shift cells" (proposal, clause 3(a)) is read as every such cell of the design, each judged alone; all must pass.
- 2026-11-03, before the run. "At least 90% of the AUC gain" (clause 3(b)) is read as the paired difference $B$ of section 2, so that a negative or null gain of the edges cannot make a ratio undefined.
- 2026-11-03, before the run. The combination rule of the proposal leaves two cases open: $G_2 < 0.01$ with 1 and 3 passing, read as fail (question 2 fails outright); 3(b) failing with 1, 2, and 3(a) passing, read as a close call (the edges then carry something beyond first order, which is a finding, not a failure of the safeguard).
- 2026-11-03, before the run. "LIONESS edges added to $R_0$" is the elastic net N1 with the $R_0$ terms unpenalized; "the matched quadratic model" is E5, which holds the $R_1$ terms.

## 6. Amendments before the run

- 2026-11-03, after the timing run and before the run. Replicates per cell: 180. The timing run (10 replicates per cell, three workers loaded, the run's own scheduling; `pilot/results/timing.rds`) took 181 seconds, which projects 200 replicates to about 3,620 seconds, over the one-hour box; 180 is the largest multiple of 20 that fits (projected about 3,260 seconds). At 180 replicates the MCSE of a gain with replicate standard deviation 0.04 is about 0.003.
