# Módulo 05 — Ajuste da regressão e mínimos quadrados restritos (id m05)
#
# O que este script faz:
#   Parte A. Confere as identidades do MQ restrito numa Cobb-Douglas simulada:
#            R b* = q; e*'e* - e'e = (Rb-q)'[R(X'X)^{-1}R']^{-1}(Rb-q);
#            F nas três formas (Wald, SQR restrita x irrestrita, R²) = car::linearHypothesis;
#            F = t² para J = 1; Var(b*) de Greene-Seaks = vcov da regressão por substituição.
#   Parte B. Incluir uma variável: u'u = e'e(1 - r*²), R² de Greene (Teorema 3.5/3.6),
#            r*² = t²/(t² + n - K) e o teorema "R̄² sobe sse |t| > 1".
#   Parte C. Log-verossimilhança do modelo normal e critérios de informação (EViews, Greene, R).
#   Parte D. Números dos exercícios 55, 56 e 62 da Lista 1 (dados copiados dos outputs impressos).
#   Parte E. Aplicações: output da P1 2025/2 (tabela ANOVA) e exemplo da gasolina do SL05.
#   Figuras: figuras/fig05_r2_vs_r2adj.png e figuras/fig05_mq_restrito_geometria.png
#
# Rodar: powershell -ExecutionPolicy Bypass -File scripts\r.ps1 05_ajuste_restricoes\05_ajuste_restricoes.R

# --- bootstrap: localizar a raiz do repo e carregar helpers ---
.d <- getwd(); while (!file.exists(file.path(.d, ".repo-root")) && dirname(.d) != .d) .d <- dirname(.d)
source(file.path(.d, "R", "raiz.R"))

suppressPackageStartupMessages(library(car))

dir_fig <- caminho_repo("05_ajuste_restricoes", "figuras")
dir.create(dir_fig, showWarnings = FALSE, recursive = TRUE)

# Falha (status != 0) se uma identidade não bater
confere <- function(a, b, rotulo, tol = 1e-8) {
  a <- as.numeric(a); b <- as.numeric(b)
  if (length(a) != length(b) || any(abs(a - b) > tol * pmax(1, abs(a), abs(b))))
    stop("Identidade falhou: ", rotulo, " | ", paste(signif(a, 10), collapse = ", "),
         " vs ", paste(signif(b, 10), collapse = ", "))
  invisible(TRUE)
}

## ---- Parte A: MQ restrito numa Cobb-Douglas simulada ----
set.seed(5021)
n  <- 200
lk <- rnorm(n, mean = 3, sd = 1)                             # log(capital)
ll <- 2 + 0.5 * (lk - 3) + rnorm(n, sd = sqrt(0.75))         # log(trabalho), corr ~ 0,5 com lk
ly <- 1 + 0.60 * lk + 0.35 * ll + rnorm(n, sd = 0.5)         # retornos decrescentes: 0,95

X  <- cbind(const = 1, lk = lk, ll = ll)
y  <- ly
K  <- ncol(X)
XtXi <- solve(crossprod(X))
b    <- drop(XtXi %*% crossprod(X, y))
e    <- drop(y - X %*% b)
ssr_u <- sum(e^2)
sst   <- sum((y - mean(y))^2)

# Restrição de retornos constantes: beta_K + beta_L = 1  (J = 1)
Rm <- matrix(c(0, 1, 1), nrow = 1); q <- 1; J <- nrow(Rm)
m     <- drop(Rm %*% b - q)                                  # vetor de discrepância (J x 1)
Wm    <- solve(Rm %*% XtXi %*% t(Rm))                        # [R(X'X)^{-1}R']^{-1}  (J x J)
lam   <- drop(Wm %*% m)                                      # multiplicador de Lagrange
bstar <- drop(b - XtXi %*% t(Rm) %*% Wm %*% m)               # b* de Greene
estar <- drop(y - X %*% bstar)
ssr_r <- sum(estar^2)
forma_quad <- drop(t(m) %*% Wm %*% m)

confere(Rm %*% bstar, q, "R b* = q")
confere(ssr_r - ssr_u, forma_quad, "e*'e* - e'e = forma quadrática")
confere(bstar, b - drop(XtXi %*% t(Rm)) * lam, "b* = b - (X'X)^{-1} R' lambda")

# Mesma estimativa impondo a restrição por substituição: log(Y/L) = b0 + bK log(K/L)
fit_sub <- lm(I(ly - ll) ~ I(lk - ll))
b_sub   <- c(coef(fit_sub), 1 - coef(fit_sub)[2])
confere(bstar, b_sub, "b* (Lagrange) = b* (substituição)")
confere(ssr_r, sum(resid(fit_sub)^2), "SQR restrita (Lagrange = substituição)")

# F nas três formas
s2     <- ssr_u / (n - K)
F_wald <- drop(t(m) %*% solve(s2 * Rm %*% XtXi %*% t(Rm)) %*% m) / J
F_ssr  <- ((ssr_r - ssr_u) / J) / (ssr_u / (n - K))
R2_u   <- 1 - ssr_u / sst
R2_r   <- 1 - ssr_r / sst                                   # mesmo y, mesmo denominador
F_r2   <- ((R2_u - R2_r) / J) / ((1 - R2_u) / (n - K))
fit_u  <- lm(ly ~ lk + ll)
F_car  <- linearHypothesis(fit_u, "lk + ll = 1")$F[2]
se_som <- sqrt(drop(Rm %*% vcov(fit_u) %*% t(Rm)))
t_crs  <- m / se_som
confere(F_wald, F_ssr, "F Wald = F SQR")
confere(F_ssr, F_r2, "F SQR = F R²")
confere(F_ssr, F_car, "F SQR = car::linearHypothesis")
confere(t_crs^2, F_ssr, "t² = F (J = 1)")

# Var(b*|X) de Greene-Seaks, com s*² = e*'e*/(n - K + J), contra a vcov da regressão por substituição
s2r    <- ssr_r / (n - K + J)
G      <- XtXi %*% t(Rm) %*% Wm %*% Rm %*% XtXi
V_star <- s2r * (XtXi - G)
confere(V_star[1:2, 1:2], vcov(fit_sub), "Var(b*) Greene-Seaks = vcov da substituição")
confere(min(eigen(G, symmetric = TRUE)$values), 0, "G é psd (menor autovalor ~ 0)", tol = 1e-10)
confere(R2_r <= R2_u, TRUE, "R*² <= R²")

registrar("m05_sim_b_k", b[2]);        registrar("m05_sim_b_l", b[3])
registrar("m05_sim_soma_b", b[2] + b[3])
registrar("m05_sim_bstar_k", bstar[2]); registrar("m05_sim_bstar_l", bstar[3])
registrar("m05_sim_rbstar", drop(Rm %*% bstar))
registrar("m05_sim_lambda", lam)
registrar("m05_sim_ssr_u", ssr_u);     registrar("m05_sim_ssr_r", ssr_r)
registrar("m05_sim_dif_ssr", ssr_r - ssr_u)
registrar("m05_sim_forma_quad", forma_quad)
registrar("m05_sim_F_wald", F_wald);   registrar("m05_sim_F_ssr", F_ssr)
registrar("m05_sim_F_r2", F_r2);       registrar("m05_sim_F_car", F_car)
registrar("m05_sim_t_crs", t_crs);     registrar("m05_sim_t2", t_crs^2)
registrar("m05_sim_p_F", pf(F_ssr, J, n - K, lower.tail = FALSE))
registrar("m05_sim_r2_u", R2_u);       registrar("m05_sim_r2_r", R2_r)
registrar("m05_sim_corr_lk_ll", cor(lk, ll))

## ---- Parte B: incluir uma variável (Teorema 3.5), correlação parcial e R̄² ----
# Curta: y em X1 = [1, lk]; longa: y em [X1, z] com z = ll
X1  <- X[, 1:2]; z <- ll
M1  <- diag(n) - X1 %*% solve(crossprod(X1)) %*% t(X1)
e1  <- drop(M1 %*% y)                 # resíduos da curta
zs  <- drop(M1 %*% z)                 # z* = M_X z
cc  <- sum(zs * e1) / sum(zs^2)       # coeficiente de z na longa (FWL)
u   <- e                              # resíduos da longa (= regressão completa)
confere(cc, b[3], "c = z*'e / z*'z* (coeficiente de z na longa)")
confere(sum(u^2), sum(e1^2) - cc^2 * sum(zs^2), "u'u = e'e - c² z*'z*")
r2parc <- sum(zs * e1)^2 / (sum(zs^2) * sum(e1^2))
confere(sum(u^2), sum(e1^2) * (1 - r2parc), "u'u = e'e (1 - r*²)")
R2_curta <- 1 - sum(e1^2) / sst
confere(R2_u, R2_curta + (1 - R2_curta) * r2parc, "R²_Xz = R²_X + (1 - R²_X) r*²")
t_z <- summary(fit_u)$coefficients["ll", "t value"]
confere(r2parc, t_z^2 / (t_z^2 + (n - K)), "r*² = t²/(t² + n - K)")
registrar("m05_sim_ee_curta", sum(e1^2)); registrar("m05_sim_uu_longa", sum(u^2))
registrar("m05_sim_r2parc", r2parc);      registrar("m05_sim_t_ll", t_z)
registrar("m05_sim_r2_curta", R2_curta)

# Teorema do R̄²: em 2000 variáveis irrelevantes, R̄² sobe exatamente quando |t| > 1
r2adj <- function(ssr, sst, n, K) 1 - (n - 1) / (n - K) * ssr / sst
ra_base <- r2adj(ssr_u, sst, n, K)
acerto <- logical(2000)
for (r in seq_along(acerto)) {
  w   <- rnorm(n)
  fw  <- lm(ly ~ lk + ll + w)
  tw  <- summary(fw)$coefficients["w", "t value"]
  raw <- r2adj(sum(resid(fw)^2), sst, n, K + 1)
  acerto[r] <- (raw > ra_base) == (abs(tw) > 1)
}
confere(mean(acerto), 1, "R̄² sobe sse |t| > 1 (2000 réplicas)")
registrar("m05_sim_prop_teorema_t1", mean(acerto))

# Figura 1: R², R̄², AIC e SC ao adicionar 15 regressores irrelevantes, um a um
set.seed(6021)
Wirr <- matrix(rnorm(n * 15), n, 15)
caminho <- data.frame(j = 0:15, R2 = NA, R2a = NA, aic = NA, sc = NA, t = NA)
for (j in 0:15) {
  Xj  <- if (j == 0) X else cbind(X, Wirr[, 1:j, drop = FALSE])
  fj  <- lm.fit(Xj, y)
  ssj <- sum(fj$residuals^2); Kj <- ncol(Xj)
  llj <- -n / 2 * (1 + log(2 * pi) + log(ssj / n))
  caminho[j + 1, c("R2", "R2a", "aic", "sc")] <-
    c(1 - ssj / sst, r2adj(ssj, sst, n, Kj), -2 * llj / n + 2 * Kj / n, -2 * llj / n + Kj * log(n) / n)
  if (j > 0) {
    s2j <- ssj / (n - Kj)
    caminho$t[j + 1] <- fj$coefficients[Kj] / sqrt(s2j * solve(crossprod(Xj))[Kj, Kj])
  }
}
confere(all(diff(caminho$R2) >= 0), TRUE, "R² nunca cai")
sobe <- diff(caminho$R2a) > 0
confere(sobe, abs(caminho$t[-1]) > 1, "caminho: R̄² sobe sse |t| > 1")

png(file.path(dir_fig, "fig05_r2_vs_r2adj.png"), width = 1600, height = 1000, res = 200)
par(mfrow = c(1, 2), mar = c(4.2, 4.2, 3, 1))
yl <- range(c(caminho$R2, caminho$R2a))
plot(caminho$j, caminho$R2, type = "b", pch = 19, col = "grey20", ylim = yl,
     xlab = "Nº de regressores irrelevantes incluídos", ylab = "Medida de ajuste",
     main = "R² nunca cai; R̄² pode cair", cex.main = 0.95)
lines(caminho$j, caminho$R2a, type = "b", pch = 1, col = "firebrick", lty = 2)
pts <- which(c(FALSE, abs(caminho$t[-1]) > 1))
points(caminho$j[pts], caminho$R2a[pts], pch = 17, col = "firebrick", cex = 1.3)
legend("topleft", bty = "n", cex = 0.75,
       legend = c("R²", "R̄² (ajustado)", "R̄² subiu: |t| > 1"),
       col = c("grey20", "firebrick", "firebrick"), pch = c(19, 1, 17), lty = c(1, 2, NA))
yl2 <- range(c(caminho$aic, caminho$sc))
plot(caminho$j, caminho$aic, type = "b", pch = 19, col = "navy", ylim = yl2,
     xlab = "Nº de regressores irrelevantes incluídos", ylab = "Critério (formato EViews)",
     main = "Critérios de informação: o SC penaliza mais", cex.main = 0.95)
lines(caminho$j, caminho$sc, type = "b", pch = 1, col = "darkgreen", lty = 2)
legend("topleft", bty = "n", cex = 0.75, legend = c("AIC", "SC (Schwarz/BIC)"),
       col = c("navy", "darkgreen"), pch = c(19, 1), lty = c(1, 2))
invisible(dev.off())
registrar("m05_fig1_r2_final", caminho$R2[16]); registrar("m05_fig1_r2a_final", caminho$R2a[16])
registrar("m05_fig1_r2a_inicial", caminho$R2a[1])

# Figura 2: geometria do MQ restrito no plano das inclinações (intercepto concentrado)
Xc  <- scale(X[, 2:3], scale = FALSE)
A   <- crossprod(Xc)                       # X~'X~ (inclinações em desvios)
bs  <- b[2:3]
gK  <- seq(bs[1] - 0.13, bs[1] + 0.13, length.out = 241)
gL  <- seq(bs[2] - 0.13, bs[2] + 0.13, length.out = 241)
Sg  <- outer(gK, gL, Vectorize(function(a1, a2) {
  d <- c(a1, a2) - bs; ssr_u + drop(t(d) %*% A %*% d)
}))
png(file.path(dir_fig, "fig05_mq_restrito_geometria.png"), width = 1600, height = 1000, res = 200)
par(mar = c(4.2, 4.2, 3, 1))
niveis <- ssr_u + c(0.25, 0.5, 1, 2, 3.5) * (ssr_r - ssr_u)
contour(gK, gL, Sg, levels = niveis, drawlabels = FALSE, col = "grey60", asp = 1,
        xlab = expression(beta[K] ~ "(capital)"), ylab = expression(beta[L] ~ "(trabalho)"),
        main = "MQ restrito: a elipse de e'e tangencia a reta da restrição", cex.main = 0.95)
contour(gK, gL, Sg, levels = ssr_r, drawlabels = FALSE, add = TRUE, col = "firebrick", lwd = 2)
abline(a = 1, b = -1, lwd = 2, col = "navy")
points(bs[1], bs[2], pch = 19, cex = 1.3)
points(bstar[2], bstar[3], pch = 17, cex = 1.4, col = "firebrick")
text(bs[1], bs[2], "b (irrestrito)", pos = 3, offset = 0.6, cex = 0.8)
text(bstar[2], bstar[3], "b* (restrito)", pos = 2, offset = 0.7, cex = 0.8, col = "firebrick")
legend("topright", bty = "n", cex = 0.75,
       legend = c(expression(beta[K] + beta[L] == 1), "curva de nível e*'e*", "outras curvas de e'e"),
       col = c("navy", "firebrick", "grey60"), lwd = c(2, 2, 1))
invisible(dev.off())

## ---- Parte C: log-verossimilhança e critérios de informação ----
llik  <- -n / 2 * (1 + log(2 * pi) + log(ssr_u / n))
confere(llik, as.numeric(logLik(fit_u)), "log L concentrada = logLik(lm)")
aic_ev <- -2 * llik / n + 2 * K / n
sc_ev  <- -2 * llik / n + K * log(n) / n
aic_gr <- log(ssr_u / n) + 2 * K / n
confere(aic_ev - aic_gr, 1 + log(2 * pi), "AIC EViews - AIC Greene = 1 + ln(2 pi)")
confere((AIC(fit_u) - 2) / n, aic_ev, "AIC do R conta sigma²: (AIC(lm) - 2)/n = AIC EViews")
registrar("m05_sim_loglik", llik); registrar("m05_sim_aic_eviews", aic_ev)
registrar("m05_sim_sc_eviews", sc_ev); registrar("m05_sim_aic_greene", aic_gr)
registrar("m05_sim_aic_R", AIC(fit_u))
registrar("m05_const_1_ln2pi", 1 + log(2 * pi))

## ---- Parte D1: Ex. 55 (Lista 1) — Cobb-Douglas do setor informal, n = 39692 ----
# Números copiados do output impresso na Lista 1, ex. 55
n55 <- 39692; K55 <- 3
bK  <- 0.637325; seK <- 0.002199
bL  <- 0.288255; seL <- 0.007950
R2_55  <- 0.769275; F55_imp <- 66164.78
ssr55u <- 17335.62; ssr55r <- 17384.21
s2_55  <- ssr55u / (n55 - K55)
F55_crs <- ((ssr55r - ssr55u) / 1) / s2_55
soma55  <- bK + bL
t55     <- sign(soma55 - 1) * sqrt(F55_crs)                  # t equivalente (J = 1)
se_soma55 <- abs(soma55 - 1) / sqrt(F55_crs)                 # EP(bK + bL) implícito
cov55   <- (se_soma55^2 - seK^2 - seL^2) / 2                 # Cov(bK, bL) implícita
corr55  <- cov55 / (seK * seL)
rKL55   <- -corr55                                           # corr amostral de log K e log L
F55_glob <- (R2_55 / (K55 - 1)) / ((1 - R2_55) / (n55 - K55))
registrar("m05_ex55_s2", s2_55)
registrar("m05_ex55_s", sqrt(s2_55))
registrar("m05_ex55_dif_ssr", ssr55r - ssr55u)
registrar("m05_ex55_F_crs", F55_crs)
registrar("m05_ex55_p_crs", pf(F55_crs, 1, n55 - K55, lower.tail = FALSE))
registrar("m05_ex55_soma", soma55)
registrar("m05_ex55_t_crs", t55)
registrar("m05_ex55_se_soma", se_soma55)
registrar("m05_ex55_cov_bkbl", cov55)
registrar("m05_ex55_corr_bkbl", corr55)
registrar("m05_ex55_r_lk_ll", rKL55)
registrar("m05_ex55_desvio", soma55 - 1)
registrar("m05_ex55_fiv", 1 / (1 - rKL55^2))
registrar("m05_ex55_F_glob", F55_glob)
registrar("m05_ex55_sst", ssr55u / (1 - R2_55))
registrar("m05_ex55_r2adj", 1 - (n55 - 1) / (n55 - K55) * (1 - R2_55))
registrar("m05_ex55_efeito10_aprox", 10 * bL)
registrar("m05_ex55_efeito10_exato", 100 * (1.10^bL - 1))
registrar("m05_ex55_escala10_exato", 100 * (1.10^soma55 - 1))
registrar("m05_ex55_escala10_aprox", 10 * soma55)
registrar("m05_ex55_z10", qnorm(0.95))
registrar("m05_ex55_z10_uni", qnorm(0.90))
registrar("m05_ex55_Fcrit10", qf(0.90, 1, n55 - K55))
registrar("m05_ex55_Fcrit05", qf(0.95, 1, n55 - K55))
registrar("m05_ex55_Fcrit10_glob", qf(0.90, 2, n55 - K55))
registrar("m05_ex55_t_k_recalc", bK / seK)
confere(abs(F55_glob - F55_imp) / F55_imp < 1e-4, TRUE, "ex55: F global a partir do R² bate com o impresso")

## ---- Parte D2: Ex. 56 (Lista 1) — demanda de energia, n = 10, K = 3 ----
# Números copiados do output impresso na Lista 1, ex. 56
n56 <- 10; K56 <- 3
ssr56 <- 152.3325; sdy56 <- 15.77938; R2_56 <- 0.932022; R2a56_imp <- 0.912599
ser56 <- 4.664953; ll56 <- -27.80679; F56_imp <- 47.98703
coef56 <- c(C = 7.889080, T = -0.263274, Y = 1.237959)
se56   <- c(C = 23.99340, T = 0.090018, Y = 0.181799)
sst56  <- (n56 - 1) * sdy56^2
sqe56  <- sst56 - ssr56
qm_reg <- sqe56 / (K56 - 1)
qm_res <- ssr56 / (n56 - K56)
F56    <- qm_reg / qm_res
t56    <- coef56 / se56
p56    <- 2 * pt(-abs(t56), n56 - K56)
registrar("m05_ex56_sst", sst56)
registrar("m05_ex56_sst_via_r2", ssr56 / (1 - R2_56))
registrar("m05_ex56_sqe", sqe56)
registrar("m05_ex56_ssr", ssr56)
registrar("m05_ex56_qm_reg", qm_reg)
registrar("m05_ex56_qm_res", qm_res)
registrar("m05_ex56_F_anova", F56)
registrar("m05_ex56_F_r2", (R2_56 / (K56 - 1)) / ((1 - R2_56) / (n56 - K56)))
registrar("m05_ex56_r2_recalc", 1 - ssr56 / sst56)
registrar("m05_ex56_r2adj_recalc", 1 - (n56 - 1) / (n56 - K56) * (1 - R2_56))
registrar("m05_ex56_ser_recalc", sqrt(qm_res))
registrar("m05_ex56_sy2", sdy56^2)
registrar("m05_ex56_t_C", t56["C"]); registrar("m05_ex56_t_T", t56["T"]); registrar("m05_ex56_t_Y", t56["Y"])
registrar("m05_ex56_p_C", p56["C"]); registrar("m05_ex56_p_T", p56["T"]); registrar("m05_ex56_p_Y", p56["Y"])
registrar("m05_ex56_p_F", pf(F56_imp, K56 - 1, n56 - K56, lower.tail = FALSE))
registrar("m05_ex56_Fcrit10_2_7", qf(0.90, 2, 7))
registrar("m05_ex56_Fcrit10_2_inf", qf(0.90, 2, Inf))
registrar("m05_ex56_tcrit_7_bi10", qt(0.95, 7))
registrar("m05_ex56_tcrit_8_bi10", qt(0.95, 8))
registrar("m05_ex56_tcrit_7_bi05", qt(0.975, 7))
# log L e critérios de informação a partir de e'e (conferem o output do EViews)
ll56c <- -n56 / 2 * (1 + log(2 * pi) + log(ssr56 / n56))
registrar("m05_ex56_loglik_recalc", ll56c)
registrar("m05_ex56_aic_ev", -2 * ll56 / n56 + 2 * K56 / n56)
registrar("m05_ex56_sc_ev", -2 * ll56 / n56 + K56 * log(n56) / n56)
registrar("m05_ex56_hq_ev", -2 * ll56 / n56 + 2 * K56 * log(log(n56)) / n56)
registrar("m05_ex56_aic_greene", log(ssr56 / n56) + 2 * K56 / n56)
registrar("m05_ex56_bic_greene", log(ssr56 / n56) + K56 * log(n56) / n56)
registrar("m05_ex56_menos2ll_n", -2 * ll56 / n56)
confere(abs(ll56c - ll56) < 5e-5, TRUE, "ex56: log L recalculada bate com o impresso")
confere(abs(1 - (n56 - 1) / (n56 - K56) * (1 - R2_56) - R2a56_imp) < 2e-6, TRUE, "ex56: R̄² bate")
confere(abs(sqrt(qm_res) - ser56) < 1e-5, TRUE, "ex56: S.E. of regression bate")

## ---- Parte D3: Ex. 62 (Lista 1) — retornos constantes de escala, F = 1,95 ----
F62 <- 1.95; F62_tab <- 2.45
registrar("m05_ex62_Fcrit05_1_inf", qf(0.95, 1, Inf))       # piso de F(1, gl) a 5%
registrar("m05_ex62_p_min", pf(F62, 1, Inf, lower.tail = FALSE)) # menor p-valor possível p/ F(1, gl)
registrar("m05_ex62_Fcrit05_4_103", qf(0.95, 4, 103))       # valor de F(4, n-K) do ex. 59
registrar("m05_ex62_t_abs", sqrt(F62))                       # |t| equivalente (J = 1)
confere(F62 < F62_tab && F62 < qf(0.95, 1, Inf), TRUE, "ex62: decisão igual com o crítico impresso e o correto")
confere(all(diff(qf(0.95, 1, c(5, 10, 30, 100, 1000, 1e5))) < 0), TRUE, "qf(.95,1,gl) decresce em gl")

## ---- Parte E1: P1 2025/2, Questão 1 — tabela ANOVA a partir do output impresso ----
nP <- 4165; KP <- 10
ssrP <- 581.2717; sdyP <- 0.4615122; R2P <- 0.3446066; R2aP <- 0.3431870; sP <- 0.3740280; FP <- 242.74
sstP <- (nP - 1) * sdyP^2
sqeP <- sstP - ssrP
registrar("m05_p1q1_sst", sstP)
registrar("m05_p1q1_sqe", sqeP)
registrar("m05_p1q1_qm_reg", sqeP / (KP - 1))
registrar("m05_p1q1_qm_res", ssrP / (nP - KP))
registrar("m05_p1q1_F_anova", (sqeP / (KP - 1)) / (ssrP / (nP - KP)))
registrar("m05_p1q1_r2_recalc", 1 - ssrP / sstP)
registrar("m05_p1q1_r2adj_recalc", 1 - (nP - 1) / (nP - KP) * (1 - R2P))
registrar("m05_p1q1_s_recalc", sqrt(ssrP / (nP - KP)))

## ---- Parte E2: SL05 (gasolina) — |t| de PD recuperado das duas SQR ----
# SQR sem PD = 596,68995 (K = 9); com PD = 594,54206 (K = 10); n = 36 (SL05, p. 31-32)
t_pd <- sqrt((36 - 10) * (596.68995 - 594.54206) / 594.54206)
registrar("m05_sl05_t_pd", t_pd)
registrar("m05_sl05_rparc_ps_r2", (0.9907 - 0.9861) / (1 - 0.9861))   # SL05, p. 15
registrar("m05_sl05_rparc_ps_t", 3.92^2 / (3.92^2 + (36 - 5)))
registrar("m05_sl05_rparc_ps_F", 15.340 / (15.340 + 31))             # "Partial F" = t² (SL05, p. 13)
# Critérios impressos pelo NLOGIT no SL05, p. 31 (e'e = 596,68995; n = 36; K = 9)
registrar("m05_sl05_aic_nlogit", log(596.68995 / 36) + 2 * 9 / 36)          # impresso: 3,30788
registrar("m05_sl05_amemiya", log(596.68995 / (36 - 9)) + log(1 + 9 / 36))  # impresso: 3,31870

gravar_resultados("m05")
