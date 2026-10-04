# Lista 1, versão v.1 (79 exercícios, a lista que o professor montou junto com a prova)
# Id: l1v. Confere todos os números da chave v.1 e os números novos das notas em
# provas/lista1_v1/. Exercícios com os mesmos dados da Lista 1 antiga (cabos, café,
# poupança, cigarros) já estão resolvidos nos módulos: aqui só se refazem as contas
# que a chave v.1 imprime ou que mudam de enunciado.
# Rodar: powershell -ExecutionPolicy Bypass -File scripts\r.ps1 provas\lista1_v1\lista1_v1.R

# --- bootstrap: localizar a raiz do repo e carregar helpers ---
.d <- getwd(); while (!file.exists(file.path(.d, ".repo-root")) && dirname(.d) != .d) .d <- dirname(.d)
source(file.path(.d, "R", "raiz.R"))

suppressPackageStartupMessages({ library(AER) })

reg <- function(chave, valor) registrar(paste0("l1v_", chave), unname(as.numeric(valor)))
confere <- function(a, b, rotulo, tol = 1e-8) {
  if (abs(unname(a) - unname(b)) > tol * max(1, abs(b))) stop("Identidade falhou: ", rotulo)
  invisible(TRUE)
}
secao <- function(x) cat("\n==== ", x, " ====\n", sep = "")

# Dados dos cabos telefônicos (Lista 1 v.1, ex. 30; mesmos dados do ex. 38 da lista antiga).
cabos <- data.frame(
  Y   = c(5873, 7852, 8189, 7497, 8534, 8688, 7270, 5020, 6035, 7425, 9400, 9350, 6540, 7675, 7419, 7923),
  X1  = c(1503.6, 1486.7, 1434.8, 2035.6, 2360.8, 2043.9, 1331.9, 1160.0,
          1535.0, 1961.8, 2009.3, 1721.9, 1298.0, 1100.0, 1039.0, 1200.0),
  X2  = c(3.6, 3.5, 5.0, 6.0, 5.6, 4.9, 5.6, 8.5, 7.7, 7.0, 6.0, 6.0, 7.2, 7.6, 9.2, 8.8),
  X3  = c(5.8, 6.7, 8.4, 3.2, 5.4, 5.9, 9.4, 9.4, 7.2, 6.6, 7.6, 10.6, 14.9, 16.6, 17.5, 16.0),
  X4  = c(5.9, 4.5, 4.2, 4.2, 4.9, 5.0, 4.1, 3.4, 4.2, 4.5, 3.9, 4.4, 3.9, 3.1, 0.6, 1.5),
  X5  = c(1051.8, 1078.8, 1075.3, 1107.5, 1171.1, 1235.0, 1217.8, 1202.3,
          1271.0, 1332.7, 1399.2, 1431.6, 1480.7, 1510.3, 1492.2, 1535.4)
)
Xc <- cbind(1, as.matrix(cabos[, c("X1", "X2", "X3", "X4", "X5")]))
yc <- cabos$Y

## ---- Ex. 4 — IC e teste t na regressão simples (n = 20) ----
secao("Ex. 4")
b2 <- 0.84; ep <- 0.20; tt <- qt(0.975, 18)
reg("ex4_ttab", tt)
reg("ex4_ic_inf", b2 - 2.101 * ep)
reg("ex4_ic_sup", b2 + 2.101 * ep)
reg("ex4_t", b2 / ep)
reg("ex4_p", 2 * pt(-abs(b2 / ep), 18))

## ---- Ex. 5 e 6 — R² ajustado e F conjunto ----
secao("Ex. 5-6")
reg("ex5_r2aj", 1 - (1 - 0.78) * (50 - 1) / (50 - 4))
reg("ex6_Ftab", qf(0.95, 3, 46))
reg("ex6_p", pf(42.5, 3, 46, lower.tail = FALSE))
# F a partir do R² (fórmula do ex. 42): bate com o 42,5 impresso?
reg("ex6_F_do_r2", (0.78 / 3) / ((1 - 0.78) / 46))

## ---- Ex. 8 — FIV ----
secao("Ex. 8")
reg("ex8_r2", 0.95^2)
reg("ex8_vif", 1 / (1 - 0.95^2))

## ---- Ex. 9 — Breusch-Pagan ----
secao("Ex. 9")
reg("ex9_chi2tab", qchisq(0.95, 1))
reg("ex9_p", pchisq(8.2, 1, lower.tail = FALSE))

## ---- Ex. 10 — Durbin-Watson ----
secao("Ex. 10")
reg("ex10_rho", 1 - 0.85 / 2)

## ---- Ex. 12 — mudança de escala: t e R² não mudam ----
secao("Ex. 12")
m0 <- summary(lm(Y ~ X1, data = cabos))
mY <- summary(lm(I(Y / 1000) ~ X1, data = cabos))     # Y em outra unidade (c = 1/1000)
mX <- summary(lm(Y ~ I(X1 / 1000), data = cabos))     # X em outra unidade
confere(coef(mY)[2, 1], coef(m0)[2, 1] / 1000, "b2 escala com c")
confere(coef(mY)[2, 3], coef(m0)[2, 3], "t inalterado (Y)")
confere(coef(mX)[2, 1], coef(m0)[2, 1] * 1000, "b2 escala com 1/c quando X muda")
confere(coef(mX)[2, 3], coef(m0)[2, 3], "t inalterado (X)")
confere(mY$r.squared, m0$r.squared, "R2 inalterado")
reg("ex12_t_original", coef(m0)[2, 3])
reg("ex12_t_Y_escalado", coef(mY)[2, 3])

## ---- Ex. 19 — colinearidade perfeita ----
secao("Ex. 19")
X19 <- cbind(1, c(2, 4, 6, 8), c(4, 8, 12, 16))
reg("ex19_posto", qr(X19)$rank)
reg("ex19_det", det(crossprod(X19)))

## ---- Ex. 23 — R² = r² na regressão simples ----
secao("Ex. 23")
confere(summary(lm(Y ~ X1, data = cabos))$r.squared, cor(cabos$Y, cabos$X1)^2, "R2 = r^2")

## ---- Ex. 24 — [(X'X)^-1]_kk = 1/((1 - R²_k) S_kk) ----
secao("Ex. 24")
XtXi <- solve(crossprod(Xc))
for (k in 2:6) {
  xk <- Xc[, k]; outros <- Xc[, -k]
  r2k <- 1 - sum(resid(lm(xk ~ outros - 1))^2) / sum((xk - mean(xk))^2)
  confere(XtXi[k, k], 1 / ((1 - r2k) * sum((xk - mean(xk))^2)), paste("inversa, coluna", k))
  reg(paste0("ex24_vif_X", k - 1), 1 / (1 - r2k))
}

## ---- Ex. 26 — MQO à mão com desenho ortogonal ----
secao("Ex. 26")
y26 <- c(8, 7, 10, 14)
X26 <- cbind(1, c(-3, -1, 1, 3), c(1, -1, -1, 1))
b26 <- solve(crossprod(X26), crossprod(X26, y26))
e26 <- as.vector(y26 - X26 %*% b26)
print(crossprod(X26)); print(b26)
confere(max(abs(crossprod(X26, e26))), 0, "X'e = 0", tol = 1e-10)
reg("ex26_b0", b26[1]); reg("ex26_b1", b26[2]); reg("ex26_b2", b26[3])
for (i in 1:4) reg(paste0("ex26_e", i), e26[i])

## ---- Ex. 27 — MQO à mão, 5 observações ----
secao("Ex. 27")
y27 <- c(2, 3, 5, 4, 6); X27 <- cbind(1, c(2, 4, 6, 8, 10))
b27 <- solve(crossprod(X27), crossprod(X27, y27))
reg("ex27_det", det(crossprod(X27)))
reg("ex27_b1", b27[1]); reg("ex27_b2", b27[2])

## ---- Ex. 31 — FWL numérico; ex. 32 — regressão pela origem; ex. 41 e 69 ----
secao("Ex. 31, 32, 41, 69")
Y31 <- c(4, 6, 7, 9, 10); X31 <- 1:5
m31 <- lm(Y31 ~ X31)
yd <- Y31 - mean(Y31); xd <- X31 - mean(X31)
b_fwl <- coef(lm(yd ~ xd - 1))
confere(b_fwl, coef(m31)[2], "FWL com X1 = coluna de uns")
reg("ex31_b1", coef(m31)[1]); reg("ex31_b2", coef(m31)[2]); reg("ex31_sxy", sum(xd * yd))
m32 <- lm(Y31 ~ X31 - 1)                                   # sem intercepto
reg("ex32_b_origem", coef(m32))
reg("ex32_soma_res", sum(resid(m32)))                      # não é zero
reg("ex32_vies_termo", sum(X31) / sum(X31^2))              # multiplica beta1 no viés
s31 <- summary(m31)
confere(coef(s31)[2, 3]^2, s31$fstatistic[1], "t^2 = F")
reg("ex41_t", coef(s31)[2, 3]); reg("ex41_F", s31$fstatistic[1])
b_pad <- coef(lm(scale(Y31) ~ scale(X31)))[2]
confere(b_pad, cor(X31, Y31), "beta padronizado = r_XY")
reg("ex69_bpad", b_pad)

## ---- Ex. 40 — Var(b) - Var(b_R) semidefinida positiva ----
secao("Ex. 40")
R <- rbind(c(0, 0, 0, 1, 0, 0), c(0, 0, 0, 0, 0, 1))     # restrições quaisquer (q = 2)
D <- XtXi %*% t(R) %*% solve(R %*% XtXi %*% t(R)) %*% R %*% XtXi
ev <- eigen((D + t(D)) / 2, symmetric = TRUE)$values
reg("ex40_menor_autovalor", min(ev))                       # >= 0 (até erro numérico)
reg("ex40_posto", qr(D)$rank)                              # = q: a diferença nunca é nula

## ---- Ex. 42 — F pelo R² (cabos) ----
secao("Ex. 42")
mc <- summary(lm(Y ~ X1 + X2 + X3 + X4 + X5, data = cabos))
F_r2 <- (mc$r.squared * (16 - 6)) / ((1 - mc$r.squared) * (6 - 1))
confere(F_r2, mc$fstatistic[1], "F pelo R2")
reg("ex42_F", F_r2)

## ---- Ex. 44 — IC e teste t (n = 27) ----
secao("Ex. 44")
t25 <- qt(0.975, 25)
reg("ex44_ttab", t25)
reg("ex44_ic_inf", 107.7422 - t25 * 9.581670)
reg("ex44_ic_sup", 107.7422 + t25 * 9.581670)
reg("ex44_t", 107.7422 / 9.581670)
reg("ex44_r", sqrt(0.834920))
# Elasticidade não é pedida; mas o IC para um aumento de 10 unidades é 10 vezes o IC
reg("ex44_t_vs_1", (107.7422 - 100) / 9.581670)           # H0: beta2 = 100 (torção possível)

## ---- Ex. 45 e 62 — equação de salários ----
secao("Ex. 45, 62")
reg("ex45_t_fem", -0.1800 / 0.05)
reg("ex45_p_fem", 2 * pnorm(-3.6))
F45 <- ((128 - 120) / 2) / (120 / 195)
reg("ex45_F", F45)
reg("ex45_Ftab", qf(0.95, 2, 195))
reg("ex45_pF", pf(F45, 2, 195, lower.tail = FALSE))
reg("ex45_t_educ", 0.0850 / 0.010)
reg("ex45_t_exp2", -0.0007 / 0.0002)
reg("ex62_fem_exato", 100 * (exp(-0.18) - 1))
reg("ex62_educ_exato", 100 * (exp(0.085) - 1))
reg("ex62_efeito_exp10", 0.0450 - 2 * 0.0007 * 10)
reg("ex62_pico", 0.0450 / (2 * 0.0007))
reg("ex45_r2aj", 1 - (1 - 0.42) * (200 - 1) / (200 - 5))

## ---- Ex. 46 — Jarque-Bera ----
secao("Ex. 46")
reg("ex46_chi2_5pct", qchisq(0.95, 2))
reg("ex46_alfa_do_254", pchisq(2.54, 2, lower.tail = FALSE))   # o crítico impresso não é de 5%
reg("ex46_p", pchisq(1.53, 2, lower.tail = FALSE))

## ---- Ex. 49 — W/q = F (cabos, H0: beta4 = beta6 = 0) ----
secao("Ex. 49")
Rw <- rbind(c(0, 0, 0, 0, 1, 0), c(0, 0, 0, 0, 0, 1)); rw <- c(0, 0)
bc <- XtXi %*% crossprod(Xc, yc); ec <- yc - Xc %*% bc
s2 <- sum(ec^2) / (16 - 6)
d <- Rw %*% bc - rw
W_s2 <- as.numeric(t(d) %*% solve(Rw %*% XtXi %*% t(Rw) * s2) %*% d)
mr <- lm(Y ~ X1 + X2 + X3, data = cabos)
F_ssr <- ((sum(resid(mr)^2) - sum(ec^2)) / 2) / (sum(ec^2) / 10)
confere(W_s2 / 2, F_ssr, "W/q = F")
reg("ex49_F", F_ssr)

## ---- Ex. 50 e 64 — F por SQR restrita/irrestrita ----
secao("Ex. 50, 64")
F50 <- ((180 - 150) / 2) / (150 / 37)
reg("ex50_F", F50); reg("ex50_Ftab", qf(0.95, 2, 37)); reg("ex50_p", pf(F50, 2, 37, lower.tail = FALSE))
F64 <- ((240 - 210) / 2) / (210 / 116)
reg("ex64_F", F64); reg("ex64_Ftab", qf(0.95, 2, 116)); reg("ex64_p", pf(F64, 2, 116, lower.tail = FALSE))

## ---- Ex. 59 — café: elasticidades na média ----
secao("Ex. 59")
cafe <- data.frame(Q = c(2.57, 2.50, 2.30, 2.25, 2.20, 2.11, 1.94, 1.97, 2.06, 2.02, 2.35),
                   P = c(0.77, 0.74, 0.73, 0.76, 0.75, 1.08, 1.81, 1.39, 1.20, 1.17, 0.72))
Qb <- mean(cafe$Q); Pb <- mean(cafe$P)
el <- c(
  lin    = coef(lm(Q ~ P, cafe))[2] * Pb / Qb,
  linlog = coef(lm(Q ~ log(P), cafe))[2] / Qb,
  loglin = coef(lm(log(Q) ~ P, cafe))[2] * Pb,
  loglog = coef(lm(log(Q) ~ log(P), cafe))[2],
  inv    = -coef(lm(Q ~ I(1 / P), cafe))[2] / (Pb * Qb)
)
print(round(el, 4))
for (nm in names(el)) reg(paste0("ex59_el_", sub("\\..*$", "", nm)), el[[nm]])
# A expressão intermediária da chave para a inversa, -b2 (1/X)(X/Y) = -b2/Y, dá outro número:
reg("ex59_inv_errado", -coef(lm(Q ~ I(1 / P), cafe))[2] / Qb)

## ---- Ex. 61 — custo total ----
secao("Ex. 61")
reg("ex61_t_ano", 0.056 / 0.003)
reg("ex61_pct_exato", 100 * (exp(0.056) - 1))

## ---- Ex. 63 — RESET ----
secao("Ex. 63")
# O crítico 4,10 é compatível com F(2, 10) (mesmo desenho dos cabos: n = 16, K = 6 + 2 termos)
reg("ex63_Ftab_2_10", qf(0.95, 2, 10))
reg("ex63_p_2_10", pf(2.284568, 2, 10, lower.tail = FALSE))

## ---- Ex. 73 — VI à mão ----
secao("Ex. 73")
b1iv <- 340 / 85
reg("ex73_b1", b1iv); reg("ex73_b0", 50 - b1iv * 8)

## ---- Ex. 77 — ivreg dos cigarros: p-valores coerentes com as estatísticas ----
secao("Ex. 77")
reg("ex77_wu_p_correto", pf(3.823, 1, 44, lower.tail = FALSE))      # o impresso é 0,0469
reg("ex77_sargan_p_gl1", pchisq(0.333, 1, lower.tail = FALSE))      # gl certo: L - K = 1
reg("ex77_sargan_p_gl2", pchisq(0.333, 2, lower.tail = FALSE))      # o que o enunciado imprime
reg("ex77_t_elast_1", (-1.2774 + 1) / 0.2417)                       # H0: elasticidade = -1
reg("ex77_ic_inf", -1.2774 - qnorm(0.975) * 0.2417)
reg("ex77_ic_sup", -1.2774 + qnorm(0.975) * 0.2417)
reg("ex77_t_renda", 0.2804 / 0.2458)

## ---- Ex. 79 — fórmula do Sargan: n R² = e'P_Z e / (e'e/n) ----
secao("Ex. 79")
data("CigarettesSW", package = "AER")
cig <- subset(CigarettesSW, year == "1995")
cig$rprice  <- with(cig, price / cpi)
cig$rincome <- with(cig, income / population / cpi)
cig$tdiff   <- with(cig, (taxs - tax) / cpi)
iv <- ivreg(log(packs) ~ log(rprice) + log(rincome) | log(rincome) + tdiff + I(tax / cpi), data = cig)
e_iv <- resid(iv)
Z <- model.matrix(~ log(rincome) + tdiff + I(tax / cpi), data = cig)
n_c <- nrow(cig)
ePe <- as.numeric(t(e_iv) %*% Z %*% solve(crossprod(Z)) %*% t(Z) %*% e_iv)
J_certo <- ePe / (sum(e_iv^2) / n_c)
nR2 <- n_c * summary(lm(e_iv ~ Z - 1))$r.squared
J_sum <- summary(iv, diagnostics = TRUE)$diagnostics["Sargan", "statistic"]
confere(J_certo, J_sum, "Sargan = e'Pe/(e'e/n)", tol = 1e-6)
reg("ex79_J", J_certo)
reg("ex79_J_com_n_extra", n_c * J_certo)                             # o que a fórmula da chave daria
reg("ex79_n", n_c)
# nR² com R² não centrado coincide (Z tem constante e a média de e_iv é ~0)
reg("ex79_nR2", nR2)

gravar_resultados("l1v")
