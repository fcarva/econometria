---
title: "Módulo 08 — Assintótica (teoria)"
modulo: "08"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
greene: "cap. 4 (§4.4–4.5); apêndice D"
slides: "SL08"
lista1: [73]
relevancia_p1: alta
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
  - Assintótica
  - Teoria de grandes amostras
---

# Módulo 08 — Assintótica (teoria)

## 0. Mapa

> [!NOTE]
> **O que é, por que importa, onde cai**
> Não-viés e Gauss-Markov valem em amostra finita, mas exigem hipóteses fortes — e não dizem nada sobre o que acontece quando os dados aumentam. A assintótica troca exatidão por **robustez**: com $n\to\infty$, o MQO é consistente sem normalidade, e a inferência funciona com $z$ no lugar de $t$. Na P1, é a **Q5** (variância e consistência) e a justificativa da **Q1a** (por que não precisa de Jarque-Bera com $n=4165$).

O arco: $b$ é não viesado em amostra finita → é **consistente** quando $n$ cresce → é **assintoticamente normal** mesmo com erro não normal → logo os testes valem, com $\chi^2$ e $z$.

## 1. Notação e ferramentas

Modelo $y=X\beta+\varepsilon$. Duas hipóteses substituem a exogeneidade estrita e a normalidade:

| Id | Hipótese assintótica |
|---|---|
| G1 | $\operatorname{plim}\dfrac{X'X}{n}=Q$, finita e positiva definida (condições de Grenander: nenhuma observação domina, a variação de cada regressor cresce com $n$) |
| G2 | $\operatorname{plim}\dfrac{X'\varepsilon}{n}=0$ (ortogonalidade no limite; basta $E[x_i\varepsilon_i]=0$ mais LGN) |

**Convergência em probabilidade.** $x_n\xrightarrow{p}c$ se $\Pr(\lvert x_n-c\rvert\gt\delta)\to 0$ para todo $\delta\gt 0$. Escreve-se $\operatorname{plim}x_n=c$.

**Convergência em média quadrática** implica convergência em probabilidade: se $E[x_n]\to c$ e $\operatorname{Var}(x_n)\to 0$, então $\operatorname{plim}x_n=c$. É a rota mais curta nas provas, via desigualdade de Chebyshev:
$$\Pr\big(\lvert x_n-E[x_n]\rvert\ge\delta\big)\le\frac{\operatorname{Var}(x_n)}{\delta^2}.$$

**Regras do plim (Slutsky).** Para $g$ contínua, $\operatorname{plim}g(x_n)=g(\operatorname{plim}x_n)$; o plim da soma é a soma dos plims, o do produto é o produto, e o da inversa é a inversa (se não singular). É isso que permite separar $(X'X/n)^{-1}$ de $X'\varepsilon/n$ — coisa que a **esperança não permite**, e é exatamente por isso que existe a distinção entre não-viés e consistência.

**Lei dos grandes números (Khinchine).** Média de i.i.d. com média finita converge em probabilidade para a média populacional.

**Teorema do limite central (Lindeberg-Lévy).** Para i.i.d. com variância finita, $\sqrt n(\bar x_n-\mu)\xrightarrow{d}N(0,\sigma^2)$. A versão de Lindeberg-Feller dispensa a distribuição idêntica, exigindo que nenhuma parcela domine — é a que se aplica a $X'\varepsilon/\sqrt n$ com regressores heterogêneos.

## 2. Demonstrações

### D08.1 · Consistência do MQO

> [!NOTE]
> **O que se quer provar**
> Sob G1 e G2, $\operatorname{plim} b=\beta$.

**Por que importa.** É a Q5 da P1 2025/2. E é a propriedade que sobrevive quando o não-viés cai: em painéis dinâmicos, com defasagem da dependente, $b$ é viesado mas consistente.

**Passo a passo.**

1. Da identidade fundamental, dividindo numerador e denominador por $n$ — o truque assintótico:
$$b=\beta+(X'X)^{-1}X'\varepsilon=\beta+\left(\frac{X'X}{n}\right)^{-1}\left(\frac{X'\varepsilon}{n}\right).$$

2. Tome o plim e use a regra do produto:
$$\operatorname{plim}(b-\beta)=\left[\operatorname{plim}\frac{X'X}{n}\right]^{-1}\operatorname{plim}\frac{X'\varepsilon}{n}=Q^{-1}\cdot 0=0. \qquad [G1,\ G2]$$

3. Logo $\operatorname{plim}b=\beta$: $b$ é **consistente**. $\blacksquare$

**Por que $\operatorname{plim}(X'\varepsilon/n)=0$.** Com $X$ fixo (ou condicionando), o vetor $X'\varepsilon/n$ tem média zero *[A3]* e variância
$$\operatorname{Var}\left(\frac{X'\varepsilon}{n}\right)=\frac{\sigma^2}{n}\cdot\frac{X'X}{n}\ \longrightarrow\ \frac{\sigma^2}{n}Q\ \longrightarrow\ 0,$$
então converge em média quadrática para zero — e portanto em probabilidade. Este é o argumento que o gabarito do professor registra como "a variância vai a zero, logo o estimador é consistente".

> [!TIP]
> **Como o professor pode torcer**
> Pedir a consistência **pela variância**: não-viés mais $\operatorname{Var}(b\mid X)=\sigma^2(X'X)^{-1}=\frac{\sigma^2}{n}\left(\frac{X'X}{n}\right)^{-1}\to 0$ implica convergência em média quadrática. É condição suficiente, não necessária: há estimadores consistentes e viesados.

**Verificação numérica.** Simulação com $\beta_2=2$: a média de $\hat\beta_2$ fica em 2 e o desvio-padrão cai pela metade quando $n$ quadruplica, exatamente a taxa $\sqrt n$:

| $n$ | média de $\hat\beta_2$ | desvio-padrão |
|---|---|---|
| 25 | 2,0059 | 0,2075 |
| 100 | 2,0021 | 0,1041 |
| 400 | 1,9981 | 0,0508 |
| 1600 | 2,0022 | 0,0242 |

### D08.2 · Normalidade assintótica

> [!NOTE]
> **O que se quer provar**
> $\sqrt n\,(b-\beta)\xrightarrow{d}N\big(0,\ \sigma^2Q^{-1}\big)$, sem exigir A6.

**Passo a passo.**

1. Multiplique a identidade por $\sqrt n$:
$$\sqrt n\,(b-\beta)=\left(\frac{X'X}{n}\right)^{-1}\left(\frac{X'\varepsilon}{\sqrt n}\right).$$

2. O segundo fator é uma soma padronizada: $\dfrac{X'\varepsilon}{\sqrt n}=\dfrac{1}{\sqrt n}\sum_i x_i\varepsilon_i$, com parcelas de média zero *[A3]* e variância $\sigma^2 E[x_ix_i']$. Pelo TLC de Lindeberg-Feller,
$$\frac{X'\varepsilon}{\sqrt n}\ \xrightarrow{d}\ N(0,\ \sigma^2Q).$$

3. O primeiro fator converge em probabilidade para $Q^{-1}$ *[G1]*. Pelo teorema de Slutsky, matriz constante vezes normal é normal:
$$\sqrt n\,(b-\beta)\xrightarrow{d}Q^{-1}N(0,\sigma^2Q)=N\big(0,\ \sigma^2Q^{-1}Q\,Q^{-1}\big)=N\big(0,\sigma^2Q^{-1}\big).\qquad\blacksquare$$

Na prática: $b\ \dot\sim\ N\big(\beta,\ s^2(X'X)^{-1}\big)$, com a mesma matriz de sempre. Muda a **justificativa**, não a fórmula — e a distribuição de referência passa a ser $z$ e $\chi^2$.

**Verificação numérica.** Com erro exponencial (assimétrico), o tamanho empírico do teste a 5% converge para o nominal:

| $n$ | tamanho empírico a 5% | assimetria da estatística |
|---|---|---|
| 10 | 0,0775 | 0,1130 |
| 50 | 0,0610 | 0,0406 |
| 500 | 0,0440 | 0,0473 |

### D08.3 · Consistência de $s^2$

$s^2=\dfrac{e'e}{n-K}=\dfrac{\varepsilon'M\varepsilon}{n-K}$. Abrindo,
$$\frac{\varepsilon'M\varepsilon}{n}=\frac{\varepsilon'\varepsilon}{n}-\frac{\varepsilon'X}{n}\left(\frac{X'X}{n}\right)^{-1}\frac{X'\varepsilon}{n}.$$
O primeiro termo converge para $\sigma^2$ pela LGN; o segundo é $0\cdot Q^{-1}\cdot 0=0$ *[G2]*. Como $n/(n-K)\to 1$, segue $\operatorname{plim}s^2=\sigma^2$. Na simulação, com $\sigma^2=9$, a média de $s^2$ foi 8,9989 em $n=1600$.

### D08.4 · Método delta

> [!NOTE]
> **O que se quer provar**
> Se $\sqrt n(\hat\theta-\theta)\xrightarrow{d}N(0,\Sigma)$ e $g$ é continuamente diferenciável, então
> $$\sqrt n\big(g(\hat\theta)-g(\theta)\big)\xrightarrow{d}N\big(0,\ G\Sigma G'\big),\qquad G=\frac{\partial g}{\partial\theta'}.$$

**Passo a passo.** Expanda $g(\hat\theta)$ em Taylor de 1ª ordem em torno de $\theta$:
$$g(\hat\theta)=g(\theta)+G\,(\hat\theta-\theta)+\text{resto},$$
com o resto de ordem menor, que some assintoticamente porque $\hat\theta\xrightarrow{p}\theta$. Multiplicando por $\sqrt n$ e aplicando a distribuição de $\sqrt n(\hat\theta-\theta)$, a variância de uma combinação linear dá $G\Sigma G'$. $\blacksquare$

**Aplicação direta na prova.** O ponto de máximo do log-salário em relação à experiência é $X^*=-a_3/(2a_4)$, uma **função não linear** dos coeficientes. Gradiente:
$$\frac{\partial X^*}{\partial a_3}=-\frac{1}{2a_4},\qquad \frac{\partial X^*}{\partial a_4}=\frac{a_3}{2a_4^2}.$$
Com os dados de Cornwell-Rupert (`AER::PSID7682`), $a_3=0{,}0429166$, $a_4=-0{,}00070803$:
$$X^*=30{,}31\ \text{anos},\qquad \text{E.p.}(X^*)=0{,}7079,\qquad IC_{95\%}=[28{,}92;\ 31{,}69].$$
Um bootstrap de pares com 500 reamostras deu erro-padrão 0,7495, apenas 6% acima do método delta — os dois concordam.

> [!TIP]
> **Ponto de ouro na prova**
> A Q1c pede só o $X^*$. Se você acrescentar em uma linha que o erro-padrão sai pelo método delta, mostra domínio do que a maioria não escreve.

### D08.5 · Covariância robusta de White (HC0)

Sem A4, $\operatorname{Var}(b\mid X)=(X'X)^{-1}\big(X'\Omega X\big)(X'X)^{-1}$ com $\Omega$ desconhecida. White mostrou que não é preciso estimar as $n$ variâncias, só o "miolo":
$$\widehat{\operatorname{Var}}_{HC0}(b)=(X'X)^{-1}\left(\sum_{i=1}^n e_i^2\,x_ix_i'\right)(X'X)^{-1}.$$
O estimador é consistente para a matriz de covariância assintótica mesmo com heterocedasticidade de forma desconhecida. Variantes HC1 a HC3 corrigem para amostra pequena (HC1 multiplica por $n/(n-K)$).

**Verificação.** Calculado à mão, o erro-padrão robusto de $\hat\beta_2$ deu 0,0647462, idêntico ao `sandwich::vcovHC(type = "HC0")` (diferença máxima da matriz: $4\times10^{-16}$), e 6,9% maior que o erro-padrão de MQO — nesta amostra construída com heterocedasticidade, o MQO subestima a incerteza.

### D08.6 · Bootstrap de pares

Quando não há fórmula fechada, reamostre **pares** $(y_i,x_i)$ com reposição $B$ vezes, estime em cada reamostra e use o desvio-padrão das $B$ estimativas como erro-padrão. Preserva a relação entre $y$ e $x$ e é válido sob heterocedasticidade. É o que fizemos para $X^*$ acima.

## 3. Como cai na prova

| Formato | O que fazer |
|---|---|
| "Prove que o MQO é consistente" | D08.1 inteira: dividir por $n$, G1, G2, Slutsky. Duas linhas extras com a variância indo a zero garantem o ponto. |
| "Qual a diferença entre não-viés e consistência?" | Não-viés é amostra finita e vale para qualquer $n$; consistência é limite. Um pode existir sem o outro. |
| "Precisa de Jarque-Bera com $n$ grande?" | Não: pelo TLC, $b$ é assintoticamente normal; o JB importa na inferência exata em amostra pequena. |
| "Depois de quantos anos o salário atinge o máximo?" | $X^*=-a_3/(2a_4)$; se sobrar tempo, erro-padrão pelo método delta. |
| "O que fazer se houver heterocedasticidade?" | Erros-padrão robustos de White; MQO continua consistente, mas a variância usual está errada. |

## 4. Interpretação de output

Numa amostra grande, o output traz `P[|Z|>z]` em vez de `P[|t|>t]`: a coluna já é assintótica. Compare com 1,96 a 5% e 1,645 a 10%. O mesmo vale para os testes de diagnóstico: todos comparam $nR^2$ com $\chi^2$.

## 5. Armadilhas

> [!WARNING]
> **Quatro erros comuns**
> 1. Passar a esperança para dentro da razão: $E[(X'X)^{-1}X'\varepsilon]\neq E[(X'X)^{-1}]E[X'\varepsilon]$. O plim permite, a esperança não — é por isso que consistência é mais fácil que não-viés.
> 2. Esquecer de dividir por $n$ antes de tomar o plim: $X'X$ diverge, $X'X/n$ converge.
> 3. Dizer que consistência implica não-viés. Não implica (nem o contrário).
> 4. Usar $t$ tabelado numa estatística que é $\chi^2$ assintótica.

## 6. Checklist

- [ ] Derivo $\operatorname{plim}b=\beta$ (D08.1) em até 8 minutos, citando G1 e G2.
- [ ] Justifico $\operatorname{plim}(X'\varepsilon/n)=0$ pela variância indo a zero.
- [ ] Escrevo o esqueleto da normalidade assintótica (D08.2) com o papel do TLC e de Slutsky.
- [ ] Explico por que o JB é dispensável com $n$ grande.
- [ ] Calculo $X^*=-a_3/(2a_4)$ e sei dizer de onde sai seu erro-padrão.
- [ ] Escrevo a fórmula HC0 de memória.

## 7. Conferência numérica

| chave_R | nota |
|---|---|
| m08_consist_b2_n1600 | 2,0022 |
| m08_consist_dp_n25 | 0,20746 |
| m08_consist_dp_n1600 | 0,024172 |
| m08_consist_s2_n1600 | 8,9974 |
| m08_hc0_manual_b2 | 0,0647462 |
| m08_hc0_pacote_b2 | 0,0647462 |
| m08_razao_hc0_mqo | 1,0686 |
| m08_delta_exp_star | 30,3071 |
| m08_delta_ep | 0,70794 |
| m08_delta_ic_lo | 28,920 |
| m08_delta_ic_hi | 31,695 |
| m08_boot_ep | 0,74953 |
| m08_zassim_tam5pct_n10 | 0,0775 |
| m08_zassim_tam5pct_n500 | 0,0440 |

## 8. Referências

- Greene, *Econometric Analysis*, §4.4 (propriedades assintóticas), §4.5 (normalidade assintótica e método delta), apêndice D (modos de convergência, LGN, TLC).
- Hayashi, cap. 2, para a rota com condições de momento.
- Slides SL08: convergência, distribuição assintótica, matrizes robustas e bootstrap.
- Notas do caderno: [Aulas 1 e 2](../demonstracoes/Econometria_I_Aulas_1-2_Provas_Matematicas.md), Parte II.
- Exercício 73 resolvido em [08_lista1.md](08_lista1.md).
