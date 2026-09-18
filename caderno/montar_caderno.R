# Monta o caderno de estudo em PDF a partir das notas Markdown do repositório.
#   Volume 1 — revisão, intuição, teoria, demonstrações e fontes
#   Volume 2 — Lista 1 resolvida, provas, bancos de questões e gabaritos
#   Simulados — um PDF por simulado, só com as questões, para resolver no papel
#
# Caminho: nota .md -> preparo em R (tira o frontmatter, resolve caminhos de figura,
# troca emoji por símbolo) -> pandoc (commonmark_x + filtros.lua) -> .tex -> LuaLaTeX.
# Requer pandoc (o do RStudio serve) e LuaLaTeX (MiKTeX ou TeX Live).
#
# Rodar: powershell -ExecutionPolicy Bypass -File scripts\r.ps1 caderno\montar_caderno.R
#        (argumentos opcionais: teoria, exercicios, simulados; sem argumento, tudo)
# Saída: caderno/pdf/ (fora do git, como todo PDF)

# --- bootstrap: localizar a raiz do repo e carregar helpers ---
.d <- getwd(); while (!file.exists(file.path(.d, ".repo-root")) && dirname(.d) != .d) .d <- dirname(.d)
source(file.path(.d, "R", "raiz.R"))

RAIZ <- normalizePath(raiz(), winslash = "/")
CAD <- file.path(RAIZ, "caderno")
BUILD <- file.path(CAD, "_build")
SAIDA <- file.path(CAD, "pdf")
dir.create(BUILD, showWarnings = FALSE)
dir.create(SAIDA, showWarnings = FALSE)

## ---- ferramentas ----------------------------------------------------------------
primeiro_existente <- function(x) {
  x <- x[nzchar(x)]
  x <- x[file.exists(x)]
  if (length(x)) normalizePath(x[1], winslash = "/") else ""
}
PANDOC <- primeiro_existente(c(
  Sys.which("pandoc"),
  file.path(Sys.getenv("RSTUDIO_PANDOC"), "pandoc.exe"),
  "C:/Program Files/RStudio/resources/app/bin/quarto/bin/tools/pandoc.exe",
  "C:/Program Files/Quarto/bin/tools/pandoc.exe",
  file.path(Sys.getenv("LOCALAPPDATA"), "Pandoc", "pandoc.exe"),
  "C:/Program Files/Pandoc/pandoc.exe"
))
LUALATEX <- primeiro_existente(c(
  Sys.which("lualatex"),
  file.path(Sys.getenv("LOCALAPPDATA"), "Programs", "MiKTeX", "miktex", "bin", "x64", "lualatex.exe"),
  "C:/Program Files/MiKTeX/miktex/bin/x64/lualatex.exe"
))
if (!nzchar(PANDOC)) stop("pandoc não encontrado (instale o pandoc ou o RStudio)")
if (!nzchar(LUALATEX)) stop("lualatex não encontrado (instale o MiKTeX ou o TeX Live)")

commit <- tryCatch(system2("git", c("-C", shQuote(RAIZ), "rev-parse", "--short", "HEAD"), stdout = TRUE),
                   error = function(e) "?")
hoje <- format(Sys.Date(), "%d/%m/%Y")

## ---- preparo de cada nota --------------------------------------------------------
latex_inline <- function(x) paste0("`", x, "`{=latex}")
SIMBOLOS <- c(
  "\U0001F534" = latex_inline("\\textcolor{fxvermelho}{●}"),
  "\U0001F7E1" = latex_inline("\\textcolor{fxamarelo}{●}"),
  "\u26AA"     = latex_inline("\\textcolor{fxeixo}{○}"),
  "\u2705"     = latex_inline("\\textcolor{fxverde}{✔}"),
  "\u2714"     = latex_inline("\\textcolor{fxverde}{✔}"),
  "\u2713"     = latex_inline("\\textcolor{fxverde}{✓}"),
  "\u274C"     = latex_inline("\\textcolor{fxvermelho}{✘}"),
  "\u2717"     = latex_inline("\\textcolor{fxvermelho}{✘}"),
  "\u26A0"     = latex_inline("\\textcolor{fxlaranja}{⚠}"),
  "\u23F3"     = latex_inline("\\textcolor{fxeixo}{◷}"),
  "\u2796"     = "–",
  "\U0001F3AF" = "", "\U0001F4DA" = "", "\U0001F5FA" = "", "\U0001F4E6" = "", "\U0001F52D" = "",
  "\uFE0F"     = ""
)

preparar_nota <- function(rel) {
  caminho <- file.path(RAIZ, rel)
  if (!file.exists(caminho)) stop("nota não encontrada: ", rel)
  l <- readLines(caminho, encoding = "UTF-8", warn = FALSE)
  titulo <- NA_character_
  if (length(l) && l[1] == "---") {
    fim <- which(l == "---")[2]
    fm <- l[2:(fim - 1)]
    t <- grep("^title:", fm, value = TRUE)
    if (length(t)) titulo <- gsub('^title:\\s*"?|"\\s*$', "", t[1])
    l <- l[-(1:fim)]
  }
  dir_nota <- dirname(caminho)
  em_codigo <- FALSE
  for (i in seq_along(l)) {
    if (grepl("^\\s*(```|~~~)", l[i])) { em_codigo <- !em_codigo; next }
    if (em_codigo) next
    # figuras: caminho relativo à nota -> absoluto
    m <- gregexpr("!\\[[^]]*\\]\\(([^)[:space:]]+)\\)", l[i], perl = TRUE)
    if (m[[1]][1] > 0) {
      achados <- regmatches(l[i], m)[[1]]
      for (a in achados) {
        alvo <- sub("^!\\[[^]]*\\]\\(([^)]+)\\)$", "\\1", a)
        if (!grepl("^https?://", alvo)) {
          abs <- normalizePath(file.path(dir_nota, alvo), winslash = "/", mustWork = FALSE)
          l[i] <- sub(a, sub(alvo, abs, a, fixed = TRUE), l[i], fixed = TRUE)
        }
      }
    }
    # emoji -> símbolo desenhável (em título, só some: LaTeX cru não entra em \section)
    # troca caractere a caractere, numa só passada, para não retrocar o que já foi inserido
    titulo_linha <- grepl("^#{1,6} ", l[i])
    ch <- strsplit(l[i], "")[[1]]
    alvo <- ch %in% names(SIMBOLOS)
    if (any(alvo)) {
      ch[alvo] <- if (titulo_linha) "" else unname(SIMBOLOS[ch[alvo]])
      l[i] <- paste0(ch, collapse = "")
      if (titulo_linha) l[i] <- sub("^(#{1,6}) +", "\\1 ", l[i])
    }
  }
  # um capítulo por nota: se a nota tem vários títulos de nível 1 (notas antigas),
  # rebaixa todos um nível e usa o título do frontmatter como capítulo
  fora_codigo <- !cumsum(grepl("^\\s*(```|~~~)", l)) %% 2 | grepl("^\\s*(```|~~~)", l)
  h1 <- grepl("^# ", l) & fora_codigo
  nome_cap <- if (is.na(titulo)) basename(rel) else titulo
  if (sum(h1) > 1) {
    cab <- grepl("^#{1,5} ", l) & fora_codigo
    l[cab] <- paste0("#", l[cab])
    l <- c(paste("#", nome_cap), "", l)
  } else if (!any(h1)) {
    l <- c(paste("#", nome_cap), "", l)
  }
  c(l, "", "")
}

bloco_latex <- function(...) c("", "```{=latex}", ..., "```", "")

## ---- volumes -----------------------------------------------------------------------
capa <- function(volume, subtitulo, arquivo) {
  tex <- c(
    "\\begin{titlepage}",
    "\\newgeometry{margin=2.6cm}",
    "{\\sffamily\\small\\color{fxteal}PECO-5021/6021 · PPGEco/UFES · 2026/2\\par}",
    "\\vspace*{4.2cm}",
    "{\\sffamily\\bfseries\\fontsize{34}{38}\\selectfont Econometria I\\par}",
    "\\vspace{10pt}",
    sprintf("{\\sffamily\\LARGE\\color{fxeixo}%s\\par}", volume),
    "\\vspace{4pt}",
    sprintf("{\\sffamily\\large\\color{fxeixo}%s\\par}", subtitulo),
    "\\vspace{1.4cm}",
    "{\\color{fxteal}\\rule{3cm}{2pt}}\\par\\vspace{8pt}",
    "{\\large Caderno de estudo para a P1 de 02/10/2026\\par}",
    "\\vspace{3pt}",
    "{\\color{fxeixo}Prof. Edson Zambon Monte · livro-base: Greene, \\emph{Econometric Analysis}\\par}",
    "\\vfill",
    sprintf("{\\footnotesize\\color{fxeixo}Gerado em %s a partir de \\texttt{github.com/fcarva/econometria} (commit \\texttt{%s}). Material autoral: enunciados parafraseados, demonstrações próprias, números conferidos em R contra os scripts do repositório.\\par}", hoje, commit),
    "\\restoregeometry",
    "\\end{titlepage}"
  )
  writeLines(enc2utf8(tex), arquivo, useBytes = TRUE)
}

montar_md <- function(partes, arquivo) {
  linhas <- character()
  for (nome in names(partes)) {
    linhas <- c(linhas, bloco_latex(sprintf("\\part{%s}", nome)))
    for (rel in partes[[nome]]) linhas <- c(linhas, preparar_nota(rel))
  }
  writeLines(enc2utf8(linhas), arquivo, useBytes = TRUE)
}

rodar <- function(prog, args, wd, rotulo) {
  velho <- setwd(wd); on.exit(setwd(velho))
  saida <- suppressWarnings(system2(prog, args, stdout = TRUE, stderr = TRUE))
  st <- attr(saida, "status")
  if (!is.null(st) && st != 0) {
    cat(tail(saida, 40), sep = "\n")
    stop(rotulo, " falhou (status ", st, ")")
  }
  invisible(saida)
}

compilar <- function(nome, md, capa_tex, opcoes_extra = character(), passes = 2) {
  tex <- file.path(BUILD, paste0(nome, ".tex"))
  args <- c(shQuote(md), "-f", "commonmark_x+implicit_figures+wikilinks_title_after_pipe-subscript-alerts",
            "-t", "latex", "--standalone", "-o", shQuote(tex),
            "--lua-filter", shQuote(file.path(CAD, "filtros.lua")),
            "--include-in-header", shQuote(file.path(CAD, "preambulo.tex")),
            "-V", "papersize=a4", "-V", "geometry:top=2.3cm,bottom=2.3cm,left=2.3cm,right=2.3cm",
            "-V", "lang=pt-BR", "-V", "colorlinks=true", "-V", "linkcolor=fxteal",
            "-V", "urlcolor=fxazul", "-V", "toccolor=fxtexto",
            "-M", shQuote(paste0("title-meta=Econometria I — ", nome)),
            opcoes_extra)
  if (!is.null(capa_tex)) args <- c(args, "--include-before-body", shQuote(capa_tex))
  rodar(PANDOC, args, BUILD, "pandoc")
  t0 <- proc.time()[["elapsed"]]
  for (p in seq_len(passes)) {
    rodar(LUALATEX, c("-interaction=nonstopmode", "-halt-on-error", shQuote(basename(tex))), BUILD,
          paste("lualatex (passada", p, ")"))
  }
  pdf <- file.path(BUILD, paste0(nome, ".pdf"))
  destino <- file.path(SAIDA, paste0(nome, ".pdf"))
  file.copy(pdf, destino, overwrite = TRUE)
  log <- readLines(file.path(BUILD, paste0(nome, ".log")), warn = FALSE)
  paginas <- sub(".*\\((\\d+) pages?.*", "\\1", grep("Output written on", log, value = TRUE))
  faltando <- unique(grep("Missing character", log, value = TRUE))
  cat(sprintf("  %s.pdf: %s páginas, %.0fs de LaTeX%s\n", nome, paginas,
              proc.time()[["elapsed"]] - t0,
              if (length(faltando)) sprintf(", %d glifos ausentes", length(faltando)) else ""))
  if (length(faltando)) cat(paste0("    ", head(faltando, 8)), sep = "\n")
  invisible(destino)
}

OPC_LIVRO <- c("--top-level-division=chapter", "--toc", "--toc-depth=1", "--number-sections",
               "-V", "secnumdepth=0", "-V", "documentclass=book",
               "-V", "classoption=oneside", "-V", "classoption=openany", "-V", "fontsize=11pt")

volume_teoria <- function() {
  partes <- list(
    "Revisão rápida" = c("formulario/ultima_revisao.md", "formulario/formulario.md",
                         "formulario/vocabulario_interpretacao.md", "formulario/errata_chave_lista1.md"),
    "Intuição visual" = c("didatica/intuicao_visual.md"),
    "Teoria" = c("00_fundamentos/00_teoria.md", "01_paradigma_projecao/01_teoria.md",
                 "02_mqo_simples/02_teoria.md", "03_mqo_matricial/03_teoria.md",
                 "04_fwl_particionada/04_teoria.md", "05_ajuste_restricoes/05_teoria.md",
                 "06_amostra_finita_multicol/06_teoria.md", "07_testes_hipoteses/07_teoria.md",
                 "08_assintotica/08_teoria.md", "09_dummies_forma_funcional/09_teoria.md",
                 "09_dummies_forma_funcional/did.md", "10_endogeneidade_iv/10_teoria.md"),
    "Demonstrações centrais e aulas" = c("demonstracoes/econometria-i-demonstracoes-mes-1-1.md",
                                         "demonstracoes/caderno_aulas.md"),
    "Fontes" = c("fontes/fontes_primarias.md", "fontes/cursos_e_livros.md", "fontes/referencias.md")
  )
  md <- file.path(BUILD, "volume1.md"); montar_md(partes, md)
  capa("Volume 1", "Revisão, intuição, teoria, demonstrações e fontes", file.path(BUILD, "capa1.tex"))
  compilar("caderno_volume1_teoria", md, file.path(BUILD, "capa1.tex"), OPC_LIVRO, passes = 3)
}

volume_exercicios <- function() {
  partes <- list(
    "Lista 1 resolvida" = c("00_fundamentos/00_lista1.md", "01_paradigma_projecao/01_lista1.md",
                            "02_mqo_simples/02_lista1.md", "03_mqo_matricial/03_lista1.md",
                            "04_fwl_particionada/04_lista1.md", "05_ajuste_restricoes/05_lista1.md",
                            "06_amostra_finita_multicol/06_lista1.md", "07_testes_hipoteses/07_lista1.md",
                            "07_testes_hipoteses/07_lista1_computacional.md", "08_assintotica/08_lista1.md",
                            "09_dummies_forma_funcional/09_lista1.md", "10_endogeneidade_iv/10_lista1.md"),
    "A prova de 2025/2" = c("provas/p1_2025_2/README.md", "provas/p1_2025_2/econometria-i-prova-2025-2-resolvida.md"),
    "Bancos de questões" = c("provas/banco/derivacoes.md", "provas/banco/interpretacao.md",
                             "provas/banco/flashcards.md"),
    "Gabaritos dos simulados" = c("provas/simulados/simulado_01_gabarito.md",
                                  "provas/simulados/simulado_02_gabarito.md",
                                  "provas/simulados/simulado_03_gabarito.md")
  )
  md <- file.path(BUILD, "volume2.md"); montar_md(partes, md)
  capa("Volume 2", "Lista 1, provas, bancos de questões e gabaritos", file.path(BUILD, "capa2.tex"))
  compilar("caderno_volume2_exercicios", md, file.path(BUILD, "capa2.tex"), OPC_LIVRO, passes = 3)
}

simulados <- function() {
  for (k in 1:3) {
    rel <- sprintf("provas/simulados/simulado_%02d.md", k)
    md <- file.path(BUILD, sprintf("simulado_%02d.md", k))
    corpo <- preparar_nota(rel)
    cab <- bloco_latex(
      "\\thispagestyle{plain}",
      "{\\sffamily\\small\\color{fxeixo}Econometria I (PECO-5021/6021) · PPGEco/UFES · 2026/2 · simulado da P1\\par}",
      "\\vspace{6pt}",
      "{\\sffamily Nome: \\rule{7.5cm}{0.4pt}\\hfill Início: \\rule{1.6cm}{0.4pt}\\hfill Fim: \\rule{1.6cm}{0.4pt}\\par}",
      "\\vspace{10pt}"
    )
    writeLines(enc2utf8(c(cab, corpo)), md, useBytes = TRUE)
    compilar(sprintf("simulado_%02d", k), md, NULL,
             c("--top-level-division=section", "-V", "documentclass=article", "-V", "fontsize=11pt"),
             passes = 1)
  }
}

## ---- execução ------------------------------------------------------------------------
alvos <- commandArgs(trailingOnly = TRUE)
if (!length(alvos)) alvos <- c("teoria", "exercicios", "simulados")
cat("pandoc:  ", PANDOC, "\nlualatex:", LUALATEX, "\n")
if ("teoria" %in% alvos) volume_teoria()
if ("exercicios" %in% alvos) volume_exercicios()
if ("simulados" %in% alvos) simulados()
cat("\nPDFs em caderno/pdf/\n")
