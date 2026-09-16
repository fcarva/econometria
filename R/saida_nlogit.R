# Saídas de regressão no formato das provas do Prof. Zambon, com vírgula decimal.
# Este arquivo SÓ define funções: é carregado automaticamente por R/raiz.R.
#
#   saida_nlogit(modelo_lm, ...)      MQO no layout NLOGIT/LIMDEP da P1 2025/2 (Questão 1)
#   saida_mq2e(modelo_ivreg, ...)     MQ2E no layout da P2 2024/2 (pág. 2): cabeçalho,
#                                     lista de "Variáveis instrumentais" e bloco de diagnósticos
#   saida_ivreg_r(modelo_ivreg, ...)  imita summary(..., diagnostics = TRUE) do R (Lista 1, ex. 67)
#   saida_testes(tab, titulo)         bloco de testes de diagnóstico (RESET, BP, BG, JB, Chow...)
#   gravar_saida(linhas, arquivo)     grava em UTF-8 sem BOM, fim de linha LF
#
# Todas as saida_*() devolvem (invisível) o vetor de linhas; com imprimir = TRUE também
# escrevem na tela. Convenções do NLOGIT reproduzidas:
#   - coeficientes, erros padrão e médias com 9 algarismos (8 casas se |x| < 1);
#     valores com |x| < 1e-4 em notação 0,dddddde-0k (ex.: 0,506204e-04);
#   - b/E.p. com 3 casas; P[|Z|>z] pela normal padrão, com 4 casas;
#   - F do modelo calculado pelo R²: F = [R²/(K-1)] / [(1-R²)/(n-K)].
# No MQ2E o NLOGIT usa s² = e'e/n (sem correção de graus de liberdade): argumento divisor.

.nl_virg <- function(s) chartr(".", ",", s)

.nl_pad <- function(s, largura, lado = c("esq", "dir")) {
  lado <- match.arg(lado)
  falta <- pmax(0, largura - nchar(s, type = "width"))
  if (lado == "esq") paste0(s, strrep(" ", falta)) else paste0(strrep(" ", falta), s)
}

# k algarismos significativos, mantendo zeros finais (0,3740280)
.nl_sig <- function(x, k = 7) .nl_virg(formatC(x, digits = k, format = "fg", flag = "#"))

# formato NLOGIT para coeficientes, erros padrão e médias
.nl_num <- function(x) {
  vapply(x, function(v) {
    if (is.na(v)) return("")
    a <- abs(v)
    if (a == 0) return("0,00000000")
    if (a < 1e-4) {
      e <- floor(log10(a)) + 1
      m <- a / 10^e
      if (round(m, 6) >= 1) { m <- m / 10; e <- e + 1 }
      s <- sprintf("%.6fe%s%02d", m, if (e < 0) "-" else "+", abs(e))
      return(.nl_virg(paste0(if (v < 0) "-" else "", s)))
    }
    if (a < 1) return(.nl_virg(sprintf("%.8f", v)))
    dec <- max(0, 9 - (floor(log10(a)) + 1))
    .nl_virg(sprintf(paste0("%.", dec, "f"), v))
  }, "")
}

.nl_rotulos <- function(nomes_coef, nomes, intercepto = "Constant") {
  r <- nomes_coef
  r[r == "(Intercept)"] <- intercepto
  if (!is.null(nomes)) {
    achou <- nomes_coef %in% names(nomes)
    r[achou] <- nomes[nomes_coef[achou]]
  }
  r
}

.nl_caixa <- function(corpo, largura = NULL) {
  if (is.null(largura)) largura <- max(nchar(corpo, type = "width")) + 1
  borda <- paste0("+", strrep("-", largura), "+")
  c(borda, paste0("|", .nl_pad(corpo, largura), "|"), borda)
}

# Cabeçalho comum (MQO e MQ2E)
.nl_cabecalho <- function(titulo, lhs, y, K, ssr, s, r2, r2a, dig_p_F) {
  n <- length(y)
  Fst <- (r2 / (K - 1)) / ((1 - r2) / (n - K))
  pF <- pf(Fst, K - 1, n - K, lower.tail = FALSE)
  g <- 20; d <- 26
  lin <- function(grupo, desc, valor) paste0(" ", .nl_pad(grupo, g), .nl_pad(desc, d), "= ", valor)
  c(paste0(" ", titulo),
    lin(paste0("LHS=", lhs), "Média", .nl_sig(mean(y))),
    lin("", "Desvio padrão", .nl_sig(sd(y))),
    lin("", "Número de observações", format(n)),
    lin("Tamanho do modelo", "Parâmetros", format(K)),
    lin("", "Graus de liberdade", format(n - K)),
    lin("Resíduos", "Soma dos quadrados", .nl_sig(ssr)),
    lin("", "Erro padrão dos resíduos", .nl_sig(s)),
    lin("Ajuste", "R-quadrado", .nl_sig(r2)),
    lin("", "R-quadrado ajustado", .nl_sig(r2a)),
    paste0(" ", .nl_pad(sprintf("Teste de modelo F[%d,%d] (valor-p)", K - 1, n - K), g + d),
           "= ", .nl_virg(sprintf("%.2f", Fst)), " (",
           .nl_virg(sprintf(paste0("%.", dig_p_F, "f"), pF)), ")"))
}

# Tabela de coeficientes (MQO e MQ2E)
.nl_tabela <- function(b, se, medias, rotulos) {
  z <- b / se
  p <- 2 * pnorm(-abs(z))
  w <- c(10, 15, 16, 9, 9, 13)
  borda <- paste0("+", paste(vapply(w, function(k) strrep("-", k), ""), collapse = "+"), "+")
  cab <- paste0("|", paste(mapply(function(t, k) .nl_pad(t, k), c("Variáveis", " Coeficientes",
               " Erro padrão", " b/E.p.", "P[|Z|>z]", " Média de X"), w), collapse = "|"), "|")
  med <- ifelse(is.na(medias), "", .nl_num(medias))
  linhas <- paste0(.nl_pad(substr(rotulos, 1, 9), 9), "|",
                   .nl_pad(.nl_num(b), 15, "dir"),
                   .nl_pad(.nl_num(se), 16, "dir"),
                   .nl_pad(.nl_virg(sprintf("%.3f", z)), 10, "dir"),
                   .nl_pad(.nl_virg(sprintf("%.4f", p)), 9, "dir"),
                   .nl_pad(med, 14, "dir"))
  c(borda, cab, borda, linhas, borda)
}

saida_nlogit <- function(modelo, lhs = NULL, nomes = NULL, vcov. = NULL,
                         titulo = "Regressão de mínimos quadrados ordinários (MQO)",
                         dig_p_F = 2, imprimir = TRUE) {
  stopifnot(inherits(modelo, "lm"))
  y <- model.response(model.frame(modelo))
  X <- model.matrix(modelo)
  n <- nrow(X); K <- ncol(X)
  if (is.null(lhs)) lhs <- toupper(deparse(formula(modelo)[[2]]))
  e <- residuals(modelo)
  ssr <- sum(e^2)
  s <- sqrt(ssr / (n - K))
  r2 <- 1 - ssr / sum((y - mean(y))^2)
  r2a <- 1 - (1 - r2) * (n - 1) / (n - K)
  V <- if (is.null(vcov.)) vcov(modelo) else if (is.function(vcov.)) vcov.(modelo) else vcov.
  b <- coef(modelo)
  medias <- colMeans(X); medias[colnames(X) == "(Intercept)"] <- NA
  linhas <- c(.nl_caixa(.nl_cabecalho(titulo, lhs, y, K, ssr, s, r2, r2a, dig_p_F)),
              .nl_tabela(b, sqrt(diag(V)), medias, .nl_rotulos(names(b), nomes)))
  if (!is.null(vcov.)) linhas <- c(linhas, "Erros padrão robustos (matriz de covariância fornecida).")
  if (imprimir) cat(linhas, sep = "\n")
  invisible(linhas)
}

saida_mq2e <- function(modelo, lhs = NULL, nomes = NULL, vcov. = NULL,
                       divisor = c("n-K", "n"), diag_vcov = NULL, diagnosticos = TRUE,
                       titulo = "Mínimos quadrados em dois estágios (MQ2E)",
                       dig_p_F = 4, imprimir = TRUE) {
  stopifnot(inherits(modelo, "ivreg"))
  divisor <- match.arg(divisor)
  y <- modelo$y
  if (is.null(y)) y <- model.response(model.frame(modelo))
  X <- model.matrix(modelo, component = "regressors")
  Z <- model.matrix(modelo, component = "instruments")
  n <- nrow(X); K <- ncol(X)
  if (is.null(lhs)) lhs <- toupper(deparse(formula(modelo)[[2]]))
  e <- residuals(modelo)
  ssr <- sum(e^2)
  s2 <- ssr / (if (divisor == "n") n else n - K)
  r2 <- 1 - ssr / sum((y - mean(y))^2)
  r2a <- 1 - (1 - r2) * (n - 1) / (n - K)
  V <- if (!is.null(vcov.)) { if (is.function(vcov.)) vcov.(modelo) else vcov. } else s2 * modelo$cov.unscaled
  b <- coef(modelo)
  medias <- colMeans(X); medias[colnames(X) == "(Intercept)"] <- NA
  cab <- .nl_cabecalho(titulo, lhs, y, K, ssr, sqrt(s2), r2, r2a, dig_p_F)
  inst <- .nl_rotulos(colnames(Z), nomes, intercepto = "ONE")
  blocos <- split(inst, ceiling(seq_along(inst) / 6))
  cab <- c(cab, " Variáveis instrumentais:",
           vapply(blocos, function(v) paste0(" ", paste(.nl_pad(v, 9), collapse = "")), ""))
  if (divisor == "n") cab <- c(cab, " (s² = e'e/n, sem correção de graus de liberdade)")
  linhas <- c(.nl_caixa(cab), .nl_tabela(b, sqrt(diag(V)), medias, .nl_rotulos(names(b), nomes)))
  if (diagnosticos) {
    dg <- summary(modelo, vcov. = diag_vcov, diagnostics = TRUE)$diagnostics
    fmt_gl <- function(v) ifelse(is.na(v), "NA", format(v))
    fmt_p <- function(v) ifelse(is.na(v), "NA", .nl_virg(sprintf("%.4f", v)))
    fmt_e <- function(v) ifelse(is.na(v), "NA", .nl_virg(sprintf("%.3f", v)))
    linhas <- c(linhas, "", "Testes de diagnóstico:",
                paste0(.nl_pad("", 18), .nl_pad("gl1", 6, "dir"), .nl_pad("gl2", 7, "dir"),
                       .nl_pad("Estatística", 14, "dir"), .nl_pad("Valor-p", 10, "dir")),
                paste0(.nl_pad(rownames(dg), 18), .nl_pad(fmt_gl(dg[, 1]), 6, "dir"),
                       .nl_pad(fmt_gl(dg[, 2]), 7, "dir"), .nl_pad(fmt_e(dg[, 3]), 14, "dir"),
                       .nl_pad(fmt_p(dg[, 4]), 10, "dir")))
  }
  if (imprimir) cat(linhas, sep = "\n")
  invisible(linhas)
}

# Troca ponto decimal por vírgula só entre dígitos (preserva nomes como "I(tax/cpi)")
.r_virg <- function(s) gsub("(?<=[0-9])\\.(?=[0-9])", ",", s, perl = TRUE)

saida_ivreg_r <- function(modelo, vcov. = NULL, df = NULL, rotulos = NULL,
                          formula_txt = NULL, imprimir = TRUE) {
  stopifnot(inherits(modelo, "ivreg"))
  s <- summary(modelo, vcov. = vcov., df = df, diagnostics = TRUE)
  cf <- s$coefficients
  if (!is.null(rotulos)) {
    achou <- rownames(cf) %in% names(rotulos)
    rownames(cf)[achou] <- rotulos[rownames(cf)[achou]]
  }
  if (is.null(formula_txt)) formula_txt <- paste(deparse(modelo$formula, width.cutoff = 500), collapse = " ")
  tab_coef <- utils::capture.output(stats::printCoefmat(cf, digits = 4, signif.stars = FALSE))
  dg <- s$diagnostics
  tab_dg <- utils::capture.output(stats::printCoefmat(dg, cs.ind = NULL, tst.ind = 3, has.Pvalue = TRUE,
                                                      P.values = TRUE, digits = 4, signif.stars = FALSE,
                                                      na.print = "NA"))
  w <- s$waldtest
  gl <- if (length(w) >= 4 && is.finite(w[4])) paste(w[3], "and", w[4]) else format(w[3])
  linhas <- c(paste0("ivreg(formula = ", formula_txt, ")"), "",
              "Coefficients:", tab_coef, "",
              "Diagnostic tests:", tab_dg, "",
              paste0("Multiple R-Squared: ", formatC(s$r.squared, digits = 4),
                     ",\tAdjusted R-squared: ", formatC(s$adj.r.squared, digits = 4)),
              paste0("Wald test: ", formatC(w[1], digits = 4), " on ", gl, " DF, p-value: ",
                     format.pval(w[2], digits = 4)))
  linhas <- .r_virg(linhas)
  if (imprimir) cat(linhas, sep = "\n")
  invisible(linhas)
}

# tab: data.frame com colunas teste, estatistica, gl (texto), p
saida_testes <- function(tab, titulo = "Testes de diagnóstico", imprimir = TRUE) {
  stopifnot(all(c("teste", "estatistica", "gl", "p") %in% names(tab)))
  wt <- max(nchar(tab$teste, type = "width"), 5) + 2
  est <- .nl_virg(sprintf("%.4f", tab$estatistica))
  pv <- ifelse(tab$p < 1e-4, "<0,0001", .nl_virg(sprintf("%.4f", tab$p)))
  linhas <- c(paste0(titulo, ":"),
              paste0(.nl_pad("Teste", wt), .nl_pad("Estatística", 14, "dir"),
                     .nl_pad("gl", 14, "dir"), .nl_pad("Valor-p", 10, "dir")),
              paste0(.nl_pad(tab$teste, wt), .nl_pad(est, 14, "dir"),
                     .nl_pad(as.character(tab$gl), 14, "dir"), .nl_pad(pv, 10, "dir")))
  if (imprimir) cat(linhas, sep = "\n")
  invisible(linhas)
}

gravar_saida <- function(linhas, arquivo) {
  dir.create(dirname(arquivo), showWarnings = FALSE, recursive = TRUE)
  con <- file(arquivo, open = "wb")
  on.exit(close(con))
  writeBin(charToRaw(enc2utf8(paste0(paste(linhas, collapse = "\n"), "\n"))), con)
  invisible(arquivo)
}
