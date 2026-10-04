---
title: "Lista 1 v.1 — a lista que o professor fez junto com a prova"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
relevancia_p1: alta
status: verificado
tags:
  - econometria
  - mestrado/ppgeco
  - p1
  - lista
aliases:
  - Lista 1 v.1 — leitura da prova
---

# Lista 1 v.1: a reta final passa por aqui

O professor distribuiu uma versão nova da Lista 1 — 79 exercícios, "Parte I", com chave de correção — e montou a P1 na mesma época. A premissa desta pasta: **a prova sai desta lista**. Tudo o que vem abaixo é a consequência prática disso.

| Arquivo | O que tem |
|---|---|
| [mapa.md](mapa.md) | Os 79 exercícios: paráfrase, equivalente na lista antiga, onde está resolvido, status da chave, prioridade |
| [novos.md](novos.md) | O que o repositório não cobria: 17 contas no formato de prova e 7 demonstrações novas |
| [algoritmo.md](algoritmo.md) | O roteiro de cada família de questão, em 16 seções: passos encadeados, o porquê de cada um e de onde vem |
| [socratico.md](socratico.md) | As mesmas 16 seções em escadas de perguntas, da intuição até a demonstração, para ler junto com o algoritmo |
| [lista1_v1.R](lista1_v1.R) | Confere os números da chave v.1 e das notas (id `l1v`, 96 valores) |
| [errata](../../formulario/errata_chave_lista1.md) | Seção nova com os problemas da chave v.1 |

## A evidência: a lista nova absorveu a P1 2025/2 inteira

| P1 2025/2 | Pontos | Na Lista 1 v.1 |
|---|---|---|
| Q1 — output de salários: t com $z=1{,}96$, pico de EXP, IC, dummy, $\bar R^2$ | 3,0 | **ex. 45 e 62**: salários log-nível com EXP, EXP², FEMALE, $t_{tab}=1{,}96$ e o pico de EXP |
| Q2 — `ivreg` dos cigarros | 3,5 | **ex. 77**: o mesmo output, com os mesmos p-valores editados |
| Q3 — derivação escalar do MQO | 1,25 | **ex. 2 e 28** |
| Q4 — erro de medição na dependente | 1,0 | **ex. 74** (e o contraste no 75) |
| Q5 — $\operatorname{Var}(b)$ e consistência | 0,75 | **ex. 35 e 52** |
| Q6 — $\widehat\beta_{IV}$ com $L=K$ via plim | 0,5 | **ex. 73b** |

As seis questões estão lá, quase com a mesma redação. Não é prova de que a P1 2026 repete a de 2025, mas mostra como o professor trabalha: **a lista é escrita a partir do que ele cobra**.

> [!IMPORTANT]
> **O formato provável da P1**
> Duas questões de output valendo cerca de dois terços (uma regressão de MQO com log, quadrático e dummy; um `ivreg` com diagnósticos) e quatro demonstrações curtas tiradas das seções 3, 4, 7 e 9. O enunciado entrega os valores críticos. Prepare-se para isso antes de qualquer outra coisa.

## O que a lista nova acrescenta, e por isso merece atenção

1. **F por soma de quadrados restrita e irrestrita, três vezes** (ex. 45b, 50, 64b). Conta de dois minutos, quatro linhas de resposta. É o tipo de item que entra num output sem aviso: "ao reestimar sem X, obteve-se SQR = …".
2. **Revisão de graduação** (seção 1, ex. 1–14): Breusch-Pagan, Durbin-Watson, regressão espúria, mudança de escala, VIF. Na prova antiga não havia nada disso; aqui são 14 exercícios. Espere pelo menos um item conceitual curto — o **quadro do ex. 14** tem cara de questão.
3. **Contas à mão pequenas**: MQO matricial 3×3 com $X$ ortogonal (ex. 26), FWL com 5 observações (ex. 31), VI com somatórios dados (ex. 73a).
4. **Demonstrações que não estavam no roteiro antigo**: $E(s^2)=\sigma^2$ (39), MQ restrito (40), $\operatorname{plim}s^2$ (54), exogeneidade estrita × contemporânea (56), regressão pela origem (32).

## O que saiu, e pode ir para o fim da fila

- Os fundamentos 1 a 9 da lista antiga (propriedades de variância e covariância). Só a consistência da média por Chebyshev sobreviveu (ex. 51).
- O bloco computacional de diagnósticos (antigo ex. 39: White, BG, regressões auxiliares, matriz de correlação) e a seção 6 inteira.
- Os outputs de demanda por energia, etanol, setor informal e o teste LM (antigos 52, 55, 56, 59, 62).

Isso não quer dizer que não caem — o conteúdo está nos slides. Quer dizer que, com pouco tempo, ficam por último.

## As armadilhas que a própria lista arma

> [!CAUTION]
> **SQR muda de significado no meio da lista**
> Nos ex. 29, 43, 45, 50 e 64, **SQR é a soma dos quadrados dos resíduos** e SQE a explicada. Nos ex. 41 e 42, o enunciado inverte: SQR vira a soma da regressão e SQE a dos resíduos. Na prova, **defina a sigla na primeira linha** ("SQR = soma dos quadrados dos resíduos") e escreva a fórmula com ela. Quem copia a fórmula de memória com a convenção errada inverte o F.

> [!CAUTION]
> **Decida pelo número impresso, mesmo quando ele é estranho**
> A lista traz um F que não bate com o $R^2$ (ex. 6), um crítico de $\chi^2(2)$ que não é de 5% (ex. 46, 2,54 em vez de 5,99), um Sargan com o gl errado e um Wu-Hausman com o p editado (ex. 77). Em todos, a decisão pelo número impresso é a que a chave aceita. No ex. 77, **a 5%, o p verdadeiro (0,0569) levaria à conclusão oposta** — por isso vale escrever explicitamente "como p = 0,0469 < 0,05".

## A fila da reta final

Na ordem, do que mais rende ao que menos rende. O cronograma dia a dia está no [CRONOGRAMA](../../CRONOGRAMA.md).

| # | Bloco | Exercícios v.1 | Onde |
|---|---|---|---|
| 1 | Output de MQO em log com quadrático e dummy | 44, 45, 62, 61 | novos; [vocabulário](../../formulario/vocabulario_interpretacao.md) |
| 2 | Output do `ivreg` a 5% | 77 (e 72, 76) | novos; [10 lista](../../10_endogeneidade_iv/10_lista1.md) |
| 3 | F por SQR e F pelo $R^2$ | 6, 42, 45b, 50, 64 | novos; D05.12 |
| 4 | Derivações de MQO simples | 2, 28, 33, 36 | D02.1–D02.7 |
| 5 | $\operatorname{Var}(b)$, Gauss-Markov, $E(s^2)$ | 35, 37, 38, 39 | D06.3–D06.7 |
| 6 | Consistência: $\operatorname{plim}\mathbf b$, $\operatorname{plim}s^2$, estrita × contemporânea | 51–54, 56 | D08.1–D08.3, D08.7 |
| 7 | Endogeneidade: plim, simultaneidade, erro de medição, VI | 71, 73, 74, 75 | D10.1–D10.5 |
| 8 | Álgebra: $\mathbf M$, $\mathbf P$, $\mathbf X'\mathbf e=0$, FWL, traço | 16–18, 20, 22 | D03.4, D04.2, D06.7 |
| 9 | Contas pequenas à mão | 4, 26, 27, 31, 73a | novos |
| 10 | Seção 1 conceitual: quadro, BP, DW, multicolinearidade | 8–11, 14 | novos |
| 11 | Dummies, Chow, DiD | 7, 64, 65, 67, 68 | D09.1–D09.8 |
| 12 | Resto: escala, espúria, padronizado, spline, AIC/BIC, Wald | 12, 13, 48, 49, 69, 70 | novos |
