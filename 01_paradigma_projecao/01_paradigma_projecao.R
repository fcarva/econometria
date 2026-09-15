# Módulo 01 — Paradigma econométrico, média condicional e projeção linear (id do script: m01)
#
# Confere numericamente os resultados de 01_teoria.md e 01_lista1.md:
#   D01.5  CEF côncava E[y|x] = 2 sqrt(x), x ~ U(0,4): projeção linear exata e simulada
#   D01.6  identificação: regressores linearmente dependentes (T = NI + S)
#   Ex. 12 Gauss-Markov na prática: MQO contra dois estimadores lineares não viesados
#   Seção 4  Cornwell-Rupert (AER::PSID7682): médias da coluna "Média de X" da P1 2025/2,
#            reprodução do MQO, efeito parcial, variação within e CEF empírica de LWAGE em EXP
#
# Rodar: powershell -ExecutionPolicy Bypass -File scripts\r.ps1 01_paradigma_projecao\01_paradigma_projecao.R

# --- bootstrap: localizar a raiz do repo e carregar helpers ---
.d <- getwd(); while (!file.exists(file.path(.d, ".repo-root")) && dirname(.d) != .d) .d <- dirname(.d)
source(file.path(.d, "R", "raiz.R"))

suppressPackageStartupMessages(library(AER))

dir_fig <- caminho_repo("01_paradigma_projecao", "figuras")
dir.create(dir_fig, showWarnings = FALSE, recursive = TRUE)
abrir_png <- function(nome) png(file.path(dir_fig, nome), width = 1600, height = 1000, res = 200)

## ---- D01.5: CEF côncava e sua projeção linear ----
# x ~ U(0, a) com a = 4; E[y | x] = 2 sqrt(x); y = 2 sqrt(x) + u, u ~ N(0, 0,5^2) independente de x.
a   <- 4
cef <- function(x) 2 * sqrt(x)
Ex    <- a / 2
Varx  <- a^2 / 12
Eg    <- integrate(function(x) cef(x) / a, 0, a)$value           # E[2 sqrt(x)]
Exg   <- integrate(function(x) x * cef(x) / a, 0, a)$value       # E[x 2 sqrt(x)]
Eg2   <- integrate(function(x) cef(x)^2 / a, 0, a)$value         # E[(2 sqrt(x))^2]
beta_teo <- (Exg - Ex * Eg) / Varx                               # Cov(x, y) / Var(x)
alfa_teo <- Eg - beta_teo * Ex                                   # E[y] - beta E[x]
aprox_teo <- integrate(function(x) (cef(x) - alfa_teo - beta_teo * x)^2 / a, 0, a)$value
var_cef   <- Eg2 - Eg^2
var_proj  <- beta_teo^2 * Varx
# Pontos em que a CEF cruza a projeção: beta s^2 - 2 s + alfa = 0, com s = sqrt(x)
s_cruz <- (2 + c(-1, 1) * sqrt(4 - 4 * beta_teo * alfa_teo)) / (2 * beta_teo)
x_cruz <- s_cruz^2
sigma_u <- 0.5

registrar("m01_d5_a", a)
registrar("m01_d5_Ex", Ex); registrar("m01_d5_Varx", Varx)
registrar("m01_d5_Eg", Eg); registrar("m01_d5_Exg", Exg)
registrar("m01_d5_cov_xg", Exg - Ex * Eg)
registrar("m01_d5_beta_teo", beta_teo); registrar("m01_d5_alfa_teo", alfa_teo)
registrar("m01_d5_aprox_teo", aprox_teo)
registrar("m01_d5_var_cef", var_cef); registrar("m01_d5_var_proj", var_proj)
registrar("m01_d5_x_cruz1", x_cruz[1]); registrar("m01_d5_x_cruz2", x_cruz[2])
registrar("m01_d5_vies_x0", cef(0) - alfa_teo)                        # E[v | x = 0]
registrar("m01_d5_vies_x1", cef(1) - alfa_teo - beta_teo * 1)         # E[v | x = 1]
registrar("m01_d5_vies_x4", cef(4) - alfa_teo - beta_teo * 4)         # E[v | x = 4]
registrar("m01_d5_sigma_u", sigma_u)
registrar("m01_d5_eqm_cef_teo", sigma_u^2)
registrar("m01_d5_eqm_proj_teo", sigma_u^2 + aprox_teo)
registrar("m01_d5_eqm_const_teo", sigma_u^2 + var_cef)

set.seed(20260915)
n  <- 200000
x  <- runif(n, 0, a)
y  <- cef(x) + rnorm(n, 0, sigma_u)
b  <- coef(lm(y ~ x))
v  <- y - alfa_teo - beta_teo * x                                     # erro de projeção
registrar("m01_d5_n", n)
registrar("m01_d5_ols_alfa", unname(b[1])); registrar("m01_d5_ols_beta", unname(b[2]))
registrar("m01_d5_media_v", mean(v))
registrar("m01_d5_cor_xv", cor(x, v))
registrar("m01_d5_Ev_xbaixo", mean(v[x < 0.3]))                       # E[v | x < 0,3] < 0
registrar("m01_d5_Ev_xmeio", mean(v[x > 1 & x < 2]))                  # E[v | 1 < x < 2] > 0
registrar("m01_d5_eqm_cef_sim", mean((y - cef(x))^2))
registrar("m01_d5_eqm_proj_sim", mean(v^2))
registrar("m01_d5_eqm_const_sim", mean((y - mean(y))^2))
g <- coef(lm(y ~ sqrt(x)))                                            # linear nos parâmetros
registrar("m01_d5_raiz_const", unname(g[1])); registrar("m01_d5_raiz_coef", unname(g[2]))

abrir_png("m01_cef_vs_projecao.png")
op <- par(mfrow = c(1, 2), mar = c(4.2, 4.2, 3, 1))
id <- 1:800
plot(x[id], y[id], pch = 16, cex = 0.45, col = adjustcolor("grey40", 0.5),
     xlab = "x", ylab = "y", main = "CEF côncava x projeção linear")
curve(cef(x), 0, a, add = TRUE, col = "firebrick", lwd = 2.5)
abline(alfa_teo, beta_teo, col = "steelblue", lwd = 2.5, lty = 2)
legend("bottomright", legend = c("E[y | x] = 2√x", "Projeção α + βx"),
       col = c("firebrick", "steelblue"), lwd = 2.5, lty = c(1, 2), bty = "n", cex = 0.85)
curve(cef(x) - alfa_teo - beta_teo * x, 0, a, col = "darkgreen", lwd = 2.5,
      xlab = "x", ylab = "E[v | x] = CEF − projeção",
      main = "Erro de projeção: média zero,\nmas não condicionalmente")
abline(h = 0, lty = 2)
abline(v = x_cruz, lty = 3, col = "grey40")
par(op); dev.off()

## ---- D01.6: identificação exige posto completo ----
# Renda total T = renda não salarial NI + salário S (dependência linear exata).
set.seed(22)
nI <- 50
NI <- rexp(nI, rate = 1 / 10)
S  <- rexp(nI, rate = 1 / 30)
TT <- NI + S
Xc <- cbind(1, NI, S, TT)
yI <- 5 + 0.3 * NI + 0.8 * S + rnorm(nI)
cfI <- coef(lm(yI ~ NI + S + TT))
registrar("m01_d6_K", ncol(Xc))
registrar("m01_d6_posto", qr(Xc)$rank)
registrar("m01_d6_T_na", as.numeric(is.na(cfI[["TT"]])))
registrar("m01_d6_Xdelta_max", max(abs(Xc %*% c(0, 1, 1, -1))))      # X delta = 0 com delta != 0

## ---- Ex. 12: Gauss-Markov na prática (três estimadores lineares não viesados) ----
# X fixo (A5): x = 1, ..., 20; beta1 = 1, beta2 = 0,5; erros N(0, 4).
set.seed(12)
xg <- 1:20; ng <- length(xg); b1 <- 1; b2 <- 0.5; sg2 <- 4; Rg <- 50000
Sxx <- sum((xg - mean(xg))^2)
k   <- (xg - mean(xg)) / Sxx                                   # pesos do MQO
w_ext <- c(-1, rep(0, ng - 2), 1) / (xg[ng] - xg[1])          # extremos: (y_n - y_1)/(x_n - x_1)
baixo <- xg <= 10; alto <- xg > 10
w_grp <- (alto / sum(alto) - baixo / sum(baixo)) / (mean(xg[alto]) - mean(xg[baixo]))  # médias de grupos
W <- rbind(mqo = k, extremos = w_ext, grupos = w_grp)
registrar("m01_ex12_Sxx", Sxx)
for (nm in rownames(W)) {
  registrar(paste0("m01_ex12_somaw_", nm), sum(W[nm, ]))           # = 0 (não viés exige)
  registrar(paste0("m01_ex12_somawx_", nm), sum(W[nm, ] * xg))     # = 1 (não viés exige)
  registrar(paste0("m01_ex12_var_teo_", nm), sg2 * sum(W[nm, ]^2)) # sigma^2 sum w^2
}
Y   <- matrix(b1 + b2 * rep(xg, each = Rg) + rnorm(Rg * ng, 0, sqrt(sg2)), nrow = Rg)
est <- Y %*% t(W)                                             # Rg x 3
for (j in seq_len(ncol(est))) {
  nm <- rownames(W)[j]
  registrar(paste0("m01_ex12_media_", nm), mean(est[, j]))
  registrar(paste0("m01_ex12_var_sim_", nm), var(est[, j]))
}

abrir_png("m01_gauss_markov.png")
op <- par(mar = c(4.2, 4.2, 3, 1))
dl <- lapply(seq_len(ncol(est)), function(j) density(est[, j]))
plot(dl[[1]], col = "firebrick", lwd = 2.5, xlim = c(0, 1), ylim = c(0, max(dl[[1]]$y) * 1.05),
     main = "Três estimadores lineares não viesados de β₂ = 0,5",
     xlab = "Estimativa de β₂", ylab = "Densidade")
lines(dl[[2]], col = "grey40", lwd = 2.5)
lines(dl[[3]], col = "steelblue", lwd = 2.5)
abline(v = b2, lty = 2)
legend("topright", legend = c("MQO (menor variância)", "Médias de grupos", "Pontos extremos"),
       col = c("firebrick", "steelblue", "grey40"), lwd = 2.5, bty = "n", cex = 0.85)
par(op); dev.off()

## ---- Seção 4: Cornwell-Rupert (AER::PSID7682) ----
data("PSID7682", package = "AER")
d <- PSID7682
d$lwage <- log(d$wage)
d$exp2  <- d$experience^2
d$occ   <- as.numeric(d$occupation == "blue")   # OCC = 1 se colarinho azul
d$ind   <- as.numeric(d$industry == "yes")
d$south <- as.numeric(d$south == "yes")
d$smsa  <- as.numeric(d$smsa == "yes")
d$blk   <- as.numeric(d$ethnicity == "afam")
d$fem   <- as.numeric(d$gender == "female")

registrar("m01_psid_n", nrow(d))
registrar("m01_psid_nind", nlevels(d$id))
registrar("m01_psid_nanos", nlevels(d$year))
registrar("m01_psid_media_lwage", mean(d$lwage))
registrar("m01_psid_dp_lwage", sd(d$lwage))
medias <- c(ed = mean(d$education), exp = mean(d$experience), exp2 = mean(d$exp2),
            occ = mean(d$occ), ind = mean(d$ind), south = mean(d$south), smsa = mean(d$smsa),
            blk = mean(d$blk), wks = mean(d$weeks), fem = mean(d$fem))
for (nm in names(medias)) registrar(paste0("m01_psid_media_", nm), medias[[nm]])
registrar("m01_psid_cont_occ", sum(d$occ)); registrar("m01_psid_cont_blk", sum(d$blk))
# E[EXP^2] = Var(EXP) + (E[EXP])^2 (variância com divisor n)
registrar("m01_psid_exp_media_quad", medias[["exp"]]^2)
registrar("m01_psid_exp_var_n", medias[["exp2"]] - medias[["exp"]]^2)
registrar("m01_psid_exp_dp_n", sqrt(medias[["exp2"]] - medias[["exp"]]^2))

fit <- lm(lwage ~ education + experience + exp2 + occ + ind + south + smsa + blk + weeks, data = d)
sf  <- summary(fit)
cf  <- coef(sf)
registrar("m01_psid_K", length(coef(fit)))
registrar("m01_psid_gl", fit$df.residual)
registrar("m01_psid_b_const", cf["(Intercept)", 1])
registrar("m01_psid_b_ed", cf["education", 1]);  registrar("m01_psid_ep_ed", cf["education", 2])
registrar("m01_psid_b_exp", cf["experience", 1]); registrar("m01_psid_t_exp", cf["experience", 3])
registrar("m01_psid_b_exp2", cf["exp2", 1])
registrar("m01_psid_b_south", cf["south", 1])
registrar("m01_psid_b_wks", cf["weeks", 1])
registrar("m01_psid_r2", sf$r.squared); registrar("m01_psid_r2aj", sf$adj.r.squared)
registrar("m01_psid_sqr", sum(resid(fit)^2)); registrar("m01_psid_s", sf$sigma)
registrar("m01_psid_F", unname(sf$fstatistic["value"]))
# Efeito parcial de EXP avaliado na média de EXP: a3 + 2 a4 EXP_bar
registrar("m01_psid_efeito_exp_media", cf["experience", 1] + 2 * cf["exp2", 1] * medias[["exp"]])
registrar("m01_psid_exp_pico", -cf["experience", 1] / (2 * cf["exp2", 1]))

# Estrutura de painel: fração da variação total de LWAGE que é within (dentro do indivíduo)
lw_i <- ave(d$lwage, d$id)
registrar("m01_psid_frac_within_lwage", sum((d$lwage - lw_i)^2) / sum((d$lwage - mean(d$lwage))^2))
registrar("m01_psid_within_ed", sum((d$education - ave(d$education, d$id))^2))   # ED não varia no tempo
registrar("m01_psid_within_blk", sum((d$blk - ave(d$blk, d$id))^2))
registrar("m01_psid_within_fem", sum((d$fem - ave(d$fem, d$id))^2))

# CEF empírica de LWAGE em EXP (médias por ano de experiência) x projeção linear x quadrática
tab  <- aggregate(lwage ~ experience, data = d, FUN = mean)
cnt  <- aggregate(lwage ~ experience, data = d, FUN = length)
tab$n <- cnt$lwage
f_lin  <- lm(lwage ~ experience, data = d)
f_quad <- lm(lwage ~ experience + exp2, data = d)
registrar("m01_psid_lin_const", coef(f_lin)[[1]]); registrar("m01_psid_lin_b", coef(f_lin)[[2]])
registrar("m01_psid_quad_b1", coef(f_quad)[[2]]); registrar("m01_psid_quad_b2", coef(f_quad)[[3]])
registrar("m01_psid_quad_pico", -coef(f_quad)[[2]] / (2 * coef(f_quad)[[3]]))
registrar("m01_psid_lin_r2", summary(f_lin)$r.squared)
registrar("m01_psid_quad_r2", summary(f_quad)$r.squared)
# Regressão saturada em EXP (uma dummy por valor) = CEF empírica exata; R^2 máximo possível em EXP
f_sat <- lm(lwage ~ factor(experience), data = d)
registrar("m01_psid_sat_r2", summary(f_sat)$r.squared)
registrar("m01_psid_sat_K", length(coef(f_sat)))
registrar("m01_psid_sat_maxdif", max(abs(fitted(f_sat) - ave(d$lwage, d$experience))))

abrir_png("m01_psid_cef_exp.png")
op <- par(mar = c(4.2, 4.2, 3, 1))
plot(tab$experience, tab$lwage, pch = 21, bg = adjustcolor("grey40", 0.6), col = "grey20",
     cex = 0.4 + 2.2 * sqrt(tab$n / max(tab$n)),
     xlab = "Anos de experiência (EXP)", ylab = "Média de LWAGE",
     main = "Cornwell-Rupert: CEF empírica de LWAGE em EXP")
abline(f_lin, col = "steelblue", lwd = 2.5, lty = 2)
eg <- seq(1, 51, by = 0.5)
lines(eg, coef(f_quad)[1] + coef(f_quad)[2] * eg + coef(f_quad)[3] * eg^2, col = "firebrick", lwd = 2.5)
legend("bottom", legend = c("Médias por EXP (área ∝ nº de obs.)", "Projeção linear em EXP",
                            "Projeção em (EXP, EXP²)"),
       pch = c(21, NA, NA), pt.bg = c("grey40", NA, NA), col = c("grey20", "steelblue", "firebrick"),
       lwd = c(NA, 2.5, 2.5), lty = c(NA, 2, 1), bty = "n", cex = 0.85)
par(op); dev.off()

gravar_resultados("m01")
