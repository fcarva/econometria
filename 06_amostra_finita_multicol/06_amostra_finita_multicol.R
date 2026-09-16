# Módulo 06 — Propriedades de amostra finita do MQO e multicolinearidade
# Script id: m06   (SL06; Lista 1, ex. 26, 32, 33, 36, 37, 53, 54, 63, 64)
#
# O que este script faz
#   A. Monte Carlo com X fixo: E[b|X] = beta, Cov(b|X) = s2 (X'X)^-1, E[s2|X] = sigma2,
#      (n-K)s2/sigma2 ~ qui2(n-K), independência entre b e s2, tamanho do teste t.
#   B. Variância incondicional: X sorteado a cada réplica -> Var(b) = sigma2 E[(X'X)^-1].
#   C. Gauss-Markov: estimadores lineares não viesados b* = [(X'X)^-1 X' + C] y com CX = 0.
#   D. Erros não esféricos (ex. 36/37): variância verdadeira × fórmula ingênua.
#   E. FIV por regressões auxiliares × car::vif e número de condição (dados Longley, base R).
#   F. Ex. 54: regressão auxiliar com os dados dos cabos (Lista 1, ex. 38/39).
#   G. Ex. 63 e ex. 64: matrizes de correlação, FIV por pares e FIV completo.
#   H. Ex. 53: viés × variância na omissão de variável (EQM), com estimador de pré-teste.
#   I. Output ilustrativo no formato LIMDEP/NLOGIT com multicolinearidade + componentes principais.
#
# Rodar: powershell -ExecutionPolicy Bypass -File scripts\r.ps1 06_amostra_finita_multicol\06_amostra_finita_multicol.R

# --- bootstrap: localizar a raiz do repo e carregar helpers ---
.d <- getwd(); while (!file.exists(file.path(.d, ".repo-root")) && dirname(.d) != .d) .d <- dirname(.d)
source(file.path(.d, "R", "raiz.R"))

suppressPackageStartupMessages(library(car))

dir_fig <- caminho_repo("06_amostra_finita_multicol", "figuras")
dir.create(dir_fig, showWarnings = FALSE, recursive = TRUE)
abrir_png <- function(nome) png(file.path(dir_fig, nome), width = 1600, height = 1000, res = 200)

cat("\n=========== Módulo 06 (m06) ===========\n")

## ---- A. Monte Carlo com X fixo (SL06, p. 11-13, 22, 34, 37-40) ----
set.seed(20260915)
n <- 30; K <- 3
beta  <- c(1, 0.5, -0.3)
sigma <- 2
R     <- 10000

x2 <- rnorm(n, 10, 2)
x3 <- 0.8 * x2 + rnorm(n, 0, 1.2)       # regressores correlacionados, mas posto completo
X  <- cbind(1, x2, x3)                   # n x K

XtX_inv <- solve(crossprod(X))           # K x K
A <- XtX_inv %*% t(X)                    # K x n   (b = A y)
M <- diag(n) - X %*% A                   # n x n   (residual maker)

# Propriedades algébricas de M (D06.5): simétrica, idempotente, MX = 0, tr(M) = n - K
stopifnot(max(abs(M - t(M))) < 1e-10, max(abs(M %*% M - M)) < 1e-10, max(abs(M %*% X)) < 1e-10)
autoval_M <- eigen(M, symmetric = TRUE, only.values = TRUE)$values
registrar("m06_trM", sum(diag(M)))
registrar("m06_autoval_M_uns", sum(abs(autoval_M - 1) < 1e-8))
registrar("m06_autoval_M_zeros", sum(abs(autoval_M) < 1e-8))
registrar("m06_mc_cor_x2x3", cor(x2, x3))

Eps <- matrix(rnorm(n * R, 0, sigma), n, R)
Y   <- drop(X %*% beta) + Eps           # n x R (cada coluna é uma amostra; X fixo)
B   <- A %*% Y                          # K x R
E   <- M %*% Y                          # resíduos = M eps
s2  <- colSums(E^2) / (n - K)

V_teo <- sigma^2 * XtX_inv
V_sim <- cov(t(B))

registrar("m06_mc_media_b1", mean(B[1, ]))
registrar("m06_mc_media_b2", mean(B[2, ]))
registrar("m06_mc_media_b3", mean(B[3, ]))
registrar("m06_mc_var_b2_teo", V_teo[2, 2])
registrar("m06_mc_var_b2_sim", V_sim[2, 2])
registrar("m06_mc_var_b3_teo", V_teo[3, 3])
registrar("m06_mc_var_b3_sim", V_sim[3, 3])
registrar("m06_mc_cov_b2b3_teo", V_teo[2, 3])
registrar("m06_mc_cov_b2b3_sim", V_sim[2, 3])
registrar("m06_mc_erro_rel_max_diag", max(abs(diag(V_sim) - diag(V_teo)) / diag(V_teo)))

registrar("m06_mc_media_s2", mean(s2))
registrar("m06_mc_media_s", mean(sqrt(s2)))                        # E[s] < sigma = 2 (Jensen)
registrar("m06_mc_media_een", mean(colSums(E^2) / n))            # e'e/n: viesado para baixo
registrar("m06_mc_een_teo", sigma^2 * (n - K) / n)

q <- (n - K) * s2 / sigma^2
registrar("m06_mc_media_q", mean(q))                                # teórico: n - K = 27
registrar("m06_mc_var_q", var(q))                                   # teórico: 2(n - K) = 54
registrar("m06_mc_cor_b2_s2", cor(B[2, ], s2))                      # independência sob A6

tstat <- (B[2, ] - beta[2]) / sqrt(s2 * XtX_inv[2, 2])
registrar("m06_mc_tamanho_t", mean(abs(tstat) > qt(0.975, n - K)))
registrar("m06_mc_tcrit", qt(0.975, n - K))

cat(sprintf("A. media(b) = (%.4f, %.4f, %.4f) | Var(b2): teo %.5f sim %.5f | E[s2]: %.4f | var(q): %.3f\n",
            mean(B[1, ]), mean(B[2, ]), mean(B[3, ]), V_teo[2, 2], V_sim[2, 2], mean(s2), var(q)))

# D06.9: Var(b_k|X) = sigma2 / [(1 - R_k^2) S_kk], com R_k^2 da regressão auxiliar de x_k nos demais
r2_x3 <- summary(lm(x3 ~ x2))$r.squared
S33   <- sum((x3 - mean(x3))^2)
var_b3_fwl <- sigma^2 / ((1 - r2_x3) * S33)
stopifnot(abs(var_b3_fwl - V_teo[3, 3]) < 1e-12)
registrar("m06_mc_r2_aux_x3", r2_x3)
registrar("m06_mc_fiv_x3", 1 / (1 - r2_x3))
registrar("m06_mc_var_b3_fwl", var_b3_fwl)
registrar("m06_mc_var_b3_sem_colin", sigma^2 / S33)                  # se x3 fosse ortogonal a x2

# Figura 1: distribuição amostral de b2 com X fixo
abrir_png("m06_dist_b2.png")
hist(B[2, ], breaks = 60, freq = FALSE, col = "grey85", border = "white",
     main = "Distribuição amostral de b2 com X fixo (10.000 réplicas)",
     xlab = expression(b[2]), ylab = "Densidade")
curve(dnorm(x, beta[2], sqrt(V_teo[2, 2])), add = TRUE, lwd = 2, col = "firebrick")
abline(v = beta[2], lwd = 2, lty = 2, col = "navy")
legend("topright", bty = "n",
       legend = c("N(beta2, sigma2 [(X'X)^-1]_22)", "beta2 verdadeiro = 0,5"),
       col = c("firebrick", "navy"), lwd = 2, lty = c(1, 2))
dev.off()

# Figura 2: (n-K)s2/sigma2 contra a densidade qui-quadrado(n-K)
abrir_png("m06_qui2_s2.png")
hist(q, breaks = 60, freq = FALSE, col = "grey85", border = "white",
     main = sprintf("(n-K)s2/sigma2 em 10.000 réplicas contra qui-quadrado(%d)", n - K),
     xlab = "(n-K) s2 / sigma2", ylab = "Densidade")
curve(dchisq(x, df = n - K), add = TRUE, lwd = 2, col = "firebrick")
abline(v = n - K, lwd = 2, lty = 2, col = "navy")
legend("topright", bty = "n", legend = c(sprintf("densidade qui-quadrado(%d)", n - K), "média teórica n - K"),
       col = c("firebrick", "navy"), lwd = 2, lty = c(1, 2))
dev.off()

## ---- B. Variância incondicional: X aleatório (SL06, p. 23) ----
set.seed(20260916)
R_inc <- 5000
B_inc <- matrix(NA_real_, K, R_inc)
soma_inv <- matrix(0, K, K); soma_xtx <- matrix(0, K, K)
for (r in seq_len(R_inc)) {
  x2r <- rnorm(n, 10, 2); x3r <- 0.8 * x2r + rnorm(n, 0, 1.2)
  Xr  <- cbind(1, x2r, x3r)
  XtXr <- crossprod(Xr); invr <- solve(XtXr)
  yr  <- Xr %*% beta + rnorm(n, 0, sigma)
  B_inc[, r] <- invr %*% crossprod(Xr, yr)
  soma_inv <- soma_inv + invr; soma_xtx <- soma_xtx + XtXr
}
E_inv <- soma_inv / R_inc                 # estima E[(X'X)^-1]
E_xtx <- soma_xtx / R_inc                 # estima E[X'X]
registrar("m06_inc_media_b2", mean(B_inc[2, ]))
registrar("m06_inc_var_b2_sim", var(B_inc[2, ]))
registrar("m06_inc_var_b2_teo", sigma^2 * E_inv[2, 2])
registrar("m06_inc_var_b2_jensen", sigma^2 * solve(E_xtx)[2, 2])  # sigma2 [E(X'X)]^-1: NÃO é a variância
cat(sprintf("B. Var(b2) incondicional: sim %.5f | sigma2 E[(X'X)^-1]_22 %.5f | sigma2 [E(X'X)]^-1_22 %.5f\n",
            var(B_inc[2, ]), sigma^2 * E_inv[2, 2], sigma^2 * solve(E_xtx)[2, 2]))

## ---- C. Gauss-Markov: concorrentes lineares não viesados (SL06, p. 30-32; ex. 33) ----
# C1: MQO só com a primeira metade da amostra. É linear em y e não viesado.
m_meio <- n / 2
X_meio <- X[1:m_meio, ]
A_meio <- cbind(solve(crossprod(X_meio)) %*% t(X_meio), matrix(0, K, n - m_meio))  # K x n
C1 <- A_meio - A
stopifnot(max(abs(C1 %*% X)) < 1e-10)                        # CX = 0
# C2: C = D M para uma D (K x n) arbitrária: CX = D M X = 0 automaticamente
set.seed(20260917)
D  <- matrix(rnorm(K * n, 0, 0.05), K, n)
C2 <- D %*% M
stopifnot(max(abs(C2 %*% X)) < 1e-10)

Bs1 <- (A + C1) %*% Y
Bs2 <- (A + C2) %*% Y
V1_teo <- sigma^2 * (XtX_inv + C1 %*% t(C1))
V2_teo <- sigma^2 * (XtX_inv + C2 %*% t(C2))
stopifnot(max(abs(V1_teo - sigma^2 * solve(crossprod(X_meio)))) < 1e-8)  # = sigma2 (X1'X1)^-1

registrar("m06_gm_media_b2_meio", mean(Bs1[2, ]))
registrar("m06_gm_media_b2_dm", mean(Bs2[2, ]))
registrar("m06_gm_var_b2_meio_teo", V1_teo[2, 2])
registrar("m06_gm_var_b2_meio_sim", var(Bs1[2, ]))
registrar("m06_gm_var_b2_dm_teo", V2_teo[2, 2])
registrar("m06_gm_var_b2_dm_sim", var(Bs2[2, ]))
registrar("m06_gm_razao_var_b2_meio", V1_teo[2, 2] / V_teo[2, 2])
registrar("m06_gm_razao_var_b2_dm", V2_teo[2, 2] / V_teo[2, 2])
registrar("m06_gm_autoval_min_cc1", min(eigen(sigma^2 * C1 %*% t(C1), symmetric = TRUE)$values))
registrar("m06_gm_autoval_min_cc2", min(eigen(sigma^2 * C2 %*% t(C2), symmetric = TRUE)$values))
# Se CX != 0 (C = D sem o M), o estimador é viesado: E[b*|X] - beta = C X beta
vies_cx <- drop(D %*% X %*% beta)
registrar("m06_gm_vies_b2_cx", vies_cx[2])
registrar("m06_gm_vies_b2_cx_sim", mean(((A + D) %*% Y)[2, ]) - beta[2])
cat(sprintf("C. Var(b2): MQO %.5f | metade %.5f | C=DM %.5f\n", V_teo[2, 2], V1_teo[2, 2], V2_teo[2, 2]))

abrir_png("m06_gauss_markov.png")
dd0 <- density(B[2, ]); dd1 <- density(Bs1[2, ]); dd2 <- density(Bs2[2, ])
plot(dd0, lwd = 2, col = "navy", main = "Gauss-Markov: b2 do MQO × dois concorrentes lineares não viesados",
     xlab = expression(b[2]), ylab = "Densidade", ylim = c(0, max(dd0$y) * 1.05),
     xlim = range(dd1$x))
lines(dd1, lwd = 2, col = "firebrick", lty = 2)
lines(dd2, lwd = 2, col = "darkgreen", lty = 3)
abline(v = beta[2], lty = 2)
legend("topright", bty = "n", lwd = 2, lty = 1:3, col = c("navy", "firebrick", "darkgreen"),
       legend = c("MQO (todas as n obs.)", "MQO na 1ª metade: C = A_meio - A", "C = D M (arbitrária)"))
dev.off()

## ---- D. Erros não esféricos (ex. 36 e 37) ----
# D1: heterocedasticidade, Var(eps_i|X) = sigma2 * w_i (diagonal NÃO constante)
w <- 0.1 + ((x2 - mean(x2)) / sd(x2))^2                        # variância cresce com o desvio de x2
Sig_h <- sigma^2 * diag(w)
V_h_verd <- A %*% Sig_h %*% t(A)                               # (X'X)^-1 X' Sigma X (X'X)^-1
Es2_h    <- sum(diag(M %*% Sig_h)) / (n - K)                    # E[s2|X] = tr(M Sigma)/(n-K)
V_h_ing  <- Es2_h * XtX_inv
registrar("m06_nesf_het_razao_dp_b2", sqrt(V_h_ing[2, 2] / V_h_verd[2, 2]))
# D2: autocorrelação AR(1), rho = 0,6, diagonal constante (o caso do ex. 37), X com tendência
rho <- 0.6
Xt  <- cbind(1, 1:n)
At  <- solve(crossprod(Xt)) %*% t(Xt)
Mt  <- diag(n) - Xt %*% At
Sig_a <- sigma^2 * rho^abs(outer(1:n, 1:n, "-"))
V_a_verd <- At %*% Sig_a %*% t(At)
Es2_a    <- sum(diag(Mt %*% Sig_a)) / (n - 2)
V_a_ing  <- Es2_a * solve(crossprod(Xt))
registrar("m06_nesf_ar1_rho", rho)
registrar("m06_nesf_ar1_Es2", Es2_a)
registrar("m06_nesf_ar1_razao_dp_b2", sqrt(V_a_ing[2, 2] / V_a_verd[2, 2]))
cat(sprintf("D. dp ingênuo / dp verdadeiro de b2: heterocedástico %.3f | AR(1) %.3f\n",
            sqrt(V_h_ing[2, 2] / V_h_verd[2, 2]), sqrt(V_a_ing[2, 2] / V_a_verd[2, 2])))

## ---- E. FIV por regressões auxiliares × car::vif; número de condição (Longley, base R) ----
data(longley)
f_lo <- Employed ~ Year + GNP.deflator + GNP + Armed.Forces
lo61 <- subset(longley, Year <= 1961)
m61  <- lm(f_lo, data = lo61)
m62  <- lm(f_lo, data = longley)
# FIV na amostra completa 1947-1962: são os números da Tabela 4.9 do Greene reproduzida no SL06, p. 52
fiv_car <- car::vif(m62)
reg_lo  <- c("Year", "GNP.deflator", "GNP", "Armed.Forces")
fiv_aux <- sapply(reg_lo, function(v) {
  r2 <- summary(lm(reformulate(setdiff(reg_lo, v), response = v), data = longley))$r.squared
  1 / (1 - r2)
})
stopifnot(max(abs(fiv_aux - fiv_car[reg_lo])) < 1e-6)
registrar("m06_lo_fiv_year", fiv_aux[["Year"]])
registrar("m06_lo_fiv_deflator", fiv_aux[["GNP.deflator"]])
registrar("m06_lo_fiv_gnp", fiv_aux[["GNP"]])
registrar("m06_lo_fiv_armed", fiv_aux[["Armed.Forces"]])
registrar("m06_lo_dif_max_aux_car", max(abs(fiv_aux - fiv_car[reg_lo])))
var_pct <- 100 * (coef(m62) - coef(m61)) / abs(coef(m61))      # variação % ao acrescentar 1962
registrar("m06_lo_varpct_deflator", var_pct[["GNP.deflator"]])
registrar("m06_lo_varpct_gnp", var_pct[["GNP"]])
registrar("m06_lo_varpct_armed", var_pct[["Armed.Forces"]])
registrar("m06_lo_varpct_year", var_pct[["Year"]])
# Número de condição: colunas de X escaladas para comprimento 1 (Belsley), inclusive a constante
Xlo  <- model.matrix(m62)
Xlo_n <- sweep(Xlo, 2, sqrt(colSums(Xlo^2)), "/")
ev_n <- eigen(crossprod(Xlo_n), symmetric = TRUE, only.values = TRUE)$values
ev_b <- eigen(crossprod(Xlo), symmetric = TRUE, only.values = TRUE)$values
registrar("m06_lo_ncond_escalado", sqrt(max(ev_n) / min(ev_n)))
registrar("m06_lo_ncond_bruto", sqrt(max(ev_b) / min(ev_b)))
cat("E. Longley FIV:", paste(sprintf("%s=%.2f", reg_lo, fiv_aux), collapse = "  "),
    sprintf("| n. de condição escalado %.1f\n", sqrt(max(ev_n) / min(ev_n))))

## ---- F. Ex. 54 aplicado aos dados dos cabos (Lista 1, ex. 38/39) ----
# Fonte: Lista 1, ex. 38 (dados de 1993 a 2008). Y = vendas; X1..X5 = regressores.
cabos <- data.frame(
  Y  = c(5873, 7852, 8189, 7497, 8534, 8688, 7270, 5020, 6035, 7425, 9400, 9350, 6540, 7675, 7419, 7923),
  X1 = c(1503.6, 1486.7, 1434.8, 2035.6, 2360.8, 2043.9, 1331.9, 1160.0, 1535.0, 1961.8, 2009.3,
         1721.9, 1298.0, 1100.0, 1039.0, 1200.0),
  X2 = c(3.6, 3.5, 5.0, 6.0, 5.6, 4.9, 5.6, 8.5, 7.7, 7.0, 6.0, 6.0, 7.2, 7.6, 9.2, 8.8),
  X3 = c(5.8, 6.7, 8.4, 3.2, 5.4, 5.9, 9.4, 9.4, 7.2, 6.6, 7.6, 10.6, 14.9, 16.6, 17.5, 16.0),
  X4 = c(5.9, 4.5, 4.2, 4.2, 4.9, 5.0, 4.1, 3.4, 4.2, 4.5, 3.9, 4.4, 3.9, 3.1, 0.6, 1.5),
  X5 = c(1051.8, 1078.8, 1075.3, 1107.5, 1171.1, 1235.0, 1217.8, 1202.3, 1271.0, 1332.7, 1399.2,
         1431.6, 1480.7, 1510.3, 1492.2, 1535.4))
m_cab <- lm(Y ~ X1 + X2 + X3 + X4 + X5, data = cabos)
# Conferência contra o output impresso na lista/chave (coeficientes da regressão completa)
coef_impresso <- c(5825.770, 2.634745, -792.0364, 59.90977, -813.6942, 4.059899)
stopifnot(max(abs(coef(m_cab) - coef_impresso) / abs(coef_impresso)) < 1e-5)

m_aux <- lm(X1 ~ X2 + X3 + X4 + X5, data = cabos)
s_aux <- summary(m_aux)
n_c <- nrow(cabos); k_c <- 6                                   # k = parâmetros do modelo original
r2a <- s_aux$r.squared
F_aux <- (r2a / (k_c - 2)) / ((1 - r2a) / (n_c - k_c + 1))    # Gujarati: F(k-2, n-k+1) = F(4, 11)
stopifnot(abs(F_aux - s_aux$fstatistic[["value"]]) < 1e-8)
registrar("m06_ex54_r2aux", r2a)
registrar("m06_ex54_faux", F_aux)
registrar("m06_ex54_gl1", k_c - 2)
registrar("m06_ex54_gl2", n_c - k_c + 1)
registrar("m06_ex54_paux", pf(F_aux, k_c - 2, n_c - k_c + 1, lower.tail = FALSE))
registrar("m06_ex54_fcrit10", qf(0.90, k_c - 2, n_c - k_c + 1))
registrar("m06_ex54_fiv_x1", 1 / (1 - r2a))
registrar("m06_ex54_r2_modelo", summary(m_cab)$r.squared)       # regra de Klein: comparar com R2 aux
registrar("m06_ex54_f_gl_errados", (round(r2a, 4) / 3) / ((1 - round(r2a, 4)) / 12))  # conta da chave, gl (3,12)
registrar("m06_ex54_fcrit10_gl_errados", qf(0.90, 3, 12))
fiv_cab <- car::vif(m_cab)
for (v in names(fiv_cab)) registrar(paste0("m06_ex54_fiv_", tolower(v)), fiv_cab[[v]])
cat(sprintf("F. Ex. 54 (cabos): R2aux = %.6f, F(4,11) = %.5f, p = %.6f, FIV_X1 = %.3f\n",
            r2a, F_aux, pf(F_aux, 4, 11, lower.tail = FALSE), 1 / (1 - r2a)))
print(round(fiv_cab, 3))

## ---- G. Ex. 63 e ex. 64: matrizes de correlação ----
fiv_par <- function(r) 1 / (1 - r^2)

# Ex. 63 (Lista 1, ex. 63). Ordem: EXPORT, PRECO, RENDABR, RENDACH.
# A matriz impressa NÃO é simétrica: RENDABR-RENDACH = 0,88725 (acima) e 0,88720 (abaixo).
R63 <- matrix(c(1,       0.07872, 0.55625, 0.63863,
                0.07872, 1,       0.12091, 0.23902,
                0.55625, 0.12091, 1,       0.88725,
                0.63863, 0.23902, 0.88720, 1), 4, 4, byrow = TRUE,
              dimnames = list(c("EXPORT", "PRECO", "RENDABR", "RENDACH"),
                              c("EXPORT", "PRECO", "RENDABR", "RENDACH")))
registrar("m06_ex63_assimetria", max(abs(R63 - t(R63))))
R63s <- (R63 + t(R63)) / 2                                     # simetriza (média das duas células)
Rxx63 <- R63s[-1, -1]; rxy63 <- R63s[-1, 1]
registrar("m06_ex63_fivpar_preco_rendabr", fiv_par(R63s["PRECO", "RENDABR"]))
registrar("m06_ex63_fivpar_preco_rendach", fiv_par(R63s["PRECO", "RENDACH"]))
registrar("m06_ex63_fivpar_br_ch_sup", fiv_par(0.88725))
registrar("m06_ex63_fivpar_br_ch_inf", fiv_par(0.88720))
fiv63 <- diag(solve(Rxx63))
registrar("m06_ex63_fiv_preco", fiv63[["PRECO"]])
registrar("m06_ex63_fiv_rendabr", fiv63[["RENDABR"]])
registrar("m06_ex63_fiv_rendach", fiv63[["RENDACH"]])
r2y63 <- drop(t(rxy63) %*% solve(Rxx63) %*% rxy63)            # R2 de EXPORT nos três regressores
registrar("m06_ex63_r2_export", r2y63)
registrar("m06_ex63_r2_br_ch", 0.88725^2)                       # regra de Klein: r2 do par × R2
ev63 <- eigen(Rxx63, symmetric = TRUE, only.values = TRUE)$values
registrar("m06_ex63_autoval_min", min(ev63))
registrar("m06_ex63_ncond", sqrt(max(ev63) / min(ev63)))
cat(sprintf("G. Ex. 63: FIV par BR-CH = %.4f | FIV completos = %s | R2 EXPORT = %.4f\n",
            fiv_par(0.88725), paste(sprintf("%.3f", fiv63), collapse = ", "), r2y63))

# Ex. 64 (Lista 1, ex. 64). Ordem: Y, X1, X2, X3.
R64 <- matrix(c(1,    0.86, 0.95,  0.54,
                0.86, 1,    0.92,  0.05,
                0.95, 0.92, 1,    -0.63,
                0.54, 0.05, -0.63, 1), 4, 4, byrow = TRUE,
              dimnames = list(c("Y", "X1", "X2", "X3"), c("Y", "X1", "X2", "X3")))
stopifnot(isSymmetric(R64))
registrar("m06_ex64_fivpar_x1x2", fiv_par(0.92))
registrar("m06_ex64_fivpar_x1x3", fiv_par(0.05))
registrar("m06_ex64_fivpar_x2x3", fiv_par(-0.63))
Rxx64 <- R64[-1, -1]
ev64 <- eigen(Rxx64, symmetric = TRUE, only.values = TRUE)$values
registrar("m06_ex64_autoval_min", min(ev64))
registrar("m06_ex64_det_rxx", det(Rxx64))
# R2 "implícito" de X1 sobre X2 e X3: r' R23^-1 r (tem de estar em [0,1] numa matriz válida)
r1 <- Rxx64[1, 2:3]; R23 <- Rxx64[2:3, 2:3]
r2_x1_impl <- drop(t(r1) %*% solve(R23) %*% r1)
registrar("m06_ex64_r2_x1_implicito", r2_x1_impl)
ev64_4 <- eigen(R64, symmetric = TRUE, only.values = TRUE)$values
registrar("m06_ex64_autoval_min_4x4", min(ev64_4))
cat(sprintf("G. Ex. 64: FIV por pares = %.4f, %.4f, %.4f | menor autovalor Rxx = %.4f | R2 implícito X1 = %.4f\n",
            fiv_par(0.92), fiv_par(0.05), fiv_par(-0.63), min(ev64), r2_x1_impl))

# Exemplo válido: correlações por pares moderadas e multicolinearidade forte a três.
# x1, x2 independentes com variância 1; x3 = x1 + x2 + u, Var(u) = 0,02 (matriz populacional).
d2 <- 0.02
S3 <- matrix(c(1, 0, 1,
               0, 1, 1,
               1, 1, 2 + d2), 3, 3, byrow = TRUE)
R3 <- cov2cor(S3)
registrar("m06_ex64_contra_r13", R3[1, 3])
registrar("m06_ex64_contra_fivpar_max", max(fiv_par(R3[upper.tri(R3)])))
registrar("m06_ex64_contra_fiv_x3", diag(solve(R3))[3])

# Figura 4: FIV = 1/(1 - R2) com os pares dos ex. 63 e 64
abrir_png("m06_fiv.png")
rr <- seq(0, 0.97, by = 0.001)
plot(rr, 1 / (1 - rr), type = "l", lwd = 2, col = "navy", log = "y",
     main = "Fator de inflação da variância: FIV = 1/(1 - R2)",
     xlab = "R2 da regressão auxiliar (por pares: r2)", ylab = "FIV (escala log)")
abline(h = c(5, 10), lty = c(3, 2), col = "grey40")
text(0.02, 10, "FIV = 10", pos = 3, cex = 0.8); text(0.02, 5, "FIV = 5", pos = 3, cex = 0.8)
pts <- c("ex63 RENDABR-RENDACH" = 0.88725^2, "ex64 X1-X2" = 0.92^2, "ex64 X2-X3" = 0.63^2)
points(pts, 1 / (1 - pts), pch = 19, col = c("firebrick", "darkgreen", "darkorange"), cex = 1.3)
legend("topleft", bty = "n", pch = 19, col = c("firebrick", "darkgreen", "darkorange"),
       legend = sprintf("%s: FIV = %.2f", names(pts), 1 / (1 - pts)), inset = c(0.05, 0.08))
dev.off()

## ---- H. Ex. 53: omissão de variável — viés, variância e EQM (SL06, p. 24-25) ----
set.seed(20260918)
nH <- 50; sigH <- 1; b1H <- 1; RH <- 5000
z1 <- rnorm(nH); z2 <- rnorm(nH)
xa <- z1; xb <- 0.9 * z1 + sqrt(1 - 0.81) * z2            # corr populacional 0,9
XL <- cbind(1, xa, xb); XS <- cbind(1, xa)
XLi <- solve(crossprod(XL)); XSi <- solve(crossprod(XS))
AL <- XLi %*% t(XL); AS <- XSi %*% t(XS); ML <- diag(nH) - XL %*% AL
P12 <- drop(XSi %*% crossprod(XS, xb))                        # coef. de xb em (1, xa): delta = P12[2]
var_L1 <- sigH^2 * XLi[2, 2]; var_S1 <- sigH^2 * XSi[2, 2]; var_L2 <- sigH^2 * XLi[3, 3]
# Identidade de D06.10: Var(b1 longo) - Var(b1 curto) = delta^2 Var(b2 longo)
stopifnot(abs((var_L1 - var_S1) - P12[2]^2 * var_L2) < 1e-10)
registrar("m06_ex53_cor_amostral", cor(xa, xb))
registrar("m06_ex53_delta", P12[2])
registrar("m06_ex53_razao_var_curta_longa", var_S1 / var_L1)
eqm_S_teo <- function(tau) (var_S1 + (P12[2] * tau * sqrt(var_L2))^2) / var_L1  # relativo a Var(b1 longo)
tau_grid <- seq(0, 3, by = 0.25)
EpsH <- matrix(rnorm(nH * RH, 0, sigH), nH, RH)
tcH <- qt(0.975, nH - 3)
res <- t(sapply(tau_grid, function(tau) {
  b2H <- tau * sqrt(var_L2)
  YH <- drop(XL %*% c(0, b1H, b2H)) + EpsH
  BL <- AL %*% YH; BS <- AS %*% YH
  s2L <- colSums((ML %*% YH)^2) / (nH - 3)
  usa_longa <- abs(BL[3, ] / sqrt(s2L * XLi[3, 3])) > tcH
  bPT <- ifelse(usa_longa, BL[2, ], BS[2, ])
  c(tau = tau,
    longa = mean((BL[2, ] - b1H)^2) / var_L1,
    curta = mean((BS[2, ] - b1H)^2) / var_L1,
    pre   = mean((bPT - b1H)^2) / var_L1)
}))
registrar("m06_ex53_eqm_curta_tau0_teo", eqm_S_teo(0))
registrar("m06_ex53_eqm_curta_tau1_teo", eqm_S_teo(1))
registrar("m06_ex53_eqm_curta_tau2_teo", eqm_S_teo(2))
registrar("m06_ex53_eqm_curta_tau0_sim", res[res[, "tau"] == 0, "curta"])
registrar("m06_ex53_eqm_curta_tau2_sim", res[res[, "tau"] == 2, "curta"])
registrar("m06_ex53_eqm_longa_tau2_sim", res[res[, "tau"] == 2, "longa"])
registrar("m06_ex53_eqm_pre_max_sim", max(res[, "pre"]))
registrar("m06_ex53_eqm_pre_tau_max", res[which.max(res[, "pre"]), "tau"])
print(round(res, 3))

abrir_png("m06_eqm_omissao.png")
tt <- seq(0, 3, by = 0.01)
plot(tt, eqm_S_teo(tt), type = "l", lwd = 2, col = "firebrick", ylim = c(0, max(eqm_S_teo(3), res[, -1])),
     main = "EQM de b1: regressão curta × longa × pré-teste (relativo a Var(b1 longo))",
     xlab = expression(tau == beta[2] / dp(b[2] ~ "longo")), ylab = "EQM relativo")
abline(h = 1, lwd = 2, col = "navy")
points(res[, "tau"], res[, "curta"], pch = 19, col = "firebrick")
points(res[, "tau"], res[, "longa"], pch = 17, col = "navy")
lines(res[, "tau"], res[, "pre"], lwd = 2, lty = 2, col = "darkgreen")
points(res[, "tau"], res[, "pre"], pch = 15, col = "darkgreen")
abline(v = 1, lty = 3)
legend("topleft", bty = "n", lwd = 2, lty = c(1, 1, 2), pch = c(19, 17, 15),
       col = c("firebrick", "navy", "darkgreen"),
       legend = c("curta (omite x2): teoria e simulação", "longa: EQM = variância",
                  "pré-teste (t de x2 a 5%)"))
dev.off()

## ---- I. Output ilustrativo (formato LIMDEP/NLOGIT) + componentes principais (SL06, p. 56-60) ----
# Dados simulados (ilustração didática): beta2 = beta3 = 0,6, corr populacional 0,98, sigma = 1.
# A semente foi escolhida entre as que exibem o quadro típico (F significativo, t's não significativos).
set.seed(20260961)
nI <- 40
zI <- rnorm(nI)
x2I <- 5 + zI
x3I <- 5 + 0.98 * zI + sqrt(1 - 0.98^2) * rnorm(nI)
yI  <- 1 + 0.6 * x2I + 0.6 * x3I + rnorm(nI, 0, 1)
dI  <- data.frame(Y = yI, X2 = x2I, X3 = x3I)
mI  <- lm(Y ~ X2 + X3, data = dI)
sI  <- summary(mI)

saida_nlogit_m06 <- function(mod, dados) {
  s <- summary(mod); cf <- coef(s); Xm <- model.matrix(mod)
  y <- model.response(model.frame(mod)); nn <- length(y); kk <- ncol(Xm)
  fst <- s$fstatistic
  cat("-----------------------------------------------------------------------------\n")
  cat("Ordinary     least squares regression ............\n")
  cat(sprintf("LHS=%-8s Mean                 = %12.5f\n", names(dados)[1], mean(y)))
  cat(sprintf("             Standard deviation   = %12.5f\n", sd(y)))
  cat(sprintf("             Number of observs.   = %12d\n", nn))
  cat(sprintf("Model size   Parameters           = %12d\n", kk))
  cat(sprintf("             Degrees of freedom   = %12d\n", nn - kk))
  cat(sprintf("Residuals    Sum of squares       = %12.5f\n", sum(resid(mod)^2)))
  cat(sprintf("             Standard error of e  = %12.5f\n", s$sigma))
  cat(sprintf("Fit          R-squared            = %12.5f\n", s$r.squared))
  cat(sprintf("             Adjusted R-squared   = %12.5f\n", s$adj.r.squared))
  cat(sprintf("Model test   F[%2d, %3d] (prob)    = %7.3f (%.4f)\n", fst[[2]], fst[[3]], fst[[1]],
              pf(fst[[1]], fst[[2]], fst[[3]], lower.tail = FALSE)))
  cat("--------+--------------------------------------------------------------------\n")
  cat("Variable| Coefficient   Standard Error  b/St.Er.  P[|T|>t]    Mean of X\n")
  cat("--------+--------------------------------------------------------------------\n")
  for (j in seq_len(nrow(cf))) {
    nm <- rownames(cf)[j]; nm <- if (nm == "(Intercept)") "Constant" else nm
    mx <- if (nm == "Constant") "" else sprintf("%12.5f", mean(Xm[, j]))
    cat(sprintf("%-8s|%12.5f     %12.5f   %7.3f    %.4f  %s\n", nm, cf[j, 1], cf[j, 2], cf[j, 3], cf[j, 4], mx))
  }
  cat("--------+--------------------------------------------------------------------\n")
}
cat("\nI. Output ilustrativo (multicolinearidade)\n")
saida_nlogit_m06(mI, dI)
cfI <- coef(sI)
registrar("m06_out_b2", cfI["X2", 1]); registrar("m06_out_se2", cfI["X2", 2])
registrar("m06_out_t2", cfI["X2", 3]); registrar("m06_out_p2", cfI["X2", 4])
registrar("m06_out_b3", cfI["X3", 1]); registrar("m06_out_se3", cfI["X3", 2])
registrar("m06_out_t3", cfI["X3", 3]); registrar("m06_out_p3", cfI["X3", 4])
registrar("m06_out_r2", sI$r.squared)
registrar("m06_out_r2adj", sI$adj.r.squared)
registrar("m06_out_b1", cfI["(Intercept)", 1]); registrar("m06_out_se1", cfI["(Intercept)", 2])
registrar("m06_out_ssr", sum(resid(mI)^2)); registrar("m06_out_se_e", sI$sigma)
registrar("m06_out_f", sI$fstatistic[["value"]])
registrar("m06_out_pf", pf(sI$fstatistic[["value"]], 2, nI - 3, lower.tail = FALSE))
registrar("m06_out_fcrit5", qf(0.95, 2, nI - 3))
registrar("m06_out_tcrit5", qt(0.975, nI - 3))
registrar("m06_out_r23", cor(x2I, x3I))
registrar("m06_out_fiv", car::vif(mI)[["X2"]])
# Covariância entre b2 e b3 (D06.9): Corr(b2, b3 | X) = - r23
Vb <- vcov(mI)
registrar("m06_out_corr_b2b3", Vb["X2", "X3"] / sqrt(Vb["X2", "X2"] * Vb["X3", "X3"]))
# Soma b2 + b3: precisa (a combinação que os dados identificam bem)
se_soma <- sqrt(Vb["X2", "X2"] + Vb["X3", "X3"] + 2 * Vb["X2", "X3"])
registrar("m06_out_soma_b", cfI["X2", 1] + cfI["X3", 1])
registrar("m06_out_se_soma", se_soma)
registrar("m06_out_t_soma", (cfI["X2", 1] + cfI["X3", 1]) / se_soma)
# Regressão curta (omite X3): viesada para beta2 = 0,6, mas precisa
mIc <- lm(Y ~ X2, data = dI)
registrar("m06_out_curta_b2", coef(mIc)[["X2"]])
registrar("m06_out_curta_se2", coef(summary(mIc))["X2", 2])
# Componentes principais das variáveis padronizadas
Zs <- scale(dI[, c("X2", "X3")])
eg <- eigen(cor(dI[, c("X2", "X3")]), symmetric = TRUE)
registrar("m06_out_pc_autoval1", eg$values[1])
registrar("m06_out_pc_autoval2", eg$values[2])
registrar("m06_out_pc_share1", eg$values[1] / sum(eg$values))
pc1 <- drop(Zs %*% eg$vectors[, 1])
mPC <- lm(dI$Y ~ pc1)
registrar("m06_out_pc_t", coef(summary(mPC))["pc1", 3])
registrar("m06_out_pc_r2", summary(mPC)$r.squared)
cat(sprintf("   r23 = %.4f | FIV = %.2f | Corr(b2,b3) = %.4f | b2+b3 = %.4f (EP %.4f) | curta b2 = %.4f\n",
            cor(x2I, x3I), car::vif(mI)[["X2"]], Vb["X2", "X3"] / sqrt(Vb["X2", "X2"] * Vb["X3", "X3"]),
            cfI["X2", 1] + cfI["X3", 1], se_soma, coef(mIc)[["X2"]]))
cat(sprintf("   CP1: autovalores %.4f / %.4f | t(CP1) = %.3f | R2 = %.4f\n",
            eg$values[1], eg$values[2], coef(summary(mPC))["pc1", 3], summary(mPC)$r.squared))

gravar_resultados("m06")
cat("OK m06\n")
