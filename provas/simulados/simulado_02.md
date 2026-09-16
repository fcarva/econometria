---
title: "Simulado 02 — P1 no formato do professor"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
relevancia_p1: alta
status: rascunho
tags:
  - econometria
  - mestrado/ppgeco
  - p1
  - simulado
aliases:
  - Simulado 02
---

# Simulado 02

> [!IMPORTANT]
> **Regras**
> Sem consulta, cronometrado, 3 horas, 10,0 pontos. Em todo teste: hipóteses, estatística, decisão, conclusão. Gabarito com rubrica em [simulado_02_gabarito.md](simulado_02_gabarito.md).

---

## Questão 1 (2,5 pontos) — Função de produção estadual

Para 48 estados americanos em 1986, estimou-se por MQO a função de produção em logaritmos, em que LGSP é o log do produto estadual, LK o log do capital privado, LL o log do emprego e UNEMP a taxa de desemprego:

```text
+------------------------------------------------------------------+
| Regressão de mínimos quadrados ordinários (MQO)                  |
| LHS=LGSP            Média                     = 10,73271         |
|                     Número de observações     = 48               |
| Tamanho do modelo   Parâmetros                = 4                |
|                     Graus de liberdade        = 44               |
| Resíduos            Soma dos quadrados        = 0,2171663        |
|                     Erro padrão dos resíduos  = 0,07025381       |
| Ajuste              R-quadrado                = 0,9955452        |
|                     R-quadrado ajustado       = 0,9952415        |
| Teste de modelo F[3,44] (valor-p)             = 3277,67 (0,0000) |
+------------------------------------------------------------------+
+----------+---------------+----------------+---------+---------+-------------+
|Variáveis | Coeficientes  | Erro padrão    | b/E.p.  |P[|Z|>z] | Média de X  |
+----------+---------------+----------------+---------+---------+-------------+
Constant |     2,27257761      0,18397681    12,353   0,0000              
LK       |     0,28892731      0,04046803     7,140   0,0000    10,7844400
LL       |     0,75753681      0,03526684    21,480   0,0000    7,15126665
UNEMP    |    -0,01055463      0,00619321    -1,704   0,0883    6,92916667
+----------+---------------+----------------+---------+---------+-------------+

Modelo restrito, impondo elasticidades somando 1:
Soma dos quadrados dos resíduos = 0,2895589

Testes de diagnóstico:
Teste                             Estatística         gl      Valor-p
Jarque-Bera                            0,9437          2       0,6238
RESET (ŷ² e ŷ³)                        1,6174     2 e 42       0,2105
Breusch-Pagan (Koenker)                4,3716          3       0,2240
White                                 10,9117          9       0,2818
```

Considere $F_{1;44;0,05}=4{,}06$, $t_{44;0,025}=2{,}015$ e $\operatorname{Cov}(\hat\beta_{LK},\hat\beta_{LL})=-0{,}00136711$.

a) Interprete os coeficientes de LK e LL. Que hipótese sobre a tecnologia o modelo está impondo ao usar logaritmos? **(0,5)**

b) Teste, a 5%, a hipótese de **retornos constantes de escala** usando as duas somas de quadrados dos resíduos. Formule as hipóteses e demonstre as etapas. **(0,75)**

c) Refaça o teste do item (b) pela estatística $t$ da soma das elasticidades e mostre que $t^2=F$. **(0,5)**

d) O modelo passa nos testes de diagnóstico? Analise os quatro, formulando as hipóteses de cada um. **(0,5)**

e) Interprete o $R^2$ ajustado e comente a significância de UNEMP a 5% e a 10%. **(0,25)**

---

## Questão 2 (2,5 pontos) — Retornos da escolaridade com proximidade de faculdade

Com 3010 observações, estimou-se a equação de salários por MQ2E, instrumentando a escolaridade pela proximidade de uma faculdade na juventude (NEARC4).

```text
+-----------------------------------------------------------------+
| Mínimos quadrados em dois estágios (MQ2E)                       |
| LHS=LWAGE           Média                     = 6,261832        |
|                     Número de observações     = 3010            |
| Tamanho do modelo   Parâmetros                = 7               |
| Ajuste              R-quadrado                = 0,2252004       |
| Variáveis instrumentais:                                        |
| ONE      NEARC4   EXPER    EXPERSQ  BLACK    SMSA      SOUTH    |
+-----------------------------------------------------------------+
+----------+---------------+----------------+---------+---------+-------------+
|Variáveis | Coeficientes  | Erro padrão    | b/E.p.  |P[|Z|>z] | Média de X  |
+----------+---------------+----------------+---------+---------+-------------+
Constant |     3,75278134      0,82934088     4,525   0,0000              
EDUC     |     0,13228884      0,04923324     2,687   0,0072    13,2634551
EXPER    |     0,10749799      0,02130061     5,047   0,0000    8,85614618
EXPERSQ  |    -0,00228407      0,00033413    -6,836   0,0000    95,5790698
BLACK    |    -0,13080189      0,05287231    -2,474   0,0134    0,23355482
SMSA     |     0,13132366      0,03012984     4,359   0,0000    0,71295681
SOUTH    |    -0,10490053      0,02307310    -4,546   0,0000    0,40365449
+----------+---------------+----------------+---------+---------+-------------+

Testes de diagnóstico:
                     gl1    gl2   Estatística   Valor-p
Weak instruments       1   3003        16,718    0,0000
Wu-Hausman             1   3002         1,539    0,2149
```

Por MQO, nesta mesma amostra, o coeficiente de EDUC é 0,074571 (erro padrão 0,003494).

a) Identifique a variável endógena e os instrumentos. Por que a escolaridade seria endógena nesta equação? **(0,5)**

b) Teste a relevância dos instrumentos a 5%. Formule as hipóteses. **(0,5)**

c) A 5%, qual método é consistente e eficiente: MQO ou MQ2E? Formule as hipóteses e conclua. **(0,5)**

d) O teste de Sargan **não aparece** no quadro. Explique por quê e o que isso implica para a validade do instrumento. **(0,5)**

e) Interprete o coeficiente de EDUC e compare com o de MQO. O que a comparação sugere, e por que o erro-padrão do MQ2E é tão maior? **(0,5)**

---

## Questão 3 (1,5 ponto) — Gauss-Markov em notação matricial

No modelo $y=X\beta+\varepsilon$ com $E[\varepsilon\mid X]=0$ e $E[\varepsilon\varepsilon'\mid X]=\sigma^2I$, considere o estimador alternativo
$$b^*=\big[(X'X)^{-1}X'+C\big]y,$$
com $C\neq 0$ uma matriz de constantes.

a) Que condição $C$ precisa satisfazer para que $b^*$ seja não viesado? Demonstre. **(0,5)**

b) Obtenha $\operatorname{Var}(b^*\mid X)$ e compare com $\operatorname{Var}(b\mid X)$. **(0,75)**

c) Conclua enunciando o teorema de Gauss-Markov e diga qual hipótese é indispensável em cada parte. **(0,25)**

---

## Questão 4 (1,5 ponto) — Regressão particionada

Considere $y=X_1\beta_1+X_2\beta_2+\varepsilon$, com $M_1=I-X_1(X_1'X_1)^{-1}X_1'$.

a) Demonstre o teorema de Frisch-Waugh-Lovell: $b_2=(X_2'M_1X_2)^{-1}X_2'M_1y$. **(0,75)**

b) Suponha que o pesquisador estime apenas $\hat y=X_1b_1$. Obtenha $E[b_1\mid X]$ e a expressão do viés; diga quando ele é nulo. **(0,75)**

---

## Questão 5 (1,0 ponto) — Propriedades assintóticas

a) Demonstre que $\operatorname{plim}b=\beta$, indicando as condições utilizadas. **(0,5)**

b) Enuncie a normalidade assintótica de $b$ e explique por que, com amostra grande, o teste de normalidade dos resíduos deixa de ser necessário para a inferência. **(0,5)**

---

## Questão 6 (1,0 ponto) — Simultaneidade

No modelo keynesiano $C_t=\beta_0+\beta_1Y_t+\mu_t$ com $Y_t=C_t+I_t$, sendo $E[\mu_t]=0$, $E[\mu_t^2]=\sigma^2$ e $\operatorname{Cov}(I_t,\mu_t)=0$:

a) Obtenha a forma reduzida de $Y_t$ e calcule $\operatorname{Cov}(Y_t,\mu_t)$. **(0,5)**

b) Demonstre que $\hat\beta_1$ é inconsistente e determine o sinal da inconsistência. Qual seria um instrumento natural? **(0,5)**
