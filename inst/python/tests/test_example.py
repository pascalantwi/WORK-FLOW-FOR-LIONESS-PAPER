"""Tests for projecttemplate.example, the twin of tests/testthat/test-example.R."""

from statistics import correlation

from projecttemplate.example import simulate_cohort


def test_simulate_cohort_matches_the_closed_form_pooled_correlation():
    # Derivation: with control fraction p, the pooled correlation of two genes
    # shifted by `shift` in the patients is
    #   (rho + p (1 - p) shift^2) / (1 + p (1 - p) shift^2).
    # A derivation is not trusted until a simulation agrees with it.
    rho, shift, p_ctrl, n = 0.5, 2, 0.2, 200_000
    d = simulate_cohort(int(n * p_ctrl), int(n * (1 - p_ctrl)), shift, rho, seed=1)

    between = p_ctrl * (1 - p_ctrl) * shift**2
    pooled = correlation(d["gene_a"], d["gene_b"])
    assert abs(pooled - (rho + between) / (1 + between)) < 0.01

    # Within a group the correlation is rho, not the pooled value.
    ctrl = [i for i, g in enumerate(d["group"]) if g == "control"]
    within = correlation([d["gene_a"][i] for i in ctrl], [d["gene_b"][i] for i in ctrl])
    assert abs(within - rho) < 0.03
    assert len(d["group"]) == n
