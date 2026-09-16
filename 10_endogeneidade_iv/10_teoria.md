---
title: "Módulo 10 — Endogeneidade e variáveis instrumentais"
modulo: "10"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
greene: "cap. 8 (modelo estendido, VI, MQ2E, testes de Hausman/Wu e de sobreidentificação, erro de medição, instrumentos fracos)"
slides: "SL10"
lista1: [65, 66, 67, 68, 69, 70]
relevancia_p1: alta
status: rascunho
verificacao:
  derivacao: ok
  numerica: pendente
  chave: ok
tags:
  - econometria
  - mestrado/ppgeco
  - p1
aliases:
  - Variáveis instrumentais
  - MQ2E
---

# Módulo 10 — Endogeneidade e variáveis instrumentais

Hub do módulo: [README](README.md) · Exercícios: [10_lista1.md](10_lista1.md) · Script: [10_endogeneidade_iv.R](10_endogeneidade_iv.R)

## 0. Mapa

> [!NOTE]
> **O que este módulo entrega**
> Uma única pergunta atravessa o SL10: o que acontece quando $\operatorname{plim} X'\varepsilon/n\neq 0$ e como recuperar $\beta$. Primeiro, as três fontes clássicas de endogeneidade com o plim do MQO calculado em cada uma (variável omitida, erro de medição, simultaneidade). Depois, o remédio: o estimador de VI no caso exatamente identificado, o MQ2E no sobreidentificado e o GMM que engloba os dois. Por fim, os três diagnósticos que o `ivreg` imprime e que caem na prova (instrumentos fracos, Wu-Hausman, Sargan). O núcleo D0–D16 não é repetido: D9, D10, D13 e D14 são citados; a P1 2025/2 resolvida já tem versões curtas de Q4 (erro em $Y$) e Q6 (derivar $b_{IV}$), que aqui ganham a versão rigorosa.

| D | Resultado | Hipóteses | Usado em |
|---|---|---|---|
| D10.1 | $\operatorname{plim} b=\beta+Q^{-1}\gamma$ e o viés "espalhado" | A1, A2, AI3 | todo o módulo |
| D10.2 | Erro de medição em $X$: $\operatorname{Cov}(z,X)=-\beta\sigma_w^2$ e atenuação | erro clássico | ex. 68 |
| D10.3 | Erro de medição em $Y$: não viesa, infla a variância | $X$ fixo | ex. 70, P1 Q4 |
| D10.4 | Keynes: $\operatorname{plim}\hat\beta_1-\beta_1=(1-\beta_1)\sigma^2/(\sigma_I^2+\sigma^2)$ | $\operatorname{Cov}(I,u)=0$ | ex. 69 |
| D10.5 | $b_{IV}=(Z'X)^{-1}Z'y$ pela condição de plim | I1, I2, $L=K$ | ex. 65, P1 Q6 |
| D10.6 | Consistência e $\operatorname{Asy.Var}(b_{IV})=\sigma^2(Z'X)^{-1}Z'Z(X'Z)^{-1}$ | I1–I3 | D10.8, D10.9 |
| D10.7 | MQ2E: três fórmulas iguais; $=$ MQO de $y$ em $\hat X$ | I1–I3, $L\ge K$ | ex. 66, 67 |
| D10.8 | Variância do MQ2E; por que o EP do 2º estágio ingênuo está errado | I1–I3 | ex. 66c |
| D10.9 | MQ2E é o VI mais eficiente em $Z$; MQO tem variância menor | I1–I3, homocedasticidade | ex. 67c |
| D10.10 | Instrumentos fracos: inconsistência amplificada, viés para o MQO | I1–I3 | ex. 67a |
| D10.11 | Hausman ($\operatorname{Var}(d)=V_{2SLS}-V_{MQO}$) e Wu por função de controle | H0: exogeneidade | ex. 67b |
| D10.12 | Sargan: $nR^2\to\chi^2(L-K)$; impossível com $L=K$ | I1–I3, homocedasticidade | ex. 67c |
| D10.13 | GMM linear; MQ2E como caso particular | momentos $E[z_i\varepsilon_i]=0$ | ex. 66 |

## 1. Notação e hipóteses

**Objetos.** Notação do Greene (CONVENCOES §2).

- $y$ é $n\times 1$; $X$ é $n\times K$ com a coluna de 1s; $\beta$ é $K\times 1$; $\varepsilon$ é $n\times 1$. Linha $i$: $x_i'$ ($1\times K$).
- $X=[X_1\;\;X_2]$: $X_1$ ($n\times K_1$) exógenas, $X_2$ ($n\times K_2$) endógenas, $K=K_1+K_2$.
- $Z$ é $n\times L$, a matriz de instrumentos, com $L\ge K$. Ela contém as exógenas incluídas e os instrumentos excluídos: $Z=[X_1\;\;W]$, com $W$ de dimensão $n\times(L-K_1)$. As exógenas são instrumentos de si mesmas.
- $P_Z=Z(Z'Z)^{-1}Z'$ e $M_Z=I_n-P_Z$ ($n\times n$, simétricas e idempotentes). $\hat X=P_ZX$ ($n\times K$) são os ajustados do 1º estágio. $\hat V=M_ZX$ são os resíduos do 1º estágio (nulos nas colunas de $X_1$).
- Momentos-limite: $Q_{XX}=\operatorname{plim}X'X/n$, $Q_{ZZ}=\operatorname{plim}Z'Z/n$, $Q_{ZX}=\operatorname{plim}Z'X/n$ ($L\times K$), $Q_{XZ}=Q_{ZX}'$, $\gamma=\operatorname{plim}X'\varepsilon/n$ ($K\times 1$).
- $H\equiv Q_{XZ}Q_{ZZ}^{-1}Q_{ZX}$ ($K\times K$), a matriz que aparece no MQ2E.

**Hipóteses.** Valem [A1], [A2], [A4] e [A5] de CONVENCOES §2. A [A3] é trocada:

| Id | Hipótese | Forma |
|---|---|---|
| AI3 | Endogeneidade (Greene, "A.I3") | $E[\varepsilon\mid X]=\eta\neq 0$, logo, em geral, $\gamma=\operatorname{plim}X'\varepsilon/n\neq 0$ |
| I1 | Exogeneidade dos instrumentos | $\operatorname{plim}Z'\varepsilon/n=0$ (implicada por $E[\varepsilon\mid Z]=0$) |
| I2 | Relevância e condição de posto | $Q_{ZX}$ finita com posto $K$; exige $L\ge K$ (condição de ordem) |
| I3 | Regularidade | $Q_{ZZ}$ finita e positiva definida; $Z'\varepsilon/\sqrt n\xrightarrow{d}N(0,\sigma^2Q_{ZZ})$, que vale com $E[\varepsilon\varepsilon'\mid Z]=\sigma^2I$ e o TLC |

**Regras de plim usadas** (Greene, Ap. D): (i) *Slutsky*: $\operatorname{plim}g(a_n)=g(\operatorname{plim}a_n)$ para $g$ contínua, em particular a inversa de uma matriz no ponto em que o limite é não singular; (ii) plim da soma, do produto e da razão (denominador com limite $\neq 0$); (iii) *LGN de Khinchine*: médias amostrais de observações i.i.d. com média finita convergem para a média populacional; (iv) *Cramér*: se $A_n\xrightarrow{p}A$ e $u_n\xrightarrow{d}N(0,\Sigma)$, então $A_nu_n\xrightarrow{d}N(0,A\Sigma A')$.

**Notação escalar (ex. 68–70).** Desvios $x_i=X_i-\bar X$, $S_{XX}=\sum x_i^2$, pesos $k_i=x_i/S_{XX}$ com $\sum k_i=0$, $\sum k_iX_i=1$ e $\sum k_i^2=1/S_{XX}$ (D9).

## 2. Demonstrações

### D10.1 · Inconsistência do MQO sob endogeneidade

> [!NOTE]
> **O que se quer provar**
> Sob [A1], [A2], [AI3], com $Q_{XX}$ positiva definida e $\gamma=\operatorname{plim}X'\varepsilon/n\neq 0$: (i) $E[b\mid X]=\beta+(X'X)^{-1}X'\eta$; (ii) $\operatorname{plim}b=\beta+Q_{XX}^{-1}\gamma\neq\beta$; (iii) se só o regressor $K$ é endógeno, $\operatorname{plim}(b-\beta)=\gamma_K\times$(coluna $K$ de $Q_{XX}^{-1}$), e o viés contamina **todos** os coeficientes.

**Por que importa.** É o problema que o módulo inteiro resolve (SL10, p. 12, 24 e 29). D10.2–D10.4 são casos particulares, com $\gamma$ calculado.

**Passo a passo.**

1. Identidade fundamental, como em D14. *[A1; A2 garante a inversa]*

$$
b=(X'X)^{-1}X'(X\beta+\varepsilon)=\beta+(X'X)^{-1}X'\varepsilon .
$$

2. Esperança condicional. $(X'X)^{-1}X'$ ($K\times n$) é função de $X$ e sai de $E[\cdot\mid X]$. *[linearidade de $E[\cdot\mid X]$; AI3]*

$$
E[b\mid X]=\beta+(X'X)^{-1}X'E[\varepsilon\mid X]=\beta+(X'X)^{-1}X'\eta .
$$

$X'\eta$ é $K\times 1$ e, em geral, não é nulo: o MQO é viesado e Gauss-Markov não se aplica.

3. Para o plim, divida cada fator por $n$ (o produto não muda):

$$
b=\beta+\Big(\frac{X'X}{n}\Big)^{-1}\Big(\frac{X'\varepsilon}{n}\Big).
$$

4. $\operatorname{plim}(X'X/n)^{-1}=Q_{XX}^{-1}$ *[Slutsky: a inversa é contínua em $Q_{XX}$ não singular]*. $\operatorname{plim}X'\varepsilon/n=\operatorname{plim}\tfrac1n\sum_ix_i\varepsilon_i=E[x_i\varepsilon_i]=\gamma$ *[Khinchine]*. Pelo produto de plims:

$$
\boxed{\operatorname{plim}b=\beta+Q_{XX}^{-1}\gamma\neq\beta .}
$$

5. Só o regressor $K$ endógeno: $\gamma=\gamma_Ke_K$, com $e_K$ a $K$-ésima coluna de $I_K$. Então $Q_{XX}^{-1}\gamma=\gamma_K\,Q_{XX}^{-1}e_K=\gamma_K\,(q^{1K},\dots,q^{KK})'$. O coeficiente $j$ é contaminado sempre que $q^{jK}\neq 0$, isto é, sempre que $x_j$ e $x_K$ são correlacionados após controlar pelos demais (SL10, p. 29).

6. Exemplo mínimo: $X=[\iota\;\;x]$, só $x$ endógena, $E[\varepsilon]=0$. Então $Q_{XX}=\begin{bmatrix}1&\mu_x\\ \mu_x&E[x^2]\end{bmatrix}$, $\gamma=(0,\sigma_{x\varepsilon})'$ e

$$
Q_{XX}^{-1}\gamma=\frac{1}{E[x^2]-\mu_x^2}\begin{bmatrix}E[x^2]&-\mu_x\\-\mu_x&1\end{bmatrix}\begin{bmatrix}0\\ \sigma_{x\varepsilon}\end{bmatrix}=\frac{\sigma_{x\varepsilon}}{\sigma_x^2}\begin{bmatrix}-\mu_x\\1\end{bmatrix}.
$$

A inclinação erra por $\sigma_{x\varepsilon}/\sigma_x^2$ e o intercepto erra por $-\mu_x\sigma_{x\varepsilon}/\sigma_x^2$: o viés da inclinação "passa" ao intercepto pela média de $x$.

> [!TIP]
> **Como o professor pode torcer**
> - "Viés ou inconsistência?" O item (i) é o viés, condicional a $X$ e em amostra finita. O item (ii) é a inconsistência. A lista pede um ou outro; responda com a ferramenta certa ($E[\cdot\mid X]$ ou plim).
> - $E[\varepsilon_i\mid x_i]=c$, uma constante não nula, **não** é endogeneidade das inclinações: com constante no modelo, $c$ é absorvido pelo intercepto. O que estraga as inclinações é $\operatorname{Cov}(x_i,\varepsilon_i)\neq 0$.
> - Variável omitida é caso particular: $y=X_1\beta_1+x_2\beta_2+\varepsilon$ estimado sem $x_2$ tem erro $w=x_2\beta_2+\varepsilon$, logo $\gamma=\beta_2\operatorname{plim}X_1'x_2/n$ e $\operatorname{plim}b_1=\beta_1+Q_{11}^{-1}Q_{12}\beta_2$ (ex. 25, módulo 04).
> - O MQO continua estimando **alguma coisa**: $\beta+Q^{-1}\gamma$ é o coeficiente da projeção linear de $y$ em $X$ (módulo 01). Ele só deixa de ser o parâmetro estrutural $\beta$.

### D10.2 · Erro de medição no regressor: viés de atenuação

> [!NOTE]
> **O que se quer provar**
> Modelo verdadeiro $Y_i=\alpha+\beta X_i^*+\mu_i$; observa-se $X_i=X_i^*+w_i$. Hipóteses: observações i.i.d. ($w$ serialmente independente); $E[\mu_i]=E[w_i]=0$; $\operatorname{Var}(w_i)=\sigma_w^2>0$; $\operatorname{Var}(X_i^*)=\sigma_{X^*}^2>0$; $\operatorname{Cov}(w_i,\mu_i)=0$; $\operatorname{Cov}(X_i^*,\mu_i)=0$; e **erro clássico**, $\operatorname{Cov}(X_i^*,w_i)=0$. Então (i) $\operatorname{Cov}(z_i,X_i)=-\beta\sigma_w^2$, com $z_i=\mu_i-\beta w_i$; (ii) o MQO é viesado (sob normalidade conjunta, $E[b]=\beta\lambda$ exatamente); (iii) $\operatorname{plim}b=\beta\lambda$ e $\operatorname{plim}a=\alpha+\beta(1-\lambda)\mu_{X^*}$, com
>
> $$\lambda=\frac{\sigma_{X^*}^2}{\sigma_{X^*}^2+\sigma_w^2}\in(0,1).$$

**Por que importa.** É o ex. 68 (a lista pede a prova "via $\operatorname{Cov}(z_i,X_i)$") e o exemplo de escolaridade do SL10 (p. 8). A hipótese $\operatorname{Cov}(X^*,w)=0$ não está escrita no enunciado, mas é indispensável: declare-a na prova.

**Passo a passo.**

1. Substitua $X_i^*=X_i-w_i$ no modelo verdadeiro. *[A1 no modelo verdadeiro; álgebra]*

$$
Y_i=\alpha+\beta(X_i-w_i)+\mu_i=\alpha+\beta X_i+\underbrace{(\mu_i-\beta w_i)}_{z_i}.
$$

2. Covariância entre o erro composto e o regressor observado. *[bilinearidade da covariância, D0]*

$$
\operatorname{Cov}(z_i,X_i)=\operatorname{Cov}(\mu_i-\beta w_i,\;X_i^*+w_i)
=\underbrace{\operatorname{Cov}(\mu_i,X_i^*)}_{0}+\underbrace{\operatorname{Cov}(\mu_i,w_i)}_{0}-\beta\underbrace{\operatorname{Cov}(w_i,X_i^*)}_{0\ (\text{erro clássico})}-\beta\underbrace{\operatorname{Var}(w_i)}_{\sigma_w^2}.
$$

$$
\boxed{\operatorname{Cov}(z_i,X_i)=-\beta\sigma_w^2\neq 0\quad(\beta\neq 0).}
$$

3. A exogeneidade cai. Se valesse $E[z_i\mid X_i]=0$, teríamos $\operatorname{Cov}(z_i,X_i)=E[X_iz_i]-E[X_i]E[z_i]=E\big[X_i\,E[z_i\mid X_i]\big]-0=0$ *[lei das expectativas iteradas; $E[z_i]=0$]*, o que contradiz o passo 2. Logo $E[z_i\mid X_i]\neq 0$ e a prova de não-viés de D9 não fecha: em $b=\beta+\sum_ik_iz_i$, o termo $\sum_ik_iE[z_i\mid X]$ não se anula.

4. Viés exato sob normalidade conjunta. Suponha $(X_i^*,w_i,\mu_i)$ normais e independentes entre $i$. Então $(z_i,X_i)$ é normal bivariado, $\operatorname{Var}(X_i)=\sigma_{X^*}^2+\sigma_w^2$ (erro clássico) e a regressão condicional é linear *[propriedade da normal, Greene Ap. B]*:

$$
E[z_i\mid X]=E[z_i\mid X_i]=\frac{\operatorname{Cov}(z_i,X_i)}{\operatorname{Var}(X_i)}(X_i-\mu_{X^*})=-\beta(1-\lambda)(X_i-\mu_{X^*}).
$$

A primeira igualdade usa a independência entre observações. Então, com os pesos de D9 ($\sum k_i=0$, $\sum k_iX_i=1$):

$$
E[b\mid X]=\beta+\sum_ik_iE[z_i\mid X]=\beta-\beta(1-\lambda)\Big(\sum_ik_iX_i-\mu_{X^*}\sum_ik_i\Big)=\beta-\beta(1-\lambda)=\beta\lambda .
$$

Pela lei das expectativas iteradas, $E[b]=\beta\lambda\neq\beta$: viesado, **em direção a zero**.

5. Inconsistência, sem precisar de normalidade. Escreva $b-\beta$ como razão de médias amostrais:

$$
b-\beta=\frac{\tfrac1n\sum_i(X_i-\bar X)z_i}{\tfrac1n\sum_i(X_i-\bar X)^2}.
$$

O numerador é $\tfrac1n\sum X_iz_i-\bar X\bar z\xrightarrow{p}E[Xz]-E[X]E[z]=\operatorname{Cov}(X,z)=-\beta\sigma_w^2$. O denominador tende a $\operatorname{Var}(X)=\sigma_{X^*}^2+\sigma_w^2>0$ *[Khinchine; Slutsky]*. Pela regra da razão:

$$
\operatorname{plim}b=\beta-\frac{\beta\sigma_w^2}{\sigma_{X^*}^2+\sigma_w^2}=\beta\,\frac{\sigma_{X^*}^2}{\sigma_{X^*}^2+\sigma_w^2}=\beta\lambda .
$$

6. Intercepto: $a=\bar Y-b\bar X$, com $E[Y]=\alpha+\beta\mu_{X^*}$ e $E[X]=\mu_{X^*}$ (porque $E[w]=0$). *[Khinchine; Slutsky]*

$$
\operatorname{plim}a=\alpha+\beta\mu_{X^*}-\beta\lambda\mu_{X^*}=\alpha+\beta(1-\lambda)\mu_{X^*}.
$$

Os **dois** estimadores de MQO são inconsistentes (o de $\alpha$ só escapa se $\mu_{X^*}=0$).

$$
\boxed{\operatorname{plim}b=\beta\lambda,\qquad \lvert\operatorname{plim}b\rvert\lt\lvert\beta\rvert,\qquad \operatorname{sinal}(\operatorname{plim}b)=\operatorname{sinal}(\beta).}
$$

A simulação do script confirma o plim (figuras [atenuação por $n$](figuras/10_atenuacao_densidades.png) e [curva de confiabilidade](figuras/10_atenuacao_confiabilidade.png)); os números estão na tabela do ex. 68 em [10_lista1.md](10_lista1.md).

> [!TIP]
> **Como o professor pode torcer**
> - Erro na **dependente**: não viesa (D10.3). Erro no **regressor**: viesa e é inconsistente. Troque os dois e a nota zera.
> - Se $\beta=0$, não há viés: $z_i=\mu_i$.
> - Regressão múltipla: o coeficiente da variável medida com erro é atenuado e os demais são contaminados pelo "espalhamento" de D10.1.
> - Erro não clássico ($\operatorname{Cov}(X^*,w)\neq 0$): o sinal do viés fica ambíguo e a fórmula de $\lambda$ não vale.
> - Remédio por VI: uma segunda medida $X_{2i}=X_i^*+w_{2i}$, com $w_2$ independente de $w$, $\mu$ e $X^*$, é instrumento válido. $\operatorname{plim}b_{IV}=\operatorname{Cov}(X_2,Y)/\operatorname{Cov}(X_2,X)=\beta\sigma_{X^*}^2/\sigma_{X^*}^2=\beta$.

### D10.3 · Erro de medição na variável dependente

> [!NOTE]
> **O que se quer provar**
> Modelo verdadeiro $Y_i^*=\alpha+\beta X_i+\mu_i$; observa-se $Y_i=Y_i^*+\varepsilon_i$, logo $Y_i=\alpha+\beta X_i+v_i$ com $v_i=\mu_i+\varepsilon_i$. Hipóteses do ex. 70: $X$ não estocástico; $E[\mu_i]=E[\varepsilon_i]=0$; $\operatorname{Var}(\mu_i)=\sigma_\mu^2$; $\operatorname{Var}(\varepsilon_i)=\sigma_\varepsilon^2$; $\operatorname{Cov}(\mu_i,\varepsilon_i)=0$. Acrescente o que a variância exige: $\operatorname{Cov}(v_i,v_j)=0$ para $i\neq j$. Então $E[b]=\beta$, $E[a]=\alpha$ e
>
> $$\operatorname{Var}(b)=\frac{\sigma_\mu^2+\sigma_\varepsilon^2}{S_{XX}}\gt\frac{\sigma_\mu^2}{S_{XX}}=\operatorname{Var}(b^*).$$

**Por que importa.** Caiu como Q4 da P1 2025/2 (versão curta na [prova resolvida](../provas/p1_2025_2/econometria-i-prova-2025-2-resolvida.md)). Aqui entram o intercepto, a consistência, o que acontece com $s^2$ e os testes, e o caso em que o erro de medição depende de $X$.

**Passo a passo.**

1. Pesos de D9: $b=\sum_ik_iY_i=\alpha\sum_ik_i+\beta\sum_ik_iX_i+\sum_ik_iv_i=\beta+\sum_ik_iv_i$. *[D9: $\sum k_i=0$, $\sum k_iX_i=1$]*

2. Com $X$ fixo, os $k_i$ são constantes. *[linearidade de $E$]*

$$
E[b]=\beta+\sum_ik_i\big(E[\mu_i]+E[\varepsilon_i]\big)=\beta .
$$

3. Intercepto: $a=\bar Y-b\bar X=\alpha+\beta\bar X+\bar v-b\bar X=\alpha-(b-\beta)\bar X+\bar v$, logo $E[a]=\alpha-0\cdot\bar X+0=\alpha$.

4. Variância. *[Var de forma linear; $\operatorname{Cov}(\mu_i,\varepsilon_i)=0$; $\operatorname{Cov}(v_i,v_j)=0$]*

$$
\operatorname{Var}(v_i)=\sigma_\mu^2+\sigma_\varepsilon^2+2\operatorname{Cov}(\mu_i,\varepsilon_i)=\sigma_\mu^2+\sigma_\varepsilon^2,
$$

$$
\operatorname{Var}(b)=\sum_ik_i^2\operatorname{Var}(v_i)+\sum_{i\neq j}k_ik_j\operatorname{Cov}(v_i,v_j)=(\sigma_\mu^2+\sigma_\varepsilon^2)\sum_ik_i^2=\frac{\sigma_\mu^2+\sigma_\varepsilon^2}{S_{XX}} .
$$

5. Comparação com o modelo sem erro, em que $\operatorname{Var}(b^*)=\sigma_\mu^2/S_{XX}$ (D10):

$$
\operatorname{Var}(b)-\operatorname{Var}(b^*)=\frac{\sigma_\varepsilon^2}{S_{XX}}\gt 0,\qquad \frac{\operatorname{Var}(b)}{\operatorname{Var}(b^*)}=1+\frac{\sigma_\varepsilon^2}{\sigma_\mu^2}.
$$

6. Consistência: se $S_{XX}\to\infty$ (por exemplo, $S_{XX}/n\to q\gt 0$), então $\operatorname{Var}(b)\to 0$; com $E[b]=\beta$, $b$ converge em média quadrática e, portanto, em probabilidade. O erro em $Y$ não afeta a consistência.

7. Inferência: $s^2=\sum\hat v_i^2/(n-2)$ é não viesado para $\sigma_\mu^2+\sigma_\varepsilon^2$ (é o $s^2$ de um MRLC com erro $v$). Os erros-padrão reportados estão **certos** para este modelo, só que maiores. Os $t$ ficam menores, o teste perde poder e o $R^2$ cai.

$$
\boxed{E[b]=\beta,\qquad \operatorname{Var}(b)=\frac{\sigma_\mu^2+\sigma_\varepsilon^2}{\sum_i(X_i-\bar X)^2}.}
$$

> [!TIP]
> **Como o professor pode torcer**
> - **Erro correlacionado com $X$** (com $X$ aleatório e $\operatorname{Cov}(X,\varepsilon)=\sigma_{X\varepsilon}\neq 0$): $b=\beta+\sum k_i\mu_i+\sum k_i\varepsilon_i$ e $\operatorname{plim}b=\beta+\sigma_{X\varepsilon}/\sigma_X^2$. Fica viesado e inconsistente. Exemplo: renda declarada que sub-reporta mais quanto maior a escolaridade. Se $\varepsilon_i=\delta(X_i-\mu_X)+e_i$, o MQO estima $\beta+\delta$.
> - **Erro com média não nula** ($E[\varepsilon_i]=c$): a inclinação continua não viesada e o intercepto estima $\alpha+c$.
> - Hipótese redundante no enunciado: com $X$ não estocástico, $\operatorname{Cov}(X_i,v_i)=0$ e $\operatorname{Cov}(X_i,\varepsilon_i)=0$ valem automaticamente. A hipótese que falta, e que a variância usa, é a ausência de correlação entre observações.

### D10.4 · Simultaneidade no modelo keynesiano

> [!NOTE]
> **O que se quer provar**
> $C_t=\beta_0+\beta_1Y_t+u_t$ e $Y_t=C_t+I_t$, com $0\lt\beta_1\lt 1$, $E[u_t]=0$, $E[u_t^2]=\sigma^2$, $E[u_tu_{t+j}]=0$ ($j\neq 0$), $\operatorname{Cov}(I_t,u_t)=0$ e momentos amostrais que convergem para os populacionais, com $\sigma_I^2=\operatorname{Var}(I_t)\gt 0$. Então
>
> $$\operatorname{plim}\hat\beta_1=\beta_1+\frac{(1-\beta_1)\,\sigma^2}{\sigma_I^2+\sigma^2}\gt\beta_1,$$
>
> e o estimador de VI que usa $I_t$ como instrumento é consistente.

**Por que importa.** É o ex. 69 e o exemplo de oferta e demanda do SL10 (p. 7): a variável explicativa é determinada **junto** com a dependente. Na prova, o ponto é mostrar $\operatorname{Cov}(Y_t,u_t)\neq 0$ pela forma reduzida.

**Passo a passo.**

1. Forma reduzida: substitua a função consumo na identidade e isole $Y_t$ (exige $\beta_1\neq 1$).

$$
Y_t=\beta_0+\beta_1Y_t+u_t+I_t\;\Longrightarrow\;Y_t=\frac{\beta_0}{1-\beta_1}+\frac{1}{1-\beta_1}I_t+\frac{1}{1-\beta_1}u_t .
$$

2. Covariância entre o regressor e o erro. *[bilinearidade; constantes não covariam; $\operatorname{Cov}(I,u)=0$]*

$$
\operatorname{Cov}(Y_t,u_t)=\frac{\operatorname{Cov}(I_t,u_t)+\operatorname{Var}(u_t)}{1-\beta_1}=\frac{\sigma^2}{1-\beta_1}\neq 0 .
$$

$Y_t$ é endógena: [A3] falha.

3. Variância do regressor. *[Var de forma linear; $\operatorname{Cov}(I,u)=0$]*

$$
\operatorname{Var}(Y_t)=\frac{\sigma_I^2+\sigma^2}{(1-\beta_1)^2}.
$$

4. MQO em desvios ($y_t=Y_t-\bar Y$, $c_t=C_t-\bar C$): $c_t=\beta_1y_t+(u_t-\bar u)$, logo, como $\sum_ty_t=0$ *[D5]*,

$$
\hat\beta_1=\frac{\sum_ty_tc_t}{\sum_ty_t^2}=\beta_1+\frac{\sum_ty_tu_t}{\sum_ty_t^2}=\beta_1+\frac{\tfrac1n\sum_ty_tu_t}{\tfrac1n\sum_ty_t^2}.
$$

5. Plim: o numerador tende a $\operatorname{Cov}(Y,u)$ e o denominador a $\operatorname{Var}(Y)\gt 0$ *[LGN; regra da razão de Slutsky]*. Usando os passos 2 e 3:

$$
\operatorname{plim}\hat\beta_1=\beta_1+\frac{\sigma^2/(1-\beta_1)}{(\sigma_I^2+\sigma^2)/(1-\beta_1)^2}=\beta_1+\frac{(1-\beta_1)\,\sigma^2}{\sigma_I^2+\sigma^2}.
$$

6. Sinal e tamanho: $1-\beta_1\gt 0$, $\sigma^2\gt 0$ e $\sigma^2/(\sigma_I^2+\sigma^2)\in(0,1)$. Logo $0\lt\operatorname{plim}\hat\beta_1-\beta_1\lt 1-\beta_1$, isto é, $\operatorname{plim}\hat\beta_1\in(\beta_1,1)$: o MQO **superestima** a propensão marginal a consumir.

$$
\boxed{\operatorname{plim}\hat\beta_1-\beta_1=\frac{(1-\beta_1)\,\sigma^2}{\sigma_I^2+\sigma^2}\gt 0 .}
$$

7. Por que plim e não viés: $E[\hat\beta_1]$ é a esperança de uma razão de variáveis aleatórias, sem forma fechada. O plim passa pela razão (Slutsky); a esperança não passa. Por isso o enunciado pede **inconsistência**.

8. Remédio. $I_t$ é exógeno ($\operatorname{Cov}(I,u)=0$) e relevante ($\operatorname{Cov}(I,Y)=\sigma_I^2/(1-\beta_1)\neq 0$). O estimador de VI $\hat\beta_1^{IV}=\sum_ti_tc_t/\sum_ti_ty_t$ (D10.5 bivariado) satisfaz $\operatorname{plim}\hat\beta_1^{IV}=\beta_1+\operatorname{Cov}(I,u)/\operatorname{Cov}(I,Y)=\beta_1$. Ele coincide com os mínimos quadrados indiretos: a forma reduzida $C_t=\pi_0+\pi_1I_t+\cdots$ tem $\pi_1=\beta_1/(1-\beta_1)$; como $\sum i_ty_t=\sum i_tc_t+\sum i_t^2$, vale $\hat\pi_1/(1+\hat\pi_1)=\sum i_tc_t/\sum i_ty_t$.

Monte Carlo no script, com os números na tabela do ex. 69 em [10_lista1.md](10_lista1.md) e a [figura MQO × VI](figuras/10_keynes_mqo_vs_vi.png).

> [!TIP]
> **Como o professor pode torcer**
> - Pedir só $\operatorname{Cov}(Y_t,u_t)$: é o passo 2, e a forma reduzida é obrigatória.
> - Com governo, $Y=C+I+G$: troque $I$ por $I+G$ em tudo.
> - Quanto maior $\sigma_I^2$ (mais variação exógena na renda), menor a inconsistência. Com $\sigma_I^2\to 0$, $\operatorname{plim}\hat\beta_1\to 1$.
> - Demanda e oferta (SL10, p. 7): o mesmo argumento dá $\operatorname{Cov}(P,\varepsilon_D)\neq 0$, porque o preço de equilíbrio depende dos dois choques.

### D10.5 · Estimador de VI no caso exatamente identificado

> [!NOTE]
> **O que se quer provar**
> $y=X\beta+\varepsilon$ com $E[\varepsilon\mid X]=\eta\neq 0$; $Z$ é $n\times L$ com $L=K$; variâncias finitas; [I1] $\operatorname{plim}Z'\varepsilon/n=0$; [I2] $Q_{ZX}$ ($K\times K$) não singular. Derivar
>
> $$b_{IV}=(Z'X)^{-1}Z'y .$$

**Por que importa.** Ex. 65 e Q6 da P1 2025/2 (versão curta na prova resolvida). A versão rigorosa separa três coisas: **identificação** (o parâmetro é função de momentos populacionais), **estimação** (princípio da analogia) e **existência** da inversa.

**Passo a passo.**

1. Parta de [I1] e substitua $\varepsilon=y-X\beta$ *[A1]*. Como $Z'y/n=(Z'X/n)\beta+Z'\varepsilon/n\xrightarrow{p}Q_{ZX}\beta$, o limite $q_{Zy}\equiv\operatorname{plim}Z'y/n$ existe. Pela linearidade do plim ($\beta$ é constante):

$$
0=\operatorname{plim}\frac{Z'(y-X\beta)}{n}=q_{Zy}-Q_{ZX}\beta .
$$

2. São $K$ equações lineares em $K$ incógnitas. Por [I2], $Q_{ZX}$ é inversível. Então $\beta$ fica **identificado**, escrito só com momentos de variáveis observáveis:

$$
\beta=Q_{ZX}^{-1}q_{Zy}.
$$

3. Princípio da analogia (método dos momentos): troque os momentos populacionais pelos amostrais. O estimador é o vetor que zera a condição de momento **amostral**:

$$
\frac1nZ'(y-Xb_{IV})=0\;\Longleftrightarrow\;Z'X\,b_{IV}=Z'y .
$$

Dimensões: $Z'$ é $K\times n$, $X$ é $n\times K$, $Z'X$ é $K\times K$, $Z'y$ é $K\times 1$.

4. Como $Z'X/n\xrightarrow{p}Q_{ZX}$ não singular, $Z'X$ é inversível com probabilidade tendendo a 1 *[Slutsky: o determinante é contínuo]*. Os $n$ se cancelam:

$$
\boxed{b_{IV}=\Big(\frac{Z'X}{n}\Big)^{-1}\frac{Z'y}{n}=(Z'X)^{-1}Z'y .}
$$

5. Por que $L=K$: com $L\gt K$, $Z'X$ é $L\times K$, não é quadrada, e o sistema $Z'Xb=Z'y$ tem $L$ equações para $K$ incógnitas, em geral sem solução exata na amostra. Aí entram o MQ2E (D10.7) e o GMM (D10.13), que combinam as $L$ condições.

6. Caso bivariado (SL10, p. 26): $X=[\iota\;\;x]$ e $Z=[\iota\;\;z]$. O sistema $Z'Xb=Z'y$ é

$$
\begin{bmatrix}n&\sum x_i\\ \sum z_i&\sum z_ix_i\end{bmatrix}\begin{bmatrix}a\\ b\end{bmatrix}=\begin{bmatrix}\sum y_i\\ \sum z_iy_i\end{bmatrix}.
$$

A 1ª linha dá $a=\bar y-b\bar x$. Levando à 2ª: $b\big(\sum z_ix_i-n\bar z\bar x\big)=\sum z_iy_i-n\bar z\bar y$. Pelas identidades de D5,

$$
b_{IV}=\frac{\sum_i(z_i-\bar z)(y_i-\bar y)}{\sum_i(z_i-\bar z)(x_i-\bar x)}=\frac{\widehat{\operatorname{Cov}}(z,y)}{\widehat{\operatorname{Cov}}(z,x)} .
$$

O script confere essa fórmula com o `ivreg` (chave `m10_biv_dif` em [10_lista1.md](10_lista1.md), ex. 65).

> [!TIP]
> **Como o professor pode torcer**
> - "Mostre que $b_{IV}$ é não viesado": **não dá**. $b_{IV}-\beta=(Z'X)^{-1}Z'\varepsilon$, e $X$ continua aleatório e correlacionado com $\varepsilon$ mesmo condicionando em $Z$. O resultado correto é consistência (D10.6). Sob normalidade, o VI exatamente identificado nem tem média finita (Kinal, 1980).
> - "E se $Z=X$?" Então $b_{IV}=(X'X)^{-1}X'y=b$: o MQO é o VI em que cada regressor é instrumento de si mesmo (SL10, p. 28). Só é válido se [A3] valer.
> - Cuidado com a ordem: é $(Z'X)^{-1}Z'y$, não $(X'Z)^{-1}Z'y$. As dimensões até batem, mas o sistema resolvido não é o mesmo.
> - Relevância é o que garante a inversa. Com $Q_{ZX}$ singular (instrumento irrelevante), $\beta$ não é identificado.

### D10.6 · Consistência e variância assintótica do estimador de VI

> [!NOTE]
> **O que se quer provar**
> Sob [A1], [I1]–[I3] com $L=K$: (i) $\operatorname{plim}b_{IV}=\beta$; (ii) $\sqrt n(b_{IV}-\beta)\xrightarrow{d}N\big(0,\sigma^2Q_{ZX}^{-1}Q_{ZZ}Q_{XZ}^{-1}\big)$; (iii) $\operatorname{Est.Asy.Var}(b_{IV})=\hat\sigma^2(Z'X)^{-1}Z'Z(X'Z)^{-1}$, com $\hat\sigma^2=\tfrac1n\sum_i(y_i-x_i'b_{IV})^2$ consistente para $\sigma^2$.

**Por que importa.** Completa o ex. 65 (o professor pode pedir "e mostre que é consistente") e dá a fórmula do SL10, p. 30. É daqui que saem os erros-padrão do `ivreg` e a comparação de eficiência de D10.9.

**Passo a passo.**

1. Substitua $y=X\beta+\varepsilon$ *[A1]*: $b_{IV}=(Z'X)^{-1}Z'X\beta+(Z'X)^{-1}Z'\varepsilon=\beta+(Z'X)^{-1}Z'\varepsilon$.

2. Consistência. Divida por $n$ e tome o plim. *[Slutsky para a inversa; I2; I1; produto de plims]*

$$
\operatorname{plim}(b_{IV}-\beta)=\Big[\operatorname{plim}\frac{Z'X}{n}\Big]^{-1}\operatorname{plim}\frac{Z'\varepsilon}{n}=Q_{ZX}^{-1}\cdot 0=0 .
$$

$X'\varepsilon$ não aparece em lugar nenhum: o $\gamma\neq 0$ de D10.1 é irrelevante para o VI.

3. Distribuição. Multiplique por $\sqrt n$:

$$
\sqrt n(b_{IV}-\beta)=\Big(\frac{Z'X}{n}\Big)^{-1}\frac{Z'\varepsilon}{\sqrt n}.
$$

Por [I3], $Z'\varepsilon/\sqrt n=\tfrac1{\sqrt n}\sum_iz_i\varepsilon_i\xrightarrow{d}N(0,\sigma^2Q_{ZZ})$: os termos têm média $E[z_i\varepsilon_i]=0$ e variância $E[\varepsilon_i^2z_iz_i']=E\big[E[\varepsilon_i^2\mid z_i]z_iz_i'\big]=\sigma^2E[z_iz_i']$ *[LEI; homocedasticidade dado $z$; TLC]*. Por Cramér, com $(Q_{ZX}^{-1})'=(Q_{ZX}')^{-1}=Q_{XZ}^{-1}$:

$$
\sqrt n(b_{IV}-\beta)\xrightarrow{d}N\big(0,\;\sigma^2Q_{ZX}^{-1}Q_{ZZ}Q_{XZ}^{-1}\big).
$$

4. Variância assintótica: divida por $n$ e troque os $Q$ pelos momentos amostrais. Os $n$ se cancelam: $\tfrac{\sigma^2}{n}(Z'X/n)^{-1}(Z'Z/n)(X'Z/n)^{-1}=\sigma^2(Z'X)^{-1}Z'Z(X'Z)^{-1}$. Dimensões: $(K\times K)(K\times K)(K\times K)$.

$$
\boxed{\operatorname{Asy.Var}(b_{IV})=\sigma^2(Z'X)^{-1}Z'Z(X'Z)^{-1}.}
$$

5. $\hat\sigma^2$ é consistente. Com $e_{IV}=y-Xb_{IV}=\varepsilon-X(b_{IV}-\beta)$:

$$
\frac{e_{IV}'e_{IV}}{n}=\frac{\varepsilon'\varepsilon}{n}-2(b_{IV}-\beta)'\frac{X'\varepsilon}{n}+(b_{IV}-\beta)'\frac{X'X}{n}(b_{IV}-\beta)\xrightarrow{p}\sigma^2-2\cdot 0'\gamma+0'Q_{XX}0=\sigma^2 .
$$

O detalhe fino: $X'\varepsilon/n\to\gamma\neq 0$, mas $\gamma$ é finito e vem multiplicado por $b_{IV}-\beta\to 0$. O resíduo usa $X$, **não** $Z$ nem $\hat X$ (D10.8).

6. Sem homocedasticidade, $\operatorname{Var}(Z'\varepsilon/\sqrt n)\to S=\operatorname{plim}\tfrac1n\sum\varepsilon_i^2z_iz_i'$ e a variância vira o sanduíche $(Z'X)^{-1}\big(\sum_ie_i^2z_iz_i'\big)(X'Z)^{-1}$. É o que `summary(iv, vcov = sandwich)` usa no ex. 67.

> [!WARNING]
> **Leia a fórmula como assintótica**
> O SL10 (p. 30) escreve a matriz como $E[(b_{IV}-\beta)(b_{IV}-\beta)'\mid X,Z]$. Não faça essa conta condicionando em $X$ na prova: com $X$ endógeno, $E[\varepsilon\mid X]=\eta\neq 0$, e $b_{IV}$ pode nem ter momentos finitos. O resultado rigoroso é o do passo 3. Escreva "Asy.Var".

> [!TIP]
> **Como o professor pode torcer**
> - "Compare a variância do VI com a do MQO": caso escalar, $\operatorname{Asy.Var}(b_{IV})=\sigma^2/(n\sigma_x^2\rho_{zx}^2)$ contra $\sigma^2/(n\sigma_x^2)$. A razão $1/\rho_{zx}^2\ge 1$ mostra que o VI é menos preciso, e muito menos com instrumento fraco (D10.9, D10.10).
> - "Onde entrou a relevância?" Na inversa de $Q_{ZX}$, nos passos 2 e 3.

(Em construção: D10.7 a D10.13.)

## 3. Como cai na prova

(em construção)

## 4. Interpretação de output

(em construção)

## 5. Armadilhas

(em construção)

## 6. Checklist

(em construção)

## 7. Referências

(em construção)
