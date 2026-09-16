---
title: "Módulo 04 — Regressão particionada e Frisch-Waugh-Lovell (teoria)"
modulo: "04"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
greene: "cap. 3 (§3.3–3.5)"
slides: "SL04"
lista1: [25]
relevancia_p1: media
status: rascunho
verificacao:
  derivacao: pendente
  numerica: ok
  chave: pendente
tags:
  - econometria
  - mestrado/ppgeco
  - p1
aliases:
  - Frisch-Waugh-Lovell
  - Regressão particionada
---

# Módulo 04 — Regressão particionada e Frisch-Waugh-Lovell

## 0. Mapa

> [!NOTE]
> **O que é, por que importa, onde cai**
> O que exatamente significa "o efeito de $X_2$ **mantidas constantes** as demais variáveis"? O teorema de Frisch-Waugh-Lovell responde com precisão algébrica: o coeficiente de $X_2$ na regressão múltipla é o coeficiente da regressão simples entre as **partes de $y$ e de $X_2$ que as outras variáveis não explicam**. Dessa mesma álgebra saem o viés de omissão em forma matricial (ex. 25), a fórmula da variância com FIV, a correlação parcial, os efeitos fixos e a transformação within do painel.

## 1. Notação

Particione os regressores: $X=[X_1\ \ X_2]$, com $X_1$ de dimensão $n\times K_1$ e $X_2$ de $n\times K_2$. O modelo é
$$y=X_1\beta_1+X_2\beta_2+\varepsilon,$$
e a estimação dá $y=X_1b_1+X_2b_2+e$. Defina a matriz geradora de resíduos do primeiro bloco:
$$M_1=I-X_1(X_1'X_1)^{-1}X_1',$$
simétrica, idempotente, com $M_1X_1=0$. Ela "limpa" de qualquer vetor a parte explicada por $X_1$.

## 2. Demonstrações

### D04.1 · A solução particionada

Escreva as equações normais $X'Xb=X'y$ em blocos:
$$\begin{pmatrix}X_1'X_1&X_1'X_2\\X_2'X_1&X_2'X_2\end{pmatrix}\begin{pmatrix}b_1\\b_2\end{pmatrix}=\begin{pmatrix}X_1'y\\X_2'y\end{pmatrix}.$$

Da primeira linha, isolando $b_1$:
$$b_1=(X_1'X_1)^{-1}X_1'(y-X_2b_2). \tag{D04.1a}$$

**Leitura.** $b_1$ é o coeficiente da regressão de $X_1$ sobre o que sobra de $y$ depois de tirar a contribuição de $X_2$. Se $X_1'X_2=0$ (blocos ortogonais), $b_1=(X_1'X_1)^{-1}X_1'y$: cada bloco pode ser estimado isoladamente.

### D04.2 · O teorema de Frisch-Waugh-Lovell

> [!NOTE]
> **O que se quer provar**
> $$b_2=\big(X_2'M_1X_2\big)^{-1}X_2'M_1y,$$
> isto é, $b_2$ é o estimador da regressão de $M_1y$ (resíduo de $y$ em $X_1$) em $M_1X_2$ (resíduo de $X_2$ em $X_1$). Além disso, os resíduos das duas regressões são **idênticos**.

**Passo a passo.**

1. Substitua (D04.1a) na segunda linha das equações normais:
$$X_2'X_1\Big[(X_1'X_1)^{-1}X_1'(y-X_2b_2)\Big]+X_2'X_2b_2=X_2'y.$$

2. Reagrupe os termos em $b_2$:
$$X_2'\Big[X_2-X_1(X_1'X_1)^{-1}X_1'X_2\Big]b_2=X_2'\Big[y-X_1(X_1'X_1)^{-1}X_1'y\Big],$$
ou seja, $X_2'M_1X_2\,b_2=X_2'M_1y$.

3. Como $M_1$ é idempotente e simétrica, $X_2'M_1X_2=(M_1X_2)'(M_1X_2)$ e $X_2'M_1y=(M_1X_2)'(M_1y)$. Com posto completo,
$$b_2=\big[(M_1X_2)'(M_1X_2)\big]^{-1}(M_1X_2)'(M_1y). \qquad\blacksquare$$

4. **Resíduos idênticos:** como $e=M_1y-M_1X_2b_2$ já é ortogonal a $X_1$ e a $X_2$, é também o resíduo da regressão original.

> [!TIP]
> **Basta limpar um dos dois**
> Regredir $M_1y$ em $M_1X_2$, ou $y$ **cru** em $M_1X_2$, dá o mesmo $b_2$ (mudam os resíduos, não o coeficiente): a limpeza de $X_2$ é o que importa. Já regredir $M_1y$ em $X_2$ **cru** dá outra coisa. Verificado: $0{,}0611277$ nos dois primeiros casos, contra $0{,}0343783$ no terceiro.

**Verificação numérica** (equação de salários de Cornwell-Rupert, `AER::PSID7682`, $n=4165$, $K=10$): o coeficiente de educação na regressão múltipla é 0,0611277; via FWL, o mesmo até $3{,}5\times 10^{-15}$, com resíduos idênticos até $7{,}5\times 10^{-13}$.

> [!WARNING]
> **Erro-padrão pede correção de graus de liberdade**
> A regressão auxiliar "pensa" que estimou 1 parâmetro, não $K$. O erro-padrão ingênuo sai 0,00276926 contra o correto 0,00277226 — fator $\sqrt{(n-1)/(n-K)}=1{,}00108$. Coeficiente igual, inferência não.

### D04.3 · Incluir constante é centrar as variáveis

Faça $X_1=\iota$ (só a constante). Então
$$M_1=M^0=I-\tfrac1n\iota\iota',$$
que subtrai a média de cada coluna. Logo, regredir $y$ em $\iota$ e $X_2$ dá o mesmo $b_2$ que regredir $y$ centrado em $X_2$ centrado — a justificativa algébrica do "modelo em desvios" do ex. 22 ([módulo 02](../02_mqo_simples/02_lista1.md)).

### D04.4 · Viés de omissão em forma matricial (ex. 25)

> [!NOTE]
> **O que se quer provar**
> Se o modelo verdadeiro é $y=X_1\beta_1+X_2\beta_2+\varepsilon$ mas estima-se $\hat y=X_1b_1$ com $b_1=(X_1'X_1)^{-1}X_1'y$, então
> $$E[b_1\mid X]=\beta_1+\underbrace{(X_1'X_1)^{-1}X_1'X_2}_{P_{12}}\,\beta_2 .$$

**Passo a passo.**

1. Substitua o modelo verdadeiro no estimador curto:
$$b_1=(X_1'X_1)^{-1}X_1'\big(X_1\beta_1+X_2\beta_2+\varepsilon\big)=\beta_1+(X_1'X_1)^{-1}X_1'X_2\beta_2+(X_1'X_1)^{-1}X_1'\varepsilon .$$

2. Tome a esperança condicional e use $E[\varepsilon\mid X]=0$ *[A3]*:
$$E[b_1\mid X]=\beta_1+(X_1'X_1)^{-1}X_1'X_2\,\beta_2 .\qquad\blacksquare$$

3. **Viés** $=P_{12}\beta_2$, em que $P_{12}$ é a matriz de coeficientes das regressões auxiliares de cada coluna de $X_2$ sobre $X_1$.

**Quando some:** se $\beta_2=0$ (bloco irrelevante) ou se $X_1'X_2=0$ (blocos ortogonais). No caso escalar, reduz-se a $\beta_3\hat\delta$ do ex. 15.

### D04.5 · Variância, FIV e correlação parcial

Do bloco (2,2) da inversa particionada,
$$\big[(X'X)^{-1}\big]_{22}=\big(X_2'M_1X_2\big)^{-1},$$
logo, para um regressor escalar $x_k$,
$$\operatorname{Var}(b_k\mid X)=\frac{\sigma^2}{x_k'M_{-k}x_k}=\frac{\sigma^2}{(1-R_k^2)\,S_{kk}},$$
com $R_k^2$ da regressão auxiliar de $x_k$ nos demais e $FIV_k=1/(1-R_k^2)$. Verificado: o bloco (2,2) da inversa é $5{,}49363\times 10^{-5}$, exatamente $1/(x'M_1x)$, com $R^2_{aux}=0{,}437599$, $FIV=1{,}77809$ e o erro-padrão reconstruído pela fórmula igual ao do software.

A mesma álgebra dá a **correlação parcial**:
$$r^2_{yx_k\mid \text{demais}}=\frac{t_k^2}{t_k^2+(n-K)},$$
e a queda relativa na soma de quadrados ao acrescentar o regressor. Verificado: $r^2$ parcial da educação igual a 0,104756 pelas três vias (fórmula do $t$, definição via resíduos e via $R^2$), com $R^2$ subindo de 0,267917 para 0,344607 e o $SQR$ caindo 68,0168.

### D04.6 · Efeitos fixos: within é FWL

Com dados de painel e um efeito fixo por unidade, $X_1$ é o conjunto de dummies de unidade. Aplicar FWL significa **tirar a média de cada unidade** de $y$ e de $X_2$ (transformação within) e rodar MQO nas variáveis centradas — que é exatamente o estimador de efeitos fixos. Isso explica por que:

- o estimador within é idêntico ao LSDV (mínimos quadrados com dummies), sem precisar estimar $N$ dummies;
- regressores **invariantes no tempo** desaparecem: $M_1$ os zera, então seus efeitos não são identificáveis — a mesma lição do DiD com controles fixos ([did.md](../09_dummies_forma_funcional/did.md), ex. 72);
- os graus de liberdade corretos descontam as $N$ dummies, ainda que elas nunca apareçam na regressão within.

Aprofundamento na P2: [módulo 12](../12_painel_I/README.md).

## 3. Como cai na prova

| Formato | O que fazer |
|---|---|
| "Prove que $b_1$ é viesado" (ex. 25) | D04.4 em três linhas, terminando no viés $P_{12}\beta_2$ e nas condições de anulação. |
| "O que significa controlar por outras variáveis?" | FWL: o coeficiente é a regressão entre as partes não explicadas pelas demais. |
| "Como se relacionam efeitos fixos e FWL?" | D04.6: within é FWL com dummies de unidade. |
| "De onde vem o FIV na variância?" | D04.5, pelo bloco da inversa particionada. |

## 4. Armadilhas

> [!WARNING]
> **Três erros comuns**
> 1. Limpar $y$ e esquecer de limpar $X_2$ (ou vice-versa): só a limpeza de $X_2$ garante o mesmo coeficiente.
> 2. Reportar o erro-padrão da regressão auxiliar sem corrigir os graus de liberdade.
> 3. Achar que FWL é aproximação. É identidade algébrica exata, válida amostra a amostra, sem hipótese estatística nenhuma.

## 5. Checklist

- [ ] Derivo FWL (D04.2) a partir das equações normais particionadas.
- [ ] Escrevo o viés de omissão matricial (D04.4) e digo quando ele é zero.
- [ ] Explico a fórmula da variância com $1-R_k^2$ e o FIV (D04.5).
- [ ] Explico por que within é FWL e por que variáveis fixas no tempo somem.

## 6. Conferência numérica

| chave_R | nota |
|---|---|
| m04_psid_b_ed | 0,0611277 |
| m04_fwl_b_ed | 0,0611277 |
| m04_fwl_b_xcru | 0,0343783 |
| m04_fwl_se_ingenuo | 0,00276926 |
| m04_fwl_se_corrigido | 0,00277226 |
| m04_fwl_fator_gl | 1,00108 |
| m04_inv_bloco22 | 0,0000549363 |
| m04_var_r2_aux | 0,437599 |
| m04_var_fiv | 1,77809 |
| m04_pc_r2_parcial | 0,104756 |
| m04_pc_r2_curta | 0,267917 |
| m04_pc_r2_longa | 0,344607 |
| m04_pc_queda_ssr | 68,0168 |

## 7. Referências

- Greene, *Econometric Analysis*, §3.3 (regressão particionada), §3.4 (FWL), §3.5 (correlação parcial).
- Slides SL04, incluindo a aplicação a efeitos fixos.
- Exercício resolvido: [04_lista1.md](04_lista1.md), ex. 25.
