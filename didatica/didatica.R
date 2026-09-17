# Figuras didáticas: a intuição visual por trás de cada resultado do curso.
# Gera PNG e SVG em didatica/figuras/ e registra os números citados nas notas.
# Rodar: powershell -ExecutionPolicy Bypass -File scripts\r.ps1 didatica\didatica.R

# --- bootstrap: localizar a raiz do repo e carregar helpers ---
.d <- getwd(); while (!file.exists(file.path(.d, ".repo-root")) && dirname(.d) != .d) .d <- dirname(.d)
source(file.path(.d, "R", "raiz.R"))

FIG <- function(nome) file.path(raiz(), "didatica", "figuras", nome)

# título para figuras com vários painéis (desenhado na margem externa)
titulo_out <- function(titulo, subtitulo = NULL, fonte = NULL) {
  mtext(titulo, side = 3, line = 2.4, adj = 0, outer = TRUE, cex = 1.15, font = 2, col = CORES$texto)
  if (!is.null(subtitulo))
    mtext(subtitulo, side = 3, line = 1.0, adj = 0, outer = TRUE, cex = 0.88, col = CORES$eixo)
  if (!is.null(fonte))
    mtext(paste0("Fonte: ", fonte), side = 1, line = 1.6, adj = 0, outer = TRUE,
          cex = 0.72, col = CORES$eixo_claro)
}

SIMULADO <- "simulação própria, script didatica/didatica.R"

## ---- 1. A reta e os resíduos -----------------------------------------------
set.seed(42)
n1 <- 22
x1 <- runif(n1, 1, 9)
y1 <- 2 + 0.75 * x1 + rnorm(n1, 0, 1.1)
m1 <- lm(y1 ~ x1)
registrar("dtc_f1_b1", unname(coef(m1)[1]))
registrar("dtc_f1_b2", unname(coef(m1)[2]))
registrar("dtc_f1_soma_res", sum(residuals(m1)))
registrar("dtc_f1_xbar", mean(x1))
registrar("dtc_f1_ybar", mean(y1))

salvar_figura(FIG("dtc_01_reta_residuos"), function() {
  plot(x1, y1, xlim = c(0, 10), ylim = c(0, 12), pch = 19, col = CORES$neutra,
       xlab = "X (variável explicativa)", ylab = "Y (variável dependente)", axes = FALSE)
  grade_h(); axis(1, col = CORES$grade); axis(2, col = CORES$grade)
  segments(x1, y1, x1, fitted(m1), col = cor_alpha(CORES$negativa, 0.8), lwd = 1.6)
  abline(m1, col = CORES$principal, lwd = 2.6)
  points(mean(x1), mean(y1), pch = 21, bg = CORES$destaque, col = CORES$texto, cex = 1.9, lwd = 1.5)
  nota(mean(x1) + 0.15, mean(y1) - 0.9, "a reta sempre passa por (X barra, Y barra)", CORES$texto)
  nota(x1[which.max(abs(residuals(m1)))] - 0.15,
       y1[which.max(abs(residuals(m1)))], "resíduo: vertical, não perpendicular", CORES$negativa, pos = 2)
  legend("topleft", bty = "n", cex = 0.85, lwd = c(2.6, 1.6), col = c(CORES$principal, CORES$negativa),
         legend = c("reta de MQO", "resíduos"))
  titulo_editorial("A reta de regressão é a que deixa os resíduos verticais menores",
                   "Cada segmento vermelho é o que a reta não explicou naquela observação",
                   SIMULADO, "a soma dos resíduos é zero")
}, largura = 8, altura = 5.2)

## ---- 2. Por que quadrados --------------------------------------------------
salvar_figura(FIG("dtc_02_por_que_quadrados"), function() {
  par(mfrow = c(1, 3), oma = c(3.2, 0.6, 5, 0.6), mar = c(3.6, 3.6, 2.2, 1))
  desenha <- function(titulo, tipo) {
    plot(x1, y1, xlim = c(0, 10), ylim = c(0, 12), pch = 19, col = CORES$neutra,
         xlab = "X", ylab = "Y", axes = FALSE, main = titulo, col.main = CORES$texto, cex.main = 1)
    axis(1, col = CORES$grade); axis(2, col = CORES$grade); grade_h()
    if (tipo == "vertical") {
      segments(x1, y1, x1, fitted(m1), col = cor_alpha(CORES$negativa, 0.8), lwd = 1.5)
    } else if (tipo == "quadrado") {
      e <- residuals(m1)
      for (i in seq_along(x1)) {
        rect(x1[i], fitted(m1)[i], x1[i] + abs(e[i]) * 0.9, fitted(m1)[i] + e[i],
             col = cor_alpha(CORES$negativa, 0.22), border = cor_alpha(CORES$negativa, 0.5))
      }
    } else {
      b <- coef(m1)[2]; a <- coef(m1)[1]
      px <- (x1 + b * (y1 - a)) / (1 + b^2)
      segments(x1, y1, px, a + b * px, col = cor_alpha(CORES$roxo, 0.8), lwd = 1.5)
    }
    abline(m1, col = CORES$principal, lwd = 2.4)
  }
  desenha("1. distância vertical", "vertical")
  desenha("2. o quadrado dessa distância", "quadrado")
  desenha("3. distância perpendicular (não é MQO)", "perpendicular")
  titulo_out("Por que somar o quadrado do desvio vertical, e não outra distância",
             "Vertical porque o modelo explica Y a partir de X; ao quadrado porque pune muito o erro grande e é derivável",
             SIMULADO)
}, largura = 11, altura = 4.6)

## ---- 3. A decomposição da variação -----------------------------------------
salvar_figura(FIG("dtc_03_decomposicao"), function() {
  i <- which.max(x1)
  plot(x1, y1, xlim = c(0, 10), ylim = c(0, 12), pch = 19, col = cor_alpha(CORES$neutra, 0.55),
       xlab = "X", ylab = "Y", axes = FALSE)
  axis(1, col = CORES$grade); axis(2, col = CORES$grade)
  abline(h = mean(y1), col = CORES$eixo_claro, lwd = 1.6, lty = 2)
  abline(m1, col = CORES$principal, lwd = 2.6)
  xi <- x1[i]; yi <- y1[i]; yh <- fitted(m1)[i]
  segments(xi + 0.25, mean(y1), xi + 0.25, yi, col = CORES$texto, lwd = 3)
  segments(xi + 0.55, mean(y1), xi + 0.55, yh, col = CORES$positiva, lwd = 3)
  segments(xi + 0.85, yh, xi + 0.85, yi, col = CORES$negativa, lwd = 3)
  points(xi, yi, pch = 19, col = CORES$neutra, cex = 1.3)
  nota(xi - 3.6, mean(y1) + (yi - mean(y1)) * 0.55, "total: y - média", CORES$texto)
  nota(xi - 3.6, mean(y1) + (yh - mean(y1)) * 0.45, "explicado pela reta", CORES$positiva)
  nota(xi - 3.6, yh + (yi - yh) * 0.5 + 0.4, "resíduo", CORES$negativa)
  text(0.6, mean(y1) + 0.4, "média de Y", col = CORES$eixo_claro, cex = 0.8, pos = 4)
  titulo_editorial("SQT = SQE + SQR: cada desvio se parte em duas peças",
                   "O R² é a fração da barra preta que a barra verde consegue cobrir, somando todos os pontos",
                   SIMULADO, "só fecha assim com intercepto no modelo")
}, largura = 8, altura = 5.2)

## ---- 4. O alvo: viés e variância -------------------------------------------
salvar_figura(FIG("dtc_04_alvo"), function() {
  par(mfrow = c(2, 2), oma = c(3.2, 0.6, 5.2, 0.6), mar = c(1.2, 1.2, 2.4, 1.2))
  set.seed(7)
  painel <- function(titulo, cx, cy, sd) {
    plot(0, 0, type = "n", xlim = c(-3, 3), ylim = c(-3, 3), axes = FALSE, xlab = "", ylab = "",
         main = titulo, col.main = CORES$texto, cex.main = 0.95)
    for (r in c(2.6, 1.8, 1.0)) symbols(0, 0, circles = r, add = TRUE, inches = FALSE,
                                        fg = CORES$suave, bg = CORES$papel)
    symbols(0, 0, circles = 0.35, add = TRUE, inches = FALSE, fg = CORES$destaque, bg = CORES$destaque)
    points(rnorm(28, cx, sd), rnorm(28, cy, sd), pch = 19, col = cor_alpha(CORES$neutra, 0.85), cex = 1.05)
  }
  painel("não viesado e eficiente (MQO)", 0, 0, 0.35)
  painel("não viesado, mas impreciso", 0, 0, 1.15)
  painel("viesado, porém preciso", 1.5, 1.1, 0.35)
  painel("viesado e impreciso", 1.5, 1.1, 1.15)
  titulo_out("O alvo: viés é mirar torto; variância é ter a mão trêmula",
             "Gauss-Markov garante o quadrante de cima à esquerda dentro da classe dos estimadores lineares e não viesados",
             "figura conceitual, no espírito do desenho feito em aula")
}, largura = 8.4, altura = 6.4)

## ---- 5. Distribuição amostral do estimador ---------------------------------
set.seed(11)
beta_v <- c(2, 0.75); sigma_v <- 1.1; n5 <- 22
b2_sim <- replicate(4000, {
  xx <- runif(n5, 1, 9)
  yy <- beta_v[1] + beta_v[2] * xx + rnorm(n5, 0, sigma_v)
  unname(coef(lm(yy ~ xx))[2])
})
registrar("dtc_f5_media_b2", mean(b2_sim))
registrar("dtc_f5_dp_b2", sd(b2_sim))
registrar("dtc_f5_beta2", beta_v[2])

salvar_figura(FIG("dtc_05_distribuicao_amostral"), function() {
  par(mfrow = c(1, 2), oma = c(3.4, 0.6, 5, 0.6), mar = c(3.8, 3.8, 2.2, 1))
  set.seed(3)
  plot(0, 0, type = "n", xlim = c(0, 10), ylim = c(0, 12), xlab = "X", ylab = "Y", axes = FALSE,
       main = "cada amostra dá uma reta diferente", col.main = CORES$texto, cex.main = 1)
  axis(1, col = CORES$grade); axis(2, col = CORES$grade); grade_h()
  for (k in 1:12) {
    xx <- runif(n5, 1, 9); yy <- beta_v[1] + beta_v[2] * xx + rnorm(n5, 0, sigma_v)
    abline(lm(yy ~ xx), col = cor_alpha(CORES$neutra, 0.55), lwd = 1.3)
  }
  abline(a = beta_v[1], b = beta_v[2], col = CORES$compara, lwd = 3)
  legend("topleft", bty = "n", cex = 0.82, lwd = c(3, 1.3), col = c(CORES$compara, CORES$neutra),
         legend = c("reta verdadeira", "retas estimadas"))

  h <- hist(b2_sim, breaks = 40, plot = FALSE)
  plot(h, freq = FALSE, col = cor_alpha(CORES$principal, 0.45), border = CORES$papel,
       xlab = "estimativas de beta2", ylab = "densidade", main = "juntando 4 mil amostras",
       col.main = CORES$texto, cex.main = 1, axes = FALSE)
  axis(1, col = CORES$grade); axis(2, col = CORES$grade)
  curve(dnorm(x, mean(b2_sim), sd(b2_sim)), add = TRUE, col = CORES$texto, lwd = 2)
  abline(v = beta_v[2], col = CORES$compara, lwd = 2.4)
  titulo_out("O estimador é uma variável aleatória: a reta muda a cada amostra",
             "Não-viés quer dizer que o centro dessa distribuição é o valor verdadeiro; variância é a largura dela",
             SIMULADO)
}, largura = 11, altura = 4.8)

## ---- 6. Gauss-Markov: comparando dois estimadores --------------------------
set.seed(21)
n6 <- 20; xg <- seq(1, 10, length.out = n6)
sim6 <- replicate(4000, {
  yy <- 2 + 0.75 * xg + rnorm(n6, 0, 1.1)
  c(mqo = unname(coef(lm(yy ~ xg))[2]),
    extremos = (yy[n6] - yy[1]) / (xg[n6] - xg[1]))
})
registrar("dtc_f6_var_mqo", var(sim6["mqo", ]))
registrar("dtc_f6_var_extremos", var(sim6["extremos", ]))
registrar("dtc_f6_razao", var(sim6["extremos", ]) / var(sim6["mqo", ]))

salvar_figura(FIG("dtc_06_gauss_markov"), function() {
  d1 <- density(sim6["mqo", ]); d2 <- density(sim6["extremos", ])
  plot(0, 0, type = "n", xlim = c(0.2, 1.3), ylim = c(0, max(d1$y) * 1.08),
       xlab = "estimativas da inclinação", ylab = "densidade", axes = FALSE)
  axis(1, col = CORES$grade); axis(2, col = CORES$grade); grade_h()
  polygon(d2, col = cor_alpha(CORES$compara, 0.35), border = CORES$compara, lwd = 2)
  polygon(d1, col = cor_alpha(CORES$principal, 0.45), border = CORES$principal, lwd = 2.4)
  abline(v = 0.75, col = CORES$texto, lwd = 2, lty = 2)
  legend("topright", bty = "n", cex = 0.85, fill = c(cor_alpha(CORES$principal, 0.45), cor_alpha(CORES$compara, 0.35)),
         border = c(CORES$principal, CORES$compara),
         legend = c("MQO", "estimador pelos pontos extremos"))
  titulo_editorial("Os dois acertam na média; só um deles é confiável",
                   "Ambos são lineares e não viesados — é a variância que separa o MQO do concorrente",
                   SIMULADO, "é o que Gauss-Markov afirma")
}, largura = 8, altura = 5)

## ---- 7. Geometria: projeção ------------------------------------------------
salvar_figura(FIG("dtc_07_projecao"), function() {
  plot(0, 0, type = "n", xlim = c(-0.4, 5.2), ylim = c(-0.4, 4.2), axes = FALSE, xlab = "", ylab = "")
  polygon(c(-0.2, 5.1, 5.1, -0.2), c(-0.2, -0.2, 1.1, 1.1), col = cor_alpha(CORES$suave, 0.5), border = NA)
  text(4.9, 0.72, "espaço gerado pelas colunas de X", col = CORES$eixo, cex = 0.82, pos = 2)
  arrows(0, 0, 3.6, 3.4, col = CORES$neutra, lwd = 3, length = 0.12)
  arrows(0, 0, 3.6, 0.45, col = CORES$principal, lwd = 3, length = 0.12)
  arrows(3.6, 0.45, 3.6, 3.4, col = CORES$negativa, lwd = 3, length = 0.12)
  rect(3.32, 0.45, 3.6, 0.73, border = CORES$eixo, lwd = 1.2)
  text(3.7, 3.4, "y", col = CORES$neutra, font = 2, pos = 3)
  text(3.6, 0.3, "y ajustado = Py", col = CORES$principal, font = 2, pos = 1)
  text(3.72, 2.0, "e = My", col = CORES$negativa, font = 2, pos = 4)
  nota(0.1, 3.7, "o ângulo reto é a condição X'e = 0", CORES$texto)
  titulo_editorial("MQO é a sombra de y no espaço das colunas de X",
                   "A parte explicada é a projeção; o resíduo é o que sobra, perpendicular a tudo que X consegue gerar",
                   "figura conceitual", "P projeta no plano, M no complemento")
}, largura = 8, altura = 5)

## ---- 8. Frisch-Waugh-Lovell ------------------------------------------------
set.seed(99)
n8 <- 120
x1f <- rnorm(n8); x2f <- 0.8 * x1f + rnorm(n8, 0, 0.7)
yf <- 1 + 1.5 * x1f + 1.0 * x2f + rnorm(n8, 0, 1)
m_longa <- lm(yf ~ x1f + x2f)
y_lim <- residuals(lm(yf ~ x1f)); x_lim <- residuals(lm(x2f ~ x1f))
m_fwl <- lm(y_lim ~ x_lim)
registrar("dtc_f8_b_longa", unname(coef(m_longa)["x2f"]))
registrar("dtc_f8_b_fwl", unname(coef(m_fwl)[2]))
registrar("dtc_f8_b_bruta", unname(coef(lm(yf ~ x2f))[2]))

salvar_figura(FIG("dtc_08_fwl"), function() {
  par(mfrow = c(1, 3), oma = c(3.4, 0.6, 5, 0.6), mar = c(3.8, 3.8, 2.4, 1))
  pl <- function(xx, yy, titulo, cor, sub) {
    plot(xx, yy, pch = 19, col = cor_alpha(cor, 0.5), xlab = sub, ylab = "", axes = FALSE,
         main = titulo, col.main = CORES$texto, cex.main = 0.98)
    axis(1, col = CORES$grade); axis(2, col = CORES$grade)
    abline(lm(yy ~ xx), col = cor, lwd = 2.6)
  }
  pl(x2f, yf, sprintf("1. cru: inclinação %.2f", coef(lm(yf ~ x2f))[2]), CORES$compara, "X2 observado")
  pl(x_lim, y_lim, sprintf("2. limpos de X1: inclinação %.2f", coef(m_fwl)[2]), CORES$principal,
     "parte de X2 que X1 não explica")
  plot(0, 0, type = "n", xlim = c(0, 1), ylim = c(0, 1), axes = FALSE, xlab = "", ylab = "",
       main = "3. o que a regressão múltipla faz", col.main = CORES$texto, cex.main = 0.98)
  text(0.02, 0.80, "Coeficiente de X2 na regressão múltipla:", pos = 4, cex = 1.0, col = CORES$texto)
  text(0.02, 0.66, sprintf("%.4f", coef(m_longa)["x2f"]), pos = 4, cex = 1.5, font = 2, col = CORES$principal)
  text(0.02, 0.48, "Regressão simples com as partes limpas:", pos = 4, cex = 1.0, col = CORES$texto)
  text(0.02, 0.34, sprintf("%.4f", coef(m_fwl)[2]), pos = 4, cex = 1.5, font = 2, col = CORES$principal)
  text(0.02, 0.14, "o mesmo número, até a última casa", pos = 4, cex = 0.9, font = 3, col = CORES$eixo)
  titulo_out("\"Controlar por X1\" é literalmente limpar X1 de todo mundo antes de comparar",
             "Teorema de Frisch-Waugh-Lovell: o coeficiente da múltipla é o da simples entre os resíduos",
             SIMULADO)
}, largura = 11.5, altura = 4.8)

## ---- 9. Viés de variável omitida -------------------------------------------
set.seed(5)
n9 <- 150
z9 <- rbinom(n9, 1, 0.5)                    # variável omitida (dois grupos)
x9 <- 2 + 2.2 * z9 + rnorm(n9, 0, 0.6)
y9 <- 1 + 0.4 * x9 + 3.0 * z9 + rnorm(n9, 0, 0.5)
b_curta <- unname(coef(lm(y9 ~ x9))[2])
b_longa <- unname(coef(lm(y9 ~ x9 + z9))[2])
registrar("dtc_f9_b_curta", b_curta)
registrar("dtc_f9_b_longa", b_longa)
registrar("dtc_f9_beta_verdadeiro", 0.4)

salvar_figura(FIG("dtc_09_vies_omissao"), function() {
  plot(x9, y9, pch = 19, col = ifelse(z9 == 1, cor_alpha(CORES$compara, 0.6), cor_alpha(CORES$neutra, 0.6)),
       xlab = "X observado", ylab = "Y", axes = FALSE)
  axis(1, col = CORES$grade); axis(2, col = CORES$grade); grade_h()
  abline(lm(y9 ~ x9), col = CORES$negativa, lwd = 3)
  for (g in 0:1) {
    idx <- z9 == g
    cg <- coef(lm(y9[idx] ~ x9[idx]))
    xg0 <- min(x9[idx]); xg1 <- max(x9[idx])
    segments(xg0, cg[1] + cg[2] * xg0, xg1, cg[1] + cg[2] * xg1, col = CORES$principal, lwd = 2.8)
  }
  legend("bottomright", bty = "n", cex = 0.85, lwd = c(3, 2.8), col = c(CORES$negativa, CORES$principal),
         legend = c(sprintf("ignorando o grupo: inclinação %.2f", b_curta),
                    sprintf("dentro de cada grupo: %.2f", b_longa)))
  titulo_editorial("Viés de omissão: a reta única confunde o efeito de X com o do grupo",
                   "Os dois grupos têm a mesma inclinação verdadeira; a reta que os ignora fica muito mais inclinada",
                   SIMULADO, "paradoxo de Simpson em versão contínua")
}, largura = 8, altura = 5.2)

## ---- 10. Multicolinearidade ------------------------------------------------
set.seed(77)
n10 <- 60
elipse <- function(centro, V, escala = 2, pontos = 200) {
  ang <- seq(0, 2 * pi, length.out = pontos)
  ev <- eigen(V)
  raio <- escala * sqrt(pmax(ev$values, 0))
  circ <- rbind(cos(ang), sin(ang)) * raio
  t(centro + ev$vectors %*% circ)
}
xa <- rnorm(n10); xb_col <- 0.97 * xa + rnorm(n10, 0, 0.22); xb_ind <- rnorm(n10)
V_col <- vcov(lm(rnorm(n10) ~ xa + xb_col))[2:3, 2:3]
V_ind <- vcov(lm(rnorm(n10) ~ xa + xb_ind))[2:3, 2:3]
registrar("dtc_f10_cor_colinear", cor(xa, xb_col))
registrar("dtc_f10_fiv_colinear", 1 / (1 - cor(xa, xb_col)^2))
registrar("dtc_f10_fiv_independente", 1 / (1 - cor(xa, xb_ind)^2))

salvar_figura(FIG("dtc_10_multicolinearidade"), function() {
  par(mfrow = c(1, 2), oma = c(3.4, 0.6, 5, 0.6), mar = c(3.8, 3.8, 2.4, 1))
  plot(xa, xb_col, pch = 19, col = cor_alpha(CORES$compara, 0.6), xlab = "X2", ylab = "X3", axes = FALSE,
       main = sprintf("os dois regressores quase coincidem (r = %.2f)", cor(xa, xb_col)),
       col.main = CORES$texto, cex.main = 0.95)
  axis(1, col = CORES$grade); axis(2, col = CORES$grade)
  points(xa, xb_ind, pch = 19, col = cor_alpha(CORES$neutra, 0.45))
  legend("topleft", bty = "n", cex = 0.8, pch = 19, col = c(CORES$compara, CORES$neutra),
         legend = c("colineares", "independentes"))

  e_col <- elipse(c(0, 0), V_col); e_ind <- elipse(c(0, 0), V_ind)
  lim <- max(abs(c(e_col, e_ind)))
  plot(0, 0, type = "n", xlim = c(-lim, lim), ylim = c(-lim, lim), axes = FALSE,
       xlab = "erro na estimativa de beta2", ylab = "erro na estimativa de beta3",
       main = "região de incerteza dos coeficientes", col.main = CORES$texto, cex.main = 0.95)
  axis(1, col = CORES$grade); axis(2, col = CORES$grade)
  polygon(e_col, col = cor_alpha(CORES$compara, 0.3), border = CORES$compara, lwd = 2)
  polygon(e_ind, col = cor_alpha(CORES$principal, 0.35), border = CORES$principal, lwd = 2)
  abline(h = 0, v = 0, col = CORES$suave)
  titulo_out("Multicolinearidade não entorta a mira: ela alarga a incerteza",
             "Com regressores quase idênticos, a soma dos efeitos é bem estimada, mas a divisão entre eles vira uma faixa alongada",
             SIMULADO)
}, largura = 11, altura = 4.8)

## ---- 11. Erro de medição: atenuação ----------------------------------------
set.seed(123)
n11 <- 200
xs <- rnorm(n11, 0, sqrt(2))
ys <- 1 + 1 * xs + rnorm(n11, 0, 0.8)
xm <- xs + rnorm(n11, 0, 1)                 # medido com erro
b_sem <- unname(coef(lm(ys ~ xs))[2]); b_com <- unname(coef(lm(ys ~ xm))[2])
registrar("dtc_f11_b_sem_erro", b_sem)
registrar("dtc_f11_b_com_erro", b_com)
registrar("dtc_f11_lambda_teorico", 2 / (2 + 1))

salvar_figura(FIG("dtc_11_erro_medicao"), function() {
  par(mfrow = c(1, 2), oma = c(3.4, 0.6, 5, 0.6), mar = c(3.8, 3.8, 2.4, 1))
  lim <- range(c(xs, xm))
  plot(xs, ys, pch = 19, col = cor_alpha(CORES$principal, 0.5), xlim = lim, xlab = "X verdadeiro", ylab = "Y",
       axes = FALSE, main = sprintf("sem erro de medição: inclinação %.2f", b_sem),
       col.main = CORES$texto, cex.main = 0.95)
  axis(1, col = CORES$grade); axis(2, col = CORES$grade); grade_h()
  abline(lm(ys ~ xs), col = CORES$principal, lwd = 2.8)
  abline(a = 1, b = 1, col = CORES$texto, lty = 2, lwd = 1.6)

  plot(xm, ys, pch = 19, col = cor_alpha(CORES$compara, 0.5), xlim = lim, xlab = "X medido com ruído", ylab = "Y",
       axes = FALSE, main = sprintf("com erro de medição: inclinação %.2f", b_com),
       col.main = CORES$texto, cex.main = 0.95)
  axis(1, col = CORES$grade); axis(2, col = CORES$grade); grade_h()
  abline(lm(ys ~ xm), col = CORES$compara, lwd = 2.8)
  abline(a = 1, b = 1, col = CORES$texto, lty = 2, lwd = 1.6)
  titulo_out("Erro de medição no regressor achata a reta em direção a zero",
             "A nuvem se espalha na horizontal sem mudar na vertical: a mesma subida distribuída num X mais largo dá inclinação menor",
             SIMULADO)
}, largura = 11, altura = 4.8)

## ---- 12. O que o instrumento faz -------------------------------------------
set.seed(2024)
n12 <- 300
z12 <- rnorm(n12); u12 <- rnorm(n12)
x12 <- 0.9 * z12 + 1.2 * u12 + rnorm(n12, 0, 0.4)
y12 <- 1 + 1 * x12 + 2 * u12 + rnorm(n12, 0, 0.4)
xhat <- fitted(lm(x12 ~ z12))
b_mqo12 <- unname(coef(lm(y12 ~ x12))[2])
b_iv12 <- unname(coef(lm(y12 ~ xhat))[2])
registrar("dtc_f12_b_mqo", b_mqo12)
registrar("dtc_f12_b_iv", b_iv12)
registrar("dtc_f12_beta_verdadeiro", 1)

salvar_figura(FIG("dtc_12_instrumento"), function() {
  par(mfrow = c(1, 2), oma = c(3.4, 0.6, 5, 0.6), mar = c(3.8, 3.8, 2.4, 1))
  plot(x12, y12, pch = 19, col = cor_alpha(CORES$negativa, 0.35), xlab = "X (contaminado)", ylab = "Y",
       axes = FALSE, main = sprintf("MQO usa X inteiro: %.2f", b_mqo12), col.main = CORES$texto, cex.main = 0.95)
  axis(1, col = CORES$grade); axis(2, col = CORES$grade); grade_h()
  abline(lm(y12 ~ x12), col = CORES$negativa, lwd = 2.8)
  abline(a = 1, b = 1, col = CORES$texto, lty = 2, lwd = 1.8)
  legend("topleft", bty = "n", cex = 0.8, lwd = c(2.8, 1.8), lty = c(1, 2),
         col = c(CORES$negativa, CORES$texto), legend = c("estimado", "verdadeiro"))

  plot(xhat, y12, pch = 19, col = cor_alpha(CORES$principal, 0.45), xlab = "parte de X explicada pelo instrumento",
       ylab = "Y", axes = FALSE, main = sprintf("MQ2E usa só a parte limpa: %.2f", b_iv12),
       col.main = CORES$texto, cex.main = 0.95)
  axis(1, col = CORES$grade); axis(2, col = CORES$grade); grade_h()
  abline(lm(y12 ~ xhat), col = CORES$principal, lwd = 2.8)
  abline(a = 1, b = 1, col = CORES$texto, lty = 2, lwd = 1.8)
  titulo_out("O instrumento é uma peneira: fica só a variação de X que não passou pelo erro",
             "A nuvem encolhe na horizontal — por isso o VI é menos preciso — mas a inclinação volta para o valor verdadeiro",
             SIMULADO)
}, largura = 11, altura = 4.8)

## ---- 13. Heterocedasticidade -----------------------------------------------
set.seed(31)
n13 <- 220
x13 <- runif(n13, 1, 10)
y13 <- 2 + 0.8 * x13 + rnorm(n13, 0, 0.25 * x13)
registrar("dtc_f13_b", unname(coef(lm(y13 ~ x13))[2]))

salvar_figura(FIG("dtc_13_heterocedasticidade"), function() {
  plot(x13, y13, pch = 19, col = cor_alpha(CORES$neutra, 0.55), xlab = "X", ylab = "Y", axes = FALSE)
  axis(1, col = CORES$grade); axis(2, col = CORES$grade); grade_h()
  m13 <- lm(y13 ~ x13)
  abline(m13, col = CORES$principal, lwd = 2.8)
  xs13 <- seq(1, 10, length.out = 100)
  lines(xs13, predict(m13, data.frame(x13 = xs13)) + 2 * 0.25 * xs13, col = CORES$compara, lwd = 2, lty = 2)
  lines(xs13, predict(m13, data.frame(x13 = xs13)) - 2 * 0.25 * xs13, col = CORES$compara, lwd = 2, lty = 2)
  nota(6.2, 2.0, "o cone: a dispersão cresce com X", CORES$compara)
  titulo_editorial("Heterocedasticidade: a reta continua certa, a margem de erro é que mente",
                   "O MQO segue não viesado e consistente; o que quebra é a fórmula do erro-padrão, e com ela todo teste",
                   SIMULADO, "correção: erro-padrão robusto ou MQG (P2)")
}, largura = 8, altura = 5.2)

## ---- 14. Dummy e interação -------------------------------------------------
set.seed(64)
n14 <- 120
d14 <- rbinom(n14, 1, 0.5); x14 <- runif(n14, 0, 10)
y14 <- 2 + 0.5 * x14 + 3 * d14 + 0.45 * d14 * x14 + rnorm(n14, 0, 1.1)
m14 <- lm(y14 ~ d14 * x14)
registrar("dtc_f14_intercepto_base", unname(coef(m14)[1]))
registrar("dtc_f14_salto_intercepto", unname(coef(m14)["d14"]))
registrar("dtc_f14_dif_inclinacao", unname(coef(m14)["d14:x14"]))

salvar_figura(FIG("dtc_14_dummy_interacao"), function() {
  plot(x14, y14, pch = 19, col = ifelse(d14 == 1, cor_alpha(CORES$compara, 0.55), cor_alpha(CORES$neutra, 0.55)),
       xlab = "X", ylab = "Y", axes = FALSE)
  axis(1, col = CORES$grade); axis(2, col = CORES$grade); grade_h()
  b <- coef(m14)
  abline(a = b[1], b = b["x14"], col = CORES$neutra, lwd = 2.8)
  abline(a = b[1] + b["d14"], b = b["x14"] + b["d14:x14"], col = CORES$compara, lwd = 2.8)
  arrows(0.35, b[1], 0.35, b[1] + b["d14"], col = CORES$texto, lwd = 2, length = 0.08, code = 3)
  nota(0.5, b[1] + b["d14"] / 2, "dummy de intercepto: o salto", CORES$texto)
  nota(6.6, b[1] + b["d14"] + (b["x14"] + b["d14:x14"]) * 6.6 - 2.2, "interação: a abertura do leque", CORES$compara)
  titulo_editorial("A dummy levanta a reta; a interação muda a inclinação dela",
                   "Sem interação, as retas são paralelas e o efeito do grupo é o mesmo em qualquer X",
                   SIMULADO, "com interação, o efeito depende do X")
}, largura = 8, altura = 5.2)

## ---- 15. O perfil quadrático da experiência --------------------------------
a3 <- 0.04291665; a4 <- -0.00070803
xstar <- -a3 / (2 * a4)
registrar("dtc_f15_xstar", xstar)

salvar_figura(FIG("dtc_15_quadratico"), function() {
  exp_seq <- seq(0, 55, length.out = 300)
  perfil <- a3 * exp_seq + a4 * exp_seq^2
  plot(exp_seq, perfil, type = "n", xlab = "anos de experiência", ylab = "contribuição para o log do salário",
       axes = FALSE)
  axis(1, col = CORES$grade); axis(2, col = CORES$grade); grade_h()
  lines(exp_seq, perfil, col = CORES$principal, lwd = 3)
  abline(v = xstar, col = CORES$compara, lwd = 2, lty = 2)
  points(xstar, a3 * xstar + a4 * xstar^2, pch = 21, bg = CORES$destaque, col = CORES$texto, cex = 1.8, lwd = 1.5)
  nota(xstar + 0.6, a3 * xstar + a4 * xstar^2 - 0.06, sprintf("máximo em %.1f anos", xstar), CORES$texto)
  segments(3, a3 * 3 + a4 * 9, 12, a3 * 3 + a4 * 9 + (a3 + 2 * a4 * 7.5) * 9, col = CORES$eixo, lwd = 1.8)
  nota(12.2, a3 * 3 + a4 * 9 + (a3 + 2 * a4 * 7.5) * 9, "efeito marginal aqui: a inclinação da tangente", CORES$eixo)
  titulo_editorial("Por que o salário sobe cada vez menos com a experiência",
                   "O termo ao quadrado com sinal negativo entorta a reta para baixo: a derivada cai até zerar",
                   "coeficientes da P1 2025/2 (Cornwell-Rupert)",
                   "máximo em -a3/(2a4)")
}, largura = 8, altura = 5.2)

## ---- 16. Alavancagem e ponto influente -------------------------------------
set.seed(202)
n16 <- 30
x16 <- runif(n16, 1, 6); y16 <- 2 + 0.8 * x16 + rnorm(n16, 0, 0.7)
x_inf <- 14; y_inf <- 3.5
b_sem16 <- coef(lm(y16 ~ x16))
b_com16 <- coef(lm(c(y16, y_inf) ~ c(x16, x_inf)))
registrar("dtc_f16_b_sem", unname(b_sem16[2]))
registrar("dtc_f16_b_com", unname(b_com16[2]))
registrar("dtc_f16_alavancagem", unname(hatvalues(lm(c(y16, y_inf) ~ c(x16, x_inf)))[n16 + 1]))

salvar_figura(FIG("dtc_16_alavancagem"), function() {
  plot(c(x16, x_inf), c(y16, y_inf), pch = 19, col = c(rep(cor_alpha(CORES$neutra, 0.65), n16), CORES$negativa),
       cex = c(rep(1.1, n16), 1.9), xlab = "X", ylab = "Y", axes = FALSE, xlim = c(0, 15), ylim = c(0, 10))
  axis(1, col = CORES$grade); axis(2, col = CORES$grade); grade_h()
  abline(b_sem16[1], b_sem16[2], col = CORES$principal, lwd = 2.8)
  abline(b_com16[1], b_com16[2], col = CORES$negativa, lwd = 2.8, lty = 2)
  nota(x_inf - 4.6, y_inf - 0.9, "um único ponto, muito longe da média de X", CORES$negativa)
  legend("topleft", bty = "n", cex = 0.85, lwd = 2.8, lty = c(1, 2), col = c(CORES$principal, CORES$negativa),
         legend = c(sprintf("sem o ponto: %.2f", b_sem16[2]), sprintf("com o ponto: %.2f", b_com16[2])))
  titulo_editorial("Alavancagem: quem está longe da média de X puxa a reta com mais força",
                   "A mesma observação, colocada perto da média, quase não mexeria no resultado",
                   SIMULADO, "dispersão em X dá precisão e concentra influência")
}, largura = 8, altura = 5.2)

gravar_resultados("dtc")
cat("\nFiguras geradas em didatica/figuras/\n")
