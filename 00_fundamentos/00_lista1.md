---
title: "Módulo 00 — Lista 1 resolvida (ex. 1–9)"
modulo: "00"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
greene: "apêndices B, C e D"
lista1: [1, 2, 3, 4, 5, 6, 7, 8, 9]
relevancia_p1: media
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
  - Fundamentos — Lista 1
---

# Módulo 00 — Lista 1 resolvida (ex. 1–9)

Nove demonstrações curtas que são a caixa de ferramentas do curso inteiro. Teoria em [00_teoria.md](00_teoria.md); verificações em [00_fundamentos.R](00_fundamentos.R).

---

## Ex. 1 — $\operatorname{Var}(aX)=a^2\operatorname{Var}(X)$

**Tipo:** derivação · **Chave:** ➖

$$\operatorname{Var}(aX)=E\big[(aX-E[aX])^2\big]=E\big[(aX-aE[X])^2\big]=E\big[a^2(X-E[X])^2\big]=a^2\operatorname{Var}(X).$$

A constante sai **ao quadrado** porque a definição de variância é quadrática. Consequência prática: mudar a unidade de medida de $X$ (de reais para milhares de reais) divide a variância por $1000^2$.

## Ex. 2 — Esperança e variância da média amostral

**Tipo:** derivação · **Chave:** ➖ · **Cai como:** aquecimento da Q5

Com $X_1,\dots,X_n$ independentes, todas com média $\mu$ e variância $\sigma^2$, e $\bar X=\frac1n\sum_i X_i$:

$$E[\bar X]=\frac1n\sum_{i=1}^n E[X_i]=\frac{n\mu}{n}=\mu \qquad \text{(só linearidade; independência não é necessária)}$$

$$\operatorname{Var}(\bar X)=\frac{1}{n^2}\operatorname{Var}\Big(\sum_i X_i\Big)=\frac{1}{n^2}\sum_i\operatorname{Var}(X_i)=\frac{n\sigma^2}{n^2}=\frac{\sigma^2}{n}$$

Aqui a independência **é** necessária: ela zera as covariâncias cruzadas.

**Verificação** (20 mil amostras, $\mu=2$, $\sigma^2=4$):

| $n$ | Variância simulada | $\sigma^2/n$ |
|---|---|---|
| 5 | 0,80493 | 0,8 |
| 100 | 0,039688 | 0,04 |
| 500 | 0,0079795 | 0,008 |

**Conferência numérica**

| chave_R | nota |
|---|---|
| m00_ex2_var_n5 | 0,80493 |
| m00_ex2_varteo_n5 | 0,8 |
| m00_ex2_var_n500 | 0,0079795 |
| m00_ex2_varteo_n500 | 0,008 |

## Ex. 3 — A média amostral é consistente

**Tipo:** derivação · **Chave:** ➖ · **Cai como:** modelo da consistência do MQO

**Passo a passo.**

1. Do ex. 2: $E[\bar X]=\mu$ (não viesada) e $\operatorname{Var}(\bar X)=\sigma^2/n$.
2. Por Chebyshev, para qualquer $\delta\gt 0$:
$$\Pr\big(\lvert\bar X-\mu\rvert\ge\delta\big)\le\frac{\operatorname{Var}(\bar X)}{\delta^2}=\frac{\sigma^2}{n\delta^2}.$$
3. Quando $n\to\infty$, o lado direito vai a zero, logo a probabilidade também:
$$\operatorname{plim}\bar X=\mu .\qquad\blacksquare$$

**Verificação** com $\delta=0{,}5$ e $\sigma^2=4$: a frequência simulada de $\lvert\bar X-\mu\rvert\ge 0{,}5$ cai de 0,2513 ($n=20$) para 0,0125 ($n=100$) e 0 ($n=500$); o limite de Chebyshev é sempre mais folgado que o valor exato pelo TLC.

> [!TIP]
> **É o mesmo argumento da Q5**
> Trocando $\bar X$ por $X'\varepsilon/n$, essa é exatamente a prova de que o MQO é consistente ([módulo 08](../08_assintotica/08_teoria.md), D08.1). Aprenda aqui e reaproveite lá.

**Conferência numérica**

| chave_R | nota |
|---|---|
| m00_ex3_prob_n20 | 0,25125 |
| m00_ex3_cheb_n20 | 0,8 |
| m00_ex3_prob_n100 | 0,01245 |
| m00_ex3_tlc_n100 | 0,012419 |

## Ex. 4 — $\operatorname{Var}(X)=E[X^2]-\mu^2$

**Tipo:** derivação · **Chave:** ➖

$$\operatorname{Var}(X)=E\big[(X-\mu)^2\big]=E\big[X^2-2\mu X+\mu^2\big]=E[X^2]-2\mu E[X]+\mu^2=E[X^2]-\mu^2 .$$

O passo-chave é lembrar que $\mu=E[X]$ é **constante** e sai da esperança.

## Ex. 5 — $\operatorname{Cov}(X,Y)=E[XY]-\mu_x\mu_y$

**Tipo:** derivação · **Chave:** ➖

$$\operatorname{Cov}(X,Y)=E\big[(X-\mu_x)(Y-\mu_y)\big]=E[XY]-\mu_yE[X]-\mu_xE[Y]+\mu_x\mu_y=E[XY]-\mu_x\mu_y .$$

Mesma mecânica do ex. 4. Note que $\operatorname{Var}(X)=\operatorname{Cov}(X,X)$: as duas identidades são a mesma.

## Ex. 6 — Independência implica covariância zero

**Tipo:** derivação · **Chave:** ➖

Se $X$ e $Y$ são independentes, $f(x,y)=f(x)f(y)$ e a esperança do produto fatora:
$$E[XY]=\int\!\!\int xy\,f(x)f(y)\,dx\,dy=\Big(\int x f(x)dx\Big)\Big(\int y f(y)dy\Big)=E[X]E[Y].$$
Pelo ex. 5, $\operatorname{Cov}(X,Y)=E[XY]-E[X]E[Y]=0$. $\blacksquare$

## Ex. 7 — Covariância zero implica independência?

**Tipo:** conceitual · **Chave:** ✅ confere

**Não.** A covariância mede apenas associação **linear**. O contraexemplo padrão: $X$ simétrica em torno de zero (por exemplo, $-1$, $0$ e $1$ com probabilidades iguais) e $Y=X^2$. Então
$$E[XY]=E[X^3]=0,\qquad E[X]=0 \ \Longrightarrow\ \operatorname{Cov}(X,Y)=0,$$
mas $Y$ é **função determinística** de $X$: saber $X$ determina $Y$ por completo. Dependência perfeita, correlação nula.

Verificado no script: $E[X]=0$, $E[Y]=0{,}6667$, $E[XY]=0$, covariância 0, enquanto $\Pr(X=0,Y=0)=1/3\neq \Pr(X=0)\Pr(Y=0)=1/9$.

**A exceção.** Sob normalidade **conjunta**, covariância zero implica independência — é o que sustenta o argumento de independência entre $b$ e $s^2$ no [módulo 07](../07_testes_hipoteses/07_teoria.md), D07.1.

**Conferência numérica**

| chave_R | nota |
|---|---|
| m00_ex7_disc_EY | 0,66667 |
| m00_ex7_disc_cov | 0 |
| m00_ex7_disc_pconj | 0,33333 |

## Ex. 8 — A soma dos desvios em relação à média é zero

**Tipo:** derivação · **Chave:** ➖

$$\sum_{i=1}^n (X_i-\bar X)=\sum_i X_i-n\bar X=n\bar X-n\bar X=0,$$
usando $\sum_i X_i=n\bar X$, que é a própria definição de média.

É uma identidade **amostral** (vale sempre, sem hipótese nenhuma), e é ela que garante $\sum k_i=0$ nos pesos do MQO e $\sum\hat u_i=0$ nos resíduos.

## Ex. 9 — $EQM=\operatorname{Var}+\text{viés}^2$

**Tipo:** derivação · **Chave:** ➖ · **Cai como:** base da comparação entre estimadores

Some e subtraia $E[\hat\theta]$ dentro do quadrado:
$$EQM(\hat\theta)=E\big[(\hat\theta-\theta)^2\big]=E\Big[\big((\hat\theta-E[\hat\theta])+(E[\hat\theta]-\theta)\big)^2\Big].$$

Abrindo:
$$=\underbrace{E\big[(\hat\theta-E[\hat\theta])^2\big]}_{\operatorname{Var}(\hat\theta)}+\underbrace{\big(E[\hat\theta]-\theta\big)^2}_{\text{viés}^2}+2\big(E[\hat\theta]-\theta\big)\underbrace{E\big[\hat\theta-E[\hat\theta]\big]}_{=0}.$$

Logo $EQM(\hat\theta)=\operatorname{Var}(\hat\theta)+[\text{viés}(\hat\theta)]^2$. $\blacksquare$

> [!IMPORTANT]
> **Para que serve**
> É o critério que permite dizer que um estimador **viesado** pode ser preferível: se a redução de variância superar o quadrado do viés. É o argumento do ex. 53 ([módulo 06](../06_amostra_finita_multicol/06_lista1.md)) sobre excluir uma variável colinear — e a razão de "não viesado" não ser sinônimo de "melhor".
