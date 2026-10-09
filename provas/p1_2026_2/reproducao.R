# P1 2026/2 (09/10/2026) — conferência numérica do gabarito.
#
# Reproduz todas as contas da Parte I (Q1 a Q4) e confere numericamente as três
# demonstrações da Parte II (Q5 Gauss-Markov, Q6 FWL, Q7 consistência) com dados
# simulados. Os números entram em resultados/p26.csv e são conferidos contra as
# tabelas "chave_R | nota" de provas/p1_2026_2/resolucao.md.
#
# Rodar: powershell -ExecutionPolicy Bypass -File scripts\r.ps1 provas\p1_2026_2\reproducao.R

# --- bootstrap: localizar a raiz do repo e carregar helpers ---
.d <- getwd(); while (!file.exists(file.path(.d, ".repo-root")) && dirname(.d) != .d) .d <- dirname(.d)
source(file.path(.d, "R", "raiz.R"))

# Para (status != 0) se uma identidade não valer
confere <- function(a, b, rotulo, tol = 1e-10) {
  if (max(abs(unname(a) - unname(b))) > tol) stop("Não bateu: ", rotulo)
  invisible(TRUE)
}

## ---- Q1: MQO matricial com 4 observações ----
y <- c(8, 7, 10, 14)
X <- unname(cbind(1, c(-3, -1, 1, 3), c(1, -1, -1, 1)))

XtX <- crossprod(X)              # (3 x 3)
Xty <- crossprod(X, y)           # (3 x 1)
XtX_inv <- solve(XtX)
b <- drop(XtX_inv %*% Xty)
Xty <- drop(Xty)
y_hat <- drop(X %*% b)
e <- y - y_hat
Xte <- drop(crossprod(X, e))

cat("\n=== Q1 ===\nX'X =\n"); print(XtX)
cat("X'y =", Xty, "\n(X'X)^{-1} diagonal =", diag(XtX_inv), "\n")
cat("b =", b, "\nresíduos =", e, "\nX'e =", round(Xte, 12), "\n")

confere(XtX[upper.tri(XtX)], 0, "colunas de X ortogonais (X'X diagonal)")
confere(Xte, 0, "X'e = 0 (equações normais)")
confere(b, unname(coef(lm(y ~ X[, 2] + X[, 3]))), "b matricial = lm()")

sqr1 <- sum(e^2); sqt1 <- sum((y - mean(y))^2)
registrar_varios(c(
  p26_q1_xtx11 = XtX[1, 1], p26_q1_xtx22 = XtX[2, 2], p26_q1_xtx33 = XtX[3, 3],
  p26_q1_xty1 = Xty[1], p26_q1_xty2 = Xty[2], p26_q1_xty3 = Xty[3],
  p26_q1_inv22 = XtX_inv[2, 2],
  p26_q1_b0 = b[1], p26_q1_b1 = b[2], p26_q1_b2 = b[3],
  p26_q1_e1 = e[1], p26_q1_e2 = e[2], p26_q1_e3 = e[3], p26_q1_e4 = e[4],
  p26_q1_yhat1 = y_hat[1], p26_q1_yhat4 = y_hat[4],
  p26_q1_sqr = sqr1, p26_q1_sqt = sqt1, p26_q1_r2 = 1 - sqr1 / sqt1,
  p26_q1_s2 = sqr1 / (length(y) - ncol(X))))

## ---- Q2: equação de log-salário (log-nível, quadrático em EXP) ----
e_prova <- 2.718                         # o enunciado manda usar e = 2,718
b_educ <- 0.0850; b_exp <- 0.0450; b_exp2 <- -0.0007; b_fem <- -0.1800; ep_fem <- 0.05
n2 <- 200; k2 <- 5

t_fem <- b_fem / ep_fem
sqr_r <- 128; sqr_ur <- 120; q2 <- 2
F2 <- ((sqr_r - sqr_ur) / q2) / (sqr_ur / (n2 - k2))
efm_10 <- b_exp + 2 * b_exp2 * 10
exp_max <- -b_exp / (2 * b_exp2)

cat("\n=== Q2 ===\nt(FEMALE) =", t_fem, " F =", F2, " efeito marginal em 10 anos =", efm_10,
    " ponto de reversão =", exp_max, "\n")

registrar_varios(c(
  p26_q2_educ_aprox = 100 * b_educ,
  p26_q2_educ_exato = 100 * (e_prova^b_educ - 1),
  p26_q2_fem_aprox = 100 * b_fem,
  p26_q2_fem_exato = 100 * (e_prova^b_fem - 1),
  p26_q2_t_fem = t_fem,
  p26_q2_F = F2,
  p26_q2_gl2 = n2 - k2,
  p26_q2_efm10 = efm_10,
  p26_q2_efm10_pct = 100 * efm_10,
  p26_q2_erro_comum = 100 * b_exp,                 # resposta que esquece o termo 2*b3*EXP
  p26_q2_exp_max = exp_max))

## ---- Q3: Chow com dummies de intercepto e de inclinação ----
sqr_r3 <- 240; sqr_ur3 <- 210; n3 <- 120; k3 <- 4; q3 <- 2
F3 <- ((sqr_r3 - sqr_ur3) / q3) / (sqr_ur3 / (n3 - k3))
cat("\n=== Q3 ===\nF =", F3, "(F_tab(2,116) = 3,08)\n")
registrar_varios(c(p26_q3_F = F3, p26_q3_num = (sqr_r3 - sqr_ur3) / q3,
                   p26_q3_den = sqr_ur3 / (n3 - k3), p26_q3_gl2 = n3 - k3))

## ---- Q4: VI no modelo simples, dados em desvios ----
szy <- 340; szx <- 85; ybar <- 50; xbar <- 8
b1_iv <- szy / szx
b0_iv <- ybar - b1_iv * xbar
cat("\n=== Q4 ===\nb1_IV =", b1_iv, " b0_IV =", b0_iv, "\n")
registrar_varios(c(p26_q4_b1iv = b1_iv, p26_q4_b0iv = b0_iv))

# Simulação: MQO inconsistente sob Cov(X,u) != 0, VI consistente com Z válido
set.seed(20261009)
n_sim <- 1e5
z <- rnorm(n_sim); v <- rnorm(n_sim); u <- 0.8 * v + rnorm(n_sim)
x <- 1 + 0.5 * z + v                       # Cov(X,u) = 0,8; Var(X) = 1,25
ysim <- 2 + 3 * x + u
b_mqo <- unname(coef(lm(ysim ~ x))[2])
b_iv_sim <- sum((z - mean(z)) * (ysim - mean(ysim))) / sum((z - mean(z)) * (x - mean(x)))
cat("Simulação (beta1 = 3): MQO =", b_mqo, " plim teórico = ", 3 + 0.8 / 1.25,
    " VI =", b_iv_sim, "\n")
registrar_varios(c(p26_q4_sim_mqo = b_mqo, p26_q4_sim_plim_mqo = 3 + 0.8 / 1.25,
                   p26_q4_sim_iv = b_iv_sim))

## ---- Q5: Gauss-Markov com b* = [(X'X)^{-1}X' + C]y ----
set.seed(5)
n5 <- 30; K5 <- 3; sigma2 <- 2
X5 <- cbind(1, matrix(rnorm(n5 * (K5 - 1)), n5))
P5 <- X5 %*% solve(crossprod(X5)) %*% t(X5)
M5 <- diag(n5) - P5
C <- matrix(rnorm(K5 * n5), K5) %*% M5        # qualquer C = A M satisfaz CX = 0
confere(C %*% X5, 0, "CX = 0", 1e-10)
A_star <- solve(crossprod(X5)) %*% t(X5) + C
var_star <- sigma2 * A_star %*% t(A_star)
var_mqo <- sigma2 * solve(crossprod(X5))
dif <- var_star - var_mqo
confere(dif, sigma2 * C %*% t(C), "Var(b*) - Var(b) = sigma^2 CC'", 1e-10)
autoval <- eigen(dif, symmetric = TRUE, only.values = TRUE)$values
if (min(autoval) < -1e-10) stop("A diferença não é semidefinida positiva")
cat("\n=== Q5 ===\nautovalores de sigma^2 CC':", round(autoval, 4), "(todos >= 0)\n")
registrar("p26_q5_min_autoval", max(min(autoval), 0))

## ---- Q6: Frisch-Waugh-Lovell ----
set.seed(6)
n6 <- 50
X1 <- cbind(1, rnorm(n6))
X2 <- cbind(rnorm(n6) + 0.5 * X1[, 2], rnorm(n6))
y6 <- drop(X1 %*% c(1, 2) + X2 %*% c(-1, 0.5) + rnorm(n6))
M1 <- diag(n6) - X1 %*% solve(crossprod(X1)) %*% t(X1)
confere(M1, t(M1), "M1 simétrica"); confere(M1 %*% M1, M1, "M1 idempotente")
b_completo <- unname(coef(lm(y6 ~ X1[, 2] + X2))[3:4])
b2_formula <- drop(solve(t(X2) %*% M1 %*% X2, t(X2) %*% M1 %*% y6))
b2_fwl <- unname(coef(lm(drop(M1 %*% y6) ~ M1 %*% X2 - 1)))
confere(b_completo, b2_formula, "b2 do modelo completo = (X2'M1X2)^{-1}X2'M1y")
confere(b2_formula, b2_fwl, "b2 = regressão de M1y em M1X2")
cat("\n=== Q6 ===\nb2 completo =", round(b_completo, 6), "| FWL =", round(b2_fwl, 6), "\n")
registrar("p26_q6_dif_fwl", max(abs(b_completo - b2_fwl)))

## ---- Q7: consistência de b ----
set.seed(7)
beta7 <- c(1, 2)
desvio <- sapply(c(50, 500, 5000, 50000), function(nn) {
  bs <- replicate(200, {
    xx <- rexp(nn); uu <- rt(nn, df = 5)     # erro não normal: consistência não usa H5
    unname(coef(lm(beta7[1] + beta7[2] * xx + uu ~ xx))[2])
  })
  mean(abs(bs - beta7[2]) > 0.05)            # estimativa de P(|b - beta| > 0,05)
})
cat("\n=== Q7 ===\nP(|b2 - beta2| > 0,05) para n = 50, 500, 5000, 50000:", desvio, "\n")
if (desvio[4] > 0.01) stop("A probabilidade de desvio deveria ir a zero")
registrar_varios(c(p26_q7_prob_n50 = desvio[1], p26_q7_prob_n50000 = desvio[4]))

gravar_resultados("p26")
