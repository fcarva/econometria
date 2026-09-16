# Módulo 08 — Assintótica: consistência, normalidade assintótica, HC0, método delta
# Exercício 73 da Lista 1 (Monte Carlo do TLC) e as verificações numéricas do 08_teoria.md.
# Rodar: powershell -ExecutionPolicy Bypass -File scripts\r.ps1 08_assintotica\08_assintotica.R

# --- bootstrap: localizar a raiz do repo e carregar helpers ---
.d <- getwd(); while (!file.exists(file.path(.d, ".repo-root")) && dirname(.d) != .d) .d <- dirname(.d)
source(file.path(.d, "R", "raiz.R"))

suppressPackageStartupMessages({
  library(AER)
  library(sandwich)
})

fig <- function(nome) file.path(raiz(), "08_assintotica", "figuras", nome)

## ---- Ex. 73 — Monte Carlo do Teorema do Limite Central ----------------------
# 1000 valores N(0,1), média amostral; repetir 1000 vezes; histograma e densidade.
set.seed(20261002)
R <- 1000
n <- 1000

medias_normal <- replicate(R, mean(rnorm(n, mean = 0, sd = 1)))

registrar("m08_ex73_R", R)
registrar("m08_ex73_n", n)
registrar("m08_ex73_media_das_medias", mean(medias_normal))
registrar("m08_ex73_dp_das_medias", sd(medias_normal))
registrar("m08_ex73_dp_teorico", 1 / sqrt(n))          # sigma/sqrt(n)
registrar("m08_ex73_assimetria", mean((medias_normal - mean(medias_normal))^3) / sd(medias_normal)^3)
registrar("m08_ex73_curtose", mean((medias_normal - mean(medias_normal))^4) / sd(medias_normal)^4)
registrar("m08_ex73_jb_p", tseries::jarque.bera.test(medias_normal)$p.value)

png(fig("08_ex73_tlc_normal.png"), width = 1600, height = 1000, res = 200)
hist(medias_normal, breaks = 30, freq = FALSE, col = "grey85", border = "white",
     main = "Distribuição das médias amostrais (1000 amostras de n = 1000)",
     xlab = "média amostral", ylab = "densidade")
lines(density(medias_normal), lwd = 2)
curve(dnorm(x, 0, 1 / sqrt(n)), add = TRUE, lwd = 2, lty = 2)
legend("topright", c("densidade estimada", "N(0, 1/n) teórica"), lwd = 2, lty = c(1, 2), bty = "n")
dev.off()

# O TLC não precisa de normalidade na população: repetir com exponencial assimétrica.
set.seed(20261002)
medias_exp_n5   <- replicate(R, mean(rexp(5, rate = 1)))
medias_exp_n30  <- replicate(R, mean(rexp(30, rate = 1)))
medias_exp_n200 <- replicate(R, mean(rexp(200, rate = 1)))

assim <- function(x) mean((x - mean(x))^3) / sd(x)^3
registrar("m08_ex73_exp_assim_n5", assim(medias_exp_n5))
registrar("m08_ex73_exp_assim_n30", assim(medias_exp_n30))
registrar("m08_ex73_exp_assim_n200", assim(medias_exp_n200))
registrar("m08_ex73_exp_jb_p_n5", tseries::jarque.bera.test(medias_exp_n5)$p.value)
registrar("m08_ex73_exp_jb_p_n200", tseries::jarque.bera.test(medias_exp_n200)$p.value)

png(fig("08_ex73_tlc_exponencial.png"), width = 1600, height = 1000, res = 200)
op <- par(mfrow = c(1, 3), mar = c(4, 4, 3, 1))
for (obj in list(list(x = medias_exp_n5, t = "n = 5"),
                 list(x = medias_exp_n30, t = "n = 30"),
                 list(x = medias_exp_n200, t = "n = 200"))) {
  hist(obj$x, breaks = 25, freq = FALSE, col = "grey85", border = "white",
       main = obj$t, xlab = "média amostral", ylab = "densidade")
  lines(density(obj$x), lwd = 2)
  curve(dnorm(x, 1, 1 / sqrt(length(obj$x[1]) * 0 + as.numeric(sub("n = ", "", obj$t)))),
        add = TRUE, lwd = 2, lty = 2)
}
par(op)
dev.off()

## ---- Consistência do MQO e de s^2 -------------------------------------------
set.seed(11)
beta <- c(1, 2)
sigma <- 3
consist <- function(n, reps = 400) {
  b2 <- numeric(reps); s2 <- numeric(reps)
  for (r in seq_len(reps)) {
    x <- runif(n, 0, 10)
    y <- beta[1] + beta[2] * x + rnorm(n, 0, sigma)
    m <- lm(y ~ x)
    b2[r] <- coef(m)[2]
    s2[r] <- summary(m)$sigma^2
  }
  c(media_b2 = mean(b2), dp_b2 = sd(b2), media_s2 = mean(s2))
}
for (n_i in c(25, 100, 400, 1600)) {
  res <- consist(n_i)
  registrar(paste0("m08_consist_b2_n", n_i), res[["media_b2"]])
  registrar(paste0("m08_consist_dp_n", n_i), res[["dp_b2"]])
  registrar(paste0("m08_consist_s2_n", n_i), res[["media_s2"]])
}

## ---- HC0 à mão é igual ao sandwich::vcovHC ---------------------------------
set.seed(7)
n <- 200
x <- runif(n, 1, 10)
y <- 1 + 0.5 * x + rnorm(n, 0, x / 3)          # heterocedasticidade proposital
m <- lm(y ~ x)
X <- model.matrix(m)
e <- residuals(m)
XtX_inv <- solve(crossprod(X))
meat <- crossprod(X * e)                       # soma de e_i^2 x_i x_i'
V_hc0_manual <- XtX_inv %*% meat %*% XtX_inv
V_hc0_pacote <- vcovHC(m, type = "HC0")

registrar("m08_hc0_manual_b2", sqrt(V_hc0_manual[2, 2]))
registrar("m08_hc0_pacote_b2", sqrt(V_hc0_pacote[2, 2]))
registrar("m08_hc0_dif_max", max(abs(V_hc0_manual - V_hc0_pacote)))
registrar("m08_ep_mqo_b2", sqrt(vcov(m)[2, 2]))
registrar("m08_razao_hc0_mqo", sqrt(V_hc0_manual[2, 2]) / sqrt(vcov(m)[2, 2]))

## ---- Método delta: ponto de máximo da experiência (P1 2025/2, Q1c) ----------
data("PSID7682", package = "AER")
d <- PSID7682
mod <- lm(log(wage) ~ education + experience + I(experience^2) + occupation +
            industry + south + smsa + ethnicity + weeks, data = d)

a3 <- unname(coef(mod)["experience"])
a4 <- unname(coef(mod)["I(experience^2)"])
exp_star <- -a3 / (2 * a4)

g <- c(-1 / (2 * a4), a3 / (2 * a4^2))                      # gradiente de -a3/(2a4)
V <- vcov(mod)[c("experience", "I(experience^2)"), c("experience", "I(experience^2)")]
ep_delta <- sqrt(as.numeric(t(g) %*% V %*% g))

registrar("m08_delta_a3", a3)
registrar("m08_delta_a4", a4)
registrar("m08_delta_exp_star", exp_star)
registrar("m08_delta_ep", ep_delta)
registrar("m08_delta_ic_lo", exp_star - 1.96 * ep_delta)
registrar("m08_delta_ic_hi", exp_star + 1.96 * ep_delta)

# Bootstrap de pares para comparar com o método delta
set.seed(99)
B <- 500
boot_star <- numeric(B)
for (b in seq_len(B)) {
  idx <- sample(nrow(d), replace = TRUE)
  mb <- lm(log(wage) ~ education + experience + I(experience^2) + occupation +
             industry + south + smsa + ethnicity + weeks, data = d[idx, ])
  boot_star[b] <- -coef(mb)["experience"] / (2 * coef(mb)["I(experience^2)"])
}
registrar("m08_boot_B", B)
registrar("m08_boot_media", mean(boot_star))
registrar("m08_boot_ep", sd(boot_star))
registrar("m08_boot_ep_sobre_delta", sd(boot_star) / ep_delta)

png(fig("08_delta_bootstrap.png"), width = 1600, height = 1000, res = 200)
hist(boot_star, breaks = 30, freq = FALSE, col = "grey85", border = "white",
     main = "Ponto de máximo da experiência: bootstrap contra método delta",
     xlab = "anos de experiência no máximo do log-salário", ylab = "densidade")
abline(v = exp_star, lwd = 2)
curve(dnorm(x, exp_star, ep_delta), add = TRUE, lwd = 2, lty = 2)
legend("topright", c("estimativa pontual", "N(delta) teórica"), lwd = 2, lty = c(1, 2), bty = "n")
dev.off()

## ---- Normalidade assintótica de b com erro não normal -----------------------
set.seed(2026)
norm_assint <- function(n, reps = 2000) {
  z <- numeric(reps)
  for (r in seq_len(reps)) {
    x <- runif(n, 0, 5)
    u <- (rexp(n, 1) - 1) * 2                 # erro assimétrico, média zero
    y <- 1 + 0.8 * x + u
    m <- lm(y ~ x)
    z[r] <- (coef(m)[2] - 0.8) / sqrt(vcov(m)[2, 2])
  }
  z
}
for (n_i in c(10, 50, 500)) {
  z <- norm_assint(n_i)
  registrar(paste0("m08_zassim_tam5pct_n", n_i), mean(abs(z) > 1.959964))
  registrar(paste0("m08_zassim_assim_n", n_i), assim(z))
}

gravar_resultados("m08")
