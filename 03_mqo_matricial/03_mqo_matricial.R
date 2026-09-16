# Módulo 03 — Álgebra matricial do MQO (SL03; Lista 1, ex. 23, 24, 28–31, 34, 35)
# id do script: m03
# Rodar: powershell -ExecutionPolicy Bypass -File scripts\r.ps1 03_mqo_matricial\03_mqo_matricial.R

# --- bootstrap: localizar a raiz do repo e carregar helpers ---
.d <- getwd(); while (!file.exists(file.path(.d, ".repo-root")) && dirname(.d) != .d) .d <- dirname(.d)
source(file.path(.d, "R", "raiz.R"))

dir_fig <- caminho_repo("03_mqo_matricial", "figuras")
dir.create(dir_fig, showWarnings = FALSE, recursive = TRUE)

# Erro máximo absoluto entre dois objetos numéricos (para checar identidades)
erro_max <- function(a, b = 0) max(abs(a - b))

## ---- Ex. 34: MQO matricial à mão (Lista 1, ex. 34) ----
# Dados da Lista 1, ex. 34: y = (2,3,5,4,6)', X = [1 | (2,4,6,8,10)]
y <- c(2, 3, 5, 4, 6)
x <- c(2, 4, 6, 8, 10)
X <- cbind(1, x)
n <- nrow(X); K <- ncol(X)

XtX <- crossprod(X)                 # X'X (2 x 2)
Xty <- crossprod(X, y)              # X'y (2 x 1)
detXtX <- XtX[1, 1] * XtX[2, 2] - XtX[1, 2] * XtX[2, 1]
adjXtX <- matrix(c(XtX[2, 2], -XtX[2, 1], -XtX[1, 2], XtX[1, 1]), 2, 2)  # adjunta (2 x 2)
XtXinv <- adjXtX / detXtX
stopifnot(erro_max(XtXinv, solve(XtX)) < 1e-12)

b <- drop(XtXinv %*% Xty)
yhat <- drop(X %*% b)
e <- y - yhat
ee <- sum(e^2)
yy <- sum(y^2)
bXty <- sum(b * Xty)
s2 <- ee / (n - K)
Vb <- s2 * XtXinv
se <- sqrt(diag(Vb))
tstat <- b / se
SQT <- sum((y - mean(y))^2)
SQReg <- sum((yhat - mean(y))^2)
R2 <- 1 - ee / SQT

# conferência com lm()
fit <- lm(y ~ x)
stopifnot(erro_max(coef(fit), b) < 1e-12, erro_max(sqrt(diag(vcov(fit))), se) < 1e-12)

registrar_varios(list(
  m03_ex34_n = n,
  m03_ex34_xtx11 = XtX[1, 1], m03_ex34_xtx12 = XtX[1, 2], m03_ex34_xtx22 = XtX[2, 2],
  m03_ex34_det = detXtX,
  m03_ex34_inv11 = XtXinv[1, 1], m03_ex34_inv12 = XtXinv[1, 2], m03_ex34_inv22 = XtXinv[2, 2],
  m03_ex34_xty1 = Xty[1], m03_ex34_xty2 = Xty[2],
  m03_ex34_b1 = b[1], m03_ex34_b2 = b[2],
  m03_ex34_yhat1 = yhat[1], m03_ex34_yhat2 = yhat[2], m03_ex34_yhat3 = yhat[3],
  m03_ex34_yhat4 = yhat[4], m03_ex34_yhat5 = yhat[5],
  m03_ex34_e1 = e[1], m03_ex34_e2 = e[2], m03_ex34_e3 = e[3], m03_ex34_e4 = e[4], m03_ex34_e5 = e[5],
  m03_ex34_soma_e = sum(e), m03_ex34_soma_xe = sum(x * e),
  m03_ex34_ee = ee, m03_ex34_yy = yy, m03_ex34_bxty = bXty, m03_ex34_ee_via_yy = yy - bXty,
  m03_ex34_s2 = s2, m03_ex34_s = sqrt(s2),
  m03_ex34_var_b1 = Vb[1, 1], m03_ex34_cov_b12 = Vb[1, 2], m03_ex34_var_b2 = Vb[2, 2],
  m03_ex34_se_b1 = se[1], m03_ex34_se_b2 = se[2],
  m03_ex34_t_b1 = tstat[1], m03_ex34_t_b2 = tstat[2],
  m03_ex34_sqt = SQT, m03_ex34_sqreg = SQReg, m03_ex34_r2 = R2,
  m03_ex34_media_yhat = mean(yhat), m03_ex34_media_y = mean(y)
))

# Conferência pela rota escalar (notação da Lista 1): b2 = Sxy/Sxx e b1 = ybar - b2*xbar
Sxx <- sum((x - mean(x))^2); Sxy <- sum((x - mean(x)) * (y - mean(y)))
stopifnot(abs(Sxy / Sxx - b[2]) < 1e-12, abs(detXtX - n * Sxx) < 1e-12)
registrar_varios(list(
  m03_ex34_xbar = mean(x), m03_ex34_ybar = mean(y),
  m03_ex34_sxx = Sxx, m03_ex34_sxy = Sxy,
  m03_ex34_adj11 = adjXtX[1, 1], m03_ex34_adj12 = adjXtX[1, 2], m03_ex34_adj22 = adjXtX[2, 2],
  m03_ex34_yhat_yhat = sum(yhat^2),               # y'y = yhat'yhat + e'e (Pitágoras)
  m03_ex34_tcrit = qt(0.975, n - K),              # t crítico bilateral a 5% com n - K = 3 gl
  m03_ex34_p_b2 = 2 * pt(-abs(tstat[2]), n - K)   # p-valor de H0: beta2 = 0
))

# Autovalores de X'X (condição de 2ª ordem: ambos > 0 => positiva definida)
ev <- eigen(XtX, symmetric = TRUE)$values
registrar("m03_ex34_autoval_max", ev[1])
registrar("m03_ex34_autoval_min", ev[2])

## ---- Ex. 28, 29: P e M no exemplo do ex. 34 ----
P <- X %*% XtXinv %*% t(X)
M <- diag(n) - P
registrar_varios(list(
  m03_ex34_trP = sum(diag(P)), m03_ex34_trM = sum(diag(M)),
  m03_ex34_h1 = P[1, 1], m03_ex34_h2 = P[2, 2], m03_ex34_h3 = P[3, 3],
  m03_ex34_h4 = P[4, 4], m03_ex34_h5 = P[5, 5],
  m03_ex34_erro_My = erro_max(M %*% y, e),       # e = My (ex. 28)
  m03_ex34_erro_Py = erro_max(P %*% y, yhat),    # yhat = Py (ex. 29)
  m03_ex34_erro_Xte = erro_max(crossprod(X, e))  # X'e = 0 (ex. 31)
))

## ---- Propriedades de P e M numa matriz X genérica (n = 50, K = 4) ----
set.seed(3003)
n2 <- 50; K2 <- 4
X2 <- cbind(1, matrix(rnorm(n2 * (K2 - 1)), n2, K2 - 1))
y2 <- drop(X2 %*% c(1, 0.5, -0.3, 2) + rnorm(n2))
P2 <- X2 %*% solve(crossprod(X2)) %*% t(X2)
M2 <- diag(n2) - P2
b2 <- solve(crossprod(X2), crossprod(X2, y2))
e2 <- drop(y2 - X2 %*% b2)
M0 <- diag(n2) - matrix(1 / n2, n2, n2)
registrar_varios(list(
  m03_gen_erro_simP = erro_max(P2, t(P2)),
  m03_gen_erro_idemP = erro_max(P2 %*% P2, P2),
  m03_gen_erro_simM = erro_max(M2, t(M2)),
  m03_gen_erro_idemM = erro_max(M2 %*% M2, M2),
  m03_gen_erro_PX = erro_max(P2 %*% X2, X2),
  m03_gen_erro_MX = erro_max(M2 %*% X2),
  m03_gen_erro_PM = erro_max(P2 %*% M2),
  m03_gen_trP = sum(diag(P2)), m03_gen_trM = sum(diag(M2)),
  m03_gen_postoM = qr(M2)$rank,
  m03_gen_erro_Xte = erro_max(crossprod(X2, e2)),
  m03_gen_erro_ee = abs(sum(e2^2) - (sum(y2^2) - sum(b2 * crossprod(X2, y2)))),
  m03_gen_erro_decomp = abs(drop(t(y2) %*% M0 %*% y2) -
                              (drop(t(b2) %*% t(X2) %*% M0 %*% X2 %*% b2) + sum(e2^2)))
))

# Gradiente numérico de S(b) = (y - Xb)'(y - Xb) vs. fórmula -2X'y + 2X'Xb (D03.1–D03.2)
S <- function(bb) sum((y2 - X2 %*% bb)^2)
b_teste <- c(0.2, -1, 0.7, 1.5)
h <- 1e-6
grad_num <- vapply(seq_len(K2), function(k) {
  d <- numeric(K2); d[k] <- h
  (S(b_teste + d) - S(b_teste - d)) / (2 * h)
}, numeric(1))
grad_form <- drop(-2 * crossprod(X2, y2) + 2 * crossprod(X2) %*% b_teste)
registrar("m03_gen_erro_grad", erro_max(grad_num, grad_form) / max(abs(grad_form)))

# S(b~) = S(b) + (b~ - b)'X'X(b~ - b): identidade de "completar o quadrado" (D03.3)
registrar("m03_gen_erro_quadrado",
          abs(S(b_teste) - (S(drop(b2)) + drop(t(b_teste - b2) %*% crossprod(X2) %*% (b_teste - b2)))))

## ---- Ex. 35: colinearidade perfeita (Lista 1, ex. 35) ----
# Dados da Lista 1, ex. 35: y = (2,3,5,4)', X = [1 | x2 | x3] com x3 = 2*x2
y35 <- c(2, 3, 5, 4)
x2 <- c(2, 4, 6, 8)
x3 <- c(4, 8, 12, 16)
X35 <- cbind(1, x2, x3)
XtX35 <- crossprod(X35)
Xty35 <- crossprod(X35, y35)
# determinante por cofatores, com aritmética exata de inteiros
cof_det3 <- function(A) {
  A[1, 1] * (A[2, 2] * A[3, 3] - A[2, 3] * A[3, 2]) -
    A[1, 2] * (A[2, 1] * A[3, 3] - A[2, 3] * A[3, 1]) +
    A[1, 3] * (A[2, 1] * A[3, 2] - A[2, 2] * A[3, 1])
}
det35 <- cof_det3(XtX35)
# menores da 1ª linha usados na expansão por cofatores
menor11 <- XtX35[2, 2] * XtX35[3, 3] - XtX35[2, 3] * XtX35[3, 2]
menor12 <- XtX35[2, 1] * XtX35[3, 3] - XtX35[2, 3] * XtX35[3, 1]
menor13 <- XtX35[2, 1] * XtX35[3, 2] - XtX35[2, 2] * XtX35[3, 1]
# vetor não nulo a com X a = 0 (x3 - 2 x2 = 0): a = (0, 2, -1)'
a_nulo <- c(0, 2, -1)
inversao_falha <- inherits(try(solve(XtX35), silent = TRUE), "try-error")
fit35 <- lm(y35 ~ x2 + x3)
# Combinações estimáveis: y em [1, x2] identifica beta1 e beta2 + 2*beta3
fit35r <- lm(y35 ~ x2)
# Duas soluções distintas das equações normais (X'X b = X'y) com o mesmo ajuste
bA <- c(coef(fit35r)[1], coef(fit35r)[2], 0)
bB <- c(coef(fit35r)[1], 0, coef(fit35r)[2] / 2)
registrar_varios(list(
  m03_ex35_xtx11 = XtX35[1, 1], m03_ex35_xtx12 = XtX35[1, 2], m03_ex35_xtx13 = XtX35[1, 3],
  m03_ex35_xtx22 = XtX35[2, 2], m03_ex35_xtx23 = XtX35[2, 3], m03_ex35_xtx33 = XtX35[3, 3],
  m03_ex35_xty1 = Xty35[1], m03_ex35_xty2 = Xty35[2], m03_ex35_xty3 = Xty35[3],
  m03_ex35_det = det35,
  m03_ex35_menor11 = menor11, m03_ex35_menor12 = menor12, m03_ex35_menor13 = menor13,
  m03_ex35_erro_Xa = erro_max(X35 %*% a_nulo),
  m03_ex35_erro_XtXa = erro_max(XtX35 %*% a_nulo),
  m03_ex35_posto = qr(X35)$rank,
  m03_ex35_autoval_min = min(eigen(XtX35, symmetric = TRUE)$values),
  m03_ex35_inversao_falha = as.numeric(inversao_falha),
  m03_ex35_lm_na = as.numeric(is.na(coef(fit35)["x3"])),
  m03_ex35_beta1_est = coef(fit35r)[1],
  m03_ex35_comb_est = coef(fit35r)[2],             # estima beta2 + 2*beta3
  m03_ex35_erro_EN_A = erro_max(XtX35 %*% bA, Xty35),
  m03_ex35_erro_EN_B = erro_max(XtX35 %*% bB, Xty35),
  m03_ex35_erro_ajuste_AB = erro_max(X35 %*% bA, X35 %*% bB),
  m03_ex35_ee = sum(resid(fit35r)^2)
))

# Torção: se a 3ª coluna fosse x2^2 (não linear em x2), X teria posto 3
X35q <- cbind(1, x2, x2^2)
b35q <- solve(crossprod(X35q), crossprod(X35q, y35))
registrar_varios(list(
  m03_ex35q_det = det(crossprod(X35q)),
  m03_ex35q_b1 = b35q[1], m03_ex35q_b2 = b35q[2], m03_ex35q_b3 = b35q[3],
  m03_ex35q_gl = length(y35) - 3
))

## ---- Ex. 24: não-viés de b por Monte Carlo (X fixo do ex. 34) ----
set.seed(2024)
beta <- c(1, 0.5); sigma <- 1; R <- 20000
A <- XtXinv %*% t(X)                    # (X'X)^{-1}X' (2 x 5), fixo
sim_b <- t(replicate(R, drop(A %*% (X %*% beta + rnorm(n, sd = sigma)))))
registrar_varios(list(
  m03_ex24_media_b1 = mean(sim_b[, 1]), m03_ex24_media_b2 = mean(sim_b[, 2]),
  m03_ex24_var_b2_sim = var(sim_b[, 2]), m03_ex24_var_b2_teo = sigma^2 * XtXinv[2, 2],
  m03_ex24_var_b1_sim = var(sim_b[, 1]), m03_ex24_var_b1_teo = sigma^2 * XtXinv[1, 1]
))

## ---- Saída da P1 2025/2 (Q1): identidades com os números impressos ----
# Números copiados do output impresso na prova (LWAGE, n = 4165, K = 10)
ee_p1 <- 581.2717; n_p1 <- 4165; K_p1 <- 10; dp_y_p1 <- 0.4615122
coef_p1 <- c(5.13171052, 0.06112766, 0.04291665, -0.00070803, -0.07814434,
             0.09066812, -0.07629062, 0.13789225, -0.26269494, 0.00484184)
media_p1 <- c(1, 12.8453782, 19.8537815, 514.405042, 0.51116447,
              0.39543818, 0.29027611, 0.65378151, 0.07226891, 46.8115246)
registrar_varios(list(
  m03_p1_gl = n_p1 - K_p1,
  m03_p1_s = sqrt(ee_p1 / (n_p1 - K_p1)),
  m03_p1_sqt = (n_p1 - 1) * dp_y_p1^2,
  m03_p1_r2 = 1 - ee_p1 / ((n_p1 - 1) * dp_y_p1^2),
  m03_p1_ybar_xbarb = sum(coef_p1 * media_p1)
))

## ---- Figuras ----
# (1) Geometria do MQO em R^3: y, sua projeção Py no plano col(X) e e = My
Xg <- cbind(c(1, 1, 1), c(-1, 0.5, 1.5)) # duas colunas em R^3 (constante e um regressor)
yg <- c(0.6, 2.4, 2.2)
Pg <- Xg %*% solve(crossprod(Xg)) %*% t(Xg)
yh_g <- drop(Pg %*% yg); e_g <- yg - yh_g
stopifnot(abs(sum(yh_g * e_g)) < 1e-12)            # (Py)'(My) = 0
# base ortonormal (u1, u2) do plano col(X); a normal é a direção de e = My,
# de modo que no novo sistema o plano é z = 0 e y fica acima dele
u1 <- Xg[, 1] / sqrt(sum(Xg[, 1]^2))
v <- Xg[, 2] - sum(Xg[, 2] * u1) * u1; u2 <- v / sqrt(sum(v^2))
nrm <- e_g / sqrt(sum(e_g^2))
coords <- function(p) c(sum(p * u1), sum(p * u2), sum(p * nrm))
Y <- coords(yg); YH <- coords(yh_g); X1c <- coords(Xg[, 1]); X2c <- coords(Xg[, 2])
png(file.path(dir_fig, "03_geometria_mqo.png"), width = 1600, height = 1000, res = 200)
par(mar = c(0.5, 0.5, 3, 0.5))
pm <- persp(x = c(-0.4, 3.8), y = c(-0.6, 2.3), z = matrix(0, 2, 2), zlim = c(0, 1),
            theta = 28, phi = 18, col = adjustcolor("grey85", 0.7), border = "grey55",
            box = FALSE, main = "Geometria do MQO: y = Py + My, com (Py)'(My) = 0")
pt <- function(p) trans3d(p[1], p[2], p[3], pm)
seta <- function(de, para, ...) {
  a <- pt(de); b <- pt(para)
  arrows(a$x, a$y, b$x, b$y, length = 0.1, lwd = 2.5, ...)
}
O <- c(0, 0, 0)
seta(O, X1c, col = "grey30"); seta(O, X2c, col = "grey30")
seta(O, YH, col = "steelblue4"); seta(YH, Y, col = "firebrick"); seta(O, Y, col = "black")
# marcador de ângulo reto no pé da perpendicular (e é ortogonal ao plano)
s_ang <- 0.12
d_e <- (Y - YH) / sqrt(sum((Y - YH)^2)); d_o <- (O - YH) / sqrt(sum((O - YH)^2))
qa <- rbind(YH + s_ang * d_e, YH + s_ang * (d_e + d_o), YH + s_ang * d_o)
qq <- trans3d(qa[, 1], qa[, 2], qa[, 3], pm); lines(qq$x, qq$y, col = "firebrick", lwd = 1.5)
lab <- function(p, txt, ...) { q <- pt(p); text(q$x, q$y, txt, ...) }
lab(X1c + c(0.1, -0.3, 0), expression(x[1] == iota), col = "grey20")
lab(X2c + c(0, 0.3, 0), expression(x[2]), col = "grey20")
lab(Y + c(0, 0, 0.08), "y", font = 2)
lab(YH + c(0.3, 0.35, 0), expression(hat(y) == P * y), col = "steelblue4")
lab((Y + YH) / 2 + c(0.5, 0, 0), "e = My", col = "firebrick", font = 2)
lab(c(3.4, 2.1, 0), "col(X)", col = "grey40")
dev.off()

# (2) Ex. 34: dados, reta ajustada e resíduos
png(file.path(dir_fig, "03_ex34_ajuste.png"), width = 1600, height = 1000, res = 200)
par(mar = c(4.5, 4.5, 3, 1))
plot(x, y, pch = 19, cex = 1.3, xlim = c(1, 11), ylim = c(1, 7),
     xlab = "X", ylab = "Y", main = "Lista 1, ex. 34: reta de MQO e resíduos")
abline(b[1], b[2], col = "steelblue4", lwd = 2)
segments(x, y, x, yhat, col = "firebrick", lwd = 2, lty = 2)
points(mean(x), mean(y), pch = 4, cex = 2, lwd = 2)
fmt2 <- function(v) formatC(v, format = "f", digits = 2, decimal.mark = ",")
legend("topleft", bty = "n",
       legend = c(as.expression(bquote(hat(y) == .(fmt2(b[1])) + .(fmt2(b[2])) ~ X)),
                  expression("resíduos" ~ e == y - hat(y)),
                  expression("ponto médio" ~ (bar(X) * "," ~ bar(Y)))),
       col = c("steelblue4", "firebrick", "black"), lty = c(1, 2, NA), pch = c(NA, NA, 4), lwd = 2)
dev.off()

# (3) Ex. 24: distribuição de b2 em 20 000 amostras com X fixo
png(file.path(dir_fig, "03_ex24_nao_vies.png"), width = 1600, height = 1000, res = 200)
par(mar = c(4.5, 4.5, 3, 1))
hist(sim_b[, 2], breaks = 60, col = "grey80", border = "white", freq = FALSE,
     xlab = expression(b[2]), ylab = "densidade",
     main = "Não-viés: b2 em 20 000 amostras (X fixo do ex. 34, β2 = 0,5)")
curve(dnorm(x, beta[2], sigma * sqrt(XtXinv[2, 2])), add = TRUE, lwd = 2, col = "steelblue4")
abline(v = beta[2], col = "firebrick", lwd = 2)
abline(v = mean(sim_b[, 2]), col = "black", lwd = 2, lty = 2)
legend("topright", bty = "n", lwd = 2, lty = c(1, 2, 1),
       col = c("firebrick", "black", "steelblue4"),
       legend = c("β2 verdadeiro", "média simulada de b2", "N(β2, σ²[(X'X)⁻¹]₂₂)"))
dev.off()

gravar_resultados("m03")
