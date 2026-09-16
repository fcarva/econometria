# Variáveis instrumentais, MQ2E, atenuação, armadilha da dummy, Chow e DiD.
.d <- getwd(); while (!file.exists(file.path(.d, ".repo-root")) && dirname(.d) != .d) .d <- dirname(.d)
source(file.path(.d, "R", "raiz.R"))
suppressPackageStartupMessages(library(AER))

set.seed(303)
n <- 500
z1 <- rnorm(n); z2 <- rnorm(n); u <- rnorm(n)
x <- 0.8 * z1 + 0.5 * z2 + u + rnorm(n, 0, 0.5)     # endógeno: compartilha u
y <- 1 + 2 * x + u + rnorm(n, 0, 0.5)

test_that("VI exatamente identificado: (Z'X)^{-1}Z'y é o que o ivreg devolve", {
  Z <- cbind(1, z1); X <- cbind(1, x)
  b_mao <- as.numeric(solve(crossprod(Z, X)) %*% crossprod(Z, y))
  b_ivreg <- unname(coef(ivreg(y ~ x | z1)))
  expect_equal(b_mao, b_ivreg)
})

test_that("com Z = X o VI colapsa no MQO", {
  expect_equal(unname(coef(ivreg(y ~ x | x))), unname(coef(lm(y ~ x))))
})

test_that("MQ2E: coeficientes iguais aos do segundo estágio manual", {
  primeiro <- lm(x ~ z1 + z2)
  segundo <- lm(y ~ fitted(primeiro))
  expect_equal(unname(coef(segundo)), unname(coef(ivreg(y ~ x | z1 + z2))))
})

test_that("os erros-padrão do segundo estágio ingênuo são diferentes", {
  primeiro <- lm(x ~ z1 + z2)
  segundo <- lm(y ~ fitted(primeiro))
  ep_ingenuo <- summary(segundo)$coefficients[2, 2]
  ep_correto <- summary(ivreg(y ~ x | z1 + z2))$coefficients[2, 2]
  expect_false(isTRUE(all.equal(ep_ingenuo, ep_correto)))
})

test_that("MQO é inconsistente sob endogeneidade e o VI não", {
  b_mqo <- unname(coef(lm(y ~ x))[2])
  b_iv <- unname(coef(ivreg(y ~ x | z1 + z2))[2])
  expect_gt(abs(b_mqo - 2), abs(b_iv - 2))
})

test_that("atenuação por erro de medição bate com o plim teórico", {
  set.seed(404)
  N <- 20000
  xstar <- rnorm(N, 0, sqrt(2)); w <- rnorm(N, 0, 1)
  yy <- 1 + 1 * xstar + rnorm(N, 0, 1)
  b <- unname(coef(lm(yy ~ I(xstar + w)))[2])
  lambda <- 2 / (2 + 1)
  expect_equal(b, lambda, tolerance = 0.02)
})

test_that("armadilha da dummy: posto incompleto", {
  d1 <- c(1, 0, 1, 0, 1); d2 <- 1 - d1
  Xtrap <- cbind(1, d1, d2)
  expect_lt(qr(Xtrap)$rank, ncol(Xtrap))
  expect_equal(qr(cbind(1, d1))$rank, 2)
})

test_that("Chow é o F do modelo totalmente interagido", {
  set.seed(505)
  m <- 80
  g <- rep(0:1, each = m / 2)
  xx <- rnorm(m)
  yy <- 1 + 2 * xx + g * (0.5 + 1.5 * xx) + rnorm(m, 0, 1)
  pooled <- lm(yy ~ xx)
  s1 <- lm(yy ~ xx, subset = g == 0); s2 <- lm(yy ~ xx, subset = g == 1)
  ssr_p <- sum(residuals(pooled)^2)
  ssr_12 <- sum(residuals(s1)^2) + sum(residuals(s2)^2)
  f_chow <- ((ssr_p - ssr_12) / 2) / (ssr_12 / (m - 4))
  interagido <- lm(yy ~ xx * g)
  expect_equal(f_chow, anova(pooled, interagido)$F[2])
})

test_that("DiD: regressão, médias e primeiras diferenças coincidem", {
  set.seed(606)
  N <- 300
  d <- rep(rbinom(N, 1, 0.5), each = 2)
  t <- rep(0:1, times = N)
  fe <- rep(rnorm(N), each = 2)
  yy <- 1 + 0.5 * d + 0.3 * t + 1.2 * d * t + fe + rnorm(2 * N, 0, 0.4)
  med <- tapply(yy, list(d, t), mean)
  did_medias <- (med["1", "1"] - med["1", "0"]) - (med["0", "1"] - med["0", "0"])
  did_reg <- unname(coef(lm(yy ~ d * t))["d:t"])
  expect_equal(did_medias, did_reg)
})
