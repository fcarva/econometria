# Números da Lista 1 feitos à mão e a reprodução dos outputs das provas.
.d <- getwd(); while (!file.exists(file.path(.d, ".repo-root")) && dirname(.d) != .d) .d <- dirname(.d)
source(file.path(.d, "R", "raiz.R"))
suppressPackageStartupMessages({ library(AER); library(sandwich) })

test_that("ex. 34: a conta matricial à mão fecha", {
  y <- c(2, 3, 5, 4, 6)
  X <- cbind(1, c(2, 4, 6, 8, 10))
  aj <- mqo(y, X)
  expect_equal(as.numeric(crossprod(X)), c(5, 30, 30, 220))
  expect_equal(det(crossprod(X)), 200)
  expect_equal(aj$b, c(1.3, 0.45))
  expect_equal(sum(aj$e^2), 1.9)
  expect_equal(aj$s2, 1.9 / 3)
  expect_equal(sum(aj$e), 0)
  expect_equal(1 - sum(aj$e^2) / sum((y - mean(y))^2), 0.81)
})

test_that("ex. 35: colinearidade perfeita torna X'X singular", {
  X <- cbind(1, c(2, 4, 6, 8), c(4, 8, 12, 16))
  expect_equal(qr(X)$rank, 2)
  expect_equal(det(crossprod(X)), 0, tolerance = 1e-8)
  expect_error(solve(crossprod(X)), regexp = NULL)
})

test_that("ex. 40: função de produção à mão", {
  Y <- c(0.58, 1.10, 1.20, 1.30, 1.95, 2.55, 2.60, 2.90, 3.45, 3.50, 3.60, 4.10, 4.35, 4.40, 4.50)
  X <- 1:15
  Sxx <- sum((X - mean(X))^2); Sxy <- sum((X - mean(X)) * (Y - mean(Y)))
  b2 <- Sxy / Sxx; b1 <- mean(Y) - b2 * mean(X)
  expect_equal(Sxx, 280)
  expect_equal(Sxy, 81.89)
  expect_equal(b2, 0.292464285714, tolerance = 1e-9)
  expect_equal(b1, 0.465619047619, tolerance = 1e-9)
  expect_equal(b1 + b2 * 20, 6.3149047619, tolerance = 1e-9)
  expect_equal(b2 * mean(X) / mean(Y), 0.834023628, tolerance = 1e-8)
})

test_that("ex. 50: o RESET do enunciado NÃO rejeita (a chave erra)", {
  f <- 2.284568; f_crit <- 4.10
  expect_lt(f, f_crit)
  expect_gt(pf(f, 2, 10, lower.tail = FALSE), 0.05)
})

test_that("ex. 46f: os dois valores de JB levam à mesma decisão", {
  crit <- qchisq(0.95, 2)
  expect_gt(18.870682, crit)     # valor impresso na lista
  expect_gt(10.48190, crit)      # valor impresso na chave
})

test_that("P1 2025/2 Q1: PSID7682 reproduz o output da prova", {
  data("PSID7682", package = "AER")
  m <- lm(log(wage) ~ education + experience + I(experience^2) + occupation +
            industry + south + smsa + ethnicity + weeks, data = PSID7682)
  s <- summary(m)
  expect_equal(nobs(m), 4165)
  expect_equal(s$r.squared, 0.3446066, tolerance = 1e-6)
  expect_equal(s$adj.r.squared, 0.3431870, tolerance = 1e-6)
  expect_equal(sum(residuals(m)^2), 581.2717, tolerance = 1e-3)
  expect_equal(s$sigma, 0.3740280, tolerance = 1e-6)
  expect_equal(unname(s$coefficients["experience", 3]), 18.677, tolerance = 1e-3)
  a3 <- unname(coef(m)["experience"]); a4 <- unname(coef(m)["I(experience^2)"])
  expect_equal(-a3 / (2 * a4), 30.3071, tolerance = 1e-3)
})

test_that("Lista 1 ex. 67: CigarettesSW reproduz os diagnósticos", {
  data("CigarettesSW", package = "AER")
  d <- subset(CigarettesSW, year == "1995")
  d$rprice <- d$price / d$cpi
  d$rincome <- d$income / d$population / d$cpi
  d$tdiff <- (d$taxs - d$tax) / d$cpi
  iv <- ivreg(log(packs) ~ log(rprice) + log(rincome) |
                log(rincome) + tdiff + I(tax / d$cpi), data = d)
  s_rob <- summary(iv, vcov = sandwich, df = Inf, diagnostics = TRUE)
  diag_rob <- s_rob$diagnostics
  expect_equal(nobs(iv), 48)
  expect_equal(unname(coef(iv)["log(rprice)"]), -1.27742413, tolerance = 1e-6)
  expect_equal(unname(diag_rob["Weak instruments", "statistic"]), 228.738, tolerance = 1e-3)
  expect_equal(unname(diag_rob["Wu-Hausman", "statistic"]), 3.823, tolerance = 1e-3)
  expect_equal(unname(diag_rob["Sargan", "statistic"]), 0.333, tolerance = 1e-3)
  expect_equal(unname(diag_rob["Wu-Hausman", "p-value"]), 0.0569, tolerance = 1e-3)
})
