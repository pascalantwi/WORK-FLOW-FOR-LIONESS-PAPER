"""Stage 1 refinement checks (log/01-idea-review.md, D11 to D14). Needs numpy.

D11: exact closed form of the LIONESS Pearson edge.
D12: exact closed form of the LIONESS partial-correlation edge (rank-one downdate).
D13: group means of LIONESS edges under a pure mean shift, against the (1 - 2*pi) formula.
D14: LIONESS edge for a test sample against a training reference, exact form.
"""
import numpy as np

rng = np.random.default_rng(20261103)


def LionessPearson(x, y):
    n = len(x); r = np.corrcoef(x, y)[0, 1]
    loo = np.array([np.corrcoef(np.delete(x, q), np.delete(y, q))[0, 1] for q in range(n)])
    return n * r - (n - 1) * loo


def ExactPearson(x, y):
    # z standardized with divisor N; a = 1/(N-1)
    n = len(x); r = np.corrcoef(x, y)[0, 1]; a = 1 / (n - 1)
    zx = (x - x.mean()) / x.std(); zy = (y - y.mean()) / y.std()
    r_loo = (r - a * zx * zy) / np.sqrt((1 - a * zx**2) * (1 - a * zy**2))
    return n * r - (n - 1) * r_loo


def Pcor(X):
    om = np.linalg.inv(np.cov(X, rowvar=False)); return -om[0, 1] / np.sqrt(om[0, 0] * om[1, 1])


def LionessPcor(X):
    n = X.shape[0]; r = Pcor(X)
    return n * r - (n - 1) * np.array([Pcor(np.delete(X, q, axis=0)) for q in range(n)])


def ExactPcor(X):
    n = X.shape[0]; Xc = X - X.mean(0); om = np.linalg.inv(Xc.T @ Xc / n)
    r = -om[0, 1] / np.sqrt(om[0, 0] * om[1, 1])
    u = Xc @ om; m = np.einsum("ij,ij->i", u, Xc)            # m_q: squared Mahalanobis distance
    e = u / np.sqrt(np.diag(om)); c = 1 / (n - 1 - m)
    r_loo = (r - c * e[:, 0] * e[:, 1]) / np.sqrt((1 + c * e[:, 0]**2) * (1 + c * e[:, 1]**2))
    first = r + e[:, 0] * e[:, 1] + r * (e[:, 0]**2 + e[:, 1]**2) / 2
    scaled = r + (n - 1) * c * (e[:, 0] * e[:, 1] + r * (e[:, 0]**2 + e[:, 1]**2) / 2)
    return n * r - (n - 1) * r_loo, first, scaled, m


print("D11 Pearson exact form: max |LIONESS - exact|")
for n in [10, 50, 500]:
    for rho in [0, 0.7]:
        Z = rng.multivariate_normal([0, 0], [[1, rho], [rho, 1]], size=n)
        Z[0] *= 6                                             # one outlier
        print(f"  N={n:4d} rho={rho}: {np.abs(LionessPearson(*Z.T) - ExactPearson(*Z.T)).max():.2e}")

print("D12 partial correlation: max |LIONESS - exact|, cor with first-order, cor with Mahalanobis-scaled form")
for p, n in [(4, 50), (10, 50), (30, 50), (30, 100), (45, 50)]:
    A = rng.normal(size=(p, p)); C = np.linalg.inv(A @ A.T + p * np.eye(p))
    X = rng.multivariate_normal(np.zeros(p), C, size=n)
    e = LionessPcor(X); ex, first, scaled, m = ExactPcor(X)
    print(f"  p={p:2d} N={n:3d}: exact err {np.abs(e - ex).max():.1e}; first-order cor {np.corrcoef(e, first)[0,1]:.4f} "
          f"max err {np.abs(e-first).max():6.3f}; scaled cor {np.corrcoef(e, scaled)[0,1]:.5f} max err {np.abs(e-scaled).max():6.3f}; "
          f"mean m/(N-1) {m.mean()/(n-1):.2f}")

print("D13 mean shift only: mean edge in group 1 minus group 0, against (1-2pi)[d_i d_j - r/2 (d_i^2+d_j^2)]")
for pi in [0.5, 0.3, 0.15]:
    diffs, preds = [], []
    for rep in range(400):
        n = 200; n1 = int(pi * n); g = np.r_[np.ones(n1), np.zeros(n - n1)]
        Delta = np.array([1.0, 0.6])
        X = rng.normal(size=(n, 2)) + np.outer(g, Delta)     # no co-expression in either group
        e = ExactPearson(*X.T); r = np.corrcoef(*X.T)[0, 1]
        d = Delta / X.std(0)                                  # mean difference in pooled SD units
        diffs.append(e[g == 1].mean() - e[g == 0].mean())
        preds.append((1 - 2 * pi) * (d[0] * d[1] - r / 2 * (d[0]**2 + d[1]**2)))
    diffs, preds = np.array(diffs), np.array(preds)
    print(f"  pi={pi:.2f}: observed {diffs.mean():.4f} (MCSE {diffs.std()/np.sqrt(len(diffs)):.4f}); formula {preds.mean():.4f}")

print("D14 test sample against a training reference: (N+1) r(train + q) - N r(train), exact form")
n = 80; Xtr = rng.multivariate_normal([0, 0], [[1, .5], [.5, 1]], size=n); xq = np.array([1.5, -0.7])
r_tr = np.corrcoef(*Xtr.T)[0, 1]; both = np.vstack([Xtr, xq]); r_all = np.corrcoef(*both.T)[0, 1]
direct = (n + 1) * r_all - n * r_tr
# exact form with the training moments: adding a point is the downdate run backwards
zx = (xq[0] - Xtr[:, 0].mean()) / Xtr[:, 0].std(); zy = (xq[1] - Xtr[:, 1].mean()) / Xtr[:, 1].std(); b = 1 / (n + 1)
r_add = (r_tr + b * zx * zy) / np.sqrt((1 + b * zx**2) * (1 + b * zy**2))
print(f"  direct {direct:.10f}; closed form {(n + 1) * r_add - n * r_tr:.10f}; first order {r_tr + zx*zy - r_tr*(zx**2+zy**2)/2:.4f}")
