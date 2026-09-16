---
title: "Módulo 03 — Lista 1 resolvida (ex. 23, 24, 28–31, 34 e 35)"
modulo: "03"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
greene: "cap. 3"
slides: "SL03"
lista1: [23, 24, 28, 29, 30, 31, 34, 35]
relevancia_p1: alta
status: rascunho
verificacao:
  derivacao: pendente
  numerica: ok
  chave: parcial
tags:
  - econometria
  - mestrado/ppgeco
  - p1
aliases:
  - MQO matricial — Lista 1
---

# Módulo 03 — Lista 1 resolvida

Teoria e demonstrações em [03_teoria.md](03_teoria.md); números em [03_mqo_matricial.R](03_mqo_matricial.R).

---

## Ex. 23 — Regressão múltipla matricial: o roteiro completo

**Tipo:** dissertativa · **Chave:** ➖ · **Cai como:** questão aberta longa

Esta é a questão-mapa da prova: ela pede, em quatro itens, quase tudo o que o curso cobriu até aqui.

**(a) Hipóteses em notação matricial.** As seis do Greene, em [CONVENCOES.md](../CONVENCOES.md) §2: A1 linearidade $y=X\beta+\varepsilon$; A2 posto completo; A3 exogeneidade $E[\varepsilon\mid X]=0$; A4 erros esféricos $E[\varepsilon\varepsilon'\mid X]=\sigma^2I$; A5 geração exógena de $X$; A6 normalidade. Explique o que cada uma garante e o que quebra sem ela (A2 → não identificação; A3 → viés e inconsistência; A4 → erros-padrão errados; A6 → só a inferência exata).

**(b) Derivar $b$ e sua matriz de variância.** Minimize $e'e=(y-Xb)'(y-Xb)$; a condição de primeira ordem $-2X'y+2X'Xb=0$ dá as equações normais $X'Xb=X'y$ e, com A2, $b=(X'X)^{-1}X'y$. A variância sai de $b-\beta=(X'X)^{-1}X'\varepsilon$:
$$\operatorname{Var}(b\mid X)=\sigma^2(X'X)^{-1}.$$
Passo a passo em D03.2 e no [módulo 06](../06_amostra_finita_multicol/06_teoria.md).

**(c) Propriedades em pequenas e grandes amostras.** Pequenas: linear, não viesado, variância $\sigma^2(X'X)^{-1}$, eficiente entre os lineares não viesados (Gauss-Markov) e, sob A6, normal. Grandes: consistente ($\operatorname{plim}b=\beta$) e assintoticamente normal, $\sqrt n(b-\beta)\to N(0,\sigma^2Q^{-1})$ — ver [módulo 08](../08_assintotica/08_teoria.md).

**(d) Endogeneidade.** Ocorre quando $E[\varepsilon\mid X]\neq 0$, ou $\operatorname{plim}(X'\varepsilon/n)\neq 0$. Causas: variável omitida correlacionada, erro de medição no regressor, simultaneidade. Consequência: viés e inconsistência. Soluções: variáveis instrumentais, MQ2E, GMM — [módulo 10](../10_endogeneidade_iv/10_teoria.md).

> [!TIP]
> **Como distribuir o tempo**
> Numa questão assim, escreva um parágrafo curto por item e **derive** apenas o que o item (b) pede. Listar as hipóteses com uma frase cada rende mais ponto do que desenvolver uma delas em detalhe e deixar as outras em branco.

## Ex. 24 — Não-viés do estimador matricial

**Tipo:** derivação · **Chave:** ➖ · **Cai como:** Q5

$$b=(X'X)^{-1}X'y=(X'X)^{-1}X'(X\beta+\varepsilon)=\beta+(X'X)^{-1}X'\varepsilon$$
$$E[b\mid X]=\beta+(X'X)^{-1}X'E[\varepsilon\mid X]=\beta \qquad [A3]$$
e, pela lei das esperanças iteradas, $E[b]=E\big[E[b\mid X]\big]=\beta$ também incondicionalmente. Ver D03.4 e D13.

Simulação com 20 mil amostras: média de $\hat\beta_2$ igual a 2,0000 para $\beta_2=2$, e variância simulada colada na teórica.

## Ex. 28 — A matriz geradora de resíduos: $e=My$

**Tipo:** derivação · **Chave:** ➖

$$e=y-Xb=y-X(X'X)^{-1}X'y=\big[I-X(X'X)^{-1}X'\big]y=My.$$
$M$ é simétrica e idempotente, com $MX=0$; logo $e=M(X\beta+\varepsilon)=M\varepsilon$: os resíduos dependem só do erro. Ver D03.5.

## Ex. 29 — A matriz de projeção: $\hat y=Py$

**Tipo:** derivação · **Chave:** ➖

$$\hat y=Xb=X(X'X)^{-1}X'y=Py.$$
$P$ projeta $y$ no espaço gerado pelas colunas de $X$; $M=I-P$ projeta no complemento ortogonal. Daí $P+M=I$, $PM=0$, $\operatorname{tr}(P)=K$ e $\operatorname{tr}(M)=n-K$. Ver D03.6.

## Ex. 30 — Soma de quadrados dos resíduos: $e'e=y'y-b'X'y$

**Tipo:** derivação · **Chave:** ➖

$$e'e=(y-Xb)'(y-Xb)=y'y-2b'X'y+b'X'Xb.$$
Pelas equações normais, $X'Xb=X'y$, então $b'X'Xb=b'X'y$ e
$$e'e=y'y-2b'X'y+b'X'y=y'y-b'X'y.$$
Verificado no ex. 34: $y'y-b'X'y = 1{,}9 = e'e$.

## Ex. 31 — Ortogonalidade: $X'e=0$

**Tipo:** derivação · **Chave:** ➖

$$X'e=X'(y-Xb)=X'y-X'X(X'X)^{-1}X'y=X'y-X'y=0.$$
São as equações normais escritas de outro jeito. Com intercepto, a primeira linha dá $\sum e_i=0$ e, portanto, $\overline{\hat y}=\bar y$.

## Ex. 34 — MQO matricial à mão

**Tipo:** cálculo · **Chave:** ⏳ · **Cai como:** questão numérica

Dados: $y=(2,3,5,4,6)'$ e $X=[\iota\ \ (2,4,6,8,10)']$, com $n=5$ e $K=2$.

**Passo 1 — os produtos cruzados.**
$$X'X=\begin{pmatrix}5&30\\30&220\end{pmatrix},\qquad X'y=\begin{pmatrix}20\\138\end{pmatrix}.$$

**Passo 2 — a inversa por adjunta.** $\det(X'X)=5\times 220-30^2=1100-900=200$ e
$$(X'X)^{-1}=\frac{1}{200}\begin{pmatrix}220&-30\\-30&5\end{pmatrix}=\begin{pmatrix}1{,}1&-0{,}15\\-0{,}15&0{,}025\end{pmatrix}.$$

**Passo 3 — o estimador.**
$$b=(X'X)^{-1}X'y=\begin{pmatrix}1{,}1\times 20-0{,}15\times 138\\-0{,}15\times 20+0{,}025\times 138\end{pmatrix}=\begin{pmatrix}1{,}3\\0{,}45\end{pmatrix}.$$

Confira pela via escalar: $S_{XX}=40$, $S_{XY}=18$, $\hat\beta_2=18/40=0{,}45$ e $\hat\beta_1=4-0{,}45\times 6=1{,}3$.

**Passo 4 — ajuste e resíduos.** $\hat y=(2{,}2;\ 3{,}1;\ 4{,}0;\ 4{,}9;\ 5{,}8)'$ e $e=(-0{,}2;\ -0{,}1;\ 1{,}0;\ -0{,}9;\ 0{,}2)'$, com $\sum e_i=0$ e $\sum X_ie_i=0$ (confira sempre: é o teste de consistência da conta).

**Passo 5 — variância.**
$$e'e=1{,}9,\qquad s^2=\frac{e'e}{n-K}=\frac{1{,}9}{3}=0{,}6333,\qquad s=0{,}7958,$$
$$\widehat{\operatorname{Var}}(b)=s^2(X'X)^{-1}=\begin{pmatrix}0{,}6967&-0{,}0950\\-0{,}0950&0{,}015833\end{pmatrix},$$
logo $\text{E.p.}(\hat\beta_1)=0{,}8347$ e $\text{E.p.}(\hat\beta_2)=0{,}12583$.

**Passo 6 — inferência e ajuste.** $t=0{,}45/0{,}12583=3{,}576$ contra $t_{3;0,025}=3{,}182$: rejeita-se $H_0:\beta_2=0$ a 5%. E $R^2=1-1{,}9/10=0{,}81$.

**Conferência numérica**

| chave_R | nota |
|---|---|
| m03_ex34_det | 200 |
| m03_ex34_inv11 | 1,1 |
| m03_ex34_inv22 | 0,025 |
| m03_ex34_b1 | 1,3 |
| m03_ex34_b2 | 0,45 |
| m03_ex34_ee | 1,9 |
| m03_ex34_s2 | 0,63333 |
| m03_ex34_s | 0,79582 |
| m03_ex34_se_b1 | 0,83467 |
| m03_ex34_se_b2 | 0,12583 |
| m03_ex34_t_b2 | 3,5762 |
| m03_ex34_tcrit | 3,1824 |
| m03_ex34_r2 | 0,81 |
| m03_ex34_sxx | 40 |
| m03_ex34_sxy | 18 |

> [!TIP]
> **Rotina de prova para conta matricial**
> Monte $X'X$ e $X'y$ → determinante → inversa pela adjunta → $b$ → resíduos → **cheque $\sum e_i=0$ e $X'e=0$** → $s^2$ → erros-padrão. O cheque intermediário custa 20 segundos e salva a questão.

## Ex. 35 — Colinearidade perfeita

**Tipo:** cálculo e conceito · **Chave:** ⏳

Agora $X=[\iota\ \ x_2\ \ x_3]$ com $x_3=2x_2$ (segunda coluna dobrada). Então:

- as colunas são linearmente dependentes: existe $a=(0,2,-1)'\neq 0$ com $Xa=0$;
- $\operatorname{posto}(X)=2 \lt K=3$, violando **A2**;
- $\det(X'X)=0$ e o menor autovalor é numericamente zero ($-1{,}1\times 10^{-13}$);
- $(X'X)^{-1}$ **não existe**, então $b=(X'X)^{-1}X'y$ não pode ser calculado.

**O que o software faz.** O R não quebra: descarta uma coluna e reporta `NA` para o coeficiente dela. Isso não é "resolver" — é reconhecer que só a **combinação** $\beta_2+2\beta_3$ é identificada, não $\beta_2$ e $\beta_3$ separadamente. Qualquer par $(\beta_2,\beta_3)$ com a mesma soma ponderada dá exatamente o mesmo ajuste.

**Conferência numérica**

| chave_R | nota |
|---|---|
| m03_ex35_det | 0 |
| m03_ex35_posto | 2 |

> [!WARNING]
> **Multicolinearidade perfeita × alta**
> Perfeita viola A2 e impede a estimação. Alta (mas não perfeita) **não viola nada**: o MQO segue MELNV, só com variâncias grandes — [módulo 06](../06_amostra_finita_multicol/06_lista1.md), ex. 53, 54, 63 e 64.
