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

**(a) Hipóteses em notação matricial.** As seis do Greene, em [CONVENCOES.md](../CONVENCOES.md) §2: H1 linearidade $\mathbf y=\mathbf X\beta+\varepsilon$; H3 posto completo; H2 exogeneidade $E(\varepsilon\mid \mathbf X)=0$; H4 erros esféricos $E(\varepsilon\varepsilon'\mid \mathbf X)=\sigma^2\mathbf I$; H2 geração exógena de $\mathbf X$; H5 normalidade. Explique o que cada uma garante e o que quebra sem ela (H3 → não identificação; H2 → viés e inconsistência; H4 → erros-padrão errados; H5 → só a inferência exata).

**(b) Derivar $\mathbf b$ e sua matriz de variância.** Minimize $\mathbf e'\mathbf e=(\mathbf y-\mathbf X\mathbf b)'(\mathbf y-\mathbf X\mathbf b)$; a condição de primeira ordem $-2\mathbf X'\mathbf y+2\mathbf X'\mathbf X\mathbf b=0$ dá as equações normais $\mathbf X'\mathbf X\mathbf b=\mathbf X'\mathbf y$ e, com H3, $\mathbf b=(\mathbf X'\mathbf X)^{-1}\mathbf X'\mathbf y$. A variância sai de $\mathbf b-\beta=(\mathbf X'\mathbf X)^{-1}\mathbf X'\varepsilon$:
$$\operatorname{Var}(\mathbf b\mid \mathbf X)=\sigma^2(\mathbf X'\mathbf X)^{-1}.$$
Passo a passo em D03.2 e no [módulo 06](../06_amostra_finita_multicol/06_teoria.md).

**(c) Propriedades em pequenas e grandes amostras.** Pequenas: linear, não viesado, variância $\sigma^2(\mathbf X'\mathbf X)^{-1}$, eficiente entre os lineares não viesados (Gauss-Markov) e, sob H5, normal. Grandes: consistente ($\operatorname{plim}\mathbf b=\beta$) e assintoticamente normal, $\sqrt n(\mathbf b-\beta)\to N(0,\sigma^2\mathbf Q^{-1})$ — ver [módulo 08](../08_assintotica/08_teoria.md).

**(d) Endogeneidade.** Ocorre quando $E(\varepsilon\mid \mathbf X)\neq 0$, ou $\operatorname{plim}(\mathbf X'\varepsilon/n)\neq 0$. Causas: variável omitida correlacionada, erro de medição no regressor, simultaneidade. Consequência: viés e inconsistência. Soluções: variáveis instrumentais, MQ2E, GMM — [módulo 10](../10_endogeneidade_iv/10_teoria.md).

> [!TIP]
> **Como distribuir o tempo**
> Numa questão assim, escreva um parágrafo curto por item e **derive** apenas o que o item (b) pede. Listar as hipóteses com uma frase cada rende mais ponto do que desenvolver uma delas em detalhe e deixar as outras em branco.

## Ex. 24 — Não-viés do estimador matricial

**Tipo:** derivação · **Chave:** ➖ · **Cai como:** Q5

$$\mathbf b=(\mathbf X'\mathbf X)^{-1}\mathbf X'\mathbf y=(\mathbf X'\mathbf X)^{-1}\mathbf X'(\mathbf X\beta+\varepsilon)=\beta+(\mathbf X'\mathbf X)^{-1}\mathbf X'\varepsilon$$
$$E(\mathbf b\mid \mathbf X)=\beta+(\mathbf X'\mathbf X)^{-1}\mathbf X'E(\varepsilon\mid \mathbf X)=\beta \qquad [H2]$$
e, pela lei das esperanças iteradas, $E(b)=E\big(E(b\mid X)\big)=\beta$ também incondicionalmente. Ver D03.4 e D13.

Simulação com 20 mil amostras: média de $\widehat\beta_2$ igual a 2,0000 para $\beta_2=2$, e variância simulada colada na teórica.

## Ex. 28 — A matriz geradora de resíduos: $e=My$

**Tipo:** derivação · **Chave:** ➖

$$\mathbf e=\mathbf y-\mathbf X\mathbf b=\mathbf y-\mathbf X(\mathbf X'\mathbf X)^{-1}\mathbf X'\mathbf y=\big[\mathbf I-\mathbf X(\mathbf X'\mathbf X)^{-1}\mathbf X'\big]\mathbf y=\mathbf M\mathbf y.$$
$\mathbf M$ é simétrica e idempotente, com $\mathbf M\mathbf X=0$; logo $\mathbf e=\mathbf M(\mathbf X\beta+\varepsilon)=\mathbf M\varepsilon$: os resíduos dependem só do erro. Ver D03.5.

## Ex. 29 — A matriz de projeção: $\widehat y=Py$

**Tipo:** derivação · **Chave:** ➖

$$\widehat{\mathbf y}=\mathbf X\mathbf b=\mathbf X(\mathbf X'\mathbf X)^{-1}\mathbf X'\mathbf y=\mathbf P\mathbf y.$$
$\mathbf P$ projeta $\mathbf y$ no espaço gerado pelas colunas de $\mathbf X$; $\mathbf M=\mathbf I-\mathbf P$ projeta no complemento ortogonal. Daí $\mathbf P+\mathbf M=\mathbf I$, $\mathbf P\mathbf M=0$, $\operatorname{tr}(\mathbf P)=K$ e $\operatorname{tr}(\mathbf M)=n-K$. Ver D03.6.

## Ex. 30 — Soma de quadrados dos resíduos: $\mathbf e'\mathbf e=\mathbf y'\mathbf y-\mathbf b'\mathbf X'\mathbf y$

**Tipo:** derivação · **Chave:** ➖

$$\mathbf e'\mathbf e=(\mathbf y-\mathbf X\mathbf b)'(\mathbf y-\mathbf X\mathbf b)=\mathbf y'\mathbf y-2\mathbf b'\mathbf X'\mathbf y+\mathbf b'\mathbf X'\mathbf X\mathbf b.$$
Pelas equações normais, $\mathbf X'\mathbf X\mathbf b=\mathbf X'\mathbf y$, então $\mathbf b'\mathbf X'\mathbf X\mathbf b=\mathbf b'\mathbf X'\mathbf y$ e
$$\mathbf e'\mathbf e=\mathbf y'\mathbf y-2\mathbf b'\mathbf X'\mathbf y+\mathbf b'\mathbf X'\mathbf y=\mathbf y'\mathbf y-\mathbf b'\mathbf X'\mathbf y.$$
Verificado no ex. 34: $\mathbf y'\mathbf y-\mathbf b'\mathbf X'\mathbf y = 1{,}9 = \mathbf e'\mathbf e$.

## Ex. 31 — Ortogonalidade: $\mathbf X'\mathbf e=0$

**Tipo:** derivação · **Chave:** ➖

$$\mathbf X'\mathbf e=\mathbf X'(\mathbf y-\mathbf X\mathbf b)=\mathbf X'\mathbf y-\mathbf X'\mathbf X(\mathbf X'\mathbf X)^{-1}\mathbf X'\mathbf y=\mathbf X'\mathbf y-\mathbf X'\mathbf y=0.$$
São as equações normais escritas de outro jeito. Com intercepto, a primeira linha dá $\sum e_i=0$ e, portanto, $\overline{\widehat y}=\bar y$.

## Ex. 34 — MQO matricial à mão

**Tipo:** cálculo · **Chave:** ⏳ · **Cai como:** questão numérica

Dados: $\mathbf y=(2,3,5,4,6)'$ e $\mathbf X=[\iota\ \ (2,4,6,8,10)']$, com $n=5$ e $K=2$.

**Passo 1 — os produtos cruzados.**
$$\mathbf X'\mathbf X=\begin{pmatrix}5&30\\30&220\end{pmatrix},\qquad \mathbf X'\mathbf y=\begin{pmatrix}20\\138\end{pmatrix}.$$

**Passo 2 — a inversa por adjunta.** $\det(\mathbf X'\mathbf X)=5\times 220-30^2=1100-900=200$ e
$$(\mathbf X'\mathbf X)^{-1}=\frac{1}{200}\begin{pmatrix}220&-30\\-30&5\end{pmatrix}=\begin{pmatrix}1{,}1&-0{,}15\\-0{,}15&0{,}025\end{pmatrix}.$$

**Passo 3 — o estimador.**
$$\mathbf b=(\mathbf X'\mathbf X)^{-1}\mathbf X'\mathbf y=\begin{pmatrix}1{,}1\times 20-0{,}15\times 138\\-0{,}15\times 20+0{,}025\times 138\end{pmatrix}=\begin{pmatrix}1{,}3\\0{,}45\end{pmatrix}.$$

Confira pela via escalar: $S_{XX}=40$, $S_{XY}=18$, $\widehat\beta_2=18/40=0{,}45$ e $\widehat\beta_1=4-0{,}45\times 6=1{,}3$.

**Passo 4 — ajuste e resíduos.** $\widehat{\mathbf y}=(2{,}2;\ 3{,}1;\ 4{,}0;\ 4{,}9;\ 5{,}8)'$ e $\mathbf e=(-0{,}2;\ -0{,}1;\ 1{,}0;\ -0{,}9;\ 0{,}2)'$, com $\sum e_i=0$ e $\sum X_ie_i=0$ (confira sempre: é o teste de consistência da conta).

**Passo 5 — variância.**
$$\mathbf e'\mathbf e=1{,}9,\qquad s^2=\frac{\mathbf e'\mathbf e}{n-K}=\frac{1{,}9}{3}=0{,}6333,\qquad s=0{,}7958,$$
$$\widehat{\operatorname{Var}}(\mathbf b)=s^2(\mathbf X'\mathbf X)^{-1}=\begin{pmatrix}0{,}6967&-0{,}0950\\-0{,}0950&0{,}015833\end{pmatrix},$$
logo $ep(\widehat\beta_1)=0{,}8347$ e $ep(\widehat\beta_2)=0{,}12583$.

**Passo 6 — inferência e ajuste.** $t=0{,}45/0{,}12583=3{,}576$ contra $t_{3;0,025}=3{,}182$: rejeita-se $H_0:\beta_2=0$ a 5%. E $R^2=1-1{,}9/10=0{,}81$.

<!-- conferência numérica: valores conferidos contra resultados/*.csv pelo scripts/check_numbers.R — 
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
-->

> [!TIP]
> **Rotina de prova para conta matricial**
> Monte $\mathbf X'\mathbf X$ e $\mathbf X'\mathbf y$ → determinante → inversa pela adjunta → $\mathbf b$ → resíduos → **cheque $\sum e_i=0$ e $\mathbf X'\mathbf e=0$** → $s^2$ → erros-padrão. O cheque intermediário custa 20 segundos e salva a questão.

## Ex. 35 — Colinearidade perfeita

**Tipo:** cálculo e conceito · **Chave:** ⏳

Agora $\mathbf X=[\iota\ \ x_2\ \ x_3]$ com $x_3=2x_2$ (segunda coluna dobrada). Então:

- as colunas são linearmente dependentes: existe $a=(0,2,-1)'\neq 0$ com $\mathbf{X}a=0$;
- $\operatorname{posto}(X)=2 \lt K=3$, violando **H3**;
- $\det(\mathbf X'\mathbf X)=0$ e o menor autovalor é numericamente zero ($-1{,}1\times 10^{-13}$);
- $(\mathbf X'\mathbf X)^{-1}$ **não existe**, então $\mathbf b=(\mathbf X'\mathbf X)^{-1}\mathbf X'\mathbf y$ não pode ser calculado.

**O que o software faz.** O R não quebra: descarta uma coluna e reporta `NA` para o coeficiente dela. Isso não é "resolver" — é reconhecer que só a **combinação** $\beta_2+2\beta_3$ é identificada, não $\beta_2$ e $\beta_3$ separadamente. Qualquer par $(\beta_2,\beta_3)$ com a mesma soma ponderada dá exatamente o mesmo ajuste.

<!-- conferência numérica: valores conferidos contra resultados/*.csv pelo scripts/check_numbers.R — 
| chave_R | nota |
|---|---|
| m03_ex35_det | 0 |
| m03_ex35_posto | 2 |
-->

> [!WARNING]
> **Multicolinearidade perfeita × alta**
> Perfeita viola H3 e impede a estimação. Alta (mas não perfeita) **não viola nada**: o MQO segue MELNV, só com variâncias grandes — [módulo 06](../06_amostra_finita_multicol/06_lista1.md), ex. 53, 54, 63 e 64.
