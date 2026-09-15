---
title: "Econometria I — Revisão das Aulas 1 e 2 (Hayashi caps. 1–2)"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
tags:
  - econometria
  - mestrado/ppgeco
  - demonstracoes
aliases:
  - Revisão Aulas 1 e 2
---

# Econometria I — Revisão das Aulas 1 e 2
## Modelo Linear Clássico e Teoria Assintótica — equações resolvidas com demonstrações

*Prof. Edson Zambon Monte · PPGEco/UFES · 2026/2*
*Referência principal: Hayashi, **Econometrics**, Caps. 1–2. Ponte com Hastie–Tibshirani–Friedman (**ESL**) §3.2.2 e §7.3 na decomposição do EQM.*

---

> **Como ler.** A **Parte I** (Aula 1) é o seu caderno tornado rigoroso: toda equação que você anotou aparece aqui resolvida, com a demonstração completa. A **Parte II** (Aula 2) é o passo seguinte — a mesma máquina, mas quando você troca *exatidão em amostra finita* por *garantias assintóticas*. As referências às "imagens" apontam para as páginas do seu caderno.
>
> O fio condutor é sempre o mesmo: **hipótese violada → propriedade que se perde → ferramenta que a restaura.**

---

# Parte I — Aula 1: Propriedades em Amostra Finita do MQO
### (Hayashi, Cap. 1)

## 1. O modelo e as hipóteses clássicas

Regressão simples (seu caderno):
$$y_i = \beta_0 + \beta_1 x_i + \varepsilon_i, \qquad i = 1, \dots, n.$$

Forma matricial (o "aplicação de álgebra linear" da imagem 1), com $\mathbf{y}$ e $\boldsymbol{\varepsilon}$ de ordem $n\times 1$, $\mathbf{X}$ de ordem $n\times K$ e $\boldsymbol{\beta}$ de ordem $K\times 1$:
$$\mathbf{y} = \mathbf{X}\boldsymbol{\beta} + \boldsymbol{\varepsilon}.$$

As **hipóteses clássicas** do Hayashi (as suas três regras, arrumadas):

| | Hipótese | Enunciado | Compra |
|---|---|---|---|
| **1.1** | Linearidade | $y_i = \mathbf{x}_i'\boldsymbol{\beta} + \varepsilon_i$ | o próprio modelo |
| **1.2** | Exogeneidade estrita | $\mathbb{E}[\varepsilon_i \mid \mathbf{X}] = 0$ | **não-viés** |
| **1.3** | Posto pleno | $\operatorname{rank}(\mathbf{X}) = K$ | existência/unicidade de $\mathbf{b}$ |
| **1.4** | Erro esférico | $\mathbb{E}[\boldsymbol{\varepsilon}\boldsymbol{\varepsilon}' \mid \mathbf{X}] = \sigma^2 \mathbf{I}_n$ | **eficiência** |
| **1.5** | Normalidade *(opcional)* | $\boldsymbol{\varepsilon}\mid\mathbf{X} \sim N(\mathbf{0}, \sigma^2\mathbf{I}_n)$ | inferência **exata** |

A hipótese 1.4 embute duas coisas: **homocedasticidade** ($\mathbb{E}[\varepsilon_i^2\mid\mathbf{X}]=\sigma^2$) e **ausência de autocorrelação** ($\mathbb{E}[\varepsilon_i\varepsilon_j\mid\mathbf{X}]=0$ para $i\neq j$) — exatamente os dois itens da imagem 7. A sua nota $\varepsilon_i \sim iid(0,\sigma^2)$ é o caso particular iid de 1.2 + 1.4.

> **Nota de rigor.** A exogeneidade *estrita* condiciona na matriz $\mathbf{X}$ **inteira**, não só no próprio $x_i$. É mais forte do que o $\mathbb{E}[\varepsilon_i\mid x_i]=0$ do caderno, e é o que garante o não-viés em amostra finita. Na Parte II ela é enfraquecida.

---

## 2. A álgebra dos mínimos quadrados (leitura matemática, sem probabilidade)

Minimizamos a soma dos quadrados dos resíduos:
$$S(\mathbf{b}) = \sum_{i=1}^n (y_i - \mathbf{x}_i'\mathbf{b})^2 = (\mathbf{y}-\mathbf{X}\mathbf{b})'(\mathbf{y}-\mathbf{X}\mathbf{b}).$$

**Condição de 1ª ordem:**
$$\frac{\partial S}{\partial \mathbf{b}} = -2\mathbf{X}'(\mathbf{y}-\mathbf{X}\mathbf{b}) = \mathbf{0} \;\Longrightarrow\; \underbrace{\mathbf{X}'\mathbf{X}\,\mathbf{b} = \mathbf{X}'\mathbf{y}}_{\text{equações normais}}.$$

Sob 1.3, $\mathbf{X}'\mathbf{X}$ é invertível, então
$$\boxed{\;\mathbf{b} = (\mathbf{X}'\mathbf{X})^{-1}\mathbf{X}'\mathbf{y}\;}$$

**Condição de 2ª ordem:** a Hessiana $2\mathbf{X}'\mathbf{X}$ é definida positiva, logo é mínimo. $\blacksquare$

**Geometria (projeção ortogonal).** Os valores ajustados são $\hat{\mathbf{y}} = \mathbf{X}\mathbf{b} = \mathbf{P}\mathbf{y}$, com
$$\mathbf{P} = \mathbf{X}(\mathbf{X}'\mathbf{X})^{-1}\mathbf{X}', \qquad \mathbf{M} = \mathbf{I}_n - \mathbf{P},\qquad \mathbf{e} = \mathbf{M}\mathbf{y}.$$
$\mathbf{P}$ e $\mathbf{M}$ são **simétricas e idempotentes**, com $\mathbf{P}\mathbf{X}=\mathbf{X}$ e $\mathbf{M}\mathbf{X}=\mathbf{0}$. A condição normal $\mathbf{X}'\mathbf{e}=\mathbf{0}$ diz que **o resíduo é ortogonal aos regressores** — que é o significado geométrico de "MQO projeta $\mathbf{y}$ no espaço-coluna de $\mathbf{X}$".

Na regressão simples, $\mathbf{X}'\mathbf{e}=\mathbf{0}$ se abre exatamente nas suas duas equações da imagem 4:
$$\sum_i e_i = 0 \quad (1), \qquad\qquad \sum_i e_i x_i = 0 \quad (2).$$

---

## 3. Regressão simples: resolvendo $b_0$ e $b_1$ (imagens 4–5)

Partindo de (1) e (2):

**De (1):** $\sum y_i = n\,b_0 + b_1 \sum x_i \;\Longrightarrow\; b_0 = \bar{y} - b_1\bar{x}.$

**Substituindo em (2):** $\sum y_i x_i = b_0\sum x_i + b_1\sum x_i^2$. Trocando $b_0$:
$$\sum y_i x_i = (\bar y - b_1\bar x)\sum x_i + b_1\sum x_i^2 = \bar y\sum x_i - b_1\bar x\sum x_i + b_1\sum x_i^2.$$
Isolando $b_1$ e usando $\bar y\sum x_i = \tfrac{\sum y_i\sum x_i}{n}$ e $\bar x\sum x_i = \tfrac{(\sum x_i)^2}{n}$:
$$\boxed{\;b_1 = \frac{\displaystyle\sum x_i y_i - \frac{\sum x_i \sum y_i}{n}}{\displaystyle\sum x_i^2 - \frac{(\sum x_i)^2}{n}} = \frac{\sum(x_i-\bar x)(y_i-\bar y)}{\sum(x_i-\bar x)^2}\;}$$

que é a linha final da sua imagem 5. $\blacksquare$

---

## 4. A rota populacional: $\beta_1$ via covariância (imagem 3)

A leitura **estatística** do mesmo parâmetro. Como $y = \beta_0 + \beta_1 x + \varepsilon$:
$$\operatorname{Cov}[x,y] = \operatorname{Cov}[x,\beta_0] + \operatorname{Cov}[x,\beta_1 x] + \operatorname{Cov}[x,\varepsilon] = \underbrace{0}_{\beta_0 \text{ const.}} + \beta_1\operatorname{Var}[x] + \underbrace{0}_{\text{exogen.}}$$
Logo
$$\boxed{\;\beta_1 = \frac{\operatorname{Cov}[x,y]}{\operatorname{Var}[x]}\;}, \qquad \beta_0 = \mathbb{E}[y] - \beta_1\mathbb{E}[x].$$

**A ponte que importa.** Compare com a §3: o estimador de MQO é o **análogo amostral** deste momento populacional — troque $\operatorname{Cov}$ e $\operatorname{Var}$ por suas versões na amostra e cai em $b_1$. Essa ideia — *"substituir momento populacional por média amostral"* — é o **Método dos Momentos**, que no Hayashi (Cap. 3) generaliza para **GMM** e passa a englobar MQO, VI e quase tudo que vem depois como casos particulares.

---

## 5. Não-viesado / não-tendencioso / sem viés (imagem 6)

### 5a. Versão matricial (limpa)
$$\mathbf{b} = (\mathbf{X}'\mathbf{X})^{-1}\mathbf{X}'(\mathbf{X}\boldsymbol\beta + \boldsymbol\varepsilon) = \boldsymbol\beta + (\mathbf{X}'\mathbf{X})^{-1}\mathbf{X}'\boldsymbol\varepsilon.$$
Condicionando em $\mathbf{X}$ e usando **1.2** ($\mathbb{E}[\boldsymbol\varepsilon\mid\mathbf{X}]=\mathbf{0}$):
$$\mathbb{E}[\mathbf{b}\mid\mathbf{X}] = \boldsymbol\beta + (\mathbf{X}'\mathbf{X})^{-1}\mathbf{X}'\,\mathbb{E}[\boldsymbol\varepsilon\mid\mathbf{X}] = \boldsymbol\beta.$$
Pela Lei das Expectativas Iteradas, $\mathbb{E}[\mathbf{b}]=\boldsymbol\beta$. $\blacksquare$

### 5b. Versão escalar — o truque do $k_i$ (a sua imagem 6)
Defina os **pesos**
$$k_i = \frac{x_i - \bar x}{\sum_j (x_j - \bar x)^2}, \qquad\text{de modo que}\qquad b_1 = \sum_i k_i\, y_i \;\;(\text{linear em } y).$$

Duas propriedades dos pesos (as suas notas laterais **i** e **ii**):

$$\textbf{(i)}\quad \sum_i k_i = \frac{\sum(x_i-\bar x)}{\sum(x_i-\bar x)^2} = 0 \quad (\text{numerador} = 0).$$

$$\textbf{(ii)}\quad \sum_i k_i x_i = \frac{\sum(x_i-\bar x)x_i}{\sum(x_i-\bar x)^2} = 1,$$
pois
$$\sum(x_i-\bar x)x_i = \sum(x_i-\bar x)x_i - \bar x\underbrace{\sum(x_i-\bar x)}_{0} = \sum(x_i-\bar x)^2.$$

Agora substitua $y_i = \beta_0 + \beta_1 x_i + \varepsilon_i$:
$$b_1 = \sum k_i(\beta_0 + \beta_1 x_i + \varepsilon_i) = \beta_0\underbrace{\sum k_i}_{0} + \beta_1\underbrace{\sum k_i x_i}_{1} + \sum k_i\varepsilon_i = \beta_1 + \sum k_i\varepsilon_i.$$
Condicionando em $\mathbf{x}$ (onde os $k_i$ são constantes) e usando exogeneidade:
$$\mathbb{E}[b_1\mid\mathbf{x}] = \beta_1 + \sum k_i\underbrace{\mathbb{E}[\varepsilon_i\mid\mathbf{x}]}_{0} = \boxed{\beta_1} \;\Longrightarrow\; \textbf{não-viesado.}\quad\blacksquare$$

> **Onde tudo se apoia.** A demonstração inteira desaba num único ponto: $\mathbb{E}[\varepsilon_i\mid x_i]=0$. Quebre a exogeneidade e o não-viés vai junto. Segure essa dependência — ela é o eixo da Parte II e da sua pesquisa em diff-in-diff.

---

## 6. Variância do estimador (imagem 7)

### 6a. Versão matricial
Com $\mathbf{A} = (\mathbf{X}'\mathbf{X})^{-1}\mathbf{X}'$ (constante dado $\mathbf{X}$) e usando **1.4** ($\operatorname{Var}[\boldsymbol\varepsilon\mid\mathbf{X}]=\sigma^2\mathbf{I}$):
$$\operatorname{Var}[\mathbf{b}\mid\mathbf{X}] = \mathbf{A}\,(\sigma^2\mathbf{I})\,\mathbf{A}' = \sigma^2\mathbf{A}\mathbf{A}' = \sigma^2(\mathbf{X}'\mathbf{X})^{-1}\mathbf{X}'\mathbf{X}(\mathbf{X}'\mathbf{X})^{-1}.$$
$$\boxed{\;\operatorname{Var}[\mathbf{b}\mid\mathbf{X}] = \sigma^2(\mathbf{X}'\mathbf{X})^{-1}\;}$$

### 6b. Versão escalar (a sua imagem 7)
$$\operatorname{Var}[b_1\mid\mathbf{x}] = \operatorname{Var}\!\Big[\beta_1 + \sum k_i\varepsilon_i \,\Big|\, \mathbf{x}\Big] = \sum k_i^2\,\operatorname{Var}[\varepsilon_i\mid\mathbf{x}] = \sigma^2\sum k_i^2,$$
onde os produtos cruzados somem pela **ausência de autocorrelação**. E
$$\sum k_i^2 = \frac{\sum(x_i-\bar x)^2}{\big[\sum(x_i-\bar x)^2\big]^2} = \frac{1}{\sum(x_i-\bar x)^2}.$$
$$\boxed{\;\operatorname{Var}[b_1\mid\mathbf{x}] = \frac{\sigma^2}{\sum(x_i-\bar x)^2}\;}\qquad\blacksquare$$

> **Leitura.** A variância cai quando (a) $\sigma^2$ é menor — menos ruído; (b) $n$ cresce — mais dados; (c) $\sum(x_i-\bar x)^2$ é maior — **mais variação em $x$**. É por isso que regressor "parado" estima mal a inclinação.

---

## 7. Teorema de Gauss-Markov — MQO é BLUE

> **Enunciado.** Sob **1.1–1.4**, o estimador de MQO $\mathbf{b}$ é o **Melhor Estimador Linear Não-Viesado** (*Best Linear Unbiased Estimator*): para qualquer outro estimador linear e não-viesado $\tilde{\boldsymbol\beta}$, a matriz $\operatorname{Var}[\tilde{\boldsymbol\beta}\mid\mathbf{X}] - \operatorname{Var}[\mathbf{b}\mid\mathbf{X}]$ é positiva semidefinida.

**Demonstração (matricial).** Todo estimador linear é $\tilde{\boldsymbol\beta} = \mathbf{C}\mathbf{y}$ para algum $\mathbf{C}$ ($K\times n$, função de $\mathbf{X}$). Escreva
$$\mathbf{C} = (\mathbf{X}'\mathbf{X})^{-1}\mathbf{X}' + \mathbf{D},\qquad \mathbf{D} := \mathbf{C} - (\mathbf{X}'\mathbf{X})^{-1}\mathbf{X}'.$$

*Não-viés impõe uma restrição.* $\mathbb{E}[\tilde{\boldsymbol\beta}\mid\mathbf{X}] = \mathbf{C}\mathbf{X}\boldsymbol\beta = \boldsymbol\beta$ para **todo** $\boldsymbol\beta$ exige $\mathbf{C}\mathbf{X}=\mathbf{I}_K$. Como $(\mathbf{X}'\mathbf{X})^{-1}\mathbf{X}'\mathbf{X}=\mathbf{I}_K$, isso força
$$\mathbf{D}\mathbf{X} = \mathbf{0}.$$

*Variância.* Com $\mathbf{C}\mathbf{X}=\mathbf{I}$, tem-se $\tilde{\boldsymbol\beta} = \mathbf{C}(\mathbf{X}\boldsymbol\beta+\boldsymbol\varepsilon) = \boldsymbol\beta + \mathbf{C}\boldsymbol\varepsilon$, logo $\operatorname{Var}[\tilde{\boldsymbol\beta}\mid\mathbf{X}] = \sigma^2\mathbf{C}\mathbf{C}'$. Expandindo:
$$\mathbf{C}\mathbf{C}' = (\mathbf{X}'\mathbf{X})^{-1} + \underbrace{(\mathbf{X}'\mathbf{X})^{-1}\mathbf{X}'\mathbf{D}'}_{=\,0} + \underbrace{\mathbf{D}\mathbf{X}(\mathbf{X}'\mathbf{X})^{-1}}_{=\,0} + \mathbf{D}\mathbf{D}',$$
onde os termos cruzados são nulos porque $\mathbf{D}\mathbf{X}=\mathbf{0}$ (e sua transposta $\mathbf{X}'\mathbf{D}'=\mathbf{0}$). Portanto
$$\operatorname{Var}[\tilde{\boldsymbol\beta}\mid\mathbf{X}] = \underbrace{\sigma^2(\mathbf{X}'\mathbf{X})^{-1}}_{\operatorname{Var}[\mathbf{b}\mid\mathbf{X}]} + \sigma^2\mathbf{D}\mathbf{D}'.$$
Como $\mathbf{D}\mathbf{D}'$ é positiva semidefinida, a diferença é PSD, com igualdade **se e só se** $\mathbf{D}=\mathbf{0}$, i.e. $\tilde{\boldsymbol\beta}=\mathbf{b}$. $\blacksquare$

**Companheira escalar (regressão simples).** Entre os lineares não-viesados $\tilde b_1 = \sum w_i y_i$ com $\sum w_i = 0$ e $\sum w_i x_i = 1$, escreva $w_i = k_i + d_i$. As restrições forçam $\sum d_i = 0$ e $\sum d_i x_i = 0$, donde
$$\sum k_i d_i = \frac{\sum(x_i-\bar x)d_i}{\sum(x_i-\bar x)^2} = \frac{\sum d_i x_i - \bar x\sum d_i}{\sum(x_i-\bar x)^2} = 0.$$
Logo $\sum w_i^2 = \sum k_i^2 + 2\sum k_i d_i + \sum d_i^2 = \sum k_i^2 + \sum d_i^2 \ge \sum k_i^2$, com igualdade só quando $d_i \equiv 0$. **O $k_i$ do MQO tem a menor variância.** $\blacksquare$

Esse é o "$MQO\,(!)$" no centro do seu alvo (imagem 7): o tiro que acerta o centro **e** está no grupo mais fechado dentre os lineares não-viesados.

---

## 8. Decomposição do EQM — a sua fórmula do viés

Para qualquer estimador $\hat\theta$ de $\theta$, some e subtraia $\mathbb{E}[\hat\theta]$:
$$
\begin{aligned}
\operatorname{EQM}[\hat\theta] &= \mathbb{E}\big[(\hat\theta-\theta)^2\big] = \mathbb{E}\big[(\hat\theta - \mathbb{E}[\hat\theta] + \mathbb{E}[\hat\theta] - \theta)^2\big]\\[2pt]
&= \underbrace{\mathbb{E}\big[(\hat\theta-\mathbb{E}[\hat\theta])^2\big]}_{\operatorname{Var}[\hat\theta]} + 2\underbrace{\mathbb{E}[\hat\theta-\mathbb{E}[\hat\theta]]}_{=\,0}\,(\mathbb{E}[\hat\theta]-\theta) + \underbrace{(\mathbb{E}[\hat\theta]-\theta)^2}_{(\operatorname{viés}[\hat\theta])^2}
\end{aligned}
$$
$$\boxed{\;\operatorname{EQM}[\hat\theta] = \operatorname{Var}[\hat\theta] + \big(\operatorname{viés}[\hat\theta]\big)^2\;}\qquad\blacksquare$$

Formaliza a metáfora do alvo: **erro total = espalhamento + descentralização²** = precisão vs. exatidão.

> **Ponte com ESL (§3.2.2 e §7.3) — por que você tem os dois livros.** Gauss-Markov garante o mínimo *dentro da classe não-viesada*. Mas o EQM acima abre uma porta que o Hayashi não usa e o ESL explora: **aceitar um pouco de viés para derrubar muito a variância** pode reduzir o EQM total. É a lógica de *ridge*, *lasso* e encolhimento — estimadores viesados que batem o MQO em erro de predição. Onde o Hayashi mira **inferência sobre $\beta$** (parâmetro sem viés), o ESL mira **predição de $y$** (EQM mínimo). A mesma decomposição, dois objetivos.

---

## 9. Estimando $\sigma^2$ (fecho da amostra finita)

O estimador não-viesado da variância do erro é
$$s^2 = \frac{\mathbf{e}'\mathbf{e}}{n-K}.$$

**Demonstração.** Como $\mathbf{e} = \mathbf{M}\boldsymbol\varepsilon$ e $\mathbf{M}$ é simétrica idempotente, $\mathbf{e}'\mathbf{e} = \boldsymbol\varepsilon'\mathbf{M}\boldsymbol\varepsilon$. Usando o truque do traço ($\boldsymbol\varepsilon'\mathbf{M}\boldsymbol\varepsilon$ é escalar = seu próprio traço):
$$\mathbb{E}[\mathbf{e}'\mathbf{e}\mid\mathbf{X}] = \mathbb{E}[\operatorname{tr}(\mathbf{M}\boldsymbol\varepsilon\boldsymbol\varepsilon')\mid\mathbf{X}] = \operatorname{tr}\!\big(\mathbf{M}\,\mathbb{E}[\boldsymbol\varepsilon\boldsymbol\varepsilon'\mid\mathbf{X}]\big) = \sigma^2\operatorname{tr}(\mathbf{M}).$$
E $\operatorname{tr}(\mathbf{M}) = \operatorname{tr}(\mathbf{I}_n) - \operatorname{tr}(\mathbf{P}) = n - \operatorname{tr}\!\big((\mathbf{X}'\mathbf{X})^{-1}\mathbf{X}'\mathbf{X}\big) = n - \operatorname{tr}(\mathbf{I}_K) = n - K.$
Logo $\mathbb{E}[\mathbf{e}'\mathbf{e}\mid\mathbf{X}] = \sigma^2(n-K)$ e $\mathbb{E}[s^2\mid\mathbf{X}] = \sigma^2$. $\blacksquare$

**Relação com máxima verossimilhança (imagens 1 e 3).** Sob normalidade **1.5**, a log-verossimilhança
$$\ln L(\boldsymbol\beta,\sigma^2) = -\frac{n}{2}\ln(2\pi\sigma^2) - \frac{1}{2\sigma^2}(\mathbf{y}-\mathbf{X}\boldsymbol\beta)'(\mathbf{y}-\mathbf{X}\boldsymbol\beta)$$
é maximizada em $\boldsymbol\beta$ **exatamente onde a soma de quadrados é minimizada**. Ou seja: **MQO = EMV** para os coeficientes. (Para $\sigma^2$ o EMV usa denominador $n$, não $n-K$, logo é viesado.) Foi por isso que "verossimilhança" apareceu solta no seu caderno — é a segunda porta de saída quando o modelo deixa de ser linear (logit/probit, imagem 2).

---
---

# Parte II — Aula 2: Teoria de Grandes Amostras
### (Hayashi, Cap. 2)

## 10. Por que precisamos de assintótica

A inferência **exata** da Parte I (testes $t$ e $F$) exige **normalidade** do erro (1.5) — hipótese forte e raramente defensável. A teoria de grandes amostras a dispensa: com $n$ grande, obtemos **consistência** e **normalidade aproximada** sob hipóteses mais fracas. O preço é trocar resultados exatos por resultados que valem "no limite".

## 11. Hipóteses de grandes amostras

O Hayashi troca o arcabouço de regressores fixos + exogeneidade estrita por:

| | Hipótese | Enunciado |
|---|---|---|
| **2.1** | Linearidade | $y_i = \mathbf{x}_i'\boldsymbol\beta + \varepsilon_i$ |
| **2.2** | Estacionariedade ergódica | $\{y_i,\mathbf{x}_i\}$ estacionário e ergódico |
| **2.3** | Ortogonalidade (predeterminado) | $\mathbb{E}[\mathbf{x}_i\varepsilon_i]=\mathbf{0}$ |
| **2.4** | Condição de posto | $\boldsymbol\Sigma_{xx} := \mathbb{E}[\mathbf{x}_i\mathbf{x}_i']$ não-singular |
| **2.5** | $\mathbf{g}_i=\mathbf{x}_i\varepsilon_i$ é MDS | dif. de martingale, com $\mathbf{S}:=\mathbb{E}[\mathbf{g}_i\mathbf{g}_i']$ finita |

> **A grande troca.** A exogeneidade estrita $\mathbb{E}[\varepsilon_i\mid\mathbf{X}]=0$ cai para a **ortogonalidade contemporânea** $\mathbb{E}[\mathbf{x}_i\varepsilon_i]=0$ (2.3) — muito mais fraca. É isso que compra generalidade. Abaixo uso o caso **iid** para as demonstrações ficarem transparentes; a versão ergódica-estacionária do Hayashi é idêntica trocando "LGN iid" por "teorema ergódico".

## 12. Aquecimento: a média amostral (imagens 4–5)

O seu desvio pela média amostral **é** o gabarito de tudo que vem. Seja $\{X_i\}$ iid com $\mathbb{E}[X_i]=\mu$, $\operatorname{Var}[X_i]=\sigma^2$.

**Não-viés** (sua imagem 5): $\mathbb{E}[\bar X] = \frac{1}{n}\sum \mathbb{E}[X_i] = \mu.$ ✓

**Variância** (sua imagem 5): $\operatorname{Var}[\bar X] = \frac{1}{n^2}\sum\operatorname{Var}[X_i] = \dfrac{\sigma^2}{n}.$ ✓

**Consistência** — aqui a sua nota $\lim_{n\to\infty}\sigma^2/n = 0$ vira teorema:
$$\operatorname{EQM}[\bar X] = \operatorname{Var}[\bar X] + \underbrace{(\text{viés})^2}_{0} = \frac{\sigma^2}{n} \xrightarrow[n\to\infty]{} 0.$$
Convergência em média quadrática $\Rightarrow$ convergência em probabilidade. Explicitamente, por **Chebyshev**:
$$P\big(|\bar X - \mu| > \epsilon\big) \le \frac{\operatorname{Var}[\bar X]}{\epsilon^2} = \frac{\sigma^2}{n\epsilon^2} \xrightarrow[n\to\infty]{} 0 \;\Longrightarrow\; \bar X \xrightarrow{p} \mu.$$
Ou seja: **não-viés + variância→0 ⟹ consistência.** A sua observação do limite era exatamente esse motor. $\blacksquare$

**Normalidade assintótica** — pelo Teorema Central do Limite:
$$\sqrt{n}\,(\bar X - \mu) \xrightarrow{d} N(0,\sigma^2).$$

Agora é só transplantar esse par de resultados para a inclinação da regressão.

## 13. Consistência do MQO

Escreva o estimador em termos de **médias** (divida em cima e embaixo por $n$):
$$\mathbf{b} = \boldsymbol\beta + \Big(\underbrace{\tfrac{1}{n}\textstyle\sum \mathbf{x}_i\mathbf{x}_i'}_{\to\,\boldsymbol\Sigma_{xx}}\Big)^{-1}\Big(\underbrace{\tfrac{1}{n}\textstyle\sum \mathbf{x}_i\varepsilon_i}_{\to\,\mathbb{E}[\mathbf{x}_i\varepsilon_i]}\Big).$$

Pela **Lei dos Grandes Números**:
$$\frac{1}{n}\sum \mathbf{x}_i\mathbf{x}_i' \xrightarrow{p} \boldsymbol\Sigma_{xx}\;(\text{não-singular, 2.4}), \qquad \frac{1}{n}\sum \mathbf{x}_i\varepsilon_i \xrightarrow{p} \mathbb{E}[\mathbf{x}_i\varepsilon_i] = \mathbf{0}\;(\text{2.3}).$$

Pelo **Teorema da Aplicação Contínua** (inversão de matriz é contínua onde é não-singular) e por **Slutsky**:
$$\mathbf{b} \xrightarrow{p} \boldsymbol\beta + \boldsymbol\Sigma_{xx}^{-1}\cdot\mathbf{0} = \boldsymbol\beta \;\Longrightarrow\; \textbf{consistente.}\qquad\blacksquare$$

> **O gancho com o seu caderno.** A consistência precisa **só** de $\mathbb{E}[\mathbf{x}_i\varepsilon_i]=0$ — nem exige exogeneidade estrita. Por isso a **endogeneidade** ($\mathbb{E}[\mathbf{x}_i\varepsilon_i]\neq 0$, imagem 1) é tão grave: ela mata **até a consistência**, não só o não-viés. É a definição formal do seu "**inconsistente**" — e a razão de existir variável instrumental / GMM (Hayashi Cap. 3). É também, na sua pesquisa, a hipótese que diff-in-diff e estudos de evento gastam o artigo inteiro tornando crível.

## 14. Normalidade assintótica do MQO

Multiplicando o desvio por $\sqrt{n}$:
$$\sqrt{n}\,(\mathbf{b}-\boldsymbol\beta) = \Big(\tfrac{1}{n}\textstyle\sum \mathbf{x}_i\mathbf{x}_i'\Big)^{-1}\cdot \frac{1}{\sqrt{n}}\sum \mathbf{x}_i\varepsilon_i.$$

Pelo **TCL** aplicado à MDS $\mathbf{g}_i = \mathbf{x}_i\varepsilon_i$, com $\mathbb{E}[\mathbf{g}_i]=\mathbf{0}$ e $\operatorname{Var}[\mathbf{g}_i]=\mathbf{S}=\mathbb{E}[\varepsilon_i^2\,\mathbf{x}_i\mathbf{x}_i']$:
$$\frac{1}{\sqrt{n}}\sum \mathbf{x}_i\varepsilon_i \xrightarrow{d} N(\mathbf{0},\mathbf{S}).$$
Combinando com $\tfrac{1}{n}\sum\mathbf{x}_i\mathbf{x}_i'\xrightarrow{p}\boldsymbol\Sigma_{xx}$ via **Slutsky**:
$$\boxed{\;\sqrt{n}\,(\mathbf{b}-\boldsymbol\beta) \xrightarrow{d} N\!\big(\mathbf{0},\; \boldsymbol\Sigma_{xx}^{-1}\,\mathbf{S}\,\boldsymbol\Sigma_{xx}^{-1}\big)\;}\qquad\blacksquare$$

Essa é a **variância assintótica em sanduíche**. Dois casos:

- **Com homocedasticidade condicional** ($\mathbb{E}[\varepsilon_i^2\mid\mathbf{x}_i]=\sigma^2$): $\mathbf{S}=\sigma^2\boldsymbol\Sigma_{xx}$, e o sanduíche colapsa em
$$\operatorname{Avar}(\mathbf{b}) = \sigma^2\boldsymbol\Sigma_{xx}^{-1},$$
o **eco assintótico** exato da fórmula de amostra finita $\sigma^2(\mathbf{X}'\mathbf{X})^{-1}$ da §6a.
- **Sem homocedasticidade**: fica o sanduíche cheio, estimado pelo **erro-padrão robusto** (White / Eicker–Huber). É de onde saem os "robust SE" — a versão assintótica de largar a hipótese 1.4.

## 15. O retorno: inferência sem normalidade

Com $\widehat{\operatorname{Avar}}(\mathbf{b}) = \widehat{\boldsymbol\Sigma}_{xx}^{-1}\widehat{\mathbf{S}}\,\widehat{\boldsymbol\Sigma}_{xx}^{-1}$ estimado consistentemente:
$$t_k = \frac{b_k - \beta_k}{\operatorname{ep}(b_k)} \xrightarrow{d} N(0,1), \qquad \text{Wald} \xrightarrow{d} \chi^2_q.$$

**Sem** exigir normalidade de $\varepsilon$. Esse é o pagamento do Cap. 2: os mesmos testes da Aula 1, agora válidos **assintoticamente** sob hipóteses muito mais fracas.

---
---

# Mapa de bolso — o arco do curso

A lógica que amarra tudo: cada hipótese que cai derruba uma propriedade e chama uma ferramenta.

| Hipótese violada | O que se perde | Ferramenta que restaura | Hayashi |
|---|---|---|---|
| **1.5** Normalidade | inferência exata | teoria assintótica (TCL) | Cap. 2 |
| **1.4** Homocedasticidade / autocorr. | eficiência; ep. corretos | GLS; ep. robusto (White); HAC | Cap. 1.6, 2, 6 |
| **1.2 / 2.3** Exogeneidade | **não-viés e consistência** | variáveis instrumentais / **GMM** | Cap. 3–4 |
| **1.1** Linearidade | o próprio MQO | máxima verossimilhança; logit/probit | Cap. 7–8 |
| dados em painel | (efeitos individuais) | efeitos fixos / aleatórios | Cap. 5 |

**Síntese.** A Aula 1 construiu o **ideal** — MQO é BLUE sob as hipóteses clássicas (Gauss-Markov) — e nomeou as duas maiores rachaduras (endogeneidade, não-linearidade). A Aula 2 fez a **primeira relaxação**: largou a normalidade e ganhou consistência + normalidade assintótica em troca. O resto do semestre repete o movimento, uma hipótese de cada vez.
