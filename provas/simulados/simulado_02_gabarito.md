---
title: "Simulado 02 — gabarito com rubrica"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
relevancia_p1: alta
status: rascunho
verificacao:
  numerica: ok
tags:
  - econometria
  - mestrado/ppgeco
  - p1
  - simulado
aliases:
  - Gabarito Simulado 02
---

# Simulado 02 — gabarito

---

## Questão 1 (2,5)

### a) Interpretação e hipótese implícita (0,5)

Modelo log-log: os coeficientes são **elasticidades**. $\widehat\beta_{LK}=0{,}2889$ — 1% a mais de capital eleva o produto em 0,289%; $\widehat\beta_{LL}=0{,}7575$ — 1% a mais de emprego eleva o produto em 0,758%. Usar logs impõe a forma **Cobb-Douglas**, com elasticidades **constantes** e elasticidade de substituição unitária entre os fatores.

| Rubrica | Pontos |
|---|---|
| Ler os dois coeficientes como elasticidades | 0,3 |
| Reconhecer a Cobb-Douglas por trás da forma log-log | 0,2 |

### b) Retornos constantes de escala pelas somas de quadrados (0,75)

- **Hipóteses:** $H_0:\beta_{LK}+\beta_{LL}=1$ (retornos constantes de escala) vs. $H_1:\beta_{LK}+\beta_{LL}\neq 1$.
- **Estatística:** $F_{cal}=\dfrac{(SQR_R-SQR_{UR})/q}{SQR_{UR}/(n-K)}=\dfrac{(0{,}2895589-0{,}2171663)/1}{0{,}2171663/44}=\dfrac{0{,}0723926}{0{,}00493560}=14{,}667$.
- **Decisão:** como $F_{cal}=14{,}667>F_{tab}(1,44)=4{,}06$, rejeita-se $H_0$ ao nível de 5%.
- **Conclusão:** não há retornos constantes de escala. Como a soma estimada é $0{,}2889+0{,}7575=1{,}0465>1$, há retornos **crescentes** de escala.

| Rubrica | Pontos |
|---|---|
| Hipóteses com a restrição escrita corretamente | 0,2 |
| Fórmula do $F$ restrito com $q=1$ e $n-K=44$ | 0,3 |
| Conta e decisão | 0,15 |
| Conclusão econômica (crescentes, não só "rejeita") | 0,1 |

### c) O mesmo teste pelo $t$ (0,5)

$$\operatorname{Var}(\widehat\beta_{LK}+\widehat\beta_{LL})=\operatorname{Var}(\widehat\beta_{LK})+\operatorname{Var}(\widehat\beta_{LL})+2\operatorname{Cov}(\widehat\beta_{LK},\widehat\beta_{LL})$$
$$=0{,}04046803^2+0{,}03526684^2+2(-0{,}00136711)=0{,}000147190,$$
logo $ep=0{,}012132$ e
$$t=\frac{1{,}046464-1}{0{,}012132}=3{,}830 .$$
Como $\lvert 3{,}830\rvert\gt 2{,}015$, rejeita-se $H_0$ — mesma conclusão. E $t^2=14{,}667=F$, como tem de ser com $q=1$.

> [!WARNING]
> **Sem a covariância não dá**
> Somar apenas as variâncias daria erro-padrão 0,0537 e $t=0{,}87$, concluindo o **oposto**. A covariância entre as duas elasticidades é negativa e grande em módulo: ignorá-la é o erro clássico desta questão.

| Rubrica | Pontos |
|---|---|
| Variância da soma com o termo de covariância | 0,25 |
| $t$ calculado e decisão | 0,15 |
| Verificar $t^2=F$ | 0,1 |

### d) Diagnósticos (0,5)

| Teste | H0 | Estatística | Decisão a 5% |
|---|---|---|---|
| Jarque-Bera | resíduos normais | 0,9437 ($\chi^2_2$) | $p=0{,}624$: não rejeita |
| RESET | modelo bem especificado | 1,6174 ($F_{2;42}$) | $p=0{,}211$: não rejeita |
| Breusch-Pagan | homocedasticidade | 4,3716 ($\chi^2_3$) | $p=0{,}224$: não rejeita |
| White | homocedasticidade | 10,9117 ($\chi^2_9$) | $p=0{,}282$: não rejeita |

**Conclusão:** o modelo passa em todos. Não há evidência contra normalidade, especificação ou homocedasticidade — o que sustenta a inferência exata usada nos itens (b) e (c), importante porque $n=48$ é pequeno.

### e) Ajuste e UNEMP (0,25)

$\bar R^2=0{,}99524$: quase toda a variação do log do produto estadual é explicada — normal em funções de produção agregadas, em que as variáveis compartilham a escala do estado. UNEMP tem $t=-1{,}704$: **não** significativa a 5% ($\lvert t\rvert\lt 2{,}015$), mas significativa a 10% ($p=0{,}0883\lt 0{,}10$), com sinal negativo, como esperado.

---

## Questão 2 (2,5)

### a) Endógena, instrumentos e por quê (0,5)

**Endógena:** EDUC. **Instrumento externo:** NEARC4 (morar perto de uma faculdade aos 18 anos). **Exógenas incluídas:** EXPER, EXPERSQ, BLACK, SMSA, SOUTH e a constante — todas também entram na lista de instrumentos.

A escolaridade é endógena porque a **habilidade** não observada afeta tanto o salário quanto a decisão de estudar: ela está no erro e é correlacionada com EDUC, violando $E(\varepsilon\mid X)=0$. Também há erro de medida na escolaridade declarada e possível causalidade reversa via expectativa de salário.

### b) Relevância (0,5)

- **Hipóteses:** $H_0$: o instrumento é fraco (irrelevante) vs. $H_1$: o instrumento é forte.
- **Estatística:** $F=16{,}718$ ($df_1=1$ e $df_2=3003$), $p=0{,}0000$.
- **Decisão:** como $p<0{,}05$ e $F=16{,}7>10$ (regra de Staiger-Stock), rejeita-se $H_0$.
- **Conclusão:** NEARC4 é relevante, embora com folga modesta: 16,7 está bem abaixo dos 228 do exemplo dos cigarros.

### c) MQO ou MQ2E a 5% (0,5)

- **Hipóteses:** $H_0$: EDUC é exógena (MQO consistente e eficiente) vs. $H_1$: EDUC é endógena.
- **Estatística:** Wu-Hausman $F=1{,}539$ ($df_1=1$ e $df_2=3002$), $p=0{,}2149$.
- **Decisão:** como $p=0{,}2149>0{,}05$, **não** se rejeita $H_0$.
- **Conclusão:** a 5% não há evidência de endogeneidade; o método consistente **e** eficiente é o MQO. A 10% a conclusão é a mesma ($0{,}2149>0{,}10$).

### d) Por que não há Sargan (0,5)

Porque o modelo é **exatamente identificado**: há **um** instrumento externo (NEARC4) para **uma** variável endógena (EDUC), então $L-K=0$ e não sobram graus de liberdade para o teste de sobreidentificação.

**Implicação:** a exogeneidade do instrumento **não é testável** aqui — ela é hipótese, defendida apenas por argumento econômico. E o argumento é discutível: morar perto de uma faculdade pode estar correlacionado com renda familiar e qualidade da escola básica, que afetam o salário diretamente. Com dois ou mais instrumentos, o Sargan permitiria ao menos testar a coerência entre eles.

| Rubrica | Pontos |
|---|---|
| Identificação exata: $L=K$ | 0,25 |
| Exogeneidade não testável e o que isso custa | 0,25 |

### e) Interpretação e comparação (0,5)

$\widehat\beta_{EDUC}^{MQ2E}=0{,}1323$: cada ano de estudo eleva o salário em cerca de 13,2% (exato $100(e^{0{,}1323}-1)=14{,}1\%$). Por MQO, 7,46%.

O MQ2E é **quase o dobro** do MQO, o contrário do que o viés de habilidade sugeriria. Duas leituras usuais: (i) o instrumento identifica o efeito para quem só estudou mais por morar perto da faculdade — um grupo com retorno marginal alto (efeito de tratamento heterogêneo, LATE); (ii) erro de medida na escolaridade atenua o MQO, e o VI corrige a atenuação. Como o Wu-Hausman não rejeitou, a diferença também pode ser ruído.

O erro-padrão salta de 0,0035 para 0,0492 — catorze vezes — porque o VI usa apenas a parcela de EDUC explicada por NEARC4, e $\rho_{zx}$ é pequeno: é o custo previsto pela variância assintótica do VI, proporcional a $1/\rho_{zx}^2$.

---

## Questão 3 (1,5)

### a) Condição de não-viés (0,5)

$$\mathbf b^*=\big[(\mathbf X'\mathbf X)^{-1}\mathbf X'+\mathbf C\big](\mathbf X\beta+\varepsilon)=\beta+\mathbf C\mathbf X\beta+\big[(\mathbf X'\mathbf X)^{-1}\mathbf X'+\mathbf C\big]\varepsilon$$
$$E(b^*\mid X)=\beta+CX\beta .$$
Para que isso valha $\beta$ **para todo** $\beta$, é necessário $\boxed{CX=0}$.

### b) Variância (0,75)

Com $\mathbf C\mathbf X=0$, $\mathbf b^*-\beta=\big[(\mathbf X'\mathbf X)^{-1}\mathbf X'+\mathbf C\big]\varepsilon$, logo
$$\operatorname{Var}(\mathbf b^*\mid \mathbf X)=\big[(\mathbf X'\mathbf X)^{-1}\mathbf X'+\mathbf C\big]\sigma^2\mathbf I\big[\mathbf X(\mathbf X'\mathbf X)^{-1}+\mathbf C'\big]$$
$$=\sigma^2\Big[(\mathbf X'\mathbf X)^{-1}+\underbrace{(\mathbf X'\mathbf X)^{-1}\mathbf X'\mathbf C'}_{=0}+\underbrace{\mathbf C\mathbf X(\mathbf X'\mathbf X)^{-1}}_{=0}+\mathbf C\mathbf C'\Big]=\sigma^2(\mathbf X'\mathbf X)^{-1}+\sigma^2\mathbf C\mathbf C' .$$

Como $\mathbf C\mathbf C'$ é semidefinida positiva, $\operatorname{Var}(\mathbf b^*)-\operatorname{Var}(\mathbf b)=\sigma^2\mathbf C\mathbf C'\succeq 0$.

### c) Conclusão (0,25)

Entre os estimadores **lineares e não viesados**, o MQO tem a menor matriz de variância — é MELNV (Gauss-Markov). A igualdade só ocorre com $C=0$. Hipóteses indispensáveis: $E(\varepsilon\mid X)=0$ para o não-viés e $E(\varepsilon\varepsilon'\mid X)=\sigma^2I$ para a comparação de variâncias. **Normalidade não é usada.**

---

## Questão 4 (1,5)

### a) Frisch-Waugh-Lovell (0,75)

Equações normais em blocos:
$$\begin{pmatrix}X_1'X_1&X_1'X_2\\X_2'X_1&X_2'X_2\end{pmatrix}\begin{pmatrix}b_1\\b_2\end{pmatrix}=\begin{pmatrix}X_1'y\\X_2'y\end{pmatrix}$$

Da primeira linha, $\mathbf b_1=(\mathbf X_1'\mathbf X_1)^{-1}\mathbf X_1'(\mathbf y-\mathbf X_2\mathbf b_2)$. Substituindo na segunda:
$$\mathbf X_2'\mathbf X_1(\mathbf X_1'\mathbf X_1)^{-1}\mathbf X_1'(\mathbf y-\mathbf X_2\mathbf b_2)+\mathbf X_2'\mathbf X_2\mathbf b_2=\mathbf X_2'\mathbf y .$$
Reagrupando,
$$\mathbf X_2'\big[\mathbf X_2-\mathbf X_1(\mathbf X_1'\mathbf X_1)^{-1}\mathbf X_1'\mathbf X_2\big]\mathbf b_2=\mathbf X_2'\big[\mathbf y-\mathbf X_1(\mathbf X_1'\mathbf X_1)^{-1}\mathbf X_1'\mathbf y\big]$$
$$\mathbf X_2'\mathbf M_1\mathbf X_2\,\mathbf b_2=\mathbf X_2'\mathbf M_1\mathbf y\ \Longrightarrow\ \mathbf b_2=(\mathbf X_2'\mathbf M_1\mathbf X_2)^{-1}\mathbf X_2'\mathbf M_1\mathbf y .\qquad\blacksquare$$

Como $\mathbf M_1$ é simétrica e idempotente, isso é a regressão de $\mathbf M_1\mathbf y$ em $\mathbf M_1\mathbf X_2$ — as partes de $\mathbf y$ e de $\mathbf X_2$ não explicadas por $\mathbf X_1$.

### b) Viés de omissão (0,75)

$$\mathbf b_1=(\mathbf X_1'\mathbf X_1)^{-1}\mathbf X_1'\big(\mathbf X_1\beta_1+\mathbf X_2\beta_2+\varepsilon\big)=\beta_1+(\mathbf X_1'\mathbf X_1)^{-1}\mathbf X_1'\mathbf X_2\beta_2+(\mathbf X_1'\mathbf X_1)^{-1}\mathbf X_1'\varepsilon$$
$$E(\mathbf b_1\mid \mathbf X)=\beta_1+(\mathbf X_1'\mathbf X_1)^{-1}\mathbf X_1'\mathbf X_2\,\beta_2 .$$
O viés é $(\mathbf X_1'\mathbf X_1)^{-1}\mathbf X_1'\mathbf X_2\beta_2$, e some se $\beta_2=0$ (bloco irrelevante) ou $\mathbf X_1'\mathbf X_2=0$ (blocos ortogonais).

---

## Questão 5 (1,0)

### a) Consistência (0,5)

$$\mathbf b=\beta+\left(\frac{\mathbf X'\mathbf X}{n}\right)^{-1}\left(\frac{\mathbf X'\varepsilon}{n}\right)$$

Condições: $\operatorname{plim}(\mathbf X'\mathbf X/n)=\mathbf Q$ finita e positiva definida, e $\operatorname{plim}(\mathbf X'\varepsilon/n)=0$ — esta última vale porque a média é zero e a variância, $\sigma^2\mathbf Q/n$, tende a zero (convergência em média quadrática). Pela regra do produto dos plims,
$$\operatorname{plim}(\mathbf b-\beta)=\mathbf Q^{-1}\cdot 0=0 .$$

### b) Normalidade assintótica e o JB (0,5)

$$\sqrt n\,(\mathbf b-\beta)\ \xrightarrow{d}\ N\big(0,\ \sigma^2\mathbf Q^{-1}\big),$$
obtida aplicando o TLC a $\mathbf X'\varepsilon/\sqrt n$ e o teorema de Slutsky ao fator $(\mathbf X'\mathbf X/n)^{-1}$.

Com $n$ grande, $\mathbf b$ é aproximadamente normal **mesmo com erro não normal**, e a inferência passa a usar $z$ e $\chi^2$. Por isso o Jarque-Bera perde relevância prática: normalidade é exigida só para a distribuição **exata** de $t$ e $F$ em amostras pequenas.

---

## Questão 6 (1,0)

### a) Forma reduzida e covariância (0,5)

Substituindo o consumo na identidade:
$$Y_t=C_t+I_t=\beta_0+\beta_1Y_t+\mu_t+I_t\ \Longrightarrow\ Y_t=\frac{\beta_0+I_t+\mu_t}{1-\beta_1}.$$

$$\operatorname{Cov}(Y_t,\mu_t)=\frac{\operatorname{Cov}(\mu_t,\mu_t)}{1-\beta_1}=\frac{\sigma^2}{1-\beta_1}\ \gt 0 .$$

O regressor é correlacionado com o erro **por construção**: é o problema de simultaneidade.

### b) Inconsistência e instrumento (0,5)

Com $\operatorname{Var}(Y_t)=\dfrac{\sigma_I^2+\sigma^2}{(1-\beta_1)^2}$:
$$\operatorname{plim}\widehat\beta_1=\beta_1+\frac{\operatorname{Cov}(Y,\mu)}{\operatorname{Var}(Y)}=\beta_1+\frac{(1-\beta_1)\sigma^2}{\sigma_I^2+\sigma^2}\ \gt\ \beta_1 ,$$
já que $0\lt\beta_1\lt 1$. A inconsistência é **positiva**: o MQO superestima a propensão marginal a consumir, e o problema não desaparece com mais dados.

**Instrumento natural:** o investimento $I_t$ — entra na identidade (logo é correlacionado com a renda: relevante) e é não correlacionado com $\mu_t$ por hipótese (exógeno).

---

## Fechamento

| Questão | Tema | Pontos | Sua nota |
|---|---|---|---|
| 1 | Output de produção, F restrito, diagnósticos | 2,5 | |
| 2 | Output de MQ2E, relevância, Wu-Hausman, identificação exata | 2,5 | |
| 3 | Gauss-Markov matricial | 1,5 | |
| 4 | FWL e viés de omissão particionado | 1,5 | |
| 5 | Consistência e normalidade assintótica | 1,0 | |
| 6 | Simultaneidade | 1,0 | |
| | **Total** | **10,0** | |

<!-- conferência numérica: valores conferidos contra resultados/*.csv pelo scripts/check_numbers.R — 
| chave_R | nota |
|---|---|
| bnc_crs86_F | 14,667 |
| bnc_crs86_soma | 1,04646 |
| bnc_crs86_ep_soma | 0,0121322 |
| bnc_crs86_t | 3,8298 |
| bnc_crs86_jb | 0,943735 |
| bnc_crs86_reset | 1,6174 |
| bnc_crs86_bp | 4,3716 |
| bnc_crs86_white | 10,912 |
-->
