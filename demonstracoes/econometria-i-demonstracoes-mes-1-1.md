---
title: "Econometria I — Índice de demonstrações do 1º mês"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
livro-base: Greene, Econometric Analysis, 7ª ed.
aulas: [14/08, 21/08, 28/08]
prova-1: 2026-10-02
tags:
  - econometria
  - mestrado/ppgeco
  - mqo
  - demonstracoes
  - greene
aliases:
  - Demonstrações Econometria I mês 1
  - Roteiro de provas MQO
  - O que preciso demonstrar Econometria I
---

# Econometria I — Índice de demonstrações do 1º mês

> [!abstract] Como usar este documento
> Isto é o **roteiro do que você precisa saber demonstrar** do primeiro mês (aulas de **14/08**, **21/08** e **28/08**), reconstruído a partir do seu caderno + [[Lista 1]]. A lógica é uma só: a **regressão simples** (14/08) e a **regressão múltipla em forma matricial** (21/08–28/08) são a *mesma* dedução vista de dois ângulos — escalar e vetorial. A prova do Zambon cobra as duas. A 28/08 fecha a rota matricial provando **não-viés, variância e Gauss-Markov** em forma vetorial.
>
> Cada demonstração vem em três camadas: **(1) o que se quer provar** (enunciado limpo), **(2) por que importa** (a fundamentação — de onde vem e pra onde vai), e **(3) o passo a passo com cada linha justificada**. Onde seu caderno tinha um salto ou um erro de notação, está marcado com `[!warning]`.
>
> Complementa [[MQO — regressão simples]] (que detalha a 14/08) e o [[Plano Econometria I]]. Faz par com o guia de revisão da [[Lista 1]].

---

## 🗺️ Mapa das demonstrações

O primeiro mês tem **duas rotas paralelas** que chegam ao mesmo estimador. Toda a matéria é isto:

| # | Demonstração | Aula | Bloco | Depende de |
|---|--------------|------|-------|------------|
| **D0** | Kit de operadores: $E$, $\operatorname{Var}$, $\operatorname{Cov}$ | 14/08 | Fundamentos | — |
| **D1** | FRP como esperança condicional $E[y\mid x]$ | 14/08 | Escalar | D0 |
| **D2** | Parâmetros populacionais por condições de momento | 14/08 | Escalar | D0, D1 |
| **D3** | As duas equações normais (condições de 1ª ordem) | 14/08 | Escalar | — |
| **D4** | $\hat\beta_0 = \bar y - \hat\beta_1 \bar x$ | 14/08 | Escalar | D3 |
| **D5** | Identidades de somatório (as 4 formas) | 14/08 | Escalar | álgebra |
| **D6** | $\hat\beta_1 = \dfrac{\widehat{\operatorname{Cov}}(x,y)}{\widehat{\operatorname{Var}}(x)}$ | 14/08 | Escalar | D3, D4, D5 |
| **D7** | Condição de 2ª ordem (Hessiana → mínimo) | 14/08 | Escalar | D3 |
| **D8** | Propriedades algébricas dos resíduos | 14/08 | Escalar | D3 |
| **D9** | Não-viés: $E[\hat\beta_1\mid X] = \beta_1$ | 14/08 | Propriedades | D6, hipóteses |
| **D10** | Variância: $\operatorname{Var}(\hat\beta_1\mid X) = \dfrac{\sigma^2}{\sum(x_i-\bar x)^2}$ | 14/08 | Propriedades | D9 |
| **D11** | Gauss–Markov: MQO é BLUE | 14/08 | Propriedades | D9, D10 |
| **D12** | Forma matricial $y = X\beta + \varepsilon$ e as 5 hipóteses | 21/08 | Matricial | D0 |
| **D13** | $\hat\beta = (X'X)^{-1}X'y$ por cálculo matricial | 21/08 | Matricial | D12, formas quadráticas |
| **D14** | $\operatorname{Var}(\hat\beta\mid X) = \sigma^2 (X'X)^{-1}$ | 21/08 | Matricial | D13 |
| **D15** | Multicolinearidade: efeito na variância e FIV | 21/08 | Matricial | D14 |
| **D16** | Gauss–Markov matricial: MQO é BLUE (via $b_0 = Cy$) | 28/08 | Matricial | D13, D14 |

> [!tip] Ordem de estudo sugerida
> Domine **D3 → D4 → D5 → D6** primeiro (é o esqueleto escalar que cai garantido). Depois **D9 → D10 → D11** (propriedades). Só então salte para o matricial **D12 → D13 → D14 → D16**, que *reempacota* tudo em vetores. **D13** é a demonstração-rainha; **D16** (Gauss-Markov matricial) foi o fecho da 28/08 e conversa direto com D11.

---
---

# PARTE I · Rota escalar (regressão simples) — 14/08

## D0 · O kit de operadores

> [!note] O que se quer
> Ter na ponta da língua as regras de **esperança**, **variância** e **covariância** — porque toda demonstração de MQO é uma recombinação delas. Não são "revisão"; são as ferramentas.

**Fundamentação.** O modelo de regressão é uma afirmação sobre *momentos* de variáveis aleatórias. Sem operar $E[\cdot]$, $\operatorname{Var}(\cdot)$ e $\operatorname{Cov}(\cdot,\cdot)$ com fluência, nenhuma linha das provas abaixo se sustenta. Referência: Greene, Ap. B.3–B.8.

**Regras (com as condições em que valem):**

Esperança — **linearidade** (vale sempre, com ou sem independência), para constantes $a,b$:
$$E[a + bX] = a + b\,E[X], \qquad E[X+Y] = E[X] + E[Y].$$

Variância — para constantes $a,b$:
$$\operatorname{Var}(a + bX) = b^2 \operatorname{Var}(X).$$
$$\operatorname{Var}(X) = E[X^2] - (E[X])^2 \equiv E\big[(X - E[X])^2\big].$$

Covariância — **bilinearidade**:
$$\operatorname{Cov}(X, Y) = E[XY] - E[X]E[Y] \equiv E\big[(X - E[X])(Y - E[Y])\big],$$
$$\operatorname{Cov}(a + bX,\; c + dY) = bd\,\operatorname{Cov}(X, Y).$$

> [!warning] Independência ⟹ Cov = 0, mas **não** a volta
> $\operatorname{Cov}(X,Y)=0$ significa apenas *ausência de relação linear*. Independência é mais forte. A recíproca só vale sob normalidade conjunta. Isto reaparece em D1 (correlação ≠ dependência) e no seu caderno da 21/08 ("$\operatorname{Cov}$ entre variáveis pode causar problemas" = multicolinearidade).

---

## D1 · A Função de Regressão Populacional como esperança condicional

> [!note] O que se quer provar
> Que o modelo $y_i = \beta_0 + \beta_1 x_i + \varepsilon_i$ com $E[\varepsilon_i \mid x_i]=0$ equivale a dizer que a **parte sistemática é a média condicional**:
> $$E[y_i \mid x_i] = \beta_0 + \beta_1 x_i.$$

**Fundamentação.** É a ponte entre "modelo com erro" e "modelo como previsão ótima". Seu caderno (14/08) registra isto como *"Correlação ≠ Dependência"* e a decomposição $y_i = E[y_i\mid x_i] + \varepsilon_i$. A FRP diz: o melhor palpite de $y$ dado $x$ é uma reta; o resíduo é o que sobra.

**Passo a passo.**

Partindo do modelo e aplicando $E[\cdot \mid x_i]$ dos dois lados:
$$E[y_i \mid x_i] = E[\beta_0 + \beta_1 x_i + \varepsilon_i \mid x_i].$$

Pela **linearidade** da esperança (D0):
$$E[y_i \mid x_i] = \underbrace{E[\beta_0\mid x_i]}_{=\,\beta_0} + \underbrace{E[\beta_1 x_i \mid x_i]}_{=\,\beta_1 x_i} + \underbrace{E[\varepsilon_i \mid x_i]}_{=\,0}.$$

- $E[\beta_0\mid x_i]=\beta_0$: constante.
- $E[\beta_1 x_i\mid x_i]=\beta_1 x_i$: condicionado a $x_i$, o termo $\beta_1 x_i$ é conhecido.
- $E[\varepsilon_i\mid x_i]=0$: **hipótese de exogeneidade em média** (a peça-chave).

Logo:
$$\boxed{E[y_i \mid x_i] = \beta_0 + \beta_1 x_i.}$$

> [!success] 🎯 Ponte com a tese
> Esta é a definição de "efeito causal médio" que você usa no [[DiD]]: a esperança condicional do desfecho dado o status de tratamento. O erro $\varepsilon_i$ carrega tudo que não é $x$ — e a validade da estimativa depende de $\varepsilon$ não estar correlacionado com $x$.

---

## D2 · Parâmetros populacionais por condições de momento

> [!note] O que se quer provar
> Que **antes de tocar em dados** os parâmetros já ficam definidos pelas duas condições de momento $E[\varepsilon]=0$ e $E[x\varepsilon]=0$, entregando:
> $$\beta_1 = \frac{\operatorname{Cov}(x,y)}{\operatorname{Var}(x)}, \qquad \beta_0 = E[y] - \beta_1 E[x].$$

**Fundamentação.** Separa o *populacional* (parâmetro verdadeiro, D2) do *amostral* (estimador, D6). O caderno da 14/08 traz exatamente esta linha: $\operatorname{Cov}[x,y] = \operatorname{Cov}[x,\beta_0] + \operatorname{Cov}[x,\beta_1 x] + \operatorname{Cov}[x,\varepsilon]$, que colapsa para $\beta_1 \operatorname{Var}(x)$.

**Passo a passo.**

Tome $\operatorname{Cov}(x, y)$ e substitua $y = \beta_0 + \beta_1 x + \varepsilon$:
$$\operatorname{Cov}(x, y) = \operatorname{Cov}(x,\; \beta_0 + \beta_1 x + \varepsilon).$$

Pela **bilinearidade** da covariância (D0):
$$\operatorname{Cov}(x, y) = \underbrace{\operatorname{Cov}(x, \beta_0)}_{=\,0} + \underbrace{\operatorname{Cov}(x, \beta_1 x)}_{=\,\beta_1 \operatorname{Var}(x)} + \underbrace{\operatorname{Cov}(x, \varepsilon)}_{=\,0}.$$

- $\operatorname{Cov}(x,\beta_0)=0$: covariância com constante é zero.
- $\operatorname{Cov}(x,\beta_1 x)=\beta_1\operatorname{Cov}(x,x)=\beta_1\operatorname{Var}(x)$.
- $\operatorname{Cov}(x,\varepsilon)=0$: decorre de $E[\varepsilon\mid x]=0$ (exogeneidade).

Isolando:
$$\boxed{\beta_1 = \frac{\operatorname{Cov}(x, y)}{\operatorname{Var}(x)}.}$$

E de $E[y]=\beta_0 + \beta_1 E[x] + \underbrace{E[\varepsilon]}_{0}$, isolando o intercepto:
$$\boxed{\beta_0 = E[y] - \beta_1 E[x].}$$

> [!info] Por que fazer o populacional primeiro
> O estimador de MQO (D6) tem **exatamente a mesma forma**, trocando momentos populacionais por amostrais. Ver os dois lado a lado deixa claro que MQO é o *análogo amostral* do método dos momentos. Cai como questão conceitual na prova.

---

## D3 · As duas equações normais (condições de 1ª ordem)

> [!note] O que se quer provar
> Que minimizar a Soma dos Quadrados dos Resíduos
> $$\mathrm{SQR}(\hat\beta_0, \hat\beta_1) = \sum_{i=1}^{n}\hat u_i^2 = \sum_{i=1}^{n}\big(y_i - \hat\beta_0 - \hat\beta_1 x_i\big)^2$$
> gera **duas equações normais**:
> $$\text{(EN-1)}\quad \sum_i (y_i - \hat\beta_0 - \hat\beta_1 x_i) = 0, \qquad \text{(EN-2)}\quad \sum_i (y_i - \hat\beta_0 - \hat\beta_1 x_i)\,x_i = 0.$$

**Fundamentação.** É o coração do MQO. O nome "mínimos quadrados" é literal: escolhemos $\hat\beta_0,\hat\beta_1$ que tornam a soma dos quadrados dos resíduos a menor possível. As duas equações normais são as condições de primeira ordem (derivadas parciais nulas). Seu caderno traz isso em duas páginas (a que começa em `min SQR` e a de `Condição de primeira ordem`).

**Passo a passo.**

**Derivada em relação a $\hat\beta_0$** (regra da cadeia; a derivada interna de $(y_i - \hat\beta_0 - \hat\beta_1 x_i)$ em $\hat\beta_0$ é $-1$):
$$\frac{\partial\, \mathrm{SQR}}{\partial \hat\beta_0} = \sum_i 2\big(y_i - \hat\beta_0 - \hat\beta_1 x_i\big)\cdot(-1) = 0.$$

Divide por $-2$:
$$\sum_i \big(y_i - \hat\beta_0 - \hat\beta_1 x_i\big) = 0. \tag{EN-1}$$

Como $\hat u_i = y_i - \hat\beta_0 - \hat\beta_1 x_i$, isto diz $\sum_i \hat u_i = 0$: **os resíduos somam zero**.

**Derivada em relação a $\hat\beta_1$** (derivada interna em $\hat\beta_1$ é $-x_i$):
$$\frac{\partial\, \mathrm{SQR}}{\partial \hat\beta_1} = \sum_i 2\big(y_i - \hat\beta_0 - \hat\beta_1 x_i\big)\cdot(-x_i) = 0.$$

Divide por $-2$:
$$\sum_i \big(y_i - \hat\beta_0 - \hat\beta_1 x_i\big)\,x_i = 0. \tag{EN-2}$$

Isto diz $\sum_i \hat u_i x_i = 0$: **os resíduos são ortogonais ao regressor**.

> [!warning] Correção de notação do caderno
> Na página da 14/08 a segunda condição aparece rotulada como *"2ª Condição"*. Cuidado: EN-1 e EN-2 **não** são "1ª e 2ª condições" no sentido de 1ª/2ª ordem — são **ambas de primeira ordem** (as duas parciais do gradiente). A condição de *segunda* ordem é outra coisa (a Hessiana, ver **D7**). Trocar os nomes na prova custa ponto.

> [!note] Notação: $m$ vs $n$
> Seu caderno usa $m$ para o tamanho da amostra. O padrão do Greene e da prova é $n$. Este documento usa **$n$**. Só um aviso pra não estranhar quando bater as fórmulas.

---

## D4 · O intercepto: $\hat\beta_0 = \bar y - \hat\beta_1 \bar x$

> [!note] O que se quer provar
> Que a reta de MQO **passa pelo ponto médio** $(\bar x, \bar y)$, o que dá:
> $$\hat\beta_0 = \bar y - \hat\beta_1 \bar x.$$

**Fundamentação.** Sai direto de EN-1 e é o primeiro resultado fechado. Geometricamente: o centro de massa da nuvem de pontos está sempre sobre a reta ajustada.

**Passo a passo.**

Parta de EN-1 e distribua a soma:
$$\sum_i (y_i - \hat\beta_0 - \hat\beta_1 x_i) = 0 \;\Longrightarrow\; \sum_i y_i - \sum_i \hat\beta_0 - \hat\beta_1\sum_i x_i = 0.$$

Como $\hat\beta_0$ é constante na soma, $\sum_i \hat\beta_0 = n\hat\beta_0$:
$$\sum_i y_i - n\hat\beta_0 - \hat\beta_1 \sum_i x_i = 0.$$

Divide tudo por $n$ e usa $\bar y = \frac{1}{n}\sum_i y_i$ e $\bar x = \frac{1}{n}\sum_i x_i$:
$$\bar y - \hat\beta_0 - \hat\beta_1 \bar x = 0.$$

Isola:
$$\boxed{\hat\beta_0 = \bar y - \hat\beta_1 \bar x.}$$

Equivalente a $\bar y = \hat\beta_0 + \hat\beta_1 \bar x$ — a reta passa por $(\bar x, \bar y)$, como você desenhou no caderno.

---

## D5 · As identidades de somatório (as quatro formas)

> [!note] O que se quer provar
> Que os numeradores/denominadores que aparecem em $\hat\beta_1$ têm **formas equivalentes**. As centrais são:
> $$\sum_i (x_i - \bar x)(y_i - \bar y) = \sum_i (x_i - \bar x)\,y_i = \sum_i x_i y_i - n\,\bar x\,\bar y,$$
> $$\sum_i (x_i - \bar x)^2 = \sum_i (x_i - \bar x)\,x_i = \sum_i x_i^2 - n\,\bar x^2.$$

**Fundamentação.** São puramente algébricas (não dependem do modelo), mas são o que permite passar da forma "bonita" $\sum(x_i-\bar x)(y_i-\bar y)$ para a forma "computável" $\sum x_i y_i - n\bar x\bar y$. Seu caderno dedica uma página inteira a isso (a de `Resultados` com a `Nota:`). Dominar essas manipulações é o que destrava D6.

**Passo a passo — identidade do numerador.**

Expanda o produto:
$$\sum_i (x_i - \bar x)(y_i - \bar y) = \sum_i \big(x_i y_i - x_i \bar y - \bar x\, y_i + \bar x\,\bar y\big).$$

Quebre a soma em quatro (linearidade do somatório):
$$= \sum_i x_i y_i - \bar y \sum_i x_i - \bar x \sum_i y_i + \sum_i \bar x\,\bar y.$$

Use $\sum_i x_i = n\bar x$, $\sum_i y_i = n\bar y$ e $\sum_i \bar x\bar y = n\bar x\bar y$:
$$= \sum_i x_i y_i - \bar y (n\bar x) - \bar x (n\bar y) + n\bar x\bar y = \sum_i x_i y_i - n\bar x\bar y - n\bar x\bar y + n\bar x\bar y.$$

Some os termos repetidos:
$$\boxed{\sum_i (x_i - \bar x)(y_i - \bar y) = \sum_i x_i y_i - n\bar x\bar y.}$$

**A forma do meio** ($\sum (x_i-\bar x)y_i$) sai porque o termo cruzado com $\bar y$ some:
$$\sum_i (x_i - \bar x)\bar y = \bar y \sum_i (x_i - \bar x) = \bar y\,(n\bar x - n\bar x) = 0,$$
já que $\sum_i(x_i - \bar x) = 0$ (**a soma dos desvios em torno da média é zero** — o fato mais usado da lista). Logo $\sum(x_i-\bar x)(y_i-\bar y) = \sum(x_i-\bar x)y_i$.

**Identidade do denominador:** é o caso particular com $y = x$:
$$\boxed{\sum_i (x_i - \bar x)^2 = \sum_i x_i^2 - n\bar x^2.}$$

> [!tip] O truque que resolve metade da lista
> $$\sum_i (x_i - \bar x) = 0.$$
> Guarde isto. Ele mata termos cruzados em quase toda demonstração escalar. É por causa dele que numerador e denominador de $\hat\beta_1$ podem ser escritos "com barra" ou "sem barra" indistintamente.

---

## D6 · O estimador de inclinação: $\hat\beta_1 = \widehat{\operatorname{Cov}}(x,y)/\widehat{\operatorname{Var}}(x)$

> [!note] O que se quer provar
> Resolvendo o sistema EN-1 + EN-2:
> $$\hat\beta_1 = \frac{\sum_i (x_i - \bar x)(y_i - \bar y)}{\sum_i (x_i - \bar x)^2} = \frac{\widehat{\operatorname{Cov}}(x, y)}{\widehat{\operatorname{Var}}(x)}.$$

**Fundamentação.** É o resultado central da regressão simples — o análogo amostral de D2. Fecha a rota escalar. Seu caderno chega nele na página do `Resumo`.

**Passo a passo.**

Substitua $\hat\beta_0 = \bar y - \hat\beta_1\bar x$ (D4) dentro de EN-2:
$$\sum_i \big(y_i - (\bar y - \hat\beta_1\bar x) - \hat\beta_1 x_i\big)x_i = 0.$$

Reagrupe dentro do parêntese, separando o que multiplica $\hat\beta_1$:
$$\sum_i \big[(y_i - \bar y) - \hat\beta_1(x_i - \bar x)\big]x_i = 0.$$

Distribua o $x_i$ e quebre a soma:
$$\sum_i (y_i - \bar y)x_i - \hat\beta_1 \sum_i (x_i - \bar x)x_i = 0.$$

Pela identidade D5, $\sum(y_i-\bar y)x_i = \sum(x_i-\bar x)(y_i-\bar y)$ e $\sum(x_i-\bar x)x_i = \sum(x_i-\bar x)^2$. Isola $\hat\beta_1$:
$$\boxed{\hat\beta_1 = \frac{\sum_i (x_i - \bar x)(y_i - \bar y)}{\sum_i (x_i - \bar x)^2}.}$$

Dividindo numerador e denominador por $n$, reconhece-se a covariância e a variância amostrais:
$$\hat\beta_1 = \frac{\frac{1}{n}\sum_i (x_i - \bar x)(y_i - \bar y)}{\frac{1}{n}\sum_i (x_i - \bar x)^2} = \frac{\widehat{\operatorname{Cov}}(x, y)}{\widehat{\operatorname{Var}}(x)}.$$

> [!danger] Erro do caderno a corrigir
> No `Resumo` da 14/08 o denominador aparece como $\sqrt{\widehat{\operatorname{Var}}(x)}$ (com raiz). **Está errado.** O denominador é $\widehat{\operatorname{Var}}(x)$ **sem raiz**.
> - *Pela dedução:* o denominador é literalmente $\sum(x_i-\bar x)^2$, sem raiz nenhuma.
> - *Por análise dimensional:* se $x$ está em reais e $y$ em kg, $\hat\beta_1$ tem de sair em kg/R\$. Ora, $\widehat{\operatorname{Cov}}$ tem unidade R\$·kg e $\widehat{\operatorname{Var}}(x)$ tem R\$². Então $\frac{\text{R\$·kg}}{\text{R\$}^2} = \frac{\text{kg}}{\text{R\$}}$ ✓. Com raiz no denominador a unidade quebraria.
> - A raiz aparece, sim, mas no **coeficiente de correlação** $r = \frac{\widehat{\operatorname{Cov}}(x,y)}{\sqrt{\widehat{\operatorname{Var}}(x)}\sqrt{\widehat{\operatorname{Var}}(y)}}$ — não na inclinação.

---

## D7 · Condição de 2ª ordem (a que garante que é mínimo)

> [!note] O que se quer provar
> Que o ponto crítico achado em D3 é de fato um **mínimo** (não máximo nem sela): a Hessiana de $\mathrm{SQR}$ é positiva definida.

**Fundamentação.** As equações normais só dizem que o gradiente é zero — isso vale para mínimo, máximo ou sela. Falta mostrar que é mínimo. Seu caderno **pula** este passo (é uma lacuna a preencher). Como $\mathrm{SQR}$ é uma soma de quadrados, o resultado é garantido, mas convém saber demonstrar.

**Passo a passo.**

As segundas derivadas parciais:
$$\frac{\partial^2 \mathrm{SQR}}{\partial \hat\beta_0^2} = \sum_i 2 = 2n,$$
$$\frac{\partial^2 \mathrm{SQR}}{\partial \hat\beta_1^2} = \sum_i 2x_i^2 = 2\sum_i x_i^2,$$
$$\frac{\partial^2 \mathrm{SQR}}{\partial \hat\beta_0\,\partial \hat\beta_1} = \sum_i 2x_i = 2\sum_i x_i.$$

A Hessiana:
$$H = 2\begin{bmatrix} n & \sum_i x_i \\[2pt] \sum_i x_i & \sum_i x_i^2 \end{bmatrix}.$$

Para ser positiva definida, precisamos dos menores principais líderes positivos:
- $H_{11} = 2n > 0$ ✓.
- $\det(H) = 4\big(n\sum_i x_i^2 - (\sum_i x_i)^2\big) = 4n\sum_i(x_i - \bar x)^2 > 0$,

onde a última igualdade usa a identidade D5 ($\sum x_i^2 - n\bar x^2 = \sum(x_i-\bar x)^2$, multiplicada por $n$). O determinante é positivo **desde que haja variação em $x$** (nem todo $x_i$ igual). Logo $H$ é positiva definida e o ponto é **mínimo**. $\blacksquare$

> [!info] A condição que reaparece no matricial
> "Precisa haver variação em $x$" é a versão escalar de **"$X$ tem posto completo"** (hipótese H5 da 21/08, ver D12). Sem variação/posto, não há estimador único.

---

## D8 · Propriedades algébricas dos resíduos

> [!note] O que se quer provar
> Consequências diretas das equações normais (valem por **álgebra**, sem hipótese estatística):
> 1. $\sum_i \hat u_i = 0$
> 2. $\sum_i \hat u_i x_i = 0$
> 3. $\widehat{\operatorname{Cov}}(\hat u, x) = 0$
> 4. a reta passa por $(\bar x, \bar y)$

**Fundamentação.** Distinguir o que é **álgebra** (sempre verdadeiro, vem das EN) do que é **estatística** (verdadeiro sob hipóteses, vem em D9–D11). Estas quatro valem em *qualquer* amostra, sempre. É o tipo de distinção que o Zambon cobra em questão conceitual.

**Passo a passo.**

**(1)** É exatamente EN-1: $\sum_i \hat u_i = 0$.

**(2)** É exatamente EN-2: $\sum_i \hat u_i x_i = 0$.

**(3)** A covariância amostral entre resíduo e regressor:
$$\widehat{\operatorname{Cov}}(\hat u, x) = \frac{1}{n}\sum_i (\hat u_i - \bar{\hat u})(x_i - \bar x).$$
Por (1), $\bar{\hat u} = 0$. Então:
$$= \frac{1}{n}\sum_i \hat u_i (x_i - \bar x) = \frac{1}{n}\Big(\underbrace{\sum_i \hat u_i x_i}_{=\,0\text{ por (2)}} - \bar x \underbrace{\sum_i \hat u_i}_{=\,0\text{ por (1)}}\Big) = 0.$$

> [!warning] Precisa das DUAS equações normais
> Repare que a conclusão (3) usa **EN-1 e EN-2 juntas**: EN-2 zera $\sum \hat u_i x_i$, mas o termo $\bar x\sum\hat u_i$ só some por EN-1. Uma só não basta. É um detalhe fino que vale destacar.

**(4)** É D4 relido: $\bar y = \hat\beta_0 + \hat\beta_1\bar x$.

---
---

# PARTE II · Propriedades estatísticas — 14/08

> A partir daqui as demonstrações **deixam de ser álgebra** e passam a depender das **hipóteses do modelo clássico**. O caderno lista, na página "Propriedades Estatísticas do MQO", que o estimador é **Linear** e **Não-tendencioso/sem viés**.

## As hipóteses do modelo clássico (versão escalar)

Antes de D9, fixe as hipóteses (elas reaparecem em forma matricial em D12):

| | Hipótese | Escalar |
|--|----------|---------|
| H1 | Linear nos parâmetros | $y_i = \beta_0 + \beta_1 x_i + \varepsilon_i$ |
| H2 | Amostra aleatória | $(x_i, y_i)$ i.i.d. |
| H3 | Variação no regressor | $\sum_i (x_i - \bar x)^2 > 0$ |
| H4 | Exogeneidade (média zero condicional) | $E[\varepsilon_i \mid x_i] = 0$ |
| H5 | Homocedasticidade | $\operatorname{Var}(\varepsilon_i \mid x_i) = \sigma^2$ |

## D9 · Não-viés: $E[\hat\beta_1 \mid X] = \beta_1$

> [!note] O que se quer provar
> Que, em média, o estimador acerta o parâmetro: $E[\hat\beta_1 \mid X] = \beta_1$. O caderno registra isto como *"Não-tendencioso / sem viés"*.

**Fundamentação.** Não-viés é a primeira coisa que se quer de um estimador: em amostras repetidas, ele se centra no valor verdadeiro. A demonstração usa o truque de escrever $\hat\beta_1$ como **combinação linear dos $y_i$** — o que também prova que ele é **linear** (a outra propriedade do caderno).

**Passo a passo.**

**Etapa 1 — $\hat\beta_1$ é linear em $y$.** Defina os pesos
$$k_i = \frac{x_i - \bar x}{\sum_j (x_j - \bar x)^2}.$$
Por D5/D6, $\hat\beta_1 = \sum_i k_i y_i$. Estes pesos têm três propriedades (todas de D5, e todas no seu caderno como i, ii, iii):
$$\text{(i) } \sum_i k_i = 0, \qquad \text{(ii) } \sum_i k_i x_i = 1, \qquad \text{(iii) } \sum_i k_i^2 = \frac{1}{\sum_i (x_i-\bar x)^2}.$$

*Prova de (i):* $\sum_i k_i = \frac{\sum_i (x_i-\bar x)}{\sum_j(x_j-\bar x)^2} = \frac{0}{\;\cdot\;} = 0$ (soma dos desvios é zero).
*Prova de (ii):* $\sum_i k_i x_i = \frac{\sum_i (x_i-\bar x)x_i}{\sum_j(x_j-\bar x)^2} = \frac{\sum_i (x_i-\bar x)^2}{\sum_j(x_j-\bar x)^2} = 1$.
*Prova de (iii):* $\sum_i k_i^2 = \frac{\sum_i (x_i-\bar x)^2}{\left(\sum_j(x_j-\bar x)^2\right)^2} = \frac{1}{\sum_i (x_i-\bar x)^2}$.

**Etapa 2 — substitui o modelo.** Como $y_i = \beta_0 + \beta_1 x_i + \varepsilon_i$:
$$\hat\beta_1 = \sum_i k_i(\beta_0 + \beta_1 x_i + \varepsilon_i) = \beta_0\underbrace{\sum_i k_i}_{0} + \beta_1\underbrace{\sum_i k_i x_i}_{1} + \sum_i k_i \varepsilon_i.$$

Ou seja, a identidade fundamental do estimador:
$$\hat\beta_1 = \beta_1 + \sum_i k_i \varepsilon_i.$$

O estimador é **o parâmetro verdadeiro mais um termo de erro amostral**.

**Etapa 3 — tira a esperança condicional.** Condicionando em $X$ (os $k_i$ viram constantes):
$$E[\hat\beta_1 \mid X] = \beta_1 + \sum_i k_i \underbrace{E[\varepsilon_i \mid X]}_{=\,0 \text{ por H4}} = \beta_1.$$

$$\boxed{E[\hat\beta_1 \mid X] = \beta_1.} \qquad \blacksquare$$

> [!info] Onde entra cada hipótese
> A linearidade em $y$ é álgebra. O **não-viés depende crucialmente de H4** ($E[\varepsilon\mid x]=0$). Se $x$ for endógeno (correlacionado com $\varepsilon$), o termo $\sum k_i E[\varepsilon_i\mid X]$ não zera e o estimador é **viesado** — é o motivo de existir variável instrumental (25/09) e de você precisar de identificação no [[DiD]].

---

## D10 · Variância: $\operatorname{Var}(\hat\beta_1 \mid X) = \dfrac{\sigma^2}{\sum_i (x_i - \bar x)^2}$

> [!note] O que se quer provar
> $$\operatorname{Var}(\hat\beta_1 \mid X) = \frac{\sigma^2}{\sum_i (x_i - \bar x)^2}.$$
> (No caderno: $\operatorname{Var}(b_1\mid x) = \dfrac{\sigma^2}{\sum(x_i-\bar x)^2}$.)

**Fundamentação.** Diz **quão preciso** é o estimador. Mostra que a precisão cresce com (a) menor variância do erro $\sigma^2$ e (b) maior dispersão de $x$. É a base do erro-padrão e de todo teste $t$.

**Passo a passo.**

Da identidade fundamental (D9, Etapa 2), condicionando em $X$:
$$\operatorname{Var}(\hat\beta_1 \mid X) = \operatorname{Var}\Big(\beta_1 + \sum_i k_i \varepsilon_i \;\Big|\; X\Big).$$

$\beta_1$ é constante (variância zero) e os $k_i$ são constantes dado $X$:
$$= \operatorname{Var}\Big(\sum_i k_i \varepsilon_i \;\Big|\; X\Big) = \sum_i k_i^2 \operatorname{Var}(\varepsilon_i\mid X) + \sum_{i\neq j} k_i k_j \operatorname{Cov}(\varepsilon_i,\varepsilon_j\mid X).$$

Sob **H5 (homocedasticidade)** $\operatorname{Var}(\varepsilon_i\mid X)=\sigma^2$ e sob **ausência de autocorrelação** $\operatorname{Cov}(\varepsilon_i,\varepsilon_j\mid X)=0$ para $i\neq j$:
$$= \sigma^2 \sum_i k_i^2.$$

Por (iii) de D9, $\sum_i k_i^2 = \dfrac{1}{\sum_i (x_i-\bar x)^2}$:
$$\boxed{\operatorname{Var}(\hat\beta_1 \mid X) = \frac{\sigma^2}{\sum_i (x_i - \bar x)^2}.} \qquad \blacksquare$$

> [!success] 🎯 Ponte com a tese
> "Variância cai quando a dispersão do regressor sobe" é por que **mais variação no tratamento** (mais unidades tratadas em momentos diferentes) dá estimativas de DiD mais precisas. E a hipótese de ausência de autocorrelação é justamente a que falha em painel — por isso você **clusteriza** o erro-padrão.

---

## D11 · Teorema de Gauss–Markov: MQO é BLUE

> [!note] O que se quer provar
> Que, dentro da classe de **todos os estimadores lineares e não-viesados**, o MQO tem a **menor variância**. BLUE = *Best Linear Unbiased Estimator*.

**Fundamentação.** É o teorema que **justifica** usar MQO. O caderno registra o alvo dos estimadores (o desenho do alvo: viés × eficiência) e a frase "*na classe de todos os estimadores lineares e não-viesados*". Também aparece a decomposição do **EQM**:
$$\mathrm{EQM}[\hat\theta] = \operatorname{Var}[\hat\theta] + \big(\text{viés}[\hat\theta]\big)^2.$$

**Passo a passo (esboço rigoroso).**

Tome qualquer outro estimador linear $\tilde\beta_1 = \sum_i w_i y_i$. Escreva os pesos como os de MQO mais um desvio:
$$w_i = k_i + d_i.$$

**Não-viés de $\tilde\beta_1$ força condições sobre $d_i$.** Substituindo o modelo,
$$\tilde\beta_1 = \sum_i w_i y_i = \beta_0\sum_i w_i + \beta_1\sum_i w_i x_i + \sum_i w_i\varepsilon_i.$$
Para $E[\tilde\beta_1\mid X]=\beta_1$ **qualquer que seja** $\beta_0,\beta_1$, precisamos de $\sum_i w_i = 0$ e $\sum_i w_i x_i = 1$. Como $\sum k_i =0$ e $\sum k_i x_i = 1$ (D9), isso obriga:
$$\sum_i d_i = 0 \qquad\text{e}\qquad \sum_i d_i x_i = 0.$$

**Variância de $\tilde\beta_1$.** Sob H5 + ausência de autocorrelação,
$$\operatorname{Var}(\tilde\beta_1\mid X) = \sigma^2\sum_i w_i^2 = \sigma^2\sum_i (k_i + d_i)^2 = \sigma^2\Big(\sum_i k_i^2 + 2\sum_i k_i d_i + \sum_i d_i^2\Big).$$

**O termo cruzado zera.** Usando $k_i = \frac{x_i-\bar x}{\sum(x_j-\bar x)^2}$ e as duas condições sobre $d_i$:
$$\sum_i k_i d_i = \frac{\sum_i (x_i-\bar x)d_i}{\sum_j(x_j-\bar x)^2} = \frac{\sum_i x_i d_i - \bar x\sum_i d_i}{\sum_j(x_j-\bar x)^2} = \frac{0 - 0}{\;\cdot\;} = 0.$$

**Conclusão.**
$$\operatorname{Var}(\tilde\beta_1\mid X) = \sigma^2\sum_i k_i^2 + \sigma^2\sum_i d_i^2 = \underbrace{\operatorname{Var}(\hat\beta_1\mid X)}_{\text{MQO}} + \underbrace{\sigma^2\sum_i d_i^2}_{\ge\,0}.$$

Como $\sigma^2\sum d_i^2 \ge 0$, com igualdade só se todo $d_i = 0$ (isto é, $\tilde\beta_1 = \hat\beta_1$):
$$\boxed{\operatorname{Var}(\tilde\beta_1\mid X) \ge \operatorname{Var}(\hat\beta_1\mid X).} \qquad \blacksquare$$

MQO é o de menor variância na classe. $\blacksquare$

> [!info] O papel do EQM no seu caderno
> A decomposição $\mathrm{EQM} = \operatorname{Var} + \text{viés}^2$ explica o **trade-off do alvo** que você desenhou: um estimador viesado (fora do centro) pode ter EQM menor que um não-viesado se sua variância for muito menor. Gauss-Markov fixa o viés em zero e minimiza a variância — mas em situações reais às vezes se aceita um pouco de viés por muito menos variância (é a lógica de estimadores encolhidos/ridge).

---
---

# PARTE III · Rota matricial (regressão múltipla) — 21/08

> [!abstract] A grande virada
> Tudo de I e II reaparece aqui **empacotado em vetores e matrizes**. A vantagem: uma única expressão $\hat\beta = (X'X)^{-1}X'y$ cobre $k$ regressores de uma vez. O caderno da 21/08 abre com o modelo múltiplo, monta a forma matricial e chega ao estimador por cálculo diferencial matricial.

## D12 · Forma matricial e as cinco hipóteses

> [!note] O que se quer provar/estabelecer
> Que o sistema de $n$ equações
> $$y_i = \beta_1 + \beta_2 x_{i2} + \beta_3 x_{i3} + \cdots + \beta_k x_{ik} + \varepsilon_i, \quad i = 1,\dots,n$$
> se escreve compactamente como
> $$\boxed{y = X\beta + \varepsilon,}$$
> e enunciar as hipóteses do modelo clássico em forma matricial.

**Fundamentação.** Empilhar as $n$ equações num objeto só é o que torna a álgebra tratável. Seu caderno monta exatamente estas matrizes (a página 21/08 com os vetores empilhados).

**As dimensões (guarde sempre):**
$$\underbrace{y}_{n\times 1} = \underbrace{X}_{n\times k}\underbrace{\beta}_{k\times 1} + \underbrace{\varepsilon}_{n\times 1},$$
$$y = \begin{bmatrix} y_1 \\ y_2 \\ \vdots \\ y_n \end{bmatrix},\quad X = \begin{bmatrix} 1 & x_{12} & \cdots & x_{1k} \\ 1 & x_{22} & \cdots & x_{2k} \\ \vdots & \vdots & & \vdots \\ 1 & x_{n2} & \cdots & x_{nk} \end{bmatrix},\quad \beta = \begin{bmatrix} \beta_1 \\ \beta_2 \\ \vdots \\ \beta_k \end{bmatrix},\quad \varepsilon = \begin{bmatrix} \varepsilon_1 \\ \varepsilon_2 \\ \vdots \\ \varepsilon_n \end{bmatrix}.$$

**As cinco hipóteses (forma matricial)** — do seu caderno (H1–H5):

| | Nome | Forma matricial | Escalar equivalente |
|--|------|-----------------|---------------------|
| **H1** | Linearidade | $y = X\beta + \varepsilon$ | D12 |
| **H2** | Posto completo / **ausência de multicolinearidade** | $\operatorname{posto}(X) = k$ | há variação em $x$ (H3 escalar) |
| **H3** | Exogeneidade estrita | $E[\varepsilon \mid X] = 0$ | H4 escalar |
| **H4** | Homocedasticidade + não-autocorrelação | $\operatorname{Var}(\varepsilon\mid X) = \sigma^2 I_n$ | H5 escalar |
| **H5** | (Opcional) Normalidade | $\varepsilon \mid X \sim \mathcal{N}(0,\sigma^2 I_n)$ | — (p/ inferência exata) |

> [!warning] A hipótese de posto e a multicolinearidade
> Seu caderno registra **H2 como "Ausência de multicolinearidade"** com o exemplo $\lambda_2 x_2 + \lambda_3 x_3 = 0 \Rightarrow x_2 - 2x_3 = 0$ (uma coluna é combinação linear de outra). Isso é **multicolinearidade perfeita** e faz $X'X$ ser **singular** (não-inversível) — o estimador D13 nem existe. Ver D15 para o caso *imperfeito* (alta, mas não perfeita).

> [!info] Por que $\operatorname{Var}(\varepsilon\mid X)=\sigma^2 I_n$ contém duas hipóteses
> A matriz de variância-covariância dos erros é
> $$\operatorname{Var}(\varepsilon\mid X) = \begin{bmatrix} \sigma_1^2 & \sigma_{12} & \cdots \\ \sigma_{21} & \sigma_2^2 & \cdots \\ \vdots & & \ddots \end{bmatrix}.$$
> **Homocedasticidade** = a diagonal é constante ($\sigma_i^2 = \sigma^2$ para todo $i$). **Ausência de autocorrelação** = os termos de fora da diagonal são zero ($\sigma_{ij}=0$). As duas juntas dão $\sigma^2 I_n$. Quando alguma falha, cai-se em MQG/heteroscedasticidade (2ª prova) — e o caderno já desenha a matriz cheia $\varepsilon\sim(0,\sigma^2\Sigma)$ para o caso heterocedástico.

---

## D13 · O estimador de MQO matricial: $\hat\beta = (X'X)^{-1}X'y$

> [!note] O que se quer provar
> Minimizar a soma dos quadrados dos resíduos em forma matricial
> $$S(b) = e'e = (y - Xb)'(y - Xb)$$
> entrega
> $$\boxed{\hat\beta = (X'X)^{-1}X'y.}$$

**Fundamentação.** É **a demonstração-rainha da prova**. Reproduz D3–D6 num golpe só, para $k$ regressores. Exige o kit de cálculo diferencial matricial que o caderno lista como "Observação".

> [!tip] Kit de derivadas matriciais (do caderno, "Observação")
> Para vetor $b$ e matriz simétrica $A$:
> $$\text{(a) } \frac{\partial (z'Az)}{\partial z} = 2Az; \qquad \frac{\partial (b'Ab)}{\partial b} = 2Ab.$$
> $$\text{(b) } \frac{\partial (Az)}{\partial z} = A'; \qquad \frac{\partial (A b)}{\partial b} = A'.$$
> $$\text{(c) } \frac{\partial (b'a)}{\partial b} = \frac{\partial (a'b)}{\partial b} = a.$$
> Também: $(AB)' = B'A'$.

**Passo a passo.**

**Etapa 1 — expandir a forma quadrática.** Com $e = y - Xb$:
$$S(b) = (y - Xb)'(y - Xb) = y'y - y'Xb - b'X'y + b'X'Xb.$$

**Etapa 2 — colapsar os dois termos do meio.** $y'Xb$ é um escalar ($1\times 1$); um escalar é igual à sua transposta, então $y'Xb = (y'Xb)' = b'X'y$. Logo os dois termos cruzados se somam:
$$S(b) = y'y - 2\,b'X'y + b'X'Xb.$$

> [!info] Este é o momento que o caderno chama de "forma quadrática"
> $b'X'Xb$ é uma **forma quadrática** com matriz $X'X$. E $X'X$ é sempre **positiva semidefinida** (pois $c'X'Xc = (Xc)'(Xc) = \|Xc\|^2 \ge 0$) — é o que garante, na Etapa 5, que o ponto crítico é mínimo. O caderno registra $c'X'Xc = v'v = \sum v_i^2 \ge 0$.

**Etapa 3 — condição de 1ª ordem.** Deriva $S(b)$ em relação a $b$ usando o kit:
- $\dfrac{\partial (y'y)}{\partial b} = 0$ (não depende de $b$);
- $\dfrac{\partial (-2 b'X'y)}{\partial b} = -2X'y$ (regra c, com $a = X'y$);
- $\dfrac{\partial (b'X'Xb)}{\partial b} = 2X'Xb$ (regra a, com $A = X'X$ simétrica).

Somando e igualando a zero no ótimo $\hat\beta$:
$$\frac{\partial S}{\partial b}\bigg|_{\hat\beta} = -2X'y + 2X'X\hat\beta = 0.$$

**Etapa 4 — as equações normais matriciais.** Divide por 2 e reorganiza:
$$\boxed{X'X\hat\beta = X'y.} \tag{Equações Normais}$$
São as $k$ equações normais empilhadas (o análogo de EN-1 + EN-2).

**Etapa 5 — resolver.** Sob **H2 (posto completo)**, $X'X$ é inversível. Multiplica à esquerda por $(X'X)^{-1}$:
$$\boxed{\hat\beta = (X'X)^{-1}X'y.} \qquad \blacksquare$$

**Etapa 6 — confirmar que é mínimo (2ª ordem).** A Hessiana é
$$\frac{\partial^2 S}{\partial b\,\partial b'} = 2X'X,$$
positiva definida sob posto completo (Etapa 2). Logo é mínimo. $\blacksquare$

> [!success] 🎯 Ponte com a tese
> $(X'X)^{-1}X'y$ é *o* objeto computacional de toda a sua econometria aplicada. Efeitos fixos, DiD, event study — tudo é este estimador com um $X$ específico (dummies de unidade e tempo). Quando você dominar o [[Frisch-Waugh-Lovell]] (28/08), vai ver que o coeficiente de tratamento é este mesmo cálculo nos resíduos.

---

## D14 · Variância do estimador matricial: $\operatorname{Var}(\hat\beta \mid X) = \sigma^2 (X'X)^{-1}$

> [!note] O que se quer provar
> $$\boxed{\operatorname{Var}(\hat\beta \mid X) = \sigma^2 (X'X)^{-1}.}$$
> (No caderno: $\operatorname{Var}(b\mid x) = \sigma^2 (X'X)^{-1}$.)

**Fundamentação.** É a generalização de D10 para $k$ regressores. A **diagonal** desta matriz $k\times k$ dá as variâncias de cada $\hat\beta_j$ (e as raízes, os erros-padrão); os termos de fora dão as covariâncias entre estimativas.

**Passo a passo.**

**Etapa 1 — identidade fundamental matricial.** Substitui $y = X\beta + \varepsilon$ no estimador:
$$\hat\beta = (X'X)^{-1}X'(X\beta + \varepsilon) = (X'X)^{-1}\underbrace{X'X}_{}\beta + (X'X)^{-1}X'\varepsilon.$$
Como $(X'X)^{-1}(X'X) = I$:
$$\hat\beta = \beta + (X'X)^{-1}X'\varepsilon.$$
(É o análogo exato de $\hat\beta_1 = \beta_1 + \sum k_i\varepsilon_i$ de D9.) Isto **reprova o não-viés** de imediato: $E[\hat\beta\mid X] = \beta + (X'X)^{-1}X'\underbrace{E[\varepsilon\mid X]}_{0} = \beta$.

**Etapa 2 — aplica o operador variância.** Seja $A = (X'X)^{-1}X'$ (constante dado $X$). Então $\hat\beta - \beta = A\varepsilon$, e para vetor aleatório vale $\operatorname{Var}(A\varepsilon\mid X) = A\operatorname{Var}(\varepsilon\mid X)A'$:
$$\operatorname{Var}(\hat\beta\mid X) = A\,\operatorname{Var}(\varepsilon\mid X)\,A'.$$

**Etapa 3 — usa H4.** Sob $\operatorname{Var}(\varepsilon\mid X) = \sigma^2 I_n$:
$$\operatorname{Var}(\hat\beta\mid X) = A(\sigma^2 I_n)A' = \sigma^2 A A'.$$

**Etapa 4 — simplifica $AA'$.**
$$AA' = (X'X)^{-1}X'\,\big[(X'X)^{-1}X'\big]' = (X'X)^{-1}X'\,X(X'X)^{-1},$$
usando $\big[(X'X)^{-1}X'\big]' = X(X'X)^{-1}$ (pois $X'X$ é simétrica, sua inversa também). Como $X'X(X'X)^{-1} = I$:
$$AA' = (X'X)^{-1}\underbrace{X'X}_{}(X'X)^{-1} = (X'X)^{-1}.$$

**Etapa 5 — conclui.**
$$\boxed{\operatorname{Var}(\hat\beta\mid X) = \sigma^2 (X'X)^{-1}.} \qquad \blacksquare$$

> [!info] Gauss-Markov matricial → ver D16
> Com D13 + D14 em mãos, a 28/08 fecha a versão matricial de Gauss-Markov: para qualquer outro linear não-viesado, a diferença das variâncias é **positiva semidefinida**. Está demonstrada por completo em **D16**, abaixo.

---

## D15 · Multicolinearidade: efeito na variância e o FIV

> [!note] O que se quer provar/entender
> Que a multicolinearidade **imperfeita** (regressores muito, mas não perfeitamente, correlacionados) **infla a variância** dos estimadores sem enviesá-los, e que o **Fator de Inflação da Variância** quantifica isso:
> $$\operatorname{Var}(\hat\beta_j\mid X) = \frac{\sigma^2}{\sum_i (x_{ij} - \bar x_j)^2}\cdot\frac{1}{1 - R_j^2}, \qquad \mathrm{FIV}_j = \frac{1}{1 - R_j^2}.$$

**Fundamentação.** É o tema central da aula 04/09, mas já aparece na 21/08. Seu caderno traz os **diagramas de Venn** (círculos sobrepostos = variância compartilhada entre regressores) e a fórmula da variância com o fator $\frac{1}{1-R_j^2}$. A intuição: se $x_j$ é quase explicado pelos outros regressores, sobra pouca variação "própria" dele para identificar seu efeito.

**Passo a passo (a decomposição da variância).**

Para o regressor $x_j$, rode a **regressão auxiliar** de $x_j$ contra todos os outros regressores e colha o $R_j^2$ dessa regressão. Pode-se mostrar (via FWL, 28/08) que a variância do $j$-ésimo coeficiente é:
$$\operatorname{Var}(\hat\beta_j\mid X) = \frac{\sigma^2}{\underbrace{\sum_i (x_{ij}-\bar x_j)^2}_{\text{variação total de }x_j}\cdot\underbrace{(1 - R_j^2)}_{\text{fração "própria"}}}.$$

Interpretação dos casos:
- $R_j^2 = 0$ (regressor ortogonal aos demais): $\mathrm{FIV}_j = 1$, variância mínima.
- $R_j^2 \to 1$ (quase colinear): $\mathrm{FIV}_j \to \infty$, variância explode.
- $R_j^2 = 1$ (colinearidade perfeita): $X'X$ singular, estimador **não existe** (volta a H2 / D12).

**O FIV como diagnóstico.** Define-se
$$\boxed{\mathrm{FIV}_j = \frac{1}{1 - R_j^2}.}$$
Regra de bolso: $\mathrm{FIV}_j > 10$ (equivale a $R_j^2 > 0{,}9$) sinaliza multicolinearidade preocupante.

> [!warning] O que multicolinearidade NÃO faz
> Ela **não** viesa o MQO nem viola Gauss-Markov — os estimadores continuam BLUE. Ela só os torna **imprecisos** (variância alta, erros-padrão grandes, $t$ baixos, intervalos largos). Sintoma clássico: $R^2$ alto no conjunto, mas nenhum coeficiente individualmente significativo. O caderno resume: "correlação entre variáveis pode causar problemas" — o problema é *precisão*, não *acurácia*.

> [!success] 🎯 Ponte com a tese
> Em event study com muitos *leads/lags*, dummies vizinhas são altamente correlacionadas → FIV alto → coeficientes de período imprecisos. Saber que isso é *variância* (não viés) é o que te deixa interpretar corretamente um gráfico de event study "ruidoso".

---

## D16 · Gauss–Markov matricial: MQO é BLUE

> [!note] O que se quer provar
> Que, na classe de **todos os estimadores lineares e não-viesados** de $\beta$, o MQO $\hat\beta = (X'X)^{-1}X'y$ tem a **menor variância** (matriz de covariância mínima no sentido PSD). É a generalização vetorial de D11 e o clímax da 28/08.

**Fundamentação.** É a demonstração que *justifica* usar MQO no caso múltiplo — a versão matricial e completa do que D11 fez no escalar e que D14 só mencionou. A estratégia do caderno (28/08): escrever um estimador linear qualquer como "MQO + desvio", mostrar que o não-viés força uma condição sobre o desvio, e ver a variância se decompor em "variância do MQO + um termo PSD".

**Passo a passo.**

**Etapa 1 — um estimador linear alternativo.** Todo estimador linear é $b_0 = Ay$ para alguma matriz $A$ ($k\times n$). Escreva $A$ como o operador de MQO mais um desvio $C$:
$$b_0 = \big[(X'X)^{-1}X' + C\big]\,y,$$
onde $C$ é uma matriz $k\times n$ qualquer. Se $C = 0$, recai-se no MQO.

**Etapa 2 — substitui o modelo $y = X\beta + \varepsilon$.**
$$b_0 = \big[(X'X)^{-1}X' + C\big](X\beta + \varepsilon).$$
Distribuindo:
$$b_0 = \underbrace{(X'X)^{-1}X'X}_{I}\beta + (X'X)^{-1}X'\varepsilon + CX\beta + C\varepsilon.$$
$$b_0 = \beta + (X'X)^{-1}X'\varepsilon + CX\beta + C\varepsilon.$$

**Etapa 3 — o não-viés força $CX = 0$.** Tira a esperança condicional (sob H3, $E[\varepsilon\mid X]=0$):
$$E[b_0\mid X] = \beta + (X'X)^{-1}X'\underbrace{E[\varepsilon\mid X]}_{0} + CX\beta + C\underbrace{E[\varepsilon\mid X]}_{0} = \beta + CX\beta.$$
Para $b_0$ ser **não-viesado qualquer que seja** $\beta$, é preciso:
$$\boxed{CX = 0.}$$
Esta é a condição-chave (o análogo matricial de "$\sum d_i = 0$ e $\sum d_i x_i = 0$" de D11). Com ela, $E[b_0\mid X] = \beta$, e a Etapa 2 simplifica para:
$$b_0 - \beta = (X'X)^{-1}X'\varepsilon + C\varepsilon = \big[(X'X)^{-1}X' + C\big]\varepsilon.$$

> [!warning] Ajuste de notação do caderno
> Na 28/08 o desvio na conta de variância aparece com um termo $CX\beta$ escrito como se sobrevivesse dentro dos colchetes de $\operatorname{Var}[b_0\mid X]$ — mas ele está marcado com "$0$" embaixo, justamente porque **$CX = 0$ o anula** (e $\beta$ é constante, não entra na variância). O caderno chega no resultado certo; só fica claro *por que* aquele termo some quando se destaca a condição $CX=0$ acima.

**Etapa 4 — calcula a variância.** Por definição, com $b_0$ não-viesado:
$$\operatorname{Var}[b_0\mid X] = E\big[(b_0 - \beta)(b_0 - \beta)'\mid X\big] = E\Big[\big[(X'X)^{-1}X' + C\big]\varepsilon\varepsilon'\big[(X'X)^{-1}X' + C\big]'\;\Big|\;X\Big].$$
Como $E[\varepsilon\varepsilon'\mid X] = \sigma^2 I$ (H4):
$$\operatorname{Var}[b_0\mid X] = \sigma^2\big[(X'X)^{-1}X' + C\big]\big[(X'X)^{-1}X' + C\big]'.$$

**Etapa 5 — expande o produto.** Chamando $P = (X'X)^{-1}X'$, temos $(P+C)(P+C)' = PP' + PC' + CP' + CC'$. Calcule cada bloco usando $CX = 0$ (e sua transposta $X'C' = 0$):
- $PP' = (X'X)^{-1}X'\,X(X'X)^{-1} = (X'X)^{-1}$ (como em D14).
- $PC' = (X'X)^{-1}\underbrace{X'C'}_{(CX)' = 0} = 0$.
- $CP' = \underbrace{CX}_{0}(X'X)^{-1} = 0$.
- $CC'$ sobra.

Logo:
$$\boxed{\operatorname{Var}[b_0\mid X] = \underbrace{\sigma^2 (X'X)^{-1}}_{\operatorname{Var}[\hat\beta\mid X]\text{ (MQO)}} + \underbrace{\sigma^2 CC'}_{\ge\,0}.}$$

**Etapa 6 — o termo extra é PSD.** $\sigma^2 CC'$ é positiva semidefinida: para qualquer vetor $a$,
$$a'(\sigma^2 CC')a = \sigma^2 (C'a)'(C'a) = \sigma^2\,v'v = \sigma^2\sum_{i=1}^{k} v_i^2 \ge 0, \qquad v = C'a.$$
(É exatamente a linha $a'CC'a = v'v = \sum v_i^2 \ge 0$ do seu caderno.)

**Conclusão.** A variância de qualquer linear não-viesado é a do MQO **mais** uma matriz PSD:
$$\operatorname{Var}[b_0\mid X] - \operatorname{Var}[\hat\beta\mid X] = \sigma^2 CC' \succeq 0.$$
Portanto o MQO tem a menor variância na classe — é **eficiente**. Igualdade só quando $C = 0$, isto é, $b_0 = \hat\beta$. $\blacksquare$

> [!success] O que o caderno conclui
> *"Dos estimadores não-viesado, linear, o MQO é eficiente, pois tem a menor variância na classe dos lineares não-tendenciosos."* É o **BLUE** completo — agora em forma matricial, valendo para $k$ regressores de uma vez. Junto com D9/D11 (escalar), você tem as duas versões que o Zambon pode cobrar.

> [!info] Por que "$\succeq 0$" (PSD) e não "$\ge 0$"
> No escalar (D11) a diferença de variâncias era um número $\ge 0$. No matricial, a "variância" é uma matriz $k\times k$, e a comparação certa é: a diferença é **positiva semidefinida**. Na prática isso implica, em particular, que **cada** variância individual na diagonal do MQO é menor — ou seja, $\operatorname{Var}(\hat\beta_j) \le \operatorname{Var}(b_{0,j})$ para todo $j$.

---
---

# ✅ Checklist de véspera de prova

> [!todo] Sei demonstrar do zero, sem consultar?
> **Rota escalar (14/08)**
> - [ ] **D3** — derivar as duas equações normais a partir da SQR
> - [ ] **D4** — $\hat\beta_0 = \bar y - \hat\beta_1\bar x$
> - [ ] **D5** — as identidades de somatório (e o truque $\sum(x_i-\bar x)=0$)
> - [ ] **D6** — $\hat\beta_1 = \widehat{\operatorname{Cov}}/\widehat{\operatorname{Var}}$ (sem raiz no denominador!)
> - [ ] **D7** — Hessiana positiva definida ⟹ mínimo
> - [ ] **D8** — as 4 propriedades algébricas dos resíduos
>
> **Propriedades (14/08)**
> - [ ] **D9** — não-viés (com os pesos $k_i$ e suas 3 propriedades)
> - [ ] **D10** — variância $\sigma^2/\sum(x_i-\bar x)^2$
> - [ ] **D11** — Gauss-Markov (o termo cruzado $\sum k_i d_i = 0$)
>
> **Rota matricial (21/08–28/08)**
> - [ ] **D12** — montar $y=X\beta+\varepsilon$ e enunciar as 5 hipóteses com dimensões
> - [ ] **D13** — $\hat\beta = (X'X)^{-1}X'y$ (kit de derivadas matriciais)
> - [ ] **D14** — $\operatorname{Var}(\hat\beta) = \sigma^2(X'X)^{-1}$
> - [ ] **D15** — FIV e efeito da multicolinearidade na variância
> - [ ] **D16** — Gauss-Markov matricial ($b_0 = Cy$; condição $CX=0$; termo $\sigma^2 CC'$ PSD)

> [!tip] Os que caem quase certo
> Se o tempo for curto, priorize **D6** (escalar), **D13** (estimador matricial) e o par **D11/D16** (Gauss-Markov, escalar + matricial). São o núcleo do que o Zambon cobra em derivação — e D16 é literalmente a última coisa que vocês fecharam em aula (28/08), forte candidata à prova. Refaça-os **à mão**, contra o relógio.

---

## 📚 Referências

- **Greene**, *Econometric Analysis*, 7ª ed. — cap. 2–3 (modelo e MQO), cap. 4 (propriedades finitas, Gauss-Markov), Ap. A (álgebra matricial), Ap. B (probabilidade).
- **Wooldridge**, *Introductory Econometrics* — cap. 2–3 (derivações escalares mais palatáveis).
- **Hansen**, *Econometrics* (PDF gratuito) — cap. 2–4 (tratamento matricial moderno e limpo).
- **Hayashi**, *Econometrics* — cap. 1 (rigor, para conferir hipóteses).

> [!note] Documentos relacionados no vault
> - [[MQO — regressão simples]] — detalhamento da 14/08
> - [[Derivação completa do MQO]] — a versão **narrada** desta rota escalar (D0–D11), com o *porquê* de cada passo, do conceito de erro até Gauss-Markov e as três lentes
> - [[Prova Zambon 2025/2]] — a 1ª prova real resolvida; mapeia cada questão a estas demonstrações e traz **3 tópicos que caíram e não estão aqui** (viés por erro de medição, consistência assintótica, estimador IV)
> - [[Plano Econometria I]] — cronograma até a 1ª prova (02/10)
> - [[Lista 1]] — guia de revisão dos 74 exercícios
> - [[Frisch-Waugh-Lovell]] — regressão parcial; entra em D15 (a decomposição da variância com $R_j^2$ sai por FWL) e provavelmente será aprofundado adiante
