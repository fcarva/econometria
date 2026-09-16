---
title: "Log de erros — treino para a P1"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
relevancia_p1: alta
status: rascunho
tags:
  - econometria
  - mestrado/ppgeco
  - p1
  - prova
aliases:
  - Log de erros
---

# Log de erros

Toda questão errada, incompleta ou resolvida acima do tempo-alvo entra aqui no mesmo dia, venha ela do [banco de derivações](banco/derivacoes.md), do [banco de interpretação](banco/interpretacao.md), de um simulado ou da Lista 1. A revisão segue o espaçamento +1, +3 e +7 dias: refaça a questão do zero, sem olhar a resolução, e marque a data em que acertou.

> [!TIP]
> **Como preencher**
> Uma linha por erro, não por questão: se uma derivação teve dois erros (esqueceu a hipótese e errou o sinal), são duas linhas. A coluna "ação" diz o que você muda no próximo treino. Não vale "estudar mais".

## Códigos

| Coluna | Valores |
|---|---|
| tipo | **D** derivação · **I** interpretação de output · **C** cálculo · **T** conceitual |
| causa | **H** hipótese não citada · **A** álgebra/sinal · **N** notação ou dimensão · **L** leitura do enunciado (α, z crítico, unidade) · **R** regra de decisão invertida · **V** vocabulário (conclusão sem economia) · **E** esquecimento do resultado · **T** tempo |
| revisão | data da revisão; `ok` quando acertou sem consulta, `x` quando errou de novo (volta para +1) |

## Registro

| data | questão | tipo | erro | causa | ação | +1 | +3 | +7 |
|---|---|---|---|---|---|---|---|---|
| 2026-09-16 | exemplo: banco B12 | D | escreveu $\operatorname{Cov}(z_i,X_i)=0$ | H | antes de tirar a esperança, listar quais covariâncias o enunciado zera | 2026-09-17 | 2026-09-19 | 2026-09-23 |
|  |  |  |  |  |  |  |  |  |
|  |  |  |  |  |  |  |  |  |
|  |  |  |  |  |  |  |  |  |
|  |  |  |  |  |  |  |  |  |
|  |  |  |  |  |  |  |  |  |

## Placar por causa

Atualize no fim de cada semana. A causa com mais linhas vira o foco da semana seguinte.

| causa | semana 15–20/09 | semana 21–27/09 | reta final 28/09–01/10 |
|---|---|---|---|
| H hipótese |  |  |  |
| A álgebra/sinal |  |  |  |
| N notação/dimensão |  |  |  |
| L leitura do enunciado |  |  |  |
| R regra de decisão |  |  |  |
| V vocabulário |  |  |  |
| E esquecimento |  |  |  |
| T tempo |  |  |  |

> [!WARNING]
> **Os três erros que mais custam ponto neste professor**
> 1. Decidir pelo p-valor de memória em vez do p-valor impresso na questão. O professor recicla outputs e troca os p-valores entre versões (ver [provas/README.md](README.md), seção 6).
> 2. Escrever só "rejeita-se $H_0$" sem a conclusão econômica. A resposta de teste tem sempre quatro linhas: hipóteses, estatística, decisão e conclusão.
> 3. Em derivação, pular a hipótese que zera um termo. Cada $E[\cdot\mid X]=0$, cada covariância nula e cada $\operatorname{plim}$ precisa vir com a sua justificativa.
