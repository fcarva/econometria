---
title: "Algoritmo das resoluções — Lista 1 v.1"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
relevancia_p1: alta
status: verificado
tags:
  - econometria
  - mestrado/ppgeco
  - p1
  - roteiro
aliases:
  - Algoritmo das resoluções
---

# Algoritmo das resoluções

Cada seção é uma **família de questões** da Lista 1 v.1 e dá o roteiro completo para resolvê-la: o que escrever, em que ordem, por que cada passo vale e de qual resultado anterior ele depende. Não há digressão: ficaram de fora as condições técnicas do Greene que a prova não pede (Grenander, Jensen, bootstrap, componentes principais, métodos não aninhados).

A leitura em conjunto é com o [material socrático](socratico.md), que tem as mesmas dezesseis seções em forma de perguntas. Sugestão: leia as perguntas de uma seção, tente respondê-las, depois leia o algoritmo da mesma seção e escreva a demonstração sem olhar.

> [!IMPORTANT]
> **Como as peças se ligam**
> Quase tudo sai de três identidades: as equações normais $\mathbf X'\mathbf e=\mathbf 0$ (§1–§3), o pivô $\mathbf b=\beta+(\mathbf X'\mathbf X)^{-1}\mathbf X'\varepsilon$ (§5) e $\mathbf e=\mathbf M\varepsilon$ (§3). Não-viés, variância, Gauss-Markov, $E(s^2)$, consistência e a inconsistência sob endogeneidade são a mesma conta com hipóteses diferentes.

| § | Pergunta da prova | Lista v.1 | Usa | Alimenta |
|---|---|---|---|---|
| 1 | Equações normais e $\widehat\beta_1,\widehat\beta_2$ | 2, 28 | — | 3, 5 |
| 2 | $\mathbf b$ pelo cálculo matricial e o mínimo | 25, 21, 19 | — | 3, 5 |
| 3 | $\mathbf P$, $\mathbf M$, $\mathbf X'\mathbf e=\mathbf 0$, $SQT=SQE+SQR$, traço | 16–18, 22, 29 | 2 | 4, 7, 9 |
| 4 | FWL e viés de variável omitida | 20, 31, 34, 11 | 3 | 5, 12 |
| 5 | Não-viés e variância (o pivô) | 33, 35–37, 24 | 2 | 6, 7, 8 |
| 6 | Gauss-Markov | 38, 3 | 5 | 16 |
| 7 | $E(s^2)=\sigma^2$ | 39 | 3, 5 | 9 |
| 8 | Consistência e normalidade assintótica | 51–54, 56 | 5 | 12, 14 |
| 9 | Testes $t$ e $F$, intervalo de confiança | 4, 6, 41–43, 49, 50 | 5, 7 | 10, 11, 15 |
| 10 | Output de MQO em log | 44, 45, 61, 62, 57–59 | 9 | — |
| 11 | Dummies, mudança estrutural e DiD | 7, 64–68, 70 | 2, 9 | — |
| 12 | Por que o MQO falha sob endogeneidade | 71, 14 | 8 | 13, 14 |
| 13 | Erro de medição em $Y$ e em $X$ | 74, 75 | 5, 12 | — |
| 14 | Variáveis instrumentais | 72, 73, 76 | 8, 12 | 15 |
| 15 | Output do `ivreg` | 77–79 | 9, 14 | — |
| 16 | Violações das hipóteses (seção 1 da lista) | 8–14 | 5, 6 | — |

**Hipóteses** (numeração da chave, [CONVENCOES](../../CONVENCOES.md) §2): H1 linearidade, H2 exogeneidade estrita $E(\varepsilon\mid\mathbf X)=\mathbf 0$, H3 posto completo, H4 esfericidade $E(\varepsilon\varepsilon'\mid\mathbf X)=\sigma^2\mathbf I_n$, H5 normalidade.

---

## 1 · Equações normais e os estimadores da regressão simples

**Pergunta-tipo.** A partir de $\min\sum(Y_i-\beta_1-\beta_2X_i)^2$, obtenha as equações normais e as fórmulas de $\widehat\beta_1$ e $\widehat\beta_2$ (ex. 2 e 28; Q3 da P1 2025/2).

**Ideia.** Duas condições de primeira ordem dão duas equações; a primeira entrega o intercepto, e a segunda, depois de centrar, entrega a inclinação.

**Algoritmo.**

1. **Critério.** $S(\widehat\beta_1,\widehat\beta_2)=\sum_{i=1}^n(Y_i-\widehat\beta_1-\widehat\beta_2X_i)^2=\sum\widehat u_i^2$. É o que define o MQO.
2. **Derivada em $\widehat\beta_1$.** Pela regra da cadeia, $\partial S/\partial\widehat\beta_1=-2\sum(Y_i-\widehat\beta_1-\widehat\beta_2X_i)=0$, isto é,

$$\textstyle\sum\widehat u_i=0\quad\Longleftrightarrow\quad\sum Y_i=n\widehat\beta_1+\widehat\beta_2\sum X_i .$$

3. **Derivada em $\widehat\beta_2$.** $\partial S/\partial\widehat\beta_2=-2\sum X_i(Y_i-\widehat\beta_1-\widehat\beta_2X_i)=0$, isto é,

$$\textstyle\sum X_i\widehat u_i=0\quad\Longleftrightarrow\quad\sum X_iY_i=\widehat\beta_1\sum X_i+\widehat\beta_2\sum X_i^2 .$$

4. **Intercepto.** Divida a primeira equação por $n$: $\widehat\beta_1=\bar Y-\widehat\beta_2\bar X$. Consequência imediata: a reta ajustada passa por $(\bar X,\bar Y)$.
5. **Substitua na segunda equação.** $\sum X_i\big[(Y_i-\bar Y)-\widehat\beta_2(X_i-\bar X)\big]=0$.
6. **Troque $X_i$ por $X_i-\bar X$ dentro das somas.** Pode, porque $\bar X\sum(Y_i-\bar Y)=0$ e $\bar X\sum(X_i-\bar X)=0$: a soma dos desvios em torno da média é zero. Fica $\sum x_iy_i=\widehat\beta_2\sum x_i^2$, com $x_i=X_i-\bar X$ e $y_i=Y_i-\bar Y$.
7. **Inclinação.**

$$\boxed{\widehat\beta_2=\frac{\sum(X_i-\bar X)(Y_i-\bar Y)}{\sum(X_i-\bar X)^2}=\frac{S_{XY}}{S_{XX}},\qquad \widehat\beta_1=\bar Y-\widehat\beta_2\bar X}$$

8. **Mínimo.** A Hessiana $2\begin{bmatrix}n&\sum X_i\\ \sum X_i&\sum X_i^2\end{bmatrix}$ tem $2n>0$ e determinante $4nS_{XX}>0$ desde que $X$ varie na amostra — é a hipótese de variação em $X$.
9. **Forma em desvios** (ex. 28c). Subtraia $\bar Y=\widehat\beta_1+\widehat\beta_2\bar X$ de $Y_i=\widehat\beta_1+\widehat\beta_2X_i+\widehat u_i$: $y_i=\widehat\beta_2x_i+\widehat u_i$.

**Encadeamento.** As duas equações dos passos 2–3 são as duas linhas de $\mathbf X'\mathbf e=\mathbf 0$ quando $\mathbf X=[\iota\ \ \mathbf x]$ (§3). O passo 7 reescrito como $\widehat\beta_2=\sum w_iY_i$, com $w_i=x_i/S_{XX}$, é o ponto de partida do não-viés escalar (§5).

---

## 2 · O estimador matricial e a condição de mínimo

**Pergunta-tipo.** A partir de $S(\beta)=(\mathbf y-\mathbf X\beta)'(\mathbf y-\mathbf X\beta)$, obtenha $\mathbf X'\mathbf X\mathbf b=\mathbf X'\mathbf y$, a solução $\mathbf b$ e mostre que é mínimo (ex. 25, 21; ex. 19 quando a inversa não existe).

**Algoritmo.**

1. **Expanda.** $S(\beta)=\mathbf y'\mathbf y-\mathbf y'\mathbf X\beta-\beta'\mathbf X'\mathbf y+\beta'\mathbf X'\mathbf X\beta$. Como $\mathbf y'\mathbf X\beta$ é um escalar ($1\times 1$), é igual à sua transposta $\beta'\mathbf X'\mathbf y$; logo $S(\beta)=\mathbf y'\mathbf y-2\beta'\mathbf X'\mathbf y+\beta'\mathbf X'\mathbf X\beta$.
2. **Derive.** Com $\partial(\mathbf a'\beta)/\partial\beta=\mathbf a$ e $\partial(\beta'\mathbf A\beta)/\partial\beta=2\mathbf A\beta$ para $\mathbf A$ simétrica:

$$\frac{\partial S}{\partial\beta}=-2\mathbf X'\mathbf y+2\mathbf X'\mathbf X\beta=\mathbf 0\quad\Longrightarrow\quad\mathbf X'\mathbf X\mathbf b=\mathbf X'\mathbf y .$$

3. **Inverta.** Sob H3, $\mathbf X'\mathbf X$ é invertível (passo 5), e

$$\boxed{\mathbf b=(\mathbf X'\mathbf X)^{-1}\mathbf X'\mathbf y}$$

4. **$\mathbf X'\mathbf X$ é simétrica.** $(\mathbf X'\mathbf X)'=\mathbf X'(\mathbf X')'=\mathbf X'\mathbf X$, pela regra $(\mathbf A\mathbf B)'=\mathbf B'\mathbf A'$ (ex. 21).
5. **$\mathbf X'\mathbf X$ é positiva definida.** Para $\mathbf c\neq\mathbf 0$, chame $\mathbf v=\mathbf X\mathbf c$: $\mathbf c'\mathbf X'\mathbf X\mathbf c=\mathbf v'\mathbf v=\sum v_i^2\ge 0$, e sob H3 $\mathbf v\neq\mathbf 0$, logo a soma é estritamente positiva. Positiva definida implica invertível.
6. **Segunda ordem.** A Hessiana é $2\mathbf X'\mathbf X$, positiva definida pelo passo 5: $\mathbf b$ é o mínimo global.
7. **Quando H3 falha** (ex. 19, 65). Se uma coluna de $\mathbf X$ é combinação linear das outras, existe $\mathbf c\neq\mathbf 0$ com $\mathbf X\mathbf c=\mathbf 0$: $\mathbf X'\mathbf X$ é singular, $\det(\mathbf X'\mathbf X)=0$, e só combinações dos parâmetros são identificadas.

**Encadeamento.** As equações normais $\mathbf X'(\mathbf y-\mathbf X\mathbf b)=\mathbf 0$ são o ponto de partida de §3. O passo 3 com $\mathbf y=\mathbf X\beta+\varepsilon$ dá o pivô de §5.

---

## 3 · Projeção, *residual maker* e a decomposição da variação

**Pergunta-tipo.** Prove que $\mathbf M$ e $\mathbf P$ são simétricas e idempotentes, que $\mathbf e=\mathbf M\mathbf y$, $\mathbf M\mathbf X=\mathbf 0$, $\mathbf X'\mathbf e=\mathbf 0$, $SQT=SQE+SQR$ e $\operatorname{tr}(\mathbf M)=n-K$ (ex. 16–18, 22, 29).

**Algoritmo.**

1. **Resíduos como transformação de $\mathbf y$.** $\mathbf e=\mathbf y-\mathbf X\mathbf b=\mathbf y-\mathbf X(\mathbf X'\mathbf X)^{-1}\mathbf X'\mathbf y=\mathbf M\mathbf y$, com $\mathbf M=\mathbf I_n-\mathbf X(\mathbf X'\mathbf X)^{-1}\mathbf X'$.
2. **Simetria.** $\mathbf M'=\mathbf I_n-\mathbf X[(\mathbf X'\mathbf X)^{-1}]'\mathbf X'=\mathbf M$, porque a inversa de uma matriz simétrica é simétrica.
3. **Idempotência.** Ao multiplicar $\mathbf M\mathbf M$, o termo do meio tem $(\mathbf X'\mathbf X)^{-1}\mathbf X'\mathbf X=\mathbf I_K$, e sobra $\mathbf M\mathbf M=\mathbf I-2\mathbf X(\mathbf X'\mathbf X)^{-1}\mathbf X'+\mathbf X(\mathbf X'\mathbf X)^{-1}\mathbf X'=\mathbf M$.
4. **$\mathbf M$ anula $\mathbf X$.** $\mathbf M\mathbf X=\mathbf X-\mathbf X(\mathbf X'\mathbf X)^{-1}\mathbf X'\mathbf X=\mathbf 0$. Daí $\mathbf e=\mathbf M(\mathbf X\beta+\varepsilon)=\mathbf M\varepsilon$ — a identidade que §7 usa.
5. **Ortogonalidade.** $\mathbf X'\mathbf e=\mathbf X'\mathbf M\mathbf y=(\mathbf M\mathbf X)'\mathbf y=\mathbf 0$. Com a coluna de uns em $\mathbf X$, a primeira linha diz $\iota'\mathbf e=\sum e_i=0$. Interpretação: os resíduos não têm correlação amostral com nenhum regressor.
6. **Projeção.** $\mathbf P=\mathbf I-\mathbf M=\mathbf X(\mathbf X'\mathbf X)^{-1}\mathbf X'$, $\widehat{\mathbf y}=\mathbf X\mathbf b=\mathbf P\mathbf y$, e $\mathbf P\mathbf M=\mathbf P-\mathbf P\mathbf P=\mathbf 0$. Então $\mathbf y=\widehat{\mathbf y}+\mathbf e$ com $\widehat{\mathbf y}'\mathbf e=\mathbf y'\mathbf P\mathbf M\mathbf y=0$.
7. **Decomposição.** Como $\sum e_i=0$, a média dos ajustados é $\bar Y$. Centrando $\mathbf y=\widehat{\mathbf y}+\mathbf e$ e usando $\widehat{\mathbf y}'\mathbf e=0$:

$$\underbrace{\textstyle\sum(Y_i-\bar Y)^2}_{SQT}=\underbrace{\textstyle\sum(\widehat Y_i-\bar Y)^2}_{SQE}+\underbrace{\textstyle\sum e_i^2}_{SQR},\qquad R^2=\frac{SQE}{SQT}=1-\frac{SQR}{SQT}.$$

8. **Forma útil de $\mathbf e'\mathbf e$.** $\mathbf e'\mathbf e=\mathbf e'\mathbf y=\mathbf y'\mathbf y-\mathbf b'\mathbf X'\mathbf y$, porque $\mathbf e'\mathbf X\mathbf b=0$ pelo passo 5.
9. **Traços.** Com $\operatorname{tr}(\mathbf A\mathbf B)=\operatorname{tr}(\mathbf B\mathbf A)$: $\operatorname{tr}(\mathbf P)=\operatorname{tr}\big[(\mathbf X'\mathbf X)^{-1}\mathbf X'\mathbf X\big]=\operatorname{tr}(\mathbf I_K)=K$ e $\operatorname{tr}(\mathbf M)=n-K$. Leitura: $K$ graus de liberdade gastos nos parâmetros, $n-K$ sobram para os resíduos.

**Encadeamento.** O passo 4 alimenta $E(s^2)$ (§7); o passo 9 dá o divisor $n-K$; a partição $\mathbf M_1$ do FWL (§4) é o mesmo $\mathbf M$ construído com $\mathbf X_1$; o passo 7 é a base do $F$ pelo $R^2$ (§9).

---

## 4 · Frisch-Waugh-Lovell e o viés de variável omitida

**Pergunta-tipo.** Mostre que $\mathbf b_2=(\mathbf X_2'\mathbf M_1\mathbf X_2)^{-1}\mathbf X_2'\mathbf M_1\mathbf y$ é a regressão de resíduos em resíduos (ex. 20, conferido com números no ex. 31); obtenha o viés de omitir uma variável relevante (ex. 34) e o efeito de incluir uma irrelevante (ex. 11).

**Algoritmo do FWL.**

1. **Equações normais particionadas.** Com $\mathbf X=[\mathbf X_1\ \mathbf X_2]$:

$$\begin{bmatrix}\mathbf X_1'\mathbf X_1&\mathbf X_1'\mathbf X_2\\ \mathbf X_2'\mathbf X_1&\mathbf X_2'\mathbf X_2\end{bmatrix}\begin{bmatrix}\mathbf b_1\\ \mathbf b_2\end{bmatrix}=\begin{bmatrix}\mathbf X_1'\mathbf y\\ \mathbf X_2'\mathbf y\end{bmatrix}.$$

2. **Isole $\mathbf b_1$ na primeira linha.** $\mathbf b_1=(\mathbf X_1'\mathbf X_1)^{-1}\mathbf X_1'(\mathbf y-\mathbf X_2\mathbf b_2)$.
3. **Leve à segunda linha.** Com $\mathbf P_1=\mathbf X_1(\mathbf X_1'\mathbf X_1)^{-1}\mathbf X_1'$: $\mathbf X_2'\mathbf P_1(\mathbf y-\mathbf X_2\mathbf b_2)+\mathbf X_2'\mathbf X_2\mathbf b_2=\mathbf X_2'\mathbf y$, isto é, $\mathbf X_2'\mathbf M_1\mathbf X_2\,\mathbf b_2=\mathbf X_2'\mathbf M_1\mathbf y$.
4. **Resolva e reescreva.** Como $\mathbf M_1$ é simétrica e idempotente (§3),

$$\boxed{\mathbf b_2=(\mathbf X_2'\mathbf M_1\mathbf X_2)^{-1}\mathbf X_2'\mathbf M_1\mathbf y=\big[(\mathbf M_1\mathbf X_2)'(\mathbf M_1\mathbf X_2)\big]^{-1}(\mathbf M_1\mathbf X_2)'(\mathbf M_1\mathbf y)}$$

que é o MQO de $\mathbf M_1\mathbf y$ (resíduos de $\mathbf y$ em $\mathbf X_1$) em $\mathbf M_1\mathbf X_2$ (resíduos de $\mathbf X_2$ em $\mathbf X_1$).
5. **Caso $\mathbf X_1=\iota$** (ex. 31). $\mathbf M_1$ subtrai a média: a inclinação da regressão com intercepto é $\sum x_iy_i/\sum x_i^2$, a regressão dos desvios sem constante.
6. **Utilidade.** É a justificativa formal de "efeito *ceteris paribus*": o coeficiente de $\mathbf X_2$ mede a relação com $\mathbf y$ depois de limpar a influência linear de $\mathbf X_1$.

**Algoritmo do viés de omissão** (modelo verdadeiro $Y_i=\beta_1+\beta_2X_{2i}+\beta_3X_{3i}+u_i$, estima-se só com $X_2$).

1. **Estimador curto.** $\widetilde\beta_2=\sum(X_{2i}-\bar X_2)Y_i\big/\sum(X_{2i}-\bar X_2)^2$.
2. **Substitua o modelo verdadeiro** e use $\sum(X_{2i}-\bar X_2)=0$ e $\sum(X_{2i}-\bar X_2)X_{2i}=\sum(X_{2i}-\bar X_2)^2$:

$$\widetilde\beta_2=\beta_2+\beta_3\underbrace{\frac{\sum(X_{2i}-\bar X_2)(X_{3i}-\bar X_3)}{\sum(X_{2i}-\bar X_2)^2}}_{\widehat\delta_{32}}+\frac{\sum(X_{2i}-\bar X_2)u_i}{\sum(X_{2i}-\bar X_2)^2}.$$

3. **Tome $E(\cdot\mid X)$** com $E(u_i\mid X)=0$ *[H2]*: $E(\widetilde\beta_2\mid X)=\beta_2+\beta_3\widehat\delta_{32}$.
4. **Leia o viés.** $\beta_3\widehat\delta_{32}$ é nulo só se $\beta_3=0$ (a omitida não importa) ou $\widehat\delta_{32}=0$ (não é correlacionada com a incluída). Sinal do viés = sinal de $\beta_3$ vezes sinal da correlação entre $X_2$ e $X_3$.
5. **Versão matricial.** $E(\mathbf b_1\mid\mathbf X)=\beta_1+(\mathbf X_1'\mathbf X_1)^{-1}\mathbf X_1'\mathbf X_2\beta_2$.
6. **Variável irrelevante** (ex. 11). Incluir $X_3$ com $\beta_3=0$ não vicia (o modelo continua correto), mas a variância de $\widehat\beta_2$ ganha o fator $1/(1-r_{23}^2)$ — o $VIF$ de §5.

**Encadeamento.** Omitir variável correlacionada é uma das três fontes de endogeneidade (§12). O FWL dá a fórmula do $VIF$ (§5, passo 7).

---

## 5 · O pivô: não-viés e variância

**Pergunta-tipo.** Prove que $E(\mathbf b\mid\mathbf X)=\beta$ e $\operatorname{Var}(\mathbf b\mid\mathbf X)=\sigma^2(\mathbf X'\mathbf X)^{-1}$; particularize para a regressão simples, com $\operatorname{Var}(\widehat\beta_2)$ e $\operatorname{Cov}(\widehat\beta_1,\widehat\beta_2)$ (ex. 33, 35, 36, 37; Q5 da P1 2025/2).

**Algoritmo matricial.**

1. **O pivô.** Substitua $\mathbf y=\mathbf X\beta+\varepsilon$ *[H1]* em $\mathbf b$ *[H3]*:

$$\boxed{\mathbf b=(\mathbf X'\mathbf X)^{-1}\mathbf X'(\mathbf X\beta+\varepsilon)=\beta+(\mathbf X'\mathbf X)^{-1}\mathbf X'\varepsilon}$$

2. **Não-viés.** Condicionando em $\mathbf X$, a matriz $(\mathbf X'\mathbf X)^{-1}\mathbf X'$ é constante e sai da esperança:

$$E(\mathbf b\mid\mathbf X)=\beta+(\mathbf X'\mathbf X)^{-1}\mathbf X'E(\varepsilon\mid\mathbf X)=\beta\quad[\text{H2}],$$

e pela lei das esperanças iteradas $E(\mathbf b)=E_{\mathbf X}\big(E(\mathbf b\mid\mathbf X)\big)=\beta$.
3. **Variância.** Chame $\mathbf A=(\mathbf X'\mathbf X)^{-1}\mathbf X'$, de modo que $\mathbf b-\beta=\mathbf A\varepsilon$ e $(\mathbf b-\beta)'=\varepsilon'\mathbf A'$:

$$\operatorname{Var}(\mathbf b\mid\mathbf X)=E(\mathbf A\varepsilon\varepsilon'\mathbf A'\mid\mathbf X)=\mathbf A\,E(\varepsilon\varepsilon'\mid\mathbf X)\,\mathbf A'=\sigma^2\mathbf A\mathbf A'\quad[\text{H4}].$$

4. **Simplifique.** $\mathbf A\mathbf A'=(\mathbf X'\mathbf X)^{-1}\mathbf X'\mathbf X(\mathbf X'\mathbf X)^{-1}=(\mathbf X'\mathbf X)^{-1}$, logo

$$\boxed{\operatorname{Var}(\mathbf b\mid\mathbf X)=\sigma^2(\mathbf X'\mathbf X)^{-1}}$$

5. **O que H4 diz, elemento a elemento** (ex. 37). O elemento $(i,j)$ de $E(\varepsilon\varepsilon'\mid\mathbf X)$ é $E(\varepsilon_i\varepsilon_j\mid\mathbf X)$. Homocedasticidade põe $\sigma^2$ em toda a diagonal; ausência de autocorrelação zera tudo fora dela. Daí $\sigma^2\mathbf I_n$.

**Algoritmo escalar** (ex. 33 e 36).

1. **Pesos.** $\widehat\beta_2=\sum w_iY_i$ com $w_i=(X_i-\bar X)/S_{XX}$, que satisfazem $\sum w_i=0$, $\sum w_iX_i=1$ e $\sum w_i^2=1/S_{XX}$.
2. **Pivô escalar.** Substituindo $Y_i=\beta_1+\beta_2X_i+u_i$: $\widehat\beta_2=\beta_1\sum w_i+\beta_2\sum w_iX_i+\sum w_iu_i=\beta_2+\sum w_iu_i$.
3. **Não-viés.** $E(\widehat\beta_2\mid X)=\beta_2+\sum w_iE(u_i\mid X)=\beta_2$; e de $\widehat\beta_1=\bar Y-\widehat\beta_2\bar X=\beta_1+\bar u-\bar X(\widehat\beta_2-\beta_2)$ sai $E(\widehat\beta_1\mid X)=\beta_1$.
4. **Variância.** Com $\operatorname{Var}(u_i)=\sigma^2$ e $\operatorname{Cov}(u_i,u_j)=0$: $\operatorname{Var}(\widehat\beta_2)=\sum w_i^2\sigma^2=\sigma^2/S_{XX}$.
5. **Covariância.** $\operatorname{Cov}(\widehat\beta_1,\widehat\beta_2)=\operatorname{Cov}(\bar u,\widehat\beta_2)-\bar X\operatorname{Var}(\widehat\beta_2)$, e $\operatorname{Cov}(\bar u,\sum w_iu_i)=(\sigma^2/n)\sum w_i=0$. Logo $\operatorname{Cov}(\widehat\beta_1,\widehat\beta_2)=-\bar X\sigma^2/S_{XX}$.
6. **Leitura.** Quanto mais $X$ se espalha em torno da média (maior $S_{XX}$), mais precisa é a inclinação.
7. **Multicolinearidade** (ex. 24). Pelo FWL (§4), o elemento $(k,k)$ de $(\mathbf X'\mathbf X)^{-1}$ é o inverso da soma dos quadrados dos resíduos de $X_k$ nas demais colunas, $S_{kk}(1-R_k^2)$. Então

$$\operatorname{Var}(b_k\mid\mathbf X)=\frac{\sigma^2}{(1-R_k^2)S_{kk}}=\frac{\sigma^2}{S_{kk}}\cdot VIF_k,\qquad VIF_k=\frac{1}{1-R_k^2},$$

que explode quando $R_k^2\to 1$, sem nenhum viés.

**Encadeamento.** O pivô (passo 1) é usado de novo em Gauss-Markov (§6), na consistência (§8) e, com $E(\varepsilon\mid\mathbf X)\neq\mathbf 0$, na inconsistência (§12).

---

## 6 · Gauss-Markov: por que o MQO é MELNV

**Pergunta-tipo.** Com $\mathbf b^*=[(\mathbf X'\mathbf X)^{-1}\mathbf X'+\mathbf C]\mathbf y$ não viesado, mostre $\mathbf C\mathbf X=\mathbf 0$ e $\operatorname{Var}(\mathbf b^*\mid\mathbf X)-\operatorname{Var}(\mathbf b\mid\mathbf X)=\sigma^2\mathbf C\mathbf C'$ (ex. 38; a versão escalar é o ex. 3).

**Algoritmo.**

1. **Qualquer estimador linear** em $\mathbf y$ é $\mathbf b^*=\mathbf D\mathbf y$; escreva $\mathbf D=(\mathbf X'\mathbf X)^{-1}\mathbf X'+\mathbf C$, isto é, o MQO mais um desvio $\mathbf C$.
2. **Substitua o modelo.** $\mathbf b^*=\beta+\mathbf C\mathbf X\beta+\big[(\mathbf X'\mathbf X)^{-1}\mathbf X'+\mathbf C\big]\varepsilon$.
3. **Não-viés.** $E(\mathbf b^*\mid\mathbf X)=(\mathbf I+\mathbf C\mathbf X)\beta$ *[H2]*. Para valer **para todo** $\beta$, é preciso $\mathbf C\mathbf X=\mathbf 0$.
4. **Variância.** Com $\mathbf C\mathbf X=\mathbf 0$, $\mathbf b^*-\beta=(\mathbf A+\mathbf C)\varepsilon$ e, por H4,

$$\operatorname{Var}(\mathbf b^*\mid\mathbf X)=\sigma^2(\mathbf A+\mathbf C)(\mathbf A+\mathbf C)'=\sigma^2\big[\mathbf A\mathbf A'+\mathbf A\mathbf C'+\mathbf C\mathbf A'+\mathbf C\mathbf C'\big].$$

5. **Os termos cruzados somem.** $\mathbf C\mathbf A'=\mathbf C\mathbf X(\mathbf X'\mathbf X)^{-1}=\mathbf 0$ e $\mathbf A\mathbf C'=(\mathbf C\mathbf A')'=\mathbf 0$. Com $\mathbf A\mathbf A'=(\mathbf X'\mathbf X)^{-1}$ (§5):

$$\boxed{\operatorname{Var}(\mathbf b^*\mid\mathbf X)-\operatorname{Var}(\mathbf b\mid\mathbf X)=\sigma^2\mathbf C\mathbf C'}$$

6. **É semidefinida positiva.** Para todo $\mathbf d$: $\mathbf d'\mathbf C\mathbf C'\mathbf d=(\mathbf C'\mathbf d)'(\mathbf C'\mathbf d)\ge 0$. Nenhum estimador linear não viesado tem variância menor; a igualdade só vale com $\mathbf C=\mathbf 0$, isto é, $\mathbf b^*=\mathbf b$.
7. **Onde as hipóteses entram.** H2 no passo 3; H4 no passo 4. Sem H4 (heterocedasticidade ou autocorrelação), $E(\varepsilon\varepsilon'\mid\mathbf X)=\Sigma\neq\sigma^2\mathbf I$ e os termos cruzados não somem: o MQO continua não viesado, mas deixa de ser o mais eficiente (ex. 3 e 9). H5 não é usada.

**Encadeamento.** O passo 7 é a linha de "eficiência" do quadro de violações (§16).

---

## 7 · $E(s^2)=\sigma^2$: o truque do traço

**Pergunta-tipo.** Mostre que $s^2=\mathbf e'\mathbf e/(n-K)$ é não viesado para $\sigma^2$ (ex. 39).

**Algoritmo.**

1. **Resíduos e erros.** $\mathbf e=\mathbf M\varepsilon$ (§3, passo 4).
2. **Forma quadrática.** $\mathbf e'\mathbf e=\varepsilon'\mathbf M'\mathbf M\varepsilon=\varepsilon'\mathbf M\varepsilon$, porque $\mathbf M$ é simétrica e idempotente.
3. **Escalar é o próprio traço.** $\varepsilon'\mathbf M\varepsilon=\operatorname{tr}(\varepsilon'\mathbf M\varepsilon)=\operatorname{tr}(\mathbf M\varepsilon\varepsilon')$, pela propriedade cíclica. Esse passo é o que permite levar $\varepsilon\varepsilon'$ para perto da esperança.
4. **Esperança.** Traço e esperança comutam e $\mathbf M$ é constante dado $\mathbf X$:

$$E(\mathbf e'\mathbf e\mid\mathbf X)=\operatorname{tr}\big(\mathbf M\,E(\varepsilon\varepsilon'\mid\mathbf X)\big)=\sigma^2\operatorname{tr}(\mathbf M)=\sigma^2(n-K)\quad[\text{H4};\ \S 3].$$

5. **Conclusão.**

$$\boxed{E(s^2\mid\mathbf X)=\frac{E(\mathbf e'\mathbf e\mid\mathbf X)}{n-K}=\sigma^2}$$

6. **Por que não dividir por $n$.** $E(\mathbf e'\mathbf e/n)=\sigma^2(n-K)/n<\sigma^2$: os resíduos são "menores" que os erros porque $\mathbf b$ foi escolhido para ajustá-los.

**Encadeamento.** $s^2$ entra em todo erro-padrão, $ep(b_k)=\sqrt{s^2[(\mathbf X'\mathbf X)^{-1}]_{kk}}$, e portanto em todo teste (§9). A versão assintótica, $\operatorname{plim}s^2=\sigma^2$, está em §8.

---

## 8 · Consistência e normalidade assintótica

**Pergunta-tipo.** Consistência da média amostral (ex. 51); $\operatorname{plim}\mathbf b=\beta$ por Slutsky (ex. 52; Q5 da P1 2025/2); normalidade assintótica (ex. 53); $\operatorname{plim}s^2=\sigma^2$ (ex. 54); exogeneidade estrita × contemporânea (ex. 56).

**Algoritmo — média amostral.**

1. $E(\bar X)=\mu$ e $\operatorname{Var}(\bar X)=\sigma^2/n$.
2. Chebyshev: $P(\lvert\bar X-\mu\rvert\ge\delta)\le\dfrac{\sigma^2}{n\delta^2}\to 0$ para todo $\delta>0$. Isso é a definição de $\bar X\xrightarrow{p}\mu$.

**Algoritmo — $\operatorname{plim}\mathbf b$.**

1. **Reescreva o pivô com médias.** $\mathbf b=\beta+\left(\dfrac{\mathbf X'\mathbf X}{n}\right)^{-1}\left(\dfrac{\mathbf X'\varepsilon}{n}\right)$.
2. **Hipóteses de limite.** $\operatorname{plim}(\mathbf X'\mathbf X/n)=\mathbf Q$, finita e não singular; $\operatorname{plim}(\mathbf X'\varepsilon/n)=\mathbf 0$.
3. **Por que $\operatorname{plim}(\mathbf X'\varepsilon/n)=\mathbf 0$.** Tem média zero *[H2]* e variância $\dfrac{\sigma^2}{n}\cdot\dfrac{\mathbf X'\mathbf X}{n}\to\mathbf 0$; pelo mesmo argumento de Chebyshev, converge para zero.
4. **Slutsky.** A função $g(\mathbf A,\mathbf c)=\mathbf A^{-1}\mathbf c$ é contínua em $(\mathbf Q,\mathbf 0)$, então

$$\boxed{\operatorname{plim}\mathbf b=\beta+\mathbf Q^{-1}\cdot\mathbf 0=\beta}$$

5. **Rota alternativa** (a do gabarito de 2025/2). $\mathbf b$ é não viesado e $\operatorname{Var}(\mathbf b\mid\mathbf X)=\dfrac{\sigma^2}{n}\left(\dfrac{\mathbf X'\mathbf X}{n}\right)^{-1}\to\dfrac{\sigma^2}{n}\mathbf Q^{-1}\to\mathbf 0$: convergência em média quadrática implica consistência.

**Algoritmo — normalidade assintótica.**

1. $\sqrt n(\mathbf b-\beta)=\left(\dfrac{\mathbf X'\mathbf X}{n}\right)^{-1}\dfrac{\mathbf X'\varepsilon}{\sqrt n}$.
2. $\mathbf X'\varepsilon/\sqrt n=\frac{1}{\sqrt n}\sum\mathbf x_i\varepsilon_i$ é uma soma padronizada de termos de média zero e variância $\sigma^2E(\mathbf x_i\mathbf x_i')$; pelo TLC, $\xrightarrow{d}N(\mathbf 0,\sigma^2\mathbf Q)$.
3. Slutsky com o primeiro fator $\to\mathbf Q^{-1}$: $\sqrt n(\mathbf b-\beta)\xrightarrow{d}N(\mathbf 0,\sigma^2\mathbf Q^{-1}\mathbf Q\mathbf Q^{-1})=N(\mathbf 0,\sigma^2\mathbf Q^{-1})$.
4. **Leitura.** Não usa H5: com $n$ grande, $t$ e $F$ valem aproximadamente mesmo sem erros normais.

**Algoritmo — $\operatorname{plim}s^2$.**

1. $\mathbf e'\mathbf e=\varepsilon'\mathbf M\varepsilon=\varepsilon'\varepsilon-\varepsilon'\mathbf X(\mathbf X'\mathbf X)^{-1}\mathbf X'\varepsilon$.
2. $s^2=\dfrac{n}{n-K}\left[\dfrac{\varepsilon'\varepsilon}{n}-\dfrac{\varepsilon'\mathbf X}{n}\left(\dfrac{\mathbf X'\mathbf X}{n}\right)^{-1}\dfrac{\mathbf X'\varepsilon}{n}\right]$.
3. $\dfrac{n}{n-K}\to 1$; $\dfrac{\varepsilon'\varepsilon}{n}\xrightarrow{p}\sigma^2$ (lei dos grandes números); o segundo termo $\to\mathbf 0'\mathbf Q^{-1}\mathbf 0=0$. Logo $\operatorname{plim}s^2=\sigma^2$.

**Algoritmo — estrita × contemporânea** (ex. 56).

1. Não-viés pede $E(\varepsilon\mid\mathbf X)=\mathbf 0$: o erro de cada período sem relação com os regressores de **todos** os períodos. Consistência pede só $\operatorname{plim}(\mathbf X'\varepsilon/n)=\mathbf 0$: sem relação com os regressores do **mesmo** período.
2. Em $Y_t=\beta_1+\beta_2Y_{t-1}+u_t$, o regressor do período seguinte é $Y_t$, que contém $u_t$: a estrita falha e o MQO é viesado em amostra finita.
3. Mas $Y_{t-1}$ só depende de choques passados, então $E(Y_{t-1}u_t)=0$: a contemporânea vale e o MQO é consistente.

**Encadeamento.** Quando $\operatorname{plim}(\mathbf X'\varepsilon/n)\neq\mathbf 0$, o passo 4 dá $\operatorname{plim}\mathbf b\neq\beta$ (§12); o VI troca $\mathbf X'$ por $\mathbf Z'$ nesta mesma conta (§14).

---

## 9 · Testes $t$ e $F$, intervalo de confiança

**Pergunta-tipo.** IC e teste $t$ de um coeficiente (ex. 4, 44); $F$ conjunto (ex. 6, 45b, 50, 64b); $t^2=F$ (ex. 41); $F$ pelo $R^2$ (ex. 42); por que $F$ tem distribuição $F$ (ex. 43); Wald (ex. 49).

**Algoritmo de qualquer teste (quatro itens).**

1. **Hipóteses.** $H_0$ é a afirmação testada; $H_1$, a alternativa.
2. **Estatística.** Calcule com os números do enunciado e diga a distribuição e os graus de liberdade.
3. **Decisão.** Compare com o crítico impresso (ou o $p$ com o nível). Escreva a frase: "como … , rejeita-se (não se rejeita) $H_0$ ao nível de …".
4. **Conclusão.** Uma frase com conteúdo econômico.

**Peças.**

- **$t$ de um coeficiente.** $t_{cal}=(\widehat\beta_k-\beta_k^0)/ep(\widehat\beta_k)$, com $n-k$ graus de liberdade ($k$ parâmetros, intercepto incluído).
- **Intervalo de confiança.** $IC_{95\%}(\beta_k)=\widehat\beta_k\pm t_{tab}\cdot ep(\widehat\beta_k)$. "O IC não contém zero" é o mesmo que "rejeita $H_0:\beta_k=0$" a 5% bicaudal.
- **$F$ por somas de quadrados.** Defina a sigla antes de usar (SQR = soma dos quadrados dos **resíduos**):

$$F_{cal}=\frac{(SQR_R-SQR_{UR})/q}{SQR_{UR}/(n-k_{UR})}\ \sim\ F(q,\,n-k_{UR}),$$

com $q$ = número de restrições e o denominador sempre do modelo irrestrito.
- **$F$ global pelo $R^2$** (ex. 42). Divida numerador e denominador de $F=\dfrac{SQE/(k-1)}{SQR/(n-k)}$ por $SQT$, usando $SQE/SQT=R^2$ e $SQR/SQT=1-R^2$:

$$F_{cal}=\frac{R^2/(k-1)}{(1-R^2)/(n-k)}.$$

- **$t^2=F$ na simples** (ex. 41). $SQE=\widehat\beta_2^2S_{XX}$ e $SQR/(n-2)=\widehat\sigma^2$, logo $F=\dfrac{\widehat\beta_2^2S_{XX}}{\widehat\sigma^2}=\left(\dfrac{\widehat\beta_2}{\sqrt{\widehat\sigma^2/S_{XX}}}\right)^2=t^2$.
- **Por que $F\sim F(q,n-k)$** (ex. 43). Sob $H_0$ e H5, $SQR_R-SQR_{UR}=(\mathbf R\mathbf b-\mathbf r)'[\mathbf R(\mathbf X'\mathbf X)^{-1}\mathbf R']^{-1}(\mathbf R\mathbf b-\mathbf r)$ é $\sigma^2\chi^2_q$; $SQR_{UR}$ é $\sigma^2\chi^2_{n-k}$, independente da primeira. A razão de qui-quadrados divididos pelos graus de liberdade é $F$, e $\sigma^2$ cancela.
- **Wald** (ex. 49). $W=(\mathbf R\mathbf b-\mathbf r)'[\sigma^2\mathbf R(\mathbf X'\mathbf X)^{-1}\mathbf R']^{-1}(\mathbf R\mathbf b-\mathbf r)\sim\chi^2_q$ com $\sigma^2$ conhecido. Trocando $\sigma^2$ por $s^2$, $W/q=F$. Em amostra pequena o $F$ é preferível porque incorpora a incerteza de estimar $\sigma^2$.
- **$F$ rejeita e os $t$ não** (ex. 6b). Regressores correlacionados dividem a mesma informação; cada $ep$ é inflado pelo $VIF$ (§5), mas o bloco explica $Y$.

> [!CAUTION]
> **Decida pelo número impresso**
> A lista imprime críticos e p-valores que não batem com as estatísticas (ex. 6, 46 e 77). A decisão pelo número do enunciado é a que vale; registre a comparação explicitamente.

**Encadeamento.** As peças acima são usadas na leitura de outputs (§10, §15) e nos testes de mudança estrutural (§11).

---

## 10 · Output de MQO em log: interpretar sem errar

**Pergunta-tipo.** Equação de salários em log com quadrático e dummy (ex. 45 e 62; Q1 da P1 2025/2); custo em log (ex. 61); elasticidades (ex. 57–59); output com $n=27$ (ex. 44).

**Algoritmo.**

1. **Identifique a forma funcional de cada termo** e use a leitura certa:

| Forma | Coeficiente $\beta$ significa | Elasticidade |
|---|---|---|
| nível–nível | variação de $Y$ por unidade de $X$ | $\beta\bar X/\bar Y$ na média |
| log–nível | $100\beta\%$ em $Y$ por unidade de $X$ | $\beta\bar X$ |
| nível–log | $\beta/100$ unidades de $Y$ por 1% de $X$ | $\beta/\bar Y$ |
| log–log | elasticidade constante | $\beta$ |

2. **Dummy num modelo em log.** Aproximado: $100\beta\%$; exato: $100(e^{\beta}-1)\%$. Escreva os dois.
3. **Quadrático.** Efeito marginal $\partial\ln Y/\partial X=\beta_2+2\beta_3X$, que depende de $X$. Ponto de máximo (se $\beta_3<0$): $X^*=-\beta_2/(2\beta_3)$. Comente se $X^*$ está dentro da amostra.
4. **Significância.** Teste $t$ por coeficiente (§9); para um bloco (como $EXP$ e $EXP^2$ juntos), $F$ por SQR.
5. **Ajuste.** $R^2$: fração da variação de $Y$ explicada linearmente pelos regressores. $\bar R^2=1-(1-R^2)\frac{n-1}{n-k}$ penaliza regressores que não ajudam; serve para comparar modelos com números diferentes de variáveis.
6. **Normalidade (JB).** Só importa para a inferência exata em amostra pequena; com $n$ grande, a inferência vale pela assintótica (§8).
7. **Antilog do intercepto** (ex. 61a). $e^{\widehat\alpha}$ estima o valor típico (mediana) de $Y$ no ponto de referência, não $E(Y)$.

**Encadeamento.** É a Q1 típica: interpretação e testes. Os testes vêm de §9; a justificativa de ignorar a não normalidade com $n$ grande vem de §8.

---

## 11 · Dummies, mudança estrutural e diferenças em diferenças

**Pergunta-tipo.** Interpretar dummies e evitar a armadilha (ex. 7, 65); testar diferença entre duas categorias (ex. 7c); mudança estrutural por dummies (ex. 64); spline (ex. 70); DiD (ex. 67–68).

**Algoritmo.**

1. **Armadilha.** Com intercepto e $J$ categorias exaustivas, use $J-1$ dummies. Com todas, $\iota=D_1+\dots+D_J$: uma coluna de $\mathbf X$ é combinação das outras, H3 falha e $\mathbf X'\mathbf X$ é singular (§2, passo 7).
2. **Leitura.** O coeficiente de uma dummy é a diferença esperada em relação à categoria omitida, *ceteris paribus*.
3. **Duas categorias não omitidas.** $H_0:\beta_2=\beta_3$ por $t=(b_2-b_3)/\sqrt{\widehat{\operatorname{Var}}(b_2)+\widehat{\operatorname{Var}}(b_3)-2\widehat{\operatorname{Cov}}(b_2,b_3)}$, ou reestime com uma delas como base.
4. **Mudança estrutural.** Em $Y=\beta_0+\beta_1X+\delta_0D+\delta_1(D\cdot X)+u$: $\delta_0$ desloca o intercepto e $\delta_1$ a inclinação depois da quebra. Ausência de mudança é $H_0:\delta_0=\delta_1=0$ — conjunta, porque a quebra pode estar em qualquer um dos dois —, testada por $F$ com $q=2$ (§9). É o teste de Chow escrito com dummies.
5. **Spline.** Com $(X-X_0)D$ e sem $D$ sozinha, a inclinação muda de $\beta_2$ para $\beta_2+\beta_3$ em $X_0$ e a função não salta, porque o termo vale zero no nó. Ausência de quebra: $H_0:\beta_3=0$, um teste $t$.
6. **DiD.** Em $y_{it}=\beta_0+\beta_1D_i+\beta_2T_t+\beta_3D_iT_t+\beta'\mathbf x_{it}+\varepsilon_{it}$, com $T_1=0$ e $T_2=1$: diferencie no tempo. $\beta_1D_i$ some porque o grupo não muda, e fica $\Delta y_i=\beta_2+\beta_3D_i+\beta'\Delta\mathbf x_i+\Delta\varepsilon_i$. Tome a esperança nos dois grupos e subtraia:

$$E(\Delta y\mid D=1)-E(\Delta y\mid D=0)=\beta_3+\beta'\big[E(\Delta\mathbf x\mid D=1)-E(\Delta\mathbf x\mid D=0)\big].$$

7. **Controles fixos no tempo** (ex. 68). Se $\mathbf x_{it}=\mathbf x_i$, então $\Delta\mathbf x_i=\mathbf 0$ e a diferença é $\beta_3$: a primeira diferença elimina toda característica fixa, observada ou não.

**Encadeamento.** O DiD é uma mudança estrutural (passo 4) em que a "quebra" é o tratamento.

---

## 12 · Por que o MQO falha sob endogeneidade

**Pergunta-tipo.** Expressão do plim do MQO quando $\operatorname{Cov}(X,u)\neq 0$; simultaneidade no modelo keynesiano (ex. 71); quadro de violações (ex. 14).

**Algoritmo.**

1. **Em desvios.** $\widehat\beta_1=\beta_1+\dfrac{\sum x_iu_i/n}{\sum x_i^2/n}$.
2. **Tome o plim** (lei dos grandes números em cada média e Slutsky):

$$\boxed{\operatorname{plim}\widehat\beta_1=\beta_1+\frac{\operatorname{Cov}(X,u)}{\operatorname{Var}(X)}}$$

3. **Leitura.** Com $\operatorname{Cov}(X,u)\neq 0$, o viés não desaparece com $n\to\infty$: o MQO é inconsistente. Fontes: variável omitida correlacionada (§4), erro de medição em $X$ (§13), simultaneidade (passo 4).
4. **Keynesiano.** Leve $Y_t=C_t+I_t$ à função consumo $C_t=\beta_0+\beta_1Y_t+\mu_t$ e resolva para $Y_t$ (forma reduzida):

$$Y_t=\frac{\beta_0}{1-\beta_1}+\frac{1}{1-\beta_1}I_t+\frac{1}{1-\beta_1}\mu_t .$$

5. **Covariância.** Com $\operatorname{Cov}(I_t,\mu_t)=0$: $\operatorname{Cov}(Y_t,\mu_t)=\sigma^2/(1-\beta_1)\neq 0$. Pelo passo 2, $\operatorname{plim}\widehat\beta_1=\beta_1+\dfrac{\sigma^2/(1-\beta_1)}{\operatorname{Var}(Y_t)}>\beta_1$: a propensão marginal a consumir é superestimada.

**Encadeamento.** O VI (§14) conserta exatamente o passo 2, trocando $\operatorname{Cov}(X,u)$ por $\operatorname{Cov}(Z,u)=0$.

---

## 13 · Erro de medição: na dependente × no regressor

**Pergunta-tipo.** Viés e variância com erro de medição em $Y$ (ex. 74; Q4 da P1 2025/2); viés e inconsistência com erro em $X$ (ex. 75).

**Algoritmo — erro em $Y$.**

1. **Modelo efetivo.** $y_i=y_i^*+\varepsilon_i$ dá $y_i=\alpha+\beta x_i+v_i$, com $v_i=\mu_i+\varepsilon_i$.
2. **Pivô escalar** (§5). $b=\beta+\dfrac{\sum(x_i-\bar x)v_i}{\sum(x_i-\bar x)^2}$, porque $\sum(x_i-\bar x)\bar v=0$.
3. **Não-viés.** $x_i$ fixo e $E(v_i)=E(\mu_i)+E(\varepsilon_i)=0$: $E(b)=\beta$.
4. **Variância.** Com $\operatorname{Cov}(\mu_i,\varepsilon_i)=0$: $\operatorname{Var}(b)=\dfrac{\sigma_\mu^2+\sigma_\varepsilon^2}{\sum(x_i-\bar x)^2}$, maior que $\dfrac{\sigma_\mu^2}{\sum(x_i-\bar x)^2}$ do modelo sem erro.
5. **Conclusão.** O erro na dependente não vicia nem torna inconsistente; só reduz a precisão.

**Algoritmo — erro em $X$.**

1. **Modelo efetivo.** $X_i=X_i^*+w_i$ dá $Y_i=\alpha+\beta X_i+z_i$, com $z_i=\mu_i-\beta w_i$.
2. **Covariância com o regressor.** $\operatorname{Cov}(z_i,X_i)=\operatorname{Cov}(\mu_i-\beta w_i,\ X_i^*+w_i)=-\beta\sigma_w^2\neq 0$, usando que $w$ não se correlaciona com $\mu$ nem com $X^*$. H2 cai.
3. **plim** (§12, passo 2): $\operatorname{plim}b=\beta-\dfrac{\beta\sigma_w^2}{\sigma_{X^*}^2+\sigma_w^2}=\beta\,\dfrac{\sigma_{X^*}^2}{\sigma_{X^*}^2+\sigma_w^2}$.
4. **Leitura.** Atenuação: a estimativa é puxada para zero, e o problema não some com $n$ grande.

| Erro em | Viés | Consistência | Variância |
|---|---|---|---|
| $Y$ | não | sim | maior |
| $X$ | sim (atenuação) | não | — |

---

## 14 · Variáveis instrumentais: as condições e o estimador

**Pergunta-tipo.** As duas condições de um instrumento e o problema do instrumento fraco ou inválido (ex. 72); $\widehat\beta^{IV}$ à mão e derivação matricial (ex. 73; Q6 da P1 2025/2); VI, MQ2E e GMM (ex. 76).

**Algoritmo.**

1. **Condições.** Relevância: $\operatorname{Cov}(Z,X)\neq 0$ — testável pelo $F$ do primeiro estágio. Exogeneidade: $\operatorname{Cov}(Z,u)=0$ — não testável no caso exatamente identificado.
2. **Por que as duas importam.** No modelo simples, $\operatorname{plim}\widehat\beta_1^{IV}=\beta_1+\dfrac{\operatorname{Cov}(Z,u)}{\operatorname{Cov}(Z,X)}$. Com $Z$ inválido, o numerador não é zero: inconsistente. Com $Z$ fraco, o denominador é quase zero e amplifica qualquer desvio, além de inflar a variância.
3. **À mão** (ex. 73a). Em desvios, $\widehat\beta_1^{IV}=\sum z_iy_i/\sum z_ix_i$ e $\widehat\beta_0^{IV}=\bar Y-\widehat\beta_1^{IV}\bar X$.
4. **Derivação com $L=K$.** A condição populacional $\operatorname{plim}(\mathbf Z'\varepsilon/n)=\mathbf 0$ tem análogo amostral $\mathbf Z'(\mathbf y-\mathbf X\widehat\beta_{IV})=\mathbf 0$. Como $\mathbf Z'\mathbf X$ é quadrada e não singular:

$$\boxed{\widehat\beta_{IV}=(\mathbf Z'\mathbf X)^{-1}\mathbf Z'\mathbf y}$$

5. **Consistência.** $\widehat\beta_{IV}=\beta+\left(\dfrac{\mathbf Z'\mathbf X}{n}\right)^{-1}\dfrac{\mathbf Z'\varepsilon}{n}\xrightarrow{p}\beta+\mathbf Q_{ZX}^{-1}\cdot\mathbf 0=\beta$ — a conta de §8 com $\mathbf Z'$ no lugar de $\mathbf X'$.
6. **Mais instrumentos que regressores ($L>K$): MQ2E.** Primeiro estágio $\widehat{\mathbf X}=\mathbf P_Z\mathbf X$; segundo estágio, MQO de $\mathbf y$ em $\widehat{\mathbf X}$: $\widehat\beta_{MQ2E}=(\widehat{\mathbf X}'\mathbf X)^{-1}\widehat{\mathbf X}'\mathbf y$. O GMM generaliza ponderando as condições de momento de forma ótima.
7. **Comparação com o MQO.** Sem endogeneidade, MQO é consistente e mais eficiente; com endogeneidade, só VI/MQ2E é consistente, ao custo de variância maior.

**Encadeamento.** Os testes que acompanham o VI estão em §15.

---

## 15 · O output do `ivreg`

**Pergunta-tipo.** Identificar endógena e instrumentos; instrumentos fracos; Wu-Hausman; Sargan; interpretar o coeficiente (ex. 77; Q2 da P1 2025/2); a lógica do Hausman (ex. 78) e o limite do Sargan (ex. 79).

**Algoritmo.**

1. **Fórmula.** Em `y ~ exógenas + endógena | exógenas + instrumentos`, a endógena é a que está à esquerda da barra e não à direita; os instrumentos externos são os que estão só à direita.
2. **Instrumentos fracos.** $H_0$: fracos. Rejeitar é a boa notícia. Regra prática: $F>10$.
3. **Wu-Hausman.** $H_0$: regressor exógeno (MQO e VI consistentes; MQO mais eficiente). $H_1$: endógeno (só VI consistente). $p<\alpha$ ⇒ use VI/MQ2E. Decida pelo $p$ impresso.
4. **Sargan.** $H_0$: todos os instrumentos válidos. Graus de liberdade $L-K$ (restrições de sobreidentificação). $p>\alpha$ ⇒ não há evidência contra a validade. Só existe com $L>K$.
5. **Limite do Sargan.** Supõe que ao menos $K$ instrumentos são válidos e detecta só incompatibilidade **entre** eles; se todos forem inválidos na mesma direção, não rejeita.
6. **Lógica do Hausman.** Sob $H_0$, o estimador eficiente (MQO) não se correlaciona com a diferença $\widehat\beta_{VI}-\widehat\beta_{MQO}$; daí $\operatorname{Var}(\widehat\beta_{VI}-\widehat\beta_{MQO})=\operatorname{Var}(\widehat\beta_{VI})-\operatorname{Var}(\widehat\beta_{MQO})$, e a estatística é a diferença ao quadrado ponderada por essa variância: um $\chi^2$. Sob $H_0$ a diferença tende a zero; sob $H_1$, não.
7. **Coeficiente.** Num log-log, elasticidade. Se a pergunta for "a demanda é elástica?", teste $H_0:\beta=-1$, não só $H_0:\beta=0$.

**Encadeamento.** Os quatro itens de cada teste vêm de §9; o significado de "consistente" vem de §8 e §12.

---

## 16 · Violações das hipóteses: o quadro da seção 1

**Pergunta-tipo.** Consequências e diagnósticos de heterocedasticidade, autocorrelação, multicolinearidade, especificação e endogeneidade (ex. 8–14).

**Algoritmo.** Para cada violação, responda sempre na mesma ordem: qual hipótese cai, o que acontece com viés, consistência e eficiência, como se detecta, o que fazer.

| Violação | Hipótese | Viés | Consistência | O que mais cai | Diagnóstico |
|---|---|---|---|---|---|
| Heterocedasticidade | H4 | não | sim | eficiência; $ep$ usuais | Breusch-Pagan: $nR^2_{aux}\sim\chi^2(k-1)$ |
| Autocorrelação | H4 | não* | sim* | eficiência; $ep$ (subestimados se $\rho>0$) | Durbin-Watson: $d\approx 2(1-\widehat\rho)$ |
| Multicolinearidade perfeita | H3 | — | — | $\mathbf b$ não existe | $\det(\mathbf X'\mathbf X)=0$ |
| Multicolinearidade alta | nenhuma | não | sim | precisão ($VIF$ alto) | $VIF_k>10$ |
| Variável omitida correlacionada | H2 | sim | não | o parâmetro | teoria; RESET |
| Variável irrelevante | nenhuma | não | sim | precisão | teste $t$ |
| Forma funcional errada | H2 | sim | não | o parâmetro | RESET |
| Endogeneidade | H2 | sim | não | o parâmetro | Wu-Hausman |

\* com regressores estritamente exógenos; com $Y_{t-1}$ entre os regressores e erro autocorrelacionado, viesado e inconsistente (§8).

**Dois complementos.**

1. **Escala** (ex. 12). Multiplicar $Y$ por $c$ multiplica $\widehat\beta_2$ e $ep(\widehat\beta_2)$ por $c$; multiplicar $X$ por $c$ os divide por $c$. Em ambos os casos, $t$ e $R^2$ não mudam.
2. **Regressão espúria** (ex. 13). Séries não estacionárias independentes produzem $R^2$ alto e $t$ "significativos". Sintoma: $R^2$ maior que o DW. Remédio: diferenciar ou testar cointegração.

> [!IMPORTANT]
> **A frase que resume o quadro**
> Só a violação de H2 compromete viés e consistência. Heterocedasticidade e autocorrelação atacam H4, que só entra na variância (§5 e §6): perdem-se eficiência e os erros-padrão usuais.
