# Pre-registration: `pilot-c/`

| | |
|---|---|
| Proposal | `proposal.md`, revision 4, section 12 (the user's new idea, 2026-11-06) |
| Written | 2026-11-06 |
| Committed | in the commit "Stage 2, step 2 (pilot-c): pre-registration", before any pilot-c code or run |

## 1. The three questions

1. Does the equivalence hold on the E1 base? Do LIONESS edges added to E1 and first-order edges added to E1 give the same out-of-sample AUC, in cells where the edges carry a real signal over E1?
2. Does the signal survive at a small size and in the conditioned network? Do edges still gain at least 0.03 over E1 at 40 per class, and do the partial-correlation edges (N2) keep the co-expression signal?
3. Does the E1 base remove the interferon artifact? When the classes differ only in the IFN factor, do edges (N1) and partial-correlation edges (N2) add nothing to E1, with normal and heavy-tailed noise?

## 2. The pass rule

$A(M)$ is the out-of-fold AUC of model $M$ in one replicate. A gain or difference is a paired difference within a replicate, averaged over replicates; its MCSE is the replicate standard deviation of the difference divided by the square root of the number of replicates. $\Delta_1 = A(\text{N1}) - A(\text{E1})$, $\Delta_2 = A(\text{N1}) - A(\text{F1})$, $G_2 = A(\text{N2}) - A(\text{E1})$.

| Question | Clause | Quantity | Threshold | Cells | Within its MCSE |
|---|---|---|---|---|---|
| 1 | (a) | mean of $\Delta_1$ | $\ge 0.05$ and $> 3$ MCSE | 6 | $\lvert v - 0.05 \rvert \le 3$ MCSE: close call |
| 1 | (b) | $D_c$ = mean of $\Delta_2$ | $\lvert D_c \rvert \le \max(0.01, 3\,\text{MCSE}_c)$ in every cell | 1 to 9 | $\max(0.01, 3\,\text{MCSE}_c) < \lvert D_c \rvert \le 0.01 + 3\,\text{MCSE}_c$: close call |
| 2 | (a) | mean of $\Delta_1$ | $\ge 0.03$ | 7 | $\lvert v - 0.03 \rvert \le 3$ MCSE: close call |
| 2 | (b) | mean of $G_2$ | $\ge 0.05$ | 6 | $\lvert v - 0.05 \rvert \le 3$ MCSE: close call |
| 3 | (a) | $E_c$ = mean of $\Delta_1$ | $\lvert E_c \rvert \le \max(0.01, 3\,\text{MCSE}_c)$ in each cell | 2, 3, 4 | as clause 1(b) |
| 3 | (b) | mean of $G_2$ | as in 3(a) | 2, 3, 4 | as clause 1(b) |

**How the answers combine.** Pass when every clause passes. Fail when 1(a), 1(b), or 3(a) fails. Close call otherwise: when 2(a), 2(b), or 3(b) fails, or when any clause is a close call for itself. A close call is stated both ways at the verdict.

## 3. Design

- **Data-generating mechanism.** As in `pilot/preregistration.md`, section 3, and `pilot-b/preregistration.md`, section 3 (`SimulateCohort()`): 50 genes; genes 1 to 20 load 0.8 on the IFN factor $F$; genes 21 to 30 form a module with within-class noise correlation 0.3 (plus the change in class 1 in network cells); genes 31 to 50 load 0.4 on composition; age and sex unrelated to class. IFN-only cells shift the mean of $F$ in class 1 and scale its standard deviation (moderate: 0.5 and 1.5; large: 1 and 2.25). Heavy-tailed noise: $t$ with 5 degrees of freedom divided by $\sqrt{5/3}$.
- **Cells (9).** $n$ is the size of class 1 and $\pi$ its share.

| Cell | Mechanism | Level | Stress | $\pi$ | $n$ |
|---|---|---|---|---|---|
| 1 | null | | | 0.5 | 80 |
| 2 | IFN only | large | | 0.5 | 80 |
| 3 | IFN only | moderate | | 0.5 | 80 |
| 4 | IFN only | large | $t_5$ noise | 0.5 | 80 |
| 5 | mean shift | 0.5 | | 0.3 | 80 |
| 6 | network | 0.4 | | 0.5 | 80 |
| 7 | network | 0.4 | | 0.5 | 40 |
| 8 | network | 0.2 | | 0.5 | 80 |
| 9 | network | 0.4 | $t_5$ noise | 0.5 | 80 |

- **Derived variables, inside each training fold.** As in the earlier pilots: the IFN score is the mean of genes 1 to 5 standardized by the training fold, and its residual on composition uses the training regression; the gene set $G$ is genes 6 to 50 (990 pairs); products, squares, and first-order edges use the training fold's correlation and standardization for both training and test samples; LIONESS edges of training samples use the training fold as reference, and test samples are scored by the add-one form.
- **Partial-correlation edges (new).** For each pair of $G$, the partial correlation given the IFN score and composition: the correlation of the residuals of the two genes on an intercept, the IFN score, and composition, fitted within the sample set. The LIONESS edge of a training sample is $N \rho - (N - 1) \rho_{(-q)}$, with $\rho$ from the training fold and $\rho_{(-q)}$ from the training fold without the sample, both computed directly; a test sample's edge is $(N + 1) \rho_{(+q)} - N \rho$, with $\rho_{(+q)}$ from the training fold with the sample added.
- **Methods.** Logistic regression: $R_0$ (age, sex, composition, residual IFN score), $R_1$ ($R_0$ with the squared residual score and squared composition). Elastic net (`cv.glmnet`, mixing 0.5, 5 inner folds, binomial deviance, `lambda.min`, the $R_1$ terms with penalty factor 0): E1 (the 45 genes); E5 (the genes and their 1,035 products and squares); F1 (the genes and the 990 first-order edges); N1 (the genes and the 990 LIONESS edges); N2 (the genes and the 990 partial-correlation edges); and N1 with $R_0$ (the 990 LIONESS edges, the $R_0$ terms unpenalized). Regularized discriminant analysis, E4, on the 45 genes with composition and the residual IFN score, $\lambda$ and $\gamma$ on the grid 0, 0.25, ..., 1 chosen by inner 5-fold cross-validation on AUC (the discriminant forms the squares itself, so the squared terms of $R_1$ are not added). Outer 5-fold cross-validation stratified by class.
- **Measures.** $A(M)$ for the nine models; $\Delta_1$, $\Delta_2$, $G_2$; and, judged in no clause: the artifact $A(\text{N1 with } R_0) - A(R_0)$; the parametrization effect $A(\text{N1}) - A(\text{E5})$; $A(\text{E4}) - A(\text{E1})$; $A(\text{N2}) - A(\text{N1})$; in the mean-shift cell, the class difference in mean edge against proposal equation (3).
- **Replicates per cell.** From a timing run of ten replicates per cell with the workers loaded: 200 if the projected run fits one hour on three cores, otherwise the largest multiple of 20 that fits, not below 60; entered in section 6 and committed before the run.
- **Seeds.** Cell $c$ has seed $20361103 + 1000c$, at least 75,000 above every seed of the first two pilots, so that no replicate stream (cell seed plus 1 to 200) overlaps theirs; replicate $r$ uses the cell seed plus $r$.
- **Cells with a known answer.** Cell 1 (every AUC near 0.5); cell 5 (equation 3). Tests: the exact edges against literal LIONESS; the partial-correlation edges against a literal leave-one-out implementation through the inverse covariance matrix, and against the Pearson edges when the conditioning set is empty.
- **Time box.** One hour of compute on three cores.

## 4. What is reported whatever the outcome

The AUC of every model in every cell with its MCSE; every quantity of section 3, "Measures", in every cell; the verdict table clause by clause; the known-answer table; one figure of the differences by cell (`pilot-c/results/auc_gains.png`).

## 5. Readings of open cases

- 2026-11-06, before the run. "In every cell" (clause 1(b)) includes the null and IFN-only cells, where N1 and F1 may both add nothing to E1; clause 1(a) is the guard against passing on two nulls.
- 2026-11-06, before the run. Clauses 3(a) and 3(b) are two-sided as written: a value below $-\max(0.01, 3\,\text{MCSE})$ fails as a value above it does.

## 6. Amendments before the run

- 2026-11-06, after the timing run and before the run. Replicates per cell: 200. The timing run (10 replicates per cell, three workers loaded, the run's own scheduling; `pilot-c/results/timing.rds`) took 174 seconds, which projects 200 replicates to about 3,480 seconds, within the one-hour box. At 200 replicates the MCSE of a difference with replicate standard deviation 0.04 is about 0.003.
