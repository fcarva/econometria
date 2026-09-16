---
title: "Módulo 03 — Álgebra matricial do MQO"
modulo: "03"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
greene: "cap. 2 (hipóteses); cap. 3 (§3.2); cap. 4 (§4.3.1); Ap. A.2–A.8"
slides: "SL03"
lista1: [23, 24, 28, 29, 30, 31, 34, 35]
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
  - Álgebra matricial do MQO
  - Residual maker
---

# Módulo 03 — Álgebra matricial do MQO

Hub do módulo: [README](README.md) · Exercícios: [03_lista1.md](03_lista1.md) · Script: [03_mqo_matricial.R](03_mqo_matricial.R)

## 0. Mapa

> [!NOTE]
> **O que este módulo entrega**
> A álgebra de mínimos quadrados em forma matricial: as derivadas matriciais, as equações normais com as dimensões conferidas, a condição de 2ª ordem, as matrizes $P$ e $M$ e o que sai delas ($e=My$, $\hat y=Py$, $X'e=0$, $e'e=y'y-b'X'y$), a geometria da projeção e o não-viés de $b$. O núcleo do aluno não é repetido: D13 (o $b$ por cálculo matricial) e D14 (a variância) são citados e completados. Tudo aqui é **álgebra pura**, válida em qualquer amostra só com [A2], exceto D03.10, que usa [A1]–[A3].

| D | Resultado | Hipóteses | Lista 1 / uso |
|---|---|---|---|
| D03.1 | Derivadas de $a'b$ e de $b'Ab$ | — | D03.2, D03.3 |
| D03.2 | Equações normais $X'Xb=X'y$, com as dimensões | — | ex. 23b; completa D13 |
| D03.3 | Condição de 2ª ordem: $X'X$ positiva definida | A2 | ex. 23b, 35 |
| D03.4 | $P$ e $M$: simetria, idempotência, $PX=X$, $MX=0$, $PM=0$, traços | A2 | ex. 28, 29; $s^2$ (módulo 06) |
| D03.5 | $e=My=M\varepsilon$ e $\hat y=Py$ | A2 (+A1 para $M\varepsilon$) | ex. 28, 29 |
| D03.6 | $X'e=0$ e as consequências com constante | A2 | ex. 31; ex. 17, 21 |
| D03.7 | $e'e=y'y-b'X'y$ e formas equivalentes | A2 | ex. 30, 34 |
| D03.8 | SQT = SQE + SQR via $M^0$ | A2 + constante | ex. 34; D05.2 |
| D03.9 | Geometria: projeção ortogonal e Pitágoras | A2 | figura |
| D03.10 | Não-viés: $E[b\mid X]=\beta$ e $E[b]=\beta$ | A1–A3 | ex. 24, 23c |
| D03.11 | Posto incompleto: $\det(X'X)=0$ e $b$ não identificado | falha de A2 | ex. 35 |

## 1. Notação e hipóteses

**Dimensões (conferir em todo produto).**

| Objeto | Dimensão | O que é |
|---|---|---|
| $y$, $\varepsilon$, $e$, $\hat y$ | $n\times 1$ | dependente, perturbações, resíduos, ajustados |
| $X$ | $n\times K$ | regressores; 1ª coluna $\iota$ (1s) quando há constante; a linha $i$ é $x_i'$ ($1\times K$) |
| $\beta$, $b$ | $K\times 1$ | parâmetros e estimador de MQO |
| $X'X=\sum_i x_ix_i'$ | $K\times K$ | simétrica; soma de $n$ matrizes de posto 1 |
| $X'y=\sum_i x_iy_i$ | $K\times 1$ | |
| $P=X(X'X)^{-1}X'$ | $n\times n$ | projeção no espaço coluna de $X$ |
| $M=I_n-P$ | $n\times n$ | *residual maker* |
| $M^0=I_n-\tfrac1n\iota\iota'$ | $n\times n$ | tira a média: $M^0a=a-\iota\bar a$ |

$\operatorname{col}(X)=\{Xc:\ c\in\mathbb R^K\}$ é o espaço coluna de $X$, com dimensão $K$ sob [A2].

**Hipóteses (Greene, cap. 2), na forma matricial.**

| Id | Enunciado | Onde entra aqui |
|---|---|---|
| A1 | $y=X\beta+\varepsilon$ | $e=M\varepsilon$ (D03.5); não-viés (D03.10) |
| A2 | $\operatorname{posto}(X)=K$ (colunas LI) | existência de $(X'X)^{-1}$, CSO, $P$ e $M$ (D03.3, D03.4) |
| A3 | $E[\varepsilon\mid X]=0$ | não-viés (D03.10) |
| A4 | $E[\varepsilon\varepsilon'\mid X]=\sigma^2I_n$ | só na variância (D14) e em $E[s^2\mid X]$ (módulo 06) |
| A5 | $X$ gerado independentemente de $\varepsilon$ (fixo ou aleatório) | permite condicionar em $X$ |
| A6 | $\varepsilon\mid X\sim N(0,\sigma^2I_n)$ | só na inferência exata (módulo 07) |

**Regras usadas nas justificativas.**
- Transposta: $(AB)'=B'A'$, $(ABC)'=C'B'A'$, $(A^{-1})'=(A')^{-1}$; a inversa de uma simétrica é simétrica (Greene, (A-62) e (A-63)).
- Um escalar ($1\times 1$) é igual à própria transposta.
- Traço: $\operatorname{tr}(AB)=\operatorname{tr}(BA)$ sempre que os dois produtos existem; o traço é linear; um escalar é igual ao próprio traço.
- Esperança condicional: se $A$ é função de $X$, $E[A\varepsilon\mid X]=A\,E[\varepsilon\mid X]$. Lei das expectativas iteradas (LEI): $E[E[b\mid X]]=E[b]$.
- Convenção de derivada: o gradiente de um escalar em relação a $b$ ($K\times 1$) é um vetor coluna $K\times 1$; a Hessiana $\partial^2S/\partial b\,\partial b'$ é $K\times K$.

**Graus de liberdade.** Convenção do Greene: $n-K$, com $K$ contando a constante. Na regressão simples da lista, $K=2$ e $n-K=n-2$.

## 2. Demonstrações

### D03.1 · Derivadas de formas lineares e quadráticas

> [!NOTE]
> **O que se quer provar**
> Sejam $b\in\mathbb R^K$, $a$ um vetor $K\times 1$ e $A$ uma matriz $K\times K$, ambos sem depender de $b$. Então (i) $\partial(a'b)/\partial b=\partial(b'a)/\partial b=a$; (ii) $\partial(b'Ab)/\partial b=(A+A')b$, que vale $2Ab$ quando $A=A'$; (iii) $\partial^2(b'Ab)/\partial b\,\partial b'=A+A'$.

**Por que importa.** É o kit que D13 usa sem provar (SL03, p. 9; Greene, Ap. A.8.1, (A-131) e (A-132)). Na prova, escrever "regra (ii) com $A=X'X$, que é simétrica" ao derivar $b'X'Xb$ é o tipo de justificativa que vale ponto.

**Passo a passo.**

1. Pela convenção da seção 1, o gradiente $\partial f/\partial b$ é o vetor coluna cujo elemento $j$ é $\partial f/\partial b_j$.

2. Regra (i). Escreva o produto interno como soma. Na derivada em $b_j$ só sobra o termo $k=j$:

$$
a'b=\sum_{k=1}^K a_kb_k\quad\Longrightarrow\quad \frac{\partial(a'b)}{\partial b_j}=a_j\quad\Longrightarrow\quad \frac{\partial(a'b)}{\partial b}=a.
$$

Como $b'a$ é o mesmo escalar que $a'b$, a derivada é a mesma.

3. Regra (ii). Escreva a forma quadrática como soma dupla. A derivada em $b_j$ pega os termos com $i=j$ e os termos com $k=j$ (regra do produto):

$$
b'Ab=\sum_{i=1}^K\sum_{k=1}^K b_iA_{ik}b_k\quad\Longrightarrow\quad \frac{\partial(b'Ab)}{\partial b_j}=\sum_{k}A_{jk}b_k+\sum_{i}b_iA_{ij}=(Ab)_j+(A'b)_j.
$$

Empilhando $j=1,\dots,K$, o gradiente é $(A+A')b$. Se $A=A'$, é $2Ab$.

4. Regra (iii). Cada componente do gradiente, $g_j=\sum_k(A+A')_{jk}b_k$, é linear em $b$, então $\partial g_j/\partial b_k=(A+A')_{jk}$. A matriz $K\times K$ dessas derivadas é $A+A'$.

$$
\boxed{\frac{\partial(a'b)}{\partial b}=a,\qquad \frac{\partial(b'Ab)}{\partial b}=(A+A')b\ \overset{A=A'}{=}\ 2Ab,\qquad \frac{\partial^2(b'Ab)}{\partial b\,\partial b'}=A+A'.}
$$

> [!WARNING]
> **Duas convenções para derivar um vetor**
> O SL03 (p. 9) e o Greene escrevem $\partial(Ab)/\partial b=A'$, empilhando os gradientes de cada componente em colunas. A convenção "jacobiana" escreve $\partial(Ab)/\partial b'=A$. As duas descrevem as mesmas derivadas, só arrumadas de outro jeito. O que não pode falhar: o gradiente de um escalar tem dimensão $K\times 1$, e cada termo da condição de 1ª ordem também.

> [!TIP]
> **Como o professor pode torcer**
> - "Derive $b'Ab$ sem supor $A$ simétrica": a resposta é $(A+A')b$. Para $b'X'Xb$ tanto faz, porque $(X'X)'=X'X$.
> - "Derive $y'Xb$ em relação a $b$": escreva $y'Xb=(X'y)'b$ e use a regra (i) com $a=X'y$. Resultado: $X'y$.
> - Com $K=1$ as regras viram $d(ab)/db=a$ e $d(Ab^2)/db=2Ab$, que é o cálculo escalar de D3.

### D03.2 · Equações normais com checagem de dimensões

> [!NOTE]
> **O que se quer provar**
> Seja $S(b)=(y-Xb)'(y-Xb)$. A condição de 1ª ordem de $\min_b S(b)$ é o sistema de $K$ equações $X'Xb=X'y$, equivalente a $X'(y-Xb)=0$. Sob [A2], a solução é $b=(X'X)^{-1}X'y$.

**Por que importa.** D13 faz a dedução. Aqui entram o que faltava: a dimensão de cada termo, a forma de somatório (SL03, p. 10) e a leitura como princípio da analogia (SL03, pp. 5 e 12). É o item (b) do ex. 23.

**Passo a passo.**

1. Dimensões. $y-Xb$ é $(n\times 1)-(n\times K)(K\times 1)=n\times 1$. Logo $S(b)=(1\times n)(n\times 1)$ é um escalar.

2. Expanda, usando $(Xb)'=b'X'$ *[transposta do produto]*. Os quatro termos são $1\times 1$:

$$
S(b)=\underbrace{y'y}_{(1\times n)(n\times 1)}-\underbrace{y'Xb}_{(1\times n)(n\times K)(K\times 1)}-\underbrace{b'X'y}_{(1\times K)(K\times n)(n\times 1)}+\underbrace{b'X'Xb}_{(1\times K)(K\times K)(K\times 1)}.
$$

3. $y'Xb$ é escalar, logo igual à própria transposta: $y'Xb=(y'Xb)'=b'X'y$ *[$(ABC)'=C'B'A'$]*. Então

$$
S(b)=y'y-2\,b'X'y+b'(X'X)\,b.
$$

4. Derive termo a termo. $y'y$ não depende de $b$. Para o termo linear, use D03.1(i) com $a=X'y$ ($K\times 1$). Para o quadrático, D03.1(ii) com $A=X'X$, que é simétrica porque $(X'X)'=X'(X')'=X'X$:

$$
\frac{\partial S}{\partial b}=0-2X'y+2X'Xb=-2X'(y-Xb)\qquad(K\times 1).
$$

5. Iguale a zero no ótimo $b$ e divida por $-2$. São $K$ equações lineares em $K$ incógnitas:

$$
X'Xb=X'y\quad\Longleftrightarrow\quad X'e=0,\qquad e=y-Xb.
$$

6. Forma de somatório. Como $X'X=\sum_i x_ix_i'$ e $X'y=\sum_i x_iy_i$, as equações normais dizem $\sum_i x_i(y_i-x_i'b)=0$. É o análogo amostral de $E[x_i\varepsilon_i]=0$: $b=\big(\tfrac1n X'X\big)^{-1}\big(\tfrac1n X'y\big)$ troca momentos populacionais por amostrais (SL03, p. 12).

7. Conferência com D3. Com $X=[\iota\;\;x]$ ($K=2$):

$$
X'X=\begin{bmatrix} n & \sum x_i\\ \sum x_i & \sum x_i^2\end{bmatrix},\qquad X'y=\begin{bmatrix}\sum y_i\\ \sum x_iy_i\end{bmatrix},
$$

e as duas linhas de $X'Xb=X'y$ são exatamente EN-1 e EN-2.

8. Sob [A2], $X'X$ é inversível (D03.3). Pré-multiplique por $(X'X)^{-1}$:

$$
\boxed{X'Xb=X'y\quad\Longrightarrow\quad b=(X'X)^{-1}X'y\qquad (K\times K)(K\times n)(n\times 1)=K\times 1.}
$$

> [!TIP]
> **Como o professor pode torcer**
> - "Obtenha as equações normais sem regras de derivada matricial": derive a soma observação por observação, $\partial\sum_i(y_i-x_i'b)^2/\partial b=\sum_i 2(y_i-x_i'b)(-x_i)=-2X'y+2X'Xb$ (regra da cadeia; é a rota do SL03, p. 10).
> - "Por que não $b=X^{-1}y$?" Porque $X$ é $n\times K$, não é quadrada. Só $X'X$ ($K\times K$) pode ser invertida. Também não vale $(X'X)^{-1}=X^{-1}(X')^{-1}$: a regra $(AB)^{-1}=B^{-1}A^{-1}$ exige fatores quadrados e inversíveis (Greene, (A-64)).
> - "E sem constante?" A linha de $\iota$ some de $X'X$ e, com ela, a equação $\sum e_i=0$ (D03.6).

### D03.3 · Condição de 2ª ordem: X'X é positiva definida sob A2

> [!NOTE]
> **O que se quer provar**
> Se $\operatorname{posto}(X)=K$ *[A2]*, então $v'X'Xv>0$ para todo $v\neq 0$. Logo a Hessiana $2X'X$ é positiva definida, $X'X$ é inversível e $b$ é o **único minimizador global** de $S(b)$.

**Por que importa.** D13 (Etapa 6) só afirma. Aqui vai a prova completa, a do SL03, p. 15. É o único lugar em que [A2] entra na álgebra de $b$, e é o que falha no ex. 35.

**Passo a passo.**

1. A Hessiana vem de D03.1(iii) aplicada ao gradiente de D03.2. O termo $-2X'y$ não depende de $b$:

$$
\frac{\partial^2 S}{\partial b\,\partial b'}=\frac{\partial(-2X'y+2X'Xb)}{\partial b'}=2X'X\qquad(K\times K).
$$

Ela não depende de $b$: $S$ é uma função quadrática.

2. Tome qualquer $v\in\mathbb R^K$ e defina $w=Xv$ ($n\times 1$). Então

$$
v'X'Xv=(Xv)'(Xv)=w'w=\sum_{i=1}^n w_i^2=\sum_{i=1}^n (x_i'v)^2\ \ge\ 0.
$$

Isso vale sempre: $X'X$ é, no mínimo, positiva **semi**definida.

3. $w'w=0$ só se $w=0$, isto é, $Xv=0$. Mas $Xv=\sum_k v_kx_{(k)}$ é uma combinação linear das colunas $x_{(k)}$ de $X$. Por [A2] elas são LI, então $Xv=0$ implica $v=0$. Logo, para $v\neq 0$, $v'X'Xv>0$: $X'X$ é **positiva definida**.

4. Positiva definida implica inversível. Se $X'Xv=0$ para algum $v\neq 0$, então $v'X'Xv=0$, o que contradiz o passo 3. Portanto $(X'X)^{-1}$ existe e $\det(X'X)$, o produto dos autovalores, todos positivos, é $>0$.

5. Mínimo global e único. Uma quadrática com Hessiana positiva definida é estritamente convexa: o ponto estacionário de D03.2 é o único mínimo global. A mesma conclusão sai sem derivada pela identidade de D05.1:

$$
\boxed{S(\tilde b)=S(b)+(\tilde b-b)'X'X(\tilde b-b)\ >\ S(b)\quad\text{para todo }\tilde b\neq b.}
$$

**Conferência numérica.** No ex. 34, os autovalores de $X'X$ são 224,1076 e 0,8924, ambos positivos. O produto é 200 ($=\det$) e a soma é 225 ($=\operatorname{tr}$). A identidade do passo 5 confere até o erro de arredondamento (tabela ao fim da seção 2).

> [!TIP]
> **Como o professor pode torcer**
> - "E sem [A2]?" Existe $v\neq 0$ com $v'X'Xv=0$: $X'X$ é semidefinida e singular, e $S$ tem um "vale plano", com infinitos minimizadores (D03.11, ex. 35).
> - "Use os menores principais": com $K=2$, $2n>0$ e $\det(2X'X)=4n\sum(x_i-\bar x)^2>0$. É o D7 do aluno. A prova com $\lVert Xv\rVert^2$ vale para qualquer $K$.
> - Multicolinearidade **imperfeita**: o menor autovalor fica perto de zero. $X'X$ continua positiva definida, mas $(X'X)^{-1}$ fica grande, e a variância explode (D15, módulo 06).

### D03.4 · Propriedades de P e M

> [!NOTE]
> **O que se quer provar**
> Sob [A2], com $P=X(X'X)^{-1}X'$ e $M=I_n-P$ (ambas $n\times n$): (a) $P'=P$ e $M'=M$; (b) $PP=P$ e $MM=M$; (c) $PX=X$ e $MX=0$; (d) $PM=MP=0$; (e) $P+M=I_n$; (f) $\operatorname{tr}(P)=K$ e $\operatorname{tr}(M)=n-K$; (g) $\operatorname{posto}(P)=K$ e $\operatorname{posto}(M)=n-K$, então $M$ é singular.

**Por que importa.** O item (c) é a chave do ex. 28 ($e=M\varepsilon$). O item (f) é a chave de $E[s^2\mid X]=\sigma^2$ (módulo 06). Os itens (a) e (b) transformam $e'e$ em $y'My$ (ex. 30). SL03, pp. 18–19.

**Passo a passo.**

1. (a) Simetria. Use $(ABC)'=C'B'A'$ e o fato de a inversa de uma simétrica ser simétrica *[(A-62), (A-63)]*:

$$
P'=\big[X(X'X)^{-1}X'\big]'=(X')'\big[(X'X)^{-1}\big]'X'=X(X'X)^{-1}X'=P,\qquad M'=I_n'-P'=I_n-P=M.
$$

2. (b) Idempotência. O $(X'X)$ do meio cancela com uma das inversas:

$$
PP=X(X'X)^{-1}\underbrace{(X'X)(X'X)^{-1}}_{I_K}X'=P,\qquad MM=(I-P)(I-P)=I-2P+PP=I-P=M.
$$

3. (c) $PX=X(X'X)^{-1}(X'X)=X$ ($n\times K$) e $MX=X-PX=0$ ($n\times K$). Leitura: regredir cada coluna de $X$ em $X$ dá ajuste perfeito e resíduo nulo.

4. (d) $PM=P(I-P)=P-PP=0$ pelo item (b). E $MP=(P'M')'=(PM)'=0$ pelo item (a).

5. (e) É a definição de $M$. Dela vem $y=Py+My$ para todo $y$.

6. (f) Traço. Use $\operatorname{tr}(AB)=\operatorname{tr}(BA)$ com $A=X$ ($n\times K$) e $B=(X'X)^{-1}X'$ ($K\times n$). O produto $AB$ é $n\times n$ e $BA$ é $K\times K$:

$$
\operatorname{tr}(P)=\operatorname{tr}\big[X\,(X'X)^{-1}X'\big]=\operatorname{tr}\big[(X'X)^{-1}X'X\big]=\operatorname{tr}(I_K)=K,\qquad \operatorname{tr}(M)=\operatorname{tr}(I_n)-\operatorname{tr}(P)=n-K.
$$

7. (g) Posto. Os autovalores de uma matriz idempotente são 0 ou 1: se $Pv=\lambda v$ com $v\neq 0$, então $\lambda v=Pv=PPv=\lambda^2v$, logo $\lambda\in\{0,1\}$. Como $P$ é simétrica, é diagonalizável, e o posto é o número de autovalores iguais a 1, que é o traço. Então $\operatorname{posto}(P)=K$ e $\operatorname{posto}(M)=n-K<n$: **$M$ não tem inversa**. Outra forma de ver: $MX=0$ com as $K$ colunas de $X$ LI, então $M$ anula $K$ vetores LI.

$$
\boxed{P=P'=P^2,\quad M=M'=M^2,\quad PX=X,\quad MX=0,\quad PM=0,\quad \operatorname{tr}P=K,\quad \operatorname{tr}M=n-K.}
$$

**Diagonal de $P$ (alavancagem).** $h_{ii}=x_i'(X'X)^{-1}x_i$. Como $P$ é simétrica e idempotente, $h_{ii}=\sum_j p_{ij}^2\ge h_{ii}^2$, logo $0\le h_{ii}\le 1$. E $\sum_i h_{ii}=\operatorname{tr}(P)=K$. No ex. 34, $h=(0{,}6;\ 0{,}3;\ 0{,}2;\ 0{,}3;\ 0{,}6)$, que soma $2=K$.

> [!TIP]
> **Como o professor pode torcer**
> - "Por que $s^2$ divide por $n-K$?" Pelo item (f): $E[e'e\mid X]=E[\varepsilon'M\varepsilon\mid X]=E[\operatorname{tr}(M\varepsilon\varepsilon')\mid X]=\operatorname{tr}(M\,E[\varepsilon\varepsilon'\mid X])=\sigma^2\operatorname{tr}(M)=\sigma^2(n-K)$. Os passos usam D03.7, "escalar = traço", $\operatorname{tr}(AB)=\operatorname{tr}(BA)$, a linearidade de $E$ e do traço, e [A4]. A prova completa está no módulo 06.
> - "$M$ é inversível?" Não: tem posto $n-K$. Qualquer passo que "divide por $M$" está errado.
> - $M^0$ é o $M$ da regressão só na constante: com $X=\iota$, $(\iota'\iota)^{-1}=1/n$ e $P=\tfrac1n\iota\iota'$.

<!-- PENDENTE: D03.5 a D03.11 e tabela numérica -->

## 3. Como cai na prova

<!-- PENDENTE -->

## 4. Interpretação de output

<!-- PENDENTE -->

## 5. Armadilhas

<!-- PENDENTE -->

## 6. Checklist

<!-- PENDENTE -->

## 7. Referências

<!-- PENDENTE -->
