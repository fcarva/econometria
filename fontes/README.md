---
title: "Fontes — artigos originais, cursos e livros"
disciplina: Econometria I (PECO-5021/6021)
relevancia_p1: media
status: rascunho
tags:
  - econometria
  - mestrado/ppgeco
  - fontes
aliases:
  - Fontes
---

# Fontes

O resto do repositório ensina **o resultado**. Esta pasta mostra **de onde ele veio**: o artigo original, o que o autor provou de fato, e onde a versão do livro-texto simplifica.

| Arquivo | Conteúdo |
|---|---|
| [fontes_primarias.md](fontes_primarias.md) | módulo a módulo: quem provou, o que o original fez, onde o livro simplifica; sete resultados reproduzidos em R |
| [cursos_e_livros.md](cursos_e_livros.md) | as seções do Greene, do Hayashi, do Wooldridge e do Stock-Watson para cada módulo; cursos abertos de Stanford e do MIT; livros de doutorado |
| [referencias.md](referencias.md) | as 104 referências, com DOI conferido no Crossref (gerado) |
| [referencias.bib](referencias.bib) | o mesmo, em BibTeX, para importar no Zotero (gerado) |
| [fontes.R](fontes.R) | reproduz Frisch-Waugh, Ding, White (1980, IER), Halvorsen-Palmquist, Berndt-Savin, Koenker, MacKinnon-White e Card; desenha a linha do tempo (id `fts`) |
| [referencias.R](referencias.R) | fonte única da bibliografia: gera o `.bib` e o `.md` |

## O que dá para levar para a prova

| Achado | Onde entra |
|---|---|
| Gauss-Markov não precisa de normalidade; MV sob normalidade é a outra rota | justificar hipóteses nas demonstrações do módulo 06 |
| o erro-padrão da regressão parcial precisa de correção de graus de liberdade | pergunta sobre FWL que peça inferência |
| $W\ge LR\ge LM$ sempre, no modelo linear normal | comparar os três testes do módulo 07 |
| o `bptest` do R é a versão de Koenker | interpretar output de heterocedasticidade |
| dummy em log: $100(e^{c}-1)$, não $100c$ | interpretação de coeficientes no módulo 09 |
| $F>10$ é regra de viés; para o teste $t$ valer, $F>104{,}7$ | discutir instrumentos fracos no output do `ivreg` |
| VI com efeitos heterogêneos estima o LATE | explicar por que VI e MQO diferem |
