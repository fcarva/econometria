---
title: "Módulo 09 — Lista 1 resolvida (ex. 43, 47, 48, 57–61, 71 e 72)"
modulo: "09"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
greene: "cap. 6"
slides: "SL09"
lista1: [43, 47, 48, 57, 58, 59, 60, 61, 71, 72]
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
  - Dummies — Lista 1
---

# Módulo 09 — Lista 1 resolvida

Teoria em [09_teoria.md](09_teoria.md); números em [09_dummies_forma_funcional.R](09_dummies_forma_funcional.R) e `resultados/m09.csv`.

---

## Ex. 43 — Consumo de café: cinco formas funcionais

**Tipo:** computacional e derivação · **Chave:** ⏳ · **Cai como:** interpretação de elasticidade

Onze observações (2000–2010) de quantidade (xícaras) e preço (dólares); médias $\bar Q=2{,}20636$ e $\bar P=1{,}01091$.

| Forma | Equação estimada | $\hat\beta_2$ | $R^2$ | Elasticidade no ponto médio |
|---|---|---|---|---|
| Linear | $Q=\beta_1+\beta_2P$ | $-0{,}47953$ | 0,66276 | $\hat\beta_2\bar P/\bar Q=-0{,}21971$ |
| Lin-log | $Q=\alpha+\beta_2\ln P$ | $-0{,}55206$ | 0,71121 | $\hat\beta_2/\bar Q=-0{,}25021$ |
| Log-lin | $\ln Q=\alpha+\beta_2P$ | $-0{,}22028$ | 0,69708 | $\hat\beta_2\bar P=-0{,}22268$ |
| Log-log | $\ln Q=\alpha+\beta_2\ln P$ | $-0{,}25305$ | 0,74480 | $\hat\beta_2=-0{,}25305$ (constante) |
| Inversa | $Q=\beta_1+\beta_2(1/P)$ | $0{,}57895$ | 0,73089 | $-\hat\beta_2/(\bar P\bar Q)=-0{,}25957$ |

**Interpretação.** As cinco especificações contam a mesma história: demanda **inelástica**, com elasticidade-preço entre $-0{,}22$ e $-0{,}26$. Um aumento de 10% no preço reduz o consumo em cerca de 2,2% a 2,6%. Cafeína é o exemplo clássico de bem com demanda pouco sensível a preço.

> [!WARNING]
> **Não compare $R^2$ entre as cinco**
> As duas primeiras têm $Q$ como dependente, as duas seguintes têm $\ln Q$. $R^2$ só é comparável com a **mesma** variável dependente: entre linear e lin-log, sim; entre linear e log-log, não.

**(f) e (g) as duas demonstrações.**

No modelo potência $Y=\beta_1X^{\beta_2}$:
$$\frac{\partial Y}{\partial X}=\beta_1\beta_2X^{\beta_2-1}\ \Longrightarrow\ \eta=\frac{\partial Y}{\partial X}\frac XY=\beta_1\beta_2X^{\beta_2-1}\frac{X}{\beta_1X^{\beta_2}}=\beta_2 .$$

No modelo lin-log $Y=\alpha+\beta_2\ln X$:
$$\frac{\partial Y}{\partial X}=\frac{\beta_2}{X}\ \Longrightarrow\ \eta=\frac{\beta_2}{X}\cdot\frac XY=\frac{\beta_2}{Y}.$$

**Conferência numérica**

| chave_R | nota |
|---|---|
| m09_ex43_lin_b2 | -0,47953 |
| m09_ex43_loglog_b2 | -0,25305 |
| m09_ex43_elast_lin | -0,21971 |
| m09_ex43_elast_linlog | -0,25021 |
| m09_ex43_elast_loglin | -0,22268 |
| m09_ex43_elast_inv | -0,25957 |
| m09_ex43_loglog_r2 | 0,74480 |

## Ex. 47 — Estimar uma Cobb-Douglas por MQO

**Tipo:** derivação · **Chave:** ➖

Direto, não: $Y=Ax_1^{\alpha}x_2^{\beta}$ é não linear nos parâmetros. Em logs, sim:
$$\ln Y=\ln A+\alpha\ln x_1+\beta\ln x_2+u,$$
que é linear nos parâmetros $(\ln A,\alpha,\beta)$ — e o MQO se aplica normalmente. Os coeficientes já são as **elasticidades**-produto dos fatores, e $\hat A=e^{\widehat{\ln A}}$. A soma $\alpha+\beta$ mede os retornos de escala (teste em [módulo 05](../05_ajuste_restricoes/05_lista1.md), ex. 55).

> [!WARNING]
> **A condição escondida**
> Só funciona com erro **multiplicativo**, $Y=Ax_1^{\alpha}x_2^{\beta}e^{u}$. Com erro aditivo, o log não separa nada. Simulação com $\alpha=0{,}6$: erro multiplicativo dá $\hat\alpha=0{,}610$; erro aditivo dá $\hat\alpha=1{,}087$.

## Ex. 48 — Exportações e renda mundial: relação exponencial

**Tipo:** derivação · **Chave:** ➖

Mesma receita: de $EXPES_t=\beta_1\,RMUND_t^{\beta_2}e^{\mu_t}$,
$$\ln EXPES_t=\ln\beta_1+\beta_2\ln RMUND_t+\mu_t,$$
estimável por MQO, com $\hat\beta_2$ sendo a elasticidade-renda das exportações e $\hat\beta_1=e^{\widehat{\ln\beta_1}}$. O modelo é **intrinsecamente linear**: não linear nas variáveis, linear nos parâmetros depois da transformação.

## Ex. 57 — Poupança e renda com dummies (1946–1963)

**Tipo:** computacional · **Chave:** ⏳ · **Cai como:** Q1 com dummy

$D_t=1$ de 1946 a 1951, $0$ de 1952 a 1963.

**(a) O que é variável binária.** Variável que assume 1 quando o atributo está presente e 0 caso contrário. Serve para trazer informação **qualitativa** (regime, sexo, região, período) para dentro do modelo, deslocando o intercepto e, com interação, a inclinação.

**(b) Sem dummy.**
$$\hat Y_t=-1{,}08207+0{,}117845\,X_t,\qquad R^2=0{,}91854.$$
A propensão marginal a poupar é 0,1178: cada milhão a mais de renda eleva a poupança em 0,118 milhão.

**(c) Dummy de intercepto.**
$$\hat Y_t=-1{,}33113+0{,}172512\,D_t+0{,}130012\,X_t,\qquad R^2=0{,}92569.$$
$t_{D}=1{,}202$ ($p=0{,}248$): **não** significativo a 5%.

**(d) Dummy de inclinação.**
$$\hat Y_t=-1{,}22107+0{,}0094989\,(X_tD_t)+0{,}124606\,X_t,\qquad R^2=0{,}92103.$$
$t=0{,}688$ ($p=0{,}502$) contra $t_{15;0{,}025}=2{,}131$: também **não** significativo a 5%.

**(e) Intercepto e inclinação juntos.**
$$\hat Y_t=-1{,}45086+2{,}30485\,D_t-0{,}202196\,(X_tD_t)+0{,}136492\,X_t,\qquad R^2=0{,}96112,$$
com $t_D=3{,}799$ ($p=0{,}0020$) e $t_{XD}=-3{,}572$ ($p=0{,}0031$): agora **os dois** são significativos.

> [!IMPORTANT]
> **O ensinamento da questão**
> Isoladamente, nenhuma das dummies "aparece"; juntas, as duas são fortemente significativas. É o retrato da multicolinearidade entre $D$ e $D\cdot X$: cada uma sozinha é má aproximação da quebra, que é de nível **e** de inclinação. Moral: decidir por $t$ individual quando a hipótese é conjunta leva à conclusão errada — use $F$.

## Ex. 58 — Demanda log-log com dummy de crise

**Tipo:** interpretação · **Chave:** ⏳

Com $\log Q^D=5{,}75+0{,}57\log P+0{,}88\log R$, $n=20$, $R^2=0{,}88$, $F_{cal}=25{,}67$:

- **(a) Sinais.** O coeficiente do preço é **positivo** (0,57), contrariando a lei da demanda: sinal inesperado, sinal de má especificação, simultaneidade (preço e quantidade determinados juntos, [módulo 10](../10_endogeneidade_iv/10_teoria.md)) ou variável omitida. O da renda é positivo (0,88), coerente com bem normal.
- **(b) Interpretação.** Log-log: elasticidades. Preço sobe 1% → quantidade sobe 0,57% (anômalo); renda sobe 1% → quantidade sobe 0,88%.
- **(c) Significância conjunta.** $H_0:\beta_2=\beta_3=0$; $F_{cal}=25{,}67 \gt F_{crit}=3{,}81$ ⇒ rejeita-se: conjuntamente significativos.
- **(d) Elasticidade-renda** $=0{,}88\lt 1$: bem normal **necessário** (não de luxo).
- **(e) $R^2=0{,}88$.** 88% da variação do log da quantidade explicada. Para avaliar a inclusão de uma variável, $R^2$ não serve (nunca cai): use $\bar R^2$, que pune graus de liberdade.
- **(f) Dummy de crise 1997–1999.** Com $D_t=1$ em 1997, 1998 e 1999 e $0$ nos demais anos de 1995 a 2009:
$$\log Q_t=\beta_1+\alpha_1 D_t+\beta_2\log P_t+\beta_3\log R_t+\alpha_2 (D_t\log R_t)+u_t,$$
em que $\alpha_1$ desloca o intercepto e $\alpha_2$ muda a elasticidade-renda durante a crise.

## Ex. 59 — Demanda por etanol com DUMMY × log(PIB)

**Tipo:** interpretação · **Chave:** ⏳

$n=108$ (mensal, 2002–2011); dummy igual a 1 de julho de 2008 em diante (crise do subprime).

- **(a) Significância conjunta.** $F_{cal}=337{,}9987 \gt F_{crit}=2{,}45$ ⇒ rejeita-se $H_0$: os quatro coeficientes são conjuntamente significativos.
- **(b) Individual, com $t_{crit}=1{,}98$.** Preço do etanol $t=-3{,}364$ e preço da gasolina $t=2{,}345$ e PIB $t=6{,}515$: os três significativos. A interação $DUM\times\log(PIB)$ tem $t=1{,}565 \lt 1{,}98$: **não** significativa.
- **(c) Sinais.** Preço próprio negativo (lei da demanda), preço do substituto positivo (gasolina é substituta do etanol) e PIB positivo (bem normal): tudo coerente.
- **(d) Elasticidade-preço** $=-0{,}4182$: demanda **inelástica**; 1% de aumento no preço reduz o consumo em 0,42%.
- **(e) $\bar R^2=0{,}9403$.** Corrige o $R^2$ pelos graus de liberdade e, por isso, permite comparar modelos com números diferentes de regressores (mesma dependente).
- **(f) Quebra estrutural.** O teste é exatamente a significância da interação: $t=1{,}565\lt 1{,}98$, então **não** há evidência de quebra na elasticidade-renda após a crise.

> [!WARNING]
> **Um deslize no enunciado**
> O $t$ impresso para a constante é negativo ($-4{,}92$) enquanto o coeficiente é positivo (13,70) — incompatível com um erro-padrão positivo. Aponte a inconsistência e siga usando o que é pedido.

## Ex. 60 — Montar um teste de quebra estrutural com dummies

**Tipo:** conceitual e derivação · **Chave:** ➖ · **Cai como:** questão dissertativa

Modelo original para o Brasil, 1970–2010: $PIB_t=\beta_1+\beta_2C_t+\beta_3G_t+\beta_4I_t+\beta_5X_t+\beta_6M_t+\mu_t$, com possível quebra em 1999 (mudança do regime cambial).

1. **Dummy:** $D_t=0$ de 1970 a 1998 e $D_t=1$ de 1999 a 2010.
2. **Equação aumentada** (quebra no intercepto e no efeito marginal das exportações):
$$PIB_t=\beta_1+\alpha_1D_t+\beta_2C_t+\beta_3G_t+\beta_4I_t+\beta_5X_t+\alpha_2(D_tX_t)+\beta_6M_t+\mu_t.$$
3. **Hipóteses.** Quebra no intercepto: $H_0:\alpha_1=0$ contra $H_1:\alpha_1\neq 0$. Quebra na inclinação das exportações: $H_0:\alpha_2=0$ contra $H_1:\alpha_2\neq 0$. Quebra conjunta: $H_0:\alpha_1=\alpha_2=0$.
4. **Estatísticas.** $t=\hat\alpha_j/\text{E.p.}(\hat\alpha_j)$, com $n-K$ graus de liberdade, para cada teste individual; $F$ com $J=2$ e $n-K$ para o conjunto.
5. **Conclusão.** Rejeitar $\alpha_1=0$ indica mudança de nível; rejeitar $\alpha_2=0$ indica que o efeito marginal das exportações mudou depois de 1999.

Equivalência com Chow em D09.7.

## Ex. 61 — Armadilha da variável dummy

**Tipo:** derivação · **Chave:** ➖

Com $Y_i=\alpha_1+\alpha_2D_{1i}+\alpha_3D_{2i}+u_i$, $D_1$ homem e $D_2$ mulher, vale $D_{1i}+D_{2i}=1$ para todo $i$. Com $n=5$, por exemplo $D_1=(1,0,1,0,1)'$:

$$X=\begin{pmatrix}1&1&0\\1&0&1\\1&1&0\\1&0&1\\1&1&0\end{pmatrix},\qquad \text{coluna 1}=\text{coluna 2}+\text{coluna 3}.$$

O posto de $X$ é **2**, menor que $K=3$: viola-se a hipótese A2 (posto completo), $X'X$ é singular (determinante numérico $-4\times10^{-15}$) e $b=(X'X)^{-1}X'y$ **não existe** — os parâmetros não são identificados.

**Como corrigir.** Ou retire uma dummy (a categoria omitida vira base, e $\alpha_2$ passa a medir a diferença entre os grupos), ou retire o intercepto (cada coeficiente vira a média do grupo). Nas duas correções o posto volta a ser completo.

## Ex. 71 — O estimador de diferenças em diferenças

**Tipo:** derivação · **Chave:** ➖ · **Cai como:** derivação de uma página

Demonstração completa em [09_teoria.md](09_teoria.md), D09.8, e discussão em [did.md](did.md). Resumo do fio: escrever o modelo nos dois períodos, tomar a diferença (some tudo que é fixo no tempo, inclusive $\beta_1D_i$), tomar a esperança em cada grupo e subtrair. Sobra
$$\beta_3+\beta'\big[(\Delta x\mid D=1)-(\Delta x\mid D=0)\big].$$

Verificação: numa simulação com efeito verdadeiro 1,5, a diferença das diferenças de médias, o coeficiente da interação e a regressão em primeiras diferenças dão o **mesmo** número, 1,58999746.

## Ex. 72 — DiD com características invariantes no tempo

**Tipo:** derivação · **Chave:** ➖

Se $x_{it}=x_i$, então $\Delta x_i=0$ e o colchete desaparece:
$$E[\Delta y\mid D=1]-E[\Delta y\mid D=0]=\beta_3 .$$

**Conclusão.** Em DiD, controles que não variam no tempo são **irrelevantes para a identificação**: a primeira diferença já os elimina, observados ou não. Isso é uma força — o viés por heterogeneidade fixa não observada some — e uma limitação: o efeito dessas características não pode ser estimado. É o mesmo mecanismo dos efeitos fixos em painel ([módulo 12](../12_painel_I/README.md)).

Confirmado na simulação: incluir o controle invariante no tempo muda o coeficiente da interação em $10^{-15}$.

**Conferência numérica**

| chave_R | nota |
|---|---|
| m09_ex57b_b_X | 0,117845 |
| m09_ex57c_t_D | 1,2019 |
| m09_ex57d_t_IXD | 0,68789 |
| m09_ex57e_t_D | 3,7995 |
| m09_ex57e_t_IXD | -3,5716 |
| m09_ex57e_r2 | 0,96112 |
| m09_chow_F | 7,6665 |
| m09_ex61_posto | 2 |
| m09_did_medias | 1,59000 |
| m09_did_com_x | 1,59000 |
