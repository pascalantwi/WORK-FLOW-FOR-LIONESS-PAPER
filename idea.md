# Idea: What is a LIONESS edge, and does it add to expression when classifying SLE against RA?

## The idea in a paragraph

LIONESS single-sample network edges are read as each patient's own co-expression network and are compared between patient groups and used to classify patients. This project derives what a LIONESS edge is made of and tests the consequences. The exact LIONESS edge of a Pearson correlation has a closed form; to first order it is the reference correlation plus the product of the patient's two standardized expression values, minus a term in their squares, so an edge is a quadratic function of the patient's own expression. Three consequences are tested: edges and their first-order formula should classify patients equally well; a shared factor such as the interferon (IFN) signature enters edges as its square, so edges can look informative only because the comparison model lacks the squared IFN score; and unequal group sizes alone shift group means of edges by a factor $(1 - 2\pi)$. The tests are a simulation study and the classification of systemic lupus erythematosus (SLE) against rheumatoid arthritis (RA) from whole-blood transcriptomes, in all patients together with the IFN score as a continuous variable. LIONESS must beat a nested set of models built on one base: clinical and composition covariates, the residual IFN score and its square, and the gene levels (model E1); the richer models add one feature set each to E1 (quadratic discriminant analysis beside them).

## Question

Is a LIONESS co-expression edge anything more than a closed-form quadratic function of each sample's own expression? And when classifying SLE against RA from whole blood, do LIONESS edges add information beyond the IFN score, its square, cell composition, the gene levels, and their own first-order features?

## Mechanism

The LIONESS edge $e_q = N r - (N - 1) r_{(-q)}$ equals, to first order, $r + z_{qi} z_{qj} - \tfrac{r}{2}(z_{qi}^2 + z_{qj}^2)$, the reference correlation plus the influence function of the correlation at the sample. Genes that share a factor $F$ give $z_{qi} z_{qj} \approx a_i a_j F_q^2$, so the edge carries $F^2$.

## Aims

1. Equivalence: do LIONESS edges and their first-order features give the same out-of-sample classification?
2. Artifact and fix: how much do edges gain only by carrying the squared IFN level, and does a baseline with the squared score remove that gain?
3. Parametrization: why does the edge form detect a real co-expression difference that the same information, entered as separate products and squares, does not?

## Models

B1 (age, sex, batch); B2 (B1 + composition); $R_0$ (B2 + residual IFN score); $R_1$ ($R_0$ + squared residual IFN score + squared composition); E1 ($R_1$ + gene levels, the base); E4 (regularized discriminant analysis); E5, F1, N1, N2 (E1 + products and squares, first-order edges, LIONESS edges, and partial-correlation LIONESS edges given the IFN score and composition); N1 with $R_0$ outside the nesting, to show the artifact. SSN, iENA, SWEET, BONOBO, random forests, shrinkage linear discriminant analysis, module eigengenes, and differential-correlation pairs are not fitted.

## Data

PRECISESADS (whole-blood RNA-seq, flow cytometry, treatment, 18 centres; controlled access) for the application; GSE17755 and GSE235508 for replication of the simulation's findings inside each dataset; validation on the PRECISESADS inception cohort, or leave-centre-out.

## Notes

Rewritten 2026-11-06 from the refined proposal (`proposal-new/proposal.md`). The first version of this file (IFN-low and IFN-high strata, seventeen models) is in the git history and in the revision record of `proposal.md`.
