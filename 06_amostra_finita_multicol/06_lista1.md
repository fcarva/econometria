---
title: "Módulo 06 — Lista 1 resolvida (ex. 26, 32, 33, 36, 37, 53, 54, 63 e 64)"
modulo: "06"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
greene: "cap. 4 (§4.3–4.4)"
slides: "SL06"
lista1: [26, 32, 33, 36, 37, 53, 54, 63, 64]
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
  - Amostra finita — Lista 1
---

# Módulo 06 — Lista 1 resolvida

Teoria e demonstrações em [06_teoria.md](06_teoria.md); números em [06_amostra_finita_multicol.R](06_amostra_finita_multicol.R).

---

## Ex. 26 — Matriz de covariância de $b$ condicional a $X$

**Tipo:** derivação · **Chave:** ➖ · **Cai como:** Q5 (caiu assim em 2025/2)

**Passo a passo.**

1. Identidade fundamental: $b-\beta=(X'X)^{-1}X'\varepsilon$.

2. Por definição de matriz de covariância de um vetor com média $\beta$:
$$\operatorname{Var}(b\mid X)=E\big[(b-\beta)(b-\beta)'\mid X\big]=E\big[(X'X)^{-1}X'\varepsilon\,\varepsilon'X(X'X)^{-1}\mid X\big].$$

3. Condicionando em $X$, as matrizes que só dependem de $X$ saem da esperança:
$$=(X'X)^{-1}X'\,E[\varepsilon\varepsilon'\mid X]\,X(X'X)^{-1}.$$

4. Use A4, $E[\varepsilon\varepsilon'\mid X]=\sigma^2I$:
$$=\sigma^2(X'X)^{-1}X'X(X'X)^{-1}=\boxed{\sigma^2(X'X)^{-1}}.\qquad\blacksquare$$

**Onde cada hipótese entrou:** A3 garante a média $\beta$ (passo 2); A4 é o passo 4; A2 garante que a inversa existe. Sem A4, fica-se com $(X'X)^{-1}X'\Omega X(X'X)^{-1}$ — a forma "sanduíche" que reaparece em MQG (P2) e em White ([módulo 08](../08_assintotica/08_teoria.md)).

**Verificação por simulação** (20 mil amostras): a maior diferença relativa entre a variância simulada e $\sigma^2(X'X)^{-1}$, na diagonal, foi de 2,7%.

**Conferência numérica**

| chave_R | nota |
|---|---|
| m06_mc_var_b2_teo | 0,085645 |
| m06_mc_var_b2_sim | 0,087420 |
| m06_mc_erro_rel_max_diag | 0,027351 |

## Ex. 32 — O significado de $E(\mu\mu'\mid X)=\sigma^2I$

**Tipo:** derivação e conceito · **Chave:** ➖

A matriz $E(\mu\mu'\mid X)$ tem, na posição $(i,j)$, o valor $E[\mu_i\mu_j\mid X]$. Dizer que ela é $\sigma^2I$ é afirmar duas coisas ao mesmo tempo:

$$E[\mu_i^2\mid X]=\sigma^2\ \ \forall i \quad\text{(homocedasticidade: diagonal constante)}$$
$$E[\mu_i\mu_j\mid X]=0\ \ \forall i\neq j \quad\text{(ausência de autocorrelação: fora da diagonal zerada)}$$

Como $E[\mu_i\mid X]=0$, esses momentos de segunda ordem são a variância e as covariâncias. Demonstrar a igualdade é, portanto, escrever a matriz elemento a elemento e aplicar as duas hipóteses.

**O que se perde sem ela.** O MQO continua não viesado e consistente, mas $\operatorname{Var}(b)$ deixa de ser $\sigma^2(X'X)^{-1}$: os erros-padrão do output ficam errados e toda a inferência vai junto. Gauss-Markov também cai — o eficiente passa a ser o MQG.

**Verificação.** Simulando com heterocedasticidade, o desvio-padrão verdadeiro de $\hat\beta_2$ fica 0,843 vez o que a fórmula clássica reporta; com autocorrelação AR(1) de $\rho=0{,}6$, a razão vai a 0,502 e o $E[s^2]$ cai para 3,284 (contra $\sigma^2=4$). Em ambos os casos, a fórmula clássica **mente** — em direções diferentes.

**Conferência numérica**

| chave_R | nota |
|---|---|
| m06_nesf_het_razao_dp_b2 | 0,84338 |
| m06_nesf_ar1_razao_dp_b2 | 0,50164 |
| m06_nesf_ar1_Es2 | 3,2839 |

## Ex. 33 — Gauss-Markov matricial com $b^*=[(X'X)^{-1}X'+C]y$

**Tipo:** derivação · **Chave:** ➖ · **Cai como:** demonstração longa

**Passo a passo.**

1. **Linearidade.** $b^*$ é linear em $y$ por construção, com matriz de pesos $[(X'X)^{-1}X'+C]$.

2. **Não-viés exige $CX=0$.** Substituindo $y=X\beta+\varepsilon$:
$$b^*=\big[(X'X)^{-1}X'+C\big](X\beta+\varepsilon)=\beta+CX\beta+\big[(X'X)^{-1}X'+C\big]\varepsilon .$$
Tomando a esperança condicional e usando A3:
$$E[b^*\mid X]=\beta+CX\beta .$$
Para que isso seja $\beta$ **para todo** $\beta$, é preciso $CX=0$.

3. **Variância.** Com $CX=0$ e A4:
$$\operatorname{Var}(b^*\mid X)=\big[(X'X)^{-1}X'+C\big]\sigma^2I\big[(X'X)^{-1}X'+C\big]'=\sigma^2(X'X)^{-1}+\sigma^2CC',$$
porque os termos cruzados contêm $CX=0$ ou $X'C'=0$.

4. **Conclusão.** $CC'$ é semidefinida positiva (é uma matriz do tipo $AA'$), logo
$$\operatorname{Var}(b^*\mid X)-\operatorname{Var}(b\mid X)=\sigma^2CC'\succeq 0 .$$
Qualquer estimador linear e não viesado tem variância **maior ou igual** à do MQO; a igualdade só vale com $C=0$, isto é, $b^*=b$. O MQO é MELNV. $\blacksquare$

**Verificação.** Dois competidores lineares não viesados (média dos extremos e média das diferenças) têm variância 1,719 e 2,838 vezes a do MQO. Um competidor com $CX\neq 0$ ganha variância menor, mas ao custo de um viés de $-1{,}203$ — exatamente o que o teorema prevê.

**Conferência numérica**

| chave_R | nota |
|---|---|
| m06_gm_razao_var_b2_meio | 1,7192 |
| m06_gm_razao_var_b2_dm | 2,8384 |
| m06_gm_vies_b2_cx | -1,2034 |
| m06_gm_autoval_min_cc1 | 0,00054701 |

## Ex. 36 — O que significa $E(u_iu_j)=\sigma_i^2$ para $i=j$

**Tipo:** conceitual · **Chave:** ➖

Com $i=j$, o momento é $E[u_i^2]=\sigma_i^2$: a variância do erro **depende da observação**. Isso é **heterocedasticidade** — viola A4. Consequências: MQO permanece não viesado e consistente, mas deixa de ser eficiente, e a matriz $\sigma^2(X'X)^{-1}$ deixa de valer, invalidando erros-padrão, $t$ e $F$. Correções: erros-padrão robustos de White, MQG ou MQP (matéria da P2, [módulo 11](../11_mqg_heterosk_autocorr/README.md)).

## Ex. 37 — Matriz de covariância dos erros com elementos fora da diagonal

**Tipo:** conceitual · **Chave:** ➖

A matriz apresentada tem 1 na diagonal e valores como 0,56 e 0,42 fora dela. Como $E(\mu\mu')=\sigma^2\Omega$ com $\Omega\neq I$, viola-se a parte de **ausência de autocorrelação** da hipótese A4: os erros de observações diferentes são correlacionados. A diagonal constante indica que a homocedasticidade, essa, está mantida.

Consequências e correção: iguais às do ex. 36 — MQO não viesado e consistente, porém ineficiente e com inferência inválida; o estimador eficiente é o de mínimos quadrados generalizados.

## Ex. 53 — Excluir variável para curar multicolinearidade

**Tipo:** conceitual · **Chave:** ✅ confere

O problema criado é o **viés de variável omitida**, mais grave que a multicolinearidade: esta não viola hipótese alguma (o MQO segue MELNV, apenas impreciso), enquanto a omissão de variável relevante **vicia** o estimador e o torna inconsistente.

**O trade-off, com números.** Numa simulação com correlação amostral de 0,910 entre os dois regressores e $\hat\delta=0{,}850$:

| Cenário ($\tau=\beta_3$) | EQM da curta | EQM da longa |
|---|---|---|
| $\tau=0$ (omitida irrelevante) | 0,1720 | 1 (referência) |
| $\tau=1$ | 1,000 | ~1 |
| $\tau=2$ | 3,484 | 0,980 |

Ou seja: a regressão curta só vence quando o coeficiente da variável omitida é pequeno — abaixo de cerca de $\tau=1$ nesta calibração. É o dilema viés-variância em forma de EQM.

**Conferência numérica**

| chave_R | nota |
|---|---|
| m06_ex53_cor_amostral | 0,909955 |
| m06_ex53_delta | 0,850138 |
| m06_ex53_eqm_curta_tau0_teo | 0,171981 |
| m06_ex53_eqm_curta_tau2_teo | 3,4841 |

## Ex. 54 — Passos do teste por regressão auxiliar

**Tipo:** conceitual e cálculo · **Chave:** ➖

**Formulação.** Para verificar se $X_1$ é explicada pelas demais, estime
$$X_{1i}=\alpha_1+\alpha_2X_{2i}+\alpha_3X_{3i}+\dots+v_i .$$

**Hipóteses.** $H_0:\alpha_2=\alpha_3=\dots=0$ (não há multicolinearidade envolvendo $X_1$) contra $H_1$: ao menos um $\neq 0$.

**Estatística.**
$$F=\frac{R^2_{aux}/(k_{aux}-1)}{(1-R^2_{aux})/(n-k_{aux})}\sim F_{k_{aux}-1,\ n-k_{aux}} ,$$
e o FIV correspondente é $1/(1-R^2_{aux})$.

**Resultado com os dados do ex. 38/39 (auxiliar de $X_1$).** $R^2_{aux}=0{,}8315$, $F=13{,}571$ com 4 e 11 graus de liberdade ($p=0{,}00031$) contra $F_{crit}=2{,}536$ a 10% ⇒ **rejeita-se** $H_0$: há colinearidade relevante. O FIV de $X_1$ é 5,935.

**Conclusão e leitura.** Rejeitar indica que $X_1$ é bem explicada pelas demais, ou seja, contribui pouco com variação própria: seu erro-padrão será inflado pelo fator $\sqrt{FIV}$. A regra prática costuma ser $FIV\gt 10$ (equivalente a $R^2_{aux}\gt 0{,}9$); no conjunto, o caso grave é o dos juros ($FIV=18{,}1$).

> [!WARNING]
> **Cuidado com os graus de liberdade**
> A auxiliar tem $k_{aux}$ parâmetros (constante + os outros 4 regressores), então são 4 e 11 graus de liberdade — e não os do modelo original. Usando os graus de liberdade errados, sairia $F=19{,}74$ em vez de 13,57.

**Conferência numérica**

| chave_R | nota |
|---|---|
| m06_ex54_r2aux | 0,831510 |
| m06_ex54_faux | 13,571 |
| m06_ex54_gl1 | 4 |
| m06_ex54_gl2 | 11 |
| m06_ex54_fcrit10 | 2,5362 |
| m06_ex54_fiv_x1 | 5,9351 |
| m06_ex54_fiv_x3 | 18,107 |

## Ex. 63 — Correlação entre exportações, preço e rendas

**Tipo:** interpretação · **Chave:** ⏳

A matriz mostra correlação **alta entre as duas rendas** (RENDABR e RENDACH: 0,887), enquanto o preço é praticamente ortogonal às demais. Como as duas rendas são as explicativas, o par problemático é esse.

Traduzindo em FIV a partir dos pares: $FIV=1/(1-0{,}887^2)=4{,}70$. Calculando o FIV completo (cada regressor contra **todos** os outros): preço 1,106, RENDABR 4,901, RENDACH 5,122. Todos abaixo de 10, então há correlação forte, mas não a ponto de inviabilizar a estimação. O menor autovalor da matriz de correlação é 0,105 e o número de condição, 4,32 — confirmando colinearidade moderada.

> [!NOTE]
> **O detalhe que o enunciado deixa passar**
> A matriz impressa não é perfeitamente simétrica: o valor RENDABR–RENDACH aparece como 0,88725 numa posição e 0,88720 na outra. A diferença é de $5\times 10^{-5}$ e não muda nada, mas vale registrar que uma matriz de correlação tem de ser simétrica.

**Conferência numérica**

| chave_R | nota |
|---|---|
| m06_ex63_assimetria | 0,00005 |
| m06_ex63_fivpar_br_ch_sup | 4,6995 |
| m06_ex63_fiv_rendabr | 4,9015 |
| m06_ex63_fiv_rendach | 5,1225 |
| m06_ex63_autoval_min | 0,104655 |
| m06_ex63_ncond | 4,3224 |

## Ex. 64 — Matriz de correlação e FIV

**Tipo:** cálculo · **Chave:** ⏳

**Leitura direta.** O par mais forte é $X_1$ com $X_2$ ($r=0{,}92$), que dá $FIV$ por pares $=1/(1-0{,}92^2)=6{,}51$. Os demais pares são fracos: $X_1$–$X_3$ ($0{,}05$; FIV 1,003) e $X_2$–$X_3$ ($-0{,}63$; FIV 1,658).

> [!CAUTION]
> **A matriz do enunciado é impossível**
> Calculando os autovalores da matriz de correlação dos regressores, o menor é **negativo** ($-0{,}1387$), e o determinante também ($-0{,}3038$). Uma matriz de correlação legítima é semidefinida positiva, com determinante entre 0 e 1. Pior: o $R^2$ implícito da auxiliar de $X_1$ sairia **1,504**, maior que 1. Ou seja, os números do enunciado não podem vir de dados reais. Responda usando os FIV **por pares** (que são bem definidos) e registre a inconsistência — é exatamente o tipo de observação que rende ponto.

**Resposta ao que é pedido.** Há indício de multicolinearidade forte entre $X_1$ e $X_2$; não há multicolinearidade perfeita (nenhum par com $\lvert r\rvert=1$). Excluir uma das duas não elimina "toda" a multicolinearidade, porque ela pode envolver combinações de três ou mais variáveis — e ainda arrisca viés de omissão (ex. 53). O diagnóstico correto usa a auxiliar de cada regressor contra **todos** os demais, não apenas pares.

**Contraexemplo que fecha o argumento.** É possível construir três variáveis em que nenhum par tem correlação alta (o maior FIV por pares é 1,98) e, mesmo assim, o FIV completo de $X_3$ é **101**: a colinearidade está na combinação $X_1+X_2$, invisível nos pares.

**Conferência numérica**

| chave_R | nota |
|---|---|
| m06_ex64_fivpar_x1x2 | 6,5104 |
| m06_ex64_fivpar_x1x3 | 1,0025 |
| m06_ex64_fivpar_x2x3 | 1,6581 |
| m06_ex64_autoval_min | -0,138727 |
| m06_ex64_det_rxx | -0,30376 |
| m06_ex64_r2_x1_implicito | 1,5037 |
| m06_ex64_contra_fivpar_max | 1,9804 |
| m06_ex64_contra_fiv_x3 | 101 |
