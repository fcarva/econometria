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
| 2026-10-09 | P1 2026/2, Q1 | C | não resolveu $\mathbf X'\mathbf X$, inversa e $\widehat\beta$ com $n=4$ | T | fazer a Parte I pelos itens de conta primeiro; reconhecer $\mathbf X'\mathbf X$ diagonal e inverter pela diagonal | 2026-10-10 | 2026-10-12 | 2026-10-16 |
| 2026-10-09 | P1 2026/2, Q2d | C | efeito marginal de EXP dado como 4,5%, sem o termo $2\beta_3EXP$ | A | escrever a derivada $\beta_2+2\beta_3EXP$ antes de pôr números | 2026-10-10 | 2026-10-12 | 2026-10-16 |
| 2026-10-09 | P1 2026/2, Q3c | C | rejeitou $H_0$ sem calcular $F_{cal}$ (item de 0,75) | E | escrever a fórmula do $F$ com $SQR_R$, $SQR_{UR}$, $q$ e $n-k$ antes da decisão | 2026-10-10 | 2026-10-12 | 2026-10-16 |
| 2026-10-09 | P1 2026/2, Q4a | D | plim do MQO sob $\operatorname{Cov}(X,u)\neq 0$ em branco | E | refazer D10.1 do zero: decompor, LGN, Slutsky na razão | 2026-10-10 | 2026-10-12 | 2026-10-16 |
| 2026-10-09 | P1 2026/2, Q4b | C | $\widehat\beta_1^{IV}=340/85$ e $\widehat\beta_0^{IV}=\bar Y-\widehat\beta_1^{IV}\bar X$ em branco | T | item de duas linhas: fazer antes das demonstrações | 2026-10-10 | 2026-10-12 | 2026-10-16 |
| 2026-10-09 | P1 2026/2, Q5 | D | parou em $\sigma^2\mathbf C\mathbf C'$ sem mostrar que é semidefinida positiva | E | fechar com $\mathbf a'\mathbf C\mathbf C'\mathbf a=\lVert\mathbf C'\mathbf a\rVert^2\ge 0$ e a conclusão MELNV | 2026-10-10 | 2026-10-12 | 2026-10-16 |
| 2026-10-09 | P1 2026/2, Q6 | D | não isolou $\mathbf b_2$ com $\mathbf I-\mathbf P_1$ (FWL incompleto) | E | refazer D04.1 e D04.2: blocos, isolar $\mathbf b_1$, substituir, $\mathbf M_1$ idempotente | 2026-10-10 | 2026-10-12 | 2026-10-16 |
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
> 3. Em derivação, pular a hipótese que zera um termo. Cada $E(\cdot\mid X)=0$, cada covariância nula e cada $\operatorname{plim}$ precisa vir com a sua justificativa.
