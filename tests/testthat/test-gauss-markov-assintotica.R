# Gauss-Markov, E[s²] = sigma², covariância robusta HC0 e consistência.
.d <- getwd(); while (!file.exists(file.path(.d, ".repo-root")) && dirname(.d) != .d) .d <- dirname(.d)
source(file.path(.d, "R", "raiz.R"))
suppressPackageStartupMessages(library(sandwich))

test_that("Var(b) simulada bate com sigma²(X'X)^{-1} e E[s²] = sigma²", {
  set.seed(707)
  n <- 30; sigma <- 2
  X <- cbind(1, runif(n, 0, 10))
  beta <- c(1, 0.5)
  R <- 4000
  bs <- matrix(NA_real_, R, 2); s2s <- numeric(R)
  XtX_inv <- solve(crossprod(X))
  for (r in seq_len(R)) {
    yy <- X %*% beta + rnorm(n, 0, sigma)
    aj <- mqo(yy, X)
    bs[r, ] <- aj$b; s2s[r] <- aj$s2
  }
  teo <- sigma^2 * XtX_inv
  expect_equal(mean(bs[, 2]), beta[2], tolerance = 0.01)
  expect_equal(var(bs[, 2]), teo[2, 2], tolerance = 0.06)
  expect_equal(mean(s2s), sigma^2, tolerance = 0.05)
})

test_that("um competidor linear e não viesado tem variância maior", {
  set.seed(808)
  n <- 20; sigma <- 1
  x <- seq(1, 10, length.out = n)
  X <- cbind(1, x)
  beta <- c(2, 1)
  R <- 4000
  b_mqo <- numeric(R); b_alt <- numeric(R)
  for (r in seq_len(R)) {
    yy <- as.numeric(X %*% beta + rnorm(n, 0, sigma))
    b_mqo[r] <- mqo(yy, X)$b[2]
    # estimador alternativo: inclinação pelos pontos extremos (linear e não viesado)
    b_alt[r] <- (yy[n] - yy[1]) / (x[n] - x[1])
  }
  expect_equal(mean(b_alt), beta[2], tolerance = 0.03)   # não viesado
  expect_gt(var(b_alt), var(b_mqo))                      # porém menos eficiente
})

test_that("HC0 calculado à mão é igual ao do sandwich", {
  set.seed(909)
  n <- 150
  x <- runif(n, 1, 10)
  y <- 1 + 0.5 * x + rnorm(n, 0, x / 3)
  m <- lm(y ~ x)
  V_mao <- vcov_hc0(model.matrix(m), residuals(m))
  expect_equal(unname(V_mao), unname(vcovHC(m, type = "HC0")))
})

test_that("consistência: o desvio-padrão de b cai com a raiz de n", {
  set.seed(1010)
  dp <- sapply(c(50, 200, 800), function(n) {
    b <- replicate(600, {
      x <- runif(n, 0, 5)
      y <- 1 + 2 * x + rnorm(n, 0, 2)
      coef(lm(y ~ x))[2]
    })
    sd(b)
  })
  expect_lt(dp[2], dp[1])
  expect_lt(dp[3], dp[2])
  expect_equal(dp[1] / dp[2], 2, tolerance = 0.25)   # razão esperada sqrt(4) = 2
})

test_that("a média amostral é consistente (Chebyshev na prática)", {
  set.seed(1111)
  p <- sapply(c(20, 100, 500), function(n) mean(replicate(3000, abs(mean(rnorm(n, 2, 2)) - 2) >= 0.5)))
  expect_lt(p[2], p[1])
  expect_lt(p[3], p[2])
})
