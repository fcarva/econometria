# Módulo 00 — Fundamentos de probabilidade e estatística (id do script: m00)
#
# Confere numericamente os resultados de 00_teoria.md e 00_lista1.md:
#   Ex. 2  E e Var da média amostral (população assimétrica)
#   Ex. 3  consistência da média: P(|Xbar - mu| > eps), cota de Chebyshev e aproximação do TLC
#   Ex. 7  covariância nula sem independência (caso discreto exato e dois casos contínuos)
#   Ex. 9  EQM = Var + viés^2 com s^2 e sigma2_chapeu (Greene, Ex. C.5)
#   D00.3  Var(Ax) = A Sigma A' e a média de variáveis equicorrelacionadas
#   D00.7  decomposição da variância com heterocedasticidade
#   D00.9  valores críticos (z, t, qui-quadrado, F) e t^2 = F
#
# Rodar: powershell -ExecutionPolicy Bypass -File scripts\r.ps1 00_fundamentos\00_fundamentos.R

# --- bootstrap: localizar a raiz do repo e carregar helpers ---
.d <- getwd(); while (!file.exists(file.path(.d, ".repo-root")) && dirname(.d) != .d) .d <- dirname(.d)
source(file.path(.d, "R", "raiz.R"))

suppressPackageStartupMessages(library(MASS))

dir_fig <- caminho_repo("00_fundamentos", "figuras")
dir.create(dir_fig, showWarnings = FALSE, recursive = TRUE)
abrir_png <- function(nome) png(file.path(dir_fig, nome), width = 1600, height = 1000, res = 200)

## ---- Ex. 2: E e Var da média amostral ----
# População Exponencial com média mu = 2 e variância sigma2 = 4. É assimétrica de
# propósito: E(Xbar) = mu e Var(Xbar) = sigma2/n não dependem de normalidade.
set.seed(20260915)
mu     <- 2
sigma2 <- 4
R      <- 20000                      # réplicas de Monte Carlo
ns     <- c(5, 10, 20, 50, 100, 200, 500)
eps    <- 0.5                        # tolerância usada no Ex. 3
registrar("m00_ex2_mu", mu)
registrar("m00_ex2_sigma2", sigma2)
registrar("m00_ex2_R", R)
registrar("m00_ex3_eps", eps)

dens      <- list()
prob_fora <- numeric(length(ns))
for (j in seq_along(ns)) {
  n    <- ns[j]
  xbar <- rowMeans(matrix(rexp(n * R, rate = 1 / mu), nrow = R))
  prob_fora[j] <- mean(abs(xbar - mu) > eps)
  if (n %in% c(5, 20, 100, 500)) {
    registrar(sprintf("m00_ex2_media_n%d", n), mean(xbar))
    registrar(sprintf("m00_ex2_var_n%d", n), var(xbar))
    registrar(sprintf("m00_ex2_varteo_n%d", n), sigma2 / n)
    dens[[as.character(n)]] <- density(xbar)
  }
}

## ---- Ex. 3: consistência da média amostral (Chebyshev x TLC) ----
cheb <- sigma2 / (ns * eps^2)                              # cota de Chebyshev
tlc  <- 2 * (1 - pnorm(eps * sqrt(ns) / sqrt(sigma2)))    # aproximação normal
for (n in c(20, 100, 500)) {
  j <- which(ns == n)
  registrar(sprintf("m00_ex3_prob_n%d", n), prob_fora[j])
  registrar(sprintf("m00_ex3_cheb_n%d", n), cheb[j])
  registrar(sprintf("m00_ex3_tlc_n%d", n), tlc[j])
}

abrir_png("m00_media_amostral.png")
op <- par(mfrow = c(1, 2), mar = c(4.2, 4.2, 3, 1))
cores <- c("5" = "grey60", "20" = "steelblue", "100" = "darkorange", "500" = "firebrick")
plot(NA, xlim = c(0, 5), ylim = c(0, max(dens[["500"]]$y) * 1.05),
     xlab = expression(bar(X)), ylab = "Densidade",
     main = "Distribuição amostral da média\n(população Exponencial, média 2)")
for (k in names(dens)) lines(dens[[k]], col = cores[k], lwd = 2)
abline(v = mu, lty = 2)
legend("topright", legend = paste("n =", names(dens)), col = cores, lwd = 2, bty = "n")
plot(ns, prob_fora, log = "x", type = "b", pch = 19, ylim = c(0, 1),
     xlab = "n (escala log)", ylab = expression(P(abs(bar(X) - mu) > 0.5)),
     main = "Consistência: probabilidade de errar\npor mais de 0,5")
ng <- exp(seq(log(5), log(500), length.out = 200))
lines(ng, pmin(1, sigma2 / (ng * eps^2)), col = "firebrick", lwd = 2, lty = 2)
lines(ng, 2 * (1 - pnorm(eps * sqrt(ng) / sqrt(sigma2))), col = "steelblue", lwd = 2)
legend("topright", legend = c("Monte Carlo", "Cota de Chebyshev", "Aproximação do TLC"),
       col = c("black", "firebrick", "steelblue"), lty = c(1, 2, 1), pch = c(19, NA, NA),
       lwd = 2, bty = "n", cex = 0.85)
par(op); dev.off()

## ---- Ex. 7: covariância nula não implica independência ----
# (a) Caso discreto exato: X uniforme em {-1, 0, 1} e Y = X^2.
px <- rep(1 / 3, 3); xv <- c(-1, 0, 1); yv <- xv^2
EX  <- sum(px * xv); EY <- sum(px * yv); EXY <- sum(px * xv * yv)
registrar("m00_ex7_disc_EX", EX)
registrar("m00_ex7_disc_EY", EY)
registrar("m00_ex7_disc_EXY", EXY)
registrar("m00_ex7_disc_cov", EXY - EX * EY)
registrar("m00_ex7_disc_pconj", px[xv == 0])                         # P(X=0, Y=0) = P(X=0)
registrar("m00_ex7_disc_pprod", px[xv == 0] * sum(px[yv == 0]))      # P(X=0) P(Y=0)

# (b) Contínuo: X ~ N(0,1) e Y = X^2 (dependência perfeita, correlação zero).
set.seed(7)
n7 <- 100000
x  <- rnorm(n7)
y  <- x^2
registrar("m00_ex7_n", n7)
registrar("m00_ex7_cov_xy", cov(x, y))
registrar("m00_ex7_cor_xy", cor(x, y))
registrar("m00_ex7_cor_x2y", cor(x^2, y))
registrar("m00_ex7_b_proj", unname(coef(lm(y ~ x))[2]))              # inclinação da projeção linear
registrar("m00_ex7_EY_meio", mean(y[abs(x) < 0.5]))                  # E[Y | |X| < 0,5]
registrar("m00_ex7_EY_cauda", mean(y[abs(x) > 1.5]))                 # E[Y | |X| > 1,5]

# (c) Marginais normais mas conjunta não normal: Y2 = S X, com S = +-1 independente de X.
s  <- sample(c(-1, 1), n7, replace = TRUE)
y2 <- s * x
registrar("m00_ex7_cor_sx", cor(x, y2))
registrar("m00_ex7_cor_abs", cor(abs(x), abs(y2)))
registrar("m00_ex7_p_cond", mean(abs(y2[abs(x) > 1.5]) > 1.5))       # P(|Y2|>1,5 | |X|>1,5)
registrar("m00_ex7_p_marg", mean(abs(y2) > 1.5))                     # P(|Y2|>1,5)

abrir_png("m00_cov_nula_dependencia.png")
op <- par(mfrow = c(1, 2), mar = c(4.2, 4.2, 3, 1))
id <- 1:3000
plot(x[id], y[id], pch = 16, cex = 0.4, col = adjustcolor("grey30", 0.4),
     xlab = "X", ylab = expression(Y == X^2),
     main = "Cov(X, Y) = 0, mas Y é função de X")
curve(x^2, add = TRUE, col = "firebrick", lwd = 2)
abline(lm(y ~ x), col = "steelblue", lwd = 2, lty = 2)
legend("top", legend = c("E[Y | X] = X²", "Projeção linear (reta MQO)"),
       col = c("firebrick", "steelblue"), lwd = 2, lty = c(1, 2), bty = "n", cex = 0.85)
plot(x[id], y2[id], pch = 16, cex = 0.4, col = adjustcolor("grey30", 0.4),
     xlab = "X", ylab = "Y = S X",
     main = "Marginais normais, Cov = 0,\nmas |Y| = |X|")
abline(h = 0, v = 0, lty = 3)
par(op); dev.off()

## ---- Ex. 9: EQM = Var + viés^2 (s^2 contra sigma2_chapeu) ----
# Amostras normais de tamanho n9 = 10 com sigma^2 = 4 (Greene, Ex. C.5).
set.seed(9)
n9 <- 10; s2pop <- 4; R9 <- 200000
m    <- matrix(rnorm(n9 * R9, mean = 0, sd = sqrt(s2pop)), nrow = R9)
sqd  <- rowSums((m - rowMeans(m))^2)       # soma dos quadrados dos desvios em cada réplica
s2   <- sqd / (n9 - 1)                     # não viesado
sh   <- sqd / n9                           # viesado (divide por n)
decomp <- function(est) {
  media <- mean(est); vies <- media - s2pop
  v     <- mean((est - media)^2)            # variância com divisor R9 -> identidade exata
  eqm   <- mean((est - s2pop)^2)
  c(media = media, vies = vies, var = v, vies2 = vies^2, eqm = eqm, dif = eqm - (v + vies^2))
}
d_s2 <- decomp(s2); d_sh <- decomp(sh)
registrar("m00_ex9_n", n9); registrar("m00_ex9_sigma2", s2pop); registrar("m00_ex9_R", R9)
for (k in c("media", "vies", "var", "vies2", "eqm")) {
  registrar(paste0("m00_ex9_s2_", k), d_s2[[k]])
  registrar(paste0("m00_ex9_sh_", k), d_sh[[k]])
}
registrar("m00_ex9_dif_max", max(abs(c(d_s2[["dif"]], d_sh[["dif"]]))))
# Valores teóricos (derivados em D00.8 com (n-1)s^2/sigma^2 ~ qui2(n-1))
registrar("m00_ex9_s2_var_teo", 2 * s2pop^2 / (n9 - 1))
registrar("m00_ex9_sh_media_teo", (n9 - 1) / n9 * s2pop)
registrar("m00_ex9_sh_vies_teo", -s2pop / n9)
registrar("m00_ex9_sh_vies2_teo", (s2pop / n9)^2)
registrar("m00_ex9_sh_var_teo", 2 * (n9 - 1) * s2pop^2 / n9^2)
registrar("m00_ex9_sh_eqm_teo", (2 * n9 - 1) * s2pop^2 / n9^2)
# Conferência de (n-1)s^2/sigma^2 ~ qui2(n-1): média n-1 e variância 2(n-1)
q <- sqd / s2pop
registrar("m00_d9_qui2_media", mean(q))
registrar("m00_d9_qui2_var", var(q))

abrir_png("m00_eqm_vies_variancia.png")
op <- par(mfrow = c(1, 2), mar = c(4.2, 4.2, 3, 1))
ds2 <- density(s2); dsh <- density(sh)
plot(ds2, col = "steelblue", lwd = 2, xlim = c(0, 12), ylim = c(0, max(dsh$y) * 1.05),
     main = "Distribuições amostrais (n = 10, σ² = 4)", xlab = "Estimativa de σ²", ylab = "Densidade")
lines(dsh, col = "firebrick", lwd = 2)
abline(v = s2pop, lty = 2)
abline(v = c(mean(s2), mean(sh)), col = c("steelblue", "firebrick"), lty = 3, lwd = 2)
legend("topright", legend = c("s² (divide por n-1)", "σ̂² (divide por n)", "σ² verdadeiro"),
       col = c("steelblue", "firebrick", "black"), lwd = 2, lty = c(1, 1, 2), bty = "n", cex = 0.85)
comp <- rbind(Variancia = c(d_s2[["var"]], d_sh[["var"]]), Vies2 = c(d_s2[["vies2"]], d_sh[["vies2"]]))
colnames(comp) <- c("s²", "σ̂²")
bp <- barplot(comp, col = c("grey70", "firebrick"), ylim = c(0, 4.2), ylab = "EQM",
              main = "EQM = variância + viés²", legend.text = c("Variância", "Viés²"),
              args.legend = list(x = "topright", bty = "n", cex = 0.85))
text(bp, colSums(comp) + 0.2, formatC(colSums(comp), format = "f", digits = 3, decimal.mark = ","))
par(op); dev.off()

## ---- D00.3: variância de combinações lineares, Var(Ax) = A Sigma A' ----
set.seed(3)
Sigma <- matrix(c(4.0,  1.2,  0.0,
                  1.2,  1.0, -0.5,
                  0.0, -0.5,  2.0), 3, byrow = TRUE)
A <- rbind(c(1, 1, 1) / 3,      # média simples dos três componentes
           c(1, -1, 0))         # diferença x1 - x2
V_teo <- A %*% Sigma %*% t(A)   # (2x3)(3x3)(3x2) = 2x2
Xs    <- mvrnorm(200000, mu = c(1, 2, 3), Sigma = Sigma)
V_sim <- cov(Xs %*% t(A))
registrar("m00_d3_v11_teo", V_teo[1, 1]); registrar("m00_d3_v11_sim", V_sim[1, 1])
registrar("m00_d3_v22_teo", V_teo[2, 2]); registrar("m00_d3_v22_sim", V_sim[2, 2])
registrar("m00_d3_v12_teo", V_teo[1, 2]); registrar("m00_d3_v12_sim", V_sim[1, 2])

# Média de n variáveis equicorrelacionadas (variância 1, correlação rho):
# Var(Xbar) = [1 + (n-1) rho] / n -> rho quando n -> infinito (não há consistência).
set.seed(33)
rho <- 0.3; n_eq <- 100; R_eq <- 20000
Z0  <- rnorm(R_eq)
Zi  <- matrix(rnorm(n_eq * R_eq), nrow = R_eq)
Xeq <- sqrt(rho) * Z0 + sqrt(1 - rho) * Zi       # cada linha: uma amostra de n_eq variáveis
registrar("m00_d3_rho", rho); registrar("m00_d3_neq", n_eq)
registrar("m00_d3_eq_var_teo", (1 + (n_eq - 1) * rho) / n_eq)
registrar("m00_d3_eq_var_sim", var(rowMeans(Xeq)))

## ---- D00.7: decomposição da variância (com heterocedasticidade) ----
# X ~ N(0,1); Y | X ~ N(1 + 2X, 1 + X^2). Var(E[Y|X]) = 4, E[Var(Y|X)] = 2, Var(Y) = 6.
set.seed(77)
n77 <- 400000
x7  <- rnorm(n77)
y7  <- 1 + 2 * x7 + rnorm(n77) * sqrt(1 + x7^2)
registrar("m00_d7_var_cef_teo", 4); registrar("m00_d7_evar_teo", 2); registrar("m00_d7_vary_teo", 6)
registrar("m00_d7_var_cef_sim", var(1 + 2 * x7))
registrar("m00_d7_evar_sim", mean(1 + x7^2))
registrar("m00_d7_vary_sim", var(y7))

## ---- D00.9: valores críticos usados no curso ----
registrar("m00_crit_z975", qnorm(0.975))
registrar("m00_crit_z95", qnorm(0.95))
registrar("m00_crit_t975_df4155", qt(0.975, 4155))   # P1 2025/2, Q1: n - K = 4165 - 10
registrar("m00_crit_t975_df25", qt(0.975, 25))       # regressão simples com n = 27
registrar("m00_crit_t975_df10", qt(0.975, 10))
registrar("m00_crit_chi2_95_df1", qchisq(0.95, 1))
registrar("m00_crit_chi2_95_df2", qchisq(0.95, 2))
registrar("m00_crit_chi2_95_df5", qchisq(0.95, 5))
registrar("m00_crit_f95_1_30", qf(0.95, 1, 30))
registrar("m00_crit_t975_df30_quad", qt(0.975, 30)^2) # t^2(30) = F(1, 30)
registrar("m00_crit_f95_9_4155", qf(0.95, 9, 4155))
registrar("m00_crit_f95_9_4155_x9", 9 * qf(0.95, 9, 4155))   # J F -> qui2(J)
registrar("m00_crit_chi2_95_df9", qchisq(0.95, 9))

gravar_resultados("m00")
