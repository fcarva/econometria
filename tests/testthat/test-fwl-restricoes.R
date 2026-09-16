# Frisch-Waugh-Lovell, viés de omissão, t² = F, F via R² e mínimos quadrados restritos.
.d <- getwd(); while (!file.exists(file.path(.d, ".repo-root")) && dirname(.d) != .d) .d <- dirname(.d)
source(file.path(.d, "R", "raiz.R"))

set.seed(202)
n <- 60
x1 <- rnorm(n); x2 <- 0.6 * x1 + rnorm(n); x3 <- rnorm(n)
y <- 1 + 2 * x1 + 1.5 * x2 - 0.8 * x3 + rnorm(n, 0, 1.5)

test_that("FWL: coeficiente e resíduos idênticos aos da regressão múltipla", {
  longa <- lm(y ~ x1 + x2 + x3)
  M1 <- matriz_M(cbind(1, x1, x3))
  y_lim <- as.numeric(M1 %*% y)
  x2_lim <- as.numeric(M1 %*% x2)
  fwl <- lm(y_lim ~ x2_lim - 1)
  expect_equal(unname(coef(fwl)[1]), unname(coef(longa)["x2"]))
  expect_equal(unname(residuals(fwl)), unname(residuals(longa)))
})

test_that("FWL: limpar só o regressor basta para o coeficiente", {
  longa <- lm(y ~ x1 + x2 + x3)
  M1 <- matriz_M(cbind(1, x1, x3))
  x2_lim <- as.numeric(M1 %*% x2)
  expect_equal(unname(coef(lm(y ~ x2_lim - 1))[1]), unname(coef(longa)["x2"]))
})

test_that("incluir constante equivale a centrar as variáveis", {
  com_const <- lm(y ~ x1)
  centrado <- lm(I(y - mean(y)) ~ I(x1 - mean(x1)) - 1)
  expect_equal(unname(coef(centrado)[1]), unname(coef(com_const)[2]))
})

test_that("viés de omissão: identidade exata entre curta, longa e auxiliar", {
  curta <- lm(y ~ x1)
  longa <- lm(y ~ x1 + x2)
  aux <- lm(x2 ~ x1)
  expect_equal(unname(coef(curta)["x1"]),
               unname(coef(longa)["x1"] + coef(longa)["x2"] * coef(aux)["x1"]))
})

test_that("t² = F na regressão simples e F via R² bate com o anova", {
  m <- lm(y ~ x1)
  s <- summary(m)
  t2 <- s$coefficients[2, 3]^2
  expect_equal(t2, unname(s$fstatistic[1]))
  expect_equal(f_r2(s$r.squared, n, 2), unname(s$fstatistic[1]))
})

test_that("F restrito pelas somas de quadrados é o F do anova", {
  irrestrito <- lm(y ~ x1 + x2 + x3)
  restrito <- lm(y ~ x1)
  ssr_u <- sum(residuals(irrestrito)^2); ssr_r <- sum(residuals(restrito)^2)
  f_mao <- f_restrito(ssr_r, ssr_u, J = 2, n = n, K = 4)
  expect_equal(f_mao, anova(restrito, irrestrito)$F[2])
})

test_that("R² ajustado sobe se e só se |t| > 1", {
  m1 <- lm(y ~ x1 + x2)
  m2 <- lm(y ~ x1 + x2 + x3)
  t3 <- abs(summary(m2)$coefficients["x3", 3])
  subiu <- summary(m2)$adj.r.squared > summary(m1)$adj.r.squared
  expect_equal(subiu, t3 > 1)
})

test_that("R² é o quadrado da correlação entre y e o ajustado", {
  m <- lm(y ~ x1 + x2 + x3)
  expect_equal(summary(m)$r.squared, cor(y, fitted(m))^2)
})
