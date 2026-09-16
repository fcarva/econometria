# Identidades algébricas do MQO: P, M, resíduos e decomposição da variação.
.d <- getwd(); while (!file.exists(file.path(.d, ".repo-root")) && dirname(.d) != .d) .d <- dirname(.d)
source(file.path(.d, "R", "raiz.R"))

set.seed(101)
n <- 40; K <- 4
X <- cbind(1, matrix(rnorm(n * (K - 1)), n, K - 1))
y <- X %*% c(2, -1, 0.5, 3) + rnorm(n, 0, 2)
aj <- mqo(y, X)
P <- matriz_P(X); M <- matriz_M(X)

test_that("P e M são simétricas e idempotentes", {
  expect_equal(P, t(P))
  expect_equal(M, t(M))
  expect_equal(P %*% P, P)
  expect_equal(M %*% M, M)
})

test_that("P e M projetam nos espaços certos", {
  expect_equal(P %*% X, X)
  expect_equal(M %*% X, matrix(0, n, K))
  expect_equal(P %*% M, matrix(0, n, n))
  expect_equal(P + M, diag(n))
})

test_that("os traços dão K e n-K", {
  expect_equal(sum(diag(P)), K)
  expect_equal(sum(diag(M)), n - K)
})

test_that("resíduos e ajustados saem de M e P", {
  expect_equal(as.numeric(M %*% y), aj$e)
  expect_equal(as.numeric(P %*% y), as.numeric(y) - aj$e)
})

test_that("ortogonalidade e somas dos resíduos", {
  expect_equal(as.numeric(crossprod(X, aj$e)), rep(0, K))
  expect_equal(sum(aj$e), 0)
  expect_equal(mean(as.numeric(X %*% aj$b)), mean(y))
})

test_that("e'e = y'y - b'X'y e a decomposição SQT = SQE + SQR", {
  expect_equal(sum(aj$e^2), as.numeric(crossprod(y) - crossprod(aj$b, crossprod(X, y))))
  M0 <- matriz_M0(n)
  sqt <- as.numeric(t(y) %*% M0 %*% y)
  sqr <- sum(aj$e^2)
  yhat <- as.numeric(X %*% aj$b)
  sqe <- as.numeric(t(yhat) %*% M0 %*% yhat)
  expect_equal(sqt, sqe + sqr)
})

test_that("e = M epsilon: os resíduos dependem só do erro", {
  eps <- rnorm(n, 0, 2)
  y2 <- X %*% c(1, 2, 3, 4) + eps
  expect_equal(as.numeric(matriz_M(X) %*% y2), as.numeric(matriz_M(X) %*% eps))
})
