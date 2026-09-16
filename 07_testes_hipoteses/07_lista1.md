---
title: "Módulo 07 — Lista 1 resolvida (ex. 41–46 e 49–52)"
modulo: "07"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
greene: "cap. 5"
slides: "SL07"
lista1: [41, 42, 44, 45, 46, 49, 50, 51, 52]
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
  - Testes — Lista 1
---

# Módulo 07 — Lista 1 resolvida (interpretação de output)

Estes exercícios são o treino direto da Q1 da prova. O padrão de resposta está em [vocabulario_interpretacao.md](../formulario/vocabulario_interpretacao.md); a teoria, em [07_teoria.md](07_teoria.md). Os exercícios computacionais 38, 39 e 74 estão em [07_lista1_computacional.md](07_lista1_computacional.md).

---

## Ex. 41 — PIB e investimento público

**Tipo:** interpretação · **Chave:** ⏳ · **Cai como:** Q1

Regressão com 27 observações (estados, 2010): constante $-27{,}23964$ (E.p. 9,805189) e INVESTIMENTO $107{,}7422$ (E.p. 9,581670), com $R^2=0{,}834920$.

**(a) Sinais.** $\hat\beta_2=107{,}74 \gt 0$: mais investimento, mais PIB — coerente com a teoria. O intercepto negativo ($-27{,}24$) não tem leitura econômica direta (PIB negativo com investimento zero é extrapolação fora do domínio dos dados); é apenas a âncora da reta.

**(b) $R^2$.** 83,49% da variação do PIB estadual é explicada pela variação do investimento público.

**(c) $R^2$ e coeficiente de correlação.** $R^2$ mede a fração da variação explicada e vai de 0 a 1; $r$ mede associação **linear** e vai de $-1$ a 1, carregando o sinal. Na regressão simples, $R^2=r^2$: aqui $r=\sqrt{0{,}834920}=0{,}9137$, positivo porque a inclinação é positiva.

**(d) "Incluir variável aumenta o $R^2$".** Correto, e é um defeito: o $R^2$ **nunca cai** ao acrescentar regressor, mesmo irrelevante, porque a soma de quadrados dos resíduos só pode diminuir. Por isso se usa o $\bar R^2$, que penaliza graus de liberdade.

**(e) Investimento sobe R\$ 2 bilhões.** $\Delta \widehat{PIB}=107{,}7422\times 2=215{,}48$ bilhões.

**(f) Outros fatores.** Sim — capital humano, infraestrutura, estrutura produtiva. Eles estão no termo de erro. Se forem **perfeitamente correlacionados** com o investimento, há multicolinearidade perfeita e os parâmetros não são identificáveis; se forem apenas correlacionados e ficarem de fora, o MQO é **viesado** por omissão de variável relevante (ex. 15).

**Conferência numérica**

| chave_R | nota |
|---|---|
| m07b_ex41_t2 | 11,2446 |
| m07b_ex41_F | 126,441 |
| m07b_ex41_r | 0,913740 |
| m07b_ex41_r2_via_t | 0,834920 |
| m07b_ex41_dpib_2 | 215,4844 |

## Ex. 42 — Intervalo de confiança e teste t (dados do ex. 41)

**Tipo:** interpretação · **Chave:** ⏳

**(a) IC de 95%.** Com $t_{25;0,025}=2{,}0595$:
$$IC=\big[107{,}7422\pm 2{,}0595\times 9{,}58167\big]=[88{,}0084;\ 127{,}4760].$$
Em 95 de cada 100 amostras, intervalos assim conteriam o verdadeiro $\beta_2$. (Se o enunciado mandar usar $z=1{,}96$, sai $[88{,}9625;\ 126{,}5219]$ — diga qual valor crítico usou.)

**(b) Teste t.**

```text
Hipóteses:   H0: β2 = 0   vs   H1: β2 ≠ 0
Estatística: t = 107,7422 / 9,58167 = 11,2446  (t com 25 gl)
Decisão:     |11,2446| > 2,0595   (p = 0,0000 < 0,05)   ⇒   rejeita-se H0
Conclusão:   o investimento público tem efeito estatisticamente significativo sobre o PIB estadual.
```

O IC não contém zero — é a mesma conclusão, por outro caminho.

**Conferência numérica**

| chave_R | nota |
|---|---|
| m07b_ex42_ic_lo | 88,0084 |
| m07b_ex42_ic_hi | 127,4760 |
| m07b_ex42_ic_z_lo | 88,9625 |
| m07b_ex42_ic_z_hi | 126,5219 |

## Ex. 44 — Função de custo total

**Tipo:** interpretação · **Chave:** ⏳

Output: constante 791,0120 (E.p. 225,7354), QUANTIDADE 11,06105 (E.p. 2,160396); $R^2=0{,}867609$, $\bar R^2=0{,}834511$, S.E. 118,1225, $SQR=55\,811{,}69$, $F=26{,}21$, média da dependente 2389,333, DW 3,072.

**(a) Elasticidade custo no ponto médio.** Dos graus de liberdade implícitos ($\bar R^2$ e $R^2$ dão $n-K=4$, logo $n=6$) e da média do custo (2389,333), a quantidade média implícita é $\bar Q=144{,}50$:
$$\hat\eta=\hat\beta_2\frac{\bar Q}{\overline{CT}}=11{,}06105\times\frac{144{,}50}{2389{,}333}=0{,}6689 .$$
Elasticidade menor que 1: o custo cresce **menos que proporcionalmente** à produção — economias de escala no ponto médio.

**(b) Testes com $t_{tab}=2{,}776$ ($\alpha=5\%$, 4 gl).** Constante: $t=791{,}0120/225{,}7354=3{,}504\gt 2{,}776$ ⇒ significativa. Quantidade: $t=11{,}06105/2{,}160396=5{,}120\gt 2{,}776$ ⇒ significativa. (Hipóteses: $H_0:\beta_j=0$ contra $H_1:\beta_j\neq 0$.)

**(c) Poderia usar $F$?** Sim: na regressão simples, $F=t^2$. Aqui $t^2=26{,}214$, que é o próprio $F$ do output (26,21), e $F_{crit}=t_{crit}^2=7{,}706$. As duas rotas dão a mesma decisão.

**(d) IC para a inclinação.** $[11{,}06105\pm 2{,}776\times 2{,}160396]=[5{,}0638;\ 17{,}0583]$.

**(e) Jarque-Bera com $JB=1{,}53$ e $\chi^2_{tab}=2{,}54$.**

```text
Hipóteses:   H0: resíduos normais   vs   H1: não normais
Decisão:     1,53 < 2,54   ⇒   não se rejeita H0
Conclusão:   não há evidência contra a normalidade; a inferência exata (t e F) está justificada,
             o que é importante aqui porque n = 6 é minúsculo.
```

**Conferência numérica**

| chave_R | nota |
|---|---|
| m07b_ex44_n_impl | 6 |
| m07b_ex44_qbar | 144,500 |
| m07b_ex44_elast | 0,66894 |
| m07b_ex44_t1 | 3,5042 |
| m07b_ex44_t2 | 5,1199 |
| m07b_ex44_F_t2 | 26,214 |
| m07b_ex44_Fcrit_tc2 | 7,7062 |
| m07b_ex44_ic_lo | 5,0638 |
| m07b_ex44_ic_hi | 17,0583 |
| m07b_ex44_sqt_r2 | 421567,1 |

## Ex. 45 — Custo em log: tendência e elasticidade

**Tipo:** interpretação · **Chave:** ✅ confere

**(a) $\ln(CT)=68{,}72+0{,}056\,Ano$, com o antilog já aplicado ao intercepto.** O coeficiente do tempo é **semi-elasticidade**: o custo total cresce cerca de **5,6% ao ano** (exato: $100(e^{0{,}056}-1)=5{,}76\%$). O intercepto, já em nível, é R\$ 68,72 no ano zero da contagem. Com $t=0{,}056/0{,}003=18{,}67$, a tendência é fortemente significativa. A esse ritmo, o custo dobra em $\ln 2/0{,}056\approx 12{,}4$ anos.

**(b) $\ln(CT)=0{,}857+0{,}246\ln(Q)$.** Agora é **elasticidade** custo-produção: 1% a mais de quantidade eleva o custo em 0,246%. Bem menor que 1, indicando fortes economias de escala (10% a mais de produção elevam o custo em cerca de 2,37%).

**Conferência numérica**

| chave_R | nota |
|---|---|
| m07b_ex45_pct_exato | 5,7598 |
| m07b_ex45_t_ano | 18,667 |
| m07b_ex45_anos_dobrar | 12,378 |
| m07b_ex45b_pct10 | 2,3723 |

## Ex. 46 — PIB e crédito nos municípios capixabas

**Tipo:** interpretação · **Chave:** ⚠️ diverge (item f) · **Cai como:** Q1 completa

Modelo log-log com 78 municípios: constante 4,664838 (E.p. 0,702390), LOG(CRED) 0,727858 (E.p. 0,069224); $R^2=0{,}633353$, $\bar R^2=0{,}627624$, S.E. 0,767296, $SQR=37{,}67959$, $F=110{,}555$.

**(a) Interpretação.** Elasticidade: 1% a mais de crédito associa-se a 0,728% a mais de PIB municipal. O intercepto, em nível, é $e^{4{,}664838}=106{,}15$ (o valor do PIB quando o crédito é 1, em R\$ 1,00 — extrapolação sem sentido econômico prático).

**(b) Coerência teórica.** Sim: crédito financia investimento e capital de giro, então mais crédito tende a acompanhar mais produto. Cuidado com causalidade reversa (municípios maiores atraem mais crédito) — é um caso de endogeneidade por simultaneidade ([módulo 10](../10_endogeneidade_iv/10_teoria.md)).

**(c) Significância ($z=1{,}96$).** $t=0{,}727858/0{,}069224=10{,}515\gt 1{,}96$ ⇒ rejeita-se $H_0:\beta_2=0$.

**(d) IC de 95%.** $[0{,}727858\pm 1{,}96\times 0{,}069224]=[0{,}5922;\ 0{,}8635]$. Note que o intervalo exclui 1: a elasticidade é significativamente **menor que um**.

**(e) $R^2$ e a inclusão de variáveis.** 63,3% da variação do log do PIB explicada. Pela fórmula $R^2=1-SQR/SQT$: incluir regressor nunca aumenta $SQR$, então o $R^2$ nunca cai — cresce ou fica igual.

**(f) Jarque-Bera.**

```text
Hipóteses:   H0: resíduos normais   vs   H1: não normais
Estatística: JB = 18,8707 (valor do enunciado da lista)  ~ χ²(2)
Decisão:     18,8707 > 9,21 = χ² crítico a 1%   ⇒   rejeita-se H0
Conclusão:   há evidência de não normalidade dos resíduos.
```

> [!CAUTION]
> **Divergência entre lista e chave**
> A lista imprime $JB=18{,}870682$ e a chave, $10{,}48190$. Os dois superam o crítico de 1% (9,21), então a **decisão não muda**. Recalculando o JB a partir da assimetria ($-0{,}883473$) e da curtose (3,321874) informadas no próprio gráfico do enunciado, com $n=78$, obtém-se 10,4835 — ou seja, o número da **chave** é o consistente com as estatísticas descritivas, e o da lista não. Responda com o número que o **seu** enunciado imprimir e registre a conta. Ver [errata](../formulario/errata_chave_lista1.md).

**(g) Quadro de ANOVA e teste F.** $SQT=SQR/(1-R^2)=102{,}768$, $SQE=65{,}0884$, $QM_{res}=0{,}495784$:

| Variação | gl | Soma de quadrados | Quadrado médio | $F$ |
|---|---|---|---|---|
| Regressão | 1 | 65,0884 | 65,0884 | 131,28 |
| Resíduos | 76 | 37,6796 | 0,4958 | |
| Total | 77 | 102,7680 | | |

Com $F_{tab}=3{,}96$: rejeita-se $H_0$. (O $F$ do output, 110,555, foi calculado com o $R^2$ arredondado; reconstruído a partir das somas de quadrados dá 131,28 — cite a sua conta.)

**(h) Elasticidade do modelo linear.** Com $\widehat{PIB}=15{.}000{.}000+25\,CRED$ avaliado em $CRED=1{.}000{.}000$: $\widehat{PIB}=40$ milhões e
$$\hat\eta=25\times\frac{1{.}000{.}000}{40{.}000{.}000}=0{,}625 .$$
No modelo linear a elasticidade **muda em cada ponto**; no log-log é constante (0,728).

**Conferência numérica**

| chave_R | nota |
|---|---|
| m07b_ex46_exp_b1 | 106,148 |
| m07b_ex46_t2 | 10,5145 |
| m07b_ex46_ic_lo | 0,59218 |
| m07b_ex46_ic_hi | 0,86354 |
| m07b_ex46_jb_sk | 10,4835 |
| m07b_ex46_sqt | 102,768 |
| m07b_ex46_sqe | 65,0884 |
| m07b_ex46_qmres | 0,495784 |
| m07b_ex46_F_anova | 131,284 |
| m07b_ex46h_elast | 0,625 |

## Ex. 49 — Modelo mal especificado e os passos do RESET

**Tipo:** conceitual · **Chave:** ✅ confere

Um modelo está **mal especificado** quando a forma funcional está errada, quando faltam variáveis relevantes ou quando sobram variáveis irrelevantes. As consequências variam: omitir relevante gera viés; forma funcional errada também; incluir irrelevante "só" infla a variância.

**Passos do RESET:**
1. estimar o modelo original e guardar $\hat y$;
2. estimar a regressão aumentada com $\hat y^2$ e $\hat y^3$ como regressores extras;
3. testar $H_0$ de que os coeficientes desses termos são nulos, por $F$;
4. rejeitar indica má especificação; não rejeitar não prova que o modelo está correto.

## Ex. 50 — Leitura de um RESET

**Tipo:** interpretação · **Chave:** ❌ chave errada

```text
Hipóteses:   H0: modelo corretamente especificado   vs   H1: má especificação
Estatística: F = 2,284568, com F tabelado = 4,10 (α = 5%) e p = 0,20267
Decisão:     2,284568 < 4,10  e  p = 0,20267 > 0,05   ⇒   NÃO se rejeita H0
Conclusão:   não há evidência de má especificação do modelo.
```

> [!CAUTION]
> **A chave erra aqui**
> A chave conclui "o modelo está mal especificado", o que contradiz a própria estatística que ela reporta. Com $F$ abaixo do crítico e $p$ acima de $\alpha$, a decisão é **não rejeitar**. Ver [errata](../formulario/errata_chave_lista1.md).

## Ex. 51 — Quadrática verdadeira, reta ajustada

**Tipo:** conceitual · **Chave:** ⏳

Com o modelo verdadeiro $Y=\beta_1+\beta_2X+\beta_3X^2+u$ ($\beta_2\lt0$, $\beta_3\gt0$), a curva em U é a **linha bem especificada**; a reta é a **mal especificada**. A reta ajustada tem a forma $Y=a+bX+v$, com $v$ contendo $\beta_3X^2$ — ou seja, **erro correlacionado com o regressor**.

A propriedade perdida é o **não-viés**: o estimador da reta é viesado e inconsistente, porque $E[v\mid X]\neq 0$. Numa simulação com $\beta_1=20$, $\beta_2=-4$ e $\beta_3=0{,}4$ no intervalo estudado, o MQO da reta converge para uma inclinação de $-0{,}661$ (valor teórico $-0{,}661$), que não corresponde ao efeito marginal em ponto nenhum de interesse — a derivada verdadeira na média é $-0{,}650$, e muda de sinal ao longo do domínio. O RESET detecta facilmente: $F=68{,}11$, $p\approx 0$.

**Conferência numérica**

| chave_R | nota |
|---|---|
| m07b_ex51_b2_teorico | -0,66125 |
| m07b_ex51_b2_medio_sim | -0,66171 |
| m07b_ex51_derivada_media | -0,65025 |
| m07b_ex51_reset_F | 68,107 |

## Ex. 52 — Teste LM entre restrita e irrestrita

**Tipo:** interpretação · **Chave:** ✅ confere

```text
Hipóteses:   H0: λ2 = λ3 = λ4 = 0 (a regressão restrita é adequada)
             H1: ao menos um ≠ 0 (a irrestrita, com X², X³, é a correta)
Estatística: LM = n·R² da auxiliar dos resíduos restritos = 5,28  ~ χ²(3)
Decisão:     5,28 < 9,21 = χ² crítico (3 gl, 5%)   ⇒   não se rejeita H0
Conclusão:   escolhe-se a regressão RESTRITA; não há evidência de que os termos
             não lineares pertençam ao modelo.
```

O menor $\alpha$ que levaria à rejeição é 0,0714: a 10% a conclusão se inverteria. Vale escrever isso — mostra domínio do p-valor.

**Conferência numérica**

| chave_R | nota |
|---|---|
| m07b_ex52_p | 0,071361 |
| m07b_ex50_p_2_10 | 0,152346 |
