---
title: "Simulado 01 — P1 no formato do professor"
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
  - Simulado 01
---

# Simulado 01

> [!IMPORTANT]
> **Regras**
> Sem consulta, cronometrado, 3 horas. Total: 10,0 pontos. Em **todo** teste, escreva as hipóteses, a estatística, a decisão e a conclusão. Resolva primeiro as questões de output. O gabarito, com rubrica de pontos por passo, está em [simulado_01_gabarito.md](simulado_01_gabarito.md) — não abra antes de terminar.

---

## Questão 1 (2,5 pontos) — Retornos da escolaridade (CPS 1985)

Com uma amostra de 534 trabalhadores dos Estados Unidos (CPS, 1985), estimou-se por MQO

$$\text{LWAGE}_i=\beta_1+\beta_2\text{ED}_i+\beta_3\text{EXP}_i+\beta_4\text{EXP}_i^2+\beta_5\text{FEM}_i+\beta_6\text{UNION}_i+\beta_7\text{SOUTH}_i+\beta_8\text{HISP}_i+\beta_9\text{OUTRA}_i+\varepsilon_i,$$

em que LWAGE é o log do salário-hora; ED, anos de educação; EXP, anos de experiência; FEM = 1 se mulher; UNION = 1 se sindicalizado; SOUTH = 1 se reside no Sul; HISP e OUTRA são dummies de etnia (base: branco não hispânico).

```text
+--------------------------------------------------------------+
| Regressão de mínimos quadrados ordinários (MQO)              |
| LHS=LWAGE           Média                     = 2,059189     |
|                     Desvio padrão             = 0,5277422    |
|                     Número de observações     = 534          |
| Tamanho do modelo   Parâmetros                = 9            |
|                     Graus de liberdade        = 525          |
| Resíduos            Soma dos quadrados        = 99,40831     |
|                     Erro padrão dos resíduos  = 0,4351427    |
| Ajuste              R-quadrado                = 0,3303440    |
|                     R-quadrado ajustado       = 0,3201397    |
| Teste de modelo F[8,525] (valor-p)            = 32,37 (0,00) |
+--------------------------------------------------------------+
+----------+---------------+----------------+---------+---------+-------------+
|Variáveis | Coeficientes  | Erro padrão    | b/E.p.  |P[|Z|>z] | Média de X  |
+----------+---------------+----------------+---------+---------+-------------+
Constant |     0,68771783      0,12335371     5,575   0,0000              
ED       |     0,08664015      0,00799421    10,838   0,0000    13,0187266
EXP      |     0,03374252      0,00536945     6,284   0,0000    17,8220974
EXP²     |    -0,00051392      0,00011781    -4,362   0,0000    470,597378
FEM      |    -0,23428911      0,03849501    -6,086   0,0000    0,45880150
UNION    |     0,20106897      0,05054193     3,978   0,0001    0,17977528
SOUTH    |    -0,09268511      0,04240686    -2,186   0,0288    0,29213483
HISP     |    -0,06847054      0,08766211    -0,781   0,4348    0,05056180
OUTRA    |    -0,11242074      0,05774777    -1,947   0,0516    0,12546816
+----------+---------------+----------------+---------+---------+-------------+

Testes de diagnóstico:
Teste                                     Estatística            gl   Valor-p
Jarque-Bera (resíduos)                        72,4653             2   <0,0001
RESET (ŷ² e ŷ³)                                6,1037       2 e 523    0,0024
Breusch-Pagan (Koenker)                       10,6158             8    0,2244
```

Considere $z$ crítico igual a 1,96 e $\chi^2_{2;0,05}=5{,}99$.

a) O teste de Jarque-Bera rejeita a normalidade dos resíduos. Isso invalida a inferência feita na tabela? Explique. **(0,5)**

b) Teste se o coeficiente de ED é estatisticamente significativo ($\alpha=5\%$). Formule as hipóteses e interprete o coeficiente. **(0,5)**

c) Depois de quantos anos de experiência o log-salário atinge o máximo? Demonstre o cálculo e diga o que ocorre em seguida. **(0,5)**

d) Construa e interprete o intervalo de confiança de 95% para o coeficiente de ED. **(0,5)**

e) Interprete o coeficiente de FEM, de forma aproximada e exata. **(0,25)**

f) Interprete o $R^2$ ajustado e explique sua vantagem sobre o $R^2$. **(0,25)**

---

## Questão 2 (2,5 pontos) — Retornos da escolaridade com variáveis instrumentais (Mroz)

Para 428 mulheres casadas na força de trabalho, estimou-se a equação de salários por MQ2E, instrumentando a educação com a escolaridade do pai e da mãe.

```text
+----------------------------------------------------------------+
| Mínimos quadrados em dois estágios (MQ2E)                      |
| LHS=LWAGE           Média                     = 1,190173       |
|                     Número de observações     = 428            |
| Tamanho do modelo   Parâmetros                = 4              |
|                     Graus de liberdade        = 424            |
| Ajuste              R-quadrado                = 0,1357085      |
|                     R-quadrado ajustado       = 0,1295932      |
| Variáveis instrumentais:                                       |
| ONE      EXPER    EXPERSQ  MOTHEDUC FATHEDUC                   |
+----------------------------------------------------------------+
+----------+---------------+----------------+---------+---------+-------------+
|Variáveis | Coeficientes  | Erro padrão    | b/E.p.  |P[|Z|>z] | Média de X  |
+----------+---------------+----------------+---------+---------+-------------+
Constant |     0,04810031      0,40032808     0,120   0,9044              
EDUC     |     0,06139663      0,03143670     1,953   0,0508    12,6588785
EXPER    |     0,04417039      0,01343248     3,288   0,0010    13,0373832
EXPERSQ  |    -0,00089897      0,00040169    -2,238   0,0252    234,719626
+----------+---------------+----------------+---------+---------+-------------+

Testes de diagnóstico:
                     gl1    gl2   Estatística   Valor-p
Weak instruments       2    423        55,400    0,0000
Wu-Hausman             1    423         2,793    0,0954
Sargan                 1     NA         0,378    0,5386
```

Por MQO, o coeficiente de EDUC nesta mesma amostra é 0,107490 (erro padrão 0,014146).

a) Qual é a variável endógena e quais são os instrumentos? Quais as duas propriedades que um instrumento válido precisa ter? **(0,5)**

b) Os instrumentos são fracos? Use o teste apropriado a 5% e formule as hipóteses. **(0,5)**

c) A 5% de significância, qual método é consistente: MQO ou MQ2E? E a 10%? Formule as hipóteses e explique por que a conclusão muda. **(0,75)**

d) Os instrumentos são válidos? Use o teste apropriado a 5%, formule as hipóteses e explique por que ele só pôde ser realizado neste caso. **(0,5)**

e) Interprete o coeficiente de EDUC e compare com a estimativa de MQO. O que a diferença sugere? **(0,25)**

---

## Questão 3 (1,5 ponto) — Derivação escalar do MQO

Considere o modelo de regressão linear simples $Y_i=\beta_1+\beta_2X_i+u_i$, com todas as hipóteses do modelo clássico satisfeitas.

a) Obtenha as duas equações normais a partir da minimização da soma dos quadrados dos resíduos. **(0,5)**

b) Resolva o sistema e mostre que $\hat\beta_1=\bar Y-\hat\beta_2\bar X$ e $\hat\beta_2=\dfrac{\sum_i(X_i-\bar X)(Y_i-\bar Y)}{\sum_i(X_i-\bar X)^2}$. **(0,75)**

c) Mostre que a soma dos resíduos é zero e que os resíduos são ortogonais a $X$. **(0,25)**

---

## Questão 4 (1,5 ponto) — Viés de variável omitida

O modelo verdadeiro é $Y_i=\beta_1+\beta_2X_{i2}+\beta_3X_{i3}+u_i$, com $E[u_i\mid X]=0$, mas o pesquisador estima $Y_i=\beta_1+\beta_2X_{i2}+v_i$, deixando $X_3$ de fora.

a) O estimador $\tilde\beta_2$ da regressão curta é viesado? Demonstre e apresente a expressão do viés. **(1,0)**

b) Em que condições o viés desaparece? E qual é o sinal do viés se $\beta_3\gt 0$ e $X_2$ e $X_3$ forem positivamente correlacionados? **(0,5)**

---

## Questão 5 (1,5 ponto) — Propriedades do estimador matricial

Considere $y=X\beta+\varepsilon$, com $X$ não estocástica de posto completo, $E[\varepsilon\mid X]=0$ e $E[\varepsilon\varepsilon'\mid X]=\sigma^2I$. O estimador de MQO é $b=(X'X)^{-1}X'y$.

a) Demonstre que $b$ é não viesado. **(0,5)**

b) Demonstre que $\operatorname{var-cov}(b\mid X)=\sigma^2(X'X)^{-1}$. **(0,5)**

c) Demonstre que $b$ é consistente, isto é, $\operatorname{plim}b=\beta$. Indique as condições utilizadas. **(0,5)**

---

## Questão 6 (1,0 ponto) — Erro de medição no regressor

O modelo verdadeiro é $Y_i=\alpha+\beta X_i^*+\mu_i$, com $E[\mu_i]=0$, mas observa-se $X_i=X_i^*+w_i$, em que $w_i$ é o erro de medição, com média zero, variância $\sigma^2_w$, não correlacionado com $X_i^*$ nem com $\mu_i$. Estima-se então $Y_i=\alpha+\beta X_i+z_i$, com $z_i=\mu_i-\beta w_i$.

a) Calcule $\operatorname{Cov}(z_i,X_i)$ e diga qual hipótese do modelo clássico é violada. **(0,5)**

b) Obtenha $\operatorname{plim}\hat\beta$ e interprete o resultado. O problema desaparece com amostras maiores? **(0,5)**
