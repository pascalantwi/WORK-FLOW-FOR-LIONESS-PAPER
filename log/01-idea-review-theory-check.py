"""Stage 1 theory check (log/01-idea-review.md, D5). Run: python3 -I log/01-idea-review-theory-check.py (needs numpy)."""
import numpy as np

def pearson(x, y):
    return np.corrcoef(x, y)[0, 1]

def lioness_pearson(x, y):
    n = len(x); r = pearson(x, y)
    loo = np.array([pearson(np.delete(x, q), np.delete(y, q)) for q in range(n)])
    return n * r - (n - 1) * loo, r

def approx_pearson(x, y, r):
    zx = (x - x.mean()) / x.std(); zy = (y - y.mean()) / y.std()   # 1/N standardization
    return r + zx * zy - r * (zx**2 + zy**2) / 2, zx * zy

def pcor(X, i=0, j=1):
    om = np.linalg.inv(np.cov(X, rowvar=False))
    return -om[i, j] / np.sqrt(om[i, i] * om[j, j])

def lioness_pcor(X):
    n = X.shape[0]; r = pcor(X)
    loo = np.array([pcor(np.delete(X, q, axis=0)) for q in range(n)])
    return n * r - (n - 1) * loo, r

def approx_pcor(X, r):
    Xc = X - X.mean(0); S = Xc.T @ Xc / len(X); om = np.linalg.inv(S)
    eps = (Xc @ om) / np.sqrt(np.diag(om))          # standardized residuals of each gene on the others
    e1, e2 = eps[:, 0], eps[:, 1]
    return r + e1 * e2 - r * (e1**2 + e2**2) / 2

rng = np.random.default_rng(20261103)
print("PEARSON  dist   rho   N   cor(exact,approx)  max|exact-approx|  sd(exact)  cor(exact, zx*zy)")
for dist in ["normal", "t3"]:
    for rho in [0.0, 0.5, 0.9]:
        for n in [20, 50, 100, 500]:
            C = np.array([[1, rho], [rho, 1]])
            Z = rng.multivariate_normal([0, 0], C, size=n)
            if dist == "t3":
                Z = Z / np.sqrt(rng.chisquare(3, size=(n, 1)) / 3)
            e, r = lioness_pearson(Z[:, 0], Z[:, 1])
            a, prod = approx_pearson(Z[:, 0], Z[:, 1], r)
            print(f"  {dist:6s} {rho:4.1f} {n:4d}   {np.corrcoef(e, a)[0,1]:.5f}            {np.abs(e-a).max():8.4f}         {e.std():6.3f}     {np.corrcoef(e, prod)[0,1]:.4f}")

print("\nPARTIAL  p   N   cor(exact,approx)  max|exact-approx|  sd(exact)")
for p in [4, 10]:
    for n in [50, 100, 500]:
        A = rng.normal(size=(p, p)); om = A @ A.T + p * np.eye(p); C = np.linalg.inv(om)
        X = rng.multivariate_normal(np.zeros(p), C, size=n)
        e, r = lioness_pcor(X); a = approx_pcor(X, r)
        print(f"         {p:2d} {n:4d}   {np.corrcoef(e, a)[0,1]:.5f}            {np.abs(e-a).max():8.4f}         {e.std():6.3f}")

# Mechanism sketch: two IFN-driven genes, groups differ only in the IFN factor's spread, not in co-expression given F
print("\nIFN SKETCH: x_k = a*F + e_k, same conditional independence in both groups; group B has larger var(F)")
n = 200; a = 1.0
F = np.r_[rng.normal(0, 0.5, n // 2), rng.normal(0, 1.5, n // 2)]
g = np.r_[np.zeros(n // 2), np.ones(n // 2)]
X = np.c_[a * F + rng.normal(size=n), a * F + rng.normal(size=n)]
e, r = lioness_pearson(X[:, 0], X[:, 1])
print(f"  mean LIONESS edge, group A {e[g==0].mean():.3f}, group B {e[g==1].mean():.3f}; cor(edge, F^2) = {np.corrcoef(e, F**2)[0,1]:.3f}")
R = X - np.outer(F, np.linalg.lstsq(np.c_[F], X, rcond=None)[0].ravel())   # condition on F
e2, _ = lioness_pearson(R[:, 0], R[:, 1])
print(f"  after conditioning on F: group A {e2[g==0].mean():.3f}, group B {e2[g==1].mean():.3f}; cor(edge, F^2) = {np.corrcoef(e2, F**2)[0,1]:.3f}")

# ---- corrected partial-correlation forms (D6) ----
def approx_pcor_resid(X, r):
    # residuals of genes 1 and 2 on the conditioning set S (genes 3..p), 1/N standardized
    Xc = X - X.mean(0); S_ = Xc[:, 2:]
    B = np.linalg.lstsq(S_, Xc[:, :2], rcond=None)[0]; R = Xc[:, :2] - S_ @ B
    h = R / R.std(0)
    return r + h[:, 0] * h[:, 1] - r * (h[:, 0]**2 + h[:, 1]**2) / 2
def approx_pcor_prec(X, r):
    Xc = X - X.mean(0); om = np.linalg.inv(Xc.T @ Xc / len(X))
    eps = (Xc @ om) / np.sqrt(np.diag(om))
    return r + eps[:, 0] * eps[:, 1] + r * (eps[:, 0]**2 + eps[:, 1]**2) / 2
rng = np.random.default_rng(20261103)
print("PARTIAL  p   N   cor(exact,resid-form)  max|err|   cor(exact,precision-form)  max|err|  sd(exact)")
for p in [4, 10, 30]:
    for n in [50, 100, 500]:
        A = rng.normal(size=(p, p)); om = A @ A.T + p * np.eye(p); C = np.linalg.inv(om)
        X = rng.multivariate_normal(np.zeros(p), C, size=n)
        e, r = lioness_pcor(X); a1 = approx_pcor_resid(X, r); a2 = approx_pcor_prec(X, r)
        print(f"         {p:2d} {n:4d}   {np.corrcoef(e,a1)[0,1]:.5f}             {np.abs(e-a1).max():7.4f}    {np.corrcoef(e,a2)[0,1]:.5f}                {np.abs(e-a2).max():7.4f}   {e.std():6.3f}")
