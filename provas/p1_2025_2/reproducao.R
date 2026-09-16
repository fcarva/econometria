# Reprodução da P1 2025/2 (id prv)
#
# O que este script faz:
#   Q1. Reproduz o output de MQO da Questão 1 (LWAGE; dados de Cornwell e Rupert) com
#       AER::PSID7682 e confere R², R² ajustado, SQR, s, F, os 10 coeficientes e os 10 erros
#       padrão contra a foto da prova (materiais/provas, id P1-25). O arquivo do Greene guarda
#       LWAGE com 5 casas decimais; com esse arredondamento tudo bate na última casa impressa.
#       Calcula as contas das respostas: EXP* = -a3/(2 a4) com erro padrão pelo método delta,
#       IC de 95% de ED, efeito percentual exato de SOUTH, Jarque-Bera dos resíduos.
#   Q2. Reproduz o ivreg da demanda por cigarros (Stock e Watson; AER::CigarettesSW, 1995)
#       com matriz robusta (sandwich, df = Inf), que é a versão impressa na Lista 1, ex. 67,
#       e com a matriz clássica. Reconstrói à mão as três estatísticas de diagnóstico:
#       Weak instruments = F do 1º estágio; Wu-Hausman = teste do resíduo do 1º estágio
#       na regressão aumentada; Sargan = n·R² dos resíduos de VI contra os instrumentos.
#
# Rodar: powershell -ExecutionPolicy Bypass -File scripts\r.ps1 provas\p1_2025_2\reproducao.R

# --- bootstrap: localizar a raiz do repo e carregar helpers ---
.d <- getwd(); while (!file.exists(file.path(.d, ".repo-root")) && dirname(.d) != .d) .d <- dirname(.d)
source(file.path(.d, "R", "raiz.R"))

suppressPackageStartupMessages({
  library(AER); library(sandwich); library(lmtest); library(car); library(tseries); library(moments)
})

# Para (status != 0) se um número não bater com o impresso na prova
confere <- function(a, b, rotulo, tol) {
  a <- unname(a)
  if (abs(a - b) > tol) stop("Não bateu com a prova: ", rotulo, " | R = ", signif(a, 10), " vs impresso = ", b)
  invisible(TRUE)
}

## ---- Q1: output de MQO (PSID7682 = Cornwell e Rupert) ----
data("PSID7682", package = "AER")
psid <- with(PSID7682, data.frame(
  LWAGE = round(log(wage), 5),              # 5 casas, como no arquivo do Greene
  ED = education, EXP = experience, EXP2 = experience^2,
  OCC = as.numeric(occupation == "blue"),   # 1 = colarinho azul
  IND = as.numeric(industry == "yes"),
  SOUTH = as.numeric(south == "yes"),
  SMSA = as.numeric(smsa == "yes"),
  BLK = as.numeric(ethnicity == "afam"),
  WKS = weeks))

m1 <- lm(LWAGE ~ ED + EXP + EXP2 + OCC + IND + SOUTH + SMSA + BLK + WKS, data = psid)
cat("\n=== P1 2025/2, Questão 1: reprodução do output ===\n")
saida_nlogit(m1, lhs = "LWAGE", nomes = c(EXP2 = "EXP²"))

s1 <- summary(m1)
n1 <- nobs(m1); K1 <- length(coef(m1))
ssr1 <- sum(resid(m1)^2)
F1 <- unname(s1$fstatistic[1])
b1 <- coef(m1); se1 <- sqrt(diag(vcov(m1)))

# Números impressos na foto da prova
confere(s1$r.squared, 0.3446066, "R²", 5e-8)
confere(s1$adj.r.squared, 0.3431870, "R² ajustado", 5e-8)
confere(ssr1, 581.2717, "SQR", 5e-5)
confere(s1$sigma, 0.3740280, "s", 5e-8)
confere(F1, 242.74, "F", 5e-3)
confere(mean(psid$LWAGE), 6.676346, "média de LWAGE", 5e-7)
confere(sd(psid$LWAGE), 0.4615122, "desvio padrão de LWAGE", 5e-8)
b_foto  <- c(5.13171052, 0.06112766, 0.04291665, -0.00070803, -0.07814434,
             0.09066812, -0.07629062, 0.13789225, -0.26269494, 0.00484184)
se_foto <- c(0.07238152, 0.00277226, 0.00229783, 0.506204e-04, 0.01502100,
             0.01247863, 0.01318346, 0.01278553, 0.02304380, 0.00113470)
for (j in seq_along(b_foto)) {
  confere(b1[j], b_foto[j], paste("coeficiente", names(b1)[j]), 5e-9)
  confere(se1[j], se_foto[j], paste("erro padrão", names(b1)[j]), if (j == 4) 5e-11 else 5e-9)
}
cat("\nConferência: R², R² ajustado, SQR, s, F, média e DP de LWAGE, 10 coeficientes e 10 erros padrão batem com a foto.\n")

registrar_varios(c(prv_q1_n = n1, prv_q1_K = K1, prv_q1_gl = n1 - K1,
                   prv_q1_r2 = s1$r.squared, prv_q1_r2adj = s1$adj.r.squared,
                   prv_q1_ssr = ssr1, prv_q1_s = s1$sigma, prv_q1_F = F1,
                   prv_q1_ymedia = mean(psid$LWAGE), prv_q1_ydp = sd(psid$LWAGE)))

# (a) Jarque-Bera dos resíduos: com n = 4165 a normalidade é rejeitada, e isso não importa
jb1 <- jarque.bera.test(resid(m1))
registrar("prv_q1_jb", unname(jb1$statistic))
registrar("prv_q1_jb_p", jb1$p.value)
registrar("prv_q1_assimetria", skewness(resid(m1)))
registrar("prv_q1_curtose", kurtosis(resid(m1)))

# (b) teste t de EXP
t_exp <- b1["EXP"] / se1["EXP"]
registrar("prv_q1_b_exp", b1["EXP"]); registrar("prv_q1_se_exp", se1["EXP"])
registrar("prv_q1_t_exp", t_exp)
registrar("prv_q1_p_exp", 2 * pnorm(-abs(t_exp)))

# (c) ponto de máximo EXP* = -a3/(2 a4) e erro padrão pelo método delta
a3 <- unname(b1["EXP"]); a4 <- unname(b1["EXP2"])
exp_star <- -a3 / (2 * a4)
grad <- c(-1 / (2 * a4), a3 / (2 * a4^2))          # derivadas de g(a3, a4) = -a3/(2 a4)
V34 <- vcov(m1)[c("EXP", "EXP2"), c("EXP", "EXP2")]
ep_star <- sqrt(drop(t(grad) %*% V34 %*% grad))
registrar("prv_q1_b_exp2", a4)
registrar("prv_q1_expstar", exp_star)
registrar("prv_q1_expstar_foto", -0.04291665 / (2 * -0.00070803))   # com os números impressos
registrar("prv_q1_expstar_ep", ep_star)
registrar("prv_q1_expstar_ic_inf", exp_star - 1.96 * ep_star)
registrar("prv_q1_expstar_ic_sup", exp_star + 1.96 * ep_star)
registrar("prv_q1_exp_max_amostra", max(psid$EXP))
registrar("prv_q1_frac_acima_pico", mean(psid$EXP > exp_star))
# efeito marginal de EXP na média amostral (19,85 anos)
registrar("prv_q1_efmarg_exp_media", a3 + 2 * a4 * mean(psid$EXP))

# (d) IC de 95% para ED com z = 1,96 (números impressos)
registrar("prv_q1_b_ed", b1["ED"]); registrar("prv_q1_se_ed", se1["ED"])
registrar("prv_q1_ic_ed_inf", 0.06112766 - 1.96 * 0.00277226)
registrar("prv_q1_ic_ed_sup", 0.06112766 + 1.96 * 0.00277226)

# (e) SOUTH: aproximação 100·a7 e efeito exato 100·(exp(a7) - 1)
a7 <- unname(b1["SOUTH"])
registrar("prv_q1_b_south", a7)
registrar("prv_q1_south_aprox", 100 * a7)
registrar("prv_q1_south_exato", 100 * (exp(a7) - 1))
registrar("prv_q1_south_kennedy", 100 * (exp(a7 - 0.5 * se1["SOUTH"]^2) - 1))

# (f) R² ajustado em porcentagem
registrar("prv_q1_r2adj_pct", 100 * s1$adj.r.squared)

## ---- Q2: ivreg da demanda por cigarros (CigarettesSW, 1995) ----
data("CigarettesSW", package = "AER")
cig <- subset(CigarettesSW, year == "1995")
cig$rprice  <- cig$price / cig$cpi
cig$rincome <- cig$income / cig$population / cig$cpi
cig$tdiff   <- (cig$taxs - cig$tax) / cig$cpi

iv2 <- ivreg(log(packs) ~ log(rprice) + log(rincome) | log(rincome) + tdiff + I(tax/cpi), data = cig)
rot <- c("(Intercept)" = "(Intercepto)", "log(rprice)" = "log(preço)", "log(rincome)" = "log(renda)")

cat("\n=== Q2: versão robusta (vcov = sandwich, df = Inf), a da Lista 1, ex. 67 ===\n")
saida_ivreg_r(iv2, vcov. = sandwich, df = Inf, rotulos = rot)
cat("\n=== Q2: versão clássica (sem sandwich) ===\n")
saida_ivreg_r(iv2, rotulos = rot)

sr <- summary(iv2, vcov. = sandwich, df = Inf, diagnostics = TRUE)
sc <- summary(iv2, diagnostics = TRUE)
dr <- sr$diagnostics; dc <- sc$diagnostics

registrar_varios(c(
  prv_q2_n = nobs(iv2),
  prv_q2_b_const = coef(iv2)[1], prv_q2_b_preco = coef(iv2)[2], prv_q2_b_renda = coef(iv2)[3],
  prv_q2_rob_se_preco = sr$coefficients[2, 2], prv_q2_rob_se_renda = sr$coefficients[3, 2],
  prv_q2_rob_z_preco = sr$coefficients[2, 3], prv_q2_rob_z_renda = sr$coefficients[3, 3],
  prv_q2_rob_p_renda = sr$coefficients[3, 4],
  prv_q2_cla_se_preco = sc$coefficients[2, 2],
  prv_q2_rob_weak = dr[1, 3], prv_q2_rob_wh = dr[2, 3], prv_q2_rob_wh_p = dr[2, 4],
  prv_q2_rob_sargan = dr[3, 3], prv_q2_rob_sargan_p = dr[3, 4],
  prv_q2_cla_weak = dc[1, 3], prv_q2_cla_wh = dc[2, 3], prv_q2_cla_wh_p = dc[2, 4],
  prv_q2_cla_sargan = dc[3, 3], prv_q2_cla_sargan_p = dc[3, 4],
  prv_q2_df2 = dr[1, 2],
  prv_q2_r2 = sr$r.squared, prv_q2_r2adj = sr$adj.r.squared,
  prv_q2_wald = sr$waldtest[1], prv_q2_wald_p = sr$waldtest[2],
  prv_q2_wald_F_cla = sc$waldtest[1],
  prv_q2_chi2_crit_2gl = qchisq(0.95, 2), prv_q2_chi2_crit_5gl = qchisq(0.95, 5)))

# IC de 95% robusto para a elasticidade-preço
registrar("prv_q2_ic_preco_inf", coef(iv2)[2] - 1.96 * sr$coefficients[2, 2])
registrar("prv_q2_ic_preco_sup", coef(iv2)[2] + 1.96 * sr$coefficients[2, 2])

# MQO da mesma equação, para comparar a elasticidade
mqo2 <- lm(log(packs) ~ log(rprice) + log(rincome), data = cig)
registrar("prv_q2_mqo_b_preco", coef(mqo2)[2])

# Reconstrução das três estatísticas de diagnóstico
fs <- lm(log(rprice) ~ log(rincome) + tdiff + I(tax/cpi), data = cig)      # 1º estágio
h0_inst <- c("tdiff = 0", "I(tax/cpi) = 0")
weak_cla <- linearHypothesis(fs, h0_inst)$F[2]
weak_rob <- linearHypothesis(fs, h0_inst, vcov. = sandwich(fs))$F[2]
confere(weak_cla, dc[1, 3], "Weak instruments clássico = F do 1º estágio", 1e-6)
confere(weak_rob, dr[1, 3], "Weak instruments robusto = F robusto do 1º estágio", 1e-6)

cig$v_hat <- resid(fs)
aux <- lm(log(packs) ~ log(rprice) + log(rincome) + v_hat, data = cig)    # regressão aumentada
wh_cla <- coeftest(aux)["v_hat", "t value"]^2
wh_rob <- coeftest(aux, vcov. = sandwich(aux))["v_hat", "t value"]^2
confere(wh_cla, dc[2, 3], "Wu-Hausman clássico = t² do resíduo do 1º estágio", 1e-6)
confere(wh_rob, dr[2, 3], "Wu-Hausman robusto = t² robusto do resíduo do 1º estágio", 1e-6)
registrar("prv_q2_b_vhat", coef(aux)["v_hat"])

u_iv <- resid(iv2)
sargan <- nobs(iv2) * summary(lm(u_iv ~ log(rincome) + tdiff + I(tax/cpi), data = cig))$r.squared
confere(sargan, dc[3, 3], "Sargan = n·R² dos resíduos de VI contra os instrumentos", 1e-6)
registrar("prv_q2_sargan_r2aux", sargan / nobs(iv2))
cat("\nConferência: Weak instruments, Wu-Hausman (clássico e robusto) e Sargan reconstruídos à mão.\n")

gravar_resultados("prv")
