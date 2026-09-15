# Módulo 02 — MQO na regressão simples (script m02)
#
# Notação da Lista 1: Y_i = beta1 + beta2 X_i + u_i  (beta1 = intercepto).
# Desvios: x_i = X_i - mean(X), y_i = Y_i - mean(Y); S_XX = sum(x_i^2); k_i = x_i / S_XX.
#
# Conteúdo:
#   Ex. 40       — MQO à mão (somas, Cramer, previsão, elasticidade), output estilo NLOGIT, figura
#   Ex. 17/21/22 — identidades algébricas (resíduos, ajustados, desvios)
#   Ex. 18/19    — t^2 = F, F via R^2, R^2 = r^2 (dados do ex. 40 e output impresso do ex. 41)
#   Ex. 14/16    — Monte Carlo: não-viés de b1 e b2, Var(b1), Var(b2), Cov(b1, b2), E[s^2]
#   Ex. 15       — Monte Carlo: viés de variável omitida
#   Ex. 20       — Monte Carlo: dispersão de X e precisão de b2
#   D02.14       — Monte Carlo: erro de medição em Y (variante da Q4 da P1 2025/2)
#
# Rodar: powershell -ExecutionPolicy Bypass -File scripts\r.ps1 02_mqo_simples\02_mqo_simples.R

# --- bootstrap: localizar a raiz do repo e carregar helpers ---
.d <- getwd(); while (!file.exists(file.path(.d, ".repo-root")) && dirname(.d) != .d) .d <- dirname(.d)
source(file.path(.d, "R", "raiz.R"))

dir_fig <- caminho_repo("02_mqo_simples", "figuras")
dir.create(dir_fig, showWarnings = FALSE, recursive = TRUE)

# Figuras com vírgula decimal nos eixos; o OutDec volta a "." ao fechar
# (o CSV de resultados precisa de ponto decimal).
abrir_png <- function(nome) {
  png(file.path(dir_fig, nome), width = 1600, height = 1000, res = 200)
  options(OutDec = ",")
}
fechar_png <- function() {
  invisible(dev.off())
  options(OutDec = ".")
}

# Formata com vírgula decimal (só para o que é impresso no console e nas legendas)
fmt <- function(v, d = 6) formatC(v, format = "f", digits = d, decimal.mark = ",")

## ---- Ex. 40 ----
# Dados: Lista 1, ex. 40 — produção Y (unidades) e quantidade de insumos X (unidades), n = 15.
Y <- c(0.58, 1.10, 1.20, 1.30, 1.95, 2.55, 2.60, 2.90, 3.45, 3.50, 3.60, 4.10, 4.35, 4.40, 4.50)
X <- 1:15
n <- length(Y)
stopifnot(n == 15, length(X) == n)

# Tabela de conta à mão (impressa no console; as somas vão para o CSV)
tab_mao <- data.frame(i = seq_len(n), X = X, Y = Y, XY = X * Y, X2 = X^2)
cat("\nEx. 40 — tabela de somas à mão\n")
print(tab_mao, row.names = FALSE)

# Somas brutas (o que se escreve na prova)
soma_X  <- sum(X)
soma_Y  <- sum(Y)
soma_XY <- sum(X * Y)
soma_X2 <- sum(X^2)
soma_Y2 <- sum(Y^2)
Xbar <- soma_X / n
Ybar <- soma_Y / n

# Somas centradas pelas formas computacionais (D5): S_XX = sum X^2 - n Xbar^2 etc.
nXbar2   <- n * Xbar^2
nXbarYbar <- n * Xbar * Ybar
S_XX <- soma_X2 - nXbar2
S_XY <- soma_XY - nXbarYbar
S_YY <- soma_Y2 - n * Ybar^2
stopifnot(isTRUE(all.equal(S_XX, sum((X - Xbar)^2))),
          isTRUE(all.equal(S_XY, sum((X - Xbar) * (Y - Ybar)))))

# Estimadores (D4–D6 na notação da Lista)
b2 <- S_XY / S_XX
b1 <- Ybar - b2 * Xbar

# Mesma coisa pela regra de Cramer nas equações normais (D02.1)
n_somaXY   <- n * soma_XY
somaX_somaY <- soma_X * soma_Y
n_somaX2   <- n * soma_X2
somaX_quad <- soma_X^2
det_XX <- n_somaX2 - somaX_quad             # = n * S_XX
num_b2 <- n_somaXY - somaX_somaY
somaX2_somaY  <- soma_X2 * soma_Y
somaX_somaXY  <- soma_X * soma_XY
num_b1 <- somaX2_somaY - somaX_somaXY
b2_cramer <- num_b2 / det_XX
b1_cramer <- num_b1 / det_XX
stopifnot(isTRUE(all.equal(det_XX, n * S_XX)),
          isTRUE(all.equal(b1, b1_cramer)), isTRUE(all.equal(b2, b2_cramer)))

# Conferência com lm()
fit <- lm(Y ~ X)
stopifnot(isTRUE(all.equal(unname(coef(fit)), c(b1, b2))))

registrar("m02_ex40_n", n)
registrar("m02_ex40_somaX", soma_X)
registrar("m02_ex40_somaY", soma_Y)
registrar("m02_ex40_somaXY", soma_XY)
registrar("m02_ex40_somaX2", soma_X2)
registrar("m02_ex40_somaY2", soma_Y2)
registrar("m02_ex40_Xbar", Xbar)
registrar("m02_ex40_Ybar", Ybar)
registrar("m02_ex40_nXbar2", nXbar2)
registrar("m02_ex40_nXbarYbar", nXbarYbar)
registrar("m02_ex40_Sxx", S_XX)
registrar("m02_ex40_Sxy", S_XY)
registrar("m02_ex40_Syy", S_YY)
registrar("m02_ex40_nSomaXY", n_somaXY)
registrar("m02_ex40_somaXsomaY", somaX_somaY)
registrar("m02_ex40_nSomaX2", n_somaX2)
registrar("m02_ex40_somaXquad", somaX_quad)
registrar("m02_ex40_det", det_XX)
registrar("m02_ex40_num_b2", num_b2)
registrar("m02_ex40_somaX2somaY", somaX2_somaY)
registrar("m02_ex40_somaXsomaXY", somaX_somaXY)
registrar("m02_ex40_num_b1", num_b1)
registrar("m02_ex40_b2Xbar", b2 * Xbar)
registrar("m02_ex40_b1", b1)
registrar("m02_ex40_b2", b2)

# Resíduos, ajustados e ajuste
Yhat <- b1 + b2 * X
uhat <- Y - Yhat
SQR <- sum(uhat^2)                 # soma dos quadrados dos resíduos (a "SSE" da Lista)
SQT <- S_YY                        # soma total
SQE <- sum((Yhat - Ybar)^2)        # soma explicada (a "SSR" da Lista)
stopifnot(isTRUE(all.equal(SQT, SQE + SQR)),
          isTRUE(all.equal(SQE, b2^2 * S_XX)), isTRUE(all.equal(SQE, S_XY^2 / S_XX)))
s2 <- SQR / (n - 2)
s  <- sqrt(s2)
R2 <- SQE / SQT
r_XY <- cor(X, Y)

registrar("m02_ex40_SQR", SQR)
registrar("m02_ex40_SQE", SQE)
registrar("m02_ex40_SQT", SQT)
registrar("m02_ex40_s2", s2)
registrar("m02_ex40_s", s)
registrar("m02_ex40_R2", R2)
registrar("m02_ex40_rXY", r_XY)

# Erros-padrão pelas fórmulas do ex. 16 (com s^2 no lugar de sigma^2)
var_b2_hat <- s2 / S_XX
var_b1_hat <- s2 * (1 / n + Xbar^2 / S_XX)
cov_b12_hat <- -Xbar * s2 / S_XX
ep_b1 <- sqrt(var_b1_hat)
ep_b2 <- sqrt(var_b2_hat)
V_lm <- vcov(fit)
stopifnot(isTRUE(all.equal(unname(V_lm[1, 1]), var_b1_hat)),
          isTRUE(all.equal(unname(V_lm[2, 2]), var_b2_hat)),
          isTRUE(all.equal(unname(V_lm[1, 2]), cov_b12_hat)))
# Mesma matriz por s^2 (X'X)^{-1} (conferência matricial do D02.7)
XX <- cbind(1, X)
V_mat <- s2 * solve(crossprod(XX))
stopifnot(isTRUE(all.equal(unname(V_mat), unname(V_lm))))

t_b1 <- b1 / ep_b1
t_b2 <- b2 / ep_b2
gl <- n - 2
p_b1 <- 2 * pt(-abs(t_b1), gl)
p_b2 <- 2 * pt(-abs(t_b2), gl)
t_crit <- qt(0.975, gl)
F_crit <- qf(0.95, 1, gl)
F_calc <- SQE / (SQR / gl)
F_R2 <- R2 / ((1 - R2) / gl)
stopifnot(isTRUE(all.equal(t_b2^2, F_calc)), isTRUE(all.equal(F_calc, F_R2)),
          isTRUE(all.equal(R2, r_XY^2)), isTRUE(all.equal(t_crit^2, F_crit)),
          isTRUE(all.equal(F_calc, unname(summary(fit)$fstatistic["value"]))))
corr_b12_hat <- cov_b12_hat / sqrt(var_b1_hat * var_b2_hat)

registrar("m02_ex40_gl", gl)
registrar("m02_ex40_ep_b1", ep_b1)
registrar("m02_ex40_ep_b2", ep_b2)
registrar("m02_ex40_cov_b1b2", cov_b12_hat)
registrar("m02_ex40_corr_b1b2", corr_b12_hat)
registrar("m02_ex40_t_b1", t_b1)
registrar("m02_ex40_t_b2", t_b2)
registrar("m02_ex40_p_b1", p_b1)
registrar("m02_ex40_p_b2", p_b2)
registrar("m02_ex40_tcrit", t_crit)
registrar("m02_ex40_tcrit2", t_crit^2)
registrar("m02_ex40_Fcrit", F_crit)
registrar("m02_ex40_F", F_calc)
registrar("m02_ex40_F_R2", F_R2)
registrar("m02_ex40_t2", t_b2^2)
registrar("m02_ex40_r2XY", r_XY^2)
registrar("m02_ex40_zcrit", qnorm(0.975))

# IC de 95% para beta2
ic_b2 <- b2 + c(-1, 1) * t_crit * ep_b2
registrar("m02_ex40_ic_b2_inf", ic_b2[1])
registrar("m02_ex40_ic_b2_sup", ic_b2[2])

# Previsão em X0 = 20 (item d) — extrapolação: X observado vai de 1 a 15
X0 <- 20
Y0_hat <- b1 + b2 * X0
ep_ajuste0 <- sqrt(s2 * (1 / n + (X0 - Xbar)^2 / S_XX))        # erro-padrão de E[Y|X0] estimado
ep_prev0   <- sqrt(s2 * (1 + 1 / n + (X0 - Xbar)^2 / S_XX))    # erro-padrão do erro de previsão
ip0 <- Y0_hat + c(-1, 1) * t_crit * ep_prev0
pr <- predict(fit, data.frame(X = X0), interval = "prediction", level = 0.95)
stopifnot(isTRUE(all.equal(unname(pr[1, ]), c(Y0_hat, ip0))))
registrar("m02_ex40_b2x20", b2 * X0)
registrar("m02_ex40_prev20", Y0_hat)
registrar("m02_ex40_ep_ajuste20", ep_ajuste0)
registrar("m02_ex40_ep_prev20", ep_prev0)
registrar("m02_ex40_ip20_inf", ip0[1])
registrar("m02_ex40_ip20_sup", ip0[2])
# Previsão dentro da amostra, no ponto médio: erro-padrão mínimo
registrar("m02_ex40_ep_ajuste_media", sqrt(s2 / n))

# Elasticidade no ponto médio (item e): eta = b2 * Xbar / Ybar
elast <- b2 * Xbar / Ybar
elast_chave <- 0.2925 * 8 / 2.80     # conta da chave, com b2 e Ybar arredondados
registrar("m02_ex40_elast", elast)
registrar("m02_ex40_elast_chave", elast_chave)
# eta = PMg / PMe: produto médio na média
registrar("m02_ex40_PMe_media", Ybar / Xbar)

# Checagem de forma funcional (só para a armadilha da extrapolação): quadrática
fit_q <- lm(Y ~ X + I(X^2))
cq <- summary(fit_q)$coefficients
prev20_q <- unname(predict(fit_q, data.frame(X = X0)))
registrar("m02_ex40_quad_c3", cq[3, 1])
registrar("m02_ex40_quad_t3", cq[3, 3])
registrar("m02_ex40_quad_p3", cq[3, 4])
registrar("m02_ex40_quad_prev20", prev20_q)

# Output no estilo LIMDEP/NLOGIT (para a seção 4 da teoria)
R2adj <- 1 - (1 - R2) * (n - 1) / (n - 2)
p_F <- pf(F_calc, 1, gl, lower.tail = FALSE)
cat("\n+----------------------------------------------------------------+\n")
cat("| Regressão de mínimos quadrados ordinários (MQO) — Lista 1, ex. 40\n")
cat("| LHS=Y        Média =", fmt(Ybar, 5), "   Desvio padrão =", fmt(sd(Y), 5), "\n")
cat("|              Número de observações =", n, "\n")
cat("| Resíduos     Soma dos quadrados =", fmt(SQR, 5), "  Erro padrão dos resíduos =", fmt(s, 5), "\n")
cat("| Ajuste       R-quadrado =", fmt(R2, 6), "  R-quadrado ajustado =", fmt(R2adj, 6), "\n")
cat("| Teste de modelo F[1,", gl, "] =", fmt(F_calc, 2), " (valor-p =", fmt(p_F, 4), ")\n")
cat("+----------+--------------+--------------+---------+----------+----------+\n")
cat("| Variável | Coeficiente  | Erro padrão  | b/E.p.  | P[|T|>t] | Média X  |\n")
cat(sprintf("| Constant | %12s | %12s | %7s | %8s |          |\n", fmt(b1, 7), fmt(ep_b1, 7), fmt(t_b1, 3), fmt(p_b1, 4)))
cat(sprintf("| X        | %12s | %12s | %7s | %8s | %8s |\n", fmt(b2, 7), fmt(ep_b2, 7), fmt(t_b2, 3), fmt(p_b2, 4), fmt(Xbar, 5)))
cat("+----------+--------------+--------------+---------+----------+----------+\n\n")
registrar("m02_ex40_R2adj", R2adj)
registrar("m02_ex40_dpY", sd(Y))
registrar("m02_ex40_pF", p_F)

# Figura: função de produção estimada
abrir_png("m02_ex40_funcao_producao.png")
par(mar = c(4.5, 4.5, 3, 1))
plot(X, Y, pch = 19, col = "grey20", xlim = c(0, 21), ylim = c(0, 7.8),
     xlab = "Quantidade de insumos (X)", ylab = "Produção (Y)",
     main = "Ex. 40 — função de produção estimada por MQO")
rect(15, -1, 22, 9, col = adjustcolor("grey85", 0.5), border = NA)
text(18, 0.35, "fora da amostra\n(extrapolação)", cex = 0.75, col = "grey30")
points(X, Y, pch = 19, col = "grey20")
curve(b1 + b2 * x, from = 0, to = 15, add = TRUE, lwd = 2.5, col = "navy")
curve(b1 + b2 * x, from = 15, to = 20.5, add = TRUE, lwd = 2.5, lty = 2, col = "navy")
xs <- seq(1, 20.5, length.out = 200)
lines(xs, predict(fit_q, data.frame(X = xs)), lwd = 1.5, lty = 3, col = "darkorange3")
points(Xbar, Ybar, pch = 4, cex = 2, lwd = 3, col = "firebrick")
segments(X0, ip0[1], X0, ip0[2], lwd = 2, col = "navy")
points(X0, Y0_hat, pch = 17, cex = 1.4, col = "navy")
legend("topleft", bty = "n", cex = 0.8,
       legend = c(sprintf("Ajuste linear: Y = %s + %s X", fmt(b1, 4), fmt(b2, 4)),
                  sprintf("Ponto das médias: (%s; %s)", fmt(Xbar, 0), fmt(Ybar, 4)),
                  sprintf("Previsão em X = 20: %s (IP 95%%)", fmt(Y0_hat, 4)),
                  "Quadrática (só comparação)"),
       col = c("navy", "firebrick", "navy", "darkorange3"),
       lty = c(1, NA, 1, 3), pch = c(NA, 4, 17, NA), lwd = c(2.5, 3, 2, 1.5))
fechar_png()

## ---- Ex. 17 e 21 ----
# Propriedades algébricas (valem em qualquer amostra com intercepto)
chk_soma_u   <- sum(uhat)
chk_soma_Xu  <- sum(X * uhat)
chk_soma_Yhu <- sum(Yhat * uhat)
chk_media    <- mean(Yhat) - Ybar
stopifnot(abs(chk_soma_u) < 1e-10, abs(chk_soma_Xu) < 1e-10,
          abs(chk_soma_Yhu) < 1e-10, abs(chk_media) < 1e-12)
registrar("m02_ex17_soma_u", chk_soma_u)
registrar("m02_ex17_soma_Xu", chk_soma_Xu)
registrar("m02_ex21_soma_Yhat_u", chk_soma_Yhu)
registrar("m02_ex21_media_Yhat", mean(Yhat))

# Contraexemplo: sem intercepto (regressão pela origem) as propriedades falham
fit0 <- lm(Y ~ 0 + X)
registrar("m02_ex21_semconst_b", unname(coef(fit0)))
registrar("m02_ex21_semconst_soma_u", sum(resid(fit0)))
registrar("m02_ex21_semconst_media_Yhat", mean(fitted(fit0)))

## ---- Ex. 22 ----
# Regressão em desvios, sem intercepto: y_i = b2 x_i + u_i
x_d <- X - Xbar
y_d <- Y - Ybar
fit_d <- lm(y_d ~ 0 + x_d)
b2_desvios <- unname(coef(fit_d))
stopifnot(isTRUE(all.equal(b2_desvios, b2)), isTRUE(all.equal(unname(resid(fit_d)), unname(uhat))))
registrar("m02_ex22_b2_desvios", b2_desvios)
registrar("m02_ex22_max_dif_resid", max(abs(resid(fit_d) - uhat)))

## ---- Ex. 18 e 19: conferência com o output impresso do ex. 41 ----
# Números copiados do output do ex. 41 da Lista 1 (PIB x investimento, 27 estados):
# t da inclinação = 11,24462 e R^2 = 0,834920. Com n - 2 = 25 g.l.
t41 <- 11.24462; R2_41 <- 0.834920; n41 <- 27
registrar("m02_ex41_t2", t41^2)
registrar("m02_ex41_F_R2", R2_41 / ((1 - R2_41) / (n41 - 2)))
registrar("m02_ex41_r", sqrt(R2_41))
registrar("m02_ex41_tcrit", qt(0.975, n41 - 2))

## ---- Ex. 14 e 16 (Monte Carlo) ----
# X fixo em amostras repetidas (X do ex. 40); u ~ N(0, sigma^2) i.i.d. [A1]-[A6]
set.seed(20261002)
R <- 20000
beta1 <- 0.5; beta2 <- 0.3; sigma <- 0.3
k <- (X - Xbar) / S_XX                     # pesos de b2
w <- 1 / n - Xbar * k                      # pesos de b1 (D02.4)
stopifnot(isTRUE(all.equal(sum(k), 0)), isTRUE(all.equal(sum(k * X), 1)),
          isTRUE(all.equal(sum(w), 1)), isTRUE(all.equal(sum(w * X), 0)),
          isTRUE(all.equal(sum(w^2), 1 / n + Xbar^2 / S_XX)),
          isTRUE(all.equal(sum(w * k), -Xbar / S_XX)))
U <- matrix(rnorm(n * R, 0, sigma), nrow = n)
Ysim <- beta1 + beta2 * X + U              # n x R
b2_sim <- colSums(k * Ysim)
b1_sim <- colSums(w * Ysim)
res_sim <- Ysim - outer(rep(1, n), b1_sim) - outer(X, b2_sim)
SQR_sim <- colSums(res_sim^2)
s2_sim <- SQR_sim / (n - 2)
s2n_sim <- SQR_sim / n

var_b2_teo <- sigma^2 / S_XX
var_b1_teo <- sigma^2 * (1 / n + Xbar^2 / S_XX)
cov_teo    <- -Xbar * sigma^2 / S_XX
corr_teo   <- -Xbar / sqrt(soma_X2 / n)
stopifnot(isTRUE(all.equal(corr_teo, cov_teo / sqrt(var_b1_teo * var_b2_teo))))

registrar("m02_mc_R", R)
registrar("m02_mc_beta1", beta1)
registrar("m02_mc_beta2", beta2)
registrar("m02_mc_sigma", sigma)
registrar("m02_mc_sigma2", sigma^2)
registrar("m02_mc_media_b1", mean(b1_sim))
registrar("m02_mc_media_b2", mean(b2_sim))
registrar("m02_mc_var_b1", var(b1_sim))
registrar("m02_mc_var_b1_teo", var_b1_teo)
registrar("m02_mc_var_b2", var(b2_sim))
registrar("m02_mc_var_b2_teo", var_b2_teo)
registrar("m02_mc_cov", cov(b1_sim, b2_sim))
registrar("m02_mc_cov_teo", cov_teo)
registrar("m02_mc_corr", cor(b1_sim, b2_sim))
registrar("m02_mc_corr_teo", corr_teo)
registrar("m02_mc_media_s2", mean(s2_sim))
registrar("m02_mc_media_s2n", mean(s2n_sim))
registrar("m02_mc_s2n_teo", sigma^2 * (n - 2) / n)
registrar("m02_mc_media_s", mean(sqrt(s2_sim)))    # sigma-chapéu é viesado para baixo (Jensen)

# Figura: não-viés e covariância negativa entre b1 e b2 (Xbar > 0)
abrir_png("m02_mc_nao_vies_covariancia.png")
par(mfrow = c(1, 3), mar = c(4.5, 4.2, 3.2, 0.8), oma = c(0, 0, 1.6, 0))
hist(b1_sim, breaks = 60, col = "grey80", border = "white", freq = FALSE,
     main = "Intercepto b1", xlab = expression(hat(beta)[1]), ylab = "densidade")
abline(v = beta1, col = "firebrick", lwd = 2.5); abline(v = mean(b1_sim), col = "navy", lwd = 2, lty = 2)
curve(dnorm(x, beta1, sqrt(var_b1_teo)), add = TRUE, lwd = 1.5)
hist(b2_sim, breaks = 60, col = "grey80", border = "white", freq = FALSE,
     main = "Inclinação b2", xlab = expression(hat(beta)[2]), ylab = "densidade")
abline(v = beta2, col = "firebrick", lwd = 2.5); abline(v = mean(b2_sim), col = "navy", lwd = 2, lty = 2)
curve(dnorm(x, beta2, sqrt(var_b2_teo)), add = TRUE, lwd = 1.5)
idx <- 1:3000
plot(b1_sim[idx], b2_sim[idx], pch = 16, cex = 0.35, col = adjustcolor("navy", 0.35),
     xlab = expression(hat(beta)[1]), ylab = expression(hat(beta)[2]),
     main = sprintf("Corr = %s (teórica %s)", fmt(cor(b1_sim, b2_sim), 3), fmt(corr_teo, 3)))
abline(v = beta1, h = beta2, col = "firebrick", lty = 2)
mtext("Monte Carlo (X fixo, 20000 amostras): vermelho = verdadeiro; tracejado azul = média; curva = normal teórica",
      outer = TRUE, cex = 0.72)
fechar_png()

## ---- Ex. 15 (Monte Carlo) ----
# Verdadeiro: Y = beta1 + beta2 X2 + beta3 X3 + u; estimado: Y em X2 apenas.
set.seed(15)
n15 <- 50
X2 <- round(runif(n15, 0, 10), 2)
X3 <- round(2 + 0.6 * X2 + rnorm(n15, 0, 1.5), 2)     # X2 e X3 fixos nas repetições
g1 <- 1; g2 <- 2; g3 <- 1.5; sig15 <- 2
x2d <- X2 - mean(X2)
d_aux <- sum(x2d * X3) / sum(x2d^2)                    # inclinação da regressão auxiliar de X3 em X2
vies_teo <- g3 * d_aux
stopifnot(isTRUE(all.equal(d_aux, unname(coef(lm(X3 ~ X2))[2]))),
          isTRUE(all.equal(sum(x2d * X3), sum(x2d * (X3 - mean(X3))))))
R15 <- 10000
U15 <- matrix(rnorm(n15 * R15, 0, sig15), nrow = n15)
Y15 <- g1 + g2 * X2 + g3 * X3 + U15
k2 <- x2d / sum(x2d^2)
b2_curta <- colSums(k2 * Y15)
# Regressão longa (com X3): coeficiente de X2 via (Z'Z)^{-1} Z'Y
Z <- cbind(1, X2, X3)
A <- solve(crossprod(Z), t(Z))                          # 3 x n
b2_longa <- (A %*% Y15)[2, ]
registrar("m02_ex15_n", n15)
registrar("m02_ex15_R", R15)
registrar("m02_ex15_beta1", g1)
registrar("m02_ex15_beta2", g2)
registrar("m02_ex15_beta3", g3)
registrar("m02_ex15_sigma", sig15)
registrar("m02_ex15_d_aux", d_aux)
registrar("m02_ex15_vies_teo", vies_teo)
registrar("m02_ex15_media_b2_curta", mean(b2_curta))
registrar("m02_ex15_vies_mc", mean(b2_curta) - g2)
registrar("m02_ex15_media_b2_longa", mean(b2_longa))
registrar("m02_ex15_var_curta", var(b2_curta))
registrar("m02_ex15_var_longa", var(b2_longa))
registrar("m02_ex15_r23", cor(X2, X3))

abrir_png("m02_ex15_vies_omitida.png")
par(mar = c(4.5, 4.5, 3, 1))
br <- seq(min(c(b2_curta, b2_longa)) - 0.01, max(c(b2_curta, b2_longa)) + 0.01, length.out = 90)
hist(b2_longa, breaks = br, col = adjustcolor("grey50", 0.6), border = "white", freq = FALSE,
     main = "Ex. 15 — viés de variável omitida (10000 amostras)",
     xlab = expression("estimativa do coeficiente de " * X[2]), ylab = "densidade", ylim = c(0, 8.5))
hist(b2_curta, breaks = br, col = adjustcolor("firebrick", 0.45), border = "white", freq = FALSE, add = TRUE)
abline(v = g2, lwd = 2.5)
abline(v = g2 + vies_teo, lwd = 2.5, lty = 2, col = "firebrick")
legend("topleft", bty = "n", cex = 0.8,
       legend = c("Regressão longa (Y em X2 e X3): não viesada",
                  "Regressão curta (Y só em X2): viesada",
                  expression("verdadeiro " * beta[2] * " = 2"),
                  sprintf("beta2 + viés teórico = %s", fmt(g2 + vies_teo, 4))),
       fill = c(adjustcolor("grey50", 0.6), adjustcolor("firebrick", 0.45), NA, NA),
       border = NA, lty = c(NA, NA, 1, 2), col = c(NA, NA, "black", "firebrick"), lwd = c(NA, NA, 2.5, 2.5))
fechar_png()

## ---- Ex. 20 (Monte Carlo) ----
# Mesmo n e mesmo sigma; muda só a dispersão de X.
set.seed(20)
X_alta  <- 1:15                                  # S_XX = 280
X_baixa <- seq(6, 10, length.out = 15)           # mesma média (8), S_XX menor
S_alta  <- sum((X_alta - mean(X_alta))^2)
S_baixa <- sum((X_baixa - mean(X_baixa))^2)
R20 <- 20000
U20 <- matrix(rnorm(15 * R20, 0, sigma), nrow = 15)
k_alta  <- (X_alta - mean(X_alta)) / S_alta
k_baixa <- (X_baixa - mean(X_baixa)) / S_baixa
b2_alta  <- colSums(k_alta  * (beta1 + beta2 * X_alta  + U20))
b2_baixa <- colSums(k_baixa * (beta1 + beta2 * X_baixa + U20))
registrar("m02_ex20_Sxx_alta", S_alta)
registrar("m02_ex20_Sxx_baixa", S_baixa)
registrar("m02_ex20_var_alta_teo", sigma^2 / S_alta)
registrar("m02_ex20_var_baixa_teo", sigma^2 / S_baixa)
registrar("m02_ex20_var_alta_mc", var(b2_alta))
registrar("m02_ex20_var_baixa_mc", var(b2_baixa))
registrar("m02_ex20_razao_var_teo", S_alta / S_baixa)
registrar("m02_ex20_razao_dp_teo", sqrt(S_alta / S_baixa))

abrir_png("m02_ex20_dispersao_precisao.png")
par(mar = c(4.5, 4.5, 3, 1))
da <- density(b2_alta); db <- density(b2_baixa)
plot(da, lwd = 2.5, col = "navy", xlim = range(db$x), ylim = c(0, max(da$y) * 1.05),
     main = "Ex. 20 — mais dispersão em X, estimativa mais precisa",
     xlab = expression(hat(beta)[2]), ylab = "densidade")
lines(db, lwd = 2.5, col = "firebrick", lty = 2)
abline(v = beta2, col = "grey30")
legend("topright", bty = "n", cex = 0.8,
       legend = c(sprintf("X = 1, ..., 15   (S_XX = %s)", fmt(S_alta, 1)),
                  sprintf("X de 6 a 10    (S_XX = %s)", fmt(S_baixa, 2)),
                  "mesmos n = 15, sigma = 0,3 e média de X = 8"),
       col = c("navy", "firebrick", NA), lty = c(1, 2, NA), lwd = c(2.5, 2.5, NA))
fechar_png()

## ---- D02.14: erro de medição em Y (Monte Carlo) ----
# Verdadeiro: Y* = beta1 + beta2 X + u; observado: Y = Y* + e, e independente de X e de u.
set.seed(4)
sig_u <- 0.3; sig_e <- 0.4
R_me <- 20000
U_me <- matrix(rnorm(n * R_me, 0, sig_u), nrow = n)
E_me <- matrix(rnorm(n * R_me, 0, sig_e), nrow = n)
Ystar <- beta1 + beta2 * X + U_me
Yobs  <- Ystar + E_me
b2_star <- colSums(k * Ystar)
b2_obs  <- colSums(k * Yobs)
registrar("m02_me_sigma_u", sig_u)
registrar("m02_me_sigma_e", sig_e)
registrar("m02_me_media_b2_semerro", mean(b2_star))
registrar("m02_me_media_b2_comerro", mean(b2_obs))
registrar("m02_me_var_semerro_teo", sig_u^2 / S_XX)
registrar("m02_me_var_comerro_teo", (sig_u^2 + sig_e^2) / S_XX)
registrar("m02_me_var_semerro_mc", var(b2_star))
registrar("m02_me_var_comerro_mc", var(b2_obs))
registrar("m02_me_razao_var_teo", (sig_u^2 + sig_e^2) / sig_u^2)

abrir_png("m02_erro_medicao_y.png")
par(mar = c(4.5, 4.5, 3, 1))
d1 <- density(b2_star); d2 <- density(b2_obs)
plot(d1, lwd = 2.5, col = "navy", xlim = range(d2$x), ylim = c(0, max(d1$y) * 1.05),
     main = "Erro de medição em Y: não vicia, mas aumenta a variância",
     xlab = expression(hat(beta)[2]), ylab = "densidade")
lines(d2, lwd = 2.5, col = "firebrick", lty = 2)
abline(v = beta2, col = "grey30")
legend("topright", bty = "n", cex = 0.8,
       legend = c("Y* sem erro (sigma_u = 0,3)", "Y = Y* + e (sigma_e = 0,4)",
                  "linha vertical: beta2 verdadeiro = 0,3"),
       col = c("navy", "firebrick", NA), lty = c(1, 2, NA), lwd = c(2.5, 2.5, NA))
fechar_png()

## ---- Resumo no console ----
cat("Ex. 40: b1 =", fmt(b1), " b2 =", fmt(b2), " previsão(20) =", fmt(Y0_hat, 4),
    " elasticidade =", fmt(elast, 4), "\n")
cat("        t2 =", fmt(t_b2^2, 4), " F =", fmt(F_calc, 4), " R2 =", fmt(R2, 6), " r2 =", fmt(r_XY^2, 6), "\n")
cat("MC: média b1 =", fmt(mean(b1_sim), 4), " média b2 =", fmt(mean(b2_sim), 5),
    " cov =", fmt(cov(b1_sim, b2_sim), 6), " (teórica", fmt(cov_teo, 6), ")\n")
cat("Ex. 15: viés teórico =", fmt(vies_teo, 4), " viés MC =", fmt(mean(b2_curta) - g2, 4), "\n")

gravar_resultados("m02")
