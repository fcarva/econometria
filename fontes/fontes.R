# Fontes primárias: reproduz em R o resultado central de sete artigos originais
# e desenha a linha do tempo das ideias do curso.
# Os números citados em fontes/fontes_primarias.md vêm daqui (id `fts`).
# Rodar: powershell -ExecutionPolicy Bypass -File scripts\r.ps1 fontes\fontes.R

# --- bootstrap: localizar a raiz do repo e carregar helpers ---
.d <- getwd(); while (!file.exists(file.path(.d, ".repo-root")) && dirname(.d) != .d) .d <- dirname(.d)
source(file.path(.d, "R", "raiz.R"))

suppressPackageStartupMessages({
  library(AER)        # ivreg
  library(lmtest)     # bptest
  library(sandwich)   # vcovHC
})
data("wage1", package = "wooldridge")
data("card", package = "wooldridge")

FIG <- function(nome) file.path(raiz(), "fontes", "figuras", nome)
dir.create(file.path(raiz(), "fontes", "figuras"), showWarnings = FALSE)

## ---- 1. Frisch e Waugh (1933): tendência incluída = séries destendenciadas ----
# O caso original: duas séries com tendência linear. Regredir y em x e t dá o
# mesmo coeficiente de x que regredir y destendenciado em x destendenciado.
set.seed(1933)
T1 <- 60
t1 <- seq_len(T1)
x_fw <- 0.08 * t1 + rnorm(T1)
y_fw <- 1 + 0.5 * x_fw + 0.05 * t1 + rnorm(T1)
b_completa <- unname(coef(lm(y_fw ~ x_fw + t1))["x_fw"])
y_dt <- residuals(lm(y_fw ~ t1))
x_dt <- residuals(lm(x_fw ~ t1))
b_destend <- unname(coef(lm(y_dt ~ x_dt))["x_dt"])
b_sem_tend <- unname(coef(lm(y_fw ~ x_fw))["x_fw"])
registrar("fts_fw_b_completa", b_completa)
registrar("fts_fw_b_destendenciada", b_destend)
registrar("fts_fw_b_sem_tendencia", b_sem_tend)
stopifnot(abs(b_completa - b_destend) < 1e-10)

## ---- 2. Ding (2021): FWL para erros-padrão --------------------------------
# Mesmo coeficiente, mesmos resíduos; o erro-padrão "ingênuo" da regressão
# parcial divide a SQR por n - K2 em vez de n - K. O EHW (HC0) coincide exatamente.
n2 <- T1; K <- 3; K2 <- 1
m_comp <- lm(y_fw ~ x_fw + t1)
m_parc <- lm(y_dt ~ x_dt - 1)
se_comp <- sqrt(diag(vcov(m_comp)))["x_fw"]
se_parc <- sqrt(diag(vcov(m_parc)))["x_dt"]
registrar("fts_ding_se_completa", unname(se_comp))
registrar("fts_ding_se_parcial_ingenuo", unname(se_parc))
registrar("fts_ding_razao", unname(se_parc / se_comp))
registrar("fts_ding_razao_teorica", sqrt((n2 - K) / (n2 - K2)))
hc0_comp <- sqrt(diag(vcovHC(m_comp, type = "HC0")))["x_fw"]
hc0_parc <- sqrt(diag(vcovHC(m_parc, type = "HC0")))["x_dt"]
registrar("fts_ding_hc0_completa", unname(hc0_comp))
registrar("fts_ding_hc0_parcial", unname(hc0_parc))
stopifnot(abs(se_parc / se_comp - sqrt((n2 - K) / (n2 - K2))) < 1e-10,
          abs(hc0_comp - hc0_parc) < 1e-10)

## ---- 3. Yule (1897) e White (1980, IER): MQO estima a melhor aproximação linear
# A média condicional verdadeira é exp(x), não linear. Com x ~ N(0,1), a
# projeção linear tem inclinação Cov(x, e^x)/Var(x) = e^{1/2} e intercepto E[e^x] = e^{1/2}.
set.seed(1897)
n3 <- 200000
x3 <- rnorm(n3)
y3 <- exp(x3) + rnorm(n3)
c3 <- coef(lm(y3 ~ x3))
registrar("fts_blp_b_mqo", unname(c3[2]))
registrar("fts_blp_a_mqo", unname(c3[1]))
registrar("fts_blp_b_teorico", exp(0.5))

## ---- 4. Halvorsen e Palmquist (1980) e Kennedy (1981): dummy em modelo semilog
m4 <- lm(lwage ~ female + educ + exper + expersq + tenure + tenursq, data = wage1)
c_fem <- unname(coef(m4)["female"])
v_fem <- unname(vcov(m4)["female", "female"])
registrar("fts_hp_coef", c_fem)
registrar("fts_hp_pct_ingenuo", 100 * c_fem)
registrar("fts_hp_pct_exato", 100 * (exp(c_fem) - 1))
registrar("fts_hp_pct_kennedy", 100 * (exp(c_fem - v_fem / 2) - 1))

## ---- 5. Berndt e Savin (1977): W >= LR >= LM no modelo linear --------------
# H0: exper = expersq = tenure = tenursq = 0 no modelo do item 4.
m5_r <- lm(lwage ~ female + educ, data = wage1)
sqr_u <- sum(residuals(m4)^2); sqr_r <- sum(residuals(m5_r)^2); n5 <- nrow(wage1)
W  <- n5 * (sqr_r - sqr_u) / sqr_u
LR <- n5 * log(sqr_r / sqr_u)
LM <- n5 * (sqr_r - sqr_u) / sqr_r
F5 <- ((sqr_r - sqr_u) / 4) / (sqr_u / (n5 - length(coef(m4))))
registrar("fts_bs_W", W)
registrar("fts_bs_LR", LR)
registrar("fts_bs_LM", LM)
registrar("fts_bs_F", F5)
stopifnot(W >= LR, LR >= LM)

## ---- 6. Koenker (1981): o bptest do R é a versão studentizada ---------------
m6 <- lm(wage ~ female + educ + exper + tenure, data = wage1)
bp_koenker <- bptest(m6)                       # padrão: studentize = TRUE
bp_original <- bptest(m6, studentize = FALSE)  # Breusch-Pagan (1979) original
registrar("fts_bp_koenker", unname(bp_koenker$statistic))
registrar("fts_bp_original", unname(bp_original$statistic))

## ---- 7. Card (1995): proximidade da faculdade como instrumento -------------
f_ols <- lwage ~ educ + exper + expersq + black + smsa + south
m7_ols <- lm(f_ols, data = card)
m7_iv <- ivreg(lwage ~ educ + exper + expersq + black + smsa + south |
                 nearc4 + exper + expersq + black + smsa + south, data = card)
m7_fs <- lm(educ ~ nearc4 + exper + expersq + black + smsa + south, data = card)
t_fs <- coef(summary(m7_fs))["nearc4", "t value"]
registrar("fts_card_b_mqo", unname(coef(m7_ols)["educ"]))
registrar("fts_card_se_mqo", unname(coef(summary(m7_ols))["educ", "Std. Error"]))
registrar("fts_card_b_iv", unname(coef(m7_iv)["educ"]))
registrar("fts_card_se_iv", unname(sqrt(diag(vcov(m7_iv)))["educ"]))
registrar("fts_card_t_iv", unname(coef(m7_iv)["educ"] / sqrt(diag(vcov(m7_iv)))["educ"]))
registrar("fts_card_F_1estagio", unname(t_fs^2))
registrar("fts_card_n", nrow(card))

## ---- 8. MacKinnon e White (1985): qual "robusto" cada função entrega -------
# sandwich() é o HC0 de White (1980); vcovHC() usa HC3 por padrão; o "robust"
# do Stata é o HC1. Mesmo modelo, três erros-padrão diferentes.
stopifnot(isTRUE(all.equal(sandwich(m6), vcovHC(m6, type = "HC0"))),
          isTRUE(all.equal(vcovHC(m6), vcovHC(m6, type = "HC3"))))
se_tipo <- function(tipo) unname(sqrt(diag(vcovHC(m6, type = tipo)))["educ"])
registrar("fts_hc_se_classico", unname(sqrt(diag(vcov(m6)))["educ"]))
registrar("fts_hc_se_hc0", se_tipo("HC0"))
registrar("fts_hc_se_hc1", se_tipo("HC1"))
registrar("fts_hc_se_hc3", se_tipo("HC3"))

## ---- Figura: linha do tempo ------------------------------------------------
eventos <- data.frame(
  ano = c(1805, 1823, 1886, 1897, 1904, 1928, 1933, 1943, 1945, 1950, 1957,
          1958, 1960, 1969, 1973, 1978, 1980, 1980, 1985, 1994, 1994, 1997,
          2004, 2005, 2021, 2022),
  rotulo = c("Legendre: mínimos quadrados", "Gauss: variância mínima", "Galton: \"regressão\"",
             "Yule: MQO sem normalidade", "Spearman: atenuação", "Wright: primeiro VI",
             "Frisch e Waugh", "Haavelmo: simultaneidade", "Reiersøl nomeia o VI",
             "Durbin-Watson", "Basmann/Theil: MQ2E", "Sargan: sobreidentificação",
             "Chow: quebra estrutural", "Ramsey: RESET", "Wu: teste de exogeneidade",
             "Hausman", "White: erro-padrão robusto", "Jarque-Bera",
             "MacKinnon-White: HC1-HC3", "Imbens-Angrist: LATE", "Card-Krueger: DiD",
             "Staiger-Stock: F > 10", "Bertrand et al.: DiD e EP", "Stock-Yogo",
             "DiD escalonado (Goodman-Bacon)", "Lee et al.: F > 104,7"),
  tema = c(1, 1, 1, 1, 4, 4, 1, 4, 4, 2, 4, 4, 2, 2, 4, 4, 3, 2, 3, 4, 5, 4, 5, 4, 5, 4),
  stringsAsFactors = FALSE
)
cores_tema <- c(CORES$principal, CORES$neutra, CORES$compara, CORES$negativa, CORES$roxo)
nomes_tema <- c("MQO e geometria", "testes de especificação", "inferência robusta",
                "endogeneidade e VI", "diferenças em diferenças")

salvar_figura(FIG("fts_linha_tempo"), function() {
  # uma linha por evento, em ordem cronológica: o ponto marca o ano
  par(mar = c(5, 1, 6.4, 1))
  ne <- nrow(eventos)
  yy <- rev(seq_len(ne))
  plot(0, 0, type = "n", xlim = c(1795, 2030), ylim = c(0.4, ne + 0.6),
       axes = FALSE, xlab = "", ylab = "")
  for (d in seq(1800, 2020, by = 20)) segments(d, 0.4, d, ne + 0.6, col = CORES$grade, lwd = 0.8)
  axis(1, at = seq(1800, 2020, by = 20), col = CORES$grade, col.axis = CORES$eixo, cex.axis = 0.8)
  for (i in seq_len(ne)) {
    cr <- cores_tema[eventos$tema[i]]
    points(eventos$ano[i], yy[i], pch = 19, col = cr, cex = 1.25)
    text(eventos$ano[i], yy[i], paste0(eventos$ano[i], " · ", eventos$rotulo[i]),
         pos = if (eventos$ano[i] < 1950) 4 else 2, offset = 0.5, cex = 0.72, col = cr)
  }
  legend("topright", bty = "n", cex = 0.75, pch = 19, pt.cex = 1.2, col = cores_tema,
         legend = nomes_tema, text.col = CORES$eixo, y.intersp = 1.1)
  titulo_editorial("Dois séculos de ideias, uma prova: de onde vem cada resultado do curso",
                   "Mínimos quadrados nasceram na astronomia; a crise dos instrumentos fracos é dos anos 1990",
                   "fontes/fontes_primarias.md (referências conferidas no Crossref)",
                   "ano da publicação original")
}, largura = 10, altura = 8.6)

gravar_resultados("fts")
cat("\nFigura gerada em fontes/figuras/\n")
