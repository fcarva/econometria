---
title: "Caderno em PDF — o repositório no papel"
disciplina: Econometria I (PECO-5021/6021)
relevancia_p1: alta
status: rascunho
tags:
  - econometria
  - mestrado/ppgeco
  - p1
aliases:
  - Caderno em PDF
---

# Caderno em PDF

A prova é no papel; o estudo final também deveria ser. Esta pasta transforma as notas do repositório em livros para imprimir. Os PDFs ficam em `caderno/pdf/`, **fora do git** como todo PDF: são gerados, não versionados.

| Arquivo gerado | Conteúdo | Para quê |
|---|---|---|
| `caderno_volume1_teoria.pdf` | revisão rápida, intuição visual, teoria dos módulos 00–10, demonstrações centrais, caderno de aula, fontes | estudar e anotar à mão |
| `caderno_volume2_exercicios.pdf` | Lista 1 resolvida, P1 de 2025/2, bancos de derivações e de outputs, flashcards, gabaritos | conferir depois de resolver |
| `simulado_01.pdf` a `simulado_03.pdf` | só as questões, com campo para nome e horário | resolver cronometrado, no papel, antes de abrir o gabarito do volume 2 |

## Gerar

```powershell
powershell -ExecutionPolicy Bypass -File scripts\r.ps1 caderno\montar_caderno.R
```

Para gerar só uma parte, passe `teoria`, `exercicios` ou `simulados` como argumento. O volume 1 leva alguns minutos, porque o LaTeX roda três passadas para acertar o sumário.

**Requisitos:** o pandoc (o que vem com o RStudio serve; o script o encontra sozinho) e o LuaLaTeX (MiKTeX ou TeX Live). As fontes são Libertinus, que vêm com o MiKTeX, e Consolas e Segoe UI Symbol, que vêm com o Windows.

## Como funciona

| Etapa | Arquivo | O que faz |
|---|---|---|
| 1. preparo | [montar_caderno.R](montar_caderno.R) | lê cada nota, tira o frontmatter, torna absolutos os caminhos das figuras e troca emoji por símbolos que a fonte desenha |
| 2. conversão | [filtros.lua](filtros.lua) | filtro do pandoc: callouts viram caixas coloridas; links para outras notas viram texto; tabelas `chave_R` viram uma linha discreta de conferência; tabelas largas ganham quebra de linha |
| 3. tipografia | [preambulo.tex](preambulo.tex) | paleta Flexoki (a mesma das figuras), títulos em sans, código com quebra de linha, cabeçalho com o capítulo |
| 4. compilação | LuaLaTeX | gera o PDF e avisa se algum símbolo ficou sem glifo |

A ordem dos capítulos está nas funções `volume_teoria()` e `volume_exercicios()` do script. Nota nova entra editando essas listas.
