---
title: "Mínimos Quadrados Ordinários — Regressão Linear Simples"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
tags:
  - econometria
  - mestrado/ppgeco
  - mqo
aliases:
  - MQO — regressão simples
---

# Mínimos Quadrados Ordinários — Regressão Linear Simples

**Derivação completa, passo a passo, com revisão de fundamentos de esperança e notação.**

> Contexto: reconstrução e formalização das suas notas manuscritas (Econometria I). Complementos conceituais ancorados no **Apêndice B do Greene — *Probability and Distribution Theory*** (variável aleatória, esperança, momentos, distribuições conjuntas, esperança condicional) e na exposição do Wooldridge (cap. 2) e do Hansen (cap. 2–4).

---

## 0. Como ler este documento

Suas notas fazem a derivação "de baixo pra cima": partem da soma de quadrados dos resíduos (SQR), minimizam, e chegam nas fórmulas. Isso está **correto**, mas fica mais sólido se antes fixarmos:

1. **a diferença entre o mundo populacional e o mundo amostral** (é onde a "esperança" entra), e
2. **a notação** — o que é parâmetro, o que é estimador, o que é erro, o que é resíduo.

A estrutura é:

- **§1** — revisão de esperança, variância, covariância e **esperança condicional** (Greene Ap. B).
- **§2** — o modelo populacional e a Função de Regressão Populacional.
- **§3** — os parâmetros no mundo populacional (de onde vêm $\beta_0,\beta_1$ *antes* de qualquer dado).
- **§4** — a derivação por mínimos quadrados (o caminho das suas notas), agora com convenção de notação limpa.
- **§5** — as identidades de somatório que você usou (provadas).
- **§6** — a **condição de segunda ordem** (o que suas notas ainda não têm: a prova de que é mínimo).
- **§7** — o método dos momentos (mesma resposta por outro caminho — fecha o ciclo com a §3).
- **§8** — propriedades algébricas dos resíduos + a correção de um deslize no denominador.
- **§9** — ponte para o próximo tópico (propriedades estatísticas / Gauss–Markov).
- **Apêndices** — glossário de notação e um snippet Python para a intuição geométrica.

---

## 1. Revisão de fundamentos (Greene, Apêndice B)

### 1.1 Esperança

Para uma variável aleatória $X$, a **esperança** (média populacional) é

$$
E[X] \;=\;
\begin{cases}
\displaystyle\sum_{x} x\,p(x) & \text{(caso discreto)}\\[2mm]
\displaystyle\int_{-\infty}^{\infty} x\,f(x)\,dx & \text{(caso contínuo)}
\end{cases}
$$

Pense em $E[\cdot]$ como um **operador** que "pesa pela probabilidade". As duas propriedades que você usa o tempo todo:

**Linearidade.** Para constantes $a,b$ e variáveis $X,Y$:

$$
E[aX + b] = a\,E[X] + b, \qquad E[X + Y] = E[X] + E[Y].
$$

> A linearidade é o que permite "puxar somatório para dentro/fora" no mundo amostral, porque a média amostral $\bar{x}=\frac1n\sum x_i$ é o análogo empírico de $E[X]$.

### 1.2 Variância e covariância

$$
\operatorname{Var}(X) = E\!\big[(X-\mu_X)^2\big] = E[X^2] - \mu_X^2, \qquad \mu_X \equiv E[X].
$$

$$
\operatorname{Cov}(X,Y) = E\!\big[(X-\mu_X)(Y-\mu_Y)\big] = E[XY] - \mu_X\mu_Y.
$$

Propriedades que serão usadas na §3 e na §7:

$$
\operatorname{Cov}(X, aY + bZ) = a\operatorname{Cov}(X,Y) + b\operatorname{Cov}(X,Z),
$$
$$
\operatorname{Cov}(X, X) = \operatorname{Var}(X), \qquad \operatorname{Cov}(X, \text{const}) = 0.
$$

### 1.3 O conceito central: esperança condicional (Greene, Ap. B.8)

Essa é a peça que **falta nas suas notas** e que amarra tudo. A **esperança condicional** $E[Y\mid X=x]$ é a média de $Y$ *entre as observações em que $X=x$*. Vista como função de $x$, ela é a **Função de Regressão Populacional (FRP)**:

$$
m(x) \;\equiv\; E[Y \mid X = x].
$$

Dois resultados que você deve ter na ponta da língua:

**Lei das Expectativas Iteradas (LIE).**
$$
E\big[\,E[Y\mid X]\,\big] = E[Y].
$$

**Propriedade de "puxar o que é conhecido".** Se $g$ é função de $X$:
$$
E[\,g(X)\,Y \mid X] = g(X)\,E[Y\mid X].
$$

Dessas duas sai a consequência que usaremos:

$$
E[Y\mid X]=0 \;\Longrightarrow\; E[Y]=0 \;\text{ e }\; E[g(X)\,Y]=0 \;\text{ para toda } g.
$$

*(Prova da segunda: $E[g(X)Y] = E\big[E[g(X)Y\mid X]\big] = E\big[g(X)\underbrace{E[Y\mid X]}_{=0}\big] = 0$.)*

### 1.4 Análogos amostrais — a tradução população ↔ amostra

Toda a mágica do MQO é **substituir esperanças populacionais por médias amostrais**. Fixe esta tabela mentalmente:

| Mundo populacional (desconhecido) | Mundo amostral (calculável com dados) |
|---|---|
| $E[X]$ | $\bar{x} = \dfrac{1}{n}\sum_{i=1}^n x_i$ |
| $\operatorname{Var}(X)$ | $\dfrac{1}{n}\sum (x_i-\bar{x})^2$  (ou com $n-1$) |
| $\operatorname{Cov}(X,Y)$ | $\dfrac{1}{n}\sum (x_i-\bar{x})(y_i-\bar{y})$ |
| $E[Y\mid X]=\beta_0+\beta_1 X$ | reta ajustada $\hat{y}_i = \hat\beta_0 + \hat\beta_1 x_i$ |
| erro $u$ (não-observável) | resíduo $\hat{u}_i$ (observável) |

> **Nota de notação:** nas suas páginas o tamanho da amostra aparece como $m$. O padrão em econometria é $n$ (ou $N$). Vou usar $n$ daqui em diante — é a mesma coisa, só para você não estranhar ao comparar com Greene/Wooldridge.

---

## 2. O modelo de regressão linear simples

### 2.1 Modelo populacional

$$
\boxed{\,y_i = \beta_0 + \beta_1 x_i + u_i\,}
$$

- $\beta_0,\beta_1$ — **parâmetros populacionais**: números fixos e **desconhecidos**. $\beta_1$ é o efeito de uma unidade de $x$ sobre $y$, $\beta_0$ é o intercepto.
- $u_i$ — **erro** (ou perturbação): tudo que afeta $y$ e não está em $x$. É **não-observável**.
- $x_i, y_i$ — observáveis.

### 2.2 A hipótese de identificação (média condicional zero)

O que dá sentido a $\beta_0,\beta_1$ é a hipótese de **exogeneidade em média condicional**:

$$
\boxed{\,E[u \mid x] = 0\,}
$$

Ela diz que, dado $x$, o erro não tem tendência sistemática. Por §1.3, ela implica as duas **condições de momento** que vão gerar os estimadores:

$$
E[u] = 0 \qquad\text{e}\qquad E[x\,u] = 0 \;\;\Longleftrightarrow\;\; \operatorname{Cov}(x,u)=0.
$$

Sob essa hipótese, a FRP é exatamente a reta:

$$
E[y\mid x] = \beta_0 + \beta_1 x.
$$

> Guarde a diferença conceitual:
> - $E[u\mid x]=0$ (média condicional) é **mais forte** e é o que justifica interpretar $\beta_1$ como efeito causal;
> - $E[u]=0$ e $\operatorname{Cov}(x,u)=0$ (ortogonalidade) é **mais fraca** e é o mínimo necessário para *identificar* $\beta_0,\beta_1$ como na §3. O MQO só precisa da versão fraca.

### 2.3 Erro × resíduo — não confundir

Depois de estimar, escrevemos a **versão amostral**:

$$
y_i = \hat\beta_0 + \hat\beta_1 x_i + \hat{u}_i,
\qquad
\hat{y}_i = \hat\beta_0 + \hat\beta_1 x_i,
\qquad
\hat{u}_i = y_i - \hat{y}_i.
$$

| | símbolo | observável? | natureza |
|---|---|---|---|
| erro | $u_i$ | ❌ | populacional, teórico |
| resíduo | $\hat{u}_i$ | ✔️ | amostral, calculado |

O resíduo é a **estimativa** do erro. A reta da sua figura (imagem 5) é $\hat{y}_i=\hat\beta_0+\hat\beta_1 x_i$, e cada $\hat u_i$ é a distância **vertical** de um ponto até essa reta.

---

## 3. De onde vêm os parâmetros (mundo populacional)

Antes de olhar para qualquer amostra, os próprios $\beta_0,\beta_1$ já estão definidos pelas condições de momento. Partindo de $y=\beta_0+\beta_1 x+u$ com $E[u]=0$ e $\operatorname{Cov}(x,u)=0$:

**Intercepto** — tomando esperança dos dois lados:
$$
E[y] = \beta_0 + \beta_1 E[x] \;\Longrightarrow\; \boxed{\beta_0 = E[y] - \beta_1 E[x]}.
$$

**Inclinação** — tomando covariância com $x$:
$$
\operatorname{Cov}(x,y)
= \operatorname{Cov}(x,\ \beta_0 + \beta_1 x + u)
= \beta_1\operatorname{Var}(x) + \underbrace{\operatorname{Cov}(x,u)}_{=0}
$$
$$
\Longrightarrow\; \boxed{\beta_1 = \dfrac{\operatorname{Cov}(x,y)}{\operatorname{Var}(x)}}.
$$

**Por que isso importa:** repare que essas são exatamente as fórmulas do MQO (§4/§8), só que com $E,\operatorname{Cov},\operatorname{Var}$ **populacionais** no lugar das versões amostrais. Ou seja, o MQO não é um truque de minimização arbitrário — ele é o **análogo amostral** dos parâmetros que já existem na população. É por isso que ele "funciona".

---

## 4. Derivação por Mínimos Quadrados

### 4.1 A função objetivo (SQR)

Escolhemos a reta que minimiza a soma dos quadrados dos resíduos. Para **candidatos genéricos** $b_0, b_1$ (uso $b$, não $\hat\beta$, para deixar claro que estamos otimizando *sobre* eles; o minimizador ganhará o chapéu):

$$
\operatorname{SQR}(b_0,b_1) = \sum_{i=1}^n \big(y_i - b_0 - b_1 x_i\big)^2.
$$

O problema é:

$$
\min_{b_0,\,b_1}\ \sum_{i=1}^n \big(y_i - b_0 - b_1 x_i\big)^2 .
$$

> **Por que quadrados, e não valor absoluto?** Duas razões práticas: (i) o quadrado é diferenciável em toda parte, então o cálculo das condições de primeira ordem é limpo; (ii) penaliza mais os desvios grandes. (Minimizar $\sum|\hat u_i|$ existe — é a regressão na mediana / LAD — mas não tem solução fechada.)

### 4.2 Condições de primeira ordem (as equações normais)

Derivamos e igualamos a zero. Regra da cadeia em cada termo.

**FOC em $b_0$:**
$$
\frac{\partial\operatorname{SQR}}{\partial b_0}
= \sum 2\big(y_i - b_0 - b_1 x_i\big)(-1) = 0
\;\Longrightarrow\;
\sum \big(y_i - \hat\beta_0 - \hat\beta_1 x_i\big) = 0.
\tag{EN-1}
$$

**FOC em $b_1$:**
$$
\frac{\partial\operatorname{SQR}}{\partial b_1}
= \sum 2\big(y_i - b_0 - b_1 x_i\big)(-x_i) = 0
\;\Longrightarrow\;
\sum \big(y_i - \hat\beta_0 - \hat\beta_1 x_i\big)x_i = 0.
\tag{EN-2}
$$

Como o termo entre parênteses é o resíduo $\hat u_i$, as duas equações normais dizem, em uma frase:

$$
\boxed{\sum \hat{u}_i = 0} \qquad\text{e}\qquad \boxed{\sum \hat{u}_i x_i = 0}.
$$

> Estas são **as duas propriedades algébricas fundamentais** do MQO. Elas valem *por construção*, sem precisar de nenhuma hipótese estatística. Tudo na §8 sai daqui.

### 4.3 Resolvendo (EN-1) → o intercepto

Abrindo (EN-1):
$$
\sum y_i - \sum \hat\beta_0 - \hat\beta_1 \sum x_i = 0
\;\Longrightarrow\;
\sum y_i - n\hat\beta_0 - \hat\beta_1 \sum x_i = 0.
$$

Dividindo por $n$ (usando $\bar{y}=\frac1n\sum y_i$ e $\bar{x}=\frac1n\sum x_i$):
$$
\bar{y} - \hat\beta_0 - \hat\beta_1 \bar{x} = 0
\;\Longrightarrow\;
\boxed{\hat\beta_0 = \bar{y} - \hat\beta_1 \bar{x}}
\quad\Longleftrightarrow\quad
\bar{y} = \hat\beta_0 + \hat\beta_1\bar{x}.
$$

**Consequência geométrica imediata:** a reta ajustada **passa pelo ponto médio** $(\bar{x},\bar{y})$. (É a última linha da sua imagem 1.)

### 4.4 Resolvendo (EN-2) → a inclinação

Substituímos $\hat\beta_0 = \bar{y} - \hat\beta_1\bar{x}$ em (EN-2):

$$
\sum \Big(y_i - (\bar{y} - \hat\beta_1\bar{x}) - \hat\beta_1 x_i\Big)x_i = 0.
$$

Reorganizando dentro do parêntese $\big(y_i - \bar{y}\big) - \hat\beta_1\big(x_i - \bar{x}\big)$:

$$
\sum \Big[(y_i-\bar{y}) - \hat\beta_1(x_i-\bar{x})\Big]x_i = 0
\;\Longrightarrow\;
\sum (y_i-\bar{y})x_i \;=\; \hat\beta_1 \sum (x_i-\bar{x})x_i .
$$

Agora usamos as identidades da §5 — a saber, $\sum(x_i-\bar x)x_i=\sum(x_i-\bar x)^2$ e $\sum(y_i-\bar y)x_i=\sum(y_i-\bar y)(x_i-\bar x)$ — para reescrever ambos os lados em forma centrada:

$$
\sum (y_i-\bar{y})(x_i-\bar{x}) = \hat\beta_1 \sum (x_i-\bar{x})^2 .
$$

Isolando:

$$
\boxed{\ \hat\beta_1 = \dfrac{\displaystyle\sum_{i=1}^n (x_i-\bar{x})(y_i-\bar{y})}{\displaystyle\sum_{i=1}^n (x_i-\bar{x})^2} \ }
\;=\; \frac{S_{xy}}{S_{xx}}
\;=\; \frac{\widehat{\operatorname{Cov}}(x,y)}{\widehat{\operatorname{Var}}(x)} .
$$

onde defini as somas centradas $S_{xx}=\sum(x_i-\bar x)^2$ e $S_{xy}=\sum(x_i-\bar x)(y_i-\bar y)$.

Isso reproduz a sua imagem 4 — **com o denominador correto** (veja §8.4 sobre o deslize da raiz quadrada).

---

## 5. As identidades de somatório (provadas)

Estas são as manipulações das suas imagens 2 e 3. Vale provar cada uma uma vez para nunca mais ter dúvida. A ferramenta única é: **$\sum(x_i-\bar x)=0$**, porque $\sum x_i = n\bar x$.

### 5.1 Soma dos desvios é zero
$$
\sum (x_i - \bar{x}) = \sum x_i - n\bar{x} = n\bar{x} - n\bar{x} = 0.
$$

### 5.2 Somas de quadrados centradas
$$
\sum (x_i-\bar{x})^2 = \sum (x_i-\bar{x})(x_i-\bar{x})
= \sum (x_i-\bar{x})x_i - \bar{x}\underbrace{\sum(x_i-\bar{x})}_{=0}
= \sum (x_i-\bar{x})x_i .
$$

E a forma "computacional":
$$
\sum (x_i-\bar{x})^2 = \sum x_i^2 - 2\bar{x}\sum x_i + n\bar{x}^2 = \sum x_i^2 - 2n\bar{x}^2 + n\bar{x}^2 = \sum x_i^2 - n\bar{x}^2 .
$$

### 5.3 Somas de produtos centradas (as quatro formas equivalentes)

Este é o resultado que aparece três vezes nas suas notas. Todas estas expressões são **iguais**:

$$
\sum (x_i-\bar{x})(y_i-\bar{y})
\;=\; \sum (x_i-\bar{x})y_i
\;=\; \sum (y_i-\bar{y})x_i
\;=\; \sum x_i y_i - n\bar{x}\bar{y}.
$$

*Prova* (mesma lógica da §5.2 — o desvio "mata" a constante do outro lado):
$$
\sum (x_i-\bar{x})(y_i-\bar{y}) = \sum(x_i-\bar{x})y_i - \bar{y}\underbrace{\sum(x_i-\bar{x})}_{=0} = \sum(x_i-\bar{x})y_i,
$$
e expandindo,
$$
\sum(x_i-\bar{x})y_i = \sum x_i y_i - \bar{x}\sum y_i = \sum x_i y_i - n\bar{x}\bar{y}.
$$

> **Moral:** centrar em **uma** das variáveis já basta — não precisa centrar as duas. Isso encurta muito as contas da imagem 3.

---

## 6. Condição de segunda ordem — a prova de que é mínimo

Aqui está a lacuna das suas notas. Você chamou a segunda FOC de "2ª condição", mas ela ainda é uma condição de *primeira* ordem (é a derivada em $b_1$). Falta mostrar que o ponto crítico $(\hat\beta_0,\hat\beta_1)$ é de fato um **mínimo**, e não um máximo ou sela. Isso é a **condição de segunda ordem (CSO)** e se checa via a **matriz Hessiana**.

As segundas derivadas da SQR:
$$
\frac{\partial^2\operatorname{SQR}}{\partial b_0^2} = 2n,\qquad
\frac{\partial^2\operatorname{SQR}}{\partial b_1^2} = 2\sum x_i^2,\qquad
\frac{\partial^2\operatorname{SQR}}{\partial b_0\,\partial b_1} = 2\sum x_i .
$$

Logo a Hessiana é

$$
H = 2\begin{bmatrix} n & \sum x_i \\[1mm] \sum x_i & \sum x_i^2 \end{bmatrix}.
$$

Ela é **positiva definida** (⇒ mínimo estrito) se seus menores principais líderes forem positivos:

- $H_{11} = 2n > 0$ ✔️
- $\det H = 4\Big[n\sum x_i^2 - \big(\sum x_i\big)^2\Big] = 4n\sum (x_i-\bar{x})^2 = 4n\,S_{xx}$.

Então:

$$
\det H > 0 \;\Longleftrightarrow\; \boxed{S_{xx}=\sum (x_i-\bar{x})^2 > 0} \;\Longleftrightarrow\; \text{nem todos os } x_i \text{ são iguais.}
$$

**Interpretação.** A SQR é uma função **estritamente convexa** de $(b_0,b_1)$ desde que haja **variação em $x$**. Nesse caso o ponto crítico é o **mínimo global único** — a solução da §4 está garantida.

> Essa condição $S_{xx}>0$ é o análogo, no caso simples, da **condição de posto** ($X$ com posto cheio) no caso multivariado. Se $x$ fosse constante, $\hat\beta_1$ seria uma divisão por zero: você não pode medir inclinação sem variação no regressor. É a **hipótese de identificação** aparecendo de forma concreta.

---

## 7. Mesma resposta pelo Método dos Momentos (fechando o ciclo)

Volte à §2.2: as condições populacionais são $E[u]=0$ e $E[xu]=0$. O **método dos momentos** manda substituir cada esperança pela média amostral e resolver. Com $\hat u_i = y_i - \hat\beta_0 - \hat\beta_1 x_i$:

$$
\frac{1}{n}\sum \hat{u}_i = 0
\qquad\text{e}\qquad
\frac{1}{n}\sum x_i\,\hat{u}_i = 0 .
$$

Multiplique por $n$ e essas são **exatamente** (EN-1) e (EN-2). Ou seja:

$$
\text{MQO} \;=\; \text{Método dos Momentos aplicado a } E[u]=0,\ E[xu]=0.
$$

Isso conecta a §3 (parâmetros populacionais) à §4 (minimização) sem passar por otimização nenhuma — os dois caminhos chegam ao mesmo estimador. É a leitura "moderna" (Hansen): MQO estima os parâmetros que satisfazem as condições de ortogonalidade da população.

---

## 8. Propriedades algébricas dos resíduos + síntese

Tudo abaixo é **algébrico** (vale por construção, sem hipótese estatística), e sai direto de (EN-1)–(EN-2).

### 8.1 Os resíduos somam zero
$$
\sum \hat{u}_i = 0 \;\Longrightarrow\; \bar{\hat{u}} = 0.
$$
Em particular, das suas notas: $y_i - \bar{y}$ centrado corresponde à parte "explicável", e $\sum\hat u_i=0$ é o que garante que a reta passa por $(\bar x,\bar y)$.

### 8.2 Resíduos ortogonais ao regressor
$$
\sum x_i\hat{u}_i = 0.
$$

### 8.3 Covariância amostral resíduo–regressor é zero

Aqui um ponto de rigor: para concluir $\widehat{\operatorname{Cov}}(\hat u, x)=0$ você precisa **das duas** condições juntas, não só de $\sum x_i \hat u_i=0$:

$$
\widehat{\operatorname{Cov}}(\hat{u},x)
= \frac{1}{n}\sum (\hat{u}_i - \bar{\hat u})(x_i - \bar{x})
\overset{\bar{\hat u}=0}{=} \frac{1}{n}\sum \hat{u}_i (x_i-\bar{x})
= \frac{1}{n}\Big[\underbrace{\sum \hat{u}_i x_i}_{=0} - \bar{x}\underbrace{\sum \hat{u}_i}_{=0}\Big] = 0.
$$

Ou seja: $\sum\hat u_i=0$ **e** $\sum x_i\hat u_i=0$ ⟹ $\widehat{\operatorname{Cov}}(\hat u,x)=0$. As suas notas escrevem "$\widehat{\operatorname{Cov}}(\hat u_i,x_i)=0$" logo após $\sum\hat u_i x_i=0$ — está certo, mas é bom saber que a passagem usa *silenciosamente* a primeira condição também.

### 8.4 ⚠️ Correção: o denominador de $\hat\beta_1$ **não** leva raiz

Na imagem 4 aparece
$$
\hat\beta_1 = \frac{\widehat{\operatorname{Cov}}(y,x)}{\sqrt{\widehat{\operatorname{Var}}(x)}}. \quad\text{❌}
$$
O correto é **sem** raiz:
$$
\hat\beta_1 = \frac{\widehat{\operatorname{Cov}}(y,x)}{\widehat{\operatorname{Var}}(x)}. \quad\text{✔️}
$$

Dois jeitos rápidos de nunca mais errar isso:

- **Sai da própria derivação (§4.4):** $\hat\beta_1 = S_{xy}/S_{xx}$, e $S_{xx}=\sum(x_i-\bar x)^2$ é a soma de quadrados **inteira** (o denominador da variância), não a raiz dela.
- **Checagem dimensional (sanity check):** $\hat\beta_1$ tem unidade $[\,y\,]/[\,x\,]$ (é "quanto $y$ muda por unidade de $x$"). Confira:
  $$
  \frac{\operatorname{Cov}(y,x)}{\operatorname{Var}(x)} \sim \frac{[y][x]}{[x]^2} = \frac{[y]}{[x]} \;\checkmark
  \qquad\text{vs}\qquad
  \frac{\operatorname{Cov}(y,x)}{\sqrt{\operatorname{Var}(x)}} \sim \frac{[y][x]}{[x]} = [y]\;\text{✗ (unidade errada)}.
  $$
  A versão com raiz daria a unidade errada — logo não pode ser $\hat\beta_1$. (A raiz de fato aparece, mas no **coeficiente de correlação** $r=\dfrac{\widehat{\operatorname{Cov}}(x,y)}{\sqrt{\widehat{\operatorname{Var}}(x)}\,\sqrt{\widehat{\operatorname{Var}}(y)}}$, e na relação $\hat\beta_1 = r\cdot \dfrac{s_y}{s_x}$ — talvez seja daí que veio a confusão.)

> Fica como hábito de conferência: sempre que fechar uma fórmula, faça a checagem de unidades. É barato e pega esse tipo de deslize antes de virar erro de prova.

### 8.5 Por que $\widehat{\operatorname{Cov}}/\widehat{\operatorname{Var}}$ é igual a $S_{xy}/S_{xx}$

Porque o fator $1/n$ (ou $1/(n-1)$) aparece em cima e embaixo e **se cancela**:
$$
\frac{\widehat{\operatorname{Cov}}(x,y)}{\widehat{\operatorname{Var}}(x)}
= \frac{\frac1n\sum(x_i-\bar x)(y_i-\bar y)}{\frac1n\sum(x_i-\bar x)^2}
= \frac{\sum(x_i-\bar x)(y_i-\bar y)}{\sum(x_i-\bar x)^2}
= \frac{S_{xy}}{S_{xx}}.
$$

### 8.6 Resumo (o quadro final)

$$
\boxed{\;
\begin{aligned}
&\text{Equações normais:} && \sum \hat{u}_i = 0, \qquad \sum \hat{u}_i x_i = 0 \;\Rightarrow\; \widehat{\operatorname{Cov}}(\hat u, x)=0\\[2mm]
&\text{Inclinação:} && \hat\beta_1 = \frac{\sum (x_i-\bar{x})(y_i-\bar{y})}{\sum (x_i-\bar{x})^2} = \frac{S_{xy}}{S_{xx}} = \frac{\widehat{\operatorname{Cov}}(x,y)}{\widehat{\operatorname{Var}}(x)}\\[2mm]
&\text{Intercepto:} && \hat\beta_0 = \bar{y} - \hat\beta_1\bar{x}\\[2mm]
&\text{Ponto médio:} && \bar{y} = \hat\beta_0 + \hat\beta_1\bar{x} \quad (\text{a reta passa por } (\bar x,\bar y))\\[2mm]
&\text{Identificação:} && S_{xx} > 0 \;\;(x \text{ não é constante})
\end{aligned}
\;}
$$

---

## 9. Ponte para o próximo tópico

Tudo até aqui é **álgebra**: dado qualquer conjunto de pontos, essas fórmulas produzem *a* reta de melhor ajuste. Nenhuma hipótese estatística foi usada (a única exigência foi $S_{xx}>0$).

O **próximo passo** — que vai exigir as hipóteses de Gauss–Markov — é tratar $\hat\beta_0,\hat\beta_1$ como **variáveis aleatórias** (funções da amostra) e perguntar:

- **Não-viés:** $E[\hat\beta_1] = \beta_1$? — precisa de $E[u\mid x]=0$.
- **Variância dos estimadores:** $\operatorname{Var}(\hat\beta_1) = \dfrac{\sigma^2}{S_{xx}}$? — precisa de homocedasticidade $\operatorname{Var}(u\mid x)=\sigma^2$ e não-autocorrelação.
- **Eficiência (Gauss–Markov):** MQO é o melhor estimador linear não-viesado (BLUE)?
- **Inferência:** distribuição de $\hat\beta_1$, testes $t$, intervalos — aí entram as distribuições do **Apêndice B.4/B.9 do Greene** (normal, $t$, $\chi^2$, $F$) e a Teoria Assintótica (Apêndice D).

Note a mudança de status de $S_{xx}$: aqui ele foi só a **condição de existência**; lá ele vira o **denominador da variância** — quanto mais variação em $x$, mais preciso é $\hat\beta_1$. É a mesma quantidade cumprindo dois papéis.

---

## Apêndice A — Glossário de notação

| Símbolo | Significado | Natureza |
|---|---|---|
| $\beta_0,\ \beta_1$ | intercepto e inclinação populacionais | fixos, desconhecidos |
| $u_i$ | erro / perturbação | populacional, **não-observável** |
| $E[\,\cdot\,]$ | operador esperança | populacional |
| $E[y\mid x]$ | esperança condicional = FRP | populacional |
| $\hat\beta_0,\ \hat\beta_1$ | estimadores de MQO | amostrais, **aleatórios** |
| $\hat{u}_i$ | resíduo $=y_i-\hat y_i$ | amostral, **observável** |
| $\hat{y}_i$ | valor ajustado $=\hat\beta_0+\hat\beta_1 x_i$ | amostral |
| $\bar{x},\ \bar{y}$ | médias amostrais | amostrais |
| $S_{xx}$ | $\sum(x_i-\bar x)^2$ | amostral |
| $S_{xy}$ | $\sum(x_i-\bar x)(y_i-\bar y)$ | amostral |
| $n$ | tamanho da amostra (o seu "$m$") | — |

Convenção usada na §4: $b_0,b_1$ são os **candidatos** sobre os quais minimizamos; o minimizador recebe chapéu ($\hat\beta_0,\hat\beta_1$). Muitos livros já derivam direto no $\hat\beta$ (como suas notas) — é aceito, mas separar deixa a lógica da otimização mais nítida.

---

## Apêndice B — Intuição geométrica em Python

Reproduz a figura das suas imagens 1 e 5 (nuvem de pontos, reta ajustada, resíduos verticais, e o ponto médio por onde a reta passa). Útil para "ver" $\hat u_i$ e a propriedade $\bar y = \hat\beta_0+\hat\beta_1\bar x$.

```python
import numpy as np
import matplotlib.pyplot as plt

rng = np.random.default_rng(42)
n = 25
x = rng.uniform(1, 10, n)
y = 2.0 + 0.8 * x + rng.normal(0, 1.2, n)   # beta0=2, beta1=0.8 verdadeiros

# --- MQO na mão (as fórmulas do documento) ---
xbar, ybar = x.mean(), y.mean()
Sxx = np.sum((x - xbar) ** 2)
Sxy = np.sum((x - xbar) * (y - ybar))
b1 = Sxy / Sxx
b0 = ybar - b1 * xbar
yhat = b0 + b1 * x
resid = y - yhat

# --- checagens algébricas (§8): devem dar ~0 ---
print(f"beta0 = {b0:.4f}, beta1 = {b1:.4f}")
print(f"soma dos residuos      = {resid.sum():.2e}")   # ~ 0  (EN-1)
print(f"soma de x_i * residuo  = {np.sum(x*resid):.2e}")# ~ 0  (EN-2)

# --- figura ---
fig, ax = plt.subplots(figsize=(7, 5))
xs = np.linspace(x.min(), x.max(), 100)
ax.plot(xs, b0 + b1 * xs, lw=2, label=fr"$\hat y = {b0:.2f} + {b1:.2f}\,x$")
ax.scatter(x, y, zorder=3, label="dados")
ax.vlines(x, yhat, y, linestyles="dotted", alpha=0.7)          # resíduos verticais
ax.scatter([xbar], [ybar], s=120, marker="X", zorder=4,
           label=r"$(\bar x,\ \bar y)$")                        # a reta passa aqui
ax.set_xlabel("x"); ax.set_ylabel("y")
ax.legend(); ax.set_title("MQO: reta ajustada e resíduos")
plt.tight_layout()
plt.show()
```

---

## Materiais complementares (por objetivo)

- **Revisar esperança, momentos, distribuições conjuntas e esperança condicional** → **Greene, *Econometric Analysis*, Apêndice B** (*Probability and Distribution Theory*): B.3 (esperanças e momentos), B.7 (distribuições conjuntas, covariância), **B.8 (condicionamento — a média condicional é a função de regressão)**. Para inferência depois: B.4/B.9 (normal, $t$, $\chi^2$, $F$).
- **A derivação de MQO no estilo destas notas, com bastante intuição** → **Wooldridge, *Introductory Econometrics*, cap. 2** (praticamente a mesma sequência: SQR, equações normais, $\hat\beta_1=S_{xy}/S_{xx}$, propriedades algébricas).
- **A leitura "por condições de momento / esperança condicional"** (que amarra a §3 e §7) → **Hansen, *Econometrics*, cap. 2–4** (disponível gratuitamente online; abordagem moderna, muito boa para mestrado).
- **Intuição causal de $E[u\mid x]=0$ vs. ortogonalidade** → **Angrist & Pischke, *Mostly Harmless Econometrics*, cap. 3** (a "regression anatomy").
- **Tratamento matricial rigoroso** (para quando generalizar a regressão múltipla) → **Hayashi, *Econometrics*, cap. 1**; Greene, cap. 2–3; Apêndice A do Greene para a álgebra matricial.
