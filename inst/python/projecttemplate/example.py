"""Simulate a two-group cohort with two correlated genes.

The Python twin of R/example.R: the same data-generating mechanism, written
the way a function in inst/python/ is documented and tested. It is pure
Python. The template's one Python dependency is numpy, which reticulate needs
to pass arrays between R and Python; a project adds others with `uv add` when
a function earns them.
"""

import random


def simulate_cohort(n_ctrl, n_pat, shift, rho=0.5, seed=None):
    """Generate expression for two genes in a control and a patient group.

    Within each group the genes are standard normal with correlation ``rho``.
    The patients are shifted by ``shift`` standard deviations in both genes.
    Assumes bivariate normal genes with equal within-group variances.

    Args:
        n_ctrl: Number of control samples.
        n_pat: Number of patient samples.
        shift: Mean shift for patients, in within-group standard deviations.
        rho: Within-group correlation between the two genes.
        seed: Seed for the random draws; ``None`` takes a fresh seed from the
            system.

    Returns:
        A dict with the lists ``group`` (``"control"`` or ``"patient"``),
        ``gene_a``, and ``gene_b``, one entry per sample, controls first.
    """
    if n_ctrl < 1 or n_pat < 1 or not abs(rho) < 1:
        raise ValueError("n_ctrl and n_pat must be at least 1 and |rho| < 1")
    rng = random.Random(seed)
    scale = (1 - rho**2) ** 0.5
    group, gene_a, gene_b = [], [], []
    for i in range(n_ctrl + n_pat):
        patient = i >= n_ctrl
        z1 = rng.gauss(0, 1)
        z2 = rho * z1 + scale * rng.gauss(0, 1)
        group.append("patient" if patient else "control")
        gene_a.append(z1 + shift * patient)
        gene_b.append(z2 + shift * patient)
    return {"group": group, "gene_a": gene_a, "gene_b": gene_b}
