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
> A álgebra de mínimos quadrados em forma matricial: as derivadas matriciais, as equações normais com as dimensões conferidas, a condição de 2ª ordem, as matrizes $\mathbf P$ e $\mathbf M$ e o que sai delas ($\mathbf e=\mathbf M\mathbf y$, $\widehat{\mathbf y}=\mathbf P\mathbf y$, $\mathbf X'\mathbf e=0$, $\mathbf e'\mathbf e=\mathbf y'\mathbf y-\mathbf b'\mathbf X'\mathbf y$), a geometria da projeção e o não-viés de $\mathbf b$. O núcleo do aluno não é repetido: D13 (o $\mathbf b$ por cálculo matricial) e D14 (a variância) são citados e completados. Tudo aqui é **álgebra pura**, válida em qualquer amostra só com [H3], exceto D03.10, que usa H1–H3.

| D | Resultado | Hipóteses | Lista 1 / uso |
|---|---|---|---|
| D03.1 | Derivadas de $\mathbf a'\mathbf b$ e de $\mathbf b'\mathbf A\mathbf b$ | — | D03.2, D03.3 |
| D03.2 | Equações normais $\mathbf X'\mathbf X\mathbf b=\mathbf X'\mathbf y$, com as dimensões | — | ex. 23b; completa D13 |
| D03.3 | Condição de 2ª ordem: $\mathbf X'\mathbf X$ positiva definida | H3 | ex. 23b, 35 |
| D03.4 | $\mathbf P$ e $\mathbf M$: simetria, idempotência, $\mathbf P\mathbf X=\mathbf X$, $\mathbf M\mathbf X=0$, $\mathbf P\mathbf M=0$, traços | H3 | ex. 28, 29; $s^2$ (módulo 06) |
| D03.5 | $e=My=M\varepsilon$ e $\widehat y=Py$ | H3 (+H1 para $M\varepsilon$) | ex. 28, 29 |
| D03.6 | $\mathbf X'\mathbf e=0$ e as consequências com constante | H3 | ex. 31; ex. 17, 21 |
| D03.7 | $\mathbf e'\mathbf e=\mathbf y'\mathbf y-\mathbf b'\mathbf X'\mathbf y$ e formas equivalentes | H3 | ex. 30, 34 |
| D03.8 | SQT = SQE + SQR via $M^0$ | H3 + constante | ex. 34; D05.2 |
| D03.9 | Geometria: projeção ortogonal e Pitágoras | H3 | figura |
| D03.10 | Não-viés: $E(b\mid X)=\beta$ e $E(b)=\beta$ | H1–H3 | ex. 24, 23c |
| D03.11 | Posto incompleto: $\det(\mathbf X'\mathbf X)=0$ e $\mathbf b$ não identificado | falha de H3 | ex. 35 |

## 1. Notação e hipóteses

**Dimensões (conferir em todo produto).**

| Objeto | Dimensão | O que é |
|---|---|---|
| $\mathbf y$, $\varepsilon$, $\mathbf e$, $\widehat{\mathbf y}$ | $n\times 1$ | dependente, perturbações, resíduos, ajustados |
| $\mathbf X$ | $n\times K$ | regressores; 1ª coluna $\iota$ (1s) quando há constante; a linha $i$ é $\mathbf x_i'$ ($1\times K$) |
| $\beta$, $\mathbf b$ | $K\times 1$ | parâmetros e estimador de MQO |
| $\mathbf X'\mathbf X=\sum_i \mathbf x_i\mathbf x_i'$ | $K\times K$ | simétrica; soma de $n$ matrizes de posto 1 |
| $\mathbf X'\mathbf y=\sum_i x_iy_i$ | $K\times 1$ | |
| $\mathbf P=\mathbf X(\mathbf X'\mathbf X)^{-1}\mathbf X'$ | $n\times n$ | projeção no espaço coluna de $\mathbf X$ |
| $M=I_n-P$ | $n\times n$ | *residual maker* |
| $\mathbf M^0=\mathbf I_n-\tfrac1n\iota\iota'$ | $n\times n$ | tira a média: $\mathbf M^0a=a-\iota\bar a$ |

$\operatorname{col}(\mathbf X)=\{\mathbf{X}c:\ c\in\mathbb R^K\}$ é o espaço coluna de $\mathbf X$, com dimensão $K$ sob [H3].

**Hipóteses (Greene, cap. 2), na forma matricial.**

| Id | Enunciado | Onde entra aqui |
|---|---|---|
| H1 | $y=X\beta+\varepsilon$ | $e=M\varepsilon$ (D03.5); não-viés (D03.10) |
| H3 | $\operatorname{posto}(\mathbf X)=K$ (colunas LI) | existência de $(\mathbf X'\mathbf X)^{-1}$, CSO, $\mathbf P$ e $\mathbf M$ (D03.3, D03.4) |
| H2 | $E(\varepsilon\mid X)=0$ | não-viés (D03.10) |
| H4 | $E(\varepsilon\varepsilon'\mid X)=\sigma^2I_n$ | só na variância (D14) e em $E(s^2\mid X)$ (módulo 06) |
| H2 | $X$ gerado independentemente de $\varepsilon$ (fixo ou aleatório) | permite condicionar em $X$ |
| H5 | $\varepsilon\mid X\sim N(0,\sigma^2I_n)$ | só na inferência exata (módulo 07) |

**Regras usadas nas justificativas.**
- Transposta: $(\mathbf A\mathbf B)'=\mathbf B'\mathbf A'$, $(\mathbf A\mathbf B\mathbf C)'=\mathbf C'\mathbf B'\mathbf A'$, $(\mathbf A^{-1})'=(\mathbf A')^{-1}$; a inversa de uma simétrica é simétrica (Greene, (A-62) e (A-63)).
- Um escalar ($1\times 1$) é igual à própria transposta.
- Traço: $\operatorname{tr}(AB)=\operatorname{tr}(BA)$ sempre que os dois produtos existem; o traço é linear; um escalar é igual ao próprio traço.
- Esperança condicional: se $\mathbf A$ é função de $\mathbf X$, $E(\mathbf A\varepsilon\mid \mathbf X)=\mathbf A\,E(\varepsilon\mid \mathbf X)$. Lei das expectativas iteradas (LEI): $E(E(\mathbf b\mid \mathbf X))=E(\mathbf b)$.
- Convenção de derivada: o gradiente de um escalar em relação a $\mathbf b$ ($K\times 1$) é um vetor coluna $K\times 1$; a Hessiana $\partial^2S/\partial \mathbf b\,\partial \mathbf b'$ é $K\times K$.

**Graus de liberdade.** Convenção do Greene: $n-K$, com $K$ contando a constante. Na regressão simples da lista, $K=2$ e $n-K=n-2$.

## 2. Demonstrações

### D03.1 · Derivadas de formas lineares e quadráticas

> [!NOTE]
> **O que se quer provar**
> Sejam $\mathbf b\in\mathbb R^K$, $a$ um vetor $K\times 1$ e $\mathbf A$ uma matriz $K\times K$, ambos sem depender de $\mathbf b$. Então (i) $\partial(\mathbf a'\mathbf b)/\partial \mathbf b=\partial(\mathbf b'\mathbf a)/\partial \mathbf b=\mathbf a$; (ii) $\partial(\mathbf b'\mathbf A\mathbf b)/\partial \mathbf b=(\mathbf A+\mathbf A')\mathbf b$, que vale $2\mathbf A\mathbf b$ quando $\mathbf A=\mathbf A'$; (iii) $\partial^2(\mathbf b'\mathbf A\mathbf b)/\partial \mathbf b\,\partial \mathbf b'=\mathbf A+\mathbf A'$.

**Por que importa.** É o kit que D13 usa sem provar (SL03, p. 9; Greene, Ap. A.8.1, (A-131) e (A-132)). Na prova, escrever "regra (ii) com $\mathbf A=\mathbf X'\mathbf X$, que é simétrica" ao derivar $\mathbf b'\mathbf X'\mathbf X\mathbf b$ é o tipo de justificativa que vale ponto.

**Passo a passo.**

1. Pela convenção da seção 1, o gradiente $\partial f/\partial b$ é o vetor coluna cujo elemento $j$ é $\partial f/\partial b_j$.

2. Regra (i). Escreva o produto interno como soma. Na derivada em $b_j$ só sobra o termo $k=j$:

$$
a'b=\sum_{k=1}^K a_kb_k\quad\Longrightarrow\quad \frac{\partial(a'b)}{\partial b_j}=a_j\quad\Longrightarrow\quad \frac{\partial(a'b)}{\partial b}=a.
$$

Como $\mathbf b'a$ é o mesmo escalar que $\mathbf a'\mathbf b$, a derivada é a mesma.

3. Regra (ii). Escreva a forma quadrática como soma dupla. A derivada em $b_j$ pega os termos com $i=j$ e os termos com $k=j$ (regra do produto):

$$
\mathbf b'\mathbf A\mathbf b=\sum_{i=1}^K\sum_{k=1}^K b_iA_{ik}b_k\quad\Longrightarrow\quad \frac{\partial(\mathbf b'\mathbf A\mathbf b)}{\partial b_j}=\sum_{k}A_{jk}b_k+\sum_{i}b_iA_{ij}=(\mathbf A\mathbf b)_j+(\mathbf A'\mathbf b)_j.
$$

Empilhando $j=1,\dots,K$, o gradiente é $(\mathbf A+\mathbf A')\mathbf b$. Se $\mathbf A=\mathbf A'$, é $2\mathbf A\mathbf b$.

4. Regra (iii). Cada componente do gradiente, $g_j=\sum_k(\mathbf A+\mathbf A')_{jk}b_k$, é linear em $\mathbf b$, então $\partial g_j/\partial b_k=(\mathbf A+\mathbf A')_{jk}$. A matriz $K\times K$ dessas derivadas é $\mathbf A+\mathbf A'$.

$$
\boxed{\frac{\partial(\mathbf a'\mathbf b)}{\partial \mathbf b}=\mathbf a,\qquad \frac{\partial(\mathbf b'\mathbf A\mathbf b)}{\partial \mathbf b}=(\mathbf A+\mathbf A')\mathbf b\ \overset{\mathbf A=\mathbf A'}{=}\ 2\mathbf A\mathbf b,\qquad \frac{\partial^2(\mathbf b'\mathbf A\mathbf b)}{\partial \mathbf b\,\partial \mathbf b'}=\mathbf A+\mathbf A'.}
$$

> [!WARNING]
> **Duas convenções para derivar um vetor**
> O SL03 (p. 9) e o Greene escrevem $\partial(\mathbf A\mathbf b)/\partial \mathbf b=\mathbf A'$, empilhando os gradientes de cada componente em colunas. A convenção "jacobiana" escreve $\partial(\mathbf A\mathbf b)/\partial \mathbf b'=\mathbf A$. As duas descrevem as mesmas derivadas, só arrumadas de outro jeito. O que não pode falhar: o gradiente de um escalar tem dimensão $K\times 1$, e cada termo da condição de 1ª ordem também.

> [!TIP]
> **Como o professor pode torcer**
> - "Derive $\mathbf b'\mathbf A\mathbf b$ sem supor $\mathbf A$ simétrica": a resposta é $(\mathbf A+\mathbf A')\mathbf b$. Para $\mathbf b'\mathbf X'\mathbf X\mathbf b$ tanto faz, porque $(\mathbf X'\mathbf X)'=\mathbf X'\mathbf X$.
> - "Derive $\mathbf y'\mathbf X\mathbf b$ em relação a $\mathbf b$": escreva $\mathbf y'\mathbf X\mathbf b=(\mathbf X'\mathbf y)'\mathbf b$ e use a regra (i) com $a=\mathbf X'\mathbf y$. Resultado: $\mathbf X'\mathbf y$.
> - Com $K=1$ as regras viram $d(ab)/db=a$ e $d(Ab^2)/db=2Ab$, que é o cálculo escalar de D3.

### D03.2 · Equações normais com checagem de dimensões

> [!NOTE]
> **O que se quer provar**
> Seja $S(\mathbf b)=(\mathbf y-\mathbf X\mathbf b)'(\mathbf y-\mathbf X\mathbf b)$. A condição de 1ª ordem de $\min_{\mathbf b} S(\mathbf b)$ é o sistema de $K$ equações $\mathbf X'\mathbf X\mathbf b=\mathbf X'\mathbf y$, equivalente a $\mathbf X'(\mathbf y-\mathbf X\mathbf b)=0$. Sob [H3], a solução é $\mathbf b=(\mathbf X'\mathbf X)^{-1}\mathbf X'\mathbf y$.

**Por que importa.** D13 faz a dedução. Aqui entram o que faltava: a dimensão de cada termo, a forma de somatório (SL03, p. 10) e a leitura como princípio da analogia (SL03, pp. 5 e 12). É o item (b) do ex. 23.

**Passo a passo.**

1. Dimensões. $y-Xb$ é $(n\times 1)-(n\times K)(K\times 1)=n\times 1$. Logo $S(b)=(1\times n)(n\times 1)$ é um escalar.

2. Expanda, usando $(\mathbf X\mathbf b)'=\mathbf b'\mathbf X'$ *[transposta do produto]*. Os quatro termos são $1\times 1$:

$$
S(\mathbf b)=\underbrace{\mathbf y'\mathbf y}_{(1\times n)(n\times 1)}-\underbrace{\mathbf y'\mathbf X\mathbf b}_{(1\times n)(n\times K)(K\times 1)}-\underbrace{\mathbf b'\mathbf X'\mathbf y}_{(1\times K)(K\times n)(n\times 1)}+\underbrace{\mathbf b'\mathbf X'\mathbf X\mathbf b}_{(1\times K)(K\times K)(K\times 1)}.
$$

3. $\mathbf y'\mathbf X\mathbf b$ é escalar, logo igual à própria transposta: $\mathbf y'\mathbf X\mathbf b=(\mathbf y'\mathbf X\mathbf b)'=\mathbf b'\mathbf X'\mathbf y$ *[$(\mathbf A\mathbf B\mathbf C)'=\mathbf C'\mathbf B'\mathbf A'$]*. Então

$$
S(\mathbf b)=\mathbf y'\mathbf y-2\,\mathbf b'\mathbf X'\mathbf y+\mathbf b'(\mathbf X'\mathbf X)\,\mathbf b.
$$

4. Derive termo a termo. $\mathbf y'\mathbf y$ não depende de $\mathbf b$. Para o termo linear, use D03.1(i) com $a=\mathbf X'\mathbf y$ ($K\times 1$). Para o quadrático, D03.1(ii) com $\mathbf A=\mathbf X'\mathbf X$, que é simétrica porque $(\mathbf X'\mathbf X)'=\mathbf X'(\mathbf X')'=\mathbf X'\mathbf X$:

$$
\frac{\partial S}{\partial \mathbf b}=0-2\mathbf X'\mathbf y+2\mathbf X'\mathbf X\mathbf b=-2\mathbf X'(\mathbf y-\mathbf X\mathbf b)\qquad(K\times 1).
$$

5. Iguale a zero no ótimo $\mathbf b$ e divida por $-2$. São $K$ equações lineares em $K$ incógnitas:

$$
\mathbf X'\mathbf X\mathbf b=\mathbf X'\mathbf y\quad\Longleftrightarrow\quad \mathbf X'\mathbf e=0,\qquad \mathbf e=\mathbf y-\mathbf X\mathbf b.
$$

6. Forma de somatório. Como $\mathbf X'\mathbf X=\sum_i \mathbf x_i\mathbf x_i'$ e $\mathbf X'\mathbf y=\sum_i \mathbf x_iy_i$, as equações normais dizem $\sum_i \mathbf x_i(y_i-\mathbf x_i'\mathbf b)=0$. É o análogo amostral de $E(\mathbf x_i\varepsilon_i)=0$: $\mathbf b=\big(\tfrac1n \mathbf X'\mathbf X\big)^{-1}\big(\tfrac1n \mathbf X'\mathbf y\big)$ troca momentos populacionais por amostrais (SL03, p. 12).

7. Conferência com D3. Com $\mathbf X=[\iota\;\;x]$ ($K=2$):

$$
\mathbf X'\mathbf X=\begin{bmatrix} n & \sum x_i\\ \sum x_i & \sum x_i^2\end{bmatrix},\qquad \mathbf X'\mathbf y=\begin{bmatrix}\sum y_i\\ \sum x_iy_i\end{bmatrix},
$$

e as duas linhas de $\mathbf X'\mathbf X\mathbf b=\mathbf X'\mathbf y$ são exatamente EN-1 e EN-2.

8. Sob [H3], $\mathbf X'\mathbf X$ é inversível (D03.3). Pré-multiplique por $(\mathbf X'\mathbf X)^{-1}$:

$$
\boxed{\mathbf X'\mathbf X\mathbf b=\mathbf X'\mathbf y\quad\Longrightarrow\quad \mathbf b=(\mathbf X'\mathbf X)^{-1}\mathbf X'\mathbf y\qquad (K\times K)(K\times n)(n\times 1)=K\times 1.}
$$

> [!TIP]
> **Como o professor pode torcer**
> - "Obtenha as equações normais sem regras de derivada matricial": derive a soma observação por observação, $\partial\sum_i(y_i-\mathbf x_i'\mathbf b)^2/\partial \mathbf b=\sum_i 2(y_i-\mathbf x_i'\mathbf b)(-\mathbf x_i)=-2\mathbf X'\mathbf y+2\mathbf X'\mathbf X\mathbf b$ (regra da cadeia; é a rota do SL03, p. 10).
> - "Por que não $\mathbf b=\mathbf X^{-1}\mathbf y$?" Porque $\mathbf X$ é $n\times K$, não é quadrada. Só $\mathbf X'\mathbf X$ ($K\times K$) pode ser invertida. Também não vale $(\mathbf X'\mathbf X)^{-1}=\mathbf X^{-1}(\mathbf X')^{-1}$: a regra $(\mathbf A\mathbf B)^{-1}=\mathbf B^{-1}\mathbf A^{-1}$ exige fatores quadrados e inversíveis (Greene, (A-64)).
> - "E sem constante?" A linha de $\iota$ some de $\mathbf X'\mathbf X$ e, com ela, a equação $\sum e_i=0$ (D03.6).

### D03.3 · Condição de 2ª ordem: X'X é positiva definida sob H3

> [!NOTE]
> **O que se quer provar**
> Se $\operatorname{posto}(\mathbf X)=K$ *[H3]*, então $v'\mathbf X'Xv>0$ para todo $v\neq 0$. Logo a Hessiana $2\mathbf X'\mathbf X$ é positiva definida, $\mathbf X'\mathbf X$ é inversível e $\mathbf b$ é o **único minimizador global** de $S(\mathbf b)$.

**Por que importa.** D13 (Etapa 6) só afirma. Aqui vai a prova completa, a do SL03, p. 15. É o único lugar em que [H3] entra na álgebra de $\mathbf b$, e é o que falha no ex. 35.

**Passo a passo.**

1. A Hessiana vem de D03.1(iii) aplicada ao gradiente de D03.2. O termo $-2\mathbf X'\mathbf y$ não depende de $\mathbf b$:

$$
\frac{\partial^2 S}{\partial \mathbf b\,\partial \mathbf b'}=\frac{\partial(-2\mathbf X'\mathbf y+2\mathbf X'\mathbf X\mathbf b)}{\partial \mathbf b'}=2\mathbf X'\mathbf X\qquad(K\times K).
$$

Ela não depende de $\mathbf b$: $S$ é uma função quadrática.

2. Tome qualquer $v\in\mathbb R^K$ e defina $w=Xv$ ($n\times 1$). Então

$$
v'\mathbf X'Xv=(Xv)'(Xv)=w'w=\sum_{i=1}^n w_i^2=\sum_{i=1}^n (\mathbf x_i'v)^2\ \ge\ 0.
$$

Isso vale sempre: $\mathbf X'\mathbf X$ é, no mínimo, positiva **semi**definida.

3. $w'w=0$ só se $w=0$, isto é, $Xv=0$. Mas $Xv=\sum_k v_kx_{(k)}$ é uma combinação linear das colunas $x_{(k)}$ de $\mathbf X$. Por [H3] elas são LI, então $Xv=0$ implica $v=0$. Logo, para $v\neq 0$, $v'\mathbf X'Xv>0$: $\mathbf X'\mathbf X$ é **positiva definida**.

4. Positiva definida implica inversível. Se $\mathbf X'Xv=0$ para algum $v\neq 0$, então $v'\mathbf X'Xv=0$, o que contradiz o passo 3. Portanto $(\mathbf X'\mathbf X)^{-1}$ existe e $\det(\mathbf X'\mathbf X)$, o produto dos autovalores, todos positivos, é $>0$.

5. Mínimo global e único. Uma quadrática com Hessiana positiva definida é estritamente convexa: o ponto estacionário de D03.2 é o único mínimo global. A mesma conclusão sai sem derivada pela identidade de D05.1:

$$
\boxed{S(\tilde b)=S(\mathbf b)+(\tilde b-\mathbf b)'\mathbf X'\mathbf X(\tilde b-\mathbf b)\ >\ S(\mathbf b)\quad\text{para todo }\tilde b\neq \mathbf b.}
$$

**Conferência numérica.** No ex. 34, os autovalores de $\mathbf X'\mathbf X$ são 224,1076 e 0,8924, ambos positivos. O produto é 200 ($=\det$) e a soma é 225 ($=\operatorname{tr}$). A identidade do passo 5 confere até o erro de arredondamento (tabela ao fim da seção 2).

> [!TIP]
> **Como o professor pode torcer**
> - "E sem [H3]?" Existe $v\neq 0$ com $v'\mathbf X'Xv=0$: $\mathbf X'\mathbf X$ é semidefinida e singular, e $S$ tem um "vale plano", com infinitos minimizadores (D03.11, ex. 35).
> - "Use os menores principais": com $K=2$, $2n>0$ e $\det(2\mathbf X'\mathbf X)=4n\sum(x_i-\bar x)^2>0$. É o D7 do aluno. A prova com $\lVert Xv\rVert^2$ vale para qualquer $K$.
> - Multicolinearidade **imperfeita**: o menor autovalor fica perto de zero. $\mathbf X'\mathbf X$ continua positiva definida, mas $(\mathbf X'\mathbf X)^{-1}$ fica grande, e a variância explode (D15, módulo 06).

### D03.4 · Propriedades de P e M

> [!NOTE]
> **O que se quer provar**
> Sob [H3], com $\mathbf P=\mathbf X(\mathbf X'\mathbf X)^{-1}\mathbf X'$ e $\mathbf M=\mathbf I_n-\mathbf P$ (ambas $n\times n$): (a) $\mathbf P'=\mathbf P$ e $\mathbf M'=\mathbf M$; (b) $\mathbf P\mathbf P=\mathbf P$ e $\mathbf M\mathbf M=\mathbf M$; (c) $\mathbf P\mathbf X=\mathbf X$ e $\mathbf M\mathbf X=0$; (d) $\mathbf P\mathbf M=\mathbf M\mathbf P=0$; (e) $\mathbf P+\mathbf M=\mathbf I_n$; (f) $\operatorname{tr}(\mathbf P)=K$ e $\operatorname{tr}(\mathbf M)=n-K$; (g) $\operatorname{posto}(\mathbf P)=K$ e $\operatorname{posto}(\mathbf M)=n-K$, então $\mathbf M$ é singular.

**Por que importa.** O item (c) é a chave do ex. 28 ($\mathbf e=\mathbf M\varepsilon$). O item (f) é a chave de $E(s^2\mid \mathbf X)=\sigma^2$ (módulo 06). Os itens (a) e (b) transformam $\mathbf e'\mathbf e$ em $\mathbf y'\mathbf M\mathbf y$ (ex. 30). SL03, pp. 18–19.

**Passo a passo.**

1. (a) Simetria. Use $(\mathbf A\mathbf B\mathbf C)'=\mathbf C'\mathbf B'\mathbf A'$ e o fato de a inversa de uma simétrica ser simétrica *[(A-62), (A-63)]*:

$$
\mathbf P'=\big[\mathbf X(\mathbf X'\mathbf X)^{-1}\mathbf X'\big]'=(\mathbf X')'\big[(\mathbf X'\mathbf X)^{-1}\big]'\mathbf X'=\mathbf X(\mathbf X'\mathbf X)^{-1}\mathbf X'=\mathbf P,\qquad \mathbf M'=\mathbf I_n'-\mathbf P'=\mathbf I_n-\mathbf P=\mathbf M.
$$

2. (b) Idempotência. O $(\mathbf X'\mathbf X)$ do meio cancela com uma das inversas:

$$
\mathbf P\mathbf P=\mathbf X(\mathbf X'\mathbf X)^{-1}\underbrace{(\mathbf X'\mathbf X)(\mathbf X'\mathbf X)^{-1}}_{I_K}\mathbf X'=\mathbf P,\qquad \mathbf M\mathbf M=(\mathbf I-\mathbf P)(\mathbf I-\mathbf P)=\mathbf I-2\mathbf P+\mathbf P\mathbf P=\mathbf I-\mathbf P=\mathbf M.
$$

3. (c) $\mathbf P\mathbf X=\mathbf X(\mathbf X'\mathbf X)^{-1}(\mathbf X'\mathbf X)=\mathbf X$ ($n\times K$) e $\mathbf M\mathbf X=\mathbf X-\mathbf P\mathbf X=0$ ($n\times K$). Leitura: regredir cada coluna de $\mathbf X$ em $\mathbf X$ dá ajuste perfeito e resíduo nulo.

4. (d) $\mathbf P\mathbf M=\mathbf P(\mathbf I-\mathbf P)=\mathbf P-\mathbf P\mathbf P=0$ pelo item (b). E $\mathbf M\mathbf P=(\mathbf P'\mathbf M')'=(\mathbf P\mathbf M)'=0$ pelo item (a).

5. (e) É a definição de $\mathbf M$. Dela vem $\mathbf y=\mathbf P\mathbf y+\mathbf M\mathbf y$ para todo $\mathbf y$.

6. (f) Traço. Use $\operatorname{tr}(\mathbf A\mathbf B)=\operatorname{tr}(\mathbf B\mathbf A)$ com $\mathbf A=\mathbf X$ ($n\times K$) e $\mathbf B=(\mathbf X'\mathbf X)^{-1}\mathbf X'$ ($K\times n$). O produto $\mathbf A\mathbf B$ é $n\times n$ e $\mathbf B\mathbf A$ é $K\times K$:

$$
\operatorname{tr}(\mathbf P)=\operatorname{tr}\big[\mathbf X\,(\mathbf X'\mathbf X)^{-1}\mathbf X'\big]=\operatorname{tr}\big[(\mathbf X'\mathbf X)^{-1}\mathbf X'\mathbf X\big]=\operatorname{tr}(\mathbf I_K)=K,\qquad \operatorname{tr}(\mathbf M)=\operatorname{tr}(\mathbf I_n)-\operatorname{tr}(\mathbf P)=n-K.
$$

7. (g) Posto. Os autovalores de uma matriz idempotente são 0 ou 1: se $Pv=\lambda v$ com $v\neq 0$, então $\lambda v=Pv=PPv=\lambda^2v$, logo $\lambda\in\{0,1\}$. Como $\mathbf P$ é simétrica, é diagonalizável, e o posto é o número de autovalores iguais a 1, que é o traço. Então $\operatorname{posto}(\mathbf P)=K$ e $\operatorname{posto}(\mathbf M)=n-K<n$: **$\mathbf M$ não tem inversa**. Outra forma de ver: $\mathbf M\mathbf X=0$ com as $K$ colunas de $\mathbf X$ LI, então $\mathbf M$ anula $K$ vetores LI.

$$
\boxed{\mathbf P=\mathbf P'=\mathbf P^2,\quad \mathbf M=\mathbf M'=\mathbf M^2,\quad \mathbf P\mathbf X=\mathbf X,\quad \mathbf M\mathbf X=0,\quad \mathbf P\mathbf M=0,\quad \operatorname{tr}\mathbf P=K,\quad \operatorname{tr}\mathbf M=n-K.}
$$

**Diagonal de $\mathbf P$ (alavancagem).** $h_{ii}=\mathbf x_i'(\mathbf X'\mathbf X)^{-1}\mathbf x_i$. Como $\mathbf P$ é simétrica e idempotente, $h_{ii}=\sum_j p_{ij}^2\ge h_{ii}^2$, logo $0\le h_{ii}\le 1$. E $\sum_i h_{ii}=\operatorname{tr}(\mathbf P)=K$. No ex. 34, $h=(0{,}6;\ 0{,}3;\ 0{,}2;\ 0{,}3;\ 0{,}6)$, que soma $2=K$.

> [!TIP]
> **Como o professor pode torcer**
> - "Por que $s^2$ divide por $n-K$?" Pelo item (f): $E(\mathbf e'\mathbf e\mid \mathbf X)=E(\varepsilon'\mathbf M\varepsilon\mid \mathbf X)=E(\operatorname{tr}(\mathbf M\varepsilon\varepsilon')\mid \mathbf X)=\operatorname{tr}(\mathbf M\,E(\varepsilon\varepsilon'\mid \mathbf X))=\sigma^2\operatorname{tr}(\mathbf M)=\sigma^2(n-K)$. Os passos usam D03.7, "escalar = traço", $\operatorname{tr}(\mathbf A\mathbf B)=\operatorname{tr}(\mathbf B\mathbf A)$, a linearidade de $E$ e do traço, e [H4]. A prova completa está no módulo 06.
> - "$\mathbf M$ é inversível?" Não: tem posto $n-K$. Qualquer passo que "divide por $\mathbf M$" está errado.
> - $\mathbf M^0$ é o $\mathbf M$ da regressão só na constante: com $\mathbf X=\iota$, $(\iota'\iota)^{-1}=1/n$ e $\mathbf P=\tfrac1n\iota\iota'$.

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
