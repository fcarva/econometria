---
title: "Módulo 07 — Testes de hipóteses (hub)"
modulo: "07"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
greene: "cap. 5 (5.1–5.6, 5.8–5.9); 14.6"
slides: "SL07"
lista1: [38, 39, 41, 42, 44, 45, 46, 49, 50, 51, 52, 74]
relevancia_p1: alta
status: rascunho
tags:
  - econometria
  - mestrado/ppgeco
  - p1
---

# Módulo 07 — Testes de hipóteses

Metade da P1 é leitura de output: tabela de MQO (no estilo NLOGIT ou EViews), testes $t$, $F$, IC, Jarque-Bera e diagnósticos do `ivreg`. Este módulo junta a teoria que sustenta cada linha dessas tabelas e resolve os exercícios de interpretação da Lista 1.

> [!NOTE]
> **Arquivos do módulo**
> - [07_teoria.md](07_teoria.md): hipótese linear geral, distribuição exata do $F$ e do $t$, tamanho, poder, p-valor, IC, a trindade Wald/LM/LR (com $W\ge LR\ge LM$), Jarque-Bera, omissão e inclusão de variáveis, RESET, teste LM de termos não lineares, modelos não aninhados, White, Breusch-Pagan, Breusch-Godfrey e Durbin-Watson, e o mapa "campo do output → fórmula". Demonstrações D07.1–D07.15.
> - [07_lista1.md](07_lista1.md): Lista 1, ex. 41, 42, 44, 45, 46, 49, 50, 51 e 52 (interpretação de output e especificação), sempre no modelo de 4 linhas.
> - [07_lista1_computacional.md](07_lista1_computacional.md): Lista 1, ex. 38, 39 e 74 (regressões rodadas em R: vendas de cabos, RESET, multicolinearidade, DW, BG, White; regressão livre com dados reais). Script [07_computacional.R](07_computacional.R), id `m07a`.
> - [07_testes_hipoteses.R](07_testes_hipoteses.R): script da teoria e dos exercícios de output, id `m07b`. Valores críticos, ANOVA a partir do output, IC, conferências $F=t^2$, auditoria de outputs e simulações de tamanho, poder, Jarque-Bera, trindade e especificação. Figuras `figuras/07b_*.png`.

## Ordem de estudo sugerida

1. [07_teoria.md](07_teoria.md), seções 1–3 (D07.1–D07.6): a distribuição do $F$ cai como derivação e sustenta todo o resto.
2. Seção 9 da teoria (leitura de outputs) e depois [07_lista1.md](07_lista1.md), ex. 41, 42, 44 e 46: é o tipo Q1 da P1 2025/2.
3. Seções 4–7 da teoria (trindade, JB, especificação) e os ex. 45, 49–52.
4. [07_lista1_computacional.md](07_lista1_computacional.md) para ver os testes de diagnóstico rodando.

## Onde cada exercício está

| Ex. | Tema | Arquivo | Chave |
|---|---|---|---|
| 38 | Vendas de cabos: regressão múltipla, t e F a 10% | [computacional](07_lista1_computacional.md) | ver nota |
| 39 | Vendas de cabos: RESET, multicolinearidade, DW, BG, White | [computacional](07_lista1_computacional.md) | ver nota |
| 41 | PIB × investimento: sinais, $R^2$, $r$ × $R^2$, efeito de variação | [lista](07_lista1.md) | ⚠️ |
| 42 | IC e teste $t$ da inclinação do ex. 41 | [lista](07_lista1.md) | ✅ |
| 44 | Custo × quantidade: elasticidade, $t$, $F$, IC, JB | [lista](07_lista1.md) | ✅ |
| 45 | Custo em log: log-lin e log-log | [lista](07_lista1.md) | ✅ |
| 46 | PIB × crédito log-log: $t$, IC, $R^2$, JB, ANOVA, elasticidade | [lista](07_lista1.md) | ⚠️ |
| 49 | Má especificação e passos do RESET | [lista](07_lista1.md) | ➖ |
| 50 | Leitura de um RESET | [lista](07_lista1.md) | ❌ |
| 51 | Quadrática verdadeira × reta ajustada | [lista](07_lista1.md) | ✅ |
| 52 | Teste LM: restrita × irrestrita | [lista](07_lista1.md) | ✅ |
| 74 | Regressão múltipla livre com dados reais | [computacional](07_lista1_computacional.md) | ver nota |

> [!CAUTION]
> **Chave errada e outputs editados**
> - Ex. 50: a chave diz "mal especificado", mas $F=2{,}28\lt 4{,}10$ e $p=0{,}20\gt 0{,}05$. **Não** se rejeita $H_0$: não há evidência de má especificação. Ver a [errata](../formulario/errata_chave_lista1.md).
> - Ex. 46: o output tem números incompatíveis entre si ($F$ impresso $=t^2=110{,}56$, mas o $F$ implicado por $R^2$ e SQR é 131,28; o JB impresso na lista é 18,87, e o recalculado com a assimetria e a curtose impressas é 10,48, o valor da chave). Decida sempre pelo número impresso na questão e, se sobrar tempo, anote a incoerência numa linha.

## Ligações com outros módulos

- [Módulo 05](../05_ajuste_restricoes/05_teoria.md): D05.10 e D05.12 ($F$ pelas SQR e pelo $R^2$), D05.8 (log-verossimilhança e AIC/SC/HQ). Aqui não se repetem; a distribuição exata do $F$, que o D05.12 só esboça, está completa em D07.2.
- D0–D16 do aluno ([demonstracoes](../demonstracoes/econometria-i-demonstracoes-mes-1-1.md)): D9 e D14 (não-viés e variância de $b$) são o ponto de partida de D07.1.
- [P1 2025/2 resolvida](../provas/p1_2025_2/econometria-i-prova-2025-2-resolvida.md): Q1a (JB com $n$ grande), Q1b (teste $t$), Q1d (IC) e Q2f (Wald $\chi^2$) usam este módulo.
- Módulos 08 (assintótica: base do Wald robusto e do JB), 09 (forma funcional, elasticidades) e 10 (Wu-Hausman e Sargan).
