# Módulo 04 — Regressão particionada e teorema de Frisch-Waugh-Lovell (SL04; Lista 1, ex. 25)
# id do script: m04
# Rodar: powershell -ExecutionPolicy Bypass -File scripts\r.ps1 04_fwl_particionada\04_fwl_particionada.R

# --- bootstrap: localizar a raiz do repo e carregar helpers ---
.d <- getwd(); while (!file.exists(file.path(.d, ".repo-root")) && dirname(.d) != .d) .d <- dirname(.d)
source(file.path(.d, "R", "raiz.R"))

suppressPackageStartupMessages(library(AER))   # dados PSID7682 (Cornwell e Rupert, 1988)

dir_fig <- caminho_repo("04_fwl_particionada", "figuras")
dir.create(dir_fig, showWarnings = FALSE, recursive = TRUE)
erro_max <- function(a, b = 0) max(abs(a - b))

data("PSID7682", package = "AER")
d <- PSID7682
d$lwage <- log(d$wage)

## ---- Regressão longa: a mesma especificação da Q1 da P1 2025/2 ----
# LWAGE ~ ED + EXP + EXP^2 + OCC + IND + SOUTH + SMSA + BLK + WKS (n = 4165, K = 10)
f_longa <- lwage ~ education + experience + I(experience^2) + occupation + industry +
  south + smsa + ethnicity + weeks
longa <- lm(f_longa, data = d)
n <- nobs(longa); K <- length(coef(longa))
b_ed <- coef(longa)["education"]
se_ed <- sqrt(diag(vcov(longa)))["education"]
t_ed <- b_ed / se_ed
registrar_varios(list(
  m04_psid_n = n, m04_psid_K = K, m04_psid_gl = n - K,
  m04_psid_b_ed = b_ed, m04_psid_se_ed = se_ed, m04_psid_t_ed = t_ed,
  m04_psid_ee = sum(resid(longa)^2)
))

## ---- FWL: parcializar X1 (tudo menos ED) de y e de ED ----
f_x1_y  <- lwage ~ experience + I(experience^2) + occupation + industry + south + smsa + ethnicity + weeks
f_x1_ed <- education ~ experience + I(experience^2) + occupation + industry + south + smsa + ethnicity + weeks
curta <- lm(f_x1_y, data = d)          # y em X1 (sem ED): resíduos M1 y
aux   <- lm(f_x1_ed, data = d)         # ED em X1: resíduos M1 x2
ey <- resid(curta); ex <- resid(aux)
b_fwl <- sum(ex * ey) / sum(ex^2)      # (x2'M1x2)^{-1} x2'M1y
fwl <- lm(ey ~ ex - 1)                 # regressão resíduo-em-resíduo (sem constante)
u_fwl <- resid(fwl)
# erro-padrão: lm() usa gl = n - 1; o correto é n - K
se_fwl_ingenuo <- sqrt(diag(vcov(fwl)))["ex"]
se_fwl_corrigido <- sqrt(sum(u_fwl^2) / (n - K) / sum(ex^2))
# variantes: só y parcializado (y cru em M1x2) e só x parcializado (M1y em x2 cru)
b_ycru <- sum(ex * d$lwage) / sum(ex^2)
b_xcru <- coef(lm(ey ~ d$education))[2]
registrar_varios(list(
  m04_fwl_b_ed = b_fwl,
  m04_fwl_dif_b = abs(b_fwl - b_ed),
  m04_fwl_dif_resid = erro_max(u_fwl, resid(longa)),
  m04_fwl_se_ingenuo = se_fwl_ingenuo,
  m04_fwl_se_corrigido = se_fwl_corrigido,
  m04_fwl_fator_gl = sqrt((n - 1) / (n - K)),
  m04_fwl_b_ycru = b_ycru,
  m04_fwl_b_xcru = b_xcru,
  m04_fwl_media_ex = mean(ex), m04_fwl_media_ey = mean(ey)
))

## ---- Inversa particionada: bloco (ED, ED) de (X'X)^{-1} = (x2'M1x2)^{-1} ----
Xm <- model.matrix(longa)
XtXinv <- solve(crossprod(Xm))
registrar_varios(list(
  m04_inv_bloco22 = XtXinv["education", "education"],
  m04_inv_1_sobre_xMx = 1 / sum(ex^2),
  m04_inv_dif = abs(XtXinv["education", "education"] - 1 / sum(ex^2))
))

## ---- Variância de b_ED pela FWL e o FIV (liga com D15) ----
# Com constante em X1: x2'M1x2 = SQT(ED) * (1 - R2 da auxiliar de ED em X1)
sst_ed <- sum((d$education - mean(d$education))^2)
r2_aux <- summary(aux)$r.squared
s2_longa <- sum(resid(longa)^2) / (n - K)
registrar_varios(list(
  m04_var_sst_ed = sst_ed, m04_var_r2_aux = r2_aux, m04_var_fiv = 1 / (1 - r2_aux),
  m04_var_xMx = sum(ex^2),
  m04_var_dif_xMx = abs(sum(ex^2) - sst_ed * (1 - r2_aux)),
  m04_var_s2 = s2_longa,
  m04_var_se_formula = sqrt(s2_longa / (sst_ed * (1 - r2_aux)))
))

## ---- Correlação parcial, t e variação do R^2 (Greene, Teorema 3.5) ----
R2_longa <- summary(longa)$r.squared
R2_curta <- summary(curta)$r.squared
r_parcial <- cor(ex, ey)
ee_curta <- sum(ey^2); uu_longa <- sum(resid(longa)^2)
registrar_varios(list(
  m04_pc_r2_parcial = r_parcial^2,
  m04_pc_t2_formula = t_ed^2 / (t_ed^2 + (n - K)),
  m04_pc_via_r2 = (R2_longa - R2_curta) / (1 - R2_curta),
  m04_pc_r2_curta = R2_curta, m04_pc_r2_longa = R2_longa,
  m04_pc_r2_longa_formula = R2_curta + (1 - R2_curta) * r_parcial^2,
  m04_pc_ee_curta = ee_curta, m04_pc_uu_longa = uu_longa,
  m04_pc_queda_ssr = b_fwl^2 * sum(ex^2),
  m04_pc_dif_teo35 = abs(uu_longa - (ee_curta - b_fwl^2 * sum(ex^2)))
))
# Mesma fórmula com os números impressos na P1 2025/2 (t = 22,050 e gl = 4155)
t_p1 <- 22.050; gl_p1 <- 4155
registrar("m04_pc_p1_r2_parcial", t_p1^2 / (t_p1^2 + gl_p1))
registrar("m04_pc_p1_r_parcial", sqrt(t_p1^2 / (t_p1^2 + gl_p1)))

## ---- Constante <=> desvios da média (M0 = M1 quando X1 = i) ----
simples <- lm(lwage ~ education + experience, data = d)
dm <- function(v) v - mean(v)
desv <- lm(dm(lwage) ~ dm(education) + dm(experience) - 1, data = d)
registrar_varios(list(
  m04_desv_b_ed = coef(simples)["education"],
  m04_desv_dif = erro_max(coef(desv), coef(simples)[-1]),
  m04_desv_intercepto = coef(simples)[1],
  m04_desv_intercepto_formula = mean(d$lwage) - sum(coef(simples)[-1] * c(mean(d$education), mean(d$experience)))
))

## ---- Ex. 25: viés de omissão no modelo particionado ----
# (a) identidade amostral exata: b1_curta = b1_longa + (X1'X1)^{-1}X1'x2 * b2_longa
delta <- coef(aux)                     # coeficientes da regressão auxiliar de ED em X1
b1_curta <- coef(curta); b1_longa <- coef(longa)[names(b1_curta)]
registrar_varios(list(
  m04_ex25_psid_bexp_curta = b1_curta["experience"],
  m04_ex25_psid_bexp_longa = b1_longa["experience"],
  m04_ex25_psid_delta_exp = delta["experience"],
  m04_ex25_psid_dif_ident = erro_max(b1_curta, b1_longa + delta * b_ed)
))

# (b) Monte Carlo com X fixo: E[b1 | X] = beta1 + (X1'X1)^{-1}X1'X2 beta2
set.seed(2525)
nmc <- 200; R <- 5000
x1 <- rnorm(nmc, 2, 1)
x2_cor <- 1 + 0.8 * x1 + rnorm(nmc, 0, 0.6)          # correlacionada com x1
x2_ort <- resid(lm(rnorm(nmc) ~ x1)) + 3             # ortogonal a x1 em desvios, média 3
beta1 <- c(1, 0.5); beta2 <- 0.7; sigma <- 1
X1 <- cbind(1, x1)
A1 <- solve(crossprod(X1), t(X1))                     # (X1'X1)^{-1}X1' (2 x n)
vies_teo <- function(x2) drop(solve(crossprod(X1), crossprod(X1, x2))) * beta2
sim <- function(x2) t(replicate(R, drop(A1 %*% (X1 %*% beta1 + x2 * beta2 + rnorm(nmc, 0, sigma)))))
s_cor <- sim(x2_cor); s_ort <- sim(x2_ort)
vt_cor <- vies_teo(x2_cor); vt_ort <- vies_teo(x2_ort)
registrar_varios(list(
  m04_ex25_mc_vies_teo_b2 = vt_cor[2], m04_ex25_mc_vies_sim_b2 = mean(s_cor[, 2]) - beta1[2],
  m04_ex25_mc_vies_teo_b1 = vt_cor[1], m04_ex25_mc_vies_sim_b1 = mean(s_cor[, 1]) - beta1[1],
  m04_ex25_mc_ort_vies_teo_b2 = vt_ort[2], m04_ex25_mc_ort_vies_sim_b2 = mean(s_ort[, 2]) - beta1[2],
  m04_ex25_mc_ort_vies_teo_b1 = vt_ort[1], m04_ex25_mc_ort_vies_sim_b1 = mean(s_ort[, 1]) - beta1[1]
))

## ---- Efeitos fixos: within = LSDV (PSID7682, 595 indivíduos x 7 anos) ----
N <- nlevels(d$id); Ti <- table(d$id)
f_fe <- lwage ~ experience + I(experience^2) + weeks + occupation + industry + south + smsa +
  married + union
# id entra PRIMEIRO: assim o lm() descarta a coluna redundante (ED, invariante no tempo),
# e não uma dummy de indivíduo
lsdv <- lm(update(f_fe, . ~ id + . + education), data = d)
Xw <- model.matrix(f_fe, data = d)[, -1]                      # sem a constante (absorvida por D)
yw <- d$lwage
within_dm <- function(v) v - ave(v, d$id)                     # M_D v: desvio da média do indivíduo
Xd <- apply(Xw, 2, within_dm); yd <- within_dm(yw)
within <- lm(yd ~ Xd - 1)
Kw <- ncol(Xw)
b_w <- coef(within); names(b_w) <- colnames(Xw)
b_l <- coef(lsdv)[colnames(Xw)]
se_w_ingenuo <- sqrt(diag(vcov(within)))
se_l <- sqrt(diag(vcov(lsdv)))[colnames(Xw)]
fator <- sqrt((n - Kw) / (n - N - Kw))
# efeitos fixos a_i = media_i(y) - media_i(x)'b
a_i <- tapply(yw, d$id, mean) - drop(apply(Xw, 2, function(v) tapply(v, d$id, mean)) %*% b_w)
# parametrização sem constante, com as N dummies completas (id tem de ser o 1º fator)
lsdv0 <- lm(lwage ~ 0 + id + experience + I(experience^2) + weeks + occupation + industry +
              south + smsa + married + union, data = d)
a_lsdv <- coef(lsdv0)[paste0("id", levels(d$id))]
# variação within da educação (invariante no tempo)
ss_within_ed <- sum(within_dm(d$education)^2)
# TWFE: experiência cresce 1 por ano para todos => colinear com dummies de id e de ano
twfe <- lm(lwage ~ id + year + experience + weeks, data = d)
registrar_varios(list(
  m04_fe_N = N, m04_fe_T = as.numeric(unique(Ti)), m04_fe_n = n, m04_fe_K = Kw,
  m04_fe_gl_lsdv = n - N - Kw, m04_fe_gl_ingenuo = n - Kw,
  m04_fe_b_weeks = b_w["weeks"], m04_fe_b_exp = b_w["experience"], m04_fe_b_union = b_w["unionyes"],
  m04_fe_dif_b = erro_max(b_w, b_l),
  m04_fe_se_weeks_lsdv = se_l["weeks"],
  m04_fe_se_weeks_ingenuo = se_w_ingenuo[which(colnames(Xw) == "weeks")],
  m04_fe_fator_gl = fator,
  m04_fe_dif_se_corrigido = erro_max(se_w_ingenuo * fator, se_l),
  m04_fe_dif_resid = erro_max(resid(within), resid(lsdv)),
  m04_fe_dif_ai = erro_max(a_i, a_lsdv),
  m04_fe_ed_na = as.numeric(is.na(coef(lsdv)["education"])),
  m04_fe_ss_within_ed = ss_within_ed,
  m04_fe_twfe_exp_na = as.numeric(is.na(coef(twfe)["experience"]))
))
# conferência opcional com plm (não obrigatória para o script terminar)
if (requireNamespace("plm", quietly = TRUE)) {
  pw <- plm::plm(f_fe, data = d, index = c("id", "year"), model = "within")
  registrar("m04_fe_dif_plm", erro_max(coef(pw)[colnames(Xw)], b_w))
  registrar("m04_fe_dif_se_plm", erro_max(sqrt(diag(vcov(pw)))[colnames(Xw)], se_l))
}

## ---- Figuras ----
# (1) FWL: relação bruta ED x LWAGE vs. regressão resíduo-em-resíduo
set.seed(4)
png(file.path(dir_fig, "04_fwl_educacao.png"), width = 1600, height = 1000, res = 200)
par(mfrow = c(1, 2), mar = c(4.5, 4.5, 3.5, 1))
b_simples <- coef(lm(lwage ~ education, data = d))
plot(jitter(d$education, 1.2), d$lwage, pch = 16, cex = 0.35, col = adjustcolor("grey30", 0.25),
     xlab = "ED (anos de estudo)", ylab = "LWAGE", main = "Bruto: LWAGE contra ED")
abline(b_simples, col = "firebrick", lwd = 2)
legend("bottomright", bty = "n", cex = 0.8, legend = sprintf("inclinação simples = %.4f", b_simples[2]))
plot(ex, ey, pch = 16, cex = 0.35, col = adjustcolor("grey30", 0.25),
     xlab = "resíduo de ED em X1 (M1 x2)", ylab = "resíduo de LWAGE em X1 (M1 y)",
     main = "FWL: resíduo contra resíduo")
abline(0, b_fwl, col = "steelblue4", lwd = 2)
legend("bottomright", bty = "n", cex = 0.8, legend = sprintf("inclinação = %.4f = b(ED) longa", b_fwl))
dev.off()

# (2) Transformação within: 6 indivíduos, LWAGE contra WKS
ids <- levels(d$id)[c(3, 40, 120, 250, 400, 560)]
sub <- d[d$id %in% ids, ]
sub$id <- droplevels(sub$id)
cores <- c("firebrick", "steelblue4", "darkgreen", "darkorange3", "purple4", "grey25")
# (a média within usa o id do subconjunto)
wdm <- function(v) v - ave(v, sub$id)
bw_sub <- coef(lm(wdm(sub$lwage) ~ wdm(sub$experience) - 1))
png(file.path(dir_fig, "04_within_lsdv.png"), width = 1600, height = 1000, res = 200)
par(mfrow = c(1, 2), mar = c(4.5, 4.5, 3.5, 1))
plot(sub$experience, sub$lwage, pch = 19, cex = 0.7, col = cores[as.integer(sub$id)],
     xlab = "EXP (anos)", ylab = "LWAGE", main = "Bruto: um intercepto por indivíduo",
     cex.main = 0.9)
for (j in seq_along(levels(sub$id))) {
  s <- sub[sub$id == levels(sub$id)[j], ]
  a <- mean(s$lwage) - bw_sub * mean(s$experience)
  abline(a, bw_sub, col = cores[j], lwd = 1.5)
}
plot(wdm(sub$experience), wdm(sub$lwage), pch = 19, cex = 0.7, col = cores[as.integer(sub$id)],
     xlab = "EXP − média do indivíduo", ylab = "LWAGE − média do indivíduo",
     main = "Within (desvios da média): inclinação comum", cex.main = 0.9)
abline(0, bw_sub, lwd = 2)
dev.off()

# (3) Ex. 25: distribuição de b2 (coef. de x1) com x2 omitido
png(file.path(dir_fig, "04_ex25_vies_omissao.png"), width = 1600, height = 1000, res = 200)
par(mar = c(4.5, 4.5, 3.5, 1))
rng <- range(c(s_cor[, 2], s_ort[, 2]))
ymax <- 1.6 * max(hist(s_ort[, 2], breaks = 60, plot = FALSE)$density,
                  hist(s_cor[, 2], breaks = 60, plot = FALSE)$density)
hist(s_ort[, 2], breaks = 60, col = adjustcolor("steelblue", 0.5), border = "white", freq = FALSE,
     xlim = rng, ylim = c(0, ymax), xlab = "coeficiente de x1 na regressão curta", ylab = "densidade",
     main = "Viés de omissão (ex. 25): x2 correlacionada vs. ortogonal a x1")
hist(s_cor[, 2], breaks = 60, col = adjustcolor("firebrick", 0.5), border = "white", freq = FALSE, add = TRUE)
abline(v = beta1[2], lwd = 2)
abline(v = beta1[2] + vt_cor[2], lwd = 2, lty = 2, col = "firebrick")
legend("topright", bty = "n", cex = 0.85,
       fill = c(adjustcolor("steelblue", 0.5), adjustcolor("firebrick", 0.5), NA, NA),
       border = NA, lty = c(NA, NA, 1, 2), lwd = c(NA, NA, 2, 2), col = c(NA, NA, "black", "firebrick"),
       legend = c("x2 ortogonal a x1: sem viés", "x2 correlacionada: viesado",
                  "β1 verdadeiro", "β1 + [(X1'X1)⁻¹X1'x2]β2"))
dev.off()

gravar_resultados("m04")
