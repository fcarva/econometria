---
title: "Simulado 03 — reserva (DiD, VI clássico e álgebra)"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
relevancia_p1: media
status: rascunho
tags:
  - econometria
  - mestrado/ppgeco
  - p1
  - simulado
aliases:
  - Simulado 03
---

# Simulado 03 (reserva)

> [!IMPORTANT]
> **Quando usar**
> Este é o simulado de reserva, para 30/09 ou para substituir questões que você já acertou nos dois primeiros. Mesmo formato: sem consulta, 3 horas, 10,0 pontos, quatro linhas em cada teste. Gabarito em [simulado_03_gabarito.md](simulado_03_gabarito.md).

---

## Questão 1 (2,5 pontos) — Incinerador e preço de imóveis (diferenças em diferenças)

Estimou-se o efeito do anúncio da construção de um incinerador sobre o preço dos imóveis próximos, com 321 transações em dois anos (1978 e 1981). LRPRICE é o log do preço real; Y81 é dummy de 1981; NEARINC indica imóvel próximo ao incinerador; Y81NRINC é a interação.

```text
+----------------------------------------------------------------+
| Regressão de mínimos quadrados ordinários (MQO)                |
| LHS=LRPRICE         Média                     = 11,26138       |
|                     Número de observações     = 321            |
| Tamanho do modelo   Parâmetros                = 11             |
|                     Graus de liberdade        = 310            |
| Resíduos            Soma dos quadrados        = 12,87686       |
|                     Erro padrão dos resíduos  = 0,2038094      |
| Ajuste              R-quadrado                = 0,7325630      |
|                     R-quadrado ajustado       = 0,7239360      |
| Teste de modelo F[10,310] (valor-p)           = 84,92 (0,0000) |
+----------------------------------------------------------------+
+----------+---------------+----------------+---------+---------+-------------+
|Variáveis | Coeficientes  | Erro padrão    | b/E.p.  |P[|Z|>z] | Média de X  |
+----------+---------------+----------------+---------+---------+-------------+
Constant |     7,65175565      0,41588322    18,399   0,0000              
Y81      |     0,16207247      0,02849993     5,687   0,0000    0,44236760
NEARINC  |     0,03223202      0,04748757     0,679   0,4973    0,29906542
Y81NRINC |    -0,13151324      0,05197120    -2,531   0,0114    0,12461059
AGE      |    -0,00835914      0,00141115    -5,924   0,0000    18,0093458
AGESQ    |   0,376348e-04    0,866846e-05     4,342   0,0000    1381,56698
LINTST   |    -0,06144824      0,03150751    -1,950   0,0511    9,48051348
LLAND    |     0,09984503      0,02449101     4,077   0,0000    10,3018592
LAREA    |     0,35077222      0,05148654     6,813   0,0000    7,59723241
ROOMS    |     0,04733435      0,01732739     2,732   0,0063    6,58566978
BATHS    |     0,09427668      0,02772561     3,400   0,0007    2,33956386
+----------+---------------+----------------+---------+---------+-------------+
```

Considere $z$ crítico igual a 1,96.

a) Qual coeficiente mede o efeito causal do incinerador? Justifique com a estrutura do estimador de diferenças em diferenças. **(0,5)**

b) Teste esse coeficiente a 5% e interprete seu valor, de forma aproximada e exata. **(0,75)**

c) Interprete Y81 e NEARINC. Por que NEARINC sozinho **não** mede o efeito do incinerador? **(0,5)**

d) Qual a hipótese de identificação do modelo? Como você a verificaria, dispondo de mais anos de dados? **(0,5)**

e) Interprete o coeficiente de AGE junto com o de AGESQ: qual a idade em que o preço é mínimo? **(0,25)**

---

## Questão 2 (2,0 pontos) — Demanda por cigarros sem erros robustos

O mesmo modelo de demanda por cigarros (48 estados, 1995), agora com erros-padrão **clássicos** (homocedásticos):

```text
+----------------------------------------------------------------+
| Mínimos quadrados em dois estágios (MQ2E)                      |
| LHS=LOG(PACKS)      Número de observações     = 48             |
| Tamanho do modelo   Parâmetros                = 3              |
| Ajuste              R-quadrado                = 0,4294224      |
| Variáveis instrumentais:                                       |
| ONE      LOG(RINCOME)   TDIFF   TAX/CPI                        |
+----------------------------------------------------------------+
+--------------+---------------+----------------+---------+---------+
|Variáveis     | Coeficientes  | Erro padrão    | b/E.p.  |P[|Z|>z] |
+--------------+---------------+----------------+---------+---------+
Constant     |     9,89495554      1,05855995     9,348   0,0000
LOG(RPRICE)  |    -1,27742413      0,26319859    -4,853   0,0000
LOG(RINCOME) |     0,28040483      0,23856544     1,175   0,2462
+--------------+---------------+----------------+---------+---------+

Testes de diagnóstico:
                     gl1    gl2   Estatística   Valor-p
Weak instruments       2     44       244,734    0,0000
Wu-Hausman             1     44         3,068    0,0868
Sargan                 1     NA         0,333    0,5641
```

a) Aplique os três testes a 5% e depois a 10%, formulando as hipóteses. Em qual deles a conclusão muda? **(1,0)**

b) Interprete a elasticidade-preço estimada e diga se a demanda é elástica. **(0,5)**

c) Com erros-padrão robustos, o teste de instrumentos fracos cai para 228,7 e o Wu-Hausman sobe para $p=0{,}0569$. O que isso indica sobre a suposição de homocedasticidade e sobre a robustez da sua conclusão? **(0,5)**

---

## Questão 3 (1,5 ponto) — Álgebra das matrizes de projeção

No modelo $y=X\beta+\varepsilon$, sejam $P=X(X'X)^{-1}X'$ e $M=I-P$.

a) Prove que $P$ e $M$ são simétricas e idempotentes e que $MX=0$. **(0,5)**

b) Prove que $e=My$ e que $X'e=0$; diga o que isso implica quando o modelo tem intercepto. **(0,5)**

c) Prove que $e'e=y'y-b'X'y$. **(0,5)**

---

## Questão 4 (1,5 ponto) — Testes equivalentes na regressão simples

No modelo $Y_i=\beta_1+\beta_2X_i+u_i$:

a) Prove que $t_0^2=F_0$ para o teste de $H_0:\beta_2=0$. **(0,75)**

b) Prove que $F_{cal}=\dfrac{R^2}{(1-R^2)/(n-2)}$. **(0,5)**

c) Explique por que as duas estatísticas sempre levam à mesma decisão. **(0,25)**

---

## Questão 5 (1,5 ponto) — O estimador de diferenças em diferenças

Considere $y_{it}=\beta_0+\beta_1D_{it}+\beta_2T_t+\beta_3D_{it}T_t+\beta'x_{it}+\varepsilon_{it}$, com $t=1,2$, $T_t$ dummy de período e $D_{it}$ dummy de tratamento.

a) Demonstre que
$$E[\Delta y_{it}\mid x,D=1]-E[\Delta y_{it}\mid x,D=0]=\beta_3+\beta'\big[(\Delta x\mid D=1)-(\Delta x\mid D=0)\big].$$ **(1,0)**

b) Suponha agora que $x_{it}=x_i$ não varie no tempo. O que acontece com a expressão e qual a conclusão para modelos de diferenças em diferenças? **(0,5)**

---

## Questão 6 (1,0 ponto) — Multicolinearidade

Um pesquisador estimou $Y_i=\beta_1+\beta_2X_{1i}+\beta_3X_{2i}+\beta_4X_{3i}+\mu_i$ e obteve, na regressão auxiliar de $X_1$ contra $X_2$ e $X_3$, um $R^2$ de 0,95.

a) Calcule o fator de inflação da variância de $\hat\beta_2$ e interprete. **(0,5)**

b) A multicolinearidade viola alguma hipótese do modelo clássico? O MQO continua MELNV? Explique as consequências e por que excluir $X_2$ pode piorar o problema. **(0,5)**
