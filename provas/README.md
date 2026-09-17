---
title: "Provas — guia de treino para a P1"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
prova: "P1 — 02/10/2026"
slides: "SL01–SL10"
relevancia_p1: alta
status: rascunho
tags:
  - econometria
  - mestrado/ppgeco
  - p1
  - prova
aliases:
  - Guia de provas
---

# Provas: como treinar para a P1 de 02/10/2026


> [!NOTE]
> **Revisão espaçada**
> Os [flashcards](banco/flashcards.md) cobrem 60 perguntas curtas com resposta escondida, organizadas por módulo — são a ferramenta das revisões de +1, +3 e +7 dias.

> [!IMPORTANT]
> **A distribuição real de pontos da P1 2025/2**
> Interpretação de output (Q1 e Q2) valeu **6,5 dos 10 pontos**; as quatro demonstrações, 3,5. Comece sempre pelas questões de output. Mapa completo em [p1_2025_2/README.md](p1_2025_2/README.md).

> [!NOTE]
> **O que há nesta pasta**
>
> | Arquivo | Para quê |
> |---|---|
> | [p1_2025_2/](p1_2025_2/econometria-i-prova-2025-2-resolvida.md) | a P1 de 2025/2 resolvida: é o molde da sua prova |
> | [p1_2025_2/reproducao.R](p1_2025_2/reproducao.R) | reproduz em R os dois outputs da P1 2025/2 e as contas das respostas |
> | [p2_2024_2/mapa.md](p2_2024_2/mapa.md) | tipos de questão da P2 2024/2 e onde estudar cada um |
> | [banco/derivacoes.md](banco/derivacoes.md) | 37 derivações no estilo do professor, com tempo-alvo e os passos que valem ponto |
> | [banco/interpretacao.md](banco/interpretacao.md) | 20 outputs com perguntas e respostas-modelo |
> | [banco/gerar_outputs.R](banco/gerar_outputs.R) | gera todos os outputs de `banco/outputs/` |
> | [simulados/](simulados/simulado_01.md) | três simulados completos (o 03 é reserva), cada um com gabarito e rubrica |
> | [log_erros.md](log_erros.md) | registro de erros com revisão espaçada |

## 1. O padrão da prova

A P1 2025/2 (03/10/2025) é o melhor retrato do que vem. A estrutura é estável: **metade da nota é leitura de output, metade é derivação.**

| Bloco | O que aparece | O que o professor cobra |
|---|---|---|
| Q1: output de MQO no layout do NLOGIT (Coeficientes, Erro padrão, b/E.p., P[\|Z\|>z], Média de X) | equação de log-salário com quadrático em EXP e dummies | precisa de Jarque-Bera com $n$ grande?; teste $t$ com $z=1{,}96$; ponto de máximo do quadrático; IC de 95%; efeito percentual de dummy; $\bar R^2$ |
| Q2: output de VI/MQ2E (R `ivreg` com `diagnostics = TRUE` ou NLOGIT MQ2E) | demanda por cigarros, log-salário | qual variável é endógena e quais são instrumentos; relevância e exogeneidade; instrumentos fracos; Wu-Hausman; Sargan; Wald $\chi^2$ conjunto; elasticidade |
| Q3–Q6: derivações | escalar e matricial | equações normais e $b_1,b_2$; (não-)viés, inclusive com erro de medição; variância; consistência via $\operatorname{plim}$; estimador de VI via $\operatorname{plim}$ |

> [!IMPORTANT]
> **Toda resposta de teste tem quatro linhas**
>
> ```text
> Hipóteses:   H0: ...   vs   H1: ...
> Estatística: valor impresso (ou calculado) e sua distribuição sob H0
> Decisão:     compara com o valor crítico dado OU o p-valor com o α dado  ⇒  rejeita / não rejeita H0
> Conclusão:   o que isso significa para o modelo e para a economia do problema
> ```
>
> E toda derivação começa pelas hipóteses que serão usadas e termina com o resultado em destaque. Cada linha algébrica leva a sua justificativa: hipótese *[A1]–[A6]*, linearidade de $E$, variância de forma linear, truque do traço, lei das expectativas iteradas, regras de $\operatorname{plim}$/Slutsky.

## 2. Estratégia no dia

1. **Leitura de 3 minutos.** Percorra a prova inteira e sublinhe, em cada item, o **α** (5% ou 10%) e o **valor crítico** que o enunciado fornece ($z=1{,}96$, $\chi^2$ tabelado). Isso decide metade das respostas.
2. **Outputs primeiro (Q1 e Q2).** São pontos rápidos e certos. Use o modelo de quatro linhas em todo teste.
3. **Derivações depois, da mais curta para a mais longa.** Equações normais e erro de medição são curtas; Gauss-Markov matricial e MQ2E são longas.
4. **Reserve 10 minutos para revisar** sinais, α e dimensões de matrizes.

## 3. Orçamento de tempo

A duração exata da prova não está no material. Planeje por **minutos por ponto**: divida a duração por 10. Com 180 minutos, por exemplo, cada ponto vale 18 minutos, um item de output de 0,5 ponto merece até 9 minutos e uma derivação de 1,5 ponto, até 27. Os tempos-alvo do banco foram calibrados para você ficar **abaixo** disso e sobrar tempo para a revisão.

| Tarefa | Tempo-alvo no treino |
|---|---|
| item de output (teste, IC, efeito de dummy) | 3–5 min |
| ponto de máximo com a conta | 4 min |
| equações normais e $b_1,b_2$ | 10–12 min |
| (não-)viés com erro de medição e $\operatorname{plim}$ | 10–12 min |
| $\operatorname{Var}(b\mid X)$ e consistência | 12–15 min |
| Gauss-Markov matricial, FWL, MQ2E | 15–20 min |

## 4. Lógica da correção

Ninguém tem a rubrica oficial. A dos simulados deste repositório segue o que a P1 2025/2 resolvida e a chave da Lista 1 mostram:

- **Item de teste:** hipóteses bem escritas, estatística e valor crítico (ou p-valor), decisão correta e conclusão com a economia do problema. Resposta só com "rejeita $H_0$" perde a maior parte do item.
- **Item de cálculo** (ponto de máximo, IC, efeito percentual): fórmula antes da conta, conta com os números do output e interpretação com "tudo mais constante".
- **Derivação:** os pontos estão nos passos intermediários (substituir o modelo, isolar o termo de erro amostral, justificar por que ele some). O resultado final sem os passos vale pouco.

## 5. Como usar o banco, os simulados e o log

| Semana | Treino |
|---|---|
| 15–20/09 | 3 derivações do banco por dia (uma escalar, uma matricial, uma de VI/assintótica) + 2 itens de interpretação. Tudo que errar vai para o [log](log_erros.md). |
| 21/09 | [Simulado 01](simulados/simulado_01.md) cronometrado. Corrija com o [gabarito](simulados/simulado_01_gabarito.md) e a rubrica. |
| 22–25/09 | Revisões +1/+3 do log; derivações do banco ainda não feitas. |
| 26/09 | [Simulado 02](simulados/simulado_02.md). |
| 27–30/09 | Revisões +1/+3/+7; itens do banco marcados como fracos. |
| 29/09 ou 30/09 | [Simulado 03](simulados/simulado_03.md) (reserva), só se os dois primeiros ficaram abaixo de 8. |
| 01/10 | Só leitura: o formulário de cabeça e as seções "Como o professor pode torcer". |

Nos simulados, a regra é **condição de prova**: sem consulta, com cronômetro e resposta escrita à mão. A correção é pela rubrica, passo por passo, e a nota vai para o topo do gabarito.

## 6. A lição dos outputs reciclados

O professor reaproveita o **mesmo output** em provas e listas diferentes e **edita os p-valores**. O bloco de diagnósticos do `ivreg` da demanda por cigarros é o caso mais claro:

| Versão | Weak instruments | Wu-Hausman: estatística (p) | Sargan: estatística (p) | α pedido |
|---|---|---|---|---|
| Lista 1, ex. 67 | 228,738 (<2e-16) | 3,823 (0,0569) | 0,333 (0,5641) | 10% |
| P2 2024/2, Q6 | 228,738 (0,0000) | 3,823 (0,0369) | 0,333 (0,5641) | 5% |
| P1 2025/2 (nota resolvida) | 228,738 (0,0000) | 3,823 (0,0469) | p = 0,8468 | 5% |

O que o R dá de fato, rodando o exemplo do Stock e Watson com `AER::CigarettesSW` (ver [reproducao.R](p1_2025_2/reproducao.R)):

| chave_R | nota |
|---|---|
| prv_q2_rob_wh | 3,823 |
| prv_q2_rob_wh_p | 0,0569 |
| prv_q2_rob_sargan_p | 0,5641 |
| prv_q2_cla_wh | 3,068 |
| prv_q2_cla_wh_p | 0,0868 |

A versão da Lista 1 é a verdadeira com matriz robusta (`vcov = sandwich`). Com a matriz clássica, o p-valor do Wu-Hausman é outro.

> [!CAUTION]
> **Decida pelo número impresso na questão, com o α da questão**
> Com p = 0,0569, a decisão do Wu-Hausman **muda com o α**: a 10% rejeita-se $H_0$ (há endogeneidade, use MQ2E); a 5% não se rejeita (MQO é consistente e eficiente). Com 0,0469 ou 0,0369, rejeita-se nos dois níveis. Nunca responda pelo p-valor de que você se lembra.

Mais dois avisos do mesmo tipo:

- Na P2 2024/2, o bloco de diagnósticos colado sob a regressão MQ2E de LWAGE ($n=4165$) tem **gl2 = 44**, que é o grau de liberdade do exemplo dos cigarros ($n=48$). Os diagnósticos verdadeiros daquela regressão são outros (ver [p2_2024_2/mapa.md](p2_2024_2/mapa.md)). Na prova, responda com o que está impresso. Se sobrar tempo, uma frase apontando a incoerência mostra domínio.
- A nota resolvida da P1 2025/2 registra, no item do Wald conjunto, o $\chi^2$ crítico 11,07. Esse é o crítico de 5% com **5** graus de liberdade. O Wald do output tem **2** graus de liberdade, com crítico 5,99. A decisão não muda (34,51 supera os dois), mas saiba de onde vem cada número.

| chave_R | nota |
|---|---|
| bnc_chi2_2gl_5 | 5,99 |
| bnc_chi2_5gl_5 | 11,07 |

A chave da Lista 1 também tem erros (ex. 50 e ex. 46f, ver a [errata](../formulario/errata_chave_lista1.md)). Trate a chave como algo "a conferir", nunca como gabarito.

## 7. Regenerar os outputs

```text
powershell -ExecutionPolicy Bypass -File scripts\r.ps1 provas\banco\gerar_outputs.R
powershell -ExecutionPolicy Bypass -File scripts\r.ps1 provas\p1_2025_2\reproducao.R
```

O primeiro escreve `provas/banco/outputs/*.txt` e `resultados/bnc.csv`. O segundo imprime os outputs da P1 2025/2 e grava `resultados/prv.csv`. Os layouts vêm de `R/saida_nlogit.R`: `saida_nlogit()` para MQO no formato NLOGIT, `saida_mq2e()` para MQ2E e `saida_ivreg_r()` para o `summary` do `ivreg`.
