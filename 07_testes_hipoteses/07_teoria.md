---
title: "Módulo 07 — Testes de hipóteses (teoria)"
modulo: "07"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
greene: "cap. 5 (5.1–5.6, 5.8–5.9); 14.6"
slides: "SL07"
lista1: [41, 42, 44, 45, 46, 49, 50, 51, 52]
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
aliases:
  - Testes de hipóteses
---

# Módulo 07 — Testes de hipóteses (teoria)

## 0. Mapa

> [!NOTE]
> **O que é, por que importa, onde cai**
> Estimar dá um número; testar decide se aquele número é compatível com uma afirmação teórica. Este módulo constrói **uma única máquina** — a hipótese linear geral $R\beta=q$ — e mostra que o teste $t$, o $F$ global, o $F$ restrito, o Wald, o LM e o LR são casos particulares ou aproximações dela. Na P1, é o módulo da **Q1**: interpretar um output e decidir. Para escrever a resposta, use o [vocabulário de interpretação](../formulario/vocabulario_interpretacao.md).

Fio condutor: **distribuição do estimador → estatística de teste → regra de decisão → conclusão econômica**.

## 1. Notação, hipóteses e fatos de distribuição

Modelo $y=X\beta+\varepsilon$, com $X$ de posto $K$ (incluindo a constante), sob A1–A6.

### D07.1 · Os três fatos que sustentam o teste exato

> [!NOTE]
> **O que se quer provar**
> Sob A1–A6: (i) $b\mid X\sim N\big(\beta,\sigma^2(X'X)^{-1}\big)$; (ii) $\dfrac{(n-K)s^2}{\sigma^2}\sim\chi^2_{n-K}$; (iii) $b$ e $s^2$ são independentes.

**Por que importa.** Sem (i) não há estatística $t$; sem (ii) não há denominador; sem (iii) a razão não é $t$ nem $F$. É o alicerce da inferência **exata** em amostra finita — e o que cai por terra sem normalidade, justificando a rota assintótica do [módulo 08](../08_assintotica/08_teoria.md).

**Passo a passo.**

1. De $b=\beta+(X'X)^{-1}X'\varepsilon$, $b$ é combinação linear de $\varepsilon$. Sob A6, combinação linear de normal é normal *[A6]*. A média é $\beta$ *[A3]* e a variância $\sigma^2(X'X)^{-1}$ *[A4]*, o que dá (i).

2. Como $e=M\varepsilon$ com $M$ simétrica e idempotente de posto $n-K$,
$$\frac{e'e}{\sigma^2}=\frac{\varepsilon'M\varepsilon}{\sigma^2}=\left(\frac{\varepsilon}{\sigma}\right)'M\left(\frac{\varepsilon}{\sigma}\right)\sim\chi^2_{\operatorname{posto}(M)}=\chi^2_{n-K},$$
porque forma quadrática idempotente em normal padrão é qui-quadrado com graus de liberdade iguais ao posto. Isso é (ii), já que $s^2=e'e/(n-K)$.

3. $b-\beta=(X'X)^{-1}X'\varepsilon$ e $e=M\varepsilon$ são conjuntamente normais, e
$$\operatorname{Cov}\big[(X'X)^{-1}X'\varepsilon,\ M\varepsilon\mid X\big]=\sigma^2(X'X)^{-1}X'M=0,$$
pois $X'M=0$. Normais não correlacionadas são independentes, o que dá (iii). $\blacksquare$

> [!TIP]
> **Como o professor pode torcer**
> Pedir só a parte (ii) ("prove que $E[e'e]=\sigma^2(n-K)$", que é a versão sem normalidade, no [módulo 06](../06_amostra_finita_multicol/06_teoria.md)) ou perguntar **onde** a normalidade foi usada — resposta: só em (i) e no argumento de independência, nunca no não-viés nem em Gauss-Markov.

## 2. A hipótese linear geral e a estatística F

Qualquer conjunto de $J$ restrições lineares se escreve $H_0: R\beta=q$, com $R$ de dimensão $J\times K$ e posto $J$.

| Hipótese econômica | $R$ | $q$ |
|---|---|---|
| $\beta_k=0$ | linha com 1 na posição $k$ | 0 |
| todas as inclinações nulas | $[\,0 \mid I_{K-1}\,]$ | vetor nulo |
| $\beta_2+\beta_3=1$ (retornos constantes) | $[0\ 1\ 1\ 0\dots]$ | 1 |
| $\beta_2=\beta_3$ | $[0\ 1\ -1\ 0\dots]$ | 0 |

### D07.2 · A estatística F da hipótese linear geral

> [!NOTE]
> **O que se quer provar**
> Sob $H_0: R\beta=q$ e A1–A6,
> $$F=\frac{(Rb-q)'\big[R(X'X)^{-1}R'\big]^{-1}(Rb-q)/J}{s^2}\sim F_{J,\,n-K}.$$

**Passo a passo.**

1. Pela D07.1(i), $Rb\mid X\sim N\big(R\beta,\ \sigma^2R(X'X)^{-1}R'\big)$. Sob $H_0$, a média é $q$, logo o desvio $Rb-q$ tem média zero.

2. Padronizando a forma quadrática de um vetor normal com matriz de covariância $\Sigma=\sigma^2R(X'X)^{-1}R'$:
$$\frac{(Rb-q)'\big[R(X'X)^{-1}R'\big]^{-1}(Rb-q)}{\sigma^2}\sim\chi^2_J.$$

3. Pela D07.1(ii), $(n-K)s^2/\sigma^2\sim\chi^2_{n-K}$, e pela D07.1(iii) as duas variáveis são independentes.

4. A razão de duas qui-quadrado independentes, cada uma dividida pelos seus graus de liberdade, é $F$; o $\sigma^2$ cancela:
$$F=\frac{\chi^2_J/J}{\chi^2_{n-K}/(n-K)}\sim F_{J,\,n-K}. \qquad \blacksquare$$

### D07.3 · O teste t é o caso $J=1$, e $t^2=F$

Com $J=1$, $R$ é uma linha $r'$ e a forma quadrática vira um quadrado:
$$F=\frac{(r'b-q)^2}{s^2\,r'(X'X)^{-1}r}=\left(\frac{r'b-q}{\text{E.p.}(r'b)}\right)^2=t^2,$$
e de fato $t_{n-K}^2 = F_{1,\,n-K}$. Verificado numericamente: $t^2 = 3{,}44928$ e $F = 3{,}44928$.

### D07.4 · As três formas equivalentes do F

A partir de $e_*'e_*-e'e=(Rb-q)'[R(X'X)^{-1}R']^{-1}(Rb-q)$ (demonstrada no [módulo 05](../05_ajuste_restricoes/05_teoria.md)):

$$F=\underbrace{\frac{(Rb-q)'[R(X'X)^{-1}R']^{-1}(Rb-q)/J}{s^2}}_{\text{forma de Wald}}=\underbrace{\frac{(SQR_R-SQR_{IR})/J}{SQR_{IR}/(n-K)}}_{\text{duas somas de quadrados}}=\underbrace{\frac{(R^2_{IR}-R^2_R)/J}{(1-R^2_{IR})/(n-K)}}_{\text{via } R^2}$$

A terceira forma só vale se as duas regressões tiverem a **mesma variável dependente**. Caso particular com $H_0$ de todas as inclinações nulas: $R^2_R=0$ e $J=K-1$, o que dá o $F$ global $=\dfrac{R^2/(K-1)}{(1-R^2)/(n-K)}$.

Conferência: as três formas deram $F_1 = 3{,}44928$ para uma restrição e $F_2 = 5{,}49296$ para duas.

## 3. Tamanho, poder, p-valor e intervalos de confiança

- **Tamanho** ($\alpha$): probabilidade de rejeitar $H_0$ quando ela é verdadeira (erro tipo I). Você escolhe.
- **Poder**: probabilidade de rejeitar $H_0$ quando ela é falsa ($1-$ erro tipo II). Cresce com $n$, com $\lvert\beta-\beta^0\rvert$ e com a dispersão de $X$; cai com $\sigma^2$.
- **p-valor**: menor $\alpha$ que levaria à rejeição. Rejeita-se quando $p\lt\alpha$. Não é a probabilidade de $H_0$ ser verdadeira.
- **Intervalo de confiança**: $\hat\beta_k\pm t_{\alpha/2}\,\text{E.p.}(\hat\beta_k)$. É o conjunto dos $\beta_k^0$ que **não** seriam rejeitados — por isso "IC contém zero" e "não rejeita $H_0:\beta_k=0$" são a mesma frase.

Simulação (10 000 amostras, $n=20$, $\alpha=5\%$): o tamanho empírico ficou em 0,04825, colado no nominal; com $\beta_2$ a meio desvio-padrão do valor testado, o poder foi 0,394. Aumentando $n$, o poder sobe.

## 4. A trindade assintótica: Wald, LM e LR

### D07.5 · Três caminhos para a mesma pergunta

| | Wald | LM (escore) | LR |
|---|---|---|---|
| Ideia | a restrição está longe de ser satisfeita no irrestrito? | o gradiente ainda é grande no ponto restrito? | a verossimilhança cai muito ao impor a restrição? |
| Estimação | só irrestrito | só restrito | os dois |
| Estatística | $W=(Rb-q)'\big[R\,\widehat{\operatorname{Var}}(b)R'\big]^{-1}(Rb-q)$ | $LM=nR^2_{aux}$ | $LR=-2\ln\lambda=n\ln\dfrac{SQR_R}{SQR_{IR}}$ |
| Distribuição | $\chi^2_J$ | $\chi^2_J$ | $\chi^2_J$ |

No LM, a auxiliar regride os **resíduos do modelo restrito** em todos os regressores (os do restrito e os excluídos); sob $H_0$ esses resíduos não devem ser explicados pelo que ficou de fora.

No modelo linear normal vale a desigualdade $W\ge LR\ge LM$ (Greene): as três concordam assintoticamente, mas em amostra finita o Wald rejeita mais. Conferência numérica com os mesmos dados e $J=2$:

$$W = 11{,}94 \;\ge\; LR = 10{,}71 \;\ge\; LM = 9{,}64,$$

e $W=J\cdot F=2\times 5{,}49296=10{,}99$ na versão com $s^2$ (a diferença para 11,94 é o uso do estimador de máxima verossimilhança $e'e/n$ no lugar de $e'e/(n-K)$).

Simulação do tamanho empírico a 5%, mostrando que a ordem persiste em amostra pequena e some quando $n$ cresce:

| $n$ | Wald | LR | LM | F exato |
|---|---|---|---|---|
| 30 | 0,0938 | 0,0765 | 0,0538 | 0,0495 |
| 200 | 0,0555 | 0,0528 | 0,0500 | 0,0493 |

> [!WARNING]
> **Compare com a distribuição certa**
> Wald, LM e LR são **assintóticos**: valor crítico de $\chi^2_J$. O $F$ é exato sob normalidade. Usar $F$ tabelado para um $nR^2$ (ou vice-versa) é erro clássico.

## 5. Normalidade: Jarque-Bera

### D07.6 · A estatística JB

$$JB=n\left[\frac{S^2}{6}+\frac{(C-3)^2}{24}\right]\sim\chi^2_2,$$
com $S$ a assimetria e $C$ a curtose dos resíduos. Sob normalidade, $S=0$ e $C=3$, e cada termo padronizado tem variância assintótica $6/n$ e $24/n$ respectivamente — daí os denominadores. Dois graus de liberdade porque são duas restrições.

Onde isso importa: a inferência **exata** ($t$ e $F$) depende de A6. Com $n$ grande, o TLC entrega normalidade assintótica de $b$ e a inferência passa a usar $z$; foi o que a P1 2025/2 cobrou com $n=4165$.

Simulação com erro exponencial (não normal):

| $n$ | Tamanho do JB sob normalidade | Poder do JB contra exponencial | Tamanho do teste $t$ com erro exponencial |
|---|---|---|---|
| 20 | 0,0265 | 0,4298 | ver script |
| 1000 | 0,0505 | 1,0000 | ver script |

Ou seja: o JB só enxerga bem a não normalidade quando $n$ é grande — exatamente quando ela já não atrapalha a inferência. É o paradoxo que rende meio ponto na prova.

## 6. Especificação: omitir e incluir variáveis

### D07.7 · Omitir relevante vicia; incluir irrelevante infla a variância

**Omissão de variável relevante.** Com o verdadeiro $y=X_1\beta_1+X_2\beta_2+\varepsilon$ e a estimação só com $X_1$:
$$E[b_1\mid X]=\beta_1+(X_1'X_1)^{-1}X_1'X_2\beta_2,$$
viesado sempre que $\beta_2\neq 0$ e $X_1'X_2\neq 0$. Além disso $s^2$ fica **superestimado**, porque o que era sinal virou erro. Simulação: viés teórico 1,3257 contra 1,3249 simulado; $E[s^2]$ teórico 1,1129 contra 1,1133 simulado.

**Inclusão de variável irrelevante.** O estimador continua não viesado (média simulada 0,9992 para $\beta_1=1$), mas a variância aumenta pelo fator $1/(1-R^2_{13})$: com $R^2_{13}=0{,}5562$, a razão teórica é 2,2531 e a simulada 2,2254.

> [!IMPORTANT]
> **A troca**
> Omitir relevante: viés. Incluir irrelevante: variância. Por isso "excluir variável para curar multicolinearidade" pode piorar tudo — é o ex. 53 do [módulo 06](../06_amostra_finita_multicol/06_lista1.md).

## 7. RESET, LM para termos não lineares e modelos não aninhados

**RESET (Ramsey).** Passos:
1. Estime o modelo e guarde $\hat y$.
2. Estime a regressão aumentada $y=X\beta+\gamma_1\hat y^2+\gamma_2\hat y^3+u$.
3. Teste $H_0:\gamma_1=\gamma_2=0$ por $F$.
4. Rejeitar indica **má especificação** — forma funcional errada ou variável omitida. Não rejeitar não prova que o modelo está certo.

As potências de $\hat y$ funcionam como aproximação de Taylor de qualquer não linearidade omitida.

**LM para termos não lineares.** É o ex. 52: estima-se o modelo restrito, regridem-se os resíduos em todos os candidatos ($X$, $X^2$, $X^3$) e compara-se $nR^2$ com $\chi^2_J$.

**Não aninhados.** Quando os modelos não são caso particular um do outro (por exemplo $y$ em $X$ contra $y$ em $Z$), não há restrição a testar. Usa-se o teste J de Davidson-MacKinnon (inclui o ajustado do rival como regressor e testa seu coeficiente) ou comparação por AIC/SC.

Exemplo verificado: modelo quadrático verdadeiro estimado como linear — o RESET detecta, com $F=$ `m07b_ex51_reset_F` e p-valor `m07b_ex51_reset_p` (ver [07_lista1.md](07_lista1.md), ex. 51).

## 8. Testes de diagnóstico

Todos seguem o mesmo padrão: **regressão auxiliar + $nR^2$ comparado com $\chi^2$**.

| Teste | Auxiliar | Estatística | Distribuição |
|---|---|---|---|
| White | $\hat u^2$ em $X$, $X^2$ e produtos cruzados | $nR^2$ | $\chi^2_{gl\ da\ auxiliar}$ |
| Breusch-Pagan | $\hat u^2$ em $X$ | $nR^2$ | $\chi^2_{K-1}$ |
| Breusch-Godfrey | $\hat u_t$ em $X$ e $\hat u_{t-1},\dots,\hat u_{t-p}$ | $nR^2$ | $\chi^2_p$ |
| Durbin-Watson | — | $d\approx 2(1-\hat\rho_1)$ | tabela $d_L$, $d_U$ |

Conferência: as versões calculadas à mão batem com as do pacote `lmtest` — BP 23,7936; White 26,8631; BG 94,9987; DW 0,6257, com $2(1-\hat\rho_1)=0{,}6273$ e $\hat\rho_1=0{,}6863$.

A leitura de cada um está no [vocabulário](../formulario/vocabulario_interpretacao.md). O tratamento (MQG, MQP, erros-padrão robustos) é matéria da P2, [módulo 11](../11_mqg_heterosk_autocorr/README.md).

## 9. Leitura rápida de outputs

| Campo do output | O que é |
|---|---|
| Coefficient / Coeficiente | $\hat\beta_k$ |
| Std. Error / Erro padrão | $\sqrt{s^2[(X'X)^{-1}]_{kk}}$ |
| t-Statistic ou b/E.p. | $\hat\beta_k/\text{E.p.}$ |
| Prob. / P[\|Z\|>z] | p-valor bilateral |
| R-squared | $1-SQR/SQT$ |
| Adjusted R-squared | $1-\frac{n-1}{n-K}(1-R^2)$ |
| S.E. of regression | $s=\sqrt{SQR/(n-K)}$ |
| Sum squared resid | $SQR=e'e$ |
| Log likelihood | $-\frac n2[1+\ln 2\pi+\ln(e'e/n)]$ |
| F-statistic | $F$ global (todas as inclinações) |
| Prob(F-statistic) | p-valor do $F$ global |
| Durbin-Watson stat | $d$ |
| Mean dependent var | $\bar y$ |
| S.D. dependent var | $\sqrt{SQT/(n-1)}$ |

Com esses campos você reconstrói o que faltar: $SQT=SQR/(1-R^2)$, $SQE=SQT-SQR$, $n$ a partir dos graus de liberdade, e o $F$ a partir do $R^2$.

> [!TIP]
> **O formato NLOGIT da prova**
> A P1 2025/2 usou a saída do NLOGIT, com as colunas `Coeficientes | Erro padrão | b/E.p. | P[|Z|>z] | Média de X`. A coluna "Média de X" serve para calcular elasticidades e o efeito no ponto médio. Reproduza o formato com `saida_nlogit()` em [R/saida_nlogit.R](../R/saida_nlogit.R).

## 10. Conferência numérica

| chave_R | nota |
|---|---|
| m07b_t4_t2 | 3,44928 |
| m07b_t4_F1_ssr | 3,44928 |
| m07b_t4_F1_wald | 3,44928 |
| m07b_t4_F2 | 5,49296 |
| m07b_t4_JF | 10,9859 |
| m07b_t4_W_ml | 11,9412 |
| m07b_t4_LR_formula | 10,7081 |
| m07b_t4_LM_nR2 | 9,63916 |
| m07b_t4_bp_manual | 23,7936 |
| m07b_t4_white_manual | 26,8631 |
| m07b_t4_bg_manual | 94,9987 |
| m07b_t4_dw | 0,62573 |
| m07b_t4_r1 | 0,68635 |
| m07b_t5_omit_b1_teo | 1,32566 |
| m07b_t5_omit_b1_sim | 1,32490 |
| m07b_t5_irrel_razao_var_teo | 2,2531 |
| m07b_qchisq_95_2 | 5,99146 |
| m07b_qnorm_975 | 1,95996 |

## 11. Armadilhas e checklist

> [!WARNING]
> **As cinco que mais custam ponto**
> 1. Usar valor crítico de $F$ para estatística $\chi^2$ (ou o contrário) nos testes LM e Wald.
> 2. Esquecer que $SQR_R\ge SQR_{IR}$: diferença negativa significa modelos trocados.
> 3. Ler o RESET ao contrário: rejeitar $H_0$ é que indica má especificação.
> 4. Dizer que "não rejeitar $H_0$ prova que $H_0$ é verdadeira". Não prova: só não há evidência contra.
> 5. Comparar $R^2$ de modelos com dependentes diferentes ($y$ e $\ln y$).

- [ ] Derivo a estatística $F$ da hipótese linear geral (D07.2) em até 10 min.
- [ ] Mostro $t^2=F$ e escrevo as três formas do $F$ (D07.3, D07.4).
- [ ] Explico Wald, LM e LR: o que cada um estima e por que $W\ge LR\ge LM$.
- [ ] Monto $R$ e $q$ para qualquer restrição que o enunciado descrever em palavras.
- [ ] Preencho um quadro de ANOVA a partir de $R^2$, $SQR$ e $n$.
- [ ] Escrevo as quatro linhas (hipóteses, estatística, decisão, conclusão) para os treze testes do vocabulário.

## 12. Referências

- Greene, *Econometric Analysis*, cap. 5 (hipótese linear geral, F, Wald, LM, LR) e §14.6 (a trindade sob máxima verossimilhança).
- Slides SL07, especialmente as seções de hipótese linear geral, testes baseados em ajuste e testes de normalidade.
- Exercícios resolvidos: [07_lista1.md](07_lista1.md) (interpretação) e [07_lista1_computacional.md](07_lista1_computacional.md) (ex. 38, 39 e 74).
- Base assintótica: [módulo 08](../08_assintotica/08_teoria.md).
