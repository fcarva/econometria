---
title: "Módulo 05 — Lista 1 resolvida (ex. 27, 55, 56 e 62)"
modulo: "05"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
greene: "cap. 3 (§3.5); cap. 5 (§5.3–5.5)"
slides: "SL05"
lista1: [27, 55, 56, 62]
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
  - Ajuste e restrições — Lista 1
---

# Módulo 05 — Lista 1 resolvida

Teoria em [05_teoria.md](05_teoria.md); números em [05_ajuste_restricoes.R](05_ajuste_restricoes.R).

---

## Ex. 27 — A estatística F escrita com o $R^2$

**Tipo:** derivação · **Chave:** ➖ · **Cai como:** item curto de fechamento

**O que se pede.** Mostrar que
$$F_{cal}=\frac{SQE/(k-1)}{SQR/(n-k)}\quad\text{é igual a}\quad F_{cal}=\frac{R^2\,(n-k)}{(1-R^2)(k-1)} .$$

**Passo a passo.**

1. Divida numerador e denominador por $SQT$:
$$F=\frac{(SQE/SQT)/(k-1)}{(SQR/SQT)/(n-k)} .$$

2. Use as definições $R^2=SQE/SQT$ e, pela decomposição $SQT=SQE+SQR$, $SQR/SQT=1-R^2$:
$$F=\frac{R^2/(k-1)}{(1-R^2)/(n-k)}=\frac{R^2(n-k)}{(1-R^2)(k-1)} .\qquad\blacksquare$$

> [!WARNING]
> **Duas condições que o enunciado esconde**
> A decomposição $SQT=SQE+SQR$ exige **intercepto** no modelo. E esta forma do $F$ só vale para a hipótese de que **todas** as inclinações são nulas; para uma restrição qualquer, use a versão com dois $R^2$ (D05.7) ou com duas somas de quadrados.

## Ex. 55 — Retornos de escala no setor informal

**Tipo:** interpretação e cálculo · **Chave:** ⏳ · **Cai como:** Q1 com teste de restrição

Função de produção estimada em logs com $n=39\,692$ firmas:
$$\ln(\text{receita})=\beta_1+\beta_2\ln(\text{capital})+\beta_3\ln(\text{trabalho})+u .$$
Coeficientes: 0,637325 (capital) e 0,288255 (trabalho); $R^2=0{,}769275$; $SQR=17\,335{,}62$; $F$ global $=66\,164{,}78$.

**(a) Capital e trabalho podem ser muito correlacionados?** Podem, e costumam ser: firmas maiores usam mais dos dois. Se a correlação fosse muito alta, haveria **multicolinearidade** — os estimadores continuariam MELNV, mas com variâncias infladas (FIV alto, $t$ baixos com $F$ alto). Aqui não é o caso: a correlação parcial entre os dois regressores é 0,522, o que dá $FIV=1{,}375$, muito abaixo de 10.

**(b) Sinais e interpretação.** Os dois são positivos, como a teoria manda: mais insumo, mais produto. Como é log-log, são **elasticidades**: capital sobe 1% ⇒ receita sobe 0,637%; trabalho sobe 1% ⇒ receita sobe 0,288%.

**(c) Contratar 10% a mais de trabalhadores.** Aproximação: $0{,}288255\times 10\% = 2{,}88\%$. Cálculo exato: $(1{,}10^{0{,}288255}-1)\times 100=2{,}785\%$.

**(d) Coeficiente de determinação.** $R^2=0{,}7693$: 76,93% da variação do log da receita é explicada pelas duas elasticidades. O ajustado é praticamente igual (0,769263), porque com $n$ quase 40 mil a penalização por dois regressores é irrelevante.

**(e) Significância individual e conjunta (10%).** Individualmente, os três $t$ são enormes (o de capital, recalculado, dá 289,8) contra $z_{0,05}=1{,}645$: todos significativos. Conjuntamente, $F=66\,164{,}8$ contra $F_{crit}\approx 2{,}303$: rejeita-se a nulidade conjunta.

**(f) Retornos constantes de escala.** Restrição $H_0:\beta_2+\beta_3=1$.

```text
Hipóteses:   H0: β2 + β3 = 1 (retornos constantes)   vs   H1: β2 + β3 ≠ 1
Estatística: F = [(SQR_R − SQR_IR)/J] / [SQR_IR/(n − K)]
             = (48,59 / 1) / (17.335,62 / 39.689) = 48,59 / 0,436787 = 111,24
Decisão:     111,24 > 3,84 = F crítico (1; ∞) a 5%   ⇒   rejeita-se H0
Conclusão:   não há retornos constantes de escala. Como a soma estimada é 0,9256 < 1,
             há retornos DECRESCENTES de escala nos pequenos empreendimentos informais.
```

Pelo $t$ equivalente: $t=(0{,}92558-1)/0{,}0070559=-10{,}547$, e $t^2=111{,}24=F$ — a mesma decisão.

> [!TIP]
> **O que o enunciado dá e o que você precisa montar**
> O enunciado entrega $SQR$ restrito (17.384,21) e irrestrito (17.335,62). A diferença, 48,59, é o numerador; o denominador é o $s^2$ do modelo irrestrito. Com $J=1$, lembre-se de que $F=t^2$ — e só é possível calcular o $t$ diretamente se o enunciado der a covariância entre $\hat\beta_2$ e $\hat\beta_3$, que em geral **não** é dada. Por isso o caminho das duas somas de quadrados é o seguro.

**Conferência numérica**

| chave_R | nota |
|---|---|
| m05_ex55_dif_ssr | 48,59 |
| m05_ex55_s2 | 0,436787 |
| m05_ex55_F_crs | 111,24 |
| m05_ex55_soma | 0,92558 |
| m05_ex55_t_crs | -10,547 |
| m05_ex55_se_soma | 0,0070559 |
| m05_ex55_fiv | 1,3746 |
| m05_ex55_efeito10_aprox | 2,88255 |
| m05_ex55_efeito10_exato | 2,7855 |
| m05_ex55_Fcrit05 | 3,8417 |

## Ex. 56 — Demanda por energia elétrica: quadro de ANOVA

**Tipo:** interpretação · **Chave:** ⏳ · **Cai como:** Q1 com ANOVA

Output com $n=10$, $K=3$ (constante, tarifa $T$ e renda $Y$): $R^2=0{,}932022$, $\bar R^2=0{,}912599$, $SQR=152{,}3325$, erro-padrão da regressão 4,664953, $F=47{,}987$, DW 2,045.

**(a) Quadro de análise de variância.** Reconstruído a partir do output: $SQT=SQR/(1-R^2)=2240{,}90$ e $SQE=SQT-SQR=2088{,}57$.

| Variação | Graus de liberdade | Soma de quadrados | Quadrado médio | $F$ |
|---|---|---|---|---|
| Regressão | 2 | 2088,57 | 1044,28 | 47,987 |
| Resíduos | 7 | 152,33 | 21,762 | |
| Total | 9 | 2240,90 | | |

O quadrado médio dos resíduos, 21,762, tem raiz 4,665: é o "S.E. of regression" do output — bom sinal de que a reconstrução está certa.

**(b) Interpretação dos coeficientes.** $\hat\beta_T=-0{,}263274$: um ponto a mais no índice de tarifa reduz a quantidade demandada em 0,263 unidade — sinal **negativo**, como a lei da demanda exige. $\hat\beta_Y=1{,}237959$: um ponto a mais no índice de renda eleva a demanda em 1,238 — positivo, como se espera de bem normal. A constante (7,889) não tem leitura econômica útil aqui.

**(c) Testes a 10%.** Para a regressão como um todo: $F=47{,}99 \gt F_{2;7;0,10}=3{,}257$ ⇒ rejeita-se $H_0:\beta_T=\beta_Y=0$. Individualmente, com $t_{7;0,05}=1{,}895$ (bilateral a 10%): tarifa $\lvert-2{,}925\rvert\gt 1{,}895$ e renda $6{,}809\gt 1{,}895$, ambos significativos; a constante ($t=0{,}329$) não é.

**(d) $R^2$ e $\bar R^2$.** 93,2% da variação da quantidade é explicada; ajustando pelos graus de liberdade, 91,3%. A diferença é grande porque $n=10$ é pequeno: cada regressor custa caro em graus de liberdade.

**Conferência numérica**

| chave_R | nota |
|---|---|
| m05_ex56_sst | 2240,90 |
| m05_ex56_sqe | 2088,57 |
| m05_ex56_qm_reg | 1044,28 |
| m05_ex56_qm_res | 21,762 |
| m05_ex56_F_anova | 47,987 |
| m05_ex56_ser_recalc | 4,6650 |
| m05_ex56_Fcrit10_2_7 | 3,2574 |
| m05_ex56_tcrit_7_bi10 | 1,8946 |

## Ex. 62 — Retornos constantes de escala pelo F restrito

**Tipo:** interpretação · **Chave:** ⏳

```text
Hipóteses:   H0: β2 + β3 = 1 (retornos constantes de escala)   vs   H1: β2 + β3 ≠ 1
Estatística: F calculado = 1,95, com J = 1 restrição
Decisão:     1,95 < 2,45 = F tabelado (α = 5%)   ⇒   NÃO se rejeita H0
Conclusão:   os dados são compatíveis com retornos constantes de escala.
```

> [!WARNING]
> **Não rejeitar não é provar**
> A conclusão correta é "não há evidência contra os retornos constantes", e não "a firma tem retornos constantes". Com $F=1{,}95$ e uma restrição, o menor $\alpha$ que levaria à rejeição é cerca de 0,163: bem acima de 5%, mas longe de ser prova de igualdade. Compare com o ex. 55, em que $n$ enorme deu poder para rejeitar uma diferença de apenas 0,074.

**Conferência numérica**

| chave_R | nota |
|---|---|
| m05_ex62_p_min | 0,16259 |
| m05_ex62_Fcrit05_1_inf | 3,8415 |
