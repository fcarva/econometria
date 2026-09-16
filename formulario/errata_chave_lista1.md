---
title: "Errata da chave de correção da Lista 1"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
status: rascunho
verificacao:
  chave: parcial
tags:
  - econometria
  - mestrado/ppgeco
  - lista
aliases:
  - Errata da chave
---

# Errata da chave de correção da Lista 1

A chave (`materiais/listas/lista1_chave.pdf`) é útil, mas tem erros e inconsistências. Aqui ficam registrados os pontos em que a nossa resposta diverge, sempre com o motivo. Nada da chave é reproduzido: cada linha descreve o conteúdo com palavras próprias.

> [!WARNING]
> **Como usar**
> Se na prova aparecer uma dessas situações, responda pelo argumento correto, não pelo que a chave diz. Em caso de ambiguidade genuína, escreva a regra de decisão explicitamente ("como $p \gt \alpha$, não se rejeita H0") — é isso que garante o ponto.

| Ex. | O que a chave conclui | O correto | Por quê | Impacto na prova |
|---|---|---|---|---|
| 50 | que o modelo está mal especificado | **não** há evidência de má especificação | O RESET traz $F=2{,}284568$ contra $F_{crit}=4{,}10$, e $p=0{,}20267 \gt 0{,}05$. Com a estatística abaixo do crítico, não se rejeita H0, e H0 é "modelo corretamente especificado". | Alto: RESET é candidato garantido a questão de interpretação. Erre a direção da decisão e perde a questão inteira. |
| 46 f | conclusão de não normalidade | a conclusão (rejeitar normalidade) está certa, mas os **números não batem entre lista e chave** | O enunciado da lista mostra $JB = 18{,}870682$; a chave usa $10{,}48190$. Os dois superam o crítico de $\chi^2_2$ a 5% (5,99), então a decisão não muda — mas o valor crítico citado nos dois lugares também difere. | Médio: mostra que os números do enunciado podem estar desalinhados. Sempre cite qual estatística e qual crítico você usou. |

## Padrão de resposta quando a chave e a conta divergem

1. Escreva as hipóteses.
2. Cite a estatística **do enunciado** e o crítico **do enunciado**.
3. Compare explicitamente e conclua.
4. Se o resultado contrariar o "esperado", diga em uma linha por que a decisão é essa.

Esse roteiro deixa o argumento verificável, que é o que vale ponto.

## A conferir

A auditoria exercício a exercício da chave ainda não terminou. Boa parte dos itens da chave apenas remete a livro (Gujarati, Wooldridge, Greene) e não tem resposta desenvolvida — esses entram como ➖ no [LISTA1_MAPA.md](../LISTA1_MAPA.md).
