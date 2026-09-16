# Gera demonstracoes/INDICE_D.md varrendo todos os .md em busca de cabeçalhos de
# demonstração: "## D9 · ..." (notas antigas) e "### D07.3 · ..." (módulos).
# Rodar: powershell -ExecutionPolicy Bypass -File scripts\r.ps1 scripts\indice_D.R

# --- bootstrap: localizar a raiz do repo e carregar helpers ---
.d <- getwd(); while (!file.exists(file.path(.d, ".repo-root")) && dirname(.d) != .d) .d <- dirname(.d)
source(file.path(.d, "R", "raiz.R"))

RAIZ <- raiz()
mds <- list.files(RAIZ, pattern = "\\.md$", recursive = TRUE, full.names = TRUE)
mds <- mds[!grepl("/materiais/|/econometria/|/\\.git/", mds)]

padrao <- "^#{2,4}\\s+(D[0-9]+(\\.[0-9]+)?)\\s*[·:-]\\s*(.+?)\\s*$"
linhas <- list()

for (md in mds) {
  txt <- readLines(md, warn = FALSE, encoding = "UTF-8")
  hits <- grep(padrao, txt)
  for (h in hits) {
    m <- regmatches(txt[h], regexec(padrao, txt[h]))[[1]]
    id <- m[2]; titulo <- m[4]
    rel <- sub(paste0(RAIZ, "/"), "", gsub("\\\\", "/", md), fixed = TRUE)
    modulo <- if (grepl("\\.", id)) sub("^D([0-9]+)\\..*$", "\\1", id) else "núcleo"
    num <- if (grepl("\\.", id)) as.numeric(sub("^D[0-9]+\\.", "", id)) else as.numeric(sub("^D", "", id))
    linhas[[length(linhas) + 1]] <- data.frame(
      id = id, titulo = titulo, arquivo = rel, modulo = modulo, num = num,
      stringsAsFactors = FALSE)
  }
}

if (!length(linhas)) stop("Nenhuma demonstração encontrada.")
tab <- do.call(rbind, linhas)
tab <- tab[order(tab$modulo == "núcleo", tab$modulo, tab$num), ]
tab <- tab[!duplicated(tab$id), ]

out <- c(
  "---",
  'title: "Índice de demonstrações"',
  "disciplina: Econometria I (PECO-5021/6021)",
  "status: gerado",
  "tags:",
  "  - econometria",
  "  - mestrado/ppgeco",
  "  - demonstracoes",
  "aliases:",
  "  - Índice de demonstrações",
  "---",
  "",
  "# Índice de demonstrações",
  "",
  "Gerado por `scripts/indice_D.R`. Não edite à mão.",
  "",
  "| ID | Demonstração | Onde está |",
  "|---|---|---|"
)

for (i in seq_len(nrow(tab))) {
  alvo <- paste0("../", tab$arquivo[i])
  out <- c(out, sprintf("| **%s** | %s | [%s](%s) |", tab$id[i], tab$titulo[i], tab$arquivo[i], alvo))
}

out <- c(out, "", sprintf("Total: **%d** demonstrações em %d arquivos.",
                          nrow(tab), length(unique(tab$arquivo))))

destino <- file.path(RAIZ, "demonstracoes", "INDICE_D.md")
con <- file(destino, open = "wb")
writeLines(enc2utf8(out), con, useBytes = TRUE)
close(con)
cat("Escrito", destino, "com", nrow(tab), "demonstrações\n")
