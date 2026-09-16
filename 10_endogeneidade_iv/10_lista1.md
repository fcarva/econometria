---
title: "Módulo 10 — Lista 1 resolvida (ex. 65–70)"
modulo: "10"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
greene: "cap. 8"
slides: "SL10"
lista1: [65, 66, 67, 68, 69, 70]
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
  - vi
aliases:
  - Endogeneidade — Lista 1
---

# Módulo 10 — Lista 1 resolvida (ex. 65–70)

Estes seis exercícios são a fonte direta das questões Q2, Q4 e Q6 da P1 2025/2. As demonstrações estão em [10_teoria.md](10_teoria.md) (D10.1 a D10.6); os números saem de [10_endogeneidade_iv.R](10_endogeneidade_iv.R).

---

## Ex. 65 — Derivar o estimador de variáveis instrumentais

**Tipo:** derivação · **Chave:** ➖ · **Cai como:** Q6 da P1 2025/2, quase palavra por palavra

**O que se pede.** No modelo $y=X\beta+\varepsilon$ com endogeneidade ($E[\varepsilon\mid X]=\eta\neq 0$), com $L=K$ instrumentos em $Z$ e todos os momentos finitos, usar $\operatorname{plim}(Z'\varepsilon/n)=0$ para obter $\hat\beta_{IV}$.

**Passo a passo.**

1. Parta da condição que **define** o instrumento (exogeneidade):
$$\operatorname{plim}\frac{Z'\varepsilon}{n}=0.$$

2. Substitua $\varepsilon=y-X\beta$:
$$\operatorname{plim}\frac{Z'(y-X\beta)}{n}=0.$$

3. Distribua:
$$\operatorname{plim}\frac{Z'y}{n}-\left(\operatorname{plim}\frac{Z'X}{n}\right)\beta=0.$$

4. A relevância garante que $\operatorname{plim}(Z'X/n)=Q_{ZX}$ é não singular, então
$$\beta=\left[\operatorname{plim}\frac{Z'X}{n}\right]^{-1}\operatorname{plim}\frac{Z'y}{n}.$$

5. O análogo amostral (trocar plim por médias amostrais; os $n$ cancelam) é o estimador:
$$\boxed{\hat\beta_{IV}=(Z'X)^{-1}Z'y.}\qquad\blacksquare$$

> [!TIP]
> **Como escrever na prova**
> Cinco linhas, começando pela condição de exogeneidade e terminando no análogo amostral. Feche com duas observações que valem ponto: tem a mesma forma do MQO com $Z$ no lugar do primeiro $X$; e se $Z=X$ (nenhuma endogeneidade), o VI **colapsa no MQO**.

## Ex. 66 — VI, MQ2E e GMM: motivação, estimação, inferência e aplicações

**Tipo:** dissertativa · **Chave:** ➖ · **Cai como:** questão aberta de uma página

**Motivação.** Quando $\operatorname{plim}(X'\varepsilon/n)=\gamma\neq 0$, o MQO é **inconsistente**: $\operatorname{plim}b=\beta+Q^{-1}\gamma$ (D10.1). As três causas clássicas são variável omitida correlacionada, erro de medição no regressor e simultaneidade. Nenhuma se resolve com mais dados: o viés não some quando $n$ cresce.

**Comparação.**

| | MQO | VI ($L=K$) | MQ2E ($L\ge K$) | GMM |
|---|---|---|---|---|
| Consistente sob endogeneidade | não | sim | sim | sim |
| Eficiente sob A4 (erros esféricos) | sim (MELNV) | não | não | — |
| Usa quantos instrumentos | — | exatamente $K$ | todos, via projeção | todos, com matriz de pesos ótima |
| Permite testar validade | — | não | sim (Sargan) | sim (J de Hansen) |
| Eficiente sob heterocedasticidade | não | não | não | sim (GMM com pesos ótimos) |

**Estimação.** $\hat\beta_{IV}=(Z'X)^{-1}Z'y$; $\hat\beta_{MQ2E}=[X'Z(Z'Z)^{-1}Z'X]^{-1}X'Z(Z'Z)^{-1}Z'y=(\hat X'\hat X)^{-1}\hat X'y$, com $\hat X=P_ZX$. O GMM minimiza $\bar g(\beta)'W\bar g(\beta)$ com $\bar g(\beta)=Z'(y-X\beta)/n$; com $W=(Z'Z)^{-1}$ recupera-se o MQ2E, e com $W$ igual à inversa da matriz de covariância dos momentos obtém-se o GMM eficiente.

**Inferência.** Todos são assintóticos: erros-padrão da matriz de covariância assintótica, testes com $z$ e $\chi^2$. Três checagens obrigatórias: relevância (F do 1º estágio), endogeneidade (Wu-Hausman) e validade (Sargan/Hansen, só com sobreidentificação).

**Aplicações em economia.** Retornos da escolaridade instrumentados por proximidade de faculdade ou escolaridade dos pais; demanda instrumentada por deslocadores de oferta (impostos, custo); avaliação de política com elegibilidade como instrumento; equações de oferta e demanda em sistemas simultâneos.

## Ex. 67 — Output do `ivreg`: instrumentos fracos, Wu-Hausman e Sargan a 10%

**Tipo:** interpretação de output · **Chave:** ⏳ · **Cai como:** Q2 da P1 2025/2

Demanda por cigarros, 48 estados, 1995 (`AER::CigarettesSW`): $\log(\text{packs})$ em $\log(\text{preço})$ e $\log(\text{renda})$, instrumentando o preço com a diferença de impostos e o imposto real. Reproduzido integralmente no script; os diagnósticos batem com os da lista.

**(a) Instrumentos fracos.**

```text
Hipóteses:   H0: instrumentos fracos   vs   H1: instrumentos fortes
Estatística: F = 228,738 (1º estágio, 2 e 44 gl), p = 0,0000
Decisão:     p = 0,0000 < 0,10  ⇒  rejeita-se H0
Conclusão:   os instrumentos são relevantes; muito acima da regra prática F > 10, não há problema de instrumento fraco.
```

**(b) MQO ou MQ2E?**

```text
Hipóteses:   H0: preço exógeno (MQO consistente e eficiente)   vs   H1: preço endógeno (só VI consistente)
Estatística: Wu-Hausman F = 3,823 (1 e 44 gl), p = 0,0569
Decisão:     p = 0,0569 < 0,10  ⇒  rejeita-se H0
Conclusão:   há evidência de endogeneidade do preço; o método consistente é o MQ2E.
```

> [!CAUTION]
> **O α decide, e a prova troca o p-valor**
> A 5% este mesmo teste **não** rejeitaria ($0{,}0569 \gt 0{,}05$) e a resposta seria "fique com o MQO". Na versão da P1 2025/2 o p-valor impresso é 0,0469, que rejeita a 5%. Responda sempre pelo número do **seu** enunciado. Sem erros-padrão robustos o teste dá $F=3{,}068$ com $p=0{,}0868$ — outra fronteira perigosa.

**(c) Os instrumentos são válidos? Valeu usar MQ2E?**

```text
Hipóteses:   H0: instrumentos válidos (exógenos)   vs   H1: ao menos um inválido
Estatística: Sargan = 0,333 (χ² com 1 gl)
Decisão:     p = 0,5641 > 0,10  ⇒  não se rejeita H0
Conclusão:   não há evidência contra a validade dos instrumentos.
```

O teste só existe porque há **sobreidentificação**: $L=4$ instrumentos (incluindo os exógenos do modelo) para $K=3$ parâmetros, logo $L-K=1$ grau de liberdade. Com um único instrumento (caso exatamente identificado) não haveria teste nenhum — é essa a vantagem do MQ2E sobre o VI simples aqui.

**(d) Leitura do coeficiente.** $\hat\beta_{\log preço}=-1{,}2774$: modelo log-log, então é **elasticidade-preço** — 1% de aumento no preço reduz o consumo em cerca de 1,28%, demanda elástica. Compare com o MQO, $-1{,}4065$: ignorar a endogeneidade **exagera** a sensibilidade ao preço.

**Conferência numérica**

| chave_R | nota |
|---|---|
| m10_ex67_b_preco | -1,27742 |
| m10_ex67_ep_preco_rob | 0,241684 |
| m10_ex67_fraco_F_rob | 228,738 |
| m10_ex67_wu_F_rob | 3,8235 |
| m10_ex67_wu_p_rob | 0,05691 |
| m10_ex67_sargan | 0,33262 |
| m10_ex67_sargan_p | 0,56412 |
| m10_ex67_fraco_F_hom | 244,734 |
| m10_ex67_wu_p_hom | 0,08683 |
| m10_ex67_ols_b_preco | -1,40650 |
| m10_ex67_r2 | 0,42942 |
| m10_ex67_wald_rob | 34,506 |

## Ex. 68 — Erro de medição no regressor

**Tipo:** derivação · **Chave:** ➖ · **Cai como:** Q4 da P1 2025/2 (a versão "malvada")

**O que se pede.** Com o modelo verdadeiro $Y_i=\alpha+\beta X_i^*+\mu_i$ e o regressor observado com erro, $X_i=X_i^*+w_i$, o modelo estimável vira
$$Y_i=\alpha+\beta X_i+z_i,\qquad z_i=\mu_i-\beta w_i.$$
Provar, via $\operatorname{Cov}(z_i,X_i)$, que o MQO é viesado e inconsistente.

**Passo a passo.**

1. O regressor observado está correlacionado com o novo erro:
$$\operatorname{Cov}(z_i,X_i)=\operatorname{Cov}(\mu_i-\beta w_i,\ X_i^*+w_i)=-\beta\operatorname{Var}(w_i)=-\beta\sigma_w^2\neq 0,$$
usando $\operatorname{Cov}(\mu,X^*)=0$, $\operatorname{Cov}(\mu,w)=0$ e $\operatorname{Cov}(X^*,w)=0$.

2. Viola-se a exogeneidade: o MQO é **viesado** em amostra finita e **inconsistente** no limite.

3. O tamanho da inconsistência sai do plim do estimador:
$$\operatorname{plim}\hat\beta=\beta+\frac{\operatorname{Cov}(z,X)}{\operatorname{Var}(X)}=\beta-\frac{\beta\sigma_w^2}{\sigma_{X^*}^2+\sigma_w^2}=\beta\underbrace{\frac{\sigma_{X^*}^2}{\sigma_{X^*}^2+\sigma_w^2}}_{\lambda\,\in\,(0,1)}.$$

4. Como $0\lt\lambda\lt 1$, $\lvert\operatorname{plim}\hat\beta\rvert\lt\lvert\beta\rvert$: é o **viés de atenuação**, sempre em direção a zero. O intercepto absorve a diferença: $\operatorname{plim}\hat\alpha=\alpha+\beta(1-\lambda)E[X^*]$. $\blacksquare$

**Verificação por simulação.** Com $\beta=1$, $\sigma^2_{X^*}=2$ e $\sigma_w^2=1$, o fator teórico é $\lambda=2/3$:

| $n$ | média de $\hat\beta$ |
|---|---|
| 50 | 0,6673 |
| 500 | 0,6680 |
| 5000 | 0,6668 |

Não converge para 1: aumentar a amostra não cura inconsistência. A solução é VI — um instrumento correlacionado com $X^*$ e não com $w$ (por exemplo, uma segunda medida independente da mesma variável).

**Conferência numérica**

| chave_R | nota |
|---|---|
| m10_ex68_lambda | 0,666667 |
| m10_ex68_plim_b | 0,666667 |
| m10_ex68_media_b_n5000 | 0,666831 |
| m10_ex68_cov_zx_teo | -0,5 |
| m10_ex68_cov_zx | -0,495347 |

## Ex. 69 — Simultaneidade no modelo keynesiano

**Tipo:** derivação · **Chave:** ➖ · **Cai como:** Q4 ou Q6

**O que se pede.** Com $C_t=\beta_0+\beta_1Y_t+\mu_t$ (função consumo) e $Y_t=C_t+I_t$ (identidade), provar que $\hat\beta_1$ é inconsistente.

**Passo a passo.**

1. Resolva o sistema para a **forma reduzida**: substituindo o consumo na identidade,
$$Y_t=\frac{\beta_0+I_t+\mu_t}{1-\beta_1}.$$
A renda é função do erro: o regressor é endógeno por construção.

2. Calcule a covariância entre regressor e erro:
$$\operatorname{Cov}(Y_t,\mu_t)=\frac{\operatorname{Var}(\mu_t)}{1-\beta_1}=\frac{\sigma^2_\mu}{1-\beta_1}\ \gt 0 .$$

3. E a variância do regressor, com $\operatorname{Cov}(I,\mu)=0$:
$$\operatorname{Var}(Y_t)=\frac{\sigma^2_I+\sigma^2_\mu}{(1-\beta_1)^2}.$$

4. Junte no plim do estimador de inclinação:
$$\operatorname{plim}\hat\beta_1=\beta_1+\frac{\operatorname{Cov}(Y,\mu)}{\operatorname{Var}(Y)}=\beta_1+\frac{(1-\beta_1)\,\sigma^2_\mu}{\sigma^2_I+\sigma^2_\mu}\ \gt\ \beta_1 .$$

5. Como $0\lt\beta_1\lt 1$, a inconsistência é **positiva**: o MQO **superestima** a propensão marginal a consumir. $\blacksquare$

**Verificação.** Com $\beta_1=0{,}8$, $\sigma^2_\mu=20$ e $\sigma^2_I=180$ (de modo que $\operatorname{Cov}(Y,\mu)=20$ e $\operatorname{Var}(Y)=200$), a fórmula dá $\operatorname{plim}\hat\beta_1=0{,}9$, inconsistência de $0{,}1$:

| $n$ | média do MQO | mediana do VI (instrumento: $I_t$) |
|---|---|---|
| 50 | 0,8997 | 0,7996 |
| 5000 | 0,9000 | 0,8000 |

O investimento é o instrumento natural: entra na identidade, é correlacionado com a renda e não com o erro da função consumo.

**Conferência numérica**

| chave_R | nota |
|---|---|
| m10_ex69_plim_ols | 0,9 |
| m10_ex69_inconsist | 0,1 |
| m10_ex69_media_ols_n5000 | 0,899966 |
| m10_ex69_mediana_vi_n5000 | 0,799994 |

## Ex. 70 — Erro de medição na variável dependente

**Tipo:** derivação · **Chave:** ➖ · **Cai como:** Q4 da P1 2025/2 (caiu exatamente assim)

**(a) O estimador é viesado?** Não. Com $Y_i=Y_i^*+\varepsilon_i$, o modelo estimável é $Y_i=\alpha+\beta X_i+v_i$, $v_i=\mu_i+\varepsilon_i$. Como $E[v_i\mid X]=0$ e $\operatorname{Cov}(X,v)=0$, vale a rota padrão do não-viés:
$$\hat\beta=\beta+\sum_i k_iv_i\ \Longrightarrow\ E[\hat\beta\mid X]=\beta+\sum_i k_i\underbrace{E[v_i\mid X]}_{=0}=\beta.$$

**(b) A variância.** Com $\operatorname{Cov}(\mu,\varepsilon)=0$, $\operatorname{Var}(v_i)=\sigma^2_\mu+\sigma^2_\varepsilon$, e
$$\operatorname{Var}(\hat\beta\mid X)=\frac{\sigma_\mu^2+\sigma_\varepsilon^2}{\sum_i(X_i-\bar X)^2}\ \gt\ \frac{\sigma_\mu^2}{\sum_i(X_i-\bar X)^2}=\operatorname{Var}(\hat\beta^*\mid X).$$

**Conclusão.** Erro de medição na **dependente** não vicia: só engorda o erro e **infla a variância**, reduzindo a precisão. Já o erro no **regressor** (ex. 68) vicia e é inconsistente. É esse contraste que o professor cobra.

> [!IMPORTANT]
> **A frase que fecha a questão**
> "Erro de medição em $Y$ preserva $E[v\mid X]=0$, então o MQO continua não viesado, mas com variância maior. Erro de medição em $X$ quebra a exogeneidade e produz atenuação: viés **e** inconsistência."

Detalhes e a versão com erro correlacionado com $X$: D10.3 em [10_teoria.md](10_teoria.md); a versão da prova está em [provas/p1_2025_2](../provas/p1_2025_2/econometria-i-prova-2025-2-resolvida.md), Q4.
