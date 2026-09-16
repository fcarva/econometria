# Banco de outputs para a P1 (id bnc)
#
# Gera em provas/banco/outputs/*.txt (UTF-8, LF) todos os outputs usados no banco de
# interpretação e nos simulados, nos layouts das provas do professor (R/saida_nlogit.R):
#   saida_nlogit()   MQO no layout NLOGIT da P1 2025/2
#   saida_mq2e()     MQ2E no layout da P2 2024/2, com instrumentos e diagnósticos
#   saida_ivreg_r()  summary(ivreg, diagnostics = TRUE) do R, como na Lista 1, ex. 67
#   saida_testes()   bloco de testes (JB, RESET, Breusch-Pagan, White, DW, BG, Chow, F)
# Todos os dados vêm de pacotes (AER, wooldridge, plm); nada depende de materiais/.
#
# Seções: A. PSID7682 (P1 2025/2 e P2 2024/2)   B. Cigarros   C. CPS1985
#         D. hprice1   E. consumo anual (USConsump1993)   F. Produc (Cobb-Douglas, CRS, Chow)
#         G. mroz   H. injury (DiD)   I. wage1 (simulado 01)   J. USMacroG (simulado 02)
#         K. kielmc e card (simulado 03)   L. valores críticos
#
# Rodar: powershell -ExecutionPolicy Bypass -File scripts\r.ps1 provas\banco\gerar_outputs.R

# --- bootstrap: localizar a raiz do repo e carregar helpers ---
.d <- getwd(); while (!file.exists(file.path(.d, ".repo-root")) && dirname(.d) != .d) .d <- dirname(.d)
source(file.path(.d, "R", "raiz.R"))

suppressPackageStartupMessages({
  library(AER); library(wooldridge); library(lmtest); library(sandwich)
  library(car); library(tseries); library(plm)
})

dir_out <- caminho_repo("provas", "banco", "outputs")
dir.create(dir_out, showWarnings = FALSE, recursive = TRUE)
arquivos <- character(0)
salva <- function(linhas, nome) {
  gravar_saida(linhas, file.path(dir_out, nome))
  arquivos <<- c(arquivos, nome)
  cat("\n#####", nome, "#####\n"); cat(linhas, sep = "\n")
}
reg <- function(chave, valor) registrar(paste0("bnc_", chave), unname(as.numeric(valor)))

confere <- function(a, b, rotulo, tol = 1e-8) {
  if (abs(unname(a) - unname(b)) > tol * max(1, abs(b))) stop("Identidade falhou: ", rotulo)
  invisible(TRUE)
}

# Linhas de teste a partir de objetos htest / anova
lin_htest <- function(nome, h, gl = NULL) {
  if (is.null(gl)) gl <- paste(h$parameter, collapse = " e ")
  data.frame(teste = nome, estatistica = unname(h$statistic), gl = gl, p = h$p.value)
}
lin_F <- function(nome, Fst, g1, g2) data.frame(teste = nome, estatistica = Fst,
                                               gl = paste(g1, "e", g2), p = pf(Fst, g1, g2, lower.tail = FALSE))
# Teste de White completo: e² contra regressores, quadrados e produtos cruzados (n·R²)
white <- function(m) {
  X <- model.matrix(m)[, -1, drop = FALSE]
  k <- ncol(X); Z <- X
  for (i in 1:k) for (j in i:k) Z <- cbind(Z, X[, i] * X[, j])
  aux <- lm(resid(m)^2 ~ Z)
  gl <- sum(!is.na(coef(aux))) - 1
  est <- length(resid(m)) * summary(aux)$r.squared
  data.frame(teste = "White (quadrados e produtos cruzados)", estatistica = est,
             gl = as.character(gl), p = pchisq(est, gl, lower.tail = FALSE))
}

## ---- A. PSID7682: P1 2025/2 (Q1) e P2 2024/2 (Q6) ----
data("PSID7682", package = "AER")
psid <- with(PSID7682, data.frame(
  LWAGE = round(log(wage), 5), ED = education, EXP = experience, EXP2 = experience^2,
  OCC = as.numeric(occupation == "blue"), IND = as.numeric(industry == "yes"),
  SOUTH = as.numeric(south == "yes"), SMSA = as.numeric(smsa == "yes"),
  BLK = as.numeric(ethnicity == "afam"), WKS = weeks,
  UNION = as.numeric(union == "yes"), FEM = as.numeric(gender == "female")))
nm_psid <- c(EXP2 = "EXP²")

pa <- lm(LWAGE ~ ED + EXP + EXP2 + OCC + IND + SOUTH + SMSA + BLK + WKS, data = psid)
salva(saida_nlogit(pa, lhs = "LWAGE", nomes = nm_psid, imprimir = FALSE), "psid_mqo.txt")
spa <- summary(pa)
n_p <- nobs(pa)
sst_p <- (n_p - 1) * sd(psid$LWAGE)^2
reg("psid_sst", sst_p)
reg("psid_r2_cabecalho", 1 - 581.2717 / ((4165 - 1) * 0.4615122^2))
reg("psid_F_cabecalho", (0.3446066 / 9) / ((1 - 0.3446066) / 4155))
reg("psid_s2", spa$sigma^2)
reg("psid_elast_wks", coef(pa)["WKS"] * mean(psid$WKS))
reg("psid_ed_exato", 100 * (exp(coef(pa)["ED"]) - 1))
reg("psid_blk_exato", 100 * (exp(coef(pa)["BLK"]) - 1))
reg("psid_smsa_exato", 100 * (exp(coef(pa)["SMSA"]) - 1))
reg("psid_prop_south", mean(psid$SOUTH))

# Variante com FEM e UNION (F conjunto pelo R²)
pb <- lm(LWAGE ~ ED + EXP + EXP2 + OCC + IND + SOUTH + SMSA + BLK + WKS + FEM + UNION, data = psid)
salva(saida_nlogit(pb, lhs = "LWAGE", nomes = nm_psid, imprimir = FALSE), "psid_mqo_fem_union.txt")
spb <- summary(pb)
F_fu <- ((spb$r.squared - spa$r.squared) / 2) / ((1 - spb$r.squared) / (n_p - 12))
confere(F_fu, anova(pa, pb)$F[2], "F conjunto via R² = anova")
reg("psid2_r2", spb$r.squared); reg("psid2_r2adj", spb$r.squared)
reg("psid2_r2adj", spb$adj.r.squared)
reg("psid2_b_fem", coef(pb)["FEM"]); reg("psid2_t_fem", coef(spb)["FEM", 3])
reg("psid2_fem_exato", 100 * (exp(coef(pb)["FEM"]) - 1))
reg("psid2_b_union", coef(pb)["UNION"]); reg("psid2_t_union", coef(spb)["UNION", 3])
reg("psid2_union_exato", 100 * (exp(coef(pb)["UNION"]) - 1))
reg("psid2_b_ed", coef(pb)["ED"])
reg("psid2_F_conj", F_fu); reg("psid2_F_conj_p", pf(F_fu, 2, n_p - 12, lower.tail = FALSE))
reg("psid2_Fcrit", qf(0.95, 2, n_p - 12))

# P2 2024/2, Q6: MQ2E com WKS endógena e UNION, FEM como instrumentos excluídos.
# O NLOGIT usa s² = e'e/n no MQ2E (divisor = "n").
p2 <- ivreg(LWAGE ~ ED + EXP + EXP2 + OCC + IND + SOUTH + SMSA + BLK + WKS |
              ED + EXP + EXP2 + OCC + IND + SOUTH + SMSA + BLK + UNION + FEM, data = psid)
salva(saida_mq2e(p2, lhs = "LWAGE", nomes = nm_psid, divisor = "n", imprimir = FALSE), "psid_mq2e_wks.txt")
e_p2 <- resid(p2); ssr_p2 <- sum(e_p2^2); K_p2 <- length(coef(p2))
s2n <- ssr_p2 / n_p
r2_p2 <- 1 - ssr_p2 / sst_p
dg_p2 <- summary(p2, diagnostics = TRUE)$diagnostics
reg("p2_r2", r2_p2); reg("p2_r2adj", 1 - (1 - r2_p2) * (n_p - 1) / (n_p - K_p2))
reg("p2_F", (r2_p2 / (K_p2 - 1)) / ((1 - r2_p2) / (n_p - K_p2)))
reg("p2_b_wks", coef(p2)["WKS"]); reg("p2_se_wks", sqrt(s2n * p2$cov.unscaled["WKS", "WKS"]))
reg("p2_s", sqrt(s2n)); reg("p2_ssr", ssr_p2); reg("p2_ssr_nlogit", s2n * (n_p - K_p2))
reg("p2_expstar", -coef(p2)["EXP"] / (2 * coef(p2)["EXP2"]))
reg("p2_df2", dg_p2[1, 2]); reg("p2_weak", dg_p2[1, 3])
reg("p2_wh", dg_p2[2, 3]); reg("p2_wh_p", dg_p2[2, 4])
reg("p2_sargan", dg_p2[3, 3]); reg("p2_sargan_p", dg_p2[3, 4])

## ---- B. Cigarros (CigarettesSW, 1995) ----
data("CigarettesSW", package = "AER")
cig <- subset(CigarettesSW, year == "1995")
cig$rprice  <- cig$price / cig$cpi
cig$rincome <- cig$income / cig$population / cig$cpi
cig$tdiff   <- (cig$taxs - cig$tax) / cig$cpi
ivc <- ivreg(log(packs) ~ log(rprice) + log(rincome) | log(rincome) + tdiff + I(tax/cpi), data = cig)
salva(saida_ivreg_r(ivc, vcov. = sandwich, df = Inf, imprimir = FALSE), "cig_ivreg_robusto.txt")
salva(saida_ivreg_r(ivc, imprimir = FALSE), "cig_ivreg_classico.txt")
salva(saida_ivreg_r(ivc, vcov. = sandwich, imprimir = FALSE), "cig_ivreg_robusto_gl.txt")
cig_ols <- data.frame(LPACKS = log(cig$packs), LPRECO = log(cig$rprice), LRENDA = log(cig$rincome))
mc <- lm(LPACKS ~ LPRECO + LRENDA, data = cig_ols)
salva(saida_nlogit(mc, lhs = "LPACKS", imprimir = FALSE), "cig_mqo.txt")
src <- summary(ivc, vcov. = sandwich, df = Inf)
srf <- summary(ivc, vcov. = sandwich)
reg("cig_mqo_b_preco", coef(mc)["LPRECO"]); reg("cig_mqo_se_preco", coef(summary(mc))["LPRECO", 2])
reg("cig_iv_b_preco", coef(ivc)[2])
reg("cig_wald_chi2", src$waldtest[1]); reg("cig_wald_F", srf$waldtest[1])
reg("cig_wald_razao", src$waldtest[1] / srf$waldtest[1])

## ---- C. CPS1985: log-salário, testes, Chow por gênero, FIV ----
data("CPS1985", package = "AER")
cps <- with(CPS1985, data.frame(
  LWAGE = log(wage), ED = education, EXP = experience, EXP2 = experience^2, AGE = age,
  FEM = as.numeric(gender == "female"), UNION = as.numeric(union == "yes"),
  SOUTH = as.numeric(region == "south"), HISP = as.numeric(ethnicity == "hispanic"),
  OUTRA = as.numeric(ethnicity == "other")))
nm_cps <- c(EXP2 = "EXP²")
ca <- lm(LWAGE ~ ED + EXP + EXP2 + FEM + UNION + SOUTH + HISP + OUTRA, data = cps)
salva(saida_nlogit(ca, lhs = "LWAGE", nomes = nm_cps, imprimir = FALSE), "cps_mqo.txt")
jb_c <- jarque.bera.test(resid(ca))
rs_c <- resettest(ca, power = 2:3, type = "fitted")
bp_c <- bptest(ca)
wh_c <- white(ca)
tab_c <- rbind(lin_htest("Jarque-Bera (resíduos)", jb_c),
               lin_htest("RESET (ŷ² e ŷ³)", rs_c),
               lin_htest("Breusch-Pagan (Koenker)", bp_c),
               wh_c)
salva(saida_testes(tab_c, imprimir = FALSE), "cps_testes.txt")
sca <- summary(ca)
reg("cps_n", nobs(ca)); reg("cps_r2adj", sca$adj.r.squared)
reg("cps_b_ed", coef(ca)["ED"]); reg("cps_b_fem", coef(ca)["FEM"]); reg("cps_t_fem", coef(sca)["FEM", 3])
reg("cps_fem_exato", 100 * (exp(coef(ca)["FEM"]) - 1))
reg("cps_b_union", coef(ca)["UNION"]); reg("cps_union_exato", 100 * (exp(coef(ca)["UNION"]) - 1))
reg("cps_t_hisp", coef(sca)["HISP", 3]); reg("cps_t_outra", coef(sca)["OUTRA", 3])
reg("cps_t_south", coef(sca)["SOUTH", 3])
reg("cps_expstar", -coef(ca)["EXP"] / (2 * coef(ca)["EXP2"]))
reg("cps_jb", jb_c$statistic); reg("cps_jb_p", jb_c$p.value)
reg("cps_reset", rs_c$statistic); reg("cps_reset_p", rs_c$p.value)
reg("cps_bp", bp_c$statistic); reg("cps_bp_p", bp_c$p.value); reg("cps_bp_gl", bp_c$parameter)
reg("cps_white", wh_c$estatistica); reg("cps_white_p", wh_c$p); reg("cps_white_gl", as.numeric(wh_c$gl))
reg("cps_chi2crit_bp", qchisq(0.95, bp_c$parameter))
# BP à mão: n·R² da regressão de e² nos regressores (versão de Koenker)
r2_bp <- summary(lm(resid(ca)^2 ~ ED + EXP + EXP2 + FEM + UNION + SOUTH + HISP + OUTRA, data = cps))$r.squared
confere(nobs(ca) * r2_bp, bp_c$statistic, "BP de Koenker = n·R² auxiliar", 1e-6)
reg("cps_bp_r2aux", r2_bp)
# Versão com erros padrão robustos (HC1) para comparar
salva(saida_nlogit(ca, lhs = "LWAGE", nomes = nm_cps, vcov. = vcovHC(ca, type = "HC1"), imprimir = FALSE),
      "cps_mqo_robusto.txt")
reg("cps_se_fem_hc1", sqrt(vcovHC(ca, type = "HC1")["FEM", "FEM"]))
reg("cps_se_fem", coef(sca)["FEM", 2])

# Chow por gênero via interações: H0: FEM, FEM·ED, FEM·EXP, FEM·EXP² = 0
cps$FEM_ED <- cps$FEM * cps$ED; cps$FEM_EXP <- cps$FEM * cps$EXP; cps$FEM_EXP2 <- cps$FEM * cps$EXP2
cr <- lm(LWAGE ~ ED + EXP + EXP2, data = cps)
cu <- lm(LWAGE ~ ED + EXP + EXP2 + FEM + FEM_ED + FEM_EXP + FEM_EXP2, data = cps)
salva(c(saida_nlogit(cu, lhs = "LWAGE", nomes = c(EXP2 = "EXP²", FEM_ED = "FEM·ED", FEM_EXP = "FEM·EXP",
                                                   FEM_EXP2 = "FEM·EXP²"), imprimir = FALSE),
        "", "Modelo restrito (sem FEM e sem interações): LWAGE ~ ED + EXP + EXP²",
        paste0("Soma dos quadrados dos resíduos = ", .nl_sig(sum(resid(cr)^2)),
               "   Parâmetros = 4   Observações = ", nobs(cr))),
      "cps_chow_genero.txt")
ssr_r <- sum(resid(cr)^2); ssr_u <- sum(resid(cu)^2)
ssr_h <- sum(resid(lm(LWAGE ~ ED + EXP + EXP2, data = subset(cps, FEM == 0)))^2)
ssr_m <- sum(resid(lm(LWAGE ~ ED + EXP + EXP2, data = subset(cps, FEM == 1)))^2)
confere(ssr_u, ssr_h + ssr_m, "SQR com interações = soma das SQR separadas (Chow)", 1e-8)
F_chow <- ((ssr_r - ssr_u) / 4) / (ssr_u / (nobs(cu) - 8))
confere(F_chow, anova(cr, cu)$F[2], "Chow = F de anova")
reg("chow_ssr_r", ssr_r); reg("chow_ssr_u", ssr_u); reg("chow_ssr_h", ssr_h); reg("chow_ssr_m", ssr_m)
reg("chow_F", F_chow); reg("chow_gl2", nobs(cu) - 8)
reg("chow_p", pf(F_chow, 4, nobs(cu) - 8, lower.tail = FALSE)); reg("chow_Fcrit", qf(0.95, 4, nobs(cu) - 8))

# Multicolinearidade: AGE = ED + EXP + 6 quase exatamente
cv <- lm(LWAGE ~ ED + EXP + AGE + FEM, data = cps)
aux_age <- lm(AGE ~ ED + EXP + FEM, data = cps)
aux_ed <- lm(ED ~ EXP + AGE + FEM, data = cps)
r2_age <- summary(aux_age)$r.squared; r2_ed <- summary(aux_ed)$r.squared
salva(c(saida_nlogit(cv, lhs = "LWAGE", imprimir = FALSE), "",
        "Regressões auxiliares (cada regressor contra os demais):",
        paste0("  AGE contra ED, EXP, FEM:  R² = ", .nl_sig(r2_age)),
        paste0("  ED contra EXP, AGE, FEM:  R² = ", .nl_sig(r2_ed)),
        paste0("Correlação simples entre AGE e EXP = ", .nl_sig(cor(cps$AGE, cps$EXP), 4))),
      "cps_multicol.txt")
scv <- summary(cv)
reg("vif_r2_age", r2_age); reg("vif_age", 1 / (1 - r2_age)); reg("vif_r2_ed", r2_ed); reg("vif_ed", 1 / (1 - r2_ed))
confere(1 / (1 - r2_age), car::vif(cv)["AGE"], "FIV = 1/(1-R²aux)", 1e-6)
reg("vif_se_ed", coef(scv)["ED", 2]); reg("vif_se_ed_curto", coef(sca)["ED", 2])
reg("vif_r2", scv$r.squared); reg("vif_F", scv$fstatistic[1])
reg("vif_t_ed", coef(scv)["ED", 3]); reg("vif_t_exp", coef(scv)["EXP", 3]); reg("vif_t_age", coef(scv)["AGE", 3])
reg("vif_cor_age_exp", cor(cps$AGE, cps$EXP))

## ---- D. hprice1: log-log, elasticidades e testes com n = 88 ----
data("hprice1", package = "wooldridge")
hp <- with(hprice1, data.frame(LPRICE = lprice, LLOTSIZE = llotsize, LSQRFT = lsqrft, BDRMS = bdrms))
mh <- lm(LPRICE ~ LLOTSIZE + LSQRFT + BDRMS, data = hp)
salva(saida_nlogit(mh, lhs = "LPRICE", imprimir = FALSE), "hprice_mqo.txt")
tab_h <- rbind(lin_htest("Jarque-Bera (resíduos)", jarque.bera.test(resid(mh))),
               lin_htest("RESET (ŷ² e ŷ³)", resettest(mh, power = 2:3, type = "fitted")),
               lin_htest("Breusch-Pagan (Koenker)", bptest(mh)),
               white(mh))
salva(saida_testes(tab_h, imprimir = FALSE), "hprice_testes.txt")
smh <- summary(mh)
reg("hp_n", nobs(mh)); reg("hp_b_lot", coef(mh)["LLOTSIZE"]); reg("hp_b_sqrft", coef(mh)["LSQRFT"])
reg("hp_se_sqrft", coef(smh)["LSQRFT", 2]); reg("hp_t_sqrft", coef(smh)["LSQRFT", 3])
reg("hp_b_bdrms", coef(mh)["BDRMS"]); reg("hp_t_bdrms", coef(smh)["BDRMS", 3])
reg("hp_bdrms_exato", 100 * (exp(coef(mh)["BDRMS"]) - 1))
reg("hp_tcrit_5", qt(0.975, nobs(mh) - 4))
reg("hp_ic_sqrft_inf", coef(mh)["LSQRFT"] - qt(0.975, nobs(mh) - 4) * coef(smh)["LSQRFT", 2])
reg("hp_ic_sqrft_sup", coef(mh)["LSQRFT"] + qt(0.975, nobs(mh) - 4) * coef(smh)["LSQRFT", 2])
reg("hp_jb", tab_h$estatistica[1]); reg("hp_jb_p", tab_h$p[1])
reg("hp_reset", tab_h$estatistica[2]); reg("hp_reset_p", tab_h$p[2])
reg("hp_bp", tab_h$estatistica[3]); reg("hp_bp_p", tab_h$p[3])
reg("hp_white", tab_h$estatistica[4]); reg("hp_white_p", tab_h$p[4]); reg("hp_white_gl", as.numeric(tab_h$gl[4]))
reg("hp_chi2crit_2", qchisq(0.95, 2)); reg("hp_Fcrit_reset", qf(0.95, 2, nobs(mh) - 6))
reg("hp_t_sqrft_1", (coef(mh)["LSQRFT"] - 1) / coef(smh)["LSQRFT", 2])

## ---- E. Consumo anual (USConsump1993): regressão simples, t² = F, DW e BG ----
data("USConsump1993", package = "AER")
uc <- data.frame(LCONS = log(as.numeric(USConsump1993[, "expenditure"])),
                 LRENDA = log(as.numeric(USConsump1993[, "income"])))
mu <- lm(LCONS ~ LRENDA, data = uc)
dw_u <- dwtest(mu); bg1 <- bgtest(mu, order = 1); bg2 <- bgtest(mu, order = 2)
tab_u <- rbind(data.frame(teste = "Durbin-Watson", estatistica = unname(dw_u$statistic), gl = "-", p = dw_u$p.value),
               lin_htest("Breusch-Godfrey (1 defasagem)", bg1), lin_htest("Breusch-Godfrey (2 defasagens)", bg2),
               lin_htest("Jarque-Bera (resíduos)", jarque.bera.test(resid(mu))))
salva(c(saida_nlogit(mu, lhs = "LCONS", dig_p_F = 4, imprimir = FALSE), "",
        "Série anual 1950-1993 (EUA); consumo e renda disponível em logaritmo.",
        saida_testes(tab_u, imprimir = FALSE)), "consumo_anual.txt")
smu <- summary(mu)
t_u <- coef(smu)["LRENDA", 3]
confere(t_u^2, smu$fstatistic[1], "t² = F na regressão simples", 1e-8)
confere(smu$r.squared, cor(uc$LCONS, uc$LRENDA)^2, "R² = r² na regressão simples", 1e-10)
reg("cons_n", nobs(mu)); reg("cons_b", coef(mu)["LRENDA"]); reg("cons_se", coef(smu)["LRENDA", 2])
reg("cons_t", t_u); reg("cons_t2", t_u^2); reg("cons_F", smu$fstatistic[1]); reg("cons_r2", smu$r.squared)
reg("cons_r", cor(uc$LCONS, uc$LRENDA))
reg("cons_F_de_r2", smu$r.squared * (nobs(mu) - 2) / (1 - smu$r.squared))
reg("cons_t_elast1", (coef(mu)["LRENDA"] - 1) / coef(smu)["LRENDA", 2])
reg("cons_dw", dw_u$statistic); reg("cons_rho_dw", 1 - dw_u$statistic / 2)
reg("cons_bg1", bg1$statistic); reg("cons_bg1_p", bg1$p.value); reg("cons_bg2", bg2$statistic); reg("cons_bg2_p", bg2$p.value)
reg("cons_tcrit", qt(0.975, nobs(mu) - 2))

## ---- F. Produc (PIB estadual, EUA): Cobb-Douglas, CRS, Chow 1970 x 1986 ----
data("Produc", package = "plm")
prod <- with(Produc, data.frame(ANO = year, LGSP = log(gsp), LK = log(pc), LL = log(emp), UNEMP = unemp))
cobb <- function(ano, arq_u, arq_r, chave) {
  d <- subset(prod, ANO == ano)
  mu_ <- lm(LGSP ~ LK + LL + UNEMP, data = d)
  d$LGSP_L <- d$LGSP - d$LL; d$LK_L <- d$LK - d$LL
  mr_ <- lm(LGSP_L ~ LK_L + UNEMP, data = d)
  salva(c(paste0("Irrestrito, ", ano, " (48 estados): LGSP = log PIB; LK = log capital privado; LL = log emprego"),
          saida_nlogit(mu_, lhs = "LGSP", dig_p_F = 4, imprimir = FALSE)), arq_u)
  salva(c(paste0("Restrito (a_K + a_L = 1), ", ano, ": LGSP_L = log(PIB/emprego); LK_L = log(capital/emprego)"),
          saida_nlogit(mr_, lhs = "LGSP_L", dig_p_F = 4, imprimir = FALSE)), arq_r)
  su <- sum(resid(mu_)^2); sr <- sum(resid(mr_)^2); n <- nobs(mu_)
  Fc <- ((sr - su) / 1) / (su / (n - 4))
  confere(Fc, linearHypothesis(mu_, "LK + LL = 1")$F[2], paste("F restrito", ano))
  V <- vcov(mu_); soma <- coef(mu_)["LK"] + coef(mu_)["LL"]
  ep_soma <- sqrt(V["LK", "LK"] + V["LL", "LL"] + 2 * V["LK", "LL"])
  confere(((soma - 1) / ep_soma)^2, Fc, paste("t² = F na restrição", ano), 1e-6)
  reg(paste0(chave, "_ssr_u"), su); reg(paste0(chave, "_ssr_r"), sr); reg(paste0(chave, "_F"), Fc)
  reg(paste0(chave, "_p"), pf(Fc, 1, n - 4, lower.tail = FALSE)); reg(paste0(chave, "_Fcrit"), qf(0.95, 1, n - 4))
  reg(paste0(chave, "_soma"), soma); reg(paste0(chave, "_ep_soma"), ep_soma); reg(paste0(chave, "_t"), (soma - 1) / ep_soma)
  reg(paste0(chave, "_b_k"), coef(mu_)["LK"]); reg(paste0(chave, "_b_l"), coef(mu_)["LL"])
  reg(paste0(chave, "_b_unemp"), coef(mu_)["UNEMP"])
  reg(paste0(chave, "_r2adj"), summary(mu_)$adj.r.squared)
  reg(paste0(chave, "_se_k"), sqrt(V["LK", "LK"])); reg(paste0(chave, "_se_l"), sqrt(V["LL", "LL"]))
  reg(paste0(chave, "_cov_kl"), V["LK", "LL"])
  reg(paste0(chave, "_tcrit"), qt(0.975, n - 4))
  mu_
}
m70 <- cobb(1970, "produc_1970.txt", "produc_1970_restrito.txt", "crs70")
m86 <- cobb(1986, "produc_1986.txt", "produc_1986_restrito.txt", "crs86")
# Testes de especificação para 1986
tab_86 <- rbind(lin_htest("RESET (ŷ² e ŷ³)", resettest(m86, power = 2:3, type = "fitted")),
                lin_htest("Breusch-Pagan (Koenker)", bptest(m86)), white(m86),
                lin_htest("Jarque-Bera (resíduos)", jarque.bera.test(resid(m86))))
salva(saida_testes(tab_86, imprimir = FALSE), "produc_1986_testes.txt")
reg("crs86_reset", tab_86$estatistica[1]); reg("crs86_reset_p", tab_86$p[1])
reg("crs86_reset_Fcrit", qf(0.95, 2, 48 - 4 - 2))
reg("crs86_bp", tab_86$estatistica[2]); reg("crs86_bp_p", tab_86$p[2])
reg("crs86_white", tab_86$estatistica[3]); reg("crs86_white_p", tab_86$p[3]); reg("crs86_white_gl", as.numeric(tab_86$gl[3]))
reg("crs86_white_crit", qchisq(0.95, as.numeric(tab_86$gl[3])))
reg("crs86_jb", tab_86$estatistica[4]); reg("crs86_jb_p", tab_86$p[4])
# Chow 1970 x 1986 via interações com D86
pc2 <- subset(prod, ANO %in% c(1970, 1986))
pc2$D86 <- as.numeric(pc2$ANO == 1986)
pc2$D86_LK <- pc2$D86 * pc2$LK; pc2$D86_LL <- pc2$D86 * pc2$LL; pc2$D86_UNEMP <- pc2$D86 * pc2$UNEMP
chr <- lm(LGSP ~ LK + LL + UNEMP, data = pc2)
chu <- lm(LGSP ~ LK + LL + UNEMP + D86 + D86_LK + D86_LL + D86_UNEMP, data = pc2)
salva(c(saida_nlogit(chu, lhs = "LGSP", nomes = c(D86_LK = "D86·LK", D86_LL = "D86·LL", D86_UNEMP = "D86·UNEMP"),
                     dig_p_F = 4, imprimir = FALSE), "",
        "Modelo restrito (1970 e 1986 empilhados, sem D86 e sem interações): LGSP ~ LK + LL + UNEMP",
        paste0("Soma dos quadrados dos resíduos = ", .nl_sig(sum(resid(chr)^2)),
               "   Parâmetros = 4   Observações = ", nobs(chr))),
      "produc_chow.txt")
s_chr <- sum(resid(chr)^2); s_chu <- sum(resid(chu)^2)
confere(s_chu, sum(resid(m70)^2) + sum(resid(m86)^2), "SQR com interações = SQR 1970 + SQR 1986")
F_ch <- ((s_chr - s_chu) / 4) / (s_chu / (96 - 8))
reg("pchow_ssr_r", s_chr); reg("pchow_ssr_u", s_chu); reg("pchow_F", F_ch)
reg("pchow_p", pf(F_ch, 4, 88, lower.tail = FALSE)); reg("pchow_Fcrit", qf(0.95, 4, 88))
reg("pchow_b_d86", coef(chu)["D86"]); reg("pchow_t_d86_lk", coef(summary(chu))["D86_LK", 3])

## ---- G. mroz: MQ2E (simulado 01) e caso exatamente identificado (banco) ----
data("mroz", package = "wooldridge")
mz <- subset(mroz, inlf == 1)
mzd <- with(mz, data.frame(LWAGE = lwage, EDUC = educ, EXPER = exper, EXPERSQ = expersq,
                           MOTHEDUC = motheduc, FATHEDUC = fatheduc))
iv_m <- ivreg(LWAGE ~ EDUC + EXPER + EXPERSQ | EXPER + EXPERSQ + MOTHEDUC + FATHEDUC, data = mzd)
salva(saida_mq2e(iv_m, lhs = "LWAGE", imprimir = FALSE), "mroz_mq2e.txt")
ols_m <- lm(LWAGE ~ EDUC + EXPER + EXPERSQ, data = mzd)
salva(saida_nlogit(ols_m, lhs = "LWAGE", imprimir = FALSE), "mroz_mqo.txt")
sim <- summary(iv_m, diagnostics = TRUE); dgm <- sim$diagnostics
z_educ <- coef(sim)["EDUC", 3]
reg("mroz_n", nobs(iv_m)); reg("mroz_iv_b_educ", coef(iv_m)["EDUC"]); reg("mroz_iv_se_educ", coef(sim)["EDUC", 2])
reg("mroz_iv_z_educ", z_educ); reg("mroz_iv_p_educ", 2 * pnorm(-abs(z_educ)))
reg("mroz_iv_educ_exato", 100 * (exp(coef(iv_m)["EDUC"]) - 1))
reg("mroz_mqo_b_educ", coef(ols_m)["EDUC"]); reg("mroz_mqo_se_educ", coef(summary(ols_m))["EDUC", 2])
reg("mroz_weak", dgm[1, 3]); reg("mroz_weak_df2", dgm[1, 2]); reg("mroz_wh", dgm[2, 3]); reg("mroz_wh_p", dgm[2, 4])
reg("mroz_sargan", dgm[3, 3]); reg("mroz_sargan_p", dgm[3, 4])
reg("mroz_iv_expstar", -coef(iv_m)["EXPER"] / (2 * coef(iv_m)["EXPERSQ"]))
reg("mroz_iv_ic_educ_inf", coef(iv_m)["EDUC"] - 1.645 * coef(sim)["EDUC", 2])
reg("mroz_iv_ic_educ_sup", coef(iv_m)["EDUC"] + 1.645 * coef(sim)["EDUC", 2])
# 1º estágio (para ligar o "Weak instruments" ao F do 1º estágio)
fs_m <- lm(EDUC ~ EXPER + EXPERSQ + MOTHEDUC + FATHEDUC, data = mzd)
confere(linearHypothesis(fs_m, c("MOTHEDUC = 0", "FATHEDUC = 0"))$F[2], dgm[1, 3], "Weak = F do 1º estágio (mroz)", 1e-6)
reg("mroz_fs_b_moth", coef(fs_m)["MOTHEDUC"]); reg("mroz_fs_b_fath", coef(fs_m)["FATHEDUC"])
# Exatamente identificado: só FATHEDUC
iv_f <- ivreg(LWAGE ~ EDUC + EXPER + EXPERSQ | EXPER + EXPERSQ + FATHEDUC, data = mzd)
salva(saida_ivreg_r(iv_f, imprimir = FALSE), "mroz_ivreg_fatheduc.txt")
sif <- summary(iv_f, diagnostics = TRUE); dgf <- sif$diagnostics
fs_f <- lm(EDUC ~ EXPER + EXPERSQ + FATHEDUC, data = mzd)
t_fath <- coef(summary(fs_f))["FATHEDUC", 3]
confere(t_fath^2, dgf[1, 3], "Weak (1 instrumento) = t² do 1º estágio", 1e-6)
reg("mrozf_b_educ", coef(iv_f)["EDUC"]); reg("mrozf_se_educ", coef(sif)["EDUC", 2])
reg("mrozf_weak", dgf[1, 3]); reg("mrozf_t_fs", t_fath); reg("mrozf_wh", dgf[2, 3]); reg("mrozf_wh_p", dgf[2, 4])
# VI escalar como razão de covariâncias (sem controles): b_IV = Cov(z, y)/Cov(z, x)
reg("mrozf_wald_simples", cov(mzd$FATHEDUC, mzd$LWAGE) / cov(mzd$FATHEDUC, mzd$EDUC))
confere(cov(mzd$FATHEDUC, mzd$LWAGE) / cov(mzd$FATHEDUC, mzd$EDUC),
        coef(ivreg(LWAGE ~ EDUC | FATHEDUC, data = mzd))["EDUC"], "VI simples = Cov(z,y)/Cov(z,x)", 1e-10)

## ---- H. injury (Meyer, Viscusi e Durbin): DiD em Kentucky ----
data("injury", package = "wooldridge")
inj <- subset(injury, ky == 1)
injd <- with(inj, data.frame(LDURAT = ldurat, AFCHNGE = afchnge, HIGHEARN = highearn, AFHIGH = afchnge * highearn))
mi <- lm(LDURAT ~ AFCHNGE + HIGHEARN + AFHIGH, data = injd)
salva(saida_nlogit(mi, lhs = "LDURAT", imprimir = FALSE), "injury_did.txt")
smi <- summary(mi)
reg("inj_n", nobs(mi)); reg("inj_b_did", coef(mi)["AFHIGH"]); reg("inj_se_did", coef(smi)["AFHIGH", 2])
reg("inj_t_did", coef(smi)["AFHIGH", 3]); reg("inj_did_exato", 100 * (exp(coef(mi)["AFHIGH"]) - 1))
reg("inj_r2", smi$r.squared); reg("inj_b_af", coef(mi)["AFCHNGE"]); reg("inj_b_high", coef(mi)["HIGHEARN"])
# DiD pelas quatro médias
mm <- with(injd, tapply(LDURAT, list(HIGHEARN, AFCHNGE), mean))
did_medias <- (mm["1", "1"] - mm["1", "0"]) - (mm["0", "1"] - mm["0", "0"])
confere(did_medias, coef(mi)["AFHIGH"], "DiD = diferença das diferenças de médias", 1e-10)
reg("inj_m00", mm["0", "0"]); reg("inj_m01", mm["0", "1"]); reg("inj_m10", mm["1", "0"]); reg("inj_m11", mm["1", "1"])

## ---- I. wage1 (simulado 01, Q1) ----
data("wage1", package = "wooldridge")
w1 <- with(wage1, data.frame(LWAGE = lwage, EDUC = educ, EXPER = exper, EXPERSQ = expersq, TENURE = tenure,
                             FEMALE = female, MARRIED = married, NONWHITE = nonwhite))
mw <- lm(LWAGE ~ EDUC + EXPER + EXPERSQ + TENURE + FEMALE + MARRIED + NONWHITE, data = w1)
jb_w <- jarque.bera.test(resid(mw))
salva(c(saida_nlogit(mw, lhs = "LWAGE", dig_p_F = 4, imprimir = FALSE), "",
        saida_testes(lin_htest("Jarque-Bera (resíduos)", jb_w), imprimir = FALSE)), "wage1_mqo.txt")
smw <- summary(mw); bw <- coef(mw); Vw <- vcov(mw)
reg("s1_n", nobs(mw)); reg("s1_r2", smw$r.squared); reg("s1_r2adj", smw$adj.r.squared)
reg("s1_F", smw$fstatistic[1]); reg("s1_Fcrit", qf(0.95, 7, nobs(mw) - 8))
reg("s1_jb", jb_w$statistic); reg("s1_jb_p", jb_w$p.value)
reg("s1_b_educ", bw["EDUC"]); reg("s1_se_educ", sqrt(Vw["EDUC", "EDUC"]))
reg("s1_ic_educ_inf", bw["EDUC"] - 1.96 * sqrt(Vw["EDUC", "EDUC"]))
reg("s1_ic_educ_sup", bw["EDUC"] + 1.96 * sqrt(Vw["EDUC", "EDUC"]))
reg("s1_b_tenure", bw["TENURE"]); reg("s1_t_tenure", coef(smw)["TENURE", 3])
reg("s1_t_married", coef(smw)["MARRIED", 3]); reg("s1_t_nonwhite", coef(smw)["NONWHITE", 3])
reg("s1_b_married", bw["MARRIED"]); reg("s1_b_nonwhite", bw["NONWHITE"])
reg("s1_b_exper", bw["EXPER"]); reg("s1_b_expersq", bw["EXPERSQ"])
es1 <- -bw["EXPER"] / (2 * bw["EXPERSQ"])
g1 <- c(-1 / (2 * bw["EXPERSQ"]), bw["EXPER"] / (2 * bw["EXPERSQ"]^2))
reg("s1_expstar", es1)
reg("s1_expstar_ep", sqrt(drop(t(g1) %*% Vw[c("EXPER", "EXPERSQ"), c("EXPER", "EXPERSQ")] %*% g1)))
reg("s1_frac_acima", mean(w1$EXPER > es1))
reg("s1_b_female", bw["FEMALE"]); reg("s1_female_aprox", 100 * bw["FEMALE"])
reg("s1_female_exato", 100 * (exp(bw["FEMALE"]) - 1))
reg("s1_efmarg_exper_10", bw["EXPER"] + 2 * bw["EXPERSQ"] * 10)

## ---- J. USMacroG: função consumo keynesiana (simulado 02, Q2) ----
data("USMacroG", package = "AER")
um <- data.frame(CONS = as.numeric(USMacroG[, "consumption"]), PIB = as.numeric(USMacroG[, "gdp"]),
                 INV = as.numeric(USMacroG[, "invest"]), GOV = as.numeric(USMacroG[, "government"]))
um <- um[complete.cases(um), ]
mk <- lm(CONS ~ PIB, data = um)
dw_k <- dwtest(mk); bg_k <- bgtest(mk, order = 4)
salva(c(saida_nlogit(mk, lhs = "CONS", dig_p_F = 4, imprimir = FALSE), "",
        "Dados trimestrais dos EUA, 1950:1 a 2000:4; bilhões de dólares de 1996.",
        saida_testes(rbind(data.frame(teste = "Durbin-Watson", estatistica = unname(dw_k$statistic), gl = "-",
                                      p = dw_k$p.value),
                           lin_htest("Breusch-Godfrey (4 defasagens)", bg_k)), imprimir = FALSE)),
      "usmacro_mqo.txt")
ivk <- ivreg(CONS ~ PIB | INV + GOV, data = um)
salva(saida_ivreg_r(ivk, formula_txt = "CONS ~ PIB | INV + GOV", imprimir = FALSE), "usmacro_ivreg.txt")
sik <- summary(ivk, diagnostics = TRUE); dgk <- sik$diagnostics
reg("s2k_n", nobs(mk)); reg("s2k_mqo_b", coef(mk)["PIB"]); reg("s2k_mqo_se", coef(summary(mk))["PIB", 2])
reg("s2k_dw", dw_k$statistic); reg("s2k_rho_dw", 1 - dw_k$statistic / 2)
reg("s2k_bg", bg_k$statistic); reg("s2k_bg_p", bg_k$p.value); reg("s2k_bg_crit", qchisq(0.95, 4))
reg("s2k_iv_b", coef(ivk)["PIB"]); reg("s2k_iv_se", coef(sik)["PIB", 2]); reg("s2k_iv_t", coef(sik)["PIB", 3])
reg("s2k_weak", dgk[1, 3]); reg("s2k_weak_p", dgk[1, 4]); reg("s2k_wh", dgk[2, 3]); reg("s2k_wh_p", dgk[2, 4])
reg("s2k_sargan", dgk[3, 3]); reg("s2k_sargan_p", dgk[3, 4]); reg("s2k_r2", sik$r.squared)
reg("s2k_mult_mqo", 1 / (1 - coef(mk)["PIB"])); reg("s2k_mult_iv", 1 / (1 - coef(ivk)["PIB"]))
reg("s2k_t_mpc1", (coef(ivk)["PIB"] - 1) / coef(sik)["PIB", 2])

## ---- K. kielmc (DiD e FIV) e card (VI), simulado 03 ----
data("kielmc", package = "wooldridge")
kd <- with(kielmc, data.frame(LRPRICE = lrprice, Y81 = y81, NEARINC = nearinc, Y81NRINC = y81nrinc,
                              AGE = age, AGESQ = agesq, LINTST = lintst, LLAND = lland, LAREA = larea,
                              ROOMS = rooms, BATHS = baths))
mkl <- lm(LRPRICE ~ Y81 + NEARINC + Y81NRINC + AGE + AGESQ + LINTST + LLAND + LAREA + ROOMS + BATHS, data = kd)
aux_k <- lm(AGE ~ Y81 + NEARINC + Y81NRINC + AGESQ + LINTST + LLAND + LAREA + ROOMS + BATHS, data = kd)
r2k <- summary(aux_k)$r.squared
mkl0 <- lm(LRPRICE ~ Y81 + NEARINC + Y81NRINC, data = kd)
salva(c(saida_nlogit(mkl, lhs = "LRPRICE", dig_p_F = 4, imprimir = FALSE), "",
        "Regressão auxiliar: AGE contra os outros 9 regressores (com constante)",
        paste0("  R-quadrado = ", .nl_sig(r2k)),
        "Mesma regressão sem os controles (só Y81, NEARINC, Y81NRINC):",
        paste0("  coeficiente de Y81NRINC = ", .nl_num(coef(mkl0)["Y81NRINC"]),
               "   erro padrão = ", .nl_num(coef(summary(mkl0))["Y81NRINC", 2]))),
      "kielmc_did.txt")
skl <- summary(mkl)
reg("s3k_n", nobs(mkl)); reg("s3k_b_did", coef(mkl)["Y81NRINC"]); reg("s3k_se_did", coef(skl)["Y81NRINC", 2])
reg("s3k_t_did", coef(skl)["Y81NRINC", 3]); reg("s3k_p_did", 2 * pnorm(-abs(coef(skl)["Y81NRINC", 3])))
reg("s3k_did_exato", 100 * (exp(coef(mkl)["Y81NRINC"]) - 1))
reg("s3k_b_nearinc", coef(mkl)["NEARINC"]); reg("s3k_t_nearinc", coef(skl)["NEARINC", 3])
reg("s3k_b_y81", coef(mkl)["Y81"])
reg("s3k_r2adj", skl$adj.r.squared); reg("s3k_r2aux", r2k); reg("s3k_vif_age", 1 / (1 - r2k))
confere(1 / (1 - r2k), car::vif(mkl)["AGE"], "FIV de AGE (kielmc)", 1e-6)
reg("s3k_b_did_sem", coef(mkl0)["Y81NRINC"]); reg("s3k_se_did_sem", coef(summary(mkl0))["Y81NRINC", 2])
reg("s3k_t_did_sem", coef(summary(mkl0))["Y81NRINC", 3])
reg("s3k_agestar", -coef(mkl)["AGE"] / (2 * coef(mkl)["AGESQ"]))

data("card", package = "wooldridge")
cd <- with(card, data.frame(LWAGE = lwage, EDUC = educ, EXPER = exper, EXPERSQ = expersq, BLACK = black,
                            SMSA = smsa, SOUTH = south, NEARC4 = nearc4))
ivcard <- ivreg(LWAGE ~ EDUC + EXPER + EXPERSQ + BLACK + SMSA + SOUTH |
                  NEARC4 + EXPER + EXPERSQ + BLACK + SMSA + SOUTH, data = cd)
olscard <- lm(LWAGE ~ EDUC + EXPER + EXPERSQ + BLACK + SMSA + SOUTH, data = cd)
salva(saida_mq2e(ivcard, lhs = "LWAGE", imprimir = FALSE), "card_mq2e.txt")
salva(saida_nlogit(olscard, lhs = "LWAGE", imprimir = FALSE), "card_mqo.txt")
sic <- summary(ivcard, diagnostics = TRUE); dgc <- sic$diagnostics
reg("s3c_n", nobs(ivcard)); reg("s3c_iv_b_educ", coef(ivcard)["EDUC"]); reg("s3c_iv_se_educ", coef(sic)["EDUC", 2])
reg("s3c_iv_z_educ", coef(sic)["EDUC", 3])
reg("s3c_mqo_b_educ", coef(olscard)["EDUC"]); reg("s3c_mqo_se_educ", coef(summary(olscard))["EDUC", 2])
reg("s3c_weak", dgc[1, 3]); reg("s3c_weak_p", dgc[1, 4]); reg("s3c_wh", dgc[2, 3]); reg("s3c_wh_p", dgc[2, 4])
reg("s3c_razao_se", coef(sic)["EDUC", 2] / coef(summary(olscard))["EDUC", 2])
reg("s3c_ic_educ_inf", coef(ivcard)["EDUC"] - 1.96 * coef(sic)["EDUC", 2])
reg("s3c_ic_educ_sup", coef(ivcard)["EDUC"] + 1.96 * coef(sic)["EDUC", 2])
fs_c <- lm(EDUC ~ NEARC4 + EXPER + EXPERSQ + BLACK + SMSA + SOUTH, data = cd)
reg("s3c_fs_b_nearc4", coef(fs_c)["NEARC4"]); reg("s3c_fs_t_nearc4", coef(summary(fs_c))["NEARC4", 3])
confere(coef(summary(fs_c))["NEARC4", 3]^2, dgc[1, 3], "Weak = t² do 1º estágio (card)", 1e-6)

## ---- L. Valores críticos usados nas respostas ----
reg("chi2_2gl_5", qchisq(0.95, 2)); reg("chi2_5gl_5", qchisq(0.95, 5)); reg("chi2_2gl_10", qchisq(0.90, 2))
reg("z_5", qnorm(0.975)); reg("z_10", qnorm(0.95))

## ---- Fim: lista dos arquivos e gravação ----
esperados <- c("psid_mqo.txt", "psid_mqo_fem_union.txt", "psid_mq2e_wks.txt", "cig_ivreg_robusto.txt",
               "cig_ivreg_classico.txt", "cig_ivreg_robusto_gl.txt", "cig_mqo.txt", "cps_mqo.txt",
               "cps_testes.txt", "cps_mqo_robusto.txt", "cps_chow_genero.txt", "cps_multicol.txt",
               "hprice_mqo.txt", "hprice_testes.txt", "consumo_anual.txt", "produc_1970.txt",
               "produc_1970_restrito.txt", "produc_1986.txt", "produc_1986_restrito.txt",
               "produc_1986_testes.txt", "produc_chow.txt", "mroz_mq2e.txt", "mroz_mqo.txt",
               "mroz_ivreg_fatheduc.txt", "injury_did.txt", "wage1_mqo.txt", "usmacro_mqo.txt",
               "usmacro_ivreg.txt", "kielmc_did.txt", "card_mq2e.txt", "card_mqo.txt")
faltam <- setdiff(esperados, list.files(dir_out))
if (length(faltam)) stop("Outputs não gerados: ", paste(faltam, collapse = ", "))
cat("\nOutputs gerados em provas/banco/outputs/:", length(arquivos), "\n")

tab <- .resultados$tab
cat("\n--- Resultados registrados (", length(tab), ") ---\n", sep = "")
for (k in names(tab)) cat(sprintf("%-26s %s\n", k, formatC(tab[[k]], digits = 10, format = "g")))
gravar_resultados("bnc")
