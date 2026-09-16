---
title: "Simulado 01 — gabarito com rubrica"
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
  - Gabarito Simulado 01
---

# Simulado 01 — gabarito

> [!TIP]
> **Como se corrigir**
> Some os pontos por **passo**, não por resultado final. Passo escrito e justificado vale ponto mesmo com erro de conta; resultado certo sem hipótese escrita perde metade. Anote cada erro em [log_erros.md](../log_erros.md) com a causa (não sabia, esqueci, errei conta, li errado).

---

## Questão 1 (2,5)

### a) Jarque-Bera rejeita a normalidade: invalida a inferência? (0,5)

```text
Hipóteses:   H0: resíduos normais   vs   H1: não normais
Estatística: JB = 72,4653 ~ χ²(2)
Decisão:     72,4653 > 5,99  (p < 0,0001)  ⇒  rejeita-se H0
Conclusão:   os resíduos não são normais.
```

**Não invalida.** A normalidade (A6) é necessária para a inferência **exata** em amostra pequena, onde $t$ e $F$ têm distribuição exata. Com $n=534$, vale o Teorema do Limite Central: $b$ é **assintoticamente normal** mesmo com erro não normal, porque é uma soma ponderada dos erros. A tabela já reporta `P[|Z|>z]`, ou seja, usa a distribuição normal assintótica. A inferência segue válida.

| Rubrica | Pontos |
|---|---|
| Hipóteses e decisão corretas do JB | 0,2 |
| Distinguir inferência exata (amostra pequena) de assintótica | 0,2 |
| Citar o TLC e o uso de $z$ | 0,1 |

> [!TIP]
> **Ponto extra que quase ninguém escreve**
> O RESET dá $F=6{,}10$ com $p=0{,}0024$: há evidência de **má especificação**. Isso, sim, é um problema sério — pode ser forma funcional ou variável omitida, e nesse caso o estimador é viesado. Já o Breusch-Pagan ($p=0{,}2244$) não rejeita homocedasticidade.

### b) Significância de ED (0,5)

```text
Hipóteses:   H0: β2 = 0 (educação não afeta o salário)   vs   H1: β2 ≠ 0
Estatística: t = b/E.p. = 0,08664015 / 0,00799421 = 10,838  (~ N(0,1))
Decisão:     |10,838| > 1,96  (p = 0,0000 < 0,05)  ⇒  rejeita-se H0
Conclusão:   ED é estatisticamente significativa. Cada ano adicional de educação eleva o
             salário-hora em cerca de 8,66% (exatamente 100(e^0,08664 − 1) = 9,05%),
             mantidas constantes as demais variáveis.
```

| Rubrica | Pontos |
|---|---|
| Hipóteses | 0,15 |
| Estatística e comparação com o crítico | 0,2 |
| Interpretação semi-elástica | 0,15 |

### c) Ponto de máximo da experiência (0,5)

Modelo quadrático em EXP: derive e iguale a zero.

$$\frac{\partial \text{LWAGE}}{\partial \text{EXP}}=\beta_3+2\beta_4\text{EXP}=0\ \Longrightarrow\ \text{EXP}^*=-\frac{\beta_3}{2\beta_4}=-\frac{0{,}03374252}{2(-0{,}00051392)}=32{,}83\ \text{anos}.$$

Como $\beta_4\lt 0$, a segunda derivada $2\beta_4$ é negativa: é **máximo**. Depois de ~32,8 anos de experiência, tudo mais constante, o log-salário passa a **cair** — o perfil experiência-salário é côncavo.

| Rubrica | Pontos |
|---|---|
| Derivada igualada a zero | 0,2 |
| Valor numérico correto | 0,2 |
| Justificar máximo pelo sinal e dizer o que acontece depois | 0,1 |

### d) Intervalo de confiança de 95% para ED (0,5)

$$IC=\big[\hat\beta_2\pm z_{0,025}\,\text{E.p.}\big]=\big[0{,}08664015\pm 1{,}96\times 0{,}00799421\big]=[0{,}07097;\ 0{,}10231].$$

**Interpretação.** Em 95 de cada 100 amostras, intervalos construídos deste modo conteriam o verdadeiro $\beta_2$. Como o intervalo não contém zero, a conclusão é a mesma do item (b). O aleatório é o intervalo, não o parâmetro.

| Rubrica | Pontos |
|---|---|
| Fórmula e conta | 0,3 |
| Interpretação frequentista correta | 0,2 |

### e) Coeficiente de FEM (0,25)

$\hat\beta_5=-0{,}23429$. Como FEM é dummy e a dependente está em log, é semi-elasticidade: mulheres ganham cerca de **23,4% menos** (aproximação), ou **20,9% menos** pelo cálculo exato $100(e^{-0{,}23429}-1)$, em relação aos homens com as mesmas características observadas.

| Rubrica | Pontos |
|---|---|
| Aproximação e categoria base explícita | 0,15 |
| Cálculo exato | 0,10 |

### f) $R^2$ ajustado (0,25)

$\bar R^2=0{,}32014$: cerca de 32% da variação do log-salário é explicada conjuntamente pelas explicativas, **corrigido pelos graus de liberdade**. A vantagem sobre o $R^2$ é penalizar a inclusão de regressores: o $R^2$ nunca cai quando se acrescenta variável, enquanto o $\bar R^2$ só sobe se a nova variável tiver $\lvert t\rvert\gt 1$.

---

## Questão 2 (2,5)

### a) Endógena, instrumentos e propriedades (0,5)

**Endógena:** EDUC (correlacionada com a habilidade não observada, que está no erro). **Instrumentos externos:** MOTHEDUC e FATHEDUC. **Exógenas incluídas:** constante, EXPER e EXPERSQ, que também entram na lista de instrumentos.

**Propriedades de um instrumento válido:**
1. **Relevância:** $\operatorname{Cov}(Z,X)\neq 0$ — correlacionado com a endógena (testável pelo $F$ do primeiro estágio).
2. **Exogeneidade:** $\operatorname{Cov}(Z,\varepsilon)=0$ — não correlacionado com o erro; só afeta $y$ **através** de $X$ (testável apenas sob sobreidentificação).

### b) Instrumentos fracos (0,5)

```text
Hipóteses:   H0: instrumentos fracos   vs   H1: instrumentos fortes
Estatística: F = 55,400 (2 e 423 gl), p = 0,0000
Decisão:     p = 0,0000 < 0,05  ⇒  rejeita-se H0
Conclusão:   os instrumentos são relevantes (F muito acima da regra prática de 10).
```

### c) MQO ou MQ2E, a 5% e a 10%? (0,75)

```text
Hipóteses:   H0: EDUC exógena (MQO consistente e eficiente)  vs  H1: EDUC endógena (só MQ2E consistente)
Estatística: Wu-Hausman F = 2,793 (1 e 423 gl), p = 0,0954
Decisão a 5%:  0,0954 > 0,05  ⇒  NÃO se rejeita H0  ⇒  usa-se MQO
Decisão a 10%: 0,0954 < 0,10  ⇒  rejeita-se H0      ⇒  usa-se MQ2E
```

**Por que muda.** O p-valor cai entre os dois níveis: a evidência de endogeneidade é **marginal**. A 5% não há evidência suficiente e prefere-se o MQO, que sob $H_0$ é consistente **e eficiente** (menor variância — repare que o erro-padrão de EDUC é 0,0141 no MQO contra 0,0314 no MQ2E). A 10% conclui-se pela endogeneidade e aceita-se perder precisão em troca de consistência.

| Rubrica | Pontos |
|---|---|
| Hipóteses corretas (incluindo "eficiente" em H0) | 0,25 |
| Decisão a 5% | 0,2 |
| Decisão a 10% | 0,2 |
| Explicar o trade-off consistência × eficiência | 0,1 |

### d) Validade dos instrumentos (0,5)

```text
Hipóteses:   H0: todos os instrumentos são válidos (exógenos)   vs   H1: ao menos um é inválido
Estatística: Sargan = 0,378 ~ χ²(1)
Decisão:     p = 0,5386 > 0,05  ⇒  não se rejeita H0
Conclusão:   não há evidência contra a validade dos instrumentos.
```

**Por que foi possível.** Há **sobreidentificação**: dois instrumentos externos (MOTHEDUC, FATHEDUC) para uma endógena, logo $L-K=1$ grau de liberdade. No caso exatamente identificado (um instrumento para uma endógena) o teste não existe.

### e) Interpretação e comparação com o MQO (0,25)

$\hat\beta_{EDUC}=0{,}06140$: cada ano adicional de educação eleva o salário em cerca de 6,14% (exato 6,33%). Por MQO, 10,75%. O MQO é **quase o dobro**, o que sugere **viés de habilidade**: quem estuda mais tende a ter características não observadas que elevam o salário, e o MQO atribui esse efeito à educação. Ressalva: o estimador de MQ2E é bem menos preciso ($p=0{,}0508$, no limite da significância).

---

## Questão 3 (1,5)

### a) Equações normais (0,5)

Minimize $S(\hat\beta_1,\hat\beta_2)=\sum_i (Y_i-\hat\beta_1-\hat\beta_2X_i)^2$:

$$\frac{\partial S}{\partial\hat\beta_1}=-2\sum_i(Y_i-\hat\beta_1-\hat\beta_2X_i)=0\ \Longrightarrow\ \sum_iY_i=n\hat\beta_1+\hat\beta_2\sum_iX_i$$

$$\frac{\partial S}{\partial\hat\beta_2}=-2\sum_iX_i(Y_i-\hat\beta_1-\hat\beta_2X_i)=0\ \Longrightarrow\ \sum_iX_iY_i=\hat\beta_1\sum_iX_i+\hat\beta_2\sum_iX_i^2$$

### b) Solução (0,75)

Divida a primeira por $n$: $\bar Y=\hat\beta_1+\hat\beta_2\bar X$, logo $\boxed{\hat\beta_1=\bar Y-\hat\beta_2\bar X}$.

Substitua na segunda:
$$\sum_iX_iY_i=(\bar Y-\hat\beta_2\bar X)\sum_iX_i+\hat\beta_2\sum_iX_i^2=n\bar X\bar Y+\hat\beta_2\Big(\sum_iX_i^2-n\bar X^2\Big),$$
e isole:
$$\hat\beta_2=\frac{\sum_iX_iY_i-n\bar X\bar Y}{\sum_iX_i^2-n\bar X^2}=\frac{\sum_i(X_i-\bar X)(Y_i-\bar Y)}{\sum_i(X_i-\bar X)^2}.$$

A última igualdade usa as identidades de somatório $\sum(X_i-\bar X)(Y_i-\bar Y)=\sum X_iY_i-n\bar X\bar Y$ e $\sum(X_i-\bar X)^2=\sum X_i^2-n\bar X^2$.

### c) Propriedades dos resíduos (0,25)

São as próprias condições de primeira ordem: a derivada em $\hat\beta_1$ dá $\sum_i\hat u_i=0$ e a derivada em $\hat\beta_2$ dá $\sum_iX_i\hat u_i=0$. Não dependem de hipótese sobre o erro: valem por construção, desde que haja intercepto.

| Rubrica | Pontos |
|---|---|
| CPOs corretas (a) | 0,5 |
| Intercepto isolado | 0,25 |
| Inclinação com as identidades (b) | 0,5 |
| Propriedades dos resíduos (c) | 0,25 |

---

## Questão 4 (1,5)

### a) O viés (1,0)

O estimador da regressão curta é $\tilde\beta_2=\dfrac{\sum_i x_{i2}Y_i}{\sum_i x_{i2}^2}$, com $x_{i2}=X_{i2}-\bar X_2$. Substitua o modelo **verdadeiro**:

$$\tilde\beta_2=\frac{\sum_i x_{i2}(\beta_1+\beta_2X_{i2}+\beta_3X_{i3}+u_i)}{\sum_i x_{i2}^2}=\beta_2+\beta_3\frac{\sum_i x_{i2}X_{i3}}{\sum_i x_{i2}^2}+\frac{\sum_i x_{i2}u_i}{\sum_i x_{i2}^2},$$

usando $\sum x_{i2}=0$ e $\sum x_{i2}X_{i2}=\sum x_{i2}^2$. Tomando a esperança condicional em $X$ e usando $E[u_i\mid X]=0$:

$$E[\tilde\beta_2\mid X]=\beta_2+\beta_3\underbrace{\frac{\sum_i(X_{i2}-\bar X_2)X_{i3}}{\sum_i(X_{i2}-\bar X_2)^2}}_{\hat\delta}\ \Longrightarrow\ \text{viés}=\beta_3\hat\delta .$$

$\hat\delta$ é o coeficiente da regressão auxiliar de $X_3$ em $X_2$.

### b) Quando desaparece e qual o sinal (0,5)

O viés é zero se $\beta_3=0$ (a variável omitida era irrelevante) **ou** se $\hat\delta=0$ ($X_2$ e $X_3$ ortogonais na amostra). Com $\beta_3\gt 0$ e correlação positiva entre $X_2$ e $X_3$ ($\hat\delta\gt 0$), o viés é **positivo**: o estimador curto superestima $\beta_2$, porque atribui a $X_2$ parte do efeito de $X_3$.

| Rubrica | Pontos |
|---|---|
| Substituir o modelo verdadeiro | 0,3 |
| Usar as propriedades dos desvios | 0,2 |
| Esperança condicional e expressão do viés | 0,5 |
| Condições de anulação e sinal | 0,5 |

---

## Questão 5 (1,5)

### a) Não-viés (0,5)

$$b=(X'X)^{-1}X'y=(X'X)^{-1}X'(X\beta+\varepsilon)=\beta+(X'X)^{-1}X'\varepsilon .$$
$$E[b\mid X]=\beta+(X'X)^{-1}X'\underbrace{E[\varepsilon\mid X]}_{=0}=\beta .$$

### b) Matriz de variância-covariância (0,5)

$$\operatorname{var-cov}(b\mid X)=E\big[(b-\beta)(b-\beta)'\mid X\big]=E\big[(X'X)^{-1}X'\varepsilon\varepsilon'X(X'X)^{-1}\mid X\big]$$
$$=(X'X)^{-1}X'\underbrace{E[\varepsilon\varepsilon'\mid X]}_{\sigma^2I}X(X'X)^{-1}=\sigma^2(X'X)^{-1}X'X(X'X)^{-1}=\sigma^2(X'X)^{-1}.$$

### c) Consistência (0,5)

Divida por $n$ dentro dos fatores:
$$b=\beta+\left(\frac{X'X}{n}\right)^{-1}\left(\frac{X'\varepsilon}{n}\right).$$
Com $\operatorname{plim}(X'X/n)=Q$ finita e positiva definida, e $\operatorname{plim}(X'\varepsilon/n)=0$ (a média tem esperança zero e variância $\sigma^2Q/n\to 0$, logo converge em média quadrática), a regra do produto dos plims dá
$$\operatorname{plim}(b-\beta)=Q^{-1}\cdot 0=0\ \Longrightarrow\ \operatorname{plim}b=\beta .$$

| Rubrica | Pontos |
|---|---|
| Identidade $b=\beta+(X'X)^{-1}X'\varepsilon$ | 0,25 |
| Esperança condicional e conclusão (a) | 0,25 |
| Passos da variância, com $E[\varepsilon\varepsilon'\mid X]=\sigma^2I$ (b) | 0,5 |
| Dividir por $n$, citar as duas condições e concluir (c) | 0,5 |

---

## Questão 6 (1,0)

### a) Covariância e hipótese violada (0,5)

$$\operatorname{Cov}(z_i,X_i)=\operatorname{Cov}(\mu_i-\beta w_i,\ X_i^*+w_i)=-\beta\operatorname{Var}(w_i)=-\beta\sigma_w^2\ \neq 0 .$$

Viola-se a **exogeneidade** ($E[z\mid X]=0$, hipótese A3): o regressor observado é correlacionado com o termo de erro. O estimador de MQO fica viesado **e** inconsistente.

### b) O plim e a leitura (0,5)

$$\operatorname{plim}\hat\beta=\beta+\frac{\operatorname{Cov}(z,X)}{\operatorname{Var}(X)}=\beta-\frac{\beta\sigma_w^2}{\sigma^2_{X^*}+\sigma^2_w}=\beta\cdot\frac{\sigma^2_{X^*}}{\sigma^2_{X^*}+\sigma^2_w}.$$

Como o fator está entre 0 e 1, $\lvert\operatorname{plim}\hat\beta\rvert\lt\lvert\beta\rvert$: **viés de atenuação**, sempre em direção a zero, tanto maior quanto maior o erro de medição. **Não** desaparece com amostras maiores — é inconsistência, não imprecisão. A solução é variável instrumental (por exemplo, uma segunda medida independente da mesma variável).

| Rubrica | Pontos |
|---|---|
| Covariância calculada e hipótese nomeada | 0,5 |
| plim com o fator de atenuação e conclusão sobre $n$ | 0,5 |

---

## Fechamento

| Questão | Tema | Pontos | Sua nota |
|---|---|---|---|
| 1 | Output MQO, dummy em log, quadrática, IC, JB | 2,5 | |
| 2 | Output MQ2E, três testes, comparação com MQO | 2,5 | |
| 3 | Derivação escalar | 1,5 | |
| 4 | Viés de variável omitida | 1,5 | |
| 5 | Não-viés, variância e consistência matriciais | 1,5 | |
| 6 | Erro de medição no regressor | 1,0 | |
| | **Total** | **10,0** | |

Abaixo de 7,0, repita as derivações das questões perdidas no dia seguinte e refaça o simulado inteiro em uma semana.
