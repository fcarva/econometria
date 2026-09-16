# Módulo 09 — Dummies, forma funcional, quebra estrutural e diferenças em diferenças
# Exercícios 43, 47, 48, 57 a 61, 71 e 72 da Lista 1.
# Rodar: powershell -ExecutionPolicy Bypass -File scripts\r.ps1 09_dummies_forma_funcional\09_dummies_forma_funcional.R

# --- bootstrap: localizar a raiz do repo e carregar helpers ---
.d <- getwd(); while (!file.exists(file.path(.d, ".repo-root")) && dirname(.d) != .d) .d <- dirname(.d)
source(file.path(.d, "R", "raiz.R"))

fig <- function(nome) file.path(raiz(), "09_dummies_forma_funcional", "figuras", nome)

## ---- Ex. 43 — Consumo de café: cinco formas funcionais ----------------------
# Dados da Lista 1, ex. 43 (EUA, 2000 a 2010): quantidade em xícaras, preço em dólares.
cafe <- data.frame(
  ano   = 2000:2010,
  Q = c(2.57, 2.50, 2.30, 2.25, 2.20, 2.11, 1.94, 1.97, 2.06, 2.02, 2.35),
  P = c(0.77, 0.74, 0.73, 0.76, 0.75, 1.08, 1.81, 1.39, 1.20, 1.17, 0.72)
)
registrar("m09_ex43_n", nrow(cafe))
registrar("m09_ex43_Qbar", mean(cafe$Q))
registrar("m09_ex43_Pbar", mean(cafe$P))

m_lin    <- lm(Q ~ P, data = cafe)                    # linear
m_linlog <- lm(Q ~ log(P), data = cafe)               # lin-log
m_loglin <- lm(log(Q) ~ P, data = cafe)               # log-lin
m_loglog <- lm(log(Q) ~ log(P), data = cafe)          # duplo log
m_inv    <- lm(Q ~ I(1 / P), data = cafe)             # inversa

guarda <- function(m, tag) {
  s <- summary(m)
  registrar(paste0("m09_ex43_", tag, "_b1"), unname(coef(m)[1]))
  registrar(paste0("m09_ex43_", tag, "_b2"), unname(coef(m)[2]))
  registrar(paste0("m09_ex43_", tag, "_ep2"), unname(s$coefficients[2, 2]))
  registrar(paste0("m09_ex43_", tag, "_t2"), unname(s$coefficients[2, 3]))
  registrar(paste0("m09_ex43_", tag, "_p2"), unname(s$coefficients[2, 4]))
  registrar(paste0("m09_ex43_", tag, "_r2"), s$r.squared)
}
guarda(m_lin, "lin"); guarda(m_linlog, "linlog"); guarda(m_loglin, "loglin")
guarda(m_loglog, "loglog"); guarda(m_inv, "inv")

Qbar <- mean(cafe$Q); Pbar <- mean(cafe$P)
# Elasticidades no ponto médio, uma fórmula por forma funcional
registrar("m09_ex43_elast_lin",    unname(coef(m_lin)[2]) * Pbar / Qbar)
registrar("m09_ex43_elast_linlog", unname(coef(m_linlog)[2]) / Qbar)
registrar("m09_ex43_elast_loglin", unname(coef(m_loglin)[2]) * Pbar)
registrar("m09_ex43_elast_loglog", unname(coef(m_loglog)[2]))          # constante
registrar("m09_ex43_elast_inv",    -unname(coef(m_inv)[2]) / (Pbar * Qbar))

png(fig("09_ex43_formas_funcionais.png"), width = 1600, height = 1000, res = 200)
plot(cafe$P, cafe$Q, pch = 19, xlab = "preço (US$)", ylab = "quantidade (xícaras)",
     main = "Demanda por café: cinco formas funcionais")
grade <- seq(min(cafe$P), max(cafe$P), length.out = 200)
lines(grade, predict(m_lin, data.frame(P = grade)), lwd = 2)
lines(grade, predict(m_linlog, data.frame(P = grade)), lwd = 2, lty = 2)
lines(grade, exp(predict(m_loglin, data.frame(P = grade))), lwd = 2, lty = 3)
lines(grade, exp(predict(m_loglog, data.frame(P = grade))), lwd = 2, lty = 4)
lines(grade, predict(m_inv, data.frame(P = grade)), lwd = 2, lty = 5)
legend("topright", c("linear", "lin-log", "log-lin", "log-log", "inversa"),
       lwd = 2, lty = 1:5, bty = "n", cex = 0.8)
dev.off()

## ---- Ex. 57 — Poupança e renda com dummies ---------------------------------
# Dados da Lista 1, ex. 57 (1946 a 1963), em milhões de reais.
pou <- data.frame(
  ano = 1946:1963,
  Y = c(0.36, 0.21, 0.08, 0.20, 0.10, 0.12, 0.41, 0.50, 0.43,
        0.59, 0.90, 0.95, 0.82, 1.04, 1.53, 1.94, 1.75, 1.99),
  X = c(8.8, 9.4, 10.0, 10.6, 11.0, 11.9, 12.7, 13.5, 14.3,
        15.5, 16.7, 17.7, 18.6, 19.7, 21.1, 22.8, 23.9, 25.2)
)
pou$D <- as.integer(pou$ano <= 1951)      # 1 de 1946 a 1951

m57b <- lm(Y ~ X, data = pou)                       # sem dummy
m57c <- lm(Y ~ D + X, data = pou)                   # dummy de intercepto
m57d <- lm(Y ~ I(X * D) + X, data = pou)            # dummy de inclinação
m57e <- lm(Y ~ D + I(X * D) + X, data = pou)        # intercepto e inclinação

for (par in list(c("b", "m57b"), c("c", "m57c"), c("d", "m57d"), c("e", "m57e"))) {
  m <- get(par[2]); s <- summary(m)
  registrar(paste0("m09_ex57", par[1], "_r2"), s$r.squared)
  registrar(paste0("m09_ex57", par[1], "_ssr"), sum(residuals(m)^2))
  for (k in seq_len(nrow(s$coefficients))) {
    nome <- gsub("[^A-Za-z0-9]", "", rownames(s$coefficients)[k])
    registrar(paste0("m09_ex57", par[1], "_b_", nome), unname(s$coefficients[k, 1]))
    registrar(paste0("m09_ex57", par[1], "_t_", nome), unname(s$coefficients[k, 3]))
    registrar(paste0("m09_ex57", par[1], "_p_", nome), unname(s$coefficients[k, 4]))
  }
}
registrar("m09_ex57_tcrit_5pct_gl15", qt(0.975, df.residual(m57d)))

# Chow: regressões separadas nos dois períodos contra a pooled
m1 <- lm(Y ~ X, data = subset(pou, D == 1))
m2 <- lm(Y ~ X, data = subset(pou, D == 0))
ssr_p <- sum(residuals(m57b)^2)
ssr_1 <- sum(residuals(m1)^2); ssr_2 <- sum(residuals(m2)^2)
K <- 2; n1 <- sum(pou$D == 1); n2 <- sum(pou$D == 0)
F_chow <- ((ssr_p - (ssr_1 + ssr_2)) / K) / ((ssr_1 + ssr_2) / (n1 + n2 - 2 * K))
registrar("m09_chow_ssr_pooled", ssr_p)
registrar("m09_chow_ssr_1", ssr_1)
registrar("m09_chow_ssr_2", ssr_2)
registrar("m09_chow_F", F_chow)
registrar("m09_chow_p", pf(F_chow, K, n1 + n2 - 2 * K, lower.tail = FALSE))
registrar("m09_chow_Fcrit5", qf(0.95, K, n1 + n2 - 2 * K))
# O mesmo F sai do modelo totalmente interagido (ex. 60)
F_inter <- anova(m57b, m57e)$F[2]
registrar("m09_chow_F_interagido", F_inter)
registrar("m09_chow_dif", abs(F_chow - F_inter))

png(fig("09_ex57_dummies.png"), width = 1600, height = 1000, res = 200)
plot(pou$X, pou$Y, pch = ifelse(pou$D == 1, 19, 1), xlab = "renda", ylab = "poupança",
     main = "Poupança e renda: dois regimes (1946-51 cheio, 1952-63 vazio)")
abline(m57b, lwd = 2)
abline(a = coef(m57e)[1] + coef(m57e)[2], b = coef(m57e)[4] + coef(m57e)[3], lwd = 2, lty = 2)
abline(a = coef(m57e)[1], b = coef(m57e)[4], lwd = 2, lty = 3)
legend("topleft", c("pooled", "1946-51", "1952-63"), lwd = 2, lty = 1:3, bty = "n")
dev.off()

## ---- Ex. 61 — Armadilha da variável dummy ----------------------------------
n <- 5
D1 <- c(1, 0, 1, 0, 1)          # homem
D2 <- 1 - D1                    # mulher
Xtrap <- cbind(const = 1, D1 = D1, D2 = D2)
registrar("m09_ex61_posto", qr(Xtrap)$rank)
registrar("m09_ex61_K", ncol(Xtrap))
registrar("m09_ex61_det_XtX", det(crossprod(Xtrap)))
registrar("m09_ex61_autoval_min", min(eigen(crossprod(Xtrap))$values))
# Sem a constante (ou com uma só dummy), o posto é completo
registrar("m09_ex61_posto_sem_const", qr(cbind(D1, D2))$rank)
registrar("m09_ex61_posto_uma_dummy", qr(cbind(const = 1, D1 = D1))$rank)

## ---- Efeito exato de dummy em modelo log (P1 2025/2, item SOUTH) -----------
b_south <- -0.07629062
registrar("m09_dummy_aprox_pct", 100 * b_south)
registrar("m09_dummy_exato_pct", 100 * (exp(b_south) - 1))
registrar("m09_dummy_dif_pp", 100 * b_south - 100 * (exp(b_south) - 1))

## ---- Ponto de máximo do quadrático (P1 2025/2, Q1c) ------------------------
a3 <- 0.04291665; a4 <- -0.00070803
registrar("m09_quad_a3", a3)
registrar("m09_quad_a4", a4)
registrar("m09_quad_xstar", -a3 / (2 * a4))
registrar("m09_quad_segunda_derivada", 2 * a4)

## ---- Ex. 47 e 48 — Linearização --------------------------------------------
set.seed(31)
n <- 200
x1 <- exp(rnorm(n)); x2 <- exp(rnorm(n))
A <- 2; alfa <- 0.6; beta <- 0.3
u <- rnorm(n, 0, 0.1)
Ycd <- A * x1^alfa * x2^beta * exp(u)         # erro multiplicativo: log lineariza
m_cd <- lm(log(Ycd) ~ log(x1) + log(x2))
registrar("m09_ex47_alfa_hat", unname(coef(m_cd)[2]))
registrar("m09_ex47_beta_hat", unname(coef(m_cd)[3]))
registrar("m09_ex47_A_hat", exp(unname(coef(m_cd)[1])))
registrar("m09_ex47_soma", unname(coef(m_cd)[2] + coef(m_cd)[3]))
# Com erro aditivo, o log NÃO lineariza: o estimador fica viesado
Ycd_ad <- A * x1^alfa * x2^beta + rnorm(n, 0, 0.5)
m_cd_ad <- lm(log(pmax(Ycd_ad, 1e-6)) ~ log(x1) + log(x2))
registrar("m09_ex47_alfa_aditivo", unname(coef(m_cd_ad)[2]))

## ---- Ex. 71 e 72 — Diferenças em diferenças --------------------------------
set.seed(2610)
N <- 400
dados <- data.frame(id = rep(1:N, each = 2), t = rep(0:1, times = N))
dados$D <- rep(rbinom(N, 1, 0.5), each = 2)
efeito_fixo <- rep(rnorm(N, 0, 1), each = 2)
x_invariante <- rep(rnorm(N, 0, 1), each = 2)          # característica fixa no tempo
dados$x <- x_invariante
beta3 <- 1.5
dados$y <- 1 + 0.7 * dados$D + 0.4 * dados$t + beta3 * dados$D * dados$t +
  0.8 * dados$x + efeito_fixo + rnorm(2 * N, 0, 0.5)

med <- with(dados, tapply(y, list(D, t), mean))
did_medias <- (med["1", "1"] - med["1", "0"]) - (med["0", "1"] - med["0", "0"])
m_did <- lm(y ~ D * t, data = dados)
registrar("m09_did_beta3_verdadeiro", beta3)
registrar("m09_did_medias", did_medias)
registrar("m09_did_regressao", unname(coef(m_did)["D:t"]))
registrar("m09_did_dif", abs(did_medias - unname(coef(m_did)["D:t"])))
registrar("m09_did_ep", unname(summary(m_did)$coefficients["D:t", 2]))
# Com o controle invariante no tempo incluído, o coeficiente de interação não muda
m_did_x <- lm(y ~ D * t + x, data = dados)
registrar("m09_did_com_x", unname(coef(m_did_x)["D:t"]))
registrar("m09_did_dif_com_x", abs(unname(coef(m_did_x)["D:t"]) - unname(coef(m_did)["D:t"])))
# Em primeiras diferenças, a característica invariante some
larga <- reshape(dados[, c("id", "t", "y", "D", "x")], idvar = "id",
                 timevar = "t", direction = "wide")
larga$dy <- larga$y.1 - larga$y.0
m_fd <- lm(dy ~ D.0, data = larga)
registrar("m09_did_primeiras_dif", unname(coef(m_fd)[2]))
registrar("m09_did_fd_dif", abs(unname(coef(m_fd)[2]) - did_medias))

png(fig("09_did.png"), width = 1600, height = 1000, res = 200)
matplot(c(0, 1), cbind(med["0", ], med["1", ]), type = "b", pch = 19, lwd = 2, lty = 1:2,
        xaxt = "n", xlab = "período", ylab = "média de y",
        main = "Diferenças em diferenças: médias por grupo e período")
axis(1, at = c(0, 1), labels = c("antes", "depois"))
contraf <- c(med["1", "0"], med["1", "0"] + (med["0", "1"] - med["0", "0"]))
lines(c(0, 1), contraf, lwd = 2, lty = 3)
legend("topleft", c("controle", "tratado", "contrafactual"), lwd = 2, lty = c(1, 2, 3), bty = "n")
dev.off()

gravar_resultados("m09")
