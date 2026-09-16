---
title: "Módulo 02 — Lista 1 resolvida (ex. 13–22 e 40)"
modulo: "02"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
greene: "cap. 3 (§3.2); cap. 4 (§4.3)"
slides: "SL03, SL06, SL07"
lista1: [13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 40]
relevancia_p1: alta
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
  - MQO simples — Lista 1
---

# Módulo 02 — Lista 1 resolvida (ex. 13–22 e 40)

Estes onze exercícios são o coração da Q3 da prova. As demonstrações completas estão em [02_teoria.md](02_teoria.md); aqui fica a resposta no formato e no tamanho que se escreve na prova. Os números do ex. 40 saem de [02_mqo_simples.R](02_mqo_simples.R) e estão em `resultados/m02.csv`.

> [!TIP]
> **O que o Zambon cobra**
> Hipóteses escritas, cada linha justificada e a conclusão em português. Resultado certo sem justificativa vale pouco; caminho certo com erro de conta vale quase tudo.

---

## Ex. 13 — Investimento público e PIB estadual: interpretar, estimar e justificar

**Tipo:** derivação e conceito · **Chave:** ✅ confere · **Cai como:** abertura de questão dissertativa

**(a) Interpretação.** No modelo $Y_i=\beta_1+\beta_2X_i+u_i$, com $Y$ = PIB e $X$ = investimento, ambos em R\$ bilhões: $\beta_1$ é o intercepto, o valor esperado do PIB quando o investimento é zero (aqui sem sentido econômico forte, é âncora da reta); $\beta_2$ é o coeficiente angular, o **efeito marginal**: quanto o PIB esperado varia, em R\$ bilhões, quando o investimento sobe R\$ 1 bilhão; $u_i$ é o erro aleatório, que junta tudo o que afeta o PIB e não está no modelo, mais erro de medida e aleatoriedade intrínseca.

**(b) Como se obtêm os parâmetros.** Minimizando a soma de quadrados dos resíduos $\sum \hat u_i^2 = \sum (Y_i-\hat\beta_1-\hat\beta_2X_i)^2$; as condições de primeira ordem dão as duas equações normais e, resolvendo-as, $\hat\beta_2=S_{XY}/S_{XX}$ e $\hat\beta_1=\bar Y-\hat\beta_2\bar X$ (ver D02.1). Com os 27 estados em 2010, $n=27$.

**(c) O que garante que é o melhor.** O **teorema de Gauss-Markov**: satisfeitas as hipóteses do modelo clássico (linearidade, $E[u\mid X]=0$, homocedasticidade, ausência de autocorrelação e $X$ com variação), o MQO é **MELNV** — o melhor estimador linear não viesado, isto é, de menor variância na classe dos lineares não viesados (D02.16 e D11).

## Ex. 14 — Não-viés de $\hat\beta_1$ e $\hat\beta_2$

**Tipo:** derivação · **Chave:** ➖ (remete a livro) · **Cai como:** Q3/Q4

Escreva $\hat\beta_2=\sum k_iY_i$ com $k_i=x_i/S_{XX}$ e use as três propriedades dos pesos ($\sum k_i=0$, $\sum k_iX_i=1$, $\sum k_i^2=1/S_{XX}$). Substituindo o modelo verdadeiro:
$$\hat\beta_2=\beta_2+\sum_i k_iu_i \;\Longrightarrow\; E[\hat\beta_2\mid X]=\beta_2+\sum_i k_i\underbrace{E[u_i\mid X]}_{=0}=\beta_2.$$
Para o intercepto, de $\hat\beta_1=\bar Y-\hat\beta_2\bar X = \beta_1+\bar u-(\hat\beta_2-\beta_2)\bar X$:
$$E[\hat\beta_1\mid X]=\beta_1+E[\bar u\mid X]-\bar X\,E[\hat\beta_2-\beta_2\mid X]=\beta_1.$$
Detalhes em D02.5.

> [!TIP]
> **Como escrever na prova**
> Três passos: (1) estimador como combinação linear dos $Y$; (2) substituir o modelo e usar as propriedades dos pesos; (3) tomar $E[\cdot\mid X]$ e usar $E[u\mid X]=0$. Diga qual hipótese usou em cada passo.

## Ex. 15 — Viés por omissão de variável relevante

**Tipo:** derivação · **Chave:** ✅ confere (a chave dá a fórmula do viés) · **Cai como:** Q4

Modelo verdadeiro $Y_i=\beta_1+\beta_2X_{i2}+\beta_3X_{i3}+u_i$, mas estima-se só com $X_2$. O estimador curto é **viesado**:
$$E[\tilde\beta_2\mid X]=\beta_2+\beta_3\underbrace{\frac{\sum_i (X_{i2}-\bar X_2)X_{i3}}{\sum_i (X_{i2}-\bar X_2)^2}}_{\hat\delta\;=\;\text{coef. da auxiliar } X_3 \text{ em } X_2},$$
ou seja, viés $=\beta_3\hat\delta$. Ele desaparece se $\beta_3=0$ (a variável não era relevante) ou se $\hat\delta=0$ ($X_2$ e $X_3$ são ortogonais na amostra). O sinal do viés é o sinal do produto $\beta_3\hat\delta$ (D02.9).

Simulação de Monte Carlo confirmando o resultado (10 000 amostras, $n=50$): viés teórico 0,8650 e viés simulado 0,8650.

**Conferência numérica**

| chave_R | nota |
|---|---|
| m02_ex15_vies_teo | 0,8650 |
| m02_ex15_vies_mc | 0,8650 |
| m02_ex15_media_b2_longa | 1,9985 |

> [!WARNING]
> **A troca que a prova adora**
> A regressão curta é viesada, mas tem variância **menor** (0,0099 contra 0,0231 na simulação). É o dilema viés-variância: excluir variável para fugir da multicolinearidade compra precisão pagando com viés.

## Ex. 16 — Variâncias e covariância dos estimadores

**Tipo:** derivação · **Chave:** ➖ · **Cai como:** Q5

De $\hat\beta_2=\beta_2+\sum k_iu_i$, com homocedasticidade e ausência de autocorrelação:
$$\operatorname{Var}(\hat\beta_2\mid X)=\sigma^2\sum_i k_i^2=\frac{\sigma^2}{S_{XX}},\qquad \operatorname{Var}(\hat\beta_1\mid X)=\sigma^2\left(\frac1n+\frac{\bar X^2}{S_{XX}}\right),$$
$$\operatorname{Cov}(\hat\beta_1,\hat\beta_2\mid X)=-\bar X\,\frac{\sigma^2}{S_{XX}}.$$
Ver D02.6 e D02.7. A covariância é negativa quando $\bar X\gt 0$: superestimar a inclinação obriga a subestimar o intercepto, porque a reta passa por $(\bar X,\bar Y)$.

## Ex. 17 — $\sum \hat u_i = 0$ e $\sum X_i\hat u_i = 0$

**Tipo:** derivação · **Chave:** ➖ · **Cai como:** item curto

As duas igualdades **são** as equações normais: elas saem das condições de primeira ordem, não de hipótese nenhuma sobre o erro. Derivando a SQR em relação a $\hat\beta_1$ obtém-se $\sum\hat u_i=0$; em relação a $\hat\beta_2$, $\sum X_i\hat u_i=0$ (D02.1 e D02.2). Consequências imediatas: $\overline{\hat Y}=\bar Y$ e $\widehat{\operatorname{Cov}}(X,\hat u)=0$.

> [!WARNING]
> **Sem intercepto nada disso vale**
> Na regressão pela origem, $\sum\hat u_i\neq 0$ em geral. Na verificação em R, o modelo sem constante deu $\sum\hat u_i = 1{,}5771$ em vez de zero.

## Ex. 18 — $t^2 = F$ na regressão simples

**Tipo:** derivação · **Chave:** ➖ · **Cai como:** item de fechamento

Com $t_0=\hat\beta_2/\sqrt{QMR/S_{XX}}$, elevar ao quadrado dá
$$t_0^2=\frac{\hat\beta_2^2 S_{XX}}{QMR}=\frac{SQE/1}{SQR/(n-2)}=F_0,$$
porque na regressão simples $SQE=\hat\beta_2^2S_{XX}$ e o numerador tem 1 grau de liberdade. Logo testar $\beta_2=0$ por $t$ ou por $F$ é o mesmo teste (D02.11). Confirmado no ex. 40: $t^2 = 512{,}0252 = F$.

## Ex. 19 — $F$ escrito com o $R^2$

**Tipo:** derivação · **Chave:** ➖

Divida numerador e denominador de $F=\dfrac{SQE}{SQR/(n-2)}$ por $SQT$ e use $R^2=SQE/SQT$:
$$F=\frac{R^2}{(1-R^2)/(n-2)}.$$
A versão múltipla é o ex. 27 (módulo 05). Ver D02.12.

## Ex. 20 — Dispersão de $X$ e precisão

**Tipo:** conceito · **Chave:** ✅ confere

Como $\operatorname{Var}(\hat\beta_2)=\sigma^2/S_{XX}$, quanto **maior** a dispersão de $X$ em torno da média, maior $S_{XX}$ e **menor** a variância: mais precisão. A intuição é geométrica — com os $X$ espalhados, a inclinação da reta fica bem determinada; com os $X$ amontoados, pequenas variações no erro giram muito a reta. É também por isso que $\hat\beta_2$ é consistente: $S_{XX}$ cresce com $n$ (D02.13).

**Conferência numérica** (mesmo $\sigma^2$, duas dispersões de $X$)

| chave_R | nota |
|---|---|
| m02_ex20_var_alta_teo | 0,00032143 |
| m02_ex20_var_baixa_teo | 0,0039375 |
| m02_ex20_razao_dp_teo | 3,5 |

## Ex. 21 — A média dos valores ajustados é a média observada

**Tipo:** derivação · **Chave:** ➖

De $\hat Y_i=\hat\beta_1+\hat\beta_2X_i$ e $\hat\beta_1=\bar Y-\hat\beta_2\bar X$:
$$\overline{\hat Y}=\hat\beta_1+\hat\beta_2\bar X=\bar Y-\hat\beta_2\bar X+\hat\beta_2\bar X=\bar Y.$$
Equivale a $\sum\hat u_i=0$ (ex. 17) e vale apenas com intercepto.

## Ex. 22 — O modelo em desvios da média

**Tipo:** derivação · **Chave:** ➖

Some as médias no modelo estimado e subtraia: com $\bar Y=\hat\beta_1+\hat\beta_2\bar X$ (porque $\sum\hat u_i=0$),
$$Y_i-\bar Y=\hat\beta_2 (X_i-\bar X)+\hat u_i \;\Longleftrightarrow\; y_i=\hat\beta_2 x_i+\hat u_i.$$
O intercepto some, a inclinação e os resíduos são **exatamente os mesmos** (D02.3). É a versão mais simples do teorema de Frisch-Waugh-Lovell (módulo 04): centrar as variáveis equivale a incluir a constante. Verificado em R: a maior diferença entre os resíduos das duas formas é da ordem de $10^{-16}$.

## Ex. 40 — Função de produção à mão

**Tipo:** cálculo · **Chave:** ⏳ a conferir · **Cai como:** questão numérica de abertura

Quinze observações de produção $Y$ contra quantidade de insumos $X$ (dados na Lista 1, ex. 40; embutidos no script).

**(a) Estimação.** As somas:

$$n=15,\quad \textstyle\sum X=120,\quad \sum Y=42{,}08,\quad \sum XY=418{,}53,\quad \sum X^2=1240.$$

Daí $\bar X=8$, $\bar Y=2{,}805333$ e
$$S_{XX}=\sum X^2-n\bar X^2=1240-960=280,\qquad S_{XY}=\sum XY-n\bar X\bar Y=418{,}53-336{,}64=81{,}89,$$
$$\hat\beta_2=\frac{81{,}89}{280}=0{,}292464,\qquad \hat\beta_1=2{,}805333-0{,}292464\times 8=0{,}465619.$$

$$\widehat{Y}_i = 0{,}465619 + 0{,}292464\,X_i$$

**(b) Leitura econômica.** $\hat\beta_2=0{,}2925$ é o **produto marginal** do insumo: cada unidade adicional de insumo eleva a produção em cerca de 0,29 unidade. É constante por construção — a especificação linear impõe produtividade marginal constante, sem rendimentos decrescentes.

**(c) Gráfico.** Reta ajustada sobre os pontos em [figuras/m02_ex40_funcao_producao.png](figuras/m02_ex40_funcao_producao.png).

**(d) Previsão em $X=20$.**
$$\hat Y=0{,}465619+0{,}292464\times 20=6{,}3149.$$
Extrapolação: 20 está fora do intervalo amostral (1 a 15), então a previsão supõe que a relação linear continua valendo.

**(e) Elasticidade no ponto médio.**
$$\hat\eta=\hat\beta_2\frac{\bar X}{\bar Y}=0{,}292464\times\frac{8}{2{,}805333}=0{,}8340.$$
Aumentar o insumo em 1% eleva a produção em cerca de 0,83%: elasticidade menor que 1, isto é, rendimentos decrescentes **em termos proporcionais** no ponto médio.

**Conferência numérica**

| chave_R | nota |
|---|---|
| m02_ex40_Sxx | 280 |
| m02_ex40_Sxy | 81,89 |
| m02_ex40_b1 | 0,465619 |
| m02_ex40_b2 | 0,292464 |
| m02_ex40_prev20 | 6,3149 |
| m02_ex40_elast | 0,8340 |
| m02_ex40_R2 | 0,9752 |
| m02_ex40_s | 0,21627 |
| m02_ex40_ep_b2 | 0,012925 |
| m02_ex40_t_b2 | 22,628 |
| m02_ex40_F | 512,03 |

> [!TIP]
> **Extras que costumam vir de brinde**
> Com as mesmas somas você já responde: $s^2=SQR/(n-2)=0{,}046775$; $\text{E.p.}(\hat\beta_2)=0{,}012925$; $t=22{,}63$ contra $t_{13;0,025}=2{,}160$, rejeitando $H_0:\beta_2=0$; $R^2=0{,}9752$; e o IC de 95% para $\beta_2$: $[0{,}2645;\,0{,}3204]$.

---

## Ligações

- Demonstrações completas: [02_teoria.md](02_teoria.md), D02.1 a D02.16.
- Núcleo escalar do caderno: [D3–D11](../demonstracoes/econometria-i-demonstracoes-mes-1-1.md).
- Versão matricial dos mesmos resultados: [módulo 03](../03_mqo_matricial/03_teoria.md).
- Erro de medição e endogeneidade: [módulo 10](../10_endogeneidade_iv/10_teoria.md).
