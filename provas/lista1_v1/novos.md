---
title: "Lista 1 v.1 — o que o repositório ainda não cobria"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
lista1_v1: [4, 6, 7, 8, 9, 10, 12, 13, 14, 19, 21, 23, 26, 31, 32, 40, 44, 45, 46, 49, 50, 56, 59, 61, 62, 64, 69, 70, 73, 77, 78, 79]
relevancia_p1: alta
status: verificado
verificacao:
  derivacao: ok
  numerica: ok
  chave: ok
tags:
  - econometria
  - mestrado/ppgeco
  - p1
  - lista
aliases:
  - Lista 1 v.1 — novos
---

# Lista 1 v.1: o que faltava

A lista nova tem 79 exercícios. Uns 50 já estavam resolvidos nos módulos, com outro número (ver o [mapa](mapa.md)). Esta nota cobre o resto: as **contas com números novos**, no formato de quatro linhas que vale ponto, e as **demonstrações que não existiam** no repositório. Todos os números saem de [lista1_v1.R](lista1_v1.R) (id `l1v`).

> [!TIP]
> **Ordem de estudo**
> Parte A primeiro: são contas de 3 minutos, com cara de item de prova. A Parte B são as demonstrações novas, curtas. A Parte C tem as respostas conceituais de um parágrafo.

---

## Parte A — contas no formato de prova

### Ex. 4 — IC e teste t da inclinação (propaganda × vendas)

$\widehat\beta_2=0{,}84$, $ep=0{,}20$, $n-2=18$, $t_{tab}=2{,}101$.

$$IC_{95\%}(\beta_2)=0{,}84\pm 2{,}101\times 0{,}20=(0{,}4198;\ 1{,}2602)$$

- **Hipóteses:** $H_0:\beta_2=0$ vs. $H_1:\beta_2\neq 0$.
- **Estatística:** $t_{cal}=\widehat\beta_2/ep(\widehat\beta_2)=0{,}84/0{,}20=4{,}20$, com $n-2=18$ graus de liberdade.
- **Decisão:** como $\lvert t_{cal}\rvert=4{,}20>t_{tab}=2{,}101$, rejeita-se $H_0$ ao nível de 5% (o IC também não contém o zero).
- **Conclusão:** o gasto com propaganda é estatisticamente significativo: R\$ 1 mil a mais de propaganda está associado a R\$ 840 a mais de vendas, em média.

<!-- conferência numérica: valores conferidos contra resultados/*.csv pelo scripts/check_numbers.R
| chave_R | nota |
|---|---|
| l1v_ex4_ttab | 2,101 |
| l1v_ex4_ic_inf | 0,4198 |
| l1v_ex4_ic_sup | 1,2602 |
| l1v_ex4_t | 4,20 |
-->

### Ex. 5 e 6 — preço de imóveis: $\bar R^2$ e F conjunto

Com $R^2=0{,}78$, $n=50$ e $k=4$: $\bar R^2=1-0{,}22\cdot 49/46=0{,}766$ (o enunciado arredonda para 0,76).

- **Hipóteses:** $H_0:\beta_{AREA}=\beta_{QUARTOS}=\beta_{IDADE}=0$ vs. $H_1$: pelo menos um $\neq 0$.
- **Estatística:** $F_{cal}=42{,}5$, com $q=3$ e $n-k=46$ graus de liberdade.
- **Decisão:** como $F_{cal}=42{,}5>F_{tab}(3,46)=2{,}81$, rejeita-se $H_0$ ao nível de 5%.
- **Conclusão:** os três regressores são conjuntamente significativos.

> [!CAUTION]
> **O F impresso não é o que o R² dá**
> Pela fórmula do ex. 42, $F=\frac{R^2/(k-1)}{(1-R^2)/(n-k)}=\frac{0{,}78/3}{0{,}22/46}=54{,}4$, não 42,5. O enunciado é internamente inconsistente, mas a decisão não muda. Na prova, **use o 42,5 impresso** e não perca tempo recalculando.

<!-- conferência numérica: valores conferidos contra resultados/*.csv pelo scripts/check_numbers.R
| chave_R | nota |
|---|---|
| l1v_ex5_r2aj | 0,766 |
| l1v_ex6_Ftab | 2,81 |
| l1v_ex6_F_do_r2 | 54,4 |
-->

**6b — F significativo, t não.** Regressores correlacionados repartem a mesma informação: cada $ep(b_k)$ é inflado pelo VIF (D06.9), e o $t$ individual perde poder. O $F$ conjunto pergunta outra coisa — se o bloco explica $Y$ — e não sofre com quem leva o crédito dentro do bloco.

### Ex. 7c — Sudeste contra Sul, não contra o Nordeste

$H_0:\beta_2=\beta_3$. Duas rotas equivalentes:

1. $t=\dfrac{b_2-b_3}{\sqrt{\widehat{\operatorname{Var}}(b_2)+\widehat{\operatorname{Var}}(b_3)-2\widehat{\operatorname{Cov}}(b_2,b_3)}}$ — **a covariância entra**; esquecê-la é o erro clássico.
2. Reestimar com o Sul como base: o $t$ da dummy do Sudeste é exatamente esse teste.

### Ex. 8 — VIF com correlação 0,95

$$R_2^2\approx 0{,}95^2=0{,}9025,\qquad VIF_2=\frac{1}{1-0{,}9025}=10{,}26$$

A variância de $b_2$ é cerca de dez vezes a que seria com regressores ortogonais; passa da regra prática de 10. Não há viés: o não-viés (D06.2) não usa a correlação entre regressores, só o posto completo.

<!-- conferência numérica: valores conferidos contra resultados/*.csv pelo scripts/check_numbers.R
| chave_R | nota |
|---|---|
| l1v_ex8_vif | 10,26 |
-->

### Ex. 9 — Breusch-Pagan

- **Hipóteses:** $H_0$: homocedasticidade, $\operatorname{Var}(u_i\mid X_i)=\sigma^2$, vs. $H_1$: $\operatorname{Var}(u_i\mid X_i)=\sigma_i^2$ depende de $X_i$.
- **Estatística:** $nR^2_{aux}=8{,}2$, que sob $H_0$ segue $\chi^2(1)$ (um regressor na auxiliar).
- **Decisão:** como $nR^2_{aux}=8{,}2>\chi^2_{tab}(1)=3{,}84$, rejeita-se $H_0$ ao nível de 5% ($p=0{,}0042$).
- **Conclusão:** há evidência de heterocedasticidade; os erros-padrão usuais não valem para inferência.

Por que MQO segue não viesado: o não-viés usa só $E(\mathbf u\mid \mathbf X)=0$. O que cai é a fórmula $\sigma^2(\mathbf X'\mathbf X)^{-1}$ e, com ela, Gauss-Markov.

<!-- conferência numérica: valores conferidos contra resultados/*.csv pelo scripts/check_numbers.R
| chave_R | nota |
|---|---|
| l1v_ex9_chi2tab | 3,84 |
| l1v_ex9_p | 0,0042 |
-->

### Ex. 10 — Durbin-Watson

$d\approx 2(1-\widehat\rho)\Rightarrow \widehat\rho\approx 1-0{,}85/2=0{,}575$.

- **Hipóteses:** $H_0:\rho=0$ vs. $H_1:\rho>0$.
- **Estatística:** $d=0{,}85$, ou seja, $\widehat\rho\approx 1-d/2=0{,}575$.
- **Decisão:** como $d=0{,}85<d_L=1{,}10$, rejeita-se $H_0$ ao nível de 5%.
- **Conclusão:** há autocorrelação positiva de primeira ordem; os erros-padrão usuais tendem a estar subestimados.

> [!WARNING]
> **As três zonas do DW**
> $d\lt d_L$: rejeita (autocorrelação positiva). $d_L\le d\le d_U$: **inconclusivo**. $d\gt d_U$: não rejeita. E o DW não vale com $Y_{t-1}$ entre os regressores — aí o MQO nem é consistente se houver autocorrelação (ver D08.7).

<!-- conferência numérica: valores conferidos contra resultados/*.csv pelo scripts/check_numbers.R
| chave_R | nota |
|---|---|
| l1v_ex10_rho | 0,575 |
-->

### Ex. 19 — a $\mathbf X$ que não inverte

A terceira coluna é o dobro da segunda. O posto de $\mathbf X$ é 2, menor que 3; $\det(\mathbf X'\mathbf X)=0$, $(\mathbf X'\mathbf X)^{-1}$ não existe. Só a combinação $\beta_2+2\beta_3$ é identificada: qualquer par com a mesma soma ponderada gera os mesmos ajustados.

<!-- conferência numérica: valores conferidos contra resultados/*.csv pelo scripts/check_numbers.R
| chave_R | nota |
|---|---|
| l1v_ex19_posto | 2 |
| l1v_ex19_det | 0 |
-->

### Ex. 26 — MQO à mão com desenho ortogonal

As colunas de $\mathbf X$ são ortogonais entre si, então $\mathbf X'\mathbf X=\operatorname{diag}(4,20,4)$ e a inversa é imediata: $\mathbf b=(39/4,\ 21/20,\ 5/4)'=(9{,}75;\ 1{,}05;\ 1{,}25)'$. Resíduos $(0{,}15;\ -0{,}45;\ 0{,}45;\ -0{,}15)$, que somam zero e são ortogonais a cada coluna.

> [!TIP]
> **O atalho que a prova quer ver**
> Com $\mathbf X'\mathbf X$ diagonal, cada $b_k=\sum x_{ik}y_i/\sum x_{ik}^2$: são regressões simples separadas. É o FWL no caso trivial: os outros regressores já são ortogonais, não há nada a "limpar".

<!-- conferência numérica: valores conferidos contra resultados/*.csv pelo scripts/check_numbers.R
| chave_R | nota |
|---|---|
| l1v_ex26_b0 | 9,75 |
| l1v_ex26_b1 | 1,05 |
| l1v_ex26_b2 | 1,25 |
| l1v_ex26_e2 | -0,45 |
-->

Interpretação: $Y$ está em milhares de reais, então $b_1=1{,}05$ são R\$ 1.050 a mais de vendas por unidade de gasto padronizado em marketing, mantido o P&D.

### Ex. 27 — MQO à mão, 5 observações

Mesmos dados do ex. 34 da lista antiga, já resolvido em [03_lista1.md](../../03_mqo_matricial/03_lista1.md): $\det(\mathbf X'\mathbf X)=200$, $\mathbf b=(1{,}30;\ 0{,}45)'$.

<!-- conferência numérica: valores conferidos contra resultados/*.csv pelo scripts/check_numbers.R
| chave_R | nota |
|---|---|
| l1v_ex27_det | 200 |
| l1v_ex27_b2 | 0,45 |
-->

### Ex. 31 — FWL com números

$\bar X=3$, $\bar Y=7{,}2$, $S_{XX}=10$, $S_{XY}=15$: $\widehat\beta_2=1{,}5$ e $\widehat\beta_1=2{,}7$. Regredir os desvios $y_i$ em $x_i$ sem constante dá o mesmo 1,5. Com $\mathbf X_1=\iota$, $\mathbf M_1=\mathbf M^0$ centra as variáveis (D04.3): o FWL diz que a inclinação da regressão com constante é a da regressão dos dados centrados.

<!-- conferência numérica: valores conferidos contra resultados/*.csv pelo scripts/check_numbers.R
| chave_R | nota |
|---|---|
| l1v_ex31_b1 | 2,7 |
| l1v_ex31_b2 | 1,5 |
-->

### Ex. 44 — output com $n=27$

$n-k=25$, $t_{0{,}025;25}=2{,}060$.

$$IC_{95\%}(\beta_2)=107{,}7422\pm 2{,}060\times 9{,}5817=(88{,}01;\ 127{,}48)$$

- **Hipóteses:** $H_0:\beta_2=0$ vs. $H_1:\beta_2\neq 0$.
- **Estatística:** $t_{cal}=107{,}7422/9{,}581670=11{,}24$, com $n-k=25$ graus de liberdade.
- **Decisão:** como $t_{cal}=11{,}24>t_{tab}=2{,}060$ (ou $p=0{,}0000<0{,}05$), rejeita-se $H_0$ ao nível de 5%.
- **Conclusão:** o investimento é estatisticamente significativo.

$R^2=0{,}8349$: 83,5% da variação amostral da dependente é explicada linearmente pelo investimento; $r=\sqrt{R^2}=0{,}914$ (sinal do $b_2$).

> [!WARNING]
> **Como interpretar o IC sem escorregar**
> "Com 95% de confiança, o intervalo $(88{,}0;\ 127{,}5)$ contém o $\beta_2$ verdadeiro", e não "$\beta_2$ tem 95% de chance de estar ali". A lista não dá as unidades do investimento nem da dependente: a chave as supõe a partir do ex. 41 da lista antiga. Na prova, use as do enunciado.

<!-- conferência numérica: valores conferidos contra resultados/*.csv pelo scripts/check_numbers.R
| chave_R | nota |
|---|---|
| l1v_ex44_ttab | 2,060 |
| l1v_ex44_ic_inf | 88,01 |
| l1v_ex44_ic_sup | 127,48 |
| l1v_ex44_t | 11,24 |
| l1v_ex44_r | 0,914 |
-->

### Ex. 45 e 62 — equação de salários log-nível (o primo da Q1 de 2025/2)

**45a — FEMALE:**

- **Hipóteses:** $H_0:\beta_4=0$ vs. $H_1:\beta_4\neq 0$.
- **Estatística:** $t_{cal}=-0{,}1800/0{,}05=-3{,}60$ (aproximadamente normal, $n=200$).
- **Decisão:** como $\lvert t_{cal}\rvert=3{,}60>t_{tab}=1{,}96$, rejeita-se $H_0$ ao nível de 5%.
- **Conclusão:** o gênero é significativo: mulheres ganham cerca de 18% menos, *ceteris paribus* (exato: $100(e^{-0{,}18}-1)=-16{,}5\%$).

**45b — EXP e EXP² juntos** ($q=2$, $n-k=195$):

$$F=\frac{(128{,}0-120{,}0)/2}{120{,}0/195}=\frac{4}{0{,}6154}=6{,}50$$

- **Hipóteses:** $H_0:\beta_2=\beta_3=0$ vs. $H_1$: pelo menos um $\neq 0$.
- **Estatística:** $F_{cal}=6{,}50$, com $q=2$ e $n-k=195$ graus de liberdade.
- **Decisão:** como $F_{cal}=6{,}50>F_{tab}(2,195)=3{,}00$, rejeita-se $H_0$ ao nível de 5% ($p=0{,}0019$).
- **Conclusão:** o perfil da experiência (nível e termo quadrático juntos) importa para o salário.

**62a — EDUC:** $100\times 0{,}085=8{,}5\%$ por ano de estudo (exato: 8,9%).

**62b — efeito marginal e pico de EXP.** É a Q1c da P1 2025/2 com outros números (D09.5):

$$\frac{\partial \ln W}{\partial EXP}=\widehat\beta_2+2\widehat\beta_3EXP=0{,}0450-0{,}0014\,EXP$$

Em $EXP=10$: $0{,}031$, ou cerca de 3,1% por ano adicional. O pico: $EXP^*=0{,}0450/0{,}0014=32{,}1$ anos. Depois disso, o modelo prevê retorno negativo da experiência.

<!-- conferência numérica: valores conferidos contra resultados/*.csv pelo scripts/check_numbers.R
| chave_R | nota |
|---|---|
| l1v_ex45_t_fem | -3,60 |
| l1v_ex62_fem_exato | -16,5 |
| l1v_ex45_F | 6,50 |
| l1v_ex45_pF | 0,00185 |
| l1v_ex62_educ_exato | 8,9 |
| l1v_ex62_efeito_exp10 | 0,031 |
| l1v_ex62_pico | 32,1 |
-->

> [!TIP]
> **Como o professor pode torcer**
> Pedir o $t$ de EDUC ($0{,}085/0{,}010=8{,}5$) ou de $EXP^2$ ($-3{,}5$); pedir o $\bar R^2$ a partir do $R^2$ ($1-0{,}58\cdot 199/195=0{,}408$); ou perguntar se o pico está dentro da amostra — se ninguém tem 32 anos de experiência, o "máximo" é extrapolação.

<!-- conferência numérica: valores conferidos contra resultados/*.csv pelo scripts/check_numbers.R
| chave_R | nota |
|---|---|
| l1v_ex45_t_educ | 8,5 |
| l1v_ex45_t_exp2 | -3,5 |
| l1v_ex45_r2aj | 0,408 |
-->

### Ex. 46 — Jarque-Bera

- **Hipóteses:** $H_0$: os erros seguem distribuição normal (assimetria 0 e curtose 3) vs. $H_1$: não seguem.
- **Estatística:** $JB=1{,}53$, que sob $H_0$ segue $\chi^2(2)$.
- **Decisão:** como $JB=1{,}53<\chi^2_{tab}=2{,}54$ (o crítico impresso), não se rejeita $H_0$ ($p=0{,}47$).
- **Conclusão:** não há evidência contra a normalidade dos resíduos.

> [!CAUTION]
> **O crítico 2,54 não é de 5%**
> O $\chi^2(2)$ a 5% é 5,99; o 2,54 corresponde a $\alpha\approx 28\%$. A decisão não muda (1,53 fica abaixo dos dois). Use o crítico do enunciado e, se sobrar uma linha, registre que o de 5% seria 5,99.

<!-- conferência numérica: valores conferidos contra resultados/*.csv pelo scripts/check_numbers.R
| chave_R | nota |
|---|---|
| l1v_ex46_chi2_5pct | 5,99 |
| l1v_ex46_alfa_do_254 | 0,28 |
| l1v_ex46_p | 0,47 |
-->

### Ex. 50 — duas restrições por SQR

$$F=\frac{(180-150)/2}{150/(40-3)}=\frac{15}{4{,}054}=3{,}70$$

- **Hipóteses:** $H_0:\beta_2=1$ e $\beta_3=0$ vs. $H_1$: pelo menos uma das restrições é falsa.
- **Estatística:** $F_{cal}=3{,}70$, com $q=2$ e $n-k_{UR}=37$ graus de liberdade.
- **Decisão:** como $F_{cal}=3{,}70>F_{tab}(2,37)=3{,}23$, rejeita-se $H_0$ ao nível de 5% ($p=0{,}034$).
- **Conclusão:** os dados não são compatíveis com as duas restrições ao mesmo tempo.

<!-- conferência numérica: valores conferidos contra resultados/*.csv pelo scripts/check_numbers.R
| chave_R | nota |
|---|---|
| l1v_ex50_F | 3,70 |
| l1v_ex50_p | 0,034 |
-->

### Ex. 61 — custo total

**a)** $\ln(Custo)=\dots+0{,}056\,Ano$: o custo cresce cerca de 5,6% ao ano (exato: $100(e^{0{,}056}-1)=5{,}76\%$). O $t$ da tendência é $0{,}056/0{,}003=18{,}7$: muito significativo.

> [!WARNING]
> **O antilog do intercepto não é o custo "esperado"**
> $e^{\widehat\alpha}$ estima a **mediana** (ou média geométrica) do custo no ano-base, não $E(Custo)$: $E(e^{u})\neq 1$. A chave chama de esperado; na prova, "custo típico no ano-base" é a frase segura.

**b)** Elasticidade custo-produção de 0,246: 1% a mais de produção, 0,246% a mais de custo. Abaixo de 1, custo médio cai com a escala — economias de escala.

<!-- conferência numérica: valores conferidos contra resultados/*.csv pelo scripts/check_numbers.R
| chave_R | nota |
|---|---|
| l1v_ex61_t_ano | 18,7 |
| l1v_ex61_pct_exato | 5,76 |
-->

### Ex. 63 — RESET

Mesmos números do ex. 50 da lista antiga: $F=2{,}284568\lt 4{,}10$ e $p=0{,}20267\gt 0{,}05$, **não** se rejeita H0 (forma funcional adequada). A chave v.1 agora conclui certo: o erro registrado na [errata](../../formulario/errata_chave_lista1.md) foi corrigido.

### Ex. 64 — mudança estrutural com dummy (Chow)

$$F=\frac{(240-210)/2}{210/(120-4)}=\frac{15}{1{,}810}=8{,}29$$

- **Hipóteses:** $H_0:\delta_0=\delta_1=0$ (ausência de mudança estrutural) vs. $H_1$: pelo menos um $\neq 0$.
- **Estatística:** $F_{cal}=8{,}29$, com $q=2$ e $n-k_{UR}=116$ graus de liberdade.
- **Decisão:** como $F_{cal}=8{,}29>F_{tab}(2,116)=3{,}08$, rejeita-se $H_0$ ao nível de 5% ($p=0{,}0004$).
- **Conclusão:** a reforma alterou o intercepto, a inclinação ou ambos.

Por que os dois juntos: a quebra pode estar só no nível, só no efeito do investimento ou em ambos. Testar $\delta_0$ e $\delta_1$ separados não responde "a relação é a mesma?" — e com $D$ e $D\times INV$ correlacionados, os dois $t$ podem ficar fracos enquanto o $F$ rejeita (D09.7).

<!-- conferência numérica: valores conferidos contra resultados/*.csv pelo scripts/check_numbers.R
| chave_R | nota |
|---|---|
| l1v_ex64_F | 8,29 |
| l1v_ex64_Ftab | 3,07 |
| l1v_ex64_p | 0,0004 |
-->

### Ex. 73a — VI à mão

$$\widehat\beta_1^{IV}=\frac{\sum z_iy_i}{\sum z_ix_i}=\frac{340}{85}=4{,}0,\qquad \widehat\beta_0^{IV}=\bar Y-\widehat\beta_1^{IV}\bar X=50-32=18{,}0$$

A 73b é a Q6 da P1 2025/2: ver D10.5.

<!-- conferência numérica: valores conferidos contra resultados/*.csv pelo scripts/check_numbers.R
| chave_R | nota |
|---|---|
| l1v_ex73_b1 | 4,0 |
| l1v_ex73_b0 | 18,0 |
-->

### Ex. 77 — o mesmo `ivreg` da Q2 de 2025/2, agora a 5%

O output é idêntico ao da P1 2025/2, inclusive os p-valores editados. Resolução completa em [10_lista1.md](../../10_endogeneidade_iv/10_lista1.md) (ex. 67 antigo); o que muda é o nível, **5% em vez de 10%**.

**Wu-Hausman**

- **Hipóteses:** $H_0$: $\ln(price)$ é exógeno (MQO e VI consistentes; MQO mais eficiente) vs. $H_1$: $\ln(price)$ é endógeno (só VI consistente).
- **Estatística:** $3{,}823$, com $df_1=1$ e $df_2=44$; $p=0{,}0469$.
- **Decisão:** como $p=0{,}0469<0{,}05$, rejeita-se $H_0$ ao nível de 5%.
- **Conclusão:** há evidência de endogeneidade de $\ln(price)$; o método consistente é VI/MQ2E.

**Sargan**

- **Hipóteses:** $H_0$: todos os instrumentos são válidos (exógenos) vs. $H_1$: pelo menos um é inválido.
- **Estatística:** $0{,}333$; $p=0{,}8468$.
- **Decisão:** como $p=0{,}8468>0{,}05$, não se rejeita $H_0$.
- **Conclusão:** não há evidência, a 5%, de que os instrumentos sejam inválidos.

> [!CAUTION]
> **A 5% a decisão do Wu-Hausman depende do número impresso**
> A estatística 3,823 com $F(1,44)$ dá $p=0{,}0569$, não 0,0469. Com o p **verdadeiro**, a 5% **não** se rejeitaria; com o impresso, rejeita. A lista antiga pedia 10%, onde os dois rejeitam. A prova vai imprimir um número: **decida pelo que estiver no papel**. Do mesmo modo, o Sargan tem $L-K=2-1=1$ gl ($p=0{,}564$), não 2 — a conclusão não muda.

**77f — elasticidade.** $-1{,}2774$: 1% a mais no preço real, 1,28% menos maços per capita. A chave diz "demanda elástica"; isso exige $\lvert\beta\rvert\gt 1$ **estatisticamente**. O teste de $H_0:\beta=-1$ dá $t=(-1{,}2774+1)/0{,}2417=-1{,}15$: não se rejeita elasticidade unitária. O IC de 95% é $(-1{,}75;\ -0{,}80)$, que contém $-1$. Uma frase sobre isso diferencia a resposta.

<!-- conferência numérica: valores conferidos contra resultados/*.csv pelo scripts/check_numbers.R
| chave_R | nota |
|---|---|
| l1v_ex77_wu_p_correto | 0,0569 |
| l1v_ex77_sargan_p_gl1 | 0,564 |
| l1v_ex77_sargan_p_gl2 | 0,8466 |
| l1v_ex77_t_elast_1 | -1,15 |
| l1v_ex77_ic_inf | -1,75 |
| l1v_ex77_ic_sup | -0,80 |
-->

---

## Parte B — demonstrações novas

### D02.17 · Mudança de escala de Y e de X (ex. 12)

> [!NOTE]
> **O que se quer provar**
> Se $Y^*=cY$, então $\widehat\beta_2^*=c\widehat\beta_2$, $ep^*=c\,ep$, e $t$ e $R^2$ não mudam. Se $X^*=cX$, então $\widehat\beta_2^*=\widehat\beta_2/c$, $ep^*=ep/c$, e $t$ e $R^2$ não mudam.

**Por que importa.** Mostra que significância e ajuste são propriedades da relação, não da unidade de medida. É a justificativa para trocar reais por milhares de reais sem refazer a inferência.

**Passo a passo.**

1. Inclinação com $Y^*=cY$: os desvios viram $y_i^*=cy_i$.

$$\widehat\beta_2^*=\frac{\sum x_i(cy_i)}{\sum x_i^2}=c\,\widehat\beta_2$$

2. Intercepto e resíduos: $\widehat\beta_1^*=c\bar Y-c\widehat\beta_2\bar X=c\widehat\beta_1$, logo $\widehat u_i^*=c\widehat u_i$ e $s^{*2}=c^2s^2$.

3. Erro-padrão: $ep(\widehat\beta_2^*)=\sqrt{s^{*2}/S_{XX}}=c\,ep(\widehat\beta_2)$. Logo $t^*=c\widehat\beta_2/(c\,ep)=t$.

4. $R^2$: $SQT^*=c^2SQT$ e $\sum\widehat u_i^{*2}=c^2\sum\widehat u_i^2$; a razão não muda.

5. Com $X^*=cX$: $x_i^*=cx_i$, $S_{XX}^*=c^2S_{XX}$.

$$\widehat\beta_2^*=\frac{\sum cx_iy_i}{c^2\sum x_i^2}=\frac{\widehat\beta_2}{c},\qquad ep^*=\sqrt{\frac{s^2}{c^2S_{XX}}}=\frac{ep}{c}$$

Os resíduos não mudam (o ajuste é o mesmo), então $s^2$, $t$ e $R^2$ ficam iguais.

$$\boxed{\text{escala muda o coeficiente e o ep na mesma proporção; } t \text{ e } R^2 \text{ são invariantes}}$$

> [!TIP]
> **Como o professor pode torcer**
> Em log-log a escala não mexe na inclinação, só no intercepto: $\ln(cY)=\ln c+\ln Y$. Em log-nível, mudar a unidade de $Y$ só desloca o intercepto. Conferido em R com os dados dos cabos ($t=2{,}144$ antes e depois).

<!-- conferência numérica: valores conferidos contra resultados/*.csv pelo scripts/check_numbers.R
| chave_R | nota |
|---|---|
| l1v_ex12_t_original | 2,144 |
| l1v_ex12_t_Y_escalado | 2,144 |
-->

### D02.18 · Cauchy-Schwarz, $\lvert r\rvert\le 1$ e $R^2=r^2$ (ex. 23)

> [!NOTE]
> **O que se quer provar**
> $(\mathbf a'\mathbf b)^2\le(\mathbf a'\mathbf a)(\mathbf b'\mathbf b)$; aplicado aos desvios, $\lvert r_{XY}\rvert\le 1$; e na regressão simples $R^2=\mathbf r_{XY}^2$.

**Passo a passo.**

1. Para todo escalar $\lambda$, a norma de $a-\lambda b$ é não negativa:

$$f(\lambda)=(\mathbf a-\lambda \mathbf b)'(\mathbf a-\lambda \mathbf b)=\mathbf a'\mathbf a-2\lambda\,\mathbf a'\mathbf b+\lambda^2\,\mathbf b'\mathbf b\ \ge 0$$

2. Uma parábola em $\lambda$ que nunca fica negativa tem discriminante $\le 0$:

$$4(\mathbf a'\mathbf b)^2-4(\mathbf a'\mathbf a)(\mathbf b'\mathbf b)\le 0\ \Longrightarrow\ (\mathbf a'\mathbf b)^2\le(\mathbf a'\mathbf a)(\mathbf b'\mathbf b)$$

3. Com $a=x$ e $\mathbf b=\mathbf y$ (desvios): $(\sum x_iy_i)^2\le\sum x_i^2\sum y_i^2$, ou seja $r_{XY}^2\le 1$.

4. Na regressão simples, $SQE=\widehat\beta_2^2S_{XX}=S_{XY}^2/S_{XX}$ (a soma explicada). Dividindo por $SQT=S_{YY}$:

$$R^2=\frac{S_{XY}^2}{S_{XX}S_{YY}}=r_{XY}^2$$

$$\boxed{\lvert r_{XY}\rvert\le 1\quad\text{e}\quad R^2=r_{XY}^2\ \text{(só na simples)}}$$

> [!WARNING]
> **Igualdade e regressão múltipla**
> A igualdade vale quando $a$ e $b$ são proporcionais (ajuste perfeito). Na múltipla, $R^2=r_{Y\widehat Y}^2$ (D05.3), não o quadrado de uma correlação simples.

### D02.19 · Regressão pela origem (ex. 32)

> [!NOTE]
> **O que se quer provar**
> Sem constante, $\sum\widehat u_i\ne 0$ em geral; e se o modelo verdadeiro tem intercepto, $\tilde\beta=\sum X_iY_i/\sum X_i^2$ é viesado, com viés $\beta_1\sum X_i/\sum X_i^2$.

**Passo a passo.**

1. A única condição de primeira ordem é $\partial S/\partial\beta=-2\sum X_i(Y_i-\tilde\beta X_i)=0$, isto é, $\sum X_i\widehat u_i=0$. Não existe a equação $\sum\widehat u_i=0$, que vinha da derivada em relação ao intercepto.

2. Substituindo o modelo verdadeiro $Y_i=\beta_1+\beta_2X_i+u_i$:

$$\tilde\beta=\frac{\sum X_i(\beta_1+\beta_2X_i+u_i)}{\sum X_i^2}=\beta_2+\beta_1\frac{\sum X_i}{\sum X_i^2}+\frac{\sum X_iu_i}{\sum X_i^2}$$

3. Tomando $E(\cdot\mid X)$ com $E(u_i\mid X)=0$ *[H2]*:

$$E(\tilde\beta\mid X)=\beta_2+\beta_1\frac{\sum X_i}{\sum X_i^2}$$

$$\boxed{\text{viés}=\beta_1\frac{\sum X_i}{\sum X_i^2}\ne 0\ \text{ salvo se } \beta_1=0 \text{ ou } \bar X=0}$$

> [!TIP]
> **Números e consequências**
> Com os dados do ex. 31, a reta pela origem dá $\tilde\beta=2{,}236$ (contra 1,5 com constante) e os resíduos somam 2,45. Sem constante, o $R^2$ usual também perde o sentido: $SQT\ne SQE+SQR$ com a média, e ele pode até sair negativo.

<!-- conferência numérica: valores conferidos contra resultados/*.csv pelo scripts/check_numbers.R
| chave_R | nota |
|---|---|
| l1v_ex32_b_origem | 2,236 |
| l1v_ex32_soma_res | 2,45 |
| l1v_ex32_vies_termo | 0,273 |
-->

### D02.20 · Coeficiente padronizado (ex. 69)

> [!NOTE]
> **O que se quer provar**
> Com $Y^*=(Y-\bar Y)/s_Y$ e $X^*=(X-\bar X)/s_X$, a inclinação é $\widehat\beta^*=\widehat\beta_2\,s_X/s_Y$; na simples, $\widehat\beta^*=r_{XY}$.

**Passo a passo.**

1. É D02.17 aplicado duas vezes: centrar não muda a inclinação (só o intercepto, que vira zero); dividir $Y$ por $s_Y$ multiplica a inclinação por $1/s_Y$; dividir $X$ por $s_X$ a multiplica por $s_X$.

$$\widehat\beta^*=\widehat\beta_2\frac{s_X}{s_Y}$$

2. Com $\widehat\beta_2=S_{XY}/S_{XX}$ e $s_X/s_Y=\sqrt{S_{XX}/S_{YY}}$ (o $n-1$ cancela):

$$\widehat\beta^*=\frac{S_{XY}}{\sqrt{S_{XX}S_{YY}}}=r_{XY}$$

$$\boxed{\widehat\beta^*_k=\widehat\beta_k\,\frac{s_{X_k}}{s_Y}:\ \text{efeito de 1 desvio-padrão de } X_k \text{ em desvios-padrão de } Y}$$

> [!TIP]
> **Utilidade e limite**
> Compara regressores em unidades distintas (anos de estudo × reais). Mas o ranking depende da dispersão **nesta amostra**: um regressor com pouca variação parece "pouco importante" mesmo com efeito grande por unidade. No ex. 31, $\widehat\beta^*=r=0{,}993$.

<!-- conferência numérica: valores conferidos contra resultados/*.csv pelo scripts/check_numbers.R
| chave_R | nota |
|---|---|
| l1v_ex69_bpad | 0,993 |
-->

### D08.7 · Exogeneidade estrita × contemporânea; AR(1) viesado mas consistente (ex. 56)

> [!NOTE]
> **O que se quer provar**
> Não-viés exige $E(\varepsilon\mid \mathbf X)=0$ (estrita); consistência exige só $\operatorname{plim}\mathbf X'\varepsilon/n=0$ (contemporânea). No modelo $Y_t=\beta_1+\beta_2Y_{t-1}+u_t$ com $u_t$ ruído branco, a primeira falha e a segunda vale.

**Por que importa.** É a razão de ser da Seção 7 da lista: em séries de tempo com defasagem da dependente, a teoria de amostra finita não se aplica e é a assintótica que justifica o MQO.

**Passo a passo.**

1. Estrita: $E(\varepsilon_t\mid x_1,\dots,x_n)=0$ — o erro de $t$ é não correlacionado com os regressores de **todos** os períodos. Contemporânea: $E(x_t\varepsilon_t)=0$ — só com os do mesmo período. A estrita implica a contemporânea; a volta não vale.

2. No AR(1), o regressor de $t+1$ é $Y_t$, que contém $u_t$:

$$\operatorname{Cov}(Y_t,u_t)=\operatorname{Var}(u_t)=\sigma^2\ne 0$$

Logo $u_t$ está correlacionado com um regressor futuro e $E(u\mid X)\ne 0$: o não-viés (D06.2) não vale. O viés é de ordem $1/n$ (viés de Hurwicz, negativo para $\beta_2\gt 0$).

3. Mas $Y_{t-1}$ depende só de $u_{t-1},u_{t-2},\dots$, que são não correlacionados com $u_t$: $E(Y_{t-1}u_t)=0$. Com estacionariedade ($\lvert\beta_2\rvert\lt 1$) e lei dos grandes números:

$$\operatorname{plim}\widehat\beta_2=\beta_2+\frac{\operatorname{plim}\frac1n\sum \tilde Y_{t-1}u_t}{\operatorname{plim}\frac1n\sum \tilde Y_{t-1}^2}=\beta_2+\frac{0}{\operatorname{Var}(Y_{t-1})}=\beta_2$$

$$\boxed{\text{AR(1) com } u_t \text{ ruído branco: MQO viesado em amostra finita, consistente}}$$

> [!WARNING]
> **Se o erro for autocorrelacionado, até a consistência cai**
> Com $u_t=\rho u_{t-1}+e_t$, $Y_{t-1}$ contém $u_{t-1}$, que se correlaciona com $u_t$: $\operatorname{Cov}(Y_{t-1},u_t)\ne 0$ e o MQO fica **inconsistente**. É a exceção ao "autocorrelação só tira eficiência" do quadro do ex. 14.

### D09.10 · Spline linear: duas inclinações sem salto (ex. 70)

> [!NOTE]
> **O que se quer provar**
> Em $Y=\beta_1+\beta_2X+\beta_3(X-X_0)D+u$, com $D=1$ se $X\gt X_0$, a inclinação é $\beta_2$ antes e $\beta_2+\beta_3$ depois de $X_0$, e a função é contínua em $X_0$.

**Passo a passo.**

1. Para $X\le X_0$ ($D=0$): $E(Y\mid X)=\beta_1+\beta_2X$, inclinação $\beta_2$.

2. Para $X\gt X_0$ ($D=1$): $E(Y\mid X)=(\beta_1-\beta_3X_0)+(\beta_2+\beta_3)X$, inclinação $\beta_2+\beta_3$.

3. Em $X=X_0$ os dois ramos valem $\beta_1+\beta_2X_0$: o termo $\beta_3(X-X_0)$ se anula exatamente no nó. Não há salto.

4. Teste da quebra: $H_0:\beta_3=0$, um $t$ sobre $\widehat\beta_3$ com $n-3$ gl (ou $F=t^2$ com 1 restrição).

$$\boxed{\text{spline} = \text{dummy de inclinação } (X-X_0)D \text{ sem dummy de intercepto}}$$

> [!TIP]
> **O contraste que o professor quer**
> Colocar $D$ sozinho (dummy de intercepto, como no ex. 66) abre um degrau em $X_0$. O spline força a continuidade: é uma **restrição** sobre o modelo com $D$ e $D\cdot X$, a de que o salto em $X_0$ é zero.

### D10.12 · A lógica da estatística de Hausman (ex. 78)

> [!NOTE]
> **O que se quer provar**
> Sob H0 (regressor exógeno), $\operatorname{Var}(\widehat\beta_{VI}-\widehat\beta_{MQO})=\operatorname{Var}(\widehat\beta_{VI})-\operatorname{Var}(\widehat\beta_{MQO})$, o que justifica a matriz no meio da estatística $H$.

**Passo a passo.**

1. Sob H0, MQO é eficiente e VI é consistente. O lema de Hausman: um estimador eficiente tem covariância nula com a diferença entre ele e qualquer outro consistente, $\operatorname{Cov}(\widehat\beta_{MQO},\ \widehat\beta_{VI}-\widehat\beta_{MQO})=0$ (assintoticamente). Se não fosse, uma combinação dos dois teria variância menor que a do eficiente — contradição.

2. Escrevendo $\widehat\beta_{VI}=\widehat\beta_{MQO}+(\widehat\beta_{VI}-\widehat\beta_{MQO})$ e usando a covariância nula:

$$\operatorname{Var}(\widehat\beta_{VI})=\operatorname{Var}(\widehat\beta_{MQO})+\operatorname{Var}(\widehat\beta_{VI}-\widehat\beta_{MQO})$$

3. Logo $H=q'[\operatorname{Var}(q)]^{-1}q$ com $q=\widehat\beta_{VI}-\widehat\beta_{MQO}$: uma forma quadrática normalizada, $\chi^2$ com tantos gl quantos regressores testados.

4. Sob H0, $\operatorname{plim}q=0$ e $H$ fica pequeno; sob H1, $\operatorname{plim}\widehat\beta_{MQO}\ne\beta$ e $\operatorname{plim}q\ne 0$, então $H$ cresce com $n$.

$$\boxed{H \text{ é um "}t^2\text{" da diferença entre um estimador eficiente e um robusto}}$$

> [!TIP]
> **Na prática do `ivreg`**
> O Wu-Hausman impresso é a versão por função de controle (D10.10): regride-se o endógeno nos instrumentos e testa-se o resíduo do 1º estágio na equação estrutural. Mesma hipótese, outra conta.

---

## Parte C — respostas curtas

### Ex. 13 — regressão espúria

Duas séries não estacionárias e independentes, regredidas uma na outra, tendem a dar $R^2$ alto e $t$ "significativos": os $t$ não seguem a distribuição usual porque o erro herda a tendência estocástica e é fortemente autocorrelacionado. **Sintoma** (regra de Granger-Newbold): $R^2$ maior que o DW. **Remédio**: diferenciar ($\Delta Y$ em $\Delta X$) ou, se houver relação de longo prazo, testar cointegração.

### Ex. 14 — o quadro que tem cara de questão de prova

| Violação | Viés (amostra finita) | Consistência | O que mais se perde |
|---|---|---|---|
| Heterocedasticidade | não viesado | consistente | eficiência e validade dos ep usuais |
| Autocorrelação | não viesado* | consistente* | eficiência e ep (tipicamente subestimados) |
| Multicolinearidade perfeita | $b$ não existe | — | identificação de cada coeficiente |
| Forma funcional errada | viesado | inconsistente | o próprio parâmetro de interesse |
| Endogeneidade | viesado | inconsistente | idem; precisa de VI |

\* com regressores estritamente exógenos. Com $Y_{t-1}$ entre os regressores e erro autocorrelacionado, viesado **e** inconsistente (D08.7).

> [!IMPORTANT]
> **A linha que resume o quadro**
> Só a violação de $E(\varepsilon\mid X)=0$ (H2) compromete viés e consistência. Heterocedasticidade e autocorrelação atacam a hipótese de erros esféricos, que só entra na variância: perdem-se eficiência e os ep usuais.

### Ex. 21 — $(\mathbf A\mathbf B)'=\mathbf B'\mathbf A'$ e $\mathbf X'\mathbf X$ semidefinida positiva

O elemento $(i,j)$ de $(\mathbf A\mathbf B)'$ é o $(j,i)$ de $\mathbf A\mathbf B$, $\sum_k a_{jk}b_{ki}$; o $(i,j)$ de $\mathbf B'\mathbf A'$ é $\sum_k b_{ki}a_{jk}$: iguais. Daí $(\mathbf X'\mathbf X)'=\mathbf X'\mathbf X$. E para $c\ne 0$, $\mathbf c'\mathbf X'\mathbf X\mathbf c=(\mathbf X\mathbf c)'(\mathbf X\mathbf c)=\sum v_i^2\ge 0$, com $v=\mathbf{X}c$; sob posto completo, $v\ne 0$ e a forma é positiva definida (D03.3).

### Ex. 40 — o ganho do MQ restrito

Não-viés e a diferença de variâncias estão em D05.11. Sobre a chave: ela diz que o ganho de eficiência é estritamente positivo quando a amostra não satisfaz a restrição exatamente. A diferença $\sigma^2(\mathbf X'\mathbf X)^{-1}\mathbf R'[\mathbf R(\mathbf X'\mathbf X)^{-1}\mathbf R']^{-1}\mathbf R(\mathbf X'\mathbf X)^{-1}$ **não depende de $\mathbf y$**: é determinada por $\mathbf X$ e $R$. Ela é semidefinida positiva com posto $q$ — nunca a matriz nula —, então há ganho em $q$ direções sempre que a restrição é imposta, qualquer que seja a amostra. (Nos cabos com $q=2$: menor autovalor $\approx 0$ e posto 2.)

<!-- conferência numérica: valores conferidos contra resultados/*.csv pelo scripts/check_numbers.R
| chave_R | nota |
|---|---|
| l1v_ex40_posto | 2 |
-->

### Ex. 42 e 49 — conferências

O $F$ pelo $R^2$ reproduz o $F$ do output dos cabos (9,447), e $W/q$ com $s^2$ reproduz o $F$ por SQR restrita/irrestrita (4,474 para $\beta_5=\beta_6=0$, isto é, X4 e X5 fora). São as identidades de D05.12 e D07.5 conferidas com números.

<!-- conferência numérica: valores conferidos contra resultados/*.csv pelo scripts/check_numbers.R
| chave_R | nota |
|---|---|
| l1v_ex42_F | 9,447 |
| l1v_ex49_F | 4,474 |
-->

### Ex. 59 — elasticidades do café no ponto médio

Os coeficientes estão em [09_lista1.md](../../09_dummies_forma_funcional/09_lista1.md) (ex. 43 antigo). Elasticidades em $(\bar X,\bar Y)$:

| Forma | Fórmula | $\widehat\eta$ |
|---|---|---|
| linear | $\widehat\beta_2\bar X/\bar Y$ | −0,220 |
| lin-log | $\widehat\beta_2/\bar Y$ | −0,250 |
| log-lin | $\widehat\beta_2\bar X$ | −0,223 |
| log-log | $\widehat\beta_2$ | −0,253 |
| inversa | $-\widehat\beta_2/(\bar X\bar Y)$ | −0,260 |

Todas inelásticas e próximas: a forma funcional pouco muda a resposta na média.

<!-- conferência numérica: valores conferidos contra resultados/*.csv pelo scripts/check_numbers.R
| chave_R | nota |
|---|---|
| l1v_ex59_el_lin | -0,220 |
| l1v_ex59_el_linlog | -0,250 |
| l1v_ex59_el_loglin | -0,223 |
| l1v_ex59_el_loglog | -0,253 |
| l1v_ex59_el_inv | -0,260 |
-->

> [!CAUTION]
> **Passo errado na chave (inversa)**
> A chave escreve um passo intermediário que simplifica para $-\widehat\beta_2/\bar Y$, depois conclui $-\widehat\beta_2/(\bar X\bar Y)$. O certo é $\frac{dY}{dX}=-\beta_2/X^2$, logo $\eta=-\frac{\beta_2}{X^2}\cdot\frac{X}{Y}=-\frac{\beta_2}{XY}$. Aqui os números quase coincidem só porque $\bar X\approx 1{,}01$.

### Ex. 79 — identificação e o limite do Sargan

Com $L=K$, o VI resolve $\mathbf Z'\widehat\varepsilon=0$ exatamente: as $L$ condições de momento são usadas para achar os $K$ parâmetros, e não sobra nenhuma para testar. A exogeneidade é hipótese mantida, defendida por argumento. Com $L\gt K$, sobram $L-K$ condições; o Sargan testa se elas são compatíveis com os dados:

$$J=\frac{\widehat\varepsilon'\mathbf Z(\mathbf Z'\mathbf Z)^{-1}\mathbf Z'\widehat\varepsilon}{\widehat\varepsilon'\widehat\varepsilon/n}=nR^2_{aux}\ \sim\ \chi^2_{L-K}$$

**Limite:** o teste supõe que pelo menos $K$ instrumentos são válidos e mede só incompatibilidades **entre** eles. Se todos forem inválidos na mesma direção, as estimativas concordam e o teste não rejeita.

> [!CAUTION]
> **A fórmula da chave tem um $n$ a mais**
> A chave escreve $n$ vezes a forma quadrática dividida por $s^2$. Como $s^2$ já é $\widehat\varepsilon'\widehat\varepsilon$ dividido por $n$ (ou $n-K$), multiplicar de novo por $n$ infla a estatística. Nos cigarros: a fórmula certa reproduz o Sargan do R (0,333); com o $n$ a mais daria 15,97.

<!-- conferência numérica: valores conferidos contra resultados/*.csv pelo scripts/check_numbers.R
| chave_R | nota |
|---|---|
| l1v_ex79_J | 0,333 |
| l1v_ex79_J_com_n_extra | 15,97 |
| l1v_ex79_nR2 | 0,333 |
-->
