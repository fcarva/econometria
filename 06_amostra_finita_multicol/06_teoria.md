---
title: "Módulo 06 — Propriedades de amostra finita do MQO e multicolinearidade"
modulo: "06"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
greene: "cap. 4 (propriedades em amostra finita; multicolinearidade, Tab. 4.9; componentes principais); Teor. 3.4; Ap. A.5.3, A.7.2, B.11"
slides: "SL06"
lista1: [26, 32, 33, 36, 37, 53, 54, 63, 64]
relevancia_p1: alta
status: rascunho
verificacao:
  derivacao: ok
  numerica: ok
  chave: ok
tags:
  - econometria
  - mestrado/ppgeco
  - p1
aliases:
  - Propriedades de amostra finita do MQO
  - Multicolinearidade e VIF
---

# Módulo 06 — Propriedades de amostra finita do MQO e multicolinearidade

Hub do módulo: [README](README.md) · Exercícios: [06_lista1.md](06_lista1.md) · Script: [06_amostra_finita_multicol.R](06_amostra_finita_multicol.R) · Figuras: [figuras/](figuras/)

## 0. Mapa

> [!NOTE]
> **O que este módulo entrega**
> O MQO visto como **variável aleatória**: $\mathbf b=\beta+(\mathbf X'\mathbf X)^{-1}\mathbf X'\varepsilon$ herda tudo de $\varepsilon$. Daí saem as quatro propriedades de amostra finita do SL06 (não-viés, variância, eficiência de Gauss-Markov, distribuição normal sob [H5]), o estimador não viesado $s^2$ pelo truque do traço e, por fim, o que a correlação entre regressores faz com a variância: multicolinearidade, VIF, regressão auxiliar, número de condição e componentes principais. O núcleo D9, D14, D15 e D16 de [demonstracoes/](../demonstracoes/econometria-i-demonstracoes-mes-1-1.md) **não é repetido**: aqui ele é citado e completado onde faltava rigor (dimensões, esperança incondicional, necessidade de $\mathbf C\mathbf X=0$, a fórmula do VIF por inversa particionada).

| D | Resultado | Hipóteses | Usado em |
|---|---|---|---|
| D06.1 | $\mathbf b=\beta+(\mathbf X'\mathbf X)^{-1}\mathbf X'\varepsilon=\beta+\sum_i v_i\varepsilon_i$ | H1, H3 | tudo |
| D06.2 | $E(b\mid X)=\beta$ e $E(b)=\beta$ (lei das expectativas iteradas) | H1–H3 | ex. 24, 33 |
| D06.3 | $\operatorname{Var}(\mathbf b\mid \mathbf X)=\sigma^2(\mathbf X'\mathbf X)^{-1}$ e $\operatorname{Var}(\mathbf b)=\sigma^2E((\mathbf X'\mathbf X)^{-1})$ | H1–H4 | ex. 26; P1 2025/2 Q5 |
| D06.4 | Erros esféricos elemento a elemento; o que cai com heterocedasticidade e autocorrelação | H2, H4 | ex. 32, 36, 37 |
| D06.5 | Gauss-Markov matricial: $\mathbf C\mathbf X=0$ é necessário; $\operatorname{Var}(\mathbf b^*\mid \mathbf X)-\operatorname{Var}(\mathbf b\mid \mathbf X)=\sigma^2\mathbf C\mathbf C'\succeq 0$ | H1–H4 | ex. 33 |
| D06.6 | $\mathbf M$ é simétrica, idempotente, $\mathbf M\mathbf X=0$, autovalores 0 ou 1, $\operatorname{tr}\mathbf M=n-K$ | H3 | D06.7, D06.8 |
| D06.7 | $E(\mathbf e'\mathbf e\mid \mathbf X)=\sigma^2(n-K)$, logo $E(s^2)=\sigma^2$ (truque do traço) | H1–H4 | ex. 23c; toda inferência |
| D06.8 | Sob H5: $\mathbf b\mid \mathbf X$ normal, $(n-K)s^2/\sigma^2\sim\chi^2(n-K)$, $\mathbf b$ e $s^2$ independentes | H1–H5 | teste t e F (módulo 07) |
| D06.9 | $\operatorname{Var}(b_k\mid X)=\sigma^2/[(1-R_k^2)S_{kk}]$ e VIF; $\operatorname{Corr}(b_2,b_3\mid X)=-r_{23}$ | H1–H4 + constante | ex. 54, 63, 64 |
| D06.10 | Omitir variável: viés $P_{12}\beta_2$, variância menor e comparação por EQM | H1–H4 | ex. 53 |
| D06.11 | Colinearidade perfeita: $\mathbf X'\mathbf X$ singular e $\beta$ não identificado | H3 | ex. 35 |
| D06.12 | Teste F da regressão auxiliar e VIF por pares como cota inferior | H3 (+ normalidade para o F) | ex. 54, 63, 64 |
| D06.13 | Componentes principais: autovetor do maior autovalor | — | remédio (SL06, p. 56–60) |

## 1. Notação e hipóteses

- Notação do Greene (ver [CONVENCOES.md](../CONVENCOES.md)): $\mathbf y$ é $n\times1$, $\mathbf X$ é $n\times K$ **com** a coluna $\iota$ de 1s, $\beta$ é $K\times1$, $\varepsilon$ é $n\times1$. $\mathbf b=(\mathbf X'\mathbf X)^{-1}\mathbf X'\mathbf y$ ($K\times1$), $\mathbf e=\mathbf y-\mathbf X\mathbf b$ ($n\times1$).
- $\mathbf A\equiv(\mathbf X'\mathbf X)^{-1}\mathbf X'$ é $K\times n$ (então $\mathbf b=\mathbf A\mathbf y$). $\mathbf P=\mathbf X\mathbf A$ e $\mathbf M=\mathbf I_n-\mathbf P$ são $n\times n$. $\mathbf M^0=\mathbf I_n-\tfrac1n\iota\iota'$. $s^2=\mathbf e'\mathbf e/(n-K)$, com $K$ contando a constante.
- $v_i=(\mathbf X'\mathbf X)^{-1}\mathbf x_i$ ($K\times1$), em que $\mathbf x_i'$ é a linha $i$ de $\mathbf X$ ($1\times K$). Então $\mathbf X'\varepsilon=\sum_i \mathbf x_i\varepsilon_i$.
- Para um regressor $x_k$ ($n\times1$): $\mathbf X_{(k)}$ é $\mathbf X$ sem a coluna $k$ ($n\times(K-1)$, **com** $\iota$), $\mathbf M_{(k)}=\mathbf I_n-\mathbf X_{(k)}(\mathbf X_{(k)}'\mathbf X_{(k)})^{-1}\mathbf X_{(k)}'$, $S_{kk}=\sum_i(x_{ik}-\bar x_k)^2=x_k'\mathbf M^0x_k$ e $R_k^2$ é o $R^2$ da regressão auxiliar de $x_k$ em $\mathbf X_{(k)}$. $\mathrm{VIF}_k=1/(1-R_k^2)$.
- Na Lista 1 o erro aparece como $\mathbf u$, $\mu$ ou $\varepsilon$, e $\mathbf b^*$ (ex. 33) é o que D16 chama de $b_0$. Na prova, use a letra do enunciado.

**Hipóteses usadas** (numeração da chave da Lista 1 v.1, [CONVENCOES.md](../CONVENCOES.md) §2): [H1] linearidade; [H2] exogeneidade estrita, $E(\varepsilon\mid\mathbf X)=\mathbf 0$, com $\mathbf X$ fixo ou independente de $\varepsilon$; [H3] posto completo; [H4] esfericidade, $E(\varepsilon\varepsilon'\mid\mathbf X)=\sigma^2\mathbf I_n$; [H5] normalidade, $\varepsilon\mid\mathbf X\sim N(\mathbf 0,\sigma^2\mathbf I_n)$. Não-viés usa H1–H3; variância e Gauss-Markov acrescentam H4; distribuição exata acrescenta H5. **Nenhuma** propriedade deste módulo exige $n\to\infty$: são de amostra finita. As assintóticas estão no módulo 08.

**Contexto amostral (SL06, p. 3–13).** "Estimativa" é o número calculado em uma amostra; "estimador" é a regra $\mathbf b=\mathbf A\mathbf y$, uma variável aleatória. As propriedades de amostra finita descrevem a **distribuição amostral** de $\mathbf b$: o que aconteceria com $\mathbf b$ se o experimento fosse repetido muitas vezes. Há dois experimentos possíveis. Com **$\mathbf X$ fixo em amostras repetidas**, só $\varepsilon$ é sorteado de novo; os resultados valem condicionais a $\mathbf X$ ($E(\cdot\mid \mathbf X)$). Com **$\mathbf X$ aleatório**, sorteia-se tudo; os resultados incondicionais saem dos condicionais pela lei das expectativas iteradas. O script faz os dois (seções A e B).

## 2. Demonstrações

### D06.1 · b como variável aleatória

> [!NOTE]
> **O que se quer provar**
> Sob [H1] e [H3], $\mathbf b=\beta+(\mathbf X'\mathbf X)^{-1}\mathbf X'\varepsilon=\beta+\sum_{i=1}^n v_i\varepsilon_i$, com $v_i=(\mathbf X'\mathbf X)^{-1}x_i$. Logo $\mathbf b$ é **linear** em $\mathbf y$ (e em $\varepsilon$): $\mathbf b=\mathbf A\mathbf y$ com $\mathbf A$ função só de $\mathbf X$.

**Por que importa.** Todas as propriedades seguintes são contas com esta identidade. É o análogo matricial de $\widehat\beta_2=\beta_2+\sum w_iu_i$ (D9).

**Passo a passo.**

1. Sob [H3], $\mathbf X'\mathbf X$ ($K\times K$) tem posto $K$, logo é invertível, e $\mathbf b=(\mathbf X'\mathbf X)^{-1}\mathbf X'\mathbf y$ existe. Substitui-se [H1], $\mathbf y=\mathbf X\beta+\varepsilon$:

$$
\mathbf b=\underbrace{(\mathbf X'\mathbf X)^{-1}}_{K\times K}\underbrace{\mathbf X'}_{K\times n}\big(\underbrace{\mathbf X\beta}_{n\times1}+\underbrace{\varepsilon}_{n\times1}\big)=(\mathbf X'\mathbf X)^{-1}\mathbf X'\mathbf X\beta+(\mathbf X'\mathbf X)^{-1}\mathbf X'\varepsilon .
$$

2. Como $(\mathbf X'\mathbf X)^{-1}(\mathbf X'\mathbf X)=\mathbf I_K$, o primeiro termo é $\beta$:

$$
\mathbf b=\beta+(\mathbf X'\mathbf X)^{-1}\mathbf X'\varepsilon=\beta+\mathbf A\varepsilon .
$$

3. Escrevendo $\mathbf X'\varepsilon=\sum_i x_i\varepsilon_i$ (produto de $\mathbf X'$ pela coluna $\varepsilon$, soma de colunas de $\mathbf X'$ ponderadas por $\varepsilon_i$):

$$
\boxed{\mathbf b=\beta+\sum_{i=1}^n\underbrace{(\mathbf X'\mathbf X)^{-1}x_i}_{v_i\ (K\times1)}\,\varepsilon_i}
$$

> [!TIP]
> **Como o professor pode torcer**
> "Mostre que $\mathbf b$ é linear." A resposta é $\mathbf b=\mathbf A\mathbf y$ com $\mathbf A=(\mathbf X'\mathbf X)^{-1}\mathbf X'$ não dependendo de $\mathbf y$. Não precisa de nenhuma hipótese sobre $\varepsilon$: linearidade é álgebra, só usa [H3].

### D06.2 · Não-viés condicional e incondicional

> [!NOTE]
> **O que se quer provar**
> Sob H1–H3, $E(b\mid X)=\beta$ para todo $\beta$ e, se $E(b)$ existe, $E(b)=\beta$.

**Por que importa.** D14 (etapa 1) e o ex. 24 do módulo 03 fazem a parte condicional. O que falta é a passagem para a esperança **incondicional**, que é o que "não viesado" significa quando $X$ é aleatório (SL06, p. 11 e 35).

**Passo a passo.**

1. Esperança condicional de D06.1. Dado $\mathbf X$, $\mathbf A$ é constante e sai da esperança (linearidade de $E(\cdot\mid \mathbf X)$). *[D06.1; H2]*

$$
E(\mathbf b\mid \mathbf X)=\beta+(\mathbf X'\mathbf X)^{-1}\mathbf X'\,E(\varepsilon\mid \mathbf X)=\beta+(\mathbf X'\mathbf X)^{-1}\mathbf X'\cdot 0=\beta .
$$

2. Lei das expectativas iteradas, $E(b)=E_X\big(E(b\mid X)\big)$: *[LEI]*

$$
E(b)=E_X(\beta)=\beta .
$$

$$\boxed{E(b\mid X)=\beta\quad\Longrightarrow\quad E(b)=\beta}$$

> [!WARNING]
> **O que [H2] exige e o que não basta**
> É preciso $E(\varepsilon\mid X)=0$ (exogeneidade **estrita**: $\varepsilon_i$ não correlacionado com os regressores de **todas** as observações). Só $E(x_i\varepsilon_i)=0$ (ortogonalidade contemporânea) não basta para não-viés em amostra finita; basta para consistência (módulo 08). Exemplo clássico: regressão com $y_{t-1}$ como regressor é viesada em amostra finita.

> [!TIP]
> **Como o professor pode torcer**
> - "O estimador é não viesado se houver heterocedasticidade?" Sim: o passo 1 não usa [H4].
> - Se $E(\varepsilon\mid \mathbf X)=\eta\neq0$ (ex. 65), então $E(\mathbf b\mid \mathbf X)=\beta+(\mathbf X'\mathbf X)^{-1}\mathbf X'\eta$: viés. É a porta para variáveis instrumentais (módulo 10).
> - Erro de medição no regressor (P1 2025/2, Q4) quebra [H2]; na dependente, não (ver a [prova resolvida](../provas/p1_2025_2/econometria-i-prova-2025-2-resolvida.md)).

### D06.3 · Variância condicional e incondicional de b (ex. 26)

> [!NOTE]
> **O que se quer provar**
> Sob H1–H4, $\operatorname{Var}(\mathbf b\mid \mathbf X)=\sigma^2(\mathbf X'\mathbf X)^{-1}$ ($K\times K$). Se $\mathbf X$ é aleatório e $E((\mathbf X'\mathbf X)^{-1})$ existe, $\operatorname{Var}(\mathbf b)=\sigma^2E((\mathbf X'\mathbf X)^{-1})$.

**Por que importa.** A parte condicional é D14; aqui ela vem com as dimensões em cada produto, que é o que a correção cobra, e com a versão incondicional (SL06, p. 22–23). Caiu na P1 2025/2 (Q5) junto com consistência.

**Passo a passo.**

1. Definição de matriz de covariância de um vetor $K\times1$ com média condicional $\beta$ (D06.2): *[def.; D06.2]*

$$
\operatorname{Var}(\mathbf b\mid \mathbf X)=E\big((\mathbf b-\beta)(\mathbf b-\beta)'\mid \mathbf X\big)\qquad (K\times1)(1\times K)=K\times K .
$$

2. Por D06.1, $\mathbf b-\beta=\mathbf A\varepsilon$ e $(\mathbf b-\beta)'=\varepsilon'\mathbf A'$, com $\mathbf A=(\mathbf X'\mathbf X)^{-1}\mathbf X'$ ($K\times n$) e $\mathbf A'=\mathbf X(\mathbf X'\mathbf X)^{-1}$ ($n\times K$; a inversa de uma matriz simétrica é simétrica): *[D06.1; $(\mathbf A\mathbf B)'=\mathbf B'\mathbf A'$]*

$$
\operatorname{Var}(\mathbf b\mid \mathbf X)=E\big(\underbrace{\mathbf A}_{K\times n}\underbrace{\varepsilon\varepsilon'}_{n\times n}\underbrace{\mathbf A'}_{n\times K}\mid \mathbf X\big).
$$

3. Dado $\mathbf X$, $\mathbf A$ é constante; a esperança de uma forma $\mathbf A \mathbf Z \mathbf A'$ com $\mathbf A$ constante é $\mathbf A\,E(\mathbf Z)\,\mathbf A'$ (linearidade elemento a elemento): *[linearidade de $E(\cdot\mid \mathbf X)$]*

$$
\operatorname{Var}(\mathbf b\mid \mathbf X)=\mathbf A\,E(\varepsilon\varepsilon'\mid \mathbf X)\,\mathbf A' .
$$

4. Erros esféricos: *[H4]*

$$
\operatorname{Var}(\mathbf b\mid \mathbf X)=\mathbf A(\sigma^2\mathbf I_n)\mathbf A'=\sigma^2\mathbf A\mathbf A'=\sigma^2(\mathbf X'\mathbf X)^{-1}\mathbf X'\mathbf X(\mathbf X'\mathbf X)^{-1}.
$$

5. $\mathbf X'\mathbf X(\mathbf X'\mathbf X)^{-1}=\mathbf I_K$:

$$
\boxed{\operatorname{Var}(\mathbf b\mid \mathbf X)=\sigma^2(\mathbf X'\mathbf X)^{-1}}\qquad(K\times K,\ \text{simétrica, positiva definida})
$$

6. **Incondicional.** Decomposição da variância (lei da variância total), $\operatorname{Var}(b)=E_X(\operatorname{Var}(b\mid X))+\operatorname{Var}_X(E(b\mid X))$: *[lei da variância total; D06.2]*

$$
\operatorname{Var}(\mathbf b)=E_{\mathbf X}\big(\sigma^2(\mathbf X'\mathbf X)^{-1}\big)+\operatorname{Var}_{\mathbf X}(\beta)=\sigma^2E\big((\mathbf X'\mathbf X)^{-1}\big)+0 .
$$

$$\boxed{\operatorname{Var}(\mathbf b)=\sigma^2E\big((\mathbf X'\mathbf X)^{-1}\big)}$$

**Leitura.** O elemento $(k,k)$ é $\operatorname{Var}(b_k\mid \mathbf X)$ e o $(j,k)$ é $\operatorname{Cov}(b_j,b_k\mid \mathbf X)$. $\sigma^2$ é desconhecido: estima-se $\operatorname{Var}(\mathbf b\mid \mathbf X)$ por $s^2(\mathbf X'\mathbf X)^{-1}$ (D06.7), e o erro-padrão impresso no output é $\sqrt{s^2[(\mathbf X'\mathbf X)^{-1}]_{kk}}$. A estimativa de $E((\mathbf X'\mathbf X)^{-1})$ usa a única informação disponível, o próprio $\mathbf X$ (SL06, p. 23): na prática, $s^2(\mathbf X'\mathbf X)^{-1}$ serve para as duas.

> [!WARNING]
> **$E((\mathbf X'\mathbf X)^{-1})\neq[E(\mathbf X'\mathbf X)]^{-1}$**
> A inversão é uma função convexa no sentido matricial, e a desigualdade de Jensen dá $E((\mathbf X'\mathbf X)^{-1})\succeq[E(\mathbf X'\mathbf X)]^{-1}$. Trocar uma pela outra **subestima** a variância. No script (seção B), com $\mathbf X$ sorteado a cada réplica, $\operatorname{Var}(\mathbf b_2)$ simulada é 0,1093, $\sigma^2E((\mathbf X'\mathbf X)^{-1})_{22}$ é 0,1066 e $\sigma^2[E(\mathbf X'\mathbf X)]^{-1}_{22}$ é só 0,0925.

> [!TIP]
> **Como o professor pode torcer**
> - Pedir a versão escalar ($\operatorname{Var}(\widehat\beta_2\mid \mathbf X)=\sigma^2/S_{XX}$, D10): é o elemento $(2,2)$ desta matriz quando $\mathbf X=[\iota\ \ x]$.
> - Tirar [H4] e pedir a variância: o passo 4 vira $\mathbf A\Sigma \mathbf A'=(\mathbf X'\mathbf X)^{-1}\mathbf X'\Sigma \mathbf X(\mathbf X'\mathbf X)^{-1}$ (sanduíche; ver D06.4).
> - Pedir $\operatorname{Var}(\mathbf b)$ "sem condicionar": responder com o passo 6 e dizer que o termo $\operatorname{Var}_{\mathbf X}(E(\mathbf b\mid \mathbf X))$ some **porque** $\mathbf b$ é condicionalmente não viesado.

<!-- conferência numérica: valores conferidos contra resultados/*.csv pelo scripts/check_numbers.R — (seção A do script: $n=30$, $K=3$, $\sigma=2$, 10.000 réplicas com $\mathbf X$ fixo; seção B: 5.000 réplicas com $\mathbf X$ aleatório)
| chave_R | nota |
|---|---|
| m06_mc_media_b2 | 0,4943 |
| m06_mc_var_b2_teo | 0,085645 |
| m06_mc_var_b2_sim | 0,08742 |
| m06_mc_cov_b2b3_teo | -0,07402 |
| m06_mc_cov_b2b3_sim | -0,07610 |
| m06_mc_erro_rel_max_diag | 0,027 |
| m06_inc_media_b2 | 0,5002 |
| m06_inc_var_b2_sim | 0,1093 |
| m06_inc_var_b2_teo | 0,1066 |
| m06_inc_var_b2_jensen | 0,0925 |
-->

A distribuição simulada de $b_2$ está em [figuras/m06_dist_b2.png](figuras/m06_dist_b2.png).

![Distribuição amostral de b2 com X fixo](figuras/m06_dist_b2.png)

### D06.4 · Erros esféricos elemento a elemento (ex. 32, 36, 37)

> [!NOTE]
> **O que se quer provar**
> (i) Sob [H2], o elemento $(i,j)$ de $E(\varepsilon\varepsilon'\mid \mathbf X)$ é $\operatorname{Cov}(\varepsilon_i,\varepsilon_j\mid \mathbf X)$, e $E(\varepsilon\varepsilon'\mid \mathbf X)=\sigma^2\mathbf I_n$ equivale a homocedasticidade (diagonal constante) **e** ausência de autocorrelação (fora da diagonal nula). (ii) Com amostragem aleatória, $E(\varepsilon_i\mid x_i)=0$ e $E(\varepsilon_i^2\mid x_i)=\sigma^2$, a matriz $\sigma^2\mathbf I_n$ é **consequência**. (iii) Se $E(\varepsilon\varepsilon'\mid \mathbf X)=\Sigma\neq\sigma^2\mathbf I_n$, $\mathbf b$ continua não viesado, mas $\operatorname{Var}(\mathbf b\mid \mathbf X)=\mathbf A\Sigma \mathbf A'$, $s^2(\mathbf X'\mathbf X)^{-1}$ é viesado e Gauss-Markov deixa de valer.

**Por que importa.** Os ex. 32, 36 e 37 são exatamente isto, e a leitura "qual hipótese caiu" volta na P2 (MQG, SL11).

**Passo a passo.**

1. $\varepsilon\varepsilon'$ é $n\times n$ com elemento $(i,j)$ igual a $\varepsilon_i\varepsilon_j$. Tomando $E(\cdot\mid X)$ elemento a elemento: *[def. de esperança de matriz]*

$$
E(\varepsilon\varepsilon'\mid X)=\begin{bmatrix}E(\varepsilon_1^2\mid X)&E(\varepsilon_1\varepsilon_2\mid X)&\cdots&E(\varepsilon_1\varepsilon_n\mid X)\\ E(\varepsilon_2\varepsilon_1\mid X)&E(\varepsilon_2^2\mid X)&\cdots&E(\varepsilon_2\varepsilon_n\mid X)\\ \vdots&\vdots&\ddots&\vdots\\ E(\varepsilon_n\varepsilon_1\mid X)&E(\varepsilon_n\varepsilon_2\mid X)&\cdots&E(\varepsilon_n^2\mid X)\end{bmatrix}.
$$

2. Como $E(\varepsilon_i\mid X)=0$ para todo $i$, $\operatorname{Cov}(\varepsilon_i,\varepsilon_j\mid X)=E(\varepsilon_i\varepsilon_j\mid X)-E(\varepsilon_i\mid X)E(\varepsilon_j\mid X)=E(\varepsilon_i\varepsilon_j\mid X)$. Em particular, a diagonal é $\operatorname{Var}(\varepsilon_i\mid X)$. *[H2; def. de covariância]*

3. Logo $E(\varepsilon\varepsilon'\mid X)=\sigma^2I_n$ se e somente se: *[comparação elemento a elemento]*

$$
\underbrace{\operatorname{Var}(\varepsilon_i\mid X)=\sigma^2\ \ \forall i}_{\text{homocedasticidade: diagonal constante}}\qquad\text{e}\qquad\underbrace{\operatorname{Cov}(\varepsilon_i,\varepsilon_j\mid X)=0\ \ \forall i\neq j}_{\text{sem autocorrelação: fora da diagonal nula}} .
$$

4. **Quando dá para "provar" (ex. 32).** $\sigma^2I_n$ é hipótese, mas é consequência de três hipóteses mais primitivas (Hayashi, §1.1): $\{(y_i,x_i)\}$ i.i.d., $E(\varepsilon_i\mid x_i)=0$ e $E(\varepsilon_i^2\mid x_i)=\sigma^2$. Pela independência entre observações, condicionar em $X$ equivale a condicionar em $x_i$ (ou em $x_i,x_j$). Então, para $i\neq j$: *[i.i.d.; independência]*

$$
E(\varepsilon_i\varepsilon_j\mid X)=E(\varepsilon_i\varepsilon_j\mid x_i,x_j)=E(\varepsilon_i\mid x_i)\,E(\varepsilon_j\mid x_j)=0\cdot0=0,
$$

e, na diagonal, $E(\varepsilon_i^2\mid X)=E(\varepsilon_i^2\mid x_i)=\sigma^2$. Juntando, $E(\varepsilon\varepsilon'\mid X)=\sigma^2I_n$.

5. **Se falhar.** Seja $E(\varepsilon\varepsilon'\mid X)=\Sigma$ ($n\times n$, simétrica, positiva definida). D06.2 não usa [H4], logo $E(b\mid X)=\beta$ continua. O passo 3 de D06.3 dá: *[D06.3, passo 3]*

$$
\operatorname{Var}(\mathbf b\mid \mathbf X)=\underbrace{(\mathbf X'\mathbf X)^{-1}}_{K\times K}\underbrace{\mathbf X'}_{K\times n}\underbrace{\Sigma}_{n\times n}\underbrace{\mathbf X}_{n\times K}\underbrace{(\mathbf X'\mathbf X)^{-1}}_{K\times K}\ \neq\ \sigma^2(\mathbf X'\mathbf X)^{-1}.
$$

Além disso, $E(\mathbf e'\mathbf e\mid \mathbf X)=\operatorname{tr}(\mathbf M\Sigma)$ (mesma conta de D06.7 sem usar [H4]), de modo que $s^2(\mathbf X'\mathbf X)^{-1}$ não estima a variância certa: os erros-padrão impressos e os testes t e F ficam errados. Gauss-Markov também cai (D06.5 usa [H4] no passo 5); o eficiente passa a ser o MQG (SL11).

| Estrutura de $E(\varepsilon\varepsilon'\mid X)$ | Diagonal | Fora da diagonal | Hipótese violada | Exercício |
|---|---|---|---|---|
| $\sigma^2I_n$ | constante | zero | nenhuma | ex. 32 |
| $\operatorname{diag}(\sigma_1^2,\dots,\sigma_n^2)$ | varia com $i$ | zero | homocedasticidade (parte de H4) | ex. 36 |
| $\sigma^2\Omega$, $\Omega$ com 1 na diagonal | constante | não nula | ausência de autocorrelação (parte de H4) | ex. 37 |

> [!TIP]
> **Como o professor pode torcer**
> - Dar a matriz em forma de correlação, $\sigma^2\Omega$ com uns na diagonal (ex. 37): a diagonal constante indica homocedasticidade; os 0,56, 0,42 e 0,65 fora da diagonal são **correlações** entre erros, e a covariância é $\sigma^2$ vezes elas.
> - Perguntar se $b$ fica viesado: não, só perde eficiência e o erro-padrão usual fica errado (passo 5).
> - Escrever $E(u_i,u_j)$ (notação do ex. 36): leia como $E(u_iu_j\mid X)$; para $i=j$ é $E(u_i^2\mid X)=\operatorname{Var}(u_i\mid X)$.

<!-- conferência numérica: valores conferidos contra resultados/*.csv pelo scripts/check_numbers.R — (seção D do script: razão entre o desvio-padrão "ingênuo" $\sqrt{E(s^2\mid \mathbf X)[(\mathbf X'\mathbf X)^{-1}]_{22}}$ e o verdadeiro $\sqrt{[\mathbf A\Sigma \mathbf A']_{22}}$)
| chave_R | nota |
|---|---|
| m06_nesf_het_razao_dp_b2 | 0,843 |
| m06_nesf_ar1_rho | 0,6 |
| m06_nesf_ar1_razao_dp_b2 | 0,502 |
-->

Com variância crescente no desvio de $x_2$, o erro-padrão usual subestima o verdadeiro em cerca de 16%; com erros AR(1) de $\rho=0{,}6$ e regressor com tendência, o usual é só metade do verdadeiro, e o teste t rejeita demais.

### D06.5 · Gauss-Markov matricial com b* = [(X'X)^{-1}X' + C]y (ex. 33)

> [!NOTE]
> **O que se quer provar**
> Sob H1–H4, seja $\mathbf b^*=[(\mathbf X'\mathbf X)^{-1}\mathbf X'+\mathbf C]\mathbf y$, com $\mathbf C$ ($K\times n$) função só de $\mathbf X$. (i) $\mathbf b^*$ é não viesado para todo $\beta$ **se e somente se** $\mathbf C\mathbf X=0$. (ii) Nesse caso, $\operatorname{Var}(\mathbf b^*\mid \mathbf X)=\sigma^2(\mathbf X'\mathbf X)^{-1}+\sigma^2\mathbf C\mathbf C'$. (iii) $\sigma^2\mathbf C\mathbf C'\succeq0$, e $\mathbf C\mathbf C'=0$ só se $\mathbf C=0$. Logo $\operatorname{Var}(\mathbf a'\mathbf b^*\mid \mathbf X)\ge\operatorname{Var}(\mathbf a'\mathbf b\mid \mathbf X)$ para todo $a\in\mathbb{R}^K$: MQO é BLUE.

**Por que importa.** D16 já faz a conta. Aqui entram os três pontos em que a correção costuma tirar nota: a **necessidade** de $\mathbf C\mathbf X=0$ (não só suficiência), a **positividade semidefinida** com dimensões e o que "menor variância" significa para matrizes. Todo estimador linear em $\mathbf y$ se escreve assim: dado $\mathbf b^*=Dy$, basta tomar $\mathbf C=D-\mathbf A$ (SL06, p. 30–33).

**Passo a passo.**

1. Dimensões: $(\mathbf X'\mathbf X)^{-1}\mathbf X'$ é $K\times n$, $\mathbf C$ é $K\times n$, $\mathbf y$ é $n\times1$; $\mathbf b^*$ é $K\times1$. Substitui-se [H1] e usa-se $(\mathbf X'\mathbf X)^{-1}\mathbf X'\mathbf X=\mathbf I_K$: *[H1; D06.1]*

$$
\mathbf b^*=\beta+(\mathbf X'\mathbf X)^{-1}\mathbf X'\varepsilon+\underbrace{\mathbf C}_{K\times n}\underbrace{\mathbf X}_{n\times K}\beta+\mathbf C\varepsilon .
$$

2. Esperança condicional, com $\mathbf C$ e $\mathbf X$ constantes dado $\mathbf X$: *[H2; linearidade de $E(\cdot\mid \mathbf X)$]*

$$
E(b^*\mid X)=\beta+CX\beta .
$$

3. **Necessidade.** "Não viesado" significa $E(\mathbf b^*\mid \mathbf X)=\beta$ **para todo** $\beta\in\mathbb{R}^K$, isto é, $\mathbf C\mathbf X\beta=0$ para todo $\beta$. Tomando $\beta=\mathbf{e}_k$ (vetor canônico), $\mathbf C\mathbf X\mathbf{e}_k$ é a coluna $k$ de $\mathbf C\mathbf X$; logo cada coluna de $\mathbf C\mathbf X$ ($K\times K$) é nula: *[escolha de $\beta$]*

$$
\boxed{CX=0_{K\times K}}\qquad\Longleftrightarrow\qquad E(b^*\mid X)=\beta\ \ \forall\beta .
$$

A volta é imediata pelo passo 2. Sob $\mathbf C\mathbf X=0$: $\mathbf b^*-\beta=[(\mathbf X'\mathbf X)^{-1}\mathbf X'+\mathbf C]\varepsilon\equiv(\mathbf A+\mathbf C)\varepsilon$.

4. Variância, pelo mesmo argumento de D06.3 (passos 1–4), agora com $\mathbf A+\mathbf C$ ($K\times n$) no lugar de $\mathbf A$: *[D06.3; H4]*

$$
\operatorname{Var}(\mathbf b^*\mid \mathbf X)=(\mathbf A+\mathbf C)\,E(\varepsilon\varepsilon'\mid \mathbf X)\,(\mathbf A+\mathbf C)'=\sigma^2\big(\mathbf A\mathbf A'+\mathbf A\mathbf C'+\mathbf C\mathbf A'+\mathbf C\mathbf C'\big).
$$

5. Termos cruzados. $\mathbf C\mathbf A'=\mathbf C\mathbf X(\mathbf X'\mathbf X)^{-1}=0\cdot(\mathbf X'\mathbf X)^{-1}=0$ ($K\times K$), e $\mathbf A\mathbf C'=(\mathbf C\mathbf A')'=0$. E $\mathbf A\mathbf A'=(\mathbf X'\mathbf X)^{-1}$ (D06.3, passo 5): *[passo 3; transposição]*

$$
\boxed{\operatorname{Var}(\mathbf b^*\mid \mathbf X)=\underbrace{\sigma^2(\mathbf X'\mathbf X)^{-1}}_{\operatorname{Var}(b\mid X)}+\sigma^2\underbrace{\mathbf C}_{K\times n}\underbrace{\mathbf C'}_{n\times K}}
$$

6. **$\mathbf C\mathbf C'$ é positiva semidefinida.** Para todo $a\in\mathbb{R}^K$, $w\equiv \mathbf C'a$ é $n\times1$ e: *[forma quadrática]*

$$
\mathbf a'\mathbf C\mathbf C'\mathbf a=(\mathbf C'\mathbf a)'(\mathbf C'\mathbf a)=w'w=\sum_{i=1}^n w_i^2\ \ge\ 0 .
$$

7. **Estrita quando $\mathbf C\neq0$.** $\operatorname{tr}(\mathbf C\mathbf C')=\sum_{k,i}c_{ki}^2>0$ se $\mathbf C\neq0$; como o traço é a soma dos elementos da diagonal, pelo menos um $[\mathbf C\mathbf C']_{kk}>0$. Então existe pelo menos um coeficiente com $\operatorname{Var}(b_k^*\mid \mathbf X)>\operatorname{Var}(b_k\mid \mathbf X)$, e nenhum com variância menor. *[traço]*

8. **Tradução para a prova.** Para qualquer combinação linear $a'\beta$ (um coeficiente, uma soma, uma previsão): *[Var de forma linear; passos 5–6]*

$$
\operatorname{Var}(\mathbf a'\mathbf b^*\mid \mathbf X)-\operatorname{Var}(\mathbf a'\mathbf b\mid \mathbf X)=\mathbf a'\big[\operatorname{Var}(\mathbf b^*\mid \mathbf X)-\operatorname{Var}(\mathbf b\mid \mathbf X)\big]\mathbf a=\sigma^2\mathbf a'\mathbf C\mathbf C'\mathbf a\ \ge0 .
$$

$$\boxed{\operatorname{Var}(\mathbf b^*\mid \mathbf X)-\operatorname{Var}(\mathbf b\mid \mathbf X)=\sigma^2\mathbf C\mathbf C'\succeq0\ \Longrightarrow\ \mathbf b\ \text{é eficiente (BLUE)}}$$

O resultado é condicional a $\mathbf X$; como vale para cada $\mathbf X$, vale também incondicionalmente (tomar $E_{\mathbf X}$ preserva a semidefinição: $E_{\mathbf X}(\sigma^2\mathbf C\mathbf C')\succeq0$).

> [!IMPORTANT]
> **O que Gauss-Markov diz e o que não diz**
> - Usa H1–H4. **Não** usa normalidade [H5].
> - Compara $\mathbf b$ só com estimadores **lineares e não viesados**. Um estimador viesado (a regressão curta de D06.10, ridge, pré-teste) pode ter **EQM menor**.
> - "Menor" é no sentido matricial: a diferença é positiva semidefinida. Isso implica cada variância da diagonal menor ou igual, mas é mais forte que isso.
> - Com heterocedasticidade ou autocorrelação, o passo 4 vira $(\mathbf A+\mathbf C)\Sigma(\mathbf A+\mathbf C)'$ e os termos cruzados não somem: MQO deixa de ser BLUE.

> [!TIP]
> **Como o professor pode torcer**
> - Dar $\mathbf b^*$ com $\mathbf C$ e dizer "linear e não viciado" (ex. 33): mesmo assim **deduza** $\mathbf C\mathbf X=0$ no passo 3; é o ponto que vale nota.
> - Escalar (D11): pesos $c_i=w_i+d_i$ e as condições $\sum d_i=0$ e $\sum d_ix_i=0$ são exatamente $\mathbf C\mathbf X=0$ com $\mathbf X=[\iota\ \ x]$.
> - Pedir um exemplo de concorrente: o MQO calculado só com parte da amostra é linear e não viesado (seção C do script); a razão de variâncias de $b_2$ é 1,72.

<!-- conferência numérica: valores conferidos contra resultados/*.csv pelo scripts/check_numbers.R — (seção C: $C_1$ = MQO na primeira metade menos MQO completo; $C_2=DM$ com $D$ arbitrária, logo $C_2X=DMX=0$)
| chave_R | nota |
|---|---|
| m06_gm_media_b2_meio | 0,4948 |
| m06_gm_media_b2_dm | 0,4947 |
| m06_gm_var_b2_meio_teo | 0,1472 |
| m06_gm_var_b2_meio_sim | 0,1471 |
| m06_gm_var_b2_dm_teo | 0,2431 |
| m06_gm_var_b2_dm_sim | 0,2445 |
| m06_gm_razao_var_b2_meio | 1,72 |
| m06_gm_razao_var_b2_dm | 2,84 |
| m06_gm_vies_b2_cx | -1,203 |
| m06_gm_vies_b2_cx_sim | -1,211 |
-->

Os menores autovalores de $\sigma^2C_1C_1'$ e de $\sigma^2C_2C_2'$ são positivos (chaves `m06_gm_autoval_min_cc1` e `m06_gm_autoval_min_cc2` no CSV). Quando se usa $C=D$ sem o $M$, $CX\neq0$ e o estimador é viesado: o viés teórico $[CX\beta]_2$ bate com o simulado. Figura: [figuras/m06_gauss_markov.png](figuras/m06_gauss_markov.png).

![Gauss-Markov](figuras/m06_gauss_markov.png)

### D06.6 · Propriedades da matriz M

> [!NOTE]
> **O que se quer provar**
> Sob [H3], $\mathbf M=\mathbf I_n-\mathbf X(\mathbf X'\mathbf X)^{-1}\mathbf X'$ ($n\times n$) satisfaz $\mathbf M'=\mathbf M$, $\mathbf M\mathbf M=\mathbf M$, $\mathbf M\mathbf X=0$, $\mathbf e=\mathbf M\mathbf y=\mathbf M\varepsilon$, seus autovalores são 0 ou 1 e $\operatorname{tr}(\mathbf M)=\operatorname{posto}(\mathbf M)=n-K$.

**Por que importa.** É a ferramenta de D06.7 e D06.8. $\mathbf e=\mathbf M\mathbf y$ é o ex. 28 (módulo 03); aqui o que interessa é $\mathbf e=\mathbf M\varepsilon$ e o traço (SL06, p. 38–42).

**Passo a passo.**

1. Simetria: $\mathbf M'=\mathbf I_n-[\mathbf X(\mathbf X'\mathbf X)^{-1}\mathbf X']'=\mathbf I_n-\mathbf X(\mathbf X'\mathbf X)^{-1}\mathbf X'=\mathbf M$. *[$(\mathbf A\mathbf B\mathbf C)'=\mathbf C'\mathbf B'\mathbf A'$; $(\mathbf X'\mathbf X)^{-1}$ simétrica]*
2. $\mathbf M\mathbf X=\mathbf X-\mathbf X(\mathbf X'\mathbf X)^{-1}\mathbf X'\mathbf X=\mathbf X-\mathbf X=0$ ($n\times K$). *[$(\mathbf X'\mathbf X)^{-1}\mathbf X'\mathbf X=\mathbf I_K$]*
3. Idempotência: $\mathbf M\mathbf M=\mathbf M-\mathbf X(\mathbf X'\mathbf X)^{-1}\mathbf X'\mathbf M=\mathbf M-\mathbf X(\mathbf X'\mathbf X)^{-1}(\mathbf M\mathbf X)'=\mathbf M$. *[passos 1–2]*
4. $\mathbf e=\mathbf y-\mathbf X\mathbf b=[\mathbf I_n-\mathbf X(\mathbf X'\mathbf X)^{-1}\mathbf X']\mathbf y=\mathbf M\mathbf y=\mathbf M(\mathbf X\beta+\varepsilon)=\mathbf M\varepsilon$. *[passo 2; H1]*
5. Autovalores: se $Mz=\lambda z$ com $z\neq0$, então $\lambda z=Mz=MMz=\lambda^2z$, logo $\lambda^2=\lambda$ e $\lambda\in\{0,1\}$. *[passo 3]*
6. Traço, pela propriedade cíclica $\operatorname{tr}(\mathbf A\mathbf B)=\operatorname{tr}(\mathbf B\mathbf A)$ com $\mathbf A=\mathbf X$ ($n\times K$) e $\mathbf B=(\mathbf X'\mathbf X)^{-1}\mathbf X'$ ($K\times n$): *[linearidade do traço; ciclicidade]*

$$
\operatorname{tr}(\mathbf M)=\operatorname{tr}(\mathbf I_n)-\operatorname{tr}\big[\mathbf X(\mathbf X'\mathbf X)^{-1}\mathbf X'\big]=n-\operatorname{tr}\big[(\mathbf X'\mathbf X)^{-1}\mathbf X'\mathbf X\big]=n-\operatorname{tr}(\mathbf I_K)=n-K .
$$

Como $\mathbf M$ é simétrica, $\mathbf M=\mathbf C\Lambda \mathbf C'$ com $\mathbf C'\mathbf C=\mathbf I_n$, e $\operatorname{tr}(\mathbf M)=\operatorname{tr}(\Lambda)$ = número de autovalores iguais a 1 = $\operatorname{posto}(\mathbf M)$.

$$\boxed{\operatorname{tr}(M)=\operatorname{posto}(M)=n-K}$$

<!-- conferência numérica: valores conferidos contra resultados/*.csv pelo scripts/check_numbers.R — ($n=30$, $K=3$ na seção A)
| chave_R | nota |
|---|---|
| m06_trM | 27 |
| m06_autoval_M_uns | 27 |
| m06_autoval_M_zeros | 3 |
-->

### D06.7 · E(s²) = σ² pelo truque do traço

> [!NOTE]
> **O que se quer provar**
> Sob H1–H4, $E(\mathbf e'\mathbf e\mid \mathbf X)=\sigma^2(n-K)$. Logo $s^2=\mathbf e'\mathbf e/(n-K)$ satisfaz $E(s^2\mid \mathbf X)=\sigma^2$ e $E(s^2)=\sigma^2$, enquanto $E(\mathbf e'\mathbf e/n\mid \mathbf X)=\sigma^2(n-K)/n\lt\sigma^2$.

**Por que importa.** É o que justifica dividir por $n-K$ em todo output (o "Degrees of freedom" do NLOGIT) e é a peça que falta para $s^2(\mathbf X'\mathbf X)^{-1}$ estimar $\operatorname{Var}(\mathbf b\mid \mathbf X)$ sem viés. Não está no D0–D16. O ponto sutil: $\mathbf e'\mathbf e$ é um **escalar**, e o traço é o que permite mover $\varepsilon$ para dentro da esperança (SL06, p. 37–41).

**Passo a passo.**

1. Por D06.6, $\mathbf e=\mathbf M\varepsilon$. Então $\mathbf e'\mathbf e=\varepsilon'\mathbf M'\mathbf M\varepsilon=\varepsilon'\mathbf M\varepsilon$ ($1\times n\cdot n\times n\cdot n\times1=1\times1$). *[D06.6: $\mathbf M'=\mathbf M$, $\mathbf M\mathbf M=\mathbf M$]*

$$
\mathbf e'\mathbf e=\varepsilon'\mathbf M\varepsilon=\sum_{i=1}^n\sum_{j=1}^n m_{ij}\varepsilon_i\varepsilon_j .
$$

2. Um escalar é igual ao seu traço, e $\operatorname{tr}(\varepsilon'M\varepsilon)=\operatorname{tr}(M\varepsilon\varepsilon')$ pela ciclicidade, com $\varepsilon'$ ($1\times n$) e $M\varepsilon$ ($n\times1$): *[escalar = traço; ciclicidade]*

$$
\mathbf e'\mathbf e=\operatorname{tr}(\varepsilon'\mathbf M\varepsilon)=\operatorname{tr}(\underbrace{\mathbf M\varepsilon\varepsilon'}_{n\times n}).
$$

3. Traço e esperança comutam (o traço é soma de elementos da diagonal, e $E$ é linear); dado $\mathbf X$, $\mathbf M$ é constante: *[linearidade de $E$ e do traço]*

$$
E(\mathbf e'\mathbf e\mid \mathbf X)=\operatorname{tr}\big(E(\mathbf M\varepsilon\varepsilon'\mid \mathbf X)\big)=\operatorname{tr}\big(\mathbf M\,E(\varepsilon\varepsilon'\mid \mathbf X)\big).
$$

4. Erros esféricos e D06.6: *[H4; D06.6]*

$$
E(\mathbf e'\mathbf e\mid \mathbf X)=\operatorname{tr}(\mathbf M\sigma^2\mathbf I_n)=\sigma^2\operatorname{tr}(\mathbf M)=\sigma^2(n-K).
$$

5. Dividindo por $n-K$ (constante) e usando a lei das expectativas iteradas: *[linearidade; LEI]*

$$
\boxed{E(s^2\mid \mathbf X)=\frac{E(\mathbf e'\mathbf e\mid \mathbf X)}{n-K}=\sigma^2\qquad\Longrightarrow\qquad E(s^2)=E_{\mathbf X}\big(E(s^2\mid \mathbf X)\big)=\sigma^2}
$$

6. **Conta alternativa, sem traço** (útil se o professor pedir escalar): pelo passo 1, $E(\mathbf e'\mathbf e\mid \mathbf X)=\sum_i\sum_jm_{ij}E(\varepsilon_i\varepsilon_j\mid \mathbf X)=\sum_i m_{ii}\sigma^2=\sigma^2\operatorname{tr}(\mathbf M)$, porque $E(\varepsilon_i\varepsilon_j\mid \mathbf X)=0$ para $i\neq j$ e $\sigma^2$ para $i=j$ *[H4, elemento a elemento como em D06.4]*.

7. **Consequência.** $\widehat{\operatorname{Var}}(\mathbf b\mid \mathbf X)=s^2(\mathbf X'\mathbf X)^{-1}$ é não viesado para $\sigma^2(\mathbf X'\mathbf X)^{-1}$: $E(s^2(\mathbf X'\mathbf X)^{-1}\mid \mathbf X)=(\mathbf X'\mathbf X)^{-1}E(s^2\mid \mathbf X)=\sigma^2(\mathbf X'\mathbf X)^{-1}$. *[passo 5; $\mathbf X$ constante dado $\mathbf X$]*

**Por que $\mathbf e'\mathbf e/n$ subestima.** $e_i=\varepsilon_i-\mathbf x_i'(\mathbf b-\beta)$: o resíduo é o erro "contaminado" pelo erro de estimação, e o MQO escolhe $\mathbf b$ justamente para deixar $\mathbf e'\mathbf e$ pequeno ($\mathbf e'\mathbf e\le\varepsilon'\varepsilon$ sempre, porque $\mathbf e'\mathbf e=\min_d(\mathbf y-Xd)'(\mathbf y-Xd)$ e $\varepsilon=\mathbf y-\mathbf X\beta$). Perde-se um grau de liberdade por parâmetro estimado: as $K$ restrições $\mathbf X'\mathbf e=0$.

> [!WARNING]
> **$s$ não é não viesado para $\sigma$**
> $E(s^2)=\sigma^2$ não implica $E(s)=\sigma$. Como a raiz é côncava, Jensen dá $E(s)=E(\sqrt{s^2})\le\sqrt{E(s^2)}=\sigma$. Na seção A ($\sigma=2$), a média de $s$ nas réplicas é 1,984. O viés some com $n$ grande; em amostra finita, não.

> [!TIP]
> **Como o professor pode torcer**
> - Regressão simples: $E(\sum\widehat u_i^2)=\sigma^2(n-2)$, o mesmo resultado com $K=2$.
> - Sem [H4]: o passo 4 vira $\operatorname{tr}(M\Sigma)$, que em geral não é $\sigma^2(n-K)$.
> - Pedir "quantos graus de liberdade": $n-K$ no Greene ($K$ conta a constante), $n-k-1$ no Wooldridge ($k$ inclinações). Mesmo número.

<!-- conferência numérica: valores conferidos contra resultados/*.csv pelo scripts/check_numbers.R — (seção A; $\sigma^2=4$, $n-K=27$)
| chave_R | nota |
|---|---|
| m06_mc_media_s2 | 3,995 |
| m06_mc_media_een | 3,596 |
| m06_mc_een_teo | 3,6 |
| m06_mc_media_s | 1,9803 |
-->

### D06.8 · Distribuição de b e de s² sob normalidade

> [!NOTE]
> **O que se quer provar**
> Sob H1–H5: (i) $\mathbf b\mid \mathbf X\sim N\big(\beta,\sigma^2(\mathbf X'\mathbf X)^{-1}\big)$; (ii) $(n-K)s^2/\sigma^2\mid \mathbf X\sim\chi^2(n-K)$; (iii) $\mathbf b$ e $s^2$ são independentes dado $\mathbf X$. Consequência: $t_k=(b_k-\beta_k)/\sqrt{s^2[(\mathbf X'\mathbf X)^{-1}]_{kk}}\sim t(n-K)$, também incondicionalmente.

**Por que importa.** É a quarta propriedade do SL06 (p. 34–35) e a base exata dos testes t e F do módulo 07. Sem [H5], a distribuição de $\mathbf b$ em amostra finita é desconhecida e a inferência passa a ser assintótica (módulo 08); é por isso que, com $n=4165$, o JB é dispensável (P1 2025/2, Q1a).

**Passo a passo.**

1. $\mathbf b-\beta=\mathbf A\varepsilon$ é função linear de um vetor normal. Função linear de normal é normal, com média $\mathbf A\cdot0$ e covariância $\mathbf A(\sigma^2\mathbf I_n)\mathbf A'$: *[H5; Greene, Ap. B.11.3; D06.3]*

$$
\mathbf b\mid \mathbf X\sim N\big(\beta,\ \sigma^2\mathbf A\mathbf A'\big)=N\big(\beta,\ \sigma^2(\mathbf X'\mathbf X)^{-1}\big).
$$

2. Seja $z=\varepsilon/\sigma$, com $z\mid \mathbf X\sim N(0,\mathbf I_n)$. Por D06.6, $(n-K)s^2/\sigma^2=\mathbf e'\mathbf e/\sigma^2=\mathbf z'\mathbf M\mathbf z$. Decompondo $\mathbf M=\mathbf C\Lambda \mathbf C'$ ($\mathbf C'\mathbf C=\mathbf I_n$) e definindo $w=\mathbf C'z$: *[D06.6; H5]*

$$
w\mid \mathbf X\sim N(0,\mathbf C'\mathbf I_n\mathbf C)=N(0,\mathbf I_n),\qquad \mathbf z'\mathbf M\mathbf z=w'\Lambda w=\sum_{i:\ \lambda_i=1}w_i^2 .
$$

3. Há exatamente $n-K$ autovalores iguais a 1 (D06.6), e os $w_i$ são normais padrão independentes (normais não correlacionadas). Soma de $n-K$ quadrados de $N(0,1)$ independentes: *[def. de $\chi^2$; Greene, Teor. B.8]*

$$
\boxed{\frac{(n-K)s^2}{\sigma^2}\ \Big|\ X\sim\chi^2(n-K)}
$$

Daí, de novo, $E(s^2\mid X)=\sigma^2$ (média da $\chi^2$ é $n-K$) e $\operatorname{Var}(s^2\mid X)=2\sigma^4/(n-K)$.

4. **Independência.** $b-\beta=A\varepsilon$ e $e=M\varepsilon$ são funções lineares do mesmo vetor normal, logo **conjuntamente** normais. A covariância cruzada ($K\times n$) é: *[Var de forma linear; H4; D06.6]*

$$
\operatorname{Cov}(\mathbf A\varepsilon,\mathbf M\varepsilon\mid \mathbf X)=\mathbf A\,E(\varepsilon\varepsilon'\mid \mathbf X)\,\mathbf M'=\sigma^2(\mathbf X'\mathbf X)^{-1}\mathbf X'\mathbf M=\sigma^2(\mathbf X'\mathbf X)^{-1}(\mathbf M\mathbf X)'=0 .
$$

Para vetores conjuntamente normais, covariância nula implica independência. Então $\mathbf b$ é independente de $\mathbf e$ e, portanto, de qualquer função de $\mathbf e$, como $s^2=\mathbf e'\mathbf e/(n-K)$. *[normal multivariada; Greene, Ap. B.11.4]*

5. **Estatística t.** Dividindo numerador e denominador por $\sqrt{\sigma^2[(\mathbf X'\mathbf X)^{-1}]_{kk}}$: *[passos 1, 3 e 4]*

$$
t_k=\frac{(b_k-\beta_k)\big/\sqrt{\sigma^2[(\mathbf X'\mathbf X)^{-1}]_{kk}}}{\sqrt{\dfrac{(n-K)s^2/\sigma^2}{n-K}}}=\frac{N(0,1)}{\sqrt{\chi^2(n-K)/(n-K)}}\ \ \text{(independentes)}\ \sim t(n-K).
$$

A distribuição não depende de $\mathbf X$, logo vale também sem condicionar.

> [!WARNING]
> **Covariância zero só dá independência com normalidade conjunta**
> O passo 4 usa [H5]. Sem normalidade, $b$ e $s^2$ continuam não correlacionados em muitos casos, mas não necessariamente independentes, e o $t$ não tem distribuição $t$ exata.

> [!TIP]
> **Como o professor pode torcer**
> - "Por que $n-K$ graus de liberdade?" Porque $\operatorname{posto}(M)=n-K$ (D06.6).
> - "O teste t exige normalidade?" Em amostra finita, sim ([H5]); em amostra grande, não (TLC, módulo 08).

<!-- conferência numérica: valores conferidos contra resultados/*.csv pelo scripts/check_numbers.R — (seção A, 10.000 réplicas; teoria: média 27, variância 54, tamanho 5%)
| chave_R | nota |
|---|---|
| m06_mc_media_q | 26,97 |
| m06_mc_var_q | 54,21 |
| m06_mc_cor_b2_s2 | 0,011 |
| m06_mc_tamanho_t | 0,0533 |
| m06_mc_tcrit | 2,052 |
-->

![(n−K)s²/σ² contra a qui-quadrado](figuras/m06_qui2_s2.png)

### D06.9 · Variância de um coeficiente e VIF (partição e FWL)

> [!NOTE]
> **O que se quer provar**
> Sob H1–H4, com constante em $\mathbf X$:
>
> $$\operatorname{Var}(b_k\mid \mathbf X)=\sigma^2\big[(\mathbf X'\mathbf X)^{-1}\big]_{kk}=\frac{\sigma^2}{x_k'\mathbf M_{(k)}x_k}=\frac{\sigma^2}{(1-R_k^2)\,S_{kk}}=\frac{\sigma^2}{S_{kk}}\cdot\mathrm{VIF}_k .$$
>
> Com $K=3$ ($\mathbf X=[\iota\ \ x_2\ \ x_3]$): $\operatorname{Var}(\mathbf b_2\mid \mathbf X)=\sigma^2/[(1-r_{23}^2)S_{22}]$ e $\operatorname{Corr}(\mathbf b_2,\mathbf b_3\mid \mathbf X)=-r_{23}$.

**Por que importa.** D15 enuncia a fórmula e diz que "sai por FWL"; aqui está a conta. É a fórmula do SL06 (p. 49–51, Teorema 3.4 do Greene) e a origem do VIF usado nos ex. 54, 63 e 64.

**Passo a passo.**

1. Reordene as colunas: $\mathbf X=[\mathbf X_{(k)}\ \ x_k]$, com $\mathbf X_{(k)}$ ($n\times(K-1)$, contendo $\iota$). A variância de $b_k$ não depende da ordem das colunas. Por Frisch-Waugh-Lovell ([módulo 04](../04_fwl_particionada/04_teoria.md)), o coeficiente de $x_k$ é *[FWL]*

$$
b_k=\big(x_k'\mathbf M_{(k)}x_k\big)^{-1}x_k'\mathbf M_{(k)}\mathbf y\qquad(1\times n\cdot n\times n\cdot n\times1=\text{escalar}).
$$

2. Substitui-se $\mathbf y=\mathbf X_{(k)}\beta_{(k)}+x_k\beta_k+\varepsilon$; como $\mathbf M_{(k)}\mathbf X_{(k)}=0$ (D06.6 aplicada a $\mathbf X_{(k)}$): *[H1; D06.6]*

$$
b_k=\beta_k+\big(x_k'\mathbf M_{(k)}x_k\big)^{-1}x_k'\mathbf M_{(k)}\varepsilon .
$$

3. Variância, com $\mathbf a'=(x_k'\mathbf M_{(k)}x_k)^{-1}x_k'\mathbf M_{(k)}$ ($1\times n$) constante dado $\mathbf X$: *[Var de forma linear; H4; $\mathbf M_{(k)}$ simétrica e idempotente]*

$$
\operatorname{Var}(b_k\mid X)=\sigma^2a'a=\sigma^2\frac{x_k'M_{(k)}M_{(k)}x_k}{(x_k'M_{(k)}x_k)^2}=\frac{\sigma^2}{x_k'M_{(k)}x_k}.
$$

(O mesmo sai da inversa particionada, Greene, Ap. A.5.3: o bloco inferior direito de $(\mathbf X'\mathbf X)^{-1}$ é $[x_k'x_k-x_k'\mathbf X_{(k)}(\mathbf X_{(k)}'\mathbf X_{(k)})^{-1}\mathbf X_{(k)}'x_k]^{-1}=[x_k'\mathbf M_{(k)}x_k]^{-1}$.)

4. $x_k'\mathbf M_{(k)}x_k=e_k'e_k$ é a soma dos quadrados dos resíduos da regressão auxiliar de $x_k$ em $\mathbf X_{(k)}$. Como $\mathbf X_{(k)}$ contém $\iota$, o $R^2$ centrado dessa regressão é $R_k^2=1-e_k'e_k/S_{kk}$, com $S_{kk}=x_k'\mathbf M^0x_k$: *[def. de $R^2$ com constante]*

$$
x_k'M_{(k)}x_k=(1-R_k^2)\,S_{kk}.
$$

5. Substituindo no passo 3:

$$\boxed{\operatorname{Var}(b_k\mid X)=\frac{\sigma^2}{(1-R_k^2)\,S_{kk}}=\underbrace{\frac{\sigma^2}{S_{kk}}}_{\text{se }x_k\perp\text{ demais}}\times\underbrace{\frac{1}{1-R_k^2}}_{\mathrm{VIF}_k}}$$

6. **Caso $K=3$.** Pela inversa particionada com $\mathbf X=[\iota\ \ \tilde X]$, o bloco das inclinações de $(\mathbf X'\mathbf X)^{-1}$ é $(\tilde X'\mathbf M^0\tilde X)^{-1}$, com *[Ap. A.5.3; inversa $2\times2$]*

$$
\tilde X'\mathbf M^0\tilde X=\begin{bmatrix}S_{22}&S_{23}\\ S_{23}&S_{33}\end{bmatrix},\qquad(\tilde X'\mathbf M^0\tilde X)^{-1}=\frac{1}{\Delta}\begin{bmatrix}S_{33}&-S_{23}\\ -S_{23}&S_{22}\end{bmatrix},\quad\Delta=S_{22}S_{33}(1-r_{23}^2).
$$

Logo $\operatorname{Var}(b_2\mid X)=\sigma^2S_{33}/\Delta=\sigma^2/[(1-r_{23}^2)S_{22}]$ (aqui $R_2^2=r_{23}^2$) e

$$
\operatorname{Corr}(b_2,b_3\mid X)=\frac{-\sigma^2S_{23}/\Delta}{\sqrt{\sigma^2S_{33}/\Delta}\sqrt{\sigma^2S_{22}/\Delta}}=-\frac{S_{23}}{\sqrt{S_{22}S_{33}}}=-r_{23}.
$$

**Leitura.** Três fontes de imprecisão: $\sigma^2$ grande, pouca variação de $x_k$ ($S_{kk}$ pequeno) e $x_k$ bem explicado pelos outros regressores ($R_k^2$ perto de 1). Só a terceira é multicolinearidade. Com $r_{23}$ alto e positivo, $b_2$ e $b_3$ andam em sentidos opostos: os dados identificam bem $\beta_2+\beta_3$ e mal $\beta_2-\beta_3$ (ver a seção 4).

> [!TIP]
> **Como o professor pode torcer**
> - Dar $R_k^2$ da auxiliar e pedir o VIF: $1/(1-R_k^2)$. Dar o VIF e pedir $R_k^2$: $1-1/\mathrm{VIF}$ (VIF = 10 equivale a $R_k^2=0{,}9$).
> - Com dois regressores, $R_k^2=r^2$ e o VIF "por pares" é o VIF exato (ex. 64).
> - Perguntar por que a variância **não** depende de $\beta$: porque $b_k-\beta_k$ só envolve $\varepsilon$ (passo 2).

<!-- conferência numérica: valores conferidos contra resultados/*.csv pelo scripts/check_numbers.R — (seção A: $x_3$ correlacionado com $x_2$; a fórmula do passo 5 reproduz $\sigma^2[(\mathbf X'\mathbf X)^{-1}]_{33}$ exatamente, conferido por `stopifnot`)
| chave_R | nota |
|---|---|
| m06_mc_cor_x2x3 | 0,831 |
| m06_mc_r2_aux_x3 | 0,6905 |
| m06_mc_fiv_x3 | 3,231 |
| m06_mc_var_b3_fwl | 0,09265 |
| m06_mc_var_b3_teo | 0,09265 |
| m06_mc_var_b3_sim | 0,09518 |
| m06_mc_var_b3_sem_colin | 0,02867 |
-->

### D06.10 · Omitir variável: viés, variância e EQM (ex. 53)

> [!NOTE]
> **O que se quer provar**
> Modelo verdadeiro $\mathbf y=\mathbf X_1\beta_1+\mathbf X_2\beta_2+\varepsilon$ com H1–H4. Regressão curta $\mathbf b_1=(\mathbf X_1'\mathbf X_1)^{-1}\mathbf X_1'\mathbf y$; longa $b_{1\cdot2}=(\mathbf X_1'\mathbf M_2\mathbf X_1)^{-1}\mathbf X_1'\mathbf M_2\mathbf y$. (i) $E(\mathbf b_1\mid \mathbf X)=\beta_1+\mathbf P_{12}\beta_2$, $\mathbf P_{12}=(\mathbf X_1'\mathbf X_1)^{-1}\mathbf X_1'\mathbf X_2$. (ii) $\operatorname{Var}(b_{1\cdot2}\mid \mathbf X)-\operatorname{Var}(\mathbf b_1\mid \mathbf X)\succeq0$. (iii) Com uma variável incluída e uma omitida, $\mathrm{EQM}(\mathbf b_1)\lt\mathrm{EQM}(b_{1\cdot2})$ se e somente se $\beta_2^2\lt\operatorname{Var}(b_{2\cdot1}\mid \mathbf X)$.

**Por que importa.** O ex. 53 pergunta qual problema a exclusão de variável cria. A resposta "viés de omissão" (o viés é o ex. 25, [módulo 04](../04_fwl_particionada/04_teoria.md)) é metade: o SL06 (p. 24–25 e 61) insiste que omitir **reduz a variância**, e a comparação honesta é por EQM.

**Passo a passo.**

1. **Viés.** Substitui-se o modelo verdadeiro na regressão curta; $P_{12}$ é $K_1\times K_2$: *[H1; H2]*

$$
\mathbf b_1=\beta_1+\mathbf P_{12}\beta_2+(\mathbf X_1'\mathbf X_1)^{-1}\mathbf X_1'\varepsilon\ \Longrightarrow\ E(\mathbf b_1\mid \mathbf X)=\beta_1+\mathbf P_{12}\beta_2 .
$$

O viés some só se $\beta_2=0$ ou $X_1'X_2=0$. Quem exclui uma variável **porque** ela é colinear com as outras está, por construção, no caso $X_1'X_2\neq0$: se $\beta_2\neq0$, o viés é certo. E não some com $n$: $\operatorname{plim}P_{12}\neq0$, logo $b_1$ também é inconsistente.

2. **Variâncias.** Pelo mesmo argumento de D06.3, $\operatorname{Var}(\mathbf b_1\mid \mathbf X)=\sigma^2(\mathbf X_1'\mathbf X_1)^{-1}$ e, por FWL como em D06.9, $\operatorname{Var}(b_{1\cdot2}\mid \mathbf X)=\sigma^2(\mathbf X_1'\mathbf M_2\mathbf X_1)^{-1}$. Compare as **inversas**: *[D06.3; D06.9; $\mathbf P_2=\mathbf I-\mathbf M_2$ simétrica e idempotente]*

$$
\mathbf X_1'\mathbf X_1-\mathbf X_1'\mathbf M_2\mathbf X_1=\mathbf X_1'\mathbf P_2\mathbf X_1=(\mathbf P_2\mathbf X_1)'(\mathbf P_2\mathbf X_1)\succeq0 .
$$

Para matrizes positivas definidas, $A\succeq B\succ0$ implica $B^{-1}\succeq A^{-1}$. Com $A=X_1'X_1$ e $B=X_1'M_2X_1$: *[inversão inverte a ordem de Loewner]*

$$
\boxed{\operatorname{Var}(b_{1\cdot2}\mid X)\succeq\operatorname{Var}(b_1\mid X)}
$$

Omitir $X_2$ equivale a impor a informação $\beta_2=0$. Informação, certa ou errada, reduz variância (SL06, p. 25 e 29).

3. **Caso escalar.** $\mathbf y=\beta_0+\beta_1x_1+\beta_2x_2+\varepsilon$; a curta omite $x_2$. Seja $\delta=S_{12}/S_{11}$ a inclinação de $x_2$ em $(\iota,x_1)$ e $r$ a correlação amostral entre $x_1$ e $x_2$. Por D06.9 e D10: *[D06.9; D10]*

$$
\operatorname{Var}(b_{1\cdot2})=\frac{\sigma^2}{S_{11}(1-r^2)},\qquad\operatorname{Var}(b_1)=\frac{\sigma^2}{S_{11}},\qquad\operatorname{Var}(b_{2\cdot1})=\frac{\sigma^2}{S_{22}(1-r^2)} .
$$

Como $\delta^2=S_{12}^2/S_{11}^2=r^2S_{22}/S_{11}$, *[álgebra]*

$$
\operatorname{Var}(b_{1\cdot2})-\operatorname{Var}(b_1)=\frac{\sigma^2}{S_{11}}\cdot\frac{r^2}{1-r^2}=\delta^2\operatorname{Var}(b_{2\cdot1}).
$$

4. **EQM** ($=$ variância $+$ viés$^2$, ex. 9). O viés da curta é $\delta\beta_2$ (passo 1); a longa é não viesada: *[EQM; passos 1 e 3]*

$$
\mathrm{EQM}(b_1)-\mathrm{EQM}(b_{1\cdot2})=\big[\operatorname{Var}(b_1)+\delta^2\beta_2^2\big]-\big[\operatorname{Var}(b_1)+\delta^2\operatorname{Var}(b_{2\cdot1})\big]=\delta^2\big[\beta_2^2-\operatorname{Var}(b_{2\cdot1})\big].
$$

$$\boxed{\mathrm{EQM}(b_1)\lt\mathrm{EQM}(b_{1\cdot2})\iff\lvert\tau\rvert\lt1,\qquad\tau\equiv\frac{\beta_2}{\sqrt{\operatorname{Var}(b_{2\cdot1}\mid X)}}}$$

$\tau$ é a razão t **populacional** de $\beta_2$ na regressão longa. Como $\tau$ é desconhecido, a regra prática "exclua $x_2$ se o t estimado for pequeno" é um **estimador de pré-teste**: nem a curta nem a longa, viesado e com EQM que, numa faixa de $\tau$, supera o da longa (Greene, discussão do pré-teste).

> [!IMPORTANT]
> **Resposta completa do ex. 53**
> Excluir uma variável relevante e correlacionada com as incluídas gera **viés (e inconsistência) de variável omitida**, $E(b_1\mid X)-\beta_1=P_{12}\beta_2$. A causa: a variável omitida vai para o erro, que passa a ser correlacionado com os regressores incluídos, violando [H2]. Em troca, a variância cai. Multicolinearidade não viola hipótese nenhuma (se não for perfeita); o viés viola. Por isso a exclusão pode ser o problema "mais grave".

> [!TIP]
> **Como o professor pode torcer**
> - "Incluir variável irrelevante causa viés?" Não (SL06, p. 26): com $\beta_2=0$, a longa é não viesada, só perde precisão.
> - "Quando a exclusão não causa viés?" Quando $\beta_2=0$ ou a omitida é ortogonal às incluídas; mas então ela não era a causa da multicolinearidade.

<!-- conferência numérica: valores conferidos contra resultados/*.csv pelo scripts/check_numbers.R — (seção H: $n=50$, correlação amostral entre $x_1$ e $x_2$ de 0,910; EQM de $b_1$ relativo a $\operatorname{Var}(b_{1\cdot2})$; 5.000 réplicas por valor de $\tau$)
| chave_R | nota |
|---|---|
| m06_ex53_cor_amostral | 0,910 |
| m06_ex53_delta | 0,850 |
| m06_ex53_razao_var_curta_longa | 0,172 |
| m06_ex53_eqm_curta_tau0_teo | 0,172 |
| m06_ex53_eqm_curta_tau0_sim | 0,168 |
| m06_ex53_eqm_curta_tau1_teo | 1 |
| m06_ex53_eqm_curta_tau2_teo | 3,484 |
| m06_ex53_eqm_curta_tau2_sim | 3,488 |
| m06_ex53_eqm_longa_tau2_sim | 0,980 |
| m06_ex53_eqm_pre_max_sim | 2,246 |
| m06_ex53_eqm_pre_tau_max | 2,25 |
-->

Com $\tau=0$ a curta tem EQM de só 17% do da longa; em $\tau=1$ empatam; em $\tau=2$ a curta é 3,5 vezes pior. O pré-teste chega a 2,25 vezes o EQM da longa perto de $\tau=2{,}25$.

![EQM: curta × longa × pré-teste](figuras/m06_eqm_omissao.png)

### D06.11 · Colinearidade perfeita e quase colinearidade

> [!NOTE]
> **O que se quer provar**
> (i) Se existe $c\neq0$ ($K\times1$) com $\mathbf{X}c=0$, então $\mathbf X'\mathbf X$ é singular e $\beta$ não é identificado. (ii) Com $\mathbf X'\mathbf X$ invertível e autovalores $\lambda_1\ge\dots\ge\lambda_K>0$, a combinação linear de $\beta$ mais mal estimada é a do autovetor do menor autovalor: $\max_{\lVert c\rVert=1}\operatorname{Var}(\mathbf c'\mathbf b\mid \mathbf X)=\sigma^2/\lambda_K$.

**Por que importa.** Separa as duas coisas que o SL06 (p. 48–49) separa: a colinearidade **perfeita** é defeito do modelo (viola [H3]); a **quase** colinearidade é característica dos dados (não viola nada, só infla variâncias). O item (ii) justifica o número de condição.

**Passo a passo.**

1. Se $\mathbf{X}c=0$ com $c\neq0$, então $\mathbf X'\mathbf{X}c=\mathbf X'0=0$: $\mathbf X'\mathbf X$ ($K\times K$) tem núcleo não trivial, logo $\det(\mathbf X'\mathbf X)=0$ e não há inversa. As equações normais $\mathbf X'\mathbf X\mathbf b=\mathbf X'\mathbf y$ têm infinitas soluções: se $b_0$ resolve, $b_0+\lambda c$ também, para todo $\lambda$. *[posto; D13]*
2. **Não identificação.** $\mathbf X\beta=\mathbf X(\beta+\lambda c)$ para todo $\lambda$: os parâmetros $\beta$ e $\beta+\lambda c$ geram a mesma distribuição de $\mathbf y$. Nenhuma quantidade de dados separa um do outro. *[H1]*
3. Exemplos: o de Monet no SL06 (p. 48), em que o log da altura é combinação exata do log da área e do log da razão de aspecto; a armadilha da dummy (ex. 61); o ex. 35, com $X_2=2X_1$.
4. **Quase colinearidade.** $\mathbf X'\mathbf X=\mathbf C\Lambda \mathbf C'$ (decomposição espectral, $\mathbf C'\mathbf C=\mathbf I_K$), logo $(\mathbf X'\mathbf X)^{-1}=\mathbf C\Lambda^{-1}\mathbf C'$. Para $\lVert c\rVert=1$, escrevendo $c=\mathbf C\alpha$ com $\lVert\alpha\rVert=1$: *[D06.3; decomposição espectral]*

$$
\operatorname{Var}(\mathbf c'\mathbf b\mid \mathbf X)=\sigma^2\mathbf c'(\mathbf X'\mathbf X)^{-1}\mathbf c=\sigma^2\sum_{j=1}^K\frac{\alpha_j^2}{\lambda_j}\ \le\ \frac{\sigma^2}{\lambda_K},
$$

com igualdade quando $c$ é o autovetor de $\lambda_K$. Se uma combinação das colunas é quase nula ($\mathbf{X}c\approx0$), então $\lambda_K\approx \mathbf c'\mathbf X'\mathbf X\mathbf c\approx0$ e essa combinação é estimada com variância enorme.

5. **Número de condição.** $\kappa=\sqrt{\lambda_{\max}/\lambda_{\min}}$ de $\mathbf X'\mathbf X$, com as colunas de $\mathbf X$ escaladas para comprimento 1 (Belsley), para que a medida não dependa das unidades. $\kappa>30$ é considerado alto (SL06, p. 53).

> [!IMPORTANT]
> **Multicolinearidade (não perfeita) não viola hipótese nenhuma**
> H1–H4 continuam valendo: $b$ é não viesado e **BLUE**. As consequências são de precisão: erros-padrão grandes, t pequenos, intervalos largos, coeficientes sensíveis a pequenas mudanças nos dados e com sinais "errados", e o quadro clássico de F global significativo com t individuais não significativos. O problema é de **informação** nos dados, não do estimador.

<!-- conferência numérica: valores conferidos contra resultados/*.csv pelo scripts/check_numbers.R — (seção E: dados de Longley, base do R, emprego contra ano, deflator do PIB, PIB e forças armadas, 1947–1962; os VIF reproduzem a Tabela 4.9 do Greene citada no SL06, p. 52)
| chave_R | nota |
|---|---|
| m06_lo_fiv_year | 143,46 |
| m06_lo_fiv_deflator | 75,67 |
| m06_lo_fiv_gnp | 132,46 |
| m06_lo_fiv_armed | 1,553 |
| m06_lo_ncond_escalado | 15824 |
| m06_lo_varpct_deflator | 89,1 |
| m06_lo_varpct_gnp | -29,3 |
| m06_lo_varpct_armed | 86,5 |
| m06_lo_varpct_year | 20,1 |
-->

Acrescentar **uma** observação (1962) muda o coeficiente do deflator em 89% e o das forças armadas em 86%: é a sensibilidade que o SL06 aponta como assinatura da colinearidade. O VIF calculado pelas regressões auxiliares coincide com `car::vif` (diferença máxima na chave `m06_lo_dif_max_aux_car`, da ordem de $10^{-12}$).

### D06.12 · Teste F da regressão auxiliar e VIF por pares (ex. 54, 63, 64)

> [!NOTE]
> **O que se quer provar**
> (i) No modelo com $K$ parâmetros (constante incluída), a regressão auxiliar de $x_k$ nos outros $K-2$ regressores e na constante dá $F_k=\dfrac{R_k^2/(K-2)}{(1-R_k^2)/(n-K+1)}$, que sob $H_0$ (nenhuma relação linear entre $x_k$ e os demais) e normalidade segue $F(K-2,\,n-K+1)$. (ii) $R_k^2\ge r_{kj}^2$ para todo $j$, logo $\mathrm{VIF}_k\ge\max_j 1/(1-r_{kj}^2)$: o VIF por pares é **cota inferior** do VIF.

**Por que importa.** (i) é o que o ex. 54 pede, passo a passo; (ii) responde "isto elimina todas as possíveis multicolinearidades?" do ex. 64.

**Passo a passo.**

1. **A regressão auxiliar é uma regressão comum.** Tem $K-1$ parâmetros (constante e $K-2$ inclinações) e $n$ observações, logo $n-(K-1)=n-K+1$ graus de liberdade nos resíduos. $H_0$ zera as $J=K-2$ inclinações. Pela forma $R^2$ do teste F (D05.12, ex. 27), com $J=K-2$: *[D05.12]*

$$
F_k=\frac{R_k^2/(K-2)}{(1-R_k^2)/(n-K+1)}\ \overset{H_0}{\sim}\ F(K-2,\ n-K+1).
$$

É exatamente o "F-statistic" impresso no output da auxiliar. No ex. 54, $K=4$: $F\sim F(2,n-3)$.

2. **Decisão e conclusão.** Rejeita-se $H_0$ se $F_k>F_{\text{crít}}$ (ou $p\lt\alpha$): $x_k$ é colinear com os demais. Complementa-se com a magnitude: $\mathrm{VIF}_k=1/(1-R_k^2)$ (alto se $>10$) e a regra de Klein (preocupante se $R_k^2$ supera o $R^2$ da regressão principal).

3. **Cota inferior.** O $R^2$ da regressão de $x_k$ em $(\iota,x_j)$ é $r_{kj}^2$. Acrescentar regressores nunca reduz o $R^2$ (a SQR da regressão maior é mínima sobre um conjunto maior; D05.4). Logo $R_k^2\ge r_{kj}^2$ para cada $j$ e, como $1/(1-R^2)$ é crescente: *[D05.4; monotonicidade]*

$$
\boxed{\mathrm{VIF}_k=\frac{1}{1-R_k^2}\ \ge\ \max_{j\neq k}\frac{1}{1-r_{kj}^2}}
$$

4. **Correlações por pares moderadas não descartam colinearidade forte.** Contraexemplo populacional: $x_1,x_2$ independentes com variância 1 e $x_3=x_1+x_2+u$, $\operatorname{Var}(u)=0{,}02$. Então $r_{12}=0$ e $r_{13}=r_{23}=1/\sqrt{2{,}02}$, mas $x_3$ é quase combinação exata de $x_1$ e $x_2$: $R_3^2=2/2{,}02$ e $\mathrm{VIF}_3=101$. *[Var de soma de independentes]*

> [!WARNING]
> **O F da auxiliar mede significância, não gravidade**
> Com $n$ grande, qualquer correlação pequena gera $F$ significativo. O que importa para a variância é a magnitude de $R_k^2$ (D06.9). Na prova, conclua pelo teste **e** comente o VIF. E o $F$ só tem distribuição $F$ exata tratando os outros regressores como fixos e o erro da auxiliar como normal: é um diagnóstico, não um teste de hipótese do modelo.

<!-- conferência numérica: valores conferidos contra resultados/*.csv pelo scripts/check_numbers.R — (seção F: auxiliar de $X_1$ nos dados de cabos do ex. 38/39, $n=16$, $K=6$; seção G: contraexemplo)
| chave_R | nota |
|---|---|
| m06_ex54_r2aux | 0,8315 |
| m06_ex54_gl1 | 4 |
| m06_ex54_gl2 | 11 |
| m06_ex54_faux | 13,57 |
| m06_ex54_paux | 0,00031 |
| m06_ex54_fcrit10 | 2,536 |
| m06_ex54_fiv_x1 | 5,935 |
| m06_ex54_r2_modelo | 0,8253 |
| m06_ex64_contra_r13 | 0,704 |
| m06_ex64_contra_fivpar_max | 1,980 |
| m06_ex64_contra_fiv_x3 | 101 |
-->

### D06.13 · Componentes principais

> [!NOTE]
> **O que se quer provar**
> Com $\mathbf X$ em desvios da média (ou padronizado), $n\times K$, a combinação $z=Xp$ com $p'p=1$ que maximiza a variação $\mathbf z'\mathbf z$ tem $p$ igual ao autovetor do maior autovalor $\lambda_1$ de $\mathbf X'\mathbf X$, e $\mathbf z'\mathbf z=\lambda_1$. As componentes $\mathbf Z=\mathbf X\mathbf C$ ($\mathbf C$ = autovetores) têm colunas ortogonais.

**Por que importa.** É o remédio do SL06 (p. 56–60) para regressores colineares de "identidade ambígua": trocar vários regressores por poucas combinações que carregam quase toda a variação.

**Passo a passo.**

1. Lagrangiano $\mathcal{L}=p'\mathbf X'Xp-\lambda(p'p-1)$. Condição de 1ª ordem, com $\mathbf X'\mathbf X$ simétrica: *[derivada de forma quadrática, D13]*

$$
\frac{\partial\mathcal{L}}{\partial p}=2\mathbf X'Xp-2\lambda p=0\ \Longrightarrow\ \mathbf X'Xp=\lambda p .
$$

2. Logo $p$ é autovetor e $\mathbf z'\mathbf z=p'\mathbf X'Xp=\lambda p'p=\lambda$: o máximo é o maior autovalor $\lambda_1$. *[passo 1; $p'p=1$]*
3. Com $\mathbf C$ ortogonal de autovetores, $\mathbf Z'\mathbf Z=\mathbf C'\mathbf X'\mathbf X\mathbf C=\Lambda$, diagonal: as componentes são ortogonais. *[decomposição espectral]*
4. Regredir $\mathbf y$ nas $m\lt K$ primeiras componentes equivale a impor que as combinações das componentes descartadas têm coeficiente zero: ganha-se precisão, perde-se ajuste, e há **viés** se a restrição for falsa. Os coeficientes deixam de ter interpretação direta por variável.

<!-- conferência numérica: valores conferidos contra resultados/*.csv pelo scripts/check_numbers.R — (seção I: dois regressores padronizados com correlação 0,9864)
| chave_R | nota |
|---|---|
| m06_out_pc_autoval1 | 1,9864 |
| m06_out_pc_autoval2 | 0,0136 |
| m06_out_pc_share1 | 0,9932 |
| m06_out_pc_t | 5,224 |
| m06_out_pc_r2 | 0,418 |
-->

## 3. Como cai na prova

A P1 é metade derivação e metade interpretação de output. Este módulo alimenta as duas.

| Formato | O que pedem | Onde está | Tempo-alvo |
|---|---|---|---|
| Derivação | $\operatorname{Var}(\mathbf b\mid \mathbf X)=\sigma^2(\mathbf X'\mathbf X)^{-1}$ (P1 2025/2, Q5; ex. 26) | D06.3 | 8 min |
| Derivação | Gauss-Markov com $\mathbf b^*=[(\mathbf X'\mathbf X)^{-1}\mathbf X'+\mathbf C]\mathbf y$ (ex. 33) | D06.5 | 12 min |
| Derivação | $E(s^2)=\sigma^2$ pelo traço | D06.6, D06.7 | 10 min |
| Derivação | Não-viés, condicional e incondicional (ex. 24) | D06.2 | 4 min |
| Conceitual | Qual hipótese cai com uma matriz $E(\varepsilon\varepsilon'\mid X)$ dada (ex. 32, 36, 37) | D06.4 | 4 min |
| Conceitual | Excluir variável colinear (ex. 53); passos da auxiliar (ex. 54) | D06.10, D06.12 | 6 min cada |
| Output | Matriz de correlação, VIF por pares (ex. 63, 64) | D06.9, D06.12 | 5 min |
| Output | Tabela MQO com F significativo e t's não significativos; auxiliar com F (ex. 39k) | seção 4 | 6 min |

> [!TIP]
> **Como escrever na prova**
> - Derivação: (1) escreva as hipóteses que vai usar, com o nome; (2) comece de $\mathbf b=\beta+(\mathbf X'\mathbf X)^{-1}\mathbf X'\varepsilon$; (3) em cada linha, diga a regra (linearidade de $E$, $\operatorname{Var}(\mathbf A\varepsilon)=\mathbf A\operatorname{Var}(\varepsilon)\mathbf A'$, traço, [H2], [H4]); (4) indique a dimensão das matrizes pelo menos uma vez; (5) feche com o resultado em caixa e uma frase de interpretação.
> - Multicolinearidade: sempre diga que **não** viola hipótese (se não for perfeita), que $\mathbf b$ continua BLUE e que o custo é variância.
> - Teste: as quatro linhas de [CONVENCOES.md](../CONVENCOES.md) §11, decidindo pelo número impresso no enunciado.

## 4. Interpretação de output

Output **ilustrativo** gerado pela seção I do script (dados simulados: $\beta_2=\beta_3=0{,}6$, correlação populacional 0,98 entre $X_2$ e $X_3$). Diagramado como as tabelas da Lista 1 v.1; a coluna "Estatística $t$" é o $b/ep$ do NLOGIT.

| Variável | Coeficiente | Erro padrão | Estatística $t$ | Prob. | Média de $X$ |
|---|---|---|---|---|---|
| C | 0,63658 | 1,11673 | 0,570 | 0,5721 | |
| X2 | −0,72652 | 1,36199 | −0,533 | 0,5969 | 4,80961 |
| X3 | 1,95699 | 1,40467 | 1,393 | 0,1719 | 4,75743 |

$n=40$ · $K=3$ · $R^2=0{,}43233$ · $\bar R^2=0{,}40164$ · $SQR=62{,}03689$ · erro-padrão da regressão $=1{,}29486$ · $F(2,37)=14{,}089$ (Prob. $=0{,}0000$) · média de $Y=6{,}45252$.

**(a) Significância individual de $X_2$** ($\alpha=5\%$, $t_{0{,}025;37}=2{,}026$)

- **Hipóteses:** $H_0:\beta_2=0$ vs. $H_1:\beta_2\neq 0$.
- **Estatística:** $t_{cal}=-0{,}533$, com 37 graus de liberdade.
- **Decisão:** como $\lvert t_{cal}\rvert=0{,}533<t_{tab}=2{,}026$, não se rejeita $H_0$ ($p=0{,}5969>0{,}05$).
- **Conclusão:** X2 não é individualmente significativo.

**(b) Significância individual de $X_3$**

- **Hipóteses:** $H_0:\beta_3=0$ vs. $H_1:\beta_3\neq 0$.
- **Estatística:** $t_{cal}=1{,}393$, com 37 graus de liberdade.
- **Decisão:** como $t_{cal}=1{,}393<t_{tab}=2{,}026$, não se rejeita $H_0$ ($p=0{,}1719>0{,}05$).
- **Conclusão:** X3 não é individualmente significativo.

**(c) Significância conjunta** ($F_{0{,}05;2;37}=3{,}252$)

- **Hipóteses:** $H_0:\beta_2=\beta_3=0$ vs. $H_1$: pelo menos um $\neq 0$.
- **Estatística:** $F_{cal}=14{,}089$, com $q=2$ e $n-K=37$ graus de liberdade.
- **Decisão:** como $F_{cal}=14{,}089>F_{tab}(2,37)=3{,}252$, rejeita-se $H_0$ ao nível de 5% ($p=0{,}0000$).
- **Conclusão:** X2 e X3 são conjuntamente significativos — embora nenhum dos dois o seja isoladamente: a assinatura da multicolinearidade.

**(d) Diagnóstico.** F rejeita, nenhum t rejeita, e $b_2$ tem sinal negativo onde a teoria esperaria positivo: é o quadro típico de multicolinearidade. A correlação amostral entre $X_2$ e $X_3$ é 0,9864; com dois regressores o VIF é $1/(1-r^2)=37{,}11>10$. Pela D06.9, $\operatorname{Corr}(b_2,b_3\mid X)=-r_{23}=-0{,}9864$: quando $b_2$ sai baixo, $b_3$ sai alto, e é isso que produz o sinal "errado".

**(e) O que os dados identificam.** A soma $b_2+b_3=1{,}2305$ tem erro-padrão $\sqrt{\widehat{\operatorname{Var}}(b_2)+\widehat{\operatorname{Var}}(b_3)+2\widehat{\operatorname{Cov}}(b_2,b_3)}=0{,}2318$, e $t=5{,}308$: o efeito conjunto é preciso; a divisão entre $X_2$ e $X_3$ é que não é. Os remédios: (i) informação externa (restrição como $\beta_2=\beta_3$, MQ restrito, módulo 05); (ii) componentes principais: a regressão de $Y$ na 1ª componente tem $t=5{,}224$ e $R^2=0{,}418$, quase o mesmo ajuste com um só regressor; (iii) excluir $X_3$: a regressão curta dá $b_2=1{,}1453$ com erro-padrão 0,2263, preciso mas viesado, pois estima $\beta_2$ mais o efeito de $X_3$ que passa por $X_2$ (D06.10).

<!-- conferência numérica: valores conferidos contra resultados/*.csv pelo scripts/check_numbers.R
| chave_R | nota |
|---|---|
| m06_out_b1 | 0,6366 |
| m06_out_se1 | 1,1167 |
| m06_out_b2 | -0,7265 |
| m06_out_se2 | 1,3620 |
| m06_out_t2 | -0,533 |
| m06_out_p2 | 0,5969 |
| m06_out_b3 | 1,9570 |
| m06_out_se3 | 1,4047 |
| m06_out_t3 | 1,393 |
| m06_out_p3 | 0,1719 |
| m06_out_r2 | 0,4323 |
| m06_out_r2adj | 0,4016 |
| m06_out_ssr | 62,037 |
| m06_out_se_e | 1,2949 |
| m06_out_f | 14,089 |
| m06_out_pf | 0,00003 |
| m06_out_tcrit5 | 2,026 |
| m06_out_fcrit5 | 3,252 |
| m06_out_r23 | 0,9864 |
| m06_out_fiv | 37,11 |
| m06_out_corr_b2b3 | -0,9864 |
| m06_out_soma_b | 1,2305 |
| m06_out_se_soma | 0,2318 |
| m06_out_t_soma | 5,308 |
| m06_out_curta_b2 | 1,1453 |
| m06_out_curta_se2 | 0,2263 |
-->

## 5. Armadilhas

> [!WARNING]
> **$E(\cdot\mid X)$ não é $E(\cdot)$**
> $E(\mathbf b\mid \mathbf X)=\beta$ e $\operatorname{Var}(\mathbf b\mid \mathbf X)=\sigma^2(\mathbf X'\mathbf X)^{-1}$ são condicionais. O incondicional sai por expectativas iteradas e pela lei da variância total (D06.2, D06.3). $\operatorname{Var}(\mathbf b)=\sigma^2E((\mathbf X'\mathbf X)^{-1})$, **não** $\sigma^2[E(\mathbf X'\mathbf X)]^{-1}$.

> [!WARNING]
> **Graus de liberdade**
> $s^2=\mathbf e'\mathbf e/(n-K)$ com $K$ contando a constante. Dividir por $n$ dá estimador viesado para baixo. Dividir por $n-K$ torna $s^2$ não viesado, mas $s$ continua viesado para $\sigma$ (D06.7).

> [!WARNING]
> **Gauss-Markov**
> (i) Não usa normalidade. (ii) Só compara com lineares **não viesados**. (iii) O não-viés tem de valer **para todo** $\beta$; é isso que obriga $CX=0$. (iv) "Menor variância" entre matrizes significa diferença positiva semidefinida, não "cada elemento menor".

> [!WARNING]
> **Heterocedasticidade e autocorrelação não viesam $\mathbf b$**
> Elas tornam $s^2(\mathbf X'\mathbf X)^{-1}$ um estimador errado da variância e tiram a eficiência (D06.4). O estimador continua não viesado se [H2] vale.

> [!WARNING]
> **Multicolinearidade**
> - Não viola nenhuma hipótese quando não é perfeita, e $b$ continua BLUE (D06.11).
> - Correlação por pares baixa não descarta colinearidade entre três ou mais variáveis; o VIF por pares é só cota inferior (D06.12).
> - VIF $>10$ e $\lvert r\rvert>0{,}8$ são regras de bolso, não testes.
> - Uma matriz de correlação precisa ser positiva semidefinida. A do ex. 64 **não é** (determinante negativo): ver [06_lista1.md](06_lista1.md).

> [!CAUTION]
> **Números que mudam entre versões e erros de impressão**
> - Ex. 63: a matriz impressa não é simétrica (0,88725 acima da diagonal e 0,88720 abaixo). A diferença não muda nada.
> - Ex. 39k (módulo 07): a chave calcula o F da auxiliar com gl (3, 12); o correto é (4, 11), que reproduz o "F-statistic" 13,57 do próprio output. A conclusão (rejeitar) não muda.

## 6. Checklist

- [ ] Escrevo $\mathbf b=\beta+(\mathbf X'\mathbf X)^{-1}\mathbf X'\varepsilon$ e digo que é linear sem usar H2, H4, H5.
- [ ] Provo $E(b\mid X)=\beta$ e passo para $E(b)=\beta$ pela lei das expectativas iteradas.
- [ ] Deduzo $\operatorname{Var}(\mathbf b\mid \mathbf X)=\sigma^2(\mathbf X'\mathbf X)^{-1}$ com as dimensões e $\operatorname{Var}(\mathbf b)=\sigma^2E((\mathbf X'\mathbf X)^{-1})$.
- [ ] Explico cada elemento de $E(\varepsilon\varepsilon'\mid X)$ e digo qual hipótese cai em cada padrão.
- [ ] Faço Gauss-Markov com $\mathbf C$: necessidade de $\mathbf C\mathbf X=0$, termos cruzados nulos, $\mathbf C\mathbf C'\succeq0$.
- [ ] Mostro $\operatorname{tr}(\mathbf M)=n-K$ e $E(\mathbf e'\mathbf e\mid \mathbf X)=\sigma^2(n-K)$ pelo traço.
- [ ] Sei por que $(n-K)s^2/\sigma^2\sim\chi^2(n-K)$ e por que $\mathbf b$ e $s^2$ são independentes sob [H5].
- [ ] Deduzo $\operatorname{Var}(b_k\mid X)=\sigma^2/[(1-R_k^2)S_{kk}]$ por FWL e defino o VIF.
- [ ] Comparo regressão curta e longa por viés, variância e EQM ($\lvert\tau\rvert\lt1$).
- [ ] Monto os passos da regressão auxiliar: equação, $H_0$, $F(K-2,n-K+1)$, decisão, VIF.
- [ ] Leio uma tabela com F significativo e t's não significativos e digo o que fazer.

## 7. Referências

- GREENE, W. H. *Econometric Analysis*. 8ª ed., 2017: cap. 4 (propriedades de amostra finita do MQO, Gauss-Markov, estimação de $\sigma^2$, normalidade, multicolinearidade, Tabela 4.9 com os dados de Longley, componentes principais, pré-teste); Teorema 3.4 (elemento diagonal da inversa). Apêndices: A.5.3 (inversa particionada), A.7.2 (formas quadráticas idempotentes), B.11 (normal multivariada; Teoremas B.8 e B.9).
- HAYASHI, F. *Econometrics*, 2000: §1.1 (hipóteses; erros esféricos a partir de amostragem aleatória), §1.3 (propriedades de amostra finita, Gauss-Markov, $E(s^2)$).
- WOOLDRIDGE, J. M. *Introductory Econometrics*, 5ª ed.: cap. 3 (componentes da variância dos estimadores, VIF, variável omitida e irrelevante).
- Slides SL06 (Prof. Edson Zambon Monte, a partir do curso do Greene na NYU): p. 3–13 (contexto amostral), 21–26 (variância e erros de especificação), 30–35 (Gauss-Markov, distribuição), 36–42 ($s^2$ e traço), 48–60 (multicolinearidade, Longley, número de condição, componentes principais).
- Lista 1, ex. 26, 32, 33, 36, 37, 53, 54, 63 e 64: resolução em [06_lista1.md](06_lista1.md).
- Núcleo do aluno: D9, D14, D15 e D16 em [demonstracoes/econometria-i-demonstracoes-mes-1-1.md](../demonstracoes/econometria-i-demonstracoes-mes-1-1.md).
