# --- bootstrap: localizar a raiz do repo e carregar helpers ---
.d <- getwd(); while (!file.exists(file.path(.d, ".repo-root")) && dirname(.d) != .d) .d <- dirname(.d)
source(file.path(.d, "R", "raiz.R"))

# Módulo 07, parte computacional (id m07a): Lista 1, ex. 38, 39 e 74.
# Nota correspondente: 07_testes_hipoteses/07_lista1_computacional.md
# Uso: powershell -ExecutionPolicy Bypass -File scripts\r.ps1 07_testes_hipoteses\07_computacional.R

suppressPackageStartupMessages({
  library(lmtest)     # resettest, dwtest, bgtest, bptest, coeftest
  library(car)        # vif, linearHypothesis
  library(sandwich)   # vcovHC
  library(moments)    # jarque.test
  library(wooldridge) # wage1 (ex. 74)
})
options(width = 100)

pasta_fig <- caminho_repo("07_testes_hipoteses", "figuras")
dir.create(pasta_fig, showWarnings = FALSE, recursive = TRUE)
fig <- function(nome) file.path(pasta_fig, nome)
secao <- function(txt) cat("\n\n==================== ", txt, " ====================\n", sep = "")

# Saída no estilo LIMDEP/NLOGIT (o formato das provas): Coefficient, Standard Error,
# b/St.Er., P[|Z|>z] (normal) e Mean of X. Função local deste script.
m07a_saida_nlogit <- function(mod, dep) {
  s  <- summary(mod); cf <- coef(s); X <- model.matrix(mod)
  n  <- nrow(X); K <- ncol(X); f <- s$fstatistic
  z  <- cf[, 1] / cf[, 2]; p <- 2 * pnorm(-abs(z)); mx <- colMeans(X)
  nomes <- sub("\\(Intercept\\)", "Constant", rownames(cf))
  linha <- strrep("-", 84)
  cat(linha, "\n")
  cat(sprintf("Ordinary least squares regression    LHS = %s   Mean = %.5f\n",
              dep, mean(model.response(model.frame(mod)))))
  cat(sprintf("Observations = %d   Parameters = %d   Deg.Fr. = %d\n", n, K, n - K))
  cat(sprintf("Std.Dev. of residuals = %.5f   Sum of squares = %.5f\n", s$sigma, deviance(mod)))
  cat(sprintf("R-squared = %.5f   Adjusted R-squared = %.5f\n", s$r.squared, s$adj.r.squared))
  cat(sprintf("Fit: F[%d,%d] = %.4f   Prob F > F* = %.5f\n", f[2], f[3], f[1],
              pf(f[1], f[2], f[3], lower.tail = FALSE)))
  cat(linha, "\n")
  cat(sprintf("%-10s %14s %15s %10s %9s %11s\n", "Variable", "Coefficient",
              "Standard Error", "b/St.Er.", "P[|Z|>z]", "Mean of X"))
  cat(linha, "\n")
  for (j in seq_len(K)) {
    mxj <- if (nomes[j] == "Constant") "" else sprintf("%11.5f", mx[j])
    cat(sprintf("%-10s %14.7f %15.7f %10.3f %9.4f %11s\n",
                nomes[j], cf[j, 1], cf[j, 2], z[j], p[j], mxj))
  }
  cat(linha, "\n")
}

## ---- Dados dos ex. 38 e 39 ----
# Lista 1, ex. 38 e 39 (mesma tabela): vendas de cabos telefônicos, 1993-2008 (n = 16).
# Y = vendas (milhões de metros); X1 = novas moradias (milhares); X2 = taxa de desemprego (%);
# X3 = taxa de juros (%); X4 = % de aumento das linhas; X5 = PIB (milhões de US$).
# Transcrito da Lista 1 (pp. 5) e conferido com a chave (reprodução exata do output impresso).
cabos <- data.frame(
  ano = 1993:2008,
  Y   = c(5873, 7852, 8189, 7497, 8534, 8688, 7270, 5020, 6035, 7425, 9400, 9350, 6540, 7675, 7419, 7923),
  X1  = c(1503.6, 1486.7, 1434.8, 2035.6, 2360.8, 2043.9, 1331.9, 1160.0,
          1535.0, 1961.8, 2009.3, 1721.9, 1298.0, 1100.0, 1039.0, 1200.0),
  X2  = c(3.6, 3.5, 5.0, 6.0, 5.6, 4.9, 5.6, 8.5, 7.7, 7.0, 6.0, 6.0, 7.2, 7.6, 9.2, 8.8),
  X3  = c(5.8, 6.7, 8.4, 3.2, 5.4, 5.9, 9.4, 9.4, 7.2, 6.6, 7.6, 10.6, 14.9, 16.6, 17.5, 16.0),
  X4  = c(5.9, 4.5, 4.2, 4.2, 4.9, 5.0, 4.1, 3.4, 4.2, 4.5, 3.9, 4.4, 3.9, 3.1, 0.6, 1.5),
  X5  = c(1051.8, 1078.8, 1075.3, 1107.5, 1171.1, 1235.0, 1217.8, 1202.3,
          1271.0, 1332.7, 1399.2, 1431.6, 1480.7, 1510.3, 1492.2, 1535.4)
)
n <- nrow(cabos); K <- 6   # K conta a constante (convenção do Greene): n - K = 10
xs <- c("X1", "X2", "X3", "X4", "X5")

## ---- Ex. 38 ----
secao("Ex. 38a - regressão completa")
m <- lm(Y ~ X1 + X2 + X3 + X4 + X5, data = cabos)
sm <- summary(m)
print(sm, digits = 7)
cf <- coef(sm)
for (j in 1:6) {
  registrar(paste0("m07a_ex38_b", j),  cf[j, 1])
  registrar(paste0("m07a_ex38_se", j), cf[j, 2])
  registrar(paste0("m07a_ex38_t", j),  cf[j, 3])
  registrar(paste0("m07a_ex38_p", j),  cf[j, 4])
}
registrar("m07a_ex38_r2",    sm$r.squared)
registrar("m07a_ex38_r2adj", sm$adj.r.squared)
registrar("m07a_ex38_s",     sm$sigma)
registrar("m07a_ex38_ssr",   deviance(m))
registrar("m07a_ex38_F",     sm$fstatistic[1])
registrar("m07a_ex38_pF",    pf(sm$fstatistic[1], 5, 10, lower.tail = FALSE))
registrar("m07a_ex38_ybar",  mean(cabos$Y))
registrar("m07a_ex38_ysd",   sd(cabos$Y))
registrar("m07a_ex38_n",     n)

secao("Ex. 38c - valores críticos a 10%")
t_crit10 <- qt(0.95, df = n - K)            # bicaudal a 10%, 10 g.l.
F_crit10 <- qf(0.90, df1 = K - 1, df2 = n - K)
cat("t crítico (10%, bicaudal, 10 g.l.) =", t_crit10, "\n")
cat("F crítico (10%; 5, 10)             =", F_crit10, "\n")
registrar("m07a_ex38_tcrit10", t_crit10)
registrar("m07a_ex38_Fcrit10", F_crit10)

secao("Ex. 38c - modelo só com os significativos a 10% (X1, X2, X4)")
mr <- lm(Y ~ X1 + X2 + X4, data = cabos)
smr <- summary(mr)
print(smr, digits = 7)
cfr <- coef(smr)
nomes_r <- c("b1", "b2", "b3", "b5")   # b3 = coef. de X2, b5 = coef. de X4 (notação da lista)
for (j in 1:4) {
  registrar(paste0("m07a_ex38r_", nomes_r[j]), cfr[j, 1])
  registrar(paste0("m07a_ex38r_p", sub("b", "", nomes_r[j])), cfr[j, 4])
}
registrar("m07a_ex38r_r2",    smr$r.squared)
registrar("m07a_ex38r_r2adj", smr$adj.r.squared)
registrar("m07a_ex38r_ssr",   deviance(mr))
registrar("m07a_ex38r_F",     smr$fstatistic[1])
registrar("m07a_ex38r_pF",    pf(smr$fstatistic[1], 3, 12, lower.tail = FALSE))

secao("Ex. 38c - teste F conjunto H0: beta4 = beta6 = 0 (X3 e X5 fora)")
an <- anova(mr, m)
print(an)
registrar("m07a_ex38_Fconj",      an$F[2])
registrar("m07a_ex38_pFconj",     an$`Pr(>F)`[2])
registrar("m07a_ex38_Fcrit10_2_10", qf(0.90, 2, 10))
# Mesmo F via R^2 (ambos os modelos têm o mesmo Y):
F_r2 <- ((sm$r.squared - smr$r.squared) / 2) / ((1 - sm$r.squared) / (n - K))
cat("F conjunto via R^2 =", F_r2, "\n")

secao("Ex. 38d - elasticidades na média")
el <- coef(m)[xs] * colMeans(cabos[xs]) / mean(cabos$Y)
print(round(el, 4))
for (j in 1:5) registrar(paste0("m07a_ex38_elast", j), el[j])
# Efeito de +1 p.p. de desemprego em % das vendas médias:
registrar("m07a_ex38_x2_pct_media", 100 * coef(m)["X2"] / mean(cabos$Y))

secao("Ex. 38e - R2 ajustado pela fórmula")
r2adj_formula <- 1 - (1 - sm$r.squared) * (n - 1) / (n - K)
cat("1 - (1 - R2)(n - 1)/(n - K) =", r2adj_formula, "\n")
stopifnot(abs(r2adj_formula - sm$adj.r.squared) < 1e-12)

## ---- Ex. 39 ----
secao("Ex. 39f - erro de digitação: X1 duas vezes => colinearidade perfeita")
Xdup <- cbind(1, cabos$X1, cabos$X2, cabos$X3, cabos$X1, cabos$X4, cabos$X5)
cat("colunas =", ncol(Xdup), " posto =", qr(Xdup)$rank, "\n")
registrar("m07a_ex39f_ncol_dup",  ncol(Xdup))
registrar("m07a_ex39f_posto_dup", qr(Xdup)$rank)

secao("Ex. 39g - RESET")
reset23 <- resettest(m, power = 2:3, type = "fitted")
reset2  <- resettest(m, power = 2,   type = "fitted")
print(reset23); print(reset2)
aux_reset <- lm(Y ~ X1 + X2 + X3 + X4 + X5 + I(fitted(m)^2) + I(fitted(m)^3), data = cabos)
print(summary(aux_reset), digits = 7)
LR_reset <- n * log(deviance(m) / deviance(aux_reset))
cat("LR = n ln(SSR_r/SSR_u) =", LR_reset, "  p =", pchisq(LR_reset, 2, lower.tail = FALSE), "\n")
registrar("m07a_ex39_reset_F",    reset23$statistic)
registrar("m07a_ex39_reset_p",    reset23$p.value)
registrar("m07a_ex39_reset_Fcrit10", qf(0.90, 2, 8))
registrar("m07a_ex39_reset2_F",   reset2$statistic)
registrar("m07a_ex39_reset2_p",   reset2$p.value)
registrar("m07a_ex39_reset_LR",   LR_reset)
registrar("m07a_ex39_reset_pLR",  pchisq(LR_reset, 2, lower.tail = FALSE))
registrar("m07a_ex39_reset_r2aux", summary(aux_reset)$r.squared)
registrar("m07a_ex39_reset_g2",   coef(aux_reset)[7])
registrar("m07a_ex39_reset_ssru", deviance(aux_reset))

secao("Ex. 39h - matriz de correlação e outros indicadores")
R <- cor(cabos[c("Y", xs)])
print(round(R, 6))
registrar("m07a_ex39_r_y_x1",  R["Y", "X1"])
registrar("m07a_ex39_r_x1_x3", R["X1", "X3"])
registrar("m07a_ex39_r_x2_x4", R["X2", "X4"])
registrar("m07a_ex39_r_x3_x4", R["X3", "X4"])
registrar("m07a_ex39_r_x3_x5", R["X3", "X5"])
registrar("m07a_ex39_r_x2_x5", R["X2", "X5"])
Rxx <- cor(cabos[xs])
registrar("m07a_ex39_det_rxx", det(Rxx))
# Número de condição de X com colunas escaladas para comprimento unitário (Belsley):
Xs <- apply(model.matrix(m), 2, function(v) v / sqrt(sum(v^2)))
ev <- eigen(crossprod(Xs), symmetric = TRUE, only.values = TRUE)$values
kappa_x <- sqrt(max(ev) / min(ev))
cat("det(Rxx) =", det(Rxx), "  número de condição =", kappa_x, "\n")
registrar("m07a_ex39_kappa", kappa_x)

secao("Ex. 39j - regressões auxiliares (cada X contra os demais)")
aux_tab <- t(sapply(xs, function(v) {
  f  <- reformulate(setdiff(xs, v), response = v)
  sa <- summary(lm(f, data = cabos))
  q  <- K - 2; gl2 <- n - K + 1              # 4 e 11
  Fj <- (sa$r.squared / q) / ((1 - sa$r.squared) / gl2)
  c(R2 = sa$r.squared, F = Fj, gl1 = q, gl2 = gl2,
    p = pf(Fj, q, gl2, lower.tail = FALSE), FIV = 1 / (1 - sa$r.squared))
}))
print(round(aux_tab, 4))
cat("FIV via car::vif:\n"); print(round(vif(m), 4))
stopifnot(all(abs(aux_tab[, "FIV"] - vif(m)) < 1e-8))
for (j in 1:5) {
  registrar(paste0("m07a_ex39_aux_r2_", j),  aux_tab[j, "R2"])
  registrar(paste0("m07a_ex39_aux_F_", j),   aux_tab[j, "F"])
  registrar(paste0("m07a_ex39_aux_p_", j),   aux_tab[j, "p"])
  registrar(paste0("m07a_ex39_fiv_", j),     aux_tab[j, "FIV"])
}
registrar("m07a_ex39_aux_Fcrit10", qf(0.90, 4, 11))
registrar("m07a_ex39_aux_Fcrit05", qf(0.95, 4, 11))

secao("Ex. 39k - regressão auxiliar de X1")
aux1 <- lm(X1 ~ X2 + X3 + X4 + X5, data = cabos)
print(summary(aux1), digits = 7)
r2a <- summary(aux1)$r.squared
F_certo <- (r2a / 4) / ((1 - r2a) / 11)
F_chave <- (r2a / 3) / ((1 - r2a) / 12)     # graus de liberdade usados na chave (errados)
cat("F correto (4, 11) =", F_certo, "  F com os g.l. da chave (3, 12) =", F_chave, "\n")
cat("F críticos: F.10(4,11) =", qf(0.90, 4, 11), " F.05(3,12) =", qf(0.95, 3, 12),
    " F.05(3,13) =", qf(0.95, 3, 13), " F.10(3,12) =", qf(0.90, 3, 12), "\n")
registrar("m07a_ex39k_F",        F_certo)
registrar("m07a_ex39k_p",        pf(F_certo, 4, 11, lower.tail = FALSE))
registrar("m07a_ex39k_F_glchave", F_chave)
registrar("m07a_ex39k_Fcrit05_3_12", qf(0.95, 3, 12))
registrar("m07a_ex39k_Fcrit05_3_13", qf(0.95, 3, 13))
registrar("m07a_ex39k_Fcrit10_3_12", qf(0.90, 3, 12))
registrar("m07a_ex39k_b_x3",     coef(aux1)["X3"])
registrar("m07a_ex39k_b_x5",     coef(aux1)["X5"])

secao("Ex. 39l - Durbin-Watson")
e <- resid(m); S <- sum(e^2)
dw  <- sum(diff(e)^2) / S
rho <- sum(e[-1] * e[-n]) / S
corr_bordas <- (e[1]^2 + e[n]^2) / S
cat("DW =", dw, " rho_hat =", rho, " 2(1 - rho_hat) =", 2 * (1 - rho),
    " (e1^2 + en^2)/SQR =", corr_bordas, "\n")
stopifnot(abs(dw - (2 * (1 - rho) - corr_bordas)) < 1e-12)   # identidade exata
dw_g <- dwtest(m, alternative = "greater")
dw_l <- dwtest(m, alternative = "less")
dw_2 <- dwtest(m, alternative = "two.sided")
print(dw_g); print(dw_l); print(dw_2)
registrar("m07a_ex39_dw",      dw)
registrar("m07a_ex39_rho",     rho)
registrar("m07a_ex39_2um_rho", 2 * (1 - rho))
registrar("m07a_ex39_dw_borda", corr_bordas)
registrar("m07a_ex39_dw_p_pos", dw_g$p.value)
registrar("m07a_ex39_dw_p_neg", dw_l$p.value)
registrar("m07a_ex39_dw_p_bi",  dw_2$p.value)
# Média exata de d sob H0 (erros normais): E[d] = tr(MA)/(n - K)
A <- diag(c(1, rep(2, n - 2), 1)); A[cbind(1:(n - 1), 2:n)] <- -1; A[cbind(2:n, 1:(n - 1))] <- -1
X <- model.matrix(m); M <- diag(n) - X %*% solve(crossprod(X)) %*% t(X)
Ed <- sum(diag(M %*% A)) / (n - K)
cat("E[d | H0] = tr(MA)/(n - K) =", Ed, "\n")
registrar("m07a_ex39_dw_media_H0", Ed)
# Limites dL e dU por simulação (distribuições-limite de Durbin-Watson, n = 16, k' = 5):
# autovalores de A em ordem crescente, lambda_1 = 0; dL usa lambda_2..lambda_{n-K+1},
# dU usa lambda_{K+1}..lambda_n (X contém a constante).
lam <- sort(eigen(A, symmetric = TRUE, only.values = TRUE)$values)
set.seed(20261002)
Rsim <- 400000
Z2 <- matrix(rnorm(Rsim * (n - K))^2, nrow = Rsim)
dL_sim <- as.vector(Z2 %*% lam[2:(n - K + 1)]) / rowSums(Z2)
dU_sim <- as.vector(Z2 %*% lam[(K + 1):n]) / rowSums(Z2)
lims <- sapply(c(0.01, 0.05, 0.10), function(a) c(dL = quantile(dL_sim, a, names = FALSE),
                                                   dU = quantile(dU_sim, a, names = FALSE)))
colnames(lims) <- c("1%", "5%", "10%")
print(round(lims, 3))
registrar("m07a_ex39_dL01", lims["dL", "1%"]);  registrar("m07a_ex39_dU01", lims["dU", "1%"])
registrar("m07a_ex39_dL05", lims["dL", "5%"]);  registrar("m07a_ex39_dU05", lims["dU", "5%"])
registrar("m07a_ex39_dL10", lims["dL", "10%"]); registrar("m07a_ex39_dU10", lims["dU", "10%"])
rm(Z2, dL_sim, dU_sim)

secao("Ex. 39l - Breusch-Godfrey (ordens 1, 2 e 3; resíduos pré-amostrais = 0)")
for (p in 1:3) {
  bl <- bgtest(m, order = p, type = "Chisq", fill = 0)
  bf <- bgtest(m, order = p, type = "F",     fill = 0)
  print(bl); print(bf)
  registrar(paste0("m07a_ex39_bg", p, "_LM"),  bl$statistic)
  registrar(paste0("m07a_ex39_bg", p, "_pLM"), bl$p.value)
  registrar(paste0("m07a_ex39_bg", p, "_F"),   bf$statistic)
  registrar(paste0("m07a_ex39_bg", p, "_pF"),  bf$p.value)
}
cat("Regressão auxiliar do BG de ordem 3 (reproduz a chave):\n")
bg3 <- bgtest(m, order = 3, fill = 0)
print(coeftest(bg3))
registrar("m07a_ex39_bg3_lag1", coef(bg3)["lag(resid)_1"])
registrar("m07a_ex39_bg3_lag2", coef(bg3)["lag(resid)_2"])
registrar("m07a_ex39_bg3_lag3", coef(bg3)["lag(resid)_3"])
registrar("m07a_ex39_bg3_r2aux", bg3$statistic / n)
cat("qchisq(0.90, 1:3) =", qchisq(0.90, 1:3), "\n")
registrar("m07a_ex39_chi2crit10_1", qchisq(0.90, 1))
registrar("m07a_ex39_chi2crit10_2", qchisq(0.90, 2))

secao("Ex. 39m - White")
# (i) White completo: níveis (5) + quadrados (5) + produtos cruzados (10) + constante = 21 parâmetros > n = 16
Xn  <- as.matrix(cabos[xs])
quad <- Xn^2
pares <- combn(5, 2)
cruz <- apply(pares, 2, function(ij) Xn[, ij[1]] * Xn[, ij[2]])
Zfull <- cbind(1, Xn, quad, cruz)
cat("White completo: parâmetros =", ncol(Zfull), " posto(Z) =", qr(Zfull)$rank, " n =", n, "\n")
registrar("m07a_ex39_white_full_npar",  ncol(Zfull))
registrar("m07a_ex39_white_full_posto", qr(Zfull)$rank)
# (ii) White sem termos cruzados: níveis + quadrados (10 regressores; 5 g.l. residuais)
w_lq <- bptest(m, ~ X1 + X2 + X3 + X4 + X5 + I(X1^2) + I(X2^2) + I(X3^2) + I(X4^2) + I(X5^2),
               data = cabos)
print(w_lq)
e2 <- e^2
aux_w <- lm(e2 ~ X1 + X2 + X3 + X4 + X5 + I(X1^2) + I(X2^2) + I(X3^2) + I(X4^2) + I(X5^2),
            data = cabos)
fw <- summary(aux_w)$fstatistic
cat("R2 aux =", summary(aux_w)$r.squared, "  n*R2 =", n * summary(aux_w)$r.squared,
    "  F(10,5) =", fw[1], "  p(F) =", pf(fw[1], 10, 5, lower.tail = FALSE), "\n")
registrar("m07a_ex39_white_lq_LM",  w_lq$statistic)
registrar("m07a_ex39_white_lq_p",   w_lq$p.value)
registrar("m07a_ex39_white_lq_F",   fw[1])
registrar("m07a_ex39_white_lq_pF",  pf(fw[1], 10, 5, lower.tail = FALSE))
registrar("m07a_ex39_white_lq_r2",  summary(aux_w)$r.squared)
registrar("m07a_ex39_chi2crit10_10", qchisq(0.90, 10))
# (iii) Só quadrados (a versão impressa na chave)
w_q <- bptest(m, ~ I(X1^2) + I(X2^2) + I(X3^2) + I(X4^2) + I(X5^2), data = cabos)
print(w_q)
aux_q <- lm(e2 ~ I(X1^2) + I(X2^2) + I(X3^2) + I(X4^2) + I(X5^2), data = cabos)
print(summary(aux_q), digits = 7)
fq <- summary(aux_q)$fstatistic
registrar("m07a_ex39_white_q_LM",  w_q$statistic)
registrar("m07a_ex39_white_q_p",   w_q$p.value)
registrar("m07a_ex39_white_q_F",   fq[1])
registrar("m07a_ex39_white_q_pF",  pf(fq[1], 5, 10, lower.tail = FALSE))
registrar("m07a_ex39_white_q_r2",  summary(aux_q)$r.squared)
registrar("m07a_ex39_chi2crit10_5", qchisq(0.90, 5))
# Breusch-Pagan original (não studentizado) com os quadrados: ESS/(2 sigma^4)
w_q_ns <- bptest(m, ~ I(X1^2) + I(X2^2) + I(X3^2) + I(X4^2) + I(X5^2), data = cabos,
                 studentize = FALSE)
print(w_q_ns)
registrar("m07a_ex39_white_q_bp_orig", w_q_ns$statistic)
# (iv) Forma especial (Wooldridge): e^2 contra y_hat e y_hat^2 (2 g.l.)
yh <- fitted(m)
w_esp <- bptest(m, ~ yh + I(yh^2), data = data.frame(cabos, yh = yh))
print(w_esp)
registrar("m07a_ex39_white_esp_LM", w_esp$statistic)
registrar("m07a_ex39_white_esp_p",  w_esp$p.value)

secao("Ex. 39 (extra) - normalidade dos resíduos (Jarque-Bera)")
jb <- jarque.test(as.vector(e))
print(jb)
registrar("m07a_ex39_jb",   jb$statistic)
registrar("m07a_ex39_jb_p", jb$p.value)
registrar("m07a_ex39_chi2crit10_2b", qchisq(0.90, 2))

## ---- Figuras dos ex. 38-39 ----
png(fig("07a_ex39_residuos.png"), width = 1600, height = 1000, res = 200)
op <- par(mfrow = c(1, 2), mar = c(4.2, 4.2, 3, 1))
plot(cabos$ano, e, type = "b", pch = 19, xlab = "Ano", ylab = "Resíduo de MQO",
     main = "Resíduos ao longo do tempo")
abline(h = 0, lty = 2, col = "gray40")
plot(e[-n], e[-1], pch = 19, xlab = expression(hat(e)[t - 1]), ylab = expression(hat(e)[t]),
     main = bquote("Resíduo contra o defasado (" * hat(rho) == .(sprintf("%.3f", rho)) * ")"))
abline(h = 0, v = 0, lty = 2, col = "gray40")
abline(lm(e[-1] ~ e[-n]), col = "firebrick", lwd = 2)
par(op); dev.off()

png(fig("07a_ex39_fiv.png"), width = 1600, height = 1000, res = 200)
op <- par(mar = c(4.2, 4.2, 3, 1))
bp <- barplot(aux_tab[, "FIV"], names.arg = xs, col = "steelblue", ylim = c(0, 20),
              ylab = "FIV = 1/(1 - R²ⱼ)", main = "Fatores de inflação da variância (ex. 39)")
abline(h = 10, lty = 2, col = "firebrick", lwd = 2)
text(bp, aux_tab[, "FIV"], labels = sprintf("%.2f", aux_tab[, "FIV"]), pos = 3, cex = 0.9)
legend("topleft", legend = "Regra de bolso: FIV = 10", lty = 2, col = "firebrick", bty = "n")
par(op); dev.off()

## ---- Ex. 74 ----
# Base: wooldridge::wage1 (CPS de 1976, n = 526 trabalhadores). Equação de Mincer:
# lwage = b1 + b2 educ + b3 exper + b4 exper^2 + b5 tenure + b6 female + b7 married + u
secao("Ex. 74 - especificação 1")
data("wage1", package = "wooldridge")
w1 <- lm(lwage ~ educ + exper + expersq + tenure + female + married, data = wage1)
sw1 <- summary(w1)
print(sw1, digits = 6)
m07a_saida_nlogit(w1, "LWAGE")
cw <- coef(sw1)
nomes_w <- c("const", "educ", "exper", "expersq", "tenure", "female", "married")
for (j in seq_along(nomes_w)) {
  registrar(paste0("m07a_ex74_b_",  nomes_w[j]), cw[j, 1])
  registrar(paste0("m07a_ex74_se_", nomes_w[j]), cw[j, 2])
  registrar(paste0("m07a_ex74_t_",  nomes_w[j]), cw[j, 3])
  registrar(paste0("m07a_ex74_p_",  nomes_w[j]), cw[j, 4])
}
registrar("m07a_ex74_n",     nobs(w1))
registrar("m07a_ex74_r2",    sw1$r.squared)
registrar("m07a_ex74_r2adj", sw1$adj.r.squared)
registrar("m07a_ex74_s",     sw1$sigma)
registrar("m07a_ex74_F",     sw1$fstatistic[1])
registrar("m07a_ex74_ybar",  mean(wage1$lwage))
registrar("m07a_ex74_media_educ",  mean(wage1$educ))
registrar("m07a_ex74_media_exper", mean(wage1$exper))
registrar("m07a_ex74_media_female", mean(wage1$female))
registrar("m07a_ex74_media_married", mean(wage1$married))
registrar("m07a_ex74_media_wage", mean(wage1$wage))

# Efeitos derivados
exper_max <- -coef(w1)["exper"] / (2 * coef(w1)["expersq"])
ef_exp_media <- coef(w1)["exper"] + 2 * coef(w1)["expersq"] * mean(wage1$exper)
fem_exato <- 100 * (exp(coef(w1)["female"]) - 1)
educ_exato <- 100 * (exp(coef(w1)["educ"]) - 1)
cat("exper* =", exper_max, "  efeito marginal de exper na média =", ef_exp_media,
    "  female exato (%) =", fem_exato, "  educ exato (%) =", educ_exato, "\n")
registrar("m07a_ex74_exper_max",  exper_max)
registrar("m07a_ex74_ef_exper_media", ef_exp_media)
registrar("m07a_ex74_female_exato", fem_exato)
registrar("m07a_ex74_educ_exato",   educ_exato)
registrar("m07a_ex74_pct_exper_acima_max", 100 * mean(wage1$exper > exper_max))
registrar("m07a_ex74_z05", qnorm(0.975))

secao("Ex. 74 - F conjunto de exper e expersq")
lh <- linearHypothesis(w1, c("exper = 0", "expersq = 0"))
print(lh)
registrar("m07a_ex74_Fexp",  lh$F[2])
registrar("m07a_ex74_pFexp", lh$`Pr(>F)`[2])

secao("Ex. 74 - testes de especificação e diagnóstico")
rs1 <- resettest(w1, power = 2:3, type = "fitted")
bp1 <- bptest(w1)
wh1 <- bptest(w1, ~ yh + I(yh^2), data = data.frame(wage1, yh = fitted(w1)))
jb1 <- jarque.test(as.vector(resid(w1)))
print(rs1); print(bp1); print(wh1); print(jb1)
cat("FIV:\n"); print(round(vif(w1), 4))
registrar("m07a_ex74_reset_F", rs1$statistic); registrar("m07a_ex74_reset_p", rs1$p.value)
registrar("m07a_ex74_bp",      bp1$statistic); registrar("m07a_ex74_bp_p",    bp1$p.value)
registrar("m07a_ex74_white_esp", wh1$statistic); registrar("m07a_ex74_white_esp_p", wh1$p.value)
registrar("m07a_ex74_jb",      jb1$statistic); registrar("m07a_ex74_jb_p",    jb1$p.value)
registrar("m07a_ex74_fiv_exper",   vif(w1)["exper"])
registrar("m07a_ex74_fiv_expersq", vif(w1)["expersq"])
registrar("m07a_ex74_chi2crit05_6", qchisq(0.95, 6))

secao("Ex. 74 - erros-padrão robustos (HC1)")
ct_rob <- coeftest(w1, vcov = vcovHC(w1, type = "HC1"))
print(ct_rob)
for (j in seq_along(nomes_w)) {
  registrar(paste0("m07a_ex74_serob_", nomes_w[j]), ct_rob[j, 2])
  registrar(paste0("m07a_ex74_trob_",  nomes_w[j]), ct_rob[j, 3])
}
registrar("m07a_ex74_prob_married", ct_rob["married", 4])

secao("Ex. 74 - especificação 2 (tenure^2 e interação female x married)")
w2 <- lm(lwage ~ educ + exper + expersq + tenure + tenursq + female * married, data = wage1)
sw2 <- summary(w2)
print(sw2, digits = 6)
rs2 <- resettest(w2, power = 2:3, type = "fitted")
print(rs2)
an12 <- anova(w1, w2)
print(an12)
registrar("m07a_ex74e2_r2adj",   sw2$adj.r.squared)
registrar("m07a_ex74e2_b_tenursq", coef(w2)["tenursq"])
registrar("m07a_ex74e2_p_tenursq", coef(sw2)["tenursq", 4])
registrar("m07a_ex74e2_b_married", coef(w2)["married"])
registrar("m07a_ex74e2_p_married", coef(sw2)["married", 4])
registrar("m07a_ex74e2_b_fem",     coef(w2)["female"])
registrar("m07a_ex74e2_b_int",     coef(w2)["female:married"])
registrar("m07a_ex74e2_p_int",     coef(sw2)["female:married", 4])
registrar("m07a_ex74e2_reset_F",   rs2$statistic)
registrar("m07a_ex74e2_reset_p",   rs2$p.value)
registrar("m07a_ex74e2_Fvs1",      an12$F[2])
registrar("m07a_ex74e2_pFvs1",     an12$`Pr(>F)`[2])
# Efeito de casar para mulheres (b_married + b_int) e seu teste t
lh_m <- linearHypothesis(w2, "married + female:married = 0")
ef_casar_mulher <- coef(w2)["married"] + coef(w2)["female:married"]
cat("efeito de casar para mulheres =", ef_casar_mulher, "  p =", lh_m$`Pr(>F)`[2], "\n")
registrar("m07a_ex74e2_casar_mulher",   ef_casar_mulher)
registrar("m07a_ex74e2_casar_mulher_p", lh_m$`Pr(>F)`[2])
tenure_max <- -coef(w2)["tenure"] / (2 * coef(w2)["tenursq"])
registrar("m07a_ex74e2_tenure_max", tenure_max)
cat("tenure* =", tenure_max, "\n")

## ---- Figuras do ex. 74 ----
png(fig("07a_ex74_perfil_exper.png"), width = 1600, height = 1000, res = 200)
op <- par(mar = c(4.2, 4.2, 3, 1))
grade <- 0:50
base <- data.frame(educ = mean(wage1$educ), exper = grade, expersq = grade^2,
                   tenure = mean(wage1$tenure), married = 1)
lh_h <- predict(w1, newdata = transform(base, female = 0))
lh_m2 <- predict(w1, newdata = transform(base, female = 1))
plot(grade, lh_h, type = "l", lwd = 2, col = "steelblue", ylim = range(c(lh_h, lh_m2)),
     xlab = "Experiência (anos)", ylab = "log(salário-hora) previsto",
     main = "Perfil experiência-salário (ex. 74, especificação 1)")
lines(grade, lh_m2, lwd = 2, col = "firebrick")
abline(v = exper_max, lty = 2, col = "gray30")
text(exper_max, min(lh_m2) + 0.05, sprintf("máximo em %.1f anos", exper_max), pos = 4, cex = 0.85)
legend("bottomright", legend = c("Homens casados", "Mulheres casadas"),
       col = c("steelblue", "firebrick"), lwd = 2, bty = "n")
mtext("educ e tenure nas médias amostrais", side = 3, line = 0.2, cex = 0.8)
par(op); dev.off()

png(fig("07a_ex74_residuos.png"), width = 1600, height = 1000, res = 200)
op <- par(mar = c(4.2, 4.2, 3, 1))
plot(fitted(w1), resid(w1)^2, pch = 19, col = rgb(0, 0, 0, 0.35),
     xlab = "Valor ajustado de log(salário)", ylab = "Resíduo ao quadrado",
     main = "Resíduos ao quadrado contra ajustados (ex. 74)")
lines(lowess(fitted(w1), resid(w1)^2), col = "firebrick", lwd = 2)
par(op); dev.off()

gravar_resultados("m07a")
