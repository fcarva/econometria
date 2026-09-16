# =====================================================================
# Módulo 10 — Endogeneidade e variáveis instrumentais (script m10)
#
# O que este script faz:
#   1. Reproduz exatamente o output do ex. 67 da Lista 1 (CigarettesSW, 1995)
#      com e sem a matriz sandwich, e registra os dois conjuntos de diagnósticos.
#   2. Refaz o MQ2E "à mão" (D10.7, D10.8): três fórmulas, mesmo b; erros-padrão
#      corretos x ingênuos do 2º estágio.
#   3. Refaz os três diagnósticos do ivreg à mão: F do 1º estágio, Wu-Hausman
#      por função de controle (D10.11) e Sargan nR² (D10.12); Hausman clássico.
#   4. Identidades: VI = MQO quando Z = X; VI bivariado = Cov(z,y)/Cov(z,x);
#      eficiência do MQ2E (D10.9); Z'e = 0 no caso exatamente identificado.
#   5. Monte Carlo: viés de atenuação (D10.2, ex. 68), simultaneidade keynesiana
#      (D10.4, ex. 69) e instrumentos fracos (D10.10).
#   6. Retornos da escolaridade: a aplicação do SL10 (Cornwell-Rupert, PSID7682,
#      MS e FEM como instrumentos) e um caso sobreidentificado (wooldridge::mroz).
#
# Rodar: powershell -ExecutionPolicy Bypass -File scripts\r.ps1 10_endogeneidade_iv\10_endogeneidade_iv.R
# =====================================================================

# --- bootstrap: localizar a raiz do repo e carregar helpers ---
.d <- getwd(); while (!file.exists(file.path(.d, ".repo-root")) && dirname(.d) != .d) .d <- dirname(.d)
source(file.path(.d, "R", "raiz.R"))

suppressPackageStartupMessages({
  library(AER)        # ivreg, CigarettesSW, PSID7682
  library(sandwich)   # matriz robusta (HC0), como no output do ex. 67
  library(lmtest)     # waldtest
  library(wooldridge) # mroz
})

dir_fig <- caminho_repo("10_endogeneidade_iv", "figuras")
dir.create(dir_fig, showWarnings = FALSE, recursive = TRUE)
abre_png <- function(nome) png(file.path(dir_fig, nome), width = 1600, height = 1000, res = 200)
secao <- function(txt) cat("\n", strrep("=", 72), "\n", txt, "\n", strrep("=", 72), "\n", sep = "")
reg <- function(chave, valor) registrar(chave, as.numeric(unname(valor))[1])

## ---- Ex. 67: reprodução do output do ivreg ----
# Dados: AER::CigarettesSW, 48 estados dos EUA, ano de 1995 (Stock e Watson).
# A lista disfarça os nomes: log(preço) = log(rprice); log(renda) = log(rincome);
# os dois instrumentos externos são tdiff (imposto sobre vendas) e tax/cpi.
secao("Ex. 67 — demanda por cigarros, MQ2E via ivreg (CigarettesSW, 1995)")
data("CigarettesSW", package = "AER")
c95 <- subset(CigarettesSW, year == "1995")
c95$rprice  <- c95$price / c95$cpi
c95$rincome <- c95$income / c95$population / c95$cpi
c95$tdiff   <- (c95$taxs - c95$tax) / c95$cpi
n67 <- nrow(c95)
reg("m10_ex67_n", n67)

iv67  <- ivreg(log(packs) ~ log(rprice) + log(rincome) | log(rincome) + tdiff + I(tax/cpi), data = c95)
s_rob <- summary(iv67, vcov = sandwich, df = Inf, diagnostics = TRUE)  # = output impresso na lista
s_hom <- summary(iv67, diagnostics = TRUE)                             # sem sandwich (homocedástico)
print(s_rob)
print(s_hom)

cf_rob <- coef(s_rob); cf_hom <- coef(s_hom)
reg("m10_ex67_b_const", cf_rob[1, 1])
reg("m10_ex67_b_preco", cf_rob[2, 1])
reg("m10_ex67_b_renda", cf_rob[3, 1])
reg("m10_ex67_ep_const_rob", cf_rob[1, 2])
reg("m10_ex67_ep_preco_rob", cf_rob[2, 2])
reg("m10_ex67_ep_renda_rob", cf_rob[3, 2])
reg("m10_ex67_z_preco_rob", cf_rob[2, 3])
reg("m10_ex67_z_renda_rob", cf_rob[3, 3])
reg("m10_ex67_p_renda_rob", cf_rob[3, 4])
reg("m10_ex67_ep_const_hom", cf_hom[1, 2])
reg("m10_ex67_ep_preco_hom", cf_hom[2, 2])
reg("m10_ex67_ep_renda_hom", cf_hom[3, 2])
reg("m10_ex67_t_preco_hom", cf_hom[2, 3])

dg_rob <- s_rob$diagnostics; dg_hom <- s_hom$diagnostics
reg("m10_ex67_fraco_F_rob", dg_rob["Weak instruments", "statistic"])
reg("m10_ex67_wu_F_rob",    dg_rob["Wu-Hausman", "statistic"])
reg("m10_ex67_wu_p_rob",    dg_rob["Wu-Hausman", "p-value"])
reg("m10_ex67_sargan",      dg_rob["Sargan", "statistic"])
reg("m10_ex67_sargan_p",    dg_rob["Sargan", "p-value"])
reg("m10_ex67_fraco_F_hom", dg_hom["Weak instruments", "statistic"])
reg("m10_ex67_wu_F_hom",    dg_hom["Wu-Hausman", "statistic"])
reg("m10_ex67_wu_p_hom",    dg_hom["Wu-Hausman", "p-value"])
reg("m10_ex67_sargan_hom",  dg_hom["Sargan", "statistic"])
reg("m10_ex67_r2",   s_rob$r.squared)
reg("m10_ex67_r2aj", s_rob$adj.r.squared)
reg("m10_ex67_sigma", s_rob$sigma)
cat("Estrutura de $waldtest (robusto):\n"); print(s_rob$waldtest)
reg("m10_ex67_wald_rob",   s_rob$waldtest[1])
reg("m10_ex67_wald_p_rob", s_rob$waldtest[2])
reg("m10_ex67_wald_F_hom", s_hom$waldtest[1])

# Valores críticos para decidir sem p-valor
reg("m10_crit_F_1_44_10", qf(0.90, 1, 44))
reg("m10_crit_F_1_44_05", qf(0.95, 1, 44))
reg("m10_crit_chi2_1_10", qchisq(0.90, 1))
reg("m10_crit_chi2_1_05", qchisq(0.95, 1))
reg("m10_crit_chi2_2_05", qchisq(0.95, 2))
reg("m10_crit_chi2_5_05", qchisq(0.95, 5))

# Versões recicladas: qual p-valor é coerente com a estatística impressa?
reg("m10_recicl_p_wu_3823", pf(3.823, 1, 44, lower.tail = FALSE))        # 0,0569: o verdadeiro
reg("m10_recicl_F_para_p0369", qf(1 - 0.0369, 1, 44))                    # F que daria p = 0,0369
reg("m10_recicl_F_para_p0469", qf(1 - 0.0469, 1, 44))                    # F que daria p = 0,0469
reg("m10_recicl_p_sargan_0333", pchisq(0.333, 1, lower.tail = FALSE))    # 0,5641: o verdadeiro
reg("m10_recicl_chi2_para_p08468", qchisq(1 - 0.8468, 1))               # estatística que daria 0,8468

# MQO para comparação (preço tratado como exógeno)
ols67 <- lm(log(packs) ~ log(rprice) + log(rincome), data = c95)
reg("m10_ex67_ols_b_preco", coef(ols67)[2])
reg("m10_ex67_ols_ep_preco", coef(summary(ols67))[2, 2])
reg("m10_ex67_ols_b_renda", coef(ols67)[3])

## ---- MQ2E à mão (D10.7 e D10.8) ----
secao("MQ2E à mão: três fórmulas e o erro-padrão ingênuo do 2º estágio")
y <- log(c95$packs)
X <- cbind(const = 1, lpreco = log(c95$rprice), lrenda = log(c95$rincome))
Z <- cbind(const = 1, lrenda = log(c95$rincome), tdiff = c95$tdiff, rtax = c95$tax / c95$cpi)
n <- nrow(X); K <- ncol(X); L <- ncol(Z)
reg("m10_ex67_K", K); reg("m10_ex67_L", L)

PZ   <- Z %*% solve(crossprod(Z), t(Z))                          # n x n, simétrica e idempotente
Xhat <- PZ %*% X                                                  # n x K
b_form  <- solve(t(X) %*% PZ %*% X, t(X) %*% PZ %*% y)            # [X'P_Z X]^{-1} X'P_Z y
b_xhat  <- solve(crossprod(Xhat), crossprod(Xhat, y))             # (X^'X^)^{-1} X^'y
b_vinst <- solve(crossprod(Xhat, X), crossprod(Xhat, y))          # VI com instrumento X^
reg("m10_2sls_dif_formula", max(abs(b_form  - coef(iv67))))
reg("m10_2sls_dif_xhat",    max(abs(b_xhat  - coef(iv67))))
reg("m10_2sls_dif_vinst",   max(abs(b_vinst - coef(iv67))))
reg("m10_2sls_dif_exog",    max(abs(Xhat[, c("const", "lrenda")] - X[, c("const", "lrenda")])))
reg("m10_2sls_idempot",     max(abs(PZ %*% PZ - PZ)))

# 2º estágio "ingênuo": MQO de y em X^ (mesmo b, erro-padrão errado)
st2    <- lm(y ~ Xhat[, "lpreco"] + X[, "lrenda"])
ep_ing <- coef(summary(st2))[, 2]
e_ok   <- drop(y - X %*% b_form)       # resíduo correto: usa X
e_ing  <- drop(y - Xhat %*% b_form)    # resíduo ingênuo: usa X^
s_ok   <- sqrt(sum(e_ok^2)  / (n - K))
s_ing  <- sqrt(sum(e_ing^2) / (n - K))
ep_ok  <- sqrt(diag(s_ok^2 * solve(crossprod(Xhat))))
reg("m10_2sls_dif_coef_st2", max(abs(coef(st2) - coef(iv67))))
reg("m10_2sls_s_ok",  s_ok)
reg("m10_2sls_s_ing", s_ing)
reg("m10_2sls_ep_preco_ok",  ep_ok[2])
reg("m10_2sls_ep_preco_ing", ep_ing[2])
reg("m10_2sls_ep_renda_ok",  ep_ok[3])
reg("m10_2sls_ep_renda_ing", ep_ing[3])
reg("m10_2sls_dif_ep_ivreg", max(abs(ep_ok - cf_hom[, 2])))
reg("m10_2sls_razao_s", s_ing / s_ok)                          # = razão ep_ing/ep_ok, igual para todo coef.
reg("m10_2sls_razao_ep_dif", diff(range(ep_ing / ep_ok)))       # ~0: a razão não depende do coeficiente
# identidade do passo 2 de D10.8: e_ing = e_ok + M_Z X b
reg("m10_2sls_dif_ident_resid", max(abs(e_ing - (e_ok + drop((diag(n) - PZ) %*% X %*% b_form)))))

## ---- Diagnósticos à mão (D10.10–D10.12) ----
secao("Diagnósticos à mão: 1º estágio, Wu-Hausman, Sargan, Hausman")
# Instrumentos fracos: F dos instrumentos excluídos no 1º estágio
fs_u <- lm(log(rprice) ~ log(rincome) + tdiff + I(tax/cpi), data = c95)
fs_r <- lm(log(rprice) ~ log(rincome), data = c95)
F_fs_hom <- anova(fs_r, fs_u)$F[2]
F_fs_rob <- waldtest(fs_u, fs_r, vcov = sandwich, test = "F")$F[2]
reg("m10_fs_F_hom", F_fs_hom)
reg("m10_fs_F_rob", F_fs_rob)
reg("m10_fs_r2", summary(fs_u)$r.squared)
print(coef(summary(fs_u)))

# Wu-Hausman: função de controle (resíduo do 1º estágio na equação estrutural)
c95$vhat <- resid(fs_u)
aug <- lm(log(packs) ~ log(rprice) + log(rincome) + vhat, data = c95)
t_v <- coef(summary(aug))["vhat", "t value"]
WH_rob <- waldtest(aug, . ~ . - vhat, vcov = sandwich, test = "F")$F[2]
reg("m10_cf_rho",  coef(aug)["vhat"])
reg("m10_cf_t",    t_v)
reg("m10_cf_t2",   t_v^2)
reg("m10_cf_F_rob", WH_rob)
reg("m10_cf_dif_coef_2sls", max(abs(coef(aug)[1:3] - coef(iv67))))
reg("m10_cf_ep_preco_ing", coef(summary(aug))[2, 2])

# Sargan: nR² da regressão dos resíduos do MQ2E em todos os instrumentos
u_iv  <- resid(iv67)
aux_s <- lm(u_iv ~ log(rincome) + tdiff + I(tax/cpi), data = c95)
sargan_m <- n * summary(aux_s)$r.squared
reg("m10_sargan_manual",   sargan_m)
reg("m10_sargan_manual_p", pchisq(sargan_m, df = L - K, lower.tail = FALSE))
reg("m10_sargan_gl", L - K)
reg("m10_sargan_media_resid", abs(mean(u_iv)))

# Caso exatamente identificado (só tdiff): Z1'e = 0 por construção => Sargan impossível
Z1    <- Z[, c("const", "lrenda", "tdiff")]
b_iv1 <- solve(crossprod(Z1, X), crossprod(Z1, y))                # (Z'X)^{-1} Z'y
e_iv1 <- drop(y - X %*% b_iv1)
reg("m10_exato_Zte", max(abs(crossprod(Z1, e_iv1))))

# Hausman clássico (versão de Durbin, sigma² comum do MQO): só o coeficiente do preço
d_preco <- coef(iv67)[2] - coef(ols67)[2]
s2_ols  <- summary(ols67)$sigma^2
Vd      <- s2_ols * (solve(crossprod(Xhat)) - solve(crossprod(X)))
H_durb  <- d_preco^2 / Vd[2, 2]
reg("m10_haus_d", d_preco)
reg("m10_haus_H", H_durb)
reg("m10_haus_p", pchisq(H_durb, 1, lower.tail = FALSE))

## ---- Ex. 67c: VI "usual" (um instrumento) x MQ2E (dois) — D10.9 ----
secao("Ex. 67c — VI exatamente identificado com cada instrumento x MQ2E")
iv_td <- ivreg(log(packs) ~ log(rprice) + log(rincome) | log(rincome) + tdiff, data = c95)
iv_tx <- ivreg(log(packs) ~ log(rprice) + log(rincome) | log(rincome) + I(tax/cpi), data = c95)
reg("m10_ex67c_b_tdiff",  coef(iv_td)[2])
reg("m10_ex67c_ep_tdiff", sqrt(vcov(iv_td)[2, 2]))
reg("m10_ex67c_b_tax",    coef(iv_tx)[2])
reg("m10_ex67c_ep_tax",   sqrt(vcov(iv_tx)[2, 2]))
reg("m10_ex67c_ep_2sls",  sqrt(vcov(iv67)[2, 2]))
reg("m10_ex67c_dif_formula", max(abs(b_iv1 - coef(iv_td))))
# Eficiência (sigma² comum): X'P_Z X - X'P_{Z1} X e X'X - X'P_Z X são psd
PZ1 <- Z1 %*% solve(crossprod(Z1), t(Z1))
reg("m10_efic_autovalor_min",     min(eigen(t(X) %*% (PZ - PZ1) %*% X, symmetric = TRUE)$values))
reg("m10_efic_ols_autovalor_min", min(eigen(t(X) %*% (diag(n) - PZ) %*% X, symmetric = TRUE)$values))

# VI bivariado: Cov(z,y)/Cov(z,x) com z = tdiff (sem renda)
b_biv  <- cov(c95$tdiff, y) / cov(c95$tdiff, log(c95$rprice))
iv_biv <- ivreg(log(packs) ~ log(rprice) | tdiff, data = c95)
reg("m10_biv_b",   b_biv)
reg("m10_biv_dif", abs(b_biv - coef(iv_biv)[2]))

# VI com Z = X é o MQO
iv_zx <- ivreg(log(packs) ~ log(rprice) + log(rincome) | log(rprice) + log(rincome), data = c95)
reg("m10_zx_dif", max(abs(coef(iv_zx) - coef(ols67))))

## ---- Ex. 68: Monte Carlo do viés de atenuação (D10.2) ----
secao("Ex. 68 — erro de medição em X: plim b = beta * lambda")
set.seed(10068)
alfa <- 2; beta <- 1; mu_xs <- 5; s2xs <- 1; s2w <- 0.5; s2mu <- 1
lambda <- s2xs / (s2xs + s2w)
ns <- c(50, 500, 5000); R <- 2000
sim_at <- sapply(ns, function(nn) {
  replicate(R, {
    xs <- rnorm(nn, mu_xs, sqrt(s2xs)); w <- rnorm(nn, 0, sqrt(s2w)); mu <- rnorm(nn, 0, sqrt(s2mu))
    yy <- alfa + beta * xs + mu; xx <- xs + w
    b <- cov(xx, yy) / var(xx)
    c(b = b, a = mean(yy) - b * mean(xx))
  })
}, simplify = "array")                      # 2 x R x length(ns)
b_at <- sim_at["b", , ]; a_at <- sim_at["a", , ]
reg("m10_ex68_lambda", lambda)
reg("m10_ex68_plim_b", beta * lambda)
reg("m10_ex68_plim_a", alfa + beta * (1 - lambda) * mu_xs)
for (j in seq_along(ns)) {
  reg(paste0("m10_ex68_media_b_n", ns[j]), mean(b_at[, j]))
  reg(paste0("m10_ex68_dp_b_n",    ns[j]), sd(b_at[, j]))
}
reg("m10_ex68_media_a_n5000", mean(a_at[, 3]))
# Cov(z, X) = -beta sigma²_w numa amostra grande
nn <- 200000
xs <- rnorm(nn, mu_xs, sqrt(s2xs)); w <- rnorm(nn, 0, sqrt(s2w)); mu <- rnorm(nn, 0, sqrt(s2mu))
reg("m10_ex68_cov_zx", cov(mu - beta * w, xs + w))
reg("m10_ex68_cov_zx_teo", -beta * s2w)

abre_png("10_atenuacao_densidades.png")
cores <- c("#1b9e77", "#d95f02", "#7570b3")
dens <- lapply(seq_along(ns), function(j) density(b_at[, j]))
plot(NA, xlim = c(0.2, 1.2), ylim = c(0, max(sapply(dens, function(d) max(d$y)))),
     xlab = "estimativa de MQO da inclinação", ylab = "densidade",
     main = "Erro de medição no regressor: o MQO converge para o valor atenuado")
for (j in seq_along(ns)) lines(dens[[j]], col = cores[j], lwd = 2)
abline(v = beta, lty = 2, lwd = 1.5)
abline(v = beta * lambda, lty = 3, lwd = 2, col = "firebrick")
legend("topleft", bty = "n", cex = 0.85,
       legend = c(paste0("n = ", ns), "valor verdadeiro (1)", "plim = 1 x 2/3"),
       col = c(cores, "black", "firebrick"), lty = c(1, 1, 1, 2, 3), lwd = 2)
dev.off()

# Curva de confiabilidade: média de b x lambda
set.seed(10168)
lams <- seq(0.1, 1, by = 0.1)
media_lam <- sapply(lams, function(lm_) {
  s2w_ <- s2xs * (1 / lm_ - 1)
  mean(replicate(500, {
    xs <- rnorm(1000, mu_xs, sqrt(s2xs)); xx <- xs + rnorm(1000, 0, sqrt(s2w_))
    yy <- alfa + beta * xs + rnorm(1000)
    cov(xx, yy) / var(xx)
  }))
})
reg("m10_ex68_media_b_lam05", media_lam[5])
abre_png("10_atenuacao_confiabilidade.png")
plot(lams, media_lam, pch = 19, col = "#1b9e77", xlim = c(0, 1), ylim = c(0, 1.05),
     xlab = "razão de confiabilidade  var(X*) / [var(X*) + var(w)]",
     ylab = "média das estimativas de MQO",
     main = "Viés de atenuação: plim b = beta x confiabilidade (beta = 1)")
abline(0, beta, lty = 2, col = "firebrick", lwd = 2)
abline(h = beta, lty = 3)
legend("topleft", bty = "n", legend = c("Monte Carlo (n = 1000, 500 réplicas)", "fórmula do plim"),
       pch = c(19, NA), lty = c(NA, 2), col = c("#1b9e77", "firebrick"), lwd = 2)
dev.off()

## ---- Ex. 69: Monte Carlo da simultaneidade keynesiana (D10.4) ----
secao("Ex. 69 — modelo keynesiano: MQO inconsistente, VI com I consistente")
set.seed(10069)
b0 <- 20; b1 <- 0.8; s2u <- 4; s2I <- 4; mu_I <- 50
plim_k <- b1 + (1 - b1) * s2u / (s2I + s2u)
reg("m10_ex69_plim_ols", plim_k)
reg("m10_ex69_inconsist", plim_k - b1)
sim_k <- sapply(ns, function(nn) {
  replicate(R, {
    I <- rnorm(nn, mu_I, sqrt(s2I)); u <- rnorm(nn, 0, sqrt(s2u))
    Y <- (b0 + I + u) / (1 - b1)          # forma reduzida
    C <- b0 + b1 * Y + u                   # equação estrutural
    c(ols = cov(Y, C) / var(Y), vi = cov(I, C) / cov(I, Y))
  })
}, simplify = "array")
for (j in seq_along(ns)) {
  reg(paste0("m10_ex69_media_ols_n", ns[j]), mean(sim_k["ols", , j]))
  reg(paste0("m10_ex69_mediana_vi_n", ns[j]), median(sim_k["vi", , j]))
}
# Momentos populacionais da forma reduzida
reg("m10_ex69_cov_Yu", s2u / (1 - b1))
reg("m10_ex69_var_Y", (s2I + s2u) / (1 - b1)^2)

abre_png("10_keynes_mqo_vs_vi.png")
d_ols <- density(sim_k["ols", , 2]); d_vi <- density(sim_k["vi", , 2])
plot(NA, xlim = c(0.6, 1.0), ylim = c(0, max(d_ols$y, d_vi$y)),
     xlab = "estimativa da propensão marginal a consumir", ylab = "densidade",
     main = "Simultaneidade keynesiana (n = 500): MQO x VI com o investimento")
lines(d_ols, col = "#d95f02", lwd = 2); lines(d_vi, col = "#1b9e77", lwd = 2)
abline(v = b1, lty = 2, lwd = 1.5); abline(v = plim_k, lty = 3, lwd = 2, col = "#d95f02")
legend("topleft", bty = "n", cex = 0.85,
       legend = c("MQO", "VI (instrumento: I)", "valor verdadeiro 0,8", "plim do MQO 0,9"),
       col = c("#d95f02", "#1b9e77", "black", "#d95f02"), lty = c(1, 1, 2, 3), lwd = 2)
dev.off()

## ---- Instrumentos fracos: Monte Carlo (D10.10) ----
secao("Instrumentos fracos: o viés do MQ2E vai para o do MQO quando F cai")
set.seed(10010)
n_f <- 200; R_f <- 2000; beta_f <- 1; rho <- 0.8; Lz <- 3
pis <- c(0, 0.03, 0.06, 0.09, 0.13, 0.2, 0.3)
res_f <- t(sapply(pis, function(p) {
  out <- replicate(R_f, {
    Zm  <- matrix(rnorm(n_f * Lz), n_f, Lz)
    v   <- rnorm(n_f); eps <- rho * v + sqrt(1 - rho^2) * rnorm(n_f)
    x   <- drop(Zm %*% rep(p, Lz)) + v
    yy  <- beta_f * x + eps
    xh  <- drop(Zm %*% solve(crossprod(Zm), crossprod(Zm, x)))
    c(ols = sum(x * yy) / sum(x^2), tsls = sum(xh * yy) / sum(xh * x),
      F = (sum(xh^2) / Lz) / (sum((x - xh)^2) / (n_f - Lz)))
  })
  c(pi = p, vies_ols = mean(out["ols", ]) - beta_f, vies_2sls = mean(out["tsls", ]) - beta_f,
    F_medio = mean(out["F", ]))
}))
res_f <- as.data.frame(res_f)
res_f$vies_rel <- res_f$vies_2sls / res_f$vies_ols
print(round(res_f, 4))
for (j in seq_len(nrow(res_f))) {
  k <- sprintf("%02d", j)
  reg(paste0("m10_fraco_F_", k), res_f$F_medio[j])
  reg(paste0("m10_fraco_viesrel_", k), res_f$vies_rel[j])
}
reg("m10_fraco_vies_ols_pi0", res_f$vies_ols[1])
reg("m10_fraco_vies_2sls_pi0", res_f$vies_2sls[1])

abre_png("10_instrumentos_fracos.png")
plot(res_f$F_medio, res_f$vies_rel, log = "x", pch = 19, type = "b", col = "#7570b3", lwd = 2,
     ylim = c(0, 1.1), xlab = "F médio do 1º estágio (escala log)",
     ylab = "viés do MQ2E / viés do MQO",
     main = "Instrumentos fracos: com F pequeno o MQ2E herda o viés do MQO")
abline(v = 10, lty = 2, col = "firebrick"); abline(h = c(0, 1), lty = 3)
text(10, 1.05, "F = 10", pos = 4, col = "firebrick", cex = 0.85)
dev.off()

## ---- Retornos da escolaridade: a aplicação do SL10 (Cornwell-Rupert) ----
secao("Aplicação do SL10: PSID7682, ED instrumentada por MS e FEM")
data("PSID7682", package = "AER")
w <- PSID7682
w$lwage <- log(w$wage); w$exp2 <- w$experience^2
w$occ   <- as.numeric(w$occupation == "blue")
w$south <- as.numeric(w$south == "yes"); w$smsa <- as.numeric(w$smsa == "yes")
w$union <- as.numeric(w$union == "yes")
w$ms    <- as.numeric(w$married == "yes"); w$fem <- as.numeric(w$gender == "female")
ols_w <- lm(lwage ~ education + experience + exp2 + weeks + occ + south + smsa + union, data = w)
iv_w  <- ivreg(lwage ~ education + experience + exp2 + weeks + occ + south + smsa + union |
                 experience + exp2 + weeks + occ + south + smsa + union + ms + fem, data = w)
s_w <- summary(iv_w, diagnostics = TRUE)
print(s_w)
n_w <- nrow(w); K_w <- length(coef(iv_w))
reg("m10_cr_n", n_w)
reg("m10_cr_ols_ed", coef(ols_w)["education"])
reg("m10_cr_ols_occ", coef(ols_w)["occ"])
reg("m10_cr_ols_s", summary(ols_w)$sigma)
reg("m10_cr_2sls_ed", coef(iv_w)["education"])
reg("m10_cr_2sls_ep_ed", coef(s_w)["education", 2])
reg("m10_cr_2sls_occ", coef(iv_w)["occ"])
reg("m10_cr_2sls_s", s_w$sigma)
reg("m10_cr_2sls_s_n", sqrt(sum(resid(iv_w)^2) / n_w))          # divisor n, como no SL10
reg("m10_cr_fraco_F", s_w$diagnostics["Weak instruments", "statistic"])
reg("m10_cr_wu_F", s_w$diagnostics["Wu-Hausman", "statistic"])
reg("m10_cr_sargan", s_w$diagnostics["Sargan", "statistic"])
reg("m10_cr_sargan_p", s_w$diagnostics["Sargan", "p-value"])
fs_w <- lm(education ~ experience + exp2 + weeks + occ + south + smsa + union + ms + fem, data = w)
print(coef(summary(fs_w))[c("ms", "fem"), ])
reg("m10_cr_fs_ms", coef(fs_w)["ms"]); reg("m10_cr_fs_fem", coef(fs_w)["fem"])
w$vhat <- resid(fs_w)
cf_w <- lm(lwage ~ education + experience + exp2 + weeks + occ + south + smsa + union + vhat, data = w)
reg("m10_cr_cf_ed", coef(cf_w)["education"])
reg("m10_cr_cf_ep_ed", coef(summary(cf_w))["education", 2])
reg("m10_cr_cf_rho", coef(cf_w)["vhat"])
reg("m10_cr_cf_t", coef(summary(cf_w))["vhat", 3])
reg("m10_cr_cf_s", summary(cf_w)$sigma)
reg("m10_cr_cf_dif", max(abs(coef(cf_w)[names(coef(iv_w))] - coef(iv_w))))

## ---- Caso sobreidentificado clássico: mroz (Wooldridge) ----
secao("Retornos da escolaridade com mroz: educ instrumentada por motheduc e fatheduc")
data("mroz", package = "wooldridge")
mz <- subset(mroz, inlf == 1)
ols_mz <- lm(lwage ~ educ + exper + expersq, data = mz)
iv_mz  <- ivreg(lwage ~ educ + exper + expersq | exper + expersq + motheduc + fatheduc, data = mz)
s_mz <- summary(iv_mz, diagnostics = TRUE)
print(s_mz)
reg("m10_mz_n", nrow(mz))
reg("m10_mz_ols_educ", coef(ols_mz)["educ"])
reg("m10_mz_ols_ep_educ", coef(summary(ols_mz))["educ", 2])
reg("m10_mz_2sls_educ", coef(iv_mz)["educ"])
reg("m10_mz_2sls_ep_educ", coef(s_mz)["educ", 2])
reg("m10_mz_fraco_F", s_mz$diagnostics["Weak instruments", "statistic"])
reg("m10_mz_wu_F", s_mz$diagnostics["Wu-Hausman", "statistic"])
reg("m10_mz_wu_p", s_mz$diagnostics["Wu-Hausman", "p-value"])
reg("m10_mz_sargan", s_mz$diagnostics["Sargan", "statistic"])
reg("m10_mz_sargan_p", s_mz$diagnostics["Sargan", "p-value"])

## ---- Gravar ----
gravar_resultados("m10")
