---
title: "MQO — a derivação completa, passo a passo (o porquê de cada linha)"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
proposito: caminhada pedagógica do zero até Gauss-Markov — entender, não decorar
tags:
  - econometria
  - mestrado/ppgeco
  - mqo
  - demonstracoes
  - fundamentos
aliases:
  - Derivação completa do MQO
  - MQO do zero
  - Passo a passo mínimos quadrados
  - Por que cada passo do MQO
---

# MQO — a derivação completa, passo a passo

> [!abstract] O que este documento é (e como ler)
> Os outros dois docs são **referência** ([[Demonstrações Econometria I mês 1]]) e **molde de prova** ([[Prova Zambon 2025/2]]). Este aqui é diferente: é a **caminhada** — a história contínua da derivação do MQO, do **conceito de erro** até o **Teorema de Gauss-Markov**, explicando **por que** cada passo mecânico é feito.
>
> Toda vez que você for tentado a decorar "aqui passa o somatório, aqui tira a esperança", pare e leia o bloco `[!question] Por quê?`. É ali que mora o entendimento. No fim, um **quadro-resumo** e a leitura pelas **três lentes**: inferência estatística, econometria e álgebra linear.
>
> A derivação é *escalar* (um regressor). A versão matricial que generaliza tudo isto está em [[Demonstrações Econometria I mês 1#PARTE III · Rota matricial (regressão múltipla) — 21/08]].

> [!info] Notação
> Uso $n$ para o tamanho da amostra (seu caderno às vezes usa $m$ — é a mesma coisa). $\hat\beta_0,\hat\beta_1$ são os estimadores (o caderno também escreve $b_0, b_1$). O chapéu $\hat{}$ marca "estimado a partir da amostra".

---
---

# ATO 0 · De onde viemos: população, amostra e o erro

Antes de qualquer conta, três objetos precisam estar separados na sua cabeça. É a confusão entre eles que faz a derivação parecer mágica.

**O modelo populacional (a verdade que não vemos):**
$$y_i = \beta_0 + \beta_1 x_i + \varepsilon_i.$$
Aqui $\beta_0,\beta_1$ são os **parâmetros verdadeiros** (fixos, desconhecidos) e $\varepsilon_i$ é o **erro** — tudo que afeta $y$ e não é $x$.

**O modelo estimado (o que construímos da amostra):**
$$\hat y_i = \hat\beta_0 + \hat\beta_1 x_i, \qquad y_i = \hat\beta_0 + \hat\beta_1 x_i + \hat u_i.$$
Aqui $\hat\beta_0,\hat\beta_1$ são **estimativas** e $\hat u_i$ é o **resíduo** — a parte de $y_i$ que a reta ajustada não capturou.

> [!warning] Erro ($\varepsilon_i$) ≠ Resíduo ($\hat u_i$)
> O **erro** $\varepsilon_i$ é populacional e nunca observado (depende dos $\beta$ verdadeiros). O **resíduo** $\hat u_i = y_i - \hat y_i$ é amostral e calculável (depende dos $\hat\beta$). Confundir os dois é o erro conceitual nº 1 do curso. Toda a derivação vive no mundo amostral (resíduos); as *propriedades* (Atos 5–7) fazem a ponte de volta para o populacional (erros).

**O quadro mental** (seu diagrama do caderno): cada ponto $y_i$ fica a uma distância vertical $\hat u_i$ da reta $\hat y_i$. Essa distância é o resíduo. A reta "boa" é a que deixa esses resíduos coletivamente **os menores possíveis**. Falta dizer o que "menores" significa — é o Ato 1.

---

# ATO 1 · A ideia dos mínimos quadrados: por que somar o quadrado dos erros

Queremos a reta que erra pouco. Primeira tentativa ingênua: minimizar a soma dos resíduos $\sum_i \hat u_i$. **Não funciona** — resíduos positivos e negativos se cancelam, e uma reta péssima pode ter soma zero.

Segunda tentativa: somar o **valor absoluto** $\sum_i |\hat u_i|$. Funciona, mas o valor absoluto não é diferenciável no zero — dá um pesadelo de cálculo.

Terceira tentativa, a vencedora: somar o **quadrado** dos resíduos.
$$\mathrm{SQR}(\hat\beta_0,\hat\beta_1) = \sum_{i=1}^{n} \hat u_i^2 = \sum_{i=1}^{n}\big(y_i - \hat\beta_0 - \hat\beta_1 x_i\big)^2.$$

> [!question] Por que o quadrado?
> Três razões, e vale saber todas:
> 1. **Elimina o cancelamento** — todo termo vira positivo, então erros pra cima e pra baixo não se anulam.
> 2. **Penaliza erros grandes mais que proporcionalmente** — um resíduo de 10 pesa 100; dois resíduos de 5 pesam 50. A reta é "puxada" a evitar desastres isolados.
> 3. **É suave (diferenciável em tudo)** — dá para derivar e achar o mínimo com cálculo, o que o valor absoluto não permite. É isto que torna o MQO *tratável*.
>
> Existe um custo: o quadrado deixa o MQO **sensível a outliers** (um ponto muito fora domina a soma). Guardar isso explica por que existem alternativas robustas — mas para o curso, quadrado é o padrão.

**O problema de otimização**, então, é:
$$\min_{\hat\beta_0,\,\hat\beta_1}\; \sum_{i=1}^{n}\big(y_i - \hat\beta_0 - \hat\beta_1 x_i\big)^2.$$

Uma função de **duas variáveis** ($\hat\beta_0$ e $\hat\beta_1$) para minimizar. O cálculo diz: derive em relação a cada uma, iguale a zero. É o Ato 2.

---

# ATO 2 · Condições de 1ª ordem: por que derivar e igualar a zero

> [!question] Por que a derivada igual a zero acha o mínimo?
> A SQR é uma **parábola (para cima) em duas dimensões** — uma tigela. No fundo da tigela, a inclinação em toda direção é zero: a reta tangente é horizontal. Derivada = taxa de inclinação; no mínimo, ela zera. Como a SQR é soma de quadrados (sempre ≥ 0 e crescendo nas bordas), o ponto de derivada nula **é** o fundo — não um topo nem uma sela. (A garantia formal disso é o Ato 4, a 2ª ordem.)

Precisamos das **derivadas parciais** — uma para cada parâmetro, tratando o outro como constante.

## Derivada em relação a $\hat\beta_0$

$$\frac{\partial\,\mathrm{SQR}}{\partial \hat\beta_0} = \sum_i 2\big(y_i - \hat\beta_0 - \hat\beta_1 x_i\big)\cdot(-1) = 0.$$

> [!question] De onde vem o $2$ e o $(-1)$?
> É a **regra da cadeia**. Cada termo é $(\,\cdot\,)^2$. A derivada de "algo ao quadrado" é $2\cdot(\text{algo})\cdot(\text{derivada do algo})$. O "algo" é $(y_i - \hat\beta_0 - \hat\beta_1 x_i)$; sua derivada **em relação a $\hat\beta_0$** é $-1$ (porque $\hat\beta_0$ aparece com sinal negativo, e $y_i,\hat\beta_1 x_i$ são constantes nessa derivada parcial). Daí o $2\cdots(-1)$.

Divide os dois lados por $-2$ (não muda a igualdade a zero) e reconhece que $\hat u_i = y_i - \hat\beta_0 - \hat\beta_1 x_i$:
$$\boxed{\sum_i \hat u_i = 0} \tag{Equação Normal 1}$$

## Derivada em relação a $\hat\beta_1$

$$\frac{\partial\,\mathrm{SQR}}{\partial \hat\beta_1} = \sum_i 2\big(y_i - \hat\beta_0 - \hat\beta_1 x_i\big)\cdot(-x_i) = 0.$$

Aqui a derivada interna **em relação a $\hat\beta_1$** é $-x_i$ (o termo $\hat\beta_1$ multiplica $x_i$). Divide por $-2$:
$$\boxed{\sum_i \hat u_i\, x_i = 0} \tag{Equação Normal 2}$$

> [!success] O que as duas equações normais SIGNIFICAM
> Não são só "contas que deram zero". Elas dizem:
> - **(EN-1)** $\sum \hat u_i = 0$: a reta não erra sistematicamente pra cima nem pra baixo — os resíduos se equilibram.
> - **(EN-2)** $\sum \hat u_i x_i = 0$: os resíduos são **ortogonais** ao regressor — não sobra nenhuma relação linear entre o que erramos e o $x$. Se sobrasse, poderíamos usar essa relação para melhorar a reta; como não sobra, a reta é ótima.
>
> Estas duas condições são a **alma geométrica do MQO**: a reta ajustada é a projeção de $y$ no espaço gerado por $x$, e o resíduo é perpendicular a esse espaço. (É esta a leitura de álgebra linear — volto a ela no fim.)

> [!warning] "1ª e 2ª condição" no caderno ≠ 1ª e 2ª ORDEM
> Seu caderno rotula EN-1 e EN-2 como "1ª Condição" e "2ª Condição". Cuidado: **ambas são de primeira ordem** (as duas parciais do gradiente). A condição de *segunda* ordem é outra coisa — a Hessiana do Ato 4. Não confunda na prova.

---

# ATO 3 · Resolvendo o sistema: por que dividir por $n$ traz as médias

Temos duas equações e duas incógnitas ($\hat\beta_0,\hat\beta_1$). Vamos resolver.

## Passo 3.1 — o intercepto sai da EN-1

Abra a EN-1 escrevendo o resíduo por extenso e distribua a soma:
$$\sum_i (y_i - \hat\beta_0 - \hat\beta_1 x_i) = 0 \;\Longrightarrow\; \sum_i y_i - \sum_i \hat\beta_0 - \hat\beta_1\sum_i x_i = 0.$$

Como $\hat\beta_0$ é constante, $\sum_i \hat\beta_0 = n\,\hat\beta_0$:
$$\sum_i y_i - n\,\hat\beta_0 - \hat\beta_1\sum_i x_i = 0.$$

Agora **divida tudo por $n$**:
$$\frac{\sum_i y_i}{n} - \hat\beta_0 - \hat\beta_1\frac{\sum_i x_i}{n} = 0.$$

> [!question] Por que dividir por $n$?
> Porque $\frac{1}{n}\sum_i y_i$ **é a definição da média** $\bar y$, e $\frac{1}{n}\sum_i x_i = \bar x$. Dividir por $n$ é o que transforma "somas" em "médias" — e médias são objetos com significado (o centro dos dados). Sem esse passo, você fica com somas que não dizem nada; com ele, aparece a relação entre os centros.

$$\bar y - \hat\beta_0 - \hat\beta_1 \bar x = 0 \;\Longrightarrow\; \boxed{\hat\beta_0 = \bar y - \hat\beta_1 \bar x.}$$

> [!success] O que isso significa
> Reescrevendo: $\bar y = \hat\beta_0 + \hat\beta_1\bar x$. **A reta de MQO passa exatamente pelo ponto médio $(\bar x,\bar y)$** — o "centro de massa" da nuvem de pontos. Sempre. É uma âncora geométrica linda: não importa a inclinação, a reta pivota em torno do centro dos dados.

## Passo 3.2 — a inclinação sai da EN-2 (a parte trabalhosa)

Pegue a EN-2 na forma $\sum_i (y_i - \hat\beta_0 - \hat\beta_1 x_i)x_i = 0$, abra:
$$\sum_i y_i x_i - \hat\beta_0\sum_i x_i - \hat\beta_1\sum_i x_i^2 = 0.$$

Agora **substitua** $\hat\beta_0 = \bar y - \hat\beta_1\bar x$ (do passo anterior). Este é o truque que fecha o sistema:
$$\sum_i y_i x_i - (\bar y - \hat\beta_1\bar x)\sum_i x_i - \hat\beta_1\sum_i x_i^2 = 0.$$

Lembrando que $\sum_i x_i = n\bar x$, o termo do meio vira $(\bar y - \hat\beta_1\bar x)\,n\bar x = n\bar x\bar y - \hat\beta_1 n\bar x^2$. Substitui:
$$\sum_i y_i x_i - n\bar x\bar y + \hat\beta_1 n\bar x^2 - \hat\beta_1\sum_i x_i^2 = 0.$$

Junte os termos com $\hat\beta_1$:
$$\sum_i y_i x_i - n\bar x\bar y = \hat\beta_1\Big(\sum_i x_i^2 - n\bar x^2\Big).$$

Isole:
$$\boxed{\hat\beta_1 = \frac{\sum_i y_i x_i - n\bar x\bar y}{\sum_i x_i^2 - n\bar x^2}.}$$

Esta já é a fórmula "computável" (a que seu caderno escreve com $\sum y_i x_i - \frac{\sum y_i\sum x_i}{n}$ no numerador — é a mesma coisa, pois $n\bar x\bar y = \frac{\sum x_i \sum y_i}{n}$).

---

# ATO 4 · Condição de 2ª ordem: por que temos certeza de que é mínimo

As equações normais só garantem "derivada zero" — poderia ser mínimo, máximo ou sela. Precisamos confirmar que é **mínimo**.

> [!question] Por que checar a 2ª ordem?
> Porque derivada nula é necessária mas não suficiente. Num ponto de sela ou num máximo a derivada também zera. A **segunda derivada** diz a *concavidade*: se a "tigela" abre pra cima em todas as direções, é mínimo. Formalmente: a matriz Hessiana (das segundas derivadas) tem de ser **positiva definida**.

As segundas derivadas parciais:
$$\frac{\partial^2\mathrm{SQR}}{\partial\hat\beta_0^2} = 2n, \qquad \frac{\partial^2\mathrm{SQR}}{\partial\hat\beta_1^2} = 2\sum_i x_i^2, \qquad \frac{\partial^2\mathrm{SQR}}{\partial\hat\beta_0\partial\hat\beta_1} = 2\sum_i x_i.$$

A Hessiana:
$$H = 2\begin{bmatrix} n & \sum_i x_i \\[2pt] \sum_i x_i & \sum_i x_i^2\end{bmatrix}.$$

Para ser positiva definida, os menores principais líderes têm de ser positivos:
- $2n > 0$ ✓ (sempre).
- $\det(H) = 4\big(n\sum_i x_i^2 - (\sum_i x_i)^2\big) = 4n\sum_i (x_i-\bar x)^2 > 0$ **desde que haja variação em $x$**.

> [!success] A condição escondida: $x$ precisa variar
> O determinante só é positivo se $\sum(x_i-\bar x)^2 > 0$, ou seja, se **nem todos os $x_i$ são iguais**. Faz todo sentido: se $x$ não varia, não há como estimar o efeito de $x$ sobre $y$ — a reta não teria inclinação identificável. Esta é a versão escalar da hipótese de **posto completo** da forma matricial. Sem variação, o MQO não existe (dividiria por zero em $\hat\beta_1$).

Confirmado: o ponto das equações normais é um **mínimo**. $\blacksquare$

---

# ATO 5 · A forma reveladora: por que $\hat\beta_1 = \mathrm{Cov}/\mathrm{Var}$

A fórmula do Ato 3 é computável, mas feia. Vamos reescrevê-la numa forma que **revela o significado**. Para isso usamos duas identidades de somatório — e o ponto pedagógico aqui é *por que os termos cruzados somem*.

## As identidades (e por que valem)

**Identidade do numerador:** afirmo que
$$\sum_i (x_i - \bar x)(y_i - \bar y) = \sum_i y_i x_i - n\bar x\bar y.$$

*Demonstração* (expandindo o produto e distribuindo a soma):
$$\sum_i (x_i-\bar x)(y_i-\bar y) = \sum_i\big(x_i y_i - x_i\bar y - \bar x y_i + \bar x\bar y\big) = \sum_i x_i y_i - \bar y\sum_i x_i - \bar x\sum_i y_i + n\bar x\bar y.$$
Como $\sum x_i = n\bar x$ e $\sum y_i = n\bar y$:
$$= \sum_i x_i y_i - \bar y(n\bar x) - \bar x(n\bar y) + n\bar x\bar y = \sum_i x_i y_i - n\bar x\bar y - n\bar x\bar y + n\bar x\bar y = \sum_i x_i y_i - n\bar x\bar y. \checkmark$$

**Identidade do denominador** (é o caso particular $y=x$):
$$\sum_i (x_i - \bar x)^2 = \sum_i x_i^2 - n\bar x^2.$$

> [!question] Por que os termos cruzados desaparecem? O truque que resolve meia matéria
> Tudo se apoia num único fato:
> $$\sum_i (x_i - \bar x) = \sum_i x_i - n\bar x = n\bar x - n\bar x = 0.$$
> **A soma dos desvios em torno da média é sempre zero.** É por isso que, por exemplo, $\sum(x_i-\bar x)\bar y = \bar y\sum(x_i-\bar x) = \bar y\cdot 0 = 0$. Esse cancelamento é o que permite escrever o numerador de $\hat\beta_1$ "com barra" $\sum(x_i-\bar x)(y_i-\bar y)$ ou "sem barra" $\sum(x_i-\bar x)y_i$ — dá no mesmo. Guarde este fato; ele reaparece em quase toda demonstração escalar.

## Substituindo, a forma reveladora

Trocando numerador e denominador do Ato 3 pelas identidades:
$$\hat\beta_1 = \frac{\sum_i (x_i-\bar x)(y_i-\bar y)}{\sum_i (x_i-\bar x)^2}.$$

Divida numerador e denominador por $n$ e reconheça as definições amostrais:
$$\boxed{\hat\beta_1 = \frac{\frac{1}{n}\sum_i (x_i-\bar x)(y_i-\bar y)}{\frac{1}{n}\sum_i (x_i-\bar x)^2} = \frac{\widehat{\mathrm{Cov}}(x,y)}{\widehat{\mathrm{Var}}(x)}.}$$

> [!success] O significado — e é lindo
> A inclinação do MQO é **a covariância entre $x$ e $y$ dividida pela variância de $x$**. Ou seja: pega toda a co-variação entre os dois e "normaliza" pela dispersão do regressor. Se $x$ e $y$ variam juntos (Cov alta), a inclinação é grande; se $x$ varia muito por conta própria (Var alta), a inclinação é amortecida. É o análogo amostral exato do parâmetro populacional $\beta_1 = \mathrm{Cov}(x,y)/\mathrm{Var}(x)$.

> [!danger] Não é raiz no denominador!
> É $\widehat{\mathrm{Var}}(x)$ **sem raiz**. A raiz aparece no **coeficiente de correlação** $r = \frac{\widehat{\mathrm{Cov}}(x,y)}{\sqrt{\widehat{\mathrm{Var}}(x)}\sqrt{\widehat{\mathrm{Var}}(y)}}$, não na inclinação. (Sua versão limpa de 01/09 já está correta; uma versão anterior do caderno tinha esse deslize.)

---

# ATO 6 · Entrando na inferência: o estimador como variável aleatória

Até aqui foi **álgebra** — vale para qualquer amostra, sempre. Agora vem a virada para a **estatística**: $\hat\beta_1$ é calculado de uma amostra, e amostras variam. Então $\hat\beta_1$ é uma **variável aleatória** — tem esperança e variância. Estudar isso é estudar a *qualidade* do estimador.

## Aquecimento: a média amostral como estimador

Seu caderno faz um aquecimento com o estimador mais simples — a média $\bar x$ como estimadora de $\mu$. Vale a lógica, que é a mesma para $\hat\beta_1$.

**Não-viés da média** (usando $E[x_i]=\mu$ e linearidade da esperança):
$$E[\bar x] = E\Big[\frac{1}{n}\sum_i x_i\Big] = \frac{1}{n}\sum_i E[x_i] = \frac{1}{n}\cdot n\mu = \mu.$$

> [!question] Por que "tirar a esperança para dentro do somatório"?
> Porque a esperança é **linear**: $E[\sum a_i] = \sum E[a_i]$ e $E[c\cdot Z]=c\cdot E[Z]$ para constante $c$. Isso vale *sempre*, com ou sem independência. É o que permite empurrar o $E[\cdot]$ através da soma e do $\frac{1}{n}$ até bater em cada $x_i$, onde usamos o que sabemos ($E[x_i]=\mu$). Sem linearidade, a conta travava.

**Variância da média** (usando independência, então a variância da soma é a soma das variâncias):
$$\mathrm{Var}(\bar x) = \mathrm{Var}\Big(\frac{1}{n}\sum_i x_i\Big) = \frac{1}{n^2}\sum_i \mathrm{Var}(x_i) = \frac{1}{n^2}\cdot n\sigma^2 = \frac{\sigma^2}{n}.$$

> [!question] Por que o $\frac{1}{n^2}$? E por que a variância cai?
> A variância "puxa constante ao quadrado": $\mathrm{Var}(cZ)=c^2\mathrm{Var}(Z)$. Como $c=\frac{1}{n}$, sai $\frac{1}{n^2}$. Depois a soma de $n$ variâncias iguais dá $n\sigma^2$, e $\frac{n\sigma^2}{n^2}=\frac{\sigma^2}{n}$. O resultado tem uma moral profunda:
> $$\lim_{n\to\infty}\frac{\sigma^2}{n} = 0.$$
> **Quanto maior a amostra, menor a variância do estimador** — ele se concentra cada vez mais em torno do alvo. Isto é a semente da **consistência**: variância indo a zero + não-viés significa que o estimador converge para o parâmetro. É a razão de "mais dados = estimativa melhor".

Agora aplicamos exatamente essa lógica ao $\hat\beta_1$ — só que primeiro precisamos escrevê-lo do jeito certo.

---

# ATO 7 · Propriedade 1 — Linearidade (o truque dos pesos $k_i$)

> [!question] Por que reescrever $\hat\beta_1$ como $\sum k_i y_i$?
> Porque para estudar esperança e variância de $\hat\beta_1$ precisamos vê-lo como uma **combinação linear dos $y_i$** — uma soma de "peso vezes observação". Com os $y_i$ isolados e pesos constantes (dado $x$), a linearidade da esperança e as regras de variância se aplicam direto. Este passo *é* a demonstração de que o MQO é **linear** (a 1ª propriedade do caderno).

Defina os **pesos**:
$$k_i = \frac{x_i - \bar x}{\sum_j (x_j - \bar x)^2}.$$

Então, da forma reveladora do Ato 5:
$$\hat\beta_1 = \frac{\sum_i (x_i-\bar x)(y_i-\bar y)}{\sum_i (x_i-\bar x)^2} = \frac{\sum_i (x_i-\bar x)y_i}{\sum_j(x_j-\bar x)^2} = \sum_i k_i y_i.$$

(Usei a identidade do Ato 5: $\sum(x_i-\bar x)(y_i-\bar y)=\sum(x_i-\bar x)y_i$.)

## As três propriedades dos pesos (e por que cada uma importa)

Estas três aparecem no seu caderno como i, ii, iii. São o motor de tudo que vem depois.

**i)** $\displaystyle\sum_i k_i = 0.$
$$\sum_i k_i = \frac{\sum_i (x_i-\bar x)}{\sum_j(x_j-\bar x)^2} = \frac{0}{\;\cdot\;} = 0 \quad(\text{soma dos desvios} = 0).$$
*Por que importa:* mata o termo do intercepto $\beta_0$ na conta do não-viés.

**ii)** $\displaystyle\sum_i k_i x_i = 1.$
$$\sum_i k_i x_i = \frac{\sum_i (x_i-\bar x)x_i}{\sum_j(x_j-\bar x)^2} = \frac{\sum_i (x_i-\bar x)^2}{\sum_j(x_j-\bar x)^2} = 1.$$
*Por que importa:* é o que faz o coeficiente de $\beta_1$ virar exatamente $1$ — o estimador "acerta" o parâmetro.

**iii)** $\displaystyle\sum_i k_i^2 = \frac{1}{\sum_i (x_i-\bar x)^2}.$
$$\sum_i k_i^2 = \frac{\sum_i (x_i-\bar x)^2}{\big(\sum_j(x_j-\bar x)^2\big)^2} = \frac{1}{\sum_i (x_i-\bar x)^2}.$$
*Por que importa:* é exatamente o fator que aparece na **variância** de $\hat\beta_1$ (Ato 9).

---

# ATO 8 · Propriedade 2 — Não-viés (por que $E[\varepsilon\mid x]=0$ é a chave)

> [!note] O que queremos
> Mostrar que, em média sobre todas as amostras possíveis, o estimador acerta o alvo:
> $$E[\hat\beta_1\mid x] = \beta_1.$$

## Passo 8.1 — substituir o modelo verdadeiro

Em $\hat\beta_1 = \sum_i k_i y_i$, troque $y_i$ pelo modelo populacional $y_i = \beta_0 + \beta_1 x_i + \varepsilon_i$:
$$\hat\beta_1 = \sum_i k_i(\beta_0 + \beta_1 x_i + \varepsilon_i) = \beta_0\sum_i k_i + \beta_1\sum_i k_i x_i + \sum_i k_i\varepsilon_i.$$

> [!question] Por que substituir o modelo verdadeiro aqui?
> Porque queremos comparar $\hat\beta_1$ (o que calculamos) com $\beta_1$ (a verdade). Só dá para fazer essa ponte injetando a definição verdadeira de $y_i$ dentro do estimador. É o momento em que o mundo amostral e o populacional se encontram.

Agora use as propriedades **i** ($\sum k_i = 0$) e **ii** ($\sum k_i x_i = 1$):
$$\hat\beta_1 = \beta_0\cdot 0 + \beta_1\cdot 1 + \sum_i k_i\varepsilon_i = \beta_1 + \sum_i k_i\varepsilon_i.$$

> [!success] A identidade fundamental do estimador
> $$\hat\beta_1 = \beta_1 + \sum_i k_i\varepsilon_i.$$
> Leia em voz alta: **o estimador é igual ao parâmetro verdadeiro mais um termo de erro amostral**. Todo o resto (viés, variância, eficiência) é sobre o comportamento desse segundo termo. Se ele tem média zero → não-viés. Se ele tem variância pequena → precisão. Guarde esta linha; ela é o coração da inferência do MQO.

## Passo 8.2 — tirar a esperança condicional

$$E[\hat\beta_1\mid x] = \beta_1 + \sum_i k_i\, E[\varepsilon_i\mid x].$$

> [!question] Por que os $k_i$ "saem" da esperança? E por que condicionar em $x$?
> Condicionamos em $x$ (tratamos os $x_i$ como dados/fixos). Feito isso, cada $k_i = \frac{x_i-\bar x}{\sum(x_j-\bar x)^2}$ é composto só de $x$'s → é **constante** dado $x$. E constante sai da esperança: $E[\sum k_i\varepsilon_i\mid x] = \sum k_i E[\varepsilon_i\mid x]$. Condicionar em $x$ é o que "congela" os pesos e deixa a aleatoriedade só no erro $\varepsilon$ — que é onde ela deve estar.

Agora a **hipótese-chave**: exogeneidade em média, $E[\varepsilon_i\mid x]=0$.
$$E[\hat\beta_1\mid x] = \beta_1 + \sum_i k_i\cdot 0 = \boxed{\beta_1.}$$

$$\Rightarrow \text{MQO é NÃO-VIESADO.} \qquad\blacksquare$$

> [!danger] Onde tudo pode desmoronar: endogeneidade
> O não-viés inteiro pendura-se em $E[\varepsilon_i\mid x]=0$. Se $x$ for **endógeno** (correlacionado com o erro — por variável omitida, simultaneidade ou erro de medição no regressor), então $E[\varepsilon_i\mid x]\neq 0$, o termo $\sum k_i E[\varepsilon_i\mid x]$ **não zera**, e o estimador fica **viesado**. É exatamente por isso que existem variáveis instrumentais (ver [[Prova Zambon 2025/2#Q6 · O estimador de variáveis instrumentais]]) e por que a identificação causal no seu [[DiD]] é tão disputada. Toda inferência causal é, no fundo, uma luta para garantir esta única hipótese.

---

# ATO 9 · Propriedade 3 — Variância (por que homocedasticidade entra aqui)

> [!note] O que queremos
> $$\mathrm{Var}(\hat\beta_1\mid x) = \frac{\sigma^2}{\sum_i (x_i-\bar x)^2}.$$

Da identidade fundamental (Ato 8), condicionando em $x$:
$$\mathrm{Var}(\hat\beta_1\mid x) = \mathrm{Var}\Big(\beta_1 + \sum_i k_i\varepsilon_i \;\Big|\; x\Big) = \mathrm{Var}\Big(\sum_i k_i\varepsilon_i \;\Big|\; x\Big).$$

> [!question] Por que o $\beta_1$ some da variância?
> Porque $\beta_1$ é uma **constante** (o parâmetro verdadeiro, fixo). Variância de constante é zero, e somar constante não muda a dispersão: $\mathrm{Var}(c + Z) = \mathrm{Var}(Z)$. Então só o termo aleatório $\sum k_i\varepsilon_i$ contribui.

Expandindo a variância de uma soma (que em geral tem variâncias + covariâncias):
$$\mathrm{Var}\Big(\sum_i k_i\varepsilon_i\Big) = \sum_i k_i^2\,\mathrm{Var}(\varepsilon_i\mid x) + \sum_{i\neq j} k_i k_j\,\mathrm{Cov}(\varepsilon_i,\varepsilon_j\mid x).$$

Agora entram **duas hipóteses**, e é importante ver que são duas:

> [!question] Por que precisamos de homocedasticidade E ausência de autocorrelação?
> - **Homocedasticidade** $\mathrm{Var}(\varepsilon_i\mid x)=\sigma^2$ (mesma variância para todo $i$): permite trocar cada $\mathrm{Var}(\varepsilon_i\mid x)$ pelo *mesmo* $\sigma^2$ e fatorá-lo para fora da soma. Sem ela, cada termo teria seu próprio $\sigma_i^2$ e a fórmula limpa não sairia.
> - **Ausência de autocorrelação** $\mathrm{Cov}(\varepsilon_i,\varepsilon_j\mid x)=0$ para $i\neq j$: **mata todo o segundo somatório** (os termos cruzados). Sem ela, sobrariam covariâncias entre erros de observações diferentes.
>
> As duas juntas são o que seu caderno resume como a hipótese de variância. Quando alguma falha, a fórmula muda (e é por isso que existe erro-padrão robusto e MQG — assunto da 2ª prova).

Sob as duas hipóteses, o segundo somatório zera e o primeiro fatora:
$$\mathrm{Var}(\hat\beta_1\mid x) = \sigma^2\sum_i k_i^2.$$

Use a propriedade **iii** dos pesos ($\sum k_i^2 = \frac{1}{\sum(x_i-\bar x)^2}$):
$$\boxed{\mathrm{Var}(\hat\beta_1\mid x) = \frac{\sigma^2}{\sum_i (x_i-\bar x)^2}.} \qquad\blacksquare$$

> [!success] O que a fórmula ensina sobre precisão
> A variância do estimador — quão "trêmula" ela é entre amostras — cai quando:
> 1. **$\sigma^2$ é pequeno** (erros pequenos, modelo que explica bem);
> 2. **$\sum(x_i-\bar x)^2$ é grande** (o regressor $x$ varia bastante).
>
> A segunda é contraintuitiva e importante: **mais variação em $x$ dá estimativas mais precisas**. Faz sentido — se $x$ mal se move, é difícil enxergar seu efeito sobre $y$. É por isso que, no seu [[DiD]], ter muita variação no tratamento (unidades tratadas em momentos variados) melhora a precisão. E é a mesma raiz do problema de **multicolinearidade**: quando um regressor tem pouca variação "própria" (é quase explicado pelos outros), sua variância explode.

---

# ATO 10 · O clímax — Teorema de Gauss-Markov (MQO é BLUE)

Já sabemos que o MQO é **linear** (Ato 7) e **não-viesado** (Ato 8), e sabemos sua **variância** (Ato 9). Falta a pergunta final: *entre todos os estimadores lineares e não-viesados, o MQO é o melhor?* A resposta é sim — é o de **menor variância**. Isto é o Teorema de Gauss-Markov, e o acrônimo é **BLUE** (*Best Linear Unbiased Estimator*).

## A imagem do alvo (seu diagrama)

> [!info] Lendo o alvo do caderno
> Pense em quatro atiradores mirando o centro (o parâmetro verdadeiro):
> - **Viesado + impreciso**: tiros espalhados e deslocados do centro. Péssimo.
> - **Viesado + preciso**: tiros agrupados, mas longe do centro. Confiantemente errado.
> - **Não-viesado + impreciso**: tiros centrados na média, mas espalhados. Certo "em média", pouco confiável em uma amostra.
> - **Não-viesado + preciso (eficiente)**: tiros agrupados no centro. **É o MQO** sob Gauss-Markov.
>
> A seta do seu caderno aponta: estimadores → não-viesados → lineares → eficientes → **MQO**. O MQO ocupa o miolo do alvo dentro da classe dos lineares não-viesados.

## A decomposição do EQM (por que "eficiente" = menor variância aqui)

O **Erro Quadrático Médio** mede o erro total de um estimador:
$$\mathrm{EQM}[\hat\theta] = \mathrm{Var}[\hat\theta] + \big(\text{viés}[\hat\theta]\big)^2.$$

> [!question] Por que essa decomposição importa para Gauss-Markov?
> Porque ela separa as duas fontes de erro: **dispersão** (variância) e **deslocamento** (viés²). Gauss-Markov fixa o viés em **zero** (só olha estimadores não-viesados) e, nesse universo, o EQM vira puramente a variância. Logo "melhor" (menor EQM) = "menor variância". É por isso que, na classe dos lineares não-viesados, ser eficiente é exatamente ter a menor variância.
>
> Nota fina: fora dessa classe, às vezes vale aceitar um *pouco* de viés para ganhar *muito* menos variância (estimadores encolhidos/ridge têm EQM menor). Mas isso é fora do escopo de Gauss-Markov, que se restringe aos não-viesados.

## O argumento (esboço rigoroso — a prova completa está na referência)

Tome qualquer outro estimador linear não-viesado $\tilde\beta_1 = \sum_i w_i y_i$. Escreva seus pesos como os do MQO mais um desvio: $w_i = k_i + d_i$. O não-viés força $\sum d_i = 0$ e $\sum d_i x_i = 0$. A variância então se decompõe:
$$\mathrm{Var}(\tilde\beta_1\mid x) = \sigma^2\sum_i (k_i + d_i)^2 = \underbrace{\sigma^2\sum_i k_i^2}_{\mathrm{Var}(\hat\beta_1)} + \underbrace{2\sigma^2\sum_i k_i d_i}_{=\,0} + \underbrace{\sigma^2\sum_i d_i^2}_{\ge\,0}.$$

O termo cruzado zera (usando as condições sobre $d_i$) e sobra:
$$\mathrm{Var}(\tilde\beta_1\mid x) = \mathrm{Var}(\hat\beta_1\mid x) + \sigma^2\sum_i d_i^2 \;\ge\; \mathrm{Var}(\hat\beta_1\mid x).$$

Como $\sigma^2\sum d_i^2 \ge 0$, **nenhum** estimador linear não-viesado tem variância menor que o MQO. Igualdade só quando todo $d_i=0$, isto é, quando $\tilde\beta_1$ é o próprio MQO. $\blacksquare$

> [!success] Conclusão de Gauss-Markov
> **Na classe de todos os estimadores lineares e não-viesados, o MQO é o de menor variância — é eficiente (BLUE).** É este teorema que *justifica* usar MQO. A versão matricial completa (para $k$ regressores) está em [[Demonstrações Econometria I mês 1#D16 · Gauss–Markov matricial: MQO é BLUE]].

---
---

# 📦 QUADRO-RESUMO

> [!abstract] Tudo em uma tela
> **Setup:** $y_i = \beta_0 + \beta_1 x_i + \varepsilon_i$ (população) → estima-se minimizando $\mathrm{SQR} = \sum \hat u_i^2$.
>
> **Condições de 1ª ordem (equações normais):**
> $$\sum_i \hat u_i = 0 \qquad\text{e}\qquad \sum_i \hat u_i x_i = 0.$$
>
> **Estimadores:**
> $$\hat\beta_0 = \bar y - \hat\beta_1\bar x \qquad\text{(a reta passa por }(\bar x,\bar y)\text{)}$$
> $$\hat\beta_1 = \frac{\sum_i (x_i-\bar x)(y_i-\bar y)}{\sum_i (x_i-\bar x)^2} = \frac{\widehat{\mathrm{Cov}}(x,y)}{\widehat{\mathrm{Var}}(x)}.$$
>
> **Identidade fundamental:** $\hat\beta_1 = \beta_1 + \sum_i k_i\varepsilon_i$, com $k_i = \dfrac{x_i-\bar x}{\sum(x_j-\bar x)^2}$.
>
> **Propriedades (sob as hipóteses clássicas):**
> | Propriedade | Resultado | Hipótese-chave |
> |---|---|---|
> | Linear | $\hat\beta_1 = \sum k_i y_i$ | (álgebra) |
> | Não-viesado | $E[\hat\beta_1\mid x] = \beta_1$ | $E[\varepsilon\mid x]=0$ |
> | Variância | $\mathrm{Var}(\hat\beta_1\mid x) = \dfrac{\sigma^2}{\sum(x_i-\bar x)^2}$ | homoced. + s/ autocorr. |
> | Eficiente (BLUE) | menor variância entre lineares não-viesados | Gauss-Markov |
>
> **Propriedades algébricas dos resíduos** (sempre, sem hipótese): $\sum\hat u_i = 0$, $\sum\hat u_i x_i = 0$, $\widehat{\mathrm{Cov}}(\hat u, x)=0$.

## Os fatos que resolvem 90% das contas

> [!tip] Decore estes, não as fórmulas finais
> 1. **$\sum_i (x_i - \bar x) = 0$** — a soma dos desvios é zero (mata termos cruzados).
> 2. **Linearidade da esperança** — $E[\sum a_i] = \sum E[a_i]$, sempre (permite entrar no somatório).
> 3. **$\mathrm{Var}(cZ) = c^2\mathrm{Var}(Z)$** — a variância puxa constante ao quadrado.
> 4. **Condicionar em $x$ congela os $k_i$** — vira tudo constante, e constante sai de $E$ e de $\mathrm{Var}$.
> 5. **Identidade fundamental $\hat\beta = \beta + (\text{erro amostral})$** — a partir dela saem viés e variância.

---
---

# 🔭 As três lentes: como o mesmo objeto aparece em cada disciplina

O MQO é, ao mesmo tempo, um objeto de três mundos. Ver os três de uma vez é o que separa quem *entende* de quem *decora*.

## Lente 1 — Inferência estatística

Aqui $\hat\beta_1$ é uma **variável aleatória** com distribuição amostral. A pergunta é *quão bom é o estimador*: ele acerta em média (não-viés)? é preciso (variância)? é o melhor (eficiência)? Os conceitos-chave — esperança, variância, o Teorema do Limite Central, distribuição amostral — vêm daqui. É a lente que fundamenta **teste de hipótese** e **intervalo de confiança**: sabendo $E[\hat\beta_1]$ e $\mathrm{Var}(\hat\beta_1)$, você padroniza e compara com a normal/$t$. Sem a lente estatística, o MQO seria só um número, não uma *estimativa com incerteza quantificada*.

## Lente 2 — Econometria

Aqui o foco é a **identificação de relações causais/econômicas** a partir de dados observacionais. O modelo $y = \beta_0 + \beta_1 x + \varepsilon$ carrega uma *teoria*: $\beta_1$ é o efeito de $x$ sobre $y$. As hipóteses (especialmente $E[\varepsilon\mid x]=0$) são afirmações **econômicas** sobre o mundo — "não há variável omitida correlacionada com $x$". A econometria é a lente que pergunta *quando podemos interpretar $\hat\beta_1$ como efeito causal, e não mera correlação*. É onde entram endogeneidade, variáveis instrumentais, DiD — e é a lente da sua dissertação.

## Lente 3 — Álgebra linear

Aqui o MQO é **geometria de projeção**. Escrevendo $y = X\beta + \varepsilon$, o estimador $\hat\beta = (X'X)^{-1}X'y$ **projeta** o vetor $y$ no subespaço gerado pelas colunas de $X$. As equações normais $\sum\hat u_i = 0$ e $\sum\hat u_i x_i = 0$ dizem exatamente que **o resíduo é ortogonal a esse subespaço** — o resíduo é a componente de $y$ que não "cabe" no espaço de $X$. Minimizar $\sum\hat u_i^2$ = achar o ponto do subespaço **mais próximo** de $y$ = projeção ortogonal. As "identidades de somatório" do Ato 5 são, nessa lente, produtos internos; a "variação em $x$" do Ato 4 é a **independência linear das colunas** (posto completo). A álgebra linear é a lente que **unifica** regressão simples e múltipla numa fórmula só e que torna tudo computável.

> [!success] A síntese
> **Uma reta.** Três verdades sobre ela:
> - *Estatística*: é um chute com incerteza que sei quantificar (e que melhora com $n$).
> - *Econometria*: sob as hipóteses certas, é um efeito causal — não só correlação.
> - *Álgebra linear*: é a projeção ortogonal de $y$ no espaço de $x$.
>
> Quando você resolve uma questão do Zambon, está sempre usando as três ao mesmo tempo: deriva com **cálculo/álgebra**, interpreta as hipóteses com **econometria**, e conclui sobre viés/variância com **inferência**.

---

## 📚 Documentos relacionados

> [!note] No vault
> - [[Demonstrações Econometria I mês 1]] — o índice-referência (D0–D16); esta caminhada é a versão "narrada" de D0–D11
> - [[Prova Zambon 2025/2]] — a prova real resolvida; a Questão 3 é exatamente os Atos 2–5 daqui
> - [[Plano Econometria I]] — cronograma até a prova de 02/10
> - [[Lista 1]] — os 74 exercícios
> - [[DiD]] — onde a lente econométrica (identificação causal) encontra sua dissertação
