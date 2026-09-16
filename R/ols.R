# Helpers de álgebra do MQO usados pelos testes e pelos scripts dos módulos.
# Só definições, sem efeitos colaterais: este arquivo é carregado por R/raiz.R.

# MQO na mão, a partir de y e X (X já com a coluna de 1s, se for o caso).
mqo <- function(y, X) {
  X <- as.matrix(X); y <- as.numeric(y)
  XtX_inv <- solve(crossprod(X))
  b <- as.numeric(XtX_inv %*% crossprod(X, y))
  e <- as.numeric(y - X %*% b)
  n <- nrow(X); K <- ncol(X)
  s2 <- sum(e^2) / (n - K)
  list(b = b, e = e, s2 = s2, V = s2 * XtX_inv, n = n, K = K, gl = n - K,
       XtX_inv = XtX_inv)
}

# Matriz de projeção P = X(X'X)^{-1}X'
matriz_P <- function(X) { X <- as.matrix(X); X %*% solve(crossprod(X)) %*% t(X) }

# Matriz geradora de resíduos M = I - P
matriz_M <- function(X) { X <- as.matrix(X); diag(nrow(X)) - matriz_P(X) }

# Matriz de centragem M0 = I - (1/n) i i'
matriz_M0 <- function(n) diag(n) - matrix(1 / n, n, n)

# F de restrições a partir das duas somas de quadrados
f_restrito <- function(ssr_r, ssr_u, J, n, K) ((ssr_r - ssr_u) / J) / (ssr_u / (n - K))

# F global a partir do R²
f_r2 <- function(r2, n, K) (r2 / (K - 1)) / ((1 - r2) / (n - K))

# R² ajustado
r2_ajustado <- function(r2, n, K) 1 - (n - 1) / (n - K) * (1 - r2)

# FIV de cada coluna de X (excluindo a constante, se houver)
fiv_manual <- function(X) {
  X <- as.matrix(X)
  const <- apply(X, 2, function(col) all(abs(col - col[1]) < 1e-12))
  cols <- which(!const)
  sapply(cols, function(k) {
    outros <- X[, setdiff(seq_len(ncol(X)), k), drop = FALSE]
    r2 <- summary(lm(X[, k] ~ outros - 1 + 1))$r.squared
    1 / (1 - r2)
  })
}

# Covariância robusta de White (HC0)
vcov_hc0 <- function(X, e) {
  X <- as.matrix(X)
  XtX_inv <- solve(crossprod(X))
  XtX_inv %*% crossprod(X * as.numeric(e)) %*% XtX_inv
}
