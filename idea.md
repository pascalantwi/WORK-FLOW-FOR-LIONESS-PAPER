# Idea: When do LIONESS single-sample networks add information in IFN-stratified SLE and RA?

## The idea in a paragraph

This study provides a rigorous evaluation of single-sample networks in a difficult clinical setting, establishing whether and when LIONESS adds information beyond the IFN score, clinical and cell-composition baselines, expression-based classifiers and established co-expression network methods. To interpret the edges, a first-order approximation of the LIONESS edge is given for Pearson and partial correlation, which shows that an edge is mainly the product of the sample's standardized deviations from the reference mean, plus a term that depends on the reference correlation, and therefore indicates which expression-based models a network method must be compared with. On this basis, single-sample networks are compared with seventeen models within one nested cross-validation framework, including baselines, expression-based classifiers, quadratic discriminant analysis and established network methods, with the primary comparison made against a reference model that already contains the residual IFN score. Safeguards against false network signals are built into the design through conditioning on the IFN score, controls matched on the IFN score, exclusion of treated patients and adjustment for batch. The pipeline is applied to IFN-low SLE and with IFN-low RA and IFN-High SLE and with IFN-high RA.

## Question

Do LIONESS single-sample network edges (Pearson and partial correlation) improve the classification of SLE against RA, within IFN-low and within IFN-high strata, over a reference model that already contains the residual IFN score, clinical covariates, and cell composition?

## Mechanism

A first-order approximation of the LIONESS edge, for Pearson and partial correlation: the edge is mainly the product of the sample's standardized deviations from the reference mean, plus a term that depends on the reference correlation. So a LIONESS edge is close to a quadratic function of the sample's own expression, which says which expression-based models (for example quadratic discriminant analysis) a network method must be compared with.

## Aims

1. Give the first-order approximation of the LIONESS edge for Pearson and partial correlation, and use it to interpret edges.
2. Compare single-sample networks with seventeen models in one nested cross-validation framework (baselines, expression-based classifiers, quadratic discriminant analysis, established network methods), the primary comparison being against a reference model that already contains the residual IFN score.
3. Apply the pipeline to IFN-low SLE against IFN-low RA, and to IFN-high SLE against IFN-high RA, with safeguards against false network signals: conditioning on the IFN score, controls matched on the IFN score, exclusion of treated patients, and adjustment for batch.

## Literature

Kuijjer, Tung, Yuan, Quackenbush, and Glass (2019), "Estimating sample-specific regulatory networks", iScience 14, 226-240 (LIONESS).

## Your own prior work

The repository pascalantwi/lioness-network-analysis: a LIONESS pipeline with Pearson correlation (lionessR, limma on edges), rebuilt from raw GEO data on the osteosarcoma cohort of Kuijjer et al. (GSE42352 / GSE33382, 84 pre-chemotherapy biopsies, 53 with known metastasis follow-up) as a proof of concept before moving to lupus data.

## Data

[Not yet named: whole-blood or PBMC expression of SLE and RA patients with an IFN score, treatment status, batch, and cell composition available or estimable.]

## Theory

The first-order approximation above, stated without derivation.

## Notes

Supervised by Dr Tyler Grimes. The reference list is kept in Markdown (`references/references.md`); no Zotero.
