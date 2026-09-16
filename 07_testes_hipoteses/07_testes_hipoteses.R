# --- bootstrap: localizar a raiz do repo e carregar helpers ---
.d <- getwd(); while (!file.exists(file.path(.d, ".repo-root")) && dirname(.d) != .d) .d <- dirname(.d)
source(file.path(.d, "R", "raiz.R"))

# Módulo 07, teoria e interpretação de outputs (id m07b).
# Notas correspondentes: 07_testes_hipoteses/07_teoria.md e 07_testes_hipoteses/07_lista1.md
# Uso: powershell -ExecutionPolicy Bypass -File scripts\r.ps1 07_testes_hipoteses\07_testes_hipoteses.R
#
# Conteúdo:
#   Parte A  valores críticos usados nas notas (qt, qf, qchisq)
#   Ex. 41, 42, 44, 45, 46, 50, 51, 52: números derivados dos outputs impressos na Lista 1
#   Parte T1 tamanho e poder do teste t (simulação x fórmula do t não central)
#   Parte T2 trindade Wald/LR/LM: W >= LR >= LM e taxas de rejeição por n
#   Parte T3 Jarque-Bera: tamanho e poder por n; tamanho do t com erros não normais
#   Parte T4 identidades numéricas (F = t^2, JF = W, LM = nR^2, LR, dualidade IC, DW, BP, BG)
#   Parte T5 omitir variável relevante x incluir variável irrelevante

suppressPackageStartupMessages({
  library(lmtest)   # resettest, bptest, bgtest
})
options(width = 100)

pasta_fig <- caminho_repo("07_testes_hipoteses", "figuras")
dir.create(pasta_fig, showWarnings = FALSE, recursive = TRUE)
fig <- function(nome) file.path(pasta_fig, nome)
secao <- function(txt) cat("\n\n==================== ", txt, " ====================\n", sep = "")

# Registra com o prefixo do script e imprime no console
reg <- function(chave, valor) {
  registrar(paste0("m07b_", chave), as.numeric(valor))
  cat(sprintf("  %-34s %s\n", chave, format(as.numeric(valor), digits = 10)))
  invisible(valor)
}

# Log-verossimilhança normal concentrada (D05.8) e critérios no formato do EViews
lnL_normal <- function(ssr, n) -n / 2 * (1 + log(2 * pi) + log(ssr / n))
crit_eviews <- function(lnL, n, K) c(aic = -2 * lnL / n + 2 * K / n,
                                     sc  = -2 * lnL / n + K * log(n) / n,
                                     hq  = -2 * lnL / n + 2 * K * log(log(n)) / n)

## ---- Parte A: valores críticos ----
secao("Parte A: valores críticos")
reg("qnorm_975",   qnorm(0.975))
reg("qchisq_95_1", qchisq(0.95, 1))      # = 1,96^2: t bilateral com n grande
reg("qt_975_25",   qt(0.975, 25))        # ex. 42 (n - K = 27 - 2)
reg("qt_975_4",    qt(0.975, 4))         # ex. 44 (n - K = 6 - 2)
reg("qt_975_4_quad", qt(0.975, 4)^2)     # = F(1,4) a 5%
reg("qf_95_1_4",   qf(0.95, 1, 4))
reg("qt_975_76",   qt(0.975, 76))        # ex. 46 (n - K = 78 - 2)
reg("qf_95_1_76",  qf(0.95, 1, 76))      # ex. 46g (a lista imprime 3,96)
reg("qf_95_2_10",  qf(0.95, 2, 10))      # ex. 50 (a lista imprime 4,10)
reg("qchisq_90_2", qchisq(0.90, 2))
reg("qchisq_95_2", qchisq(0.95, 2))
reg("qchisq_99_2", qchisq(0.99, 2))      # ex. 46f e ex. 52 (a lista imprime 9,21)
reg("qchisq_95_5", qchisq(0.95, 5))      # o "11,07" da P1 2025/2, Q2f
reg("qt_95_25",    qt(0.95, 25))         # teste unilateral no ex. 42
# chi2(2): P(X > x) = exp(-x/2), então o crítico é -2 ln(alfa)
reg("chi2_2_menos2lnalfa_05", -2 * log(0.05))
# SL07, p. 62: LR = 2(lnL_irrestrito - lnL_restrito), com os dois lnL impressos no slide
reg("sl07_LR", 2 * (830.653 - 809.676))

## ---- Ex. 41 ----
# Lista 1, ex. 41: PIB em função do investimento, n = 27 (output impresso na lista).
secao("Ex. 41: PIB x investimento")
e41 <- list(b1 = -27.23964, se1 = 9.805189, b2 = 107.7422, se2 = 9.581670, r2 = 0.834920, n = 27, K = 2)
with(e41, {
  t1 <- b1 / se1; t2 <- b2 / se2
  reg("ex41_t1", t1)
  reg("ex41_t2", t2)
  reg("ex41_p1", 2 * pt(-abs(t1), n - K))
  reg("ex41_F",  t2^2)                          # F = t^2 na regressão simples
  reg("ex41_r2_via_t", t2^2 / (t2^2 + n - K))   # R^2 = t^2/(t^2 + n - K): confere o output
  reg("ex41_r", sqrt(r2))                       # r = +sqrt(R^2) (sinal de b2)
  reg("ex41_dpib_2", 2 * b2)                    # variação do PIB para +2 no investimento
})

## ---- Ex. 42 ----
secao("Ex. 42: IC e teste t da inclinação do ex. 41")
with(e41, {
  tc <- qt(0.975, n - K)
  reg("ex42_meia_largura", tc * se2)
  reg("ex42_ic_lo", b2 - tc * se2)
  reg("ex42_ic_hi", b2 + tc * se2)
  reg("ex42_ic_z_lo", b2 - qnorm(0.975) * se2)   # versão errada (z no lugar de t): mais estreita
  reg("ex42_ic_z_hi", b2 + qnorm(0.975) * se2)
  reg("ex42_t_100", (b2 - 100) / se2)             # H0: beta2 = 100 (variação de prova)
})

## ---- Ex. 44 ----
# Lista 1, ex. 44: custo total em função da quantidade (output EViews impresso na lista).
secao("Ex. 44: função custo linear")
e44 <- list(b1 = 791.0120, se1 = 225.7354, b2 = 11.06105, se2 = 2.160396,
            r2 = 0.867609, r2a = 0.834511, s = 118.1225, ssr = 55811.69, lnL = -35.92757,
            ybar = 2389.333, sy = 290.3678, Fp = 26.21355, aic = 12.64252, sc = 12.57311,
            dw = 3.071849, tc = 2.776)
with(e44, {
  gl <- Fp * (1 - r2) / r2            # F = R^2 (n-K) / (1-R^2)  =>  n - K
  reg("ex44_gl_impl", gl)
  n <- round(gl) + 2; K <- 2
  reg("ex44_n_impl", n)
  t1 <- b1 / se1; t2 <- b2 / se2
  reg("ex44_t1", t1)
  reg("ex44_t2", t2)
  reg("ex44_p1_recalc", 2 * pt(-abs(t1), n - K))   # o output imprime 0,0365
  reg("ex44_p2_recalc", 2 * pt(-abs(t2), n - K))   # o output imprime 0,0069
  reg("ex44_F_t2", t2^2)
  reg("ex44_Fcrit_tc2", tc^2)
  qbar <- (ybar - b1) / b2                         # a reta passa pelas médias
  reg("ex44_qbar", qbar)
  reg("ex44_elast", b2 * qbar / ybar)
  reg("ex44_elast_alt", 1 - b1 / ybar)
  reg("ex44_ic_lo", b2 - tc * se2)
  reg("ex44_ic_hi", b2 + tc * se2)
  # auditoria do output: tudo sai de SQR, n, K e S.D. dependent var
  sqt_sy <- (n - 1) * sy^2; sqt_r2 <- ssr / (1 - r2); sqe <- sqt_r2 - ssr
  reg("ex44_s_recalc", sqrt(ssr / (n - K)))
  reg("ex44_r2a_recalc", 1 - (1 - r2) * (n - 1) / (n - K))
  reg("ex44_sqt_sy", sqt_sy)
  reg("ex44_sqt_r2", sqt_r2)
  reg("ex44_sqe", sqe)
  reg("ex44_F_anova", sqe / (ssr / (n - K)))
  l <- lnL_normal(ssr, n); cr <- crit_eviews(l, n, K)
  reg("ex44_lnL_recalc", l)
  reg("ex44_aic_recalc", cr["aic"])
  reg("ex44_sc_recalc", cr["sc"])
  reg("ex44_hq_recalc", cr["hq"])
  reg("ex44_jb_p", pchisq(1.53, 2, lower.tail = FALSE))   # JB = 1,53 do enunciado
  reg("ex44_rho_dw", 1 - dw / 2)                          # DW ~ 2(1 - rho)
})

## ---- Ex. 45 ----
# Lista 1, ex. 45: log do custo em função do tempo (log-lin) e do log da quantidade (log-log).
secao("Ex. 45: log-lin e log-log")
reg("ex45_ln_intercepto", log(68.72))            # intercepto em log (antes do antilog)
reg("ex45_pct_exato", 100 * (exp(0.056) - 1))    # crescimento anual exato
reg("ex45_t_ano", 0.056 / 0.003)
reg("ex45_anos_dobrar", log(2) / 0.056)
reg("ex45b_ct_q1", exp(0.857))                   # custo previsto quando Q = 1
reg("ex45b_pct10", 100 * (1.1^0.246 - 1))        # +10% em Q, variação exata do custo

## ---- Ex. 46 ----
# Lista 1, ex. 46: log(PIB) em log(CRED), 78 municípios do ES, 2008 (output EViews impresso).
secao("Ex. 46: PIB x crédito, log-log")
e46 <- list(b1 = 4.664838, se1 = 0.702390, b2 = 0.727858, se2 = 0.069224, tp2 = 10.51451,
            r2 = 0.633353, r2a = 0.627624, ybar = 11.98305, sy = 1.257397, s = 0.767296,
            ssr = 37.67959, lnL = -75.15225, Fp = 110.5550, aic = 2.337947, sc = 2.404300,
            hq = 2.364166, n = 78, K = 2, S = -0.883473, Ku = 3.321874, jb_lista = 18.870682)
with(e46, {
  reg("ex46_exp_b1", exp(b1))                    # PIB previsto quando CRED = 1 (log CRED = 0)
  reg("ex46_pct10", 100 * (1.1^b2 - 1))          # +10% no crédito, variação exata do PIB
  t2 <- b2 / se2
  reg("ex46_t2", t2)
  reg("ex46_ic_lo", b2 - 1.96 * se2)
  reg("ex46_ic_hi", b2 + 1.96 * se2)
  # f) Jarque-Bera recalculado a partir da assimetria e da curtose impressas
  jb_sk <- n * (S^2 / 6 + (Ku - 3)^2 / 24)
  reg("ex46_jb_parte_S", n * S^2 / 6)
  reg("ex46_jb_parte_K", n * (Ku - 3)^2 / 24)
  reg("ex46_jb_sk", jb_sk)
  reg("ex46_jb_sk_p", pchisq(jb_sk, 2, lower.tail = FALSE))
  reg("ex46_jb_lista_p", pchisq(jb_lista, 2, lower.tail = FALSE))
  # g) ANOVA a partir de SQR e R^2 (os números usados na chave)
  sqt <- ssr / (1 - r2); sqe <- sqt - ssr; qmres <- ssr / (n - K); Fan <- sqe / qmres
  reg("ex46_sqt", sqt)
  reg("ex46_sqe", sqe)
  reg("ex46_qmres", qmres)
  reg("ex46_F_anova", Fan)
  reg("ex46_F_r2", r2 / (1 - r2) * (n - K))
  reg("ex46_t2_quad", t2^2)                      # = F impresso (110,555)
  # auditoria: outras rotas para os mesmos objetos dão números diferentes
  reg("ex46_sqt_sy", (n - 1) * sy^2)
  reg("ex46_ssr_s", (n - K) * s^2)
  reg("ex46_r2_via_t", t2^2 / (t2^2 + n - K))
  reg("ex46_r2_via_r2a", 1 - (1 - r2a) * (n - K) / (n - 1))
  reg("ex46_r2_via_sy_s", 1 - (n - K) * s^2 / ((n - 1) * sy^2))
  reg("ex46_lnL_ssr", lnL_normal(ssr, n))
  reg("ex46_aic_do_lnL", crit_eviews(lnL, n, K)["aic"])
  # h) elasticidade do modelo linear no ponto CRED = 1.000.000
  cred <- 1e6; pib <- 15e6 + 25 * cred
  reg("ex46h_pib", pib)
  reg("ex46h_elast", 25 * cred / pib)
})

## ---- Ex. 50 ----
# Lista 1, ex. 50: RESET com F = 2,284568 e p = 0,20267; F tabelado impresso 4,10.
secao("Ex. 50: RESET")
reg("ex50_p_2_10", pf(2.284568, 2, 10, lower.tail = FALSE))  # gl compatíveis com o crítico 4,10

## ---- Ex. 51 ----
# Simulação ilustrativa: modelo verdadeiro quadrático (b1 > 0, b2 < 0, b3 > 0) e reta ajustada.
secao("Ex. 51: quadrática verdadeira x reta")
set.seed(7051)
n51 <- 100; beta51 <- c(20, -4, 0.4); sig51 <- 2
X51 <- sort(runif(n51, 0, 8)); X51q <- X51^2
aux51 <- coef(lm(X51q ~ X51))                   # regressão auxiliar de X^2 em (1, X)
mu51 <- beta51[1] + beta51[2] * X51 + beta51[3] * X51q
A51 <- solve(crossprod(cbind(1, X51)), t(cbind(1, X51)))
R51 <- 5000
B51 <- A51 %*% (mu51 + matrix(rnorm(n51 * R51, 0, sig51), n51, R51))
reg("ex51_d", aux51[2])
reg("ex51_b2_teorico", beta51[2] + beta51[3] * aux51[2])
reg("ex51_b2_medio_sim", mean(B51[2, ]))
reg("ex51_b1_teorico", beta51[1] + beta51[3] * aux51[1])
reg("ex51_b1_medio_sim", mean(B51[1, ]))
reg("ex51_xbar", mean(X51))
reg("ex51_derivada_media", beta51[2] + 2 * beta51[3] * mean(X51))
y51 <- mu51 + rnorm(n51, 0, sig51)
m51c <- lm(y51 ~ X51); m51v <- lm(y51 ~ X51 + I(X51^2))
rs51 <- resettest(m51c, power = 2:3, type = "fitted")
reg("ex51_reset_F", rs51$statistic)
reg("ex51_reset_p", rs51$p.value)
png(fig("07b_ex51_quadratica.png"), width = 1600, height = 1000, res = 200)
par(mar = c(4.2, 4.2, 3, 1))
plot(X51, y51, pch = 16, col = "grey60", cex = 0.8, xlab = "X", ylab = "Y",
     main = "Ex. 51: quadrática verdadeira (Linha 1) × reta ajustada (Linha 2)")
xs <- seq(0, 8, length.out = 200)
lines(xs, beta51[1] + beta51[2] * xs + beta51[3] * xs^2, lwd = 3, col = "navy")
abline(m51c, lwd = 3, col = "firebrick", lty = 2)
legend("top", bty = "n", lwd = 3, lty = c(1, 2), col = c("navy", "firebrick"),
       legend = c("Linha 1: E[Y|X] = 20 - 4X + 0,4X² (bem especificado)",
                  "Linha 2: reta de MQO sem X² (mal especificado)"), cex = 0.8)
dev.off()

## ---- Ex. 52 ----
# Lista 1, ex. 52: LM (nR^2 da auxiliar) = 5,28 com J = 2 termos adicionados (X^2 e X^3).
secao("Ex. 52: teste LM")
reg("ex52_p", pchisq(5.28, 2, lower.tail = FALSE))

## ---- Parte T1: tamanho e poder do teste t ----
secao("T1: tamanho e poder do teste t (n = 20)")
set.seed(7001)
poder_sim <- function(n, bgrid, R, gera_erro) {
  x <- rnorm(n); X <- cbind(1, x); XtXi <- solve(crossprod(X)); A <- XtXi %*% t(X)
  crit <- qt(0.975, n - 2)
  taxa <- sapply(bgrid, function(b) {
    Y <- as.vector(X %*% c(1, b)) + gera_erro(n * R, n, R)
    B <- A %*% Y; U <- Y - X %*% B
    s2 <- colSums(U^2) / (n - 2)
    mean(abs(B[2, ] / sqrt(s2 * XtXi[2, 2])) > crit)
  })
  list(taxa = taxa, sd_b2 = sqrt(XtXi[2, 2]), crit = crit)
}
erro_normal <- function(m, n, R) matrix(rnorm(m), n, R)
erro_exp    <- function(m, n, R) matrix(rexp(m) - 1, n, R)   # assimétrico, média 0, variância 1
bgrid <- seq(0, 1.2, by = 0.1)
p20 <- poder_sim(20, bgrid, 4000, erro_normal)
poder_teo <- function(b, sd_b2, n) {
  crit <- qt(0.975, n - 2); ncp <- b / sd_b2
  1 - pt(crit, n - 2, ncp = ncp) + pt(-crit, n - 2, ncp = ncp)
}
teo20 <- poder_teo(bgrid, p20$sd_b2, 20)
reg("sim_t_tamanho_n20", p20$taxa[1])
reg("sim_t_poder05_n20", p20$taxa[bgrid == 0.5])
reg("teo_t_poder05_n20", teo20[bgrid == 0.5])
reg("sim_t_poder10_n20", p20$taxa[abs(bgrid - 1) < 1e-9])
reg("teo_t_poder10_n20", teo20[abs(bgrid - 1) < 1e-9])
reg("sd_b2_n20", p20$sd_b2)
set.seed(7011)
p60 <- poder_sim(60, bgrid, 4000, erro_normal)
reg("sim_t_poder05_n60", p60$taxa[bgrid == 0.5])
png(fig("07b_tamanho_poder.png"), width = 1600, height = 1000, res = 200)
par(mar = c(4.2, 4.2, 3, 1))
bfino <- seq(0, 1.2, length.out = 200)
plot(bfino, poder_teo(bfino, p20$sd_b2, 20), type = "l", lwd = 2.5, col = "navy", ylim = c(0, 1),
     xlab = expression("valor verdadeiro de " * beta[2]), ylab = "P(rejeitar H0)",
     main = "Função poder do teste t bilateral de H0: β2 = 0 (α = 5%)")
points(bgrid, p20$taxa, pch = 16, col = "navy")
lines(bfino, poder_teo(bfino, p60$sd_b2, 60), lwd = 2.5, col = "darkorange")
points(bgrid, p60$taxa, pch = 17, col = "darkorange")
abline(h = 0.05, lty = 2, col = "grey40")
text(1.05, 0.09, "tamanho = 5%", col = "grey30", cex = 0.8)
legend("right", bty = "n", lwd = 2.5, pch = c(16, 17), col = c("navy", "darkorange"),
       legend = c("n = 20 (linha: t não central; pontos: simulação)",
                  "n = 60 (linha: t não central; pontos: simulação)"), cex = 0.8)
dev.off()

## ---- Parte T2: trindade Wald, LR, LM ----
secao("T2: trindade W >= LR >= LM (J = 2, K = 4)")
set.seed(7002)
trindade <- function(n, R, K = 4, J = 2) {
  X <- cbind(1, matrix(rnorm(n * (K - 1)), n, K - 1)); Xr <- X[, 1:(K - J)]
  E <- matrix(rnorm(n * R), n, R)
  Y <- as.vector(Xr %*% c(1, 0.5)) + E                 # H0 verdadeira: beta3 = beta4 = 0
  ssr <- function(Z) colSums((Y - Z %*% solve(crossprod(Z), crossprod(Z, Y)))^2)
  eu <- ssr(X); er <- ssr(Xr); r <- er / eu
  W <- n * (r - 1); LR <- n * log(r); LM <- n * (1 - 1 / r)
  Fs <- (er - eu) / J / (eu / (n - K))
  cc <- qchisq(0.95, J)
  c(W = mean(W > cc), LR = mean(LR > cc), LM = mean(LM > cc), F = mean(Fs > qf(0.95, J, n - K)),
    ordem = mean(W >= LR & LR >= LM))
}
ns_tr <- c(15, 30, 60, 200)
tab_tr <- sapply(ns_tr, trindade, R = 4000)
colnames(tab_tr) <- paste0("n", ns_tr); print(round(tab_tr, 4))
for (nm in colnames(tab_tr)) {
  reg(paste0("sim_trind_", nm, "_W"),  tab_tr["W", nm])
  reg(paste0("sim_trind_", nm, "_LR"), tab_tr["LR", nm])
  reg(paste0("sim_trind_", nm, "_LM"), tab_tr["LM", nm])
  reg(paste0("sim_trind_", nm, "_F"),  tab_tr["F", nm])
}
reg("sim_trind_prop_ordem", min(tab_tr["ordem", ]))
png(fig("07b_trindade.png"), width = 1600, height = 1000, res = 200)
par(mfrow = c(1, 2), mar = c(4.2, 4.2, 3, 1))
rr <- seq(1, 1.6, length.out = 200); nn <- 30
plot(rr, nn * (rr - 1), type = "l", lwd = 2.5, col = "firebrick", xlab = "r = e*'e* / e'e",
     ylab = "estatística", main = "As três estatísticas como função de r (n = 30)", cex.main = 0.85)
lines(rr, nn * log(rr), lwd = 2.5, col = "navy")
lines(rr, nn * (1 - 1 / rr), lwd = 2.5, col = "darkgreen")
abline(h = qchisq(0.95, 2), lty = 2, col = "grey40")
legend("topleft", bty = "n", lwd = 2.5, col = c("firebrick", "navy", "darkgreen", "grey40"),
       lty = c(1, 1, 1, 2), legend = c("W = n(r - 1)", "LR = n ln r", "LM = n(1 - 1/r)",
                                       "crítico χ²(2) 5%"), cex = 0.75)
matplot(seq_along(ns_tr), t(tab_tr[c("W", "LR", "LM", "F"), ]), type = "b", pch = 15:18, lty = 1,
        lwd = 2, col = c("firebrick", "navy", "darkgreen", "black"), xaxt = "n", ylim = c(0, 0.25),
        xlab = "n", ylab = "taxa de rejeição sob H0",
        main = "Tamanho empírico a 5% (J = 2, K = 4)", cex.main = 0.85)
axis(1, at = seq_along(ns_tr), labels = ns_tr)
abline(h = 0.05, lty = 2, col = "grey40")
legend("topright", bty = "n", lwd = 2, pch = 15:18, col = c("firebrick", "navy", "darkgreen", "black"),
       legend = c("Wald", "LR", "LM", "F exato"), cex = 0.75)
dev.off()

## ---- Parte T3: Jarque-Bera ----
secao("T3: Jarque-Bera e tamanho do t com erros não normais")
set.seed(7003)
jb_sim <- function(n, R, gera_erro) {
  x <- rnorm(n); X <- cbind(1, x)
  E <- gera_erro(n * R, n, R)
  B <- solve(crossprod(X), crossprod(X, E)); U <- E - X %*% B      # beta = 0 sem perda
  m2 <- colMeans(U^2); m3 <- colMeans(U^3); m4 <- colMeans(U^4)
  S <- m3 / m2^1.5; Ku <- m4 / m2^2
  jb <- n * (S^2 / 6 + (Ku - 3)^2 / 24)
  s2 <- colSums(U^2) / (n - 2); tt <- B[2, ] / sqrt(s2 * solve(crossprod(X))[2, 2])
  c(jb = mean(jb > qchisq(0.95, 2)), t = mean(abs(tt) > qt(0.975, n - 2)))
}
ns_jb <- c(10, 20, 50, 100, 500, 1000)
jb_norm <- sapply(ns_jb, jb_sim, R = 4000, gera_erro = erro_normal)
jb_exp  <- sapply(ns_jb, jb_sim, R = 4000, gera_erro = erro_exp)
colnames(jb_norm) <- colnames(jb_exp) <- paste0("n", ns_jb)
print(round(rbind(jb_tamanho = jb_norm["jb", ], jb_poder_exp = jb_exp["jb", ],
                  t_tamanho_normal = jb_norm["t", ], t_tamanho_exp = jb_exp["t", ]), 4))
for (nm in colnames(jb_norm)) {
  reg(paste0("sim_jb_tam_", nm), jb_norm["jb", nm])
  reg(paste0("sim_jb_pod_exp_", nm), jb_exp["jb", nm])
  reg(paste0("sim_t_tam_exp_", nm), jb_exp["t", nm])
}
png(fig("07b_jb.png"), width = 1600, height = 1000, res = 200)
par(mar = c(4.2, 4.2, 3, 1))
plot(seq_along(ns_jb), jb_exp["jb", ], type = "b", pch = 16, lwd = 2, col = "firebrick", ylim = c(0, 1),
     xaxt = "n", xlab = "n", ylab = "taxa de rejeição a 5%",
     main = "Jarque-Bera: tamanho (erros normais) e poder (erros exponenciais)")
axis(1, at = seq_along(ns_jb), labels = ns_jb)
lines(seq_along(ns_jb), jb_norm["jb", ], type = "b", pch = 17, lwd = 2, col = "navy")
lines(seq_along(ns_jb), jb_exp["t", ], type = "b", pch = 15, lwd = 2, col = "darkgreen")
abline(h = 0.05, lty = 2, col = "grey40")
legend("right", bty = "n", lwd = 2, pch = c(16, 17, 15), col = c("firebrick", "navy", "darkgreen"),
       legend = c("JB, erros exponenciais (poder)", "JB, erros normais (tamanho)",
                  "teste t de β2 = 0, erros exponenciais (tamanho)"), cex = 0.8)
dev.off()

## ---- Parte T4: identidades numéricas ----
secao("T4: identidades (F = t^2, JF = W, LM = nR^2, LR, dualidade, DW, BP, BG)")
set.seed(7004)
n4 <- 50
d4 <- data.frame(x2 = rnorm(n4), x3 = rnorm(n4), x4 = rnorm(n4))
d4$y <- 1 + 0.5 * d4$x2 + 0.3 * d4$x3 + 0 * d4$x4 + rnorm(n4)
mu4 <- lm(y ~ x2 + x3 + x4, data = d4)
X4 <- model.matrix(mu4); K4 <- ncol(X4); e4 <- resid(mu4); ee4 <- sum(e4^2); s24 <- ee4 / (n4 - K4)
# J = 1: H0: beta4 = 0
t4 <- coef(summary(mu4))["x4", "t value"]
mr1 <- lm(y ~ x2 + x3, data = d4)
F1_ssr <- (sum(resid(mr1)^2) - ee4) / (ee4 / (n4 - K4))
Rm <- matrix(c(0, 0, 0, 1), 1); m1 <- Rm %*% coef(mu4)
F1_wald <- as.numeric(t(m1) %*% solve(Rm %*% (s24 * solve(crossprod(X4))) %*% t(Rm)) %*% m1)
reg("t4_t2", t4^2)
reg("t4_F1_ssr", F1_ssr)
reg("t4_F1_wald", F1_wald)
# J = 2: H0: beta3 = beta4 = 0
mr2 <- lm(y ~ x2, data = d4); er2 <- resid(mr2); eer2 <- sum(er2^2); J2 <- 2
F2 <- (eer2 - ee4) / J2 / s24
r4 <- eer2 / ee4
aux4 <- lm(er2 ~ X4 - 1)                                   # e* em todas as colunas de X
R2aux <- 1 - sum(resid(aux4)^2) / sum((er2 - mean(er2))^2)
reg("t4_F2", F2)
reg("t4_JF", J2 * F2)
reg("t4_W_ml", n4 * (r4 - 1))
reg("t4_W_via_F", J2 * F2 * n4 / (n4 - K4))
reg("t4_LR_formula", n4 * log(r4))
reg("t4_LR_loglik", 2 * as.numeric(logLik(mu4) - logLik(mr2)))
reg("t4_LM_nR2", n4 * R2aux)
reg("t4_LM_formula", n4 * (1 - 1 / r4))
# dualidade: no limite superior do IC de 95% de beta2, |t(beta0)| = t crítico
se2_4 <- coef(summary(mu4))["x2", "Std. Error"]; b2_4 <- coef(mu4)["x2"]
tc4 <- qt(0.975, n4 - K4); b0 <- b2_4 + tc4 * se2_4
reg("t4_tcrit", tc4)
reg("t4_t_no_limite", abs((b2_4 - b0) / se2_4))
# DW ~ 2(1 - r1) com erros AR(1), rho = 0,6
set.seed(7014)
nt <- 200; u <- as.numeric(arima.sim(list(ar = 0.6), nt)); xt <- rnorm(nt)
yt <- 2 + 1 * xt + u; mt <- lm(yt ~ xt); et <- resid(mt)
dw <- sum(diff(et)^2) / sum(et^2); r1 <- sum(et[-1] * et[-nt]) / sum(et^2)
reg("t4_dw", dw)
reg("t4_dw_aprox", 2 * (1 - r1))
reg("t4_r1", r1)
reg("t4_dw_lmtest", dwtest(mt)$statistic)
# Breusch-Godfrey de ordem 1: nR^2 da auxiliar de e_t em (1, x_t, e_{t-1}), com e_0 = 0
elag <- c(0, et[-nt]); auxbg <- lm(et ~ xt + elag)
reg("t4_bg_manual", nt * summary(auxbg)$r.squared)
reg("t4_bg_lmtest", bgtest(mt, order = 1)$statistic)
# Breusch-Pagan (versão de Koenker, a padrão do lmtest): nR^2 de e^2 em X
set.seed(7024)
xh <- runif(nt, 1, 5); yh <- 1 + xh + rnorm(nt, sd = xh); mh <- lm(yh ~ xh); eh <- resid(mh)
reg("t4_bp_manual", nt * summary(lm(I(eh^2) ~ xh))$r.squared)
reg("t4_bp_lmtest", bptest(mh)$statistic)
reg("t4_white_manual", nt * summary(lm(I(eh^2) ~ xh + I(xh^2)))$r.squared)
reg("t4_white_lmtest", bptest(mh, ~ xh + I(xh^2))$statistic)

## ---- Parte T5: omitir relevante x incluir irrelevante ----
secao("T5: especificação (omissão e inclusão)")
set.seed(7005)
n5 <- 50; R5 <- 20000
x1 <- rnorm(n5); x2 <- 0.7 * x1 + sqrt(1 - 0.49) * rnorm(n5); x3 <- 0.8 * x1 + 0.6 * rnorm(n5)
Xl <- cbind(1, x1, x2); Xs <- cbind(1, x1); Xi <- cbind(1, x1, x3)
E5 <- matrix(rnorm(n5 * R5), n5, R5)
coefs <- function(Z, Y) solve(crossprod(Z), crossprod(Z, Y))
# (a) verdadeiro: y = 1 + x1 + 0,5 x2 + e; regressão curta omite x2
Ya <- as.vector(Xl %*% c(1, 1, 0.5)) + E5
Bs <- coefs(Xs, Ya); Bl <- coefs(Xl, Ya)
d12 <- coefs(Xs, x2)[2]                                   # inclinação de x2 em (1, x1)
Ua <- Ya - Xs %*% Bs; s2s <- colSums(Ua^2) / (n5 - 2)
M1x2 <- x2 - Xs %*% coefs(Xs, x2)
reg("t5_d12", d12)
reg("t5_omit_b1_teo", 1 + 0.5 * d12)
reg("t5_omit_b1_sim", mean(Bs[2, ]))
reg("t5_longa_b1_sim", mean(Bl[2, ]))
reg("t5_omit_s2_teo", 1 + 0.25 * sum(M1x2^2) / (n5 - 2))
reg("t5_omit_s2_sim", mean(s2s))
reg("t5_var_curta_sim", var(Bs[2, ]))
reg("t5_var_longa_sim", var(Bl[2, ]))
reg("t5_var_curta_teo", solve(crossprod(Xs))[2, 2])
reg("t5_var_longa_teo", solve(crossprod(Xl))[2, 2])
# (b) verdadeiro: y = 1 + x1 + e; regressão longa inclui x3 irrelevante (corr com x1)
Yb <- as.vector(Xs %*% c(1, 1)) + E5
Bc <- coefs(Xs, Yb); Bi <- coefs(Xi, Yb)
r2_13 <- summary(lm(x1 ~ x3))$r.squared
reg("t5_irrel_b1_sim", mean(Bi[2, ]))
reg("t5_irrel_razao_var_sim", var(Bi[2, ]) / var(Bc[2, ]))
reg("t5_irrel_razao_var_teo", 1 / (1 - r2_13))
reg("t5_r2_13", r2_13)
png(fig("07b_omissao_irrelevante.png"), width = 1600, height = 1000, res = 200)
par(mar = c(4.2, 4.2, 3, 1))
dc <- density(Bc[2, ]); di <- density(Bi[2, ]); ds <- density(Bs[2, ])
plot(dc, lwd = 2.5, col = "navy", xlim = range(c(dc$x, di$x, ds$x)), ylim = c(0, max(dc$y, ds$y) * 1.05),
     xlab = expression("estimativa de " * beta[1] * " (verdadeiro = 1)"), ylab = "densidade",
     main = "Distribuição amostral de b1: correto, com irrelevante e com omissão")
lines(di, lwd = 2.5, col = "darkorange")
lines(ds, lwd = 2.5, col = "firebrick", lty = 2)
abline(v = 1, lty = 3)
legend("topright", bty = "n", lwd = 2.5, lty = c(1, 1, 2), col = c("navy", "darkorange", "firebrick"),
       legend = c("modelo correto", "inclui x3 irrelevante: sem viés, mais variância",
                  "omite x2 relevante: viesado"), cex = 0.75)
dev.off()

gravar_resultados("m07b")
