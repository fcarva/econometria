---
title: "Econometria I — Prova 2025/2 resolvida (mapa da 1ª prova)"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
prova: 1ª prova — 03/10/2025 (turma 2025/2)
relevancia: mesmo professor, mesma ementa — molde da sua prova de 02/10
tags:
  - econometria
  - mestrado/ppgeco
  - prova
  - mqo
  - variaveis-instrumentais
aliases:
  - Prova Zambon 2025/2
  - Simulado Econometria I
  - Gabarito 1a prova Econometria
---

# Econometria I — Prova 2025/2 resolvida (o molde da sua prova)

> [!abstract] Por que este documento é ouro
> Esta é a **1ª prova real do Zambon** aplicada em **03/10/2025** para a turma 2025/2 — mesmo professor, mesma ementa (PECO-5021/6021), mesmo estilo que você vai encontrar em **02/10**. Ter a prova *com gabarito* significa que você sabe **exatamente** o que estudar e em que formato responder.
>
> A leitura-chave: **as demonstrações que caem são precisamente as do seu [[Demonstrações Econometria I mês 1]]**. A Questão 3 é D3+D4+D6; a Questão 5 é D14 + consistência. Este documento (1) mapeia cada questão às demonstrações que você já domina, (2) reproduz o padrão de resposta das questões aplicadas (interpretação de output), e (3) **preenche os três tópicos que a prova cobrou e que o doc de demonstrações ainda não tinha**: viés por erro de medição (Q4), consistência assintótica (Q5) e o estimador IV (Q6).

> [!warning] Isto não é a sua prova — é o molde
> As questões de 2026 serão diferentes nos números e nos dados, mas o **esqueleto é estável**: 1–2 questões de interpretação de output (LWAGE, cigarros) + 3–4 demonstrações (equações normais, viés, variância, consistência, IV). Estude o *tipo*, não o gabarito específico.

---

## 🗺️ Mapa da prova → suas demonstrações

| Questão | Assunto | O que cobra | No seu doc |
|---------|---------|-------------|------------|
| **Q1** | Output MQO (retornos da escolaridade, Cornwell-Rupert) | Interpretação aplicada: JB, teste $t$, ponto de máximo, IC, dummy, $\bar R^2$ | aplicação de D9–D14 |
| **Q2** | Output IV (cigarros, Stock-Watson) | Endogeneidade, relevância/exogeneidade, Wu-Hausman, Sargan, teste $\chi^2$ conjunto | **novo → §Q2** |
| **Q3** | Derivação escalar do MQO | Equações normais + $\hat a$ + $\hat b$ | **D3 + D4 + D6** ✅ |
| **Q4** | Viés por erro de medição | Prova de (não-)viés com regressor medido com erro | **novo → §Q4** |
| **Q5** | Variância e consistência matricial | $\operatorname{Var}(b)=\sigma^2(X'X)^{-1}$ + consistência assintótica | **D14** ✅ + **novo (consistência) → §Q5** |
| **Q6** | Estimador de variáveis instrumentais | Derivar $\hat\beta_{IV}$ via $\text{plim}$ | **novo → §Q6** |

> [!tip] Distribuição de esforço
> Metade da nota é **demonstração** (Q3–Q6) e metade é **interpretação de output** (Q1–Q2). As demonstrações você já treina no doc irmão. Este aqui foca no que falta: as **três derivações novas** e o **vocabulário de interpretação** que o Zambon premia.

---
---

# PARTE A · Interpretação de output (Q1 e Q2)

> Estas questões dão uma tabela de regressão pronta e pedem leitura. Não há conta pesada — há **vocabulário correto** e **decisão estatística**. O Zambon valoriza resposta enxuta e precisa. Abaixo, o padrão de cada tipo.

## Q1 · Retornos da escolaridade (modelo LWAGE)

Modelo estimado por MQO (Cornwell-Rupert 1988, tratado como corte transversal, $n = 4165$):
$$\text{LWAGE}_i = a_1 + a_2 \text{ED}_i + a_3 \text{EXP}_i + a_4 \text{EXP}_i^2 + a_5\text{OCC}_i + a_6\text{IND}_i + a_7\text{SOUTH}_i + a_8\text{SMSA}_i + a_9\text{BLK}_i + a_{10}\text{WKS}_i + \varepsilon_i.$$

### (a) Precisa de teste Jarque-Bera com $n = 4165$?

> [!note] Padrão de resposta
> **Não.** Com amostra grande ($n = 4165$), pelo **Teorema do Limite Central** a distribuição dos estimadores de MQO é aproximadamente normal independentemente da distribuição dos erros. Como o vetor de parâmetros de MQO depende de uma **soma** dos erros (ver a identidade $\hat\beta = \beta + \sum k_i\varepsilon_i$, D9), essa soma converge para a normal quando $n\to\infty$. O teste JB de normalidade dos resíduos importa em **amostras pequenas**, onde a inferência exata ($t$, $F$) depende da hipótese de normalidade; aqui, é dispensável.

### (b) Teste se EXP é significativo ($\alpha = 5\%$, $z$ crítico $= 1{,}96$)

> [!note] Padrão de resposta
> **Hipóteses:** $H_0: a_3 = 0$ (EXP não é significativo) vs. $H_1: a_3 \neq 0$.
> **Estatística:** o output dá $b/\text{E.p.} = 18{,}677$ para EXP. Como $|18{,}677| > 1{,}96$, **rejeita-se $H_0$**. Logo EXP é estatisticamente significativo e se relaciona com LWAGE. (No gabarito, o mesmo raciocínio aparece via $p$-valor $= 0{,}0000 < 0{,}05$.)

### (c) Após quantos anos de EXP o log-salário atinge o máximo?

> [!note] Padrão de resposta (com o cálculo)
> Como o modelo é quadrático em EXP, deriva-se e iguala-se a zero:
> $$\frac{\partial\,\text{LWAGE}}{\partial\,\text{EXP}} = a_3 + 2a_4\text{EXP} = 0 \;\Longrightarrow\; \text{EXP}^* = -\frac{a_3}{2a_4}.$$
> Substituindo os coeficientes ($a_3 = 0{,}04292$, $a_4 = -0{,}00070803$):
> $$\text{EXP}^* = -\frac{0{,}04292}{2(-0{,}00070803)} \approx 30{,}30 \text{ anos.}$$
> Como $a_4 < 0$ (parábola côncava), é um **máximo**. Depois de ~30,3 anos de experiência, mantido tudo constante, o salário **começa a cair**. É o formato clássico de perfil idade-salário.

### (d) IC de 95% para o coeficiente de ED ($z$ crítico $= 1{,}96$)

> [!note] Padrão de resposta
> $$\text{IC}_{a_2}: \big[\hat a_2 \pm \text{E.p.}(\hat a_2)\cdot z_{\alpha/2}\big] = \big[0{,}06112766 \pm 0{,}00277226 \cdot 1{,}96\big] \approx [0{,}0557;\; 0{,}0665].$$
> **Interpretação:** em 95 de cada 100 amostras, o intervalo construído deste modo conterá o verdadeiro $a_2$. (Cuidado com a leitura frequentista: é o *intervalo* que é aleatório, não o parâmetro.)

### (e) Interprete o coeficiente de SOUTH

> [!note] Padrão de resposta
> $\hat a_7 = -0{,}07629$. Como SOUTH é dummy e LWAGE é log, a interpretação é semi-elástica: quem reside no **Sul** tem salário aproximadamente **7,63% menor**, tudo mais constante, do que quem não reside. (Para precisão, o efeito percentual exato seria $(e^{-0{,}07629}-1)\times 100 \approx -7{,}35\%$, mas a aproximação linear é aceita.)

### (f) Interprete o $R^2$ ajustado

> [!note] Padrão de resposta
> $\bar R^2 = 0{,}3431$. Cerca de **34,31%** da variação de LWAGE é explicada pela variação conjunta das variáveis explicativas, **corrigida pelos graus de liberdade** (o ajuste penaliza a inclusão de regressores que não melhoram o ajuste o suficiente).

---

## Q2 · Demanda por cigarros (modelo IV / MQ2E)

Modelo estimado por **variáveis instrumentais** (Stock-Watson 2007, `ivreg`/AER, 48 estados, 1995):
$$\log(\text{packs}) = a_1 + a_2\log(\text{price}) + a_3\log(\text{renda}) + \varepsilon.$$

> [!info] Contexto: por que IV aqui
> Preço é **endógeno** — determinado simultaneamente com a quantidade (oferta e demanda). MQO seria viesado. Usam-se instrumentos ($\text{tdiff}$ e $\text{tax}/\text{cpi}$) para isolar a variação exógena do preço.

### (a) Qual variável é endógena e quais são instrumentos?

> [!note] Padrão de resposta
> **Endógena:** $\log(\text{price})$. **Exógenas/instrumentos:** $\log(\text{renda})$ (exógena, entra na regressão), $\text{tdiff}$ e $\text{tax}/\text{cpi}$ (instrumentos externos para o preço). Na sintaxe do `ivreg`, tudo à direita da barra `|` são os instrumentos.

### (b) As duas propriedades de um instrumento válido

> [!note] Padrão de resposta
> 1. **Relevância:** $\operatorname{Cov}(Z, X) \neq 0$ — o instrumento é correlacionado com a variável endógena (senão não identifica nada).
> 2. **Exogeneidade:** $\operatorname{Cov}(Z, \varepsilon) = 0$ — o instrumento **não** é correlacionado com o termo de erro (só afeta $y$ *através* de $X$).

### (c) Wu-Hausman ($\alpha = 5\%$): MQO ou MQ2E?

> [!note] Padrão de resposta
> **Hipóteses:** $H_0$: MQO e IV consistentes, MQO eficiente (isto é, $X$ exógeno) vs. $H_1$: só IV consistente (isto é, $X$ endógeno).
> **Decisão:** $p$-valor $= 0{,}0469 < 0{,}05$ → **rejeita-se $H_0$**. Logo há endogeneidade e o **MQ2E é o método consistente**.

### (d) Teste de instrumentos fracos ($\alpha = 5\%$)

> [!note] Padrão de resposta
> **Hipóteses:** $H_0$: instrumentos fracos vs. $H_1$: instrumentos fortes.
> **Decisão:** $p$-valor $= 0{,}0000 < 0{,}05$ (estatística Weak instruments $= 228{,}738$) → **rejeita-se $H_0$**. Os instrumentos são **fortes** (relevantes). Não há problema de instrumento fraco.

### (e) Teste de sobreidentificação / validade (Sargan, $\alpha = 5\%$)

> [!note] Padrão de resposta
> **Hipóteses:** $H_0$: instrumentos válidos (exógenos) vs. $H_1$: ao menos um inválido.
> **Decisão:** $p$-valor $= 0{,}8468 > 0{,}05$ → **não se rejeita $H_0$**. Os instrumentos são **válidos** (exógenos). O teste de Sargan só é possível porque há **sobreidentificação** (2 instrumentos para 1 endógena).

### (f) Significância conjunta dos efeitos marginais ($\chi^2$ crítico $= 11{,}07$)

> [!note] Padrão de resposta
> **Hipóteses:** $H_0: a_2 = a_3 = 0$ vs. $H_1$: ao menos um $\neq 0$.
> **Decisão:** compara-se a estatística de Wald ($34{,}51$) com o $\chi^2$ crítico ($11{,}07$). Como $34{,}51 > 11{,}07$, cai na região de rejeição → **rejeita-se $H_0$**. Os coeficientes são **conjuntamente significativos**.

### (g) Interprete o coeficiente de $\log(\text{price})$

> [!note] Padrão de resposta
> $\hat a_2 = -1{,}2774$. Como é modelo log-log, é uma **elasticidade**: para cada aumento de **1% no preço**, a demanda por maços de cigarros **cai ~1,28%**. (Demanda elástica: $|{-}1{,}28| > 1$.)

---
---

# PARTE B · As três demonstrações novas

> Estas caíram na prova de 2025/2 e **ainda não estavam** no seu doc de demonstrações. Aqui vão completas, no mesmo padrão passo-a-passo.

## Q4 · Viés por erro de medição num regressor

> [!note] O que se quer provar
> Há um modelo "verdadeiro" $y_i^* = \alpha + \beta x_i + \mu_i$, mas você adota $y_i = y_i^* + \varepsilon_i$, onde $\varepsilon_i$ é **erro de medição na variável dependente**. O modelo efetivo vira:
> $$y_i = \alpha + \beta x_i + v_i, \qquad v_i = \mu_i + \varepsilon_i.$$
> Pergunta-se: o estimador $b$ de $\beta$ é **viesado ou não**? E o que acontece com sua **variância**?

**Fundamentação.** É uma variação fina do não-viés (D9). O ponto é testar se você entende *quando* o erro extra estraga o MQO. Aqui o erro está na **dependente** — e o resultado é benigno (não vicia, só infla variância). Seria diferente se o erro estivesse no **regressor** $x$ (aí sim viciaria — *errors-in-variables*). Hipóteses dadas na prova: $E[\mu_i]=E[\varepsilon_i]=0$, $E[\mu_i^2]=\sigma_\mu^2$, $E[\varepsilon_i^2]=\sigma_\varepsilon^2$, $\operatorname{Cov}(x_i,v_i)=0$, $\operatorname{Cov}(x_i,\varepsilon_i)=0$, $\operatorname{Cov}(\mu_i,\varepsilon_i)=0$, e $x$ não estocástico.

### (a) O estimador é viesado?

**Passo a passo.**

Parta do estimador de inclinação (mesma forma de D6/D9), agora com o modelo $y_i = \alpha + \beta x_i + v_i$:
$$b = \frac{\sum_i (x_i - \bar x)(y_i - \bar y)}{\sum_i (x_i - \bar x)^2} = \sum_i k_i y_i, \qquad k_i = \frac{x_i - \bar x}{\sum_j (x_j - \bar x)^2}.$$

Substitui o modelo efetivo (usando as três propriedades dos pesos de D9: $\sum k_i = 0$, $\sum k_i x_i = 1$):
$$b = \sum_i k_i(\alpha + \beta x_i + v_i) = \alpha\underbrace{\sum_i k_i}_{0} + \beta\underbrace{\sum_i k_i x_i}_{1} + \sum_i k_i v_i = \beta + \sum_i k_i v_i.$$

Tira a esperança condicional em $x$ (que é não estocástico, então os $k_i$ são constantes):
$$E[b\mid x] = \beta + \sum_i k_i\, E[v_i\mid x] = \beta + \sum_i k_i\,\underbrace{E[\mu_i + \varepsilon_i\mid x]}_{=\,0} = \beta.$$

$$\boxed{E[b\mid x] = \beta \;\Rightarrow\; \text{NÃO viesado.}}$$

> [!success] A intuição
> Erro de medição **na variável dependente** apenas engorda o termo de erro ($v = \mu + \varepsilon$), mas mantém $E[v\mid x]=0$. Como o não-viés só exige exogeneidade, o estimador continua **certo em média**. O preço aparece na variância (item b).

### (b) A variância e o que muda

**Passo a passo.**

Da identidade $b = \beta + \sum_i k_i v_i$, condicionando em $x$:
$$\operatorname{Var}(b\mid x) = \operatorname{Var}\Big(\sum_i k_i v_i \;\Big|\; x\Big) = \sum_i k_i^2\,\operatorname{Var}(v_i).$$

Como $v_i = \mu_i + \varepsilon_i$ e $\operatorname{Cov}(\mu_i,\varepsilon_i)=0$:
$$\operatorname{Var}(v_i) = \operatorname{Var}(\mu_i) + \operatorname{Var}(\varepsilon_i) = \sigma_\mu^2 + \sigma_\varepsilon^2.$$

Usando $\sum_i k_i^2 = \dfrac{1}{\sum_i (x_i - \bar x)^2}$ (propriedade iii de D9):
$$\boxed{\operatorname{Var}(b\mid x) = \frac{\sigma_\mu^2 + \sigma_\varepsilon^2}{\sum_i (x_i - \bar x)^2}.}$$

**Comparação com o modelo sem erro de medição.** No modelo original $y_i^* = \alpha + \beta x_i + \mu_i$, a variância seria:
$$\operatorname{Var}(b^*\mid x) = \frac{\sigma_\mu^2}{\sum_i (x_i - \bar x)^2}.$$

**Implicação:** como $\sigma_\varepsilon^2 > 0$,
$$\operatorname{Var}(b\mid x) = \frac{\sigma_\mu^2 + \sigma_\varepsilon^2}{\sum(x_i-\bar x)^2} > \frac{\sigma_\mu^2}{\sum(x_i-\bar x)^2} = \operatorname{Var}(b^*\mid x).$$

> [!warning] A conclusão que o Zambon quer
> O erro de medição na dependente **não vicia** o MQO, mas **aumenta a variância** do estimador → reduz a precisão. Você acerta em média, mas com menos confiança. (No caderno: *"Aumento na variância reduz a precisão."*) É o trade-off que aparece o tempo todo em econometria aplicada.

---

## Q5 · Variância e consistência do MQO matricial

> [!note] O que se quer provar
> Duas coisas, no modelo $y = X\beta + \varepsilon$ com $E[\varepsilon\mid X]=0$ e $E[\varepsilon\varepsilon'\mid X]=\sigma^2 I$:
> 1. **Variância:** $\operatorname{Var}(b\mid X) = \sigma^2(X'X)^{-1}$ (isto é a **D14** — já demonstrada).
> 2. **Consistência:** $\text{plim}_{n\to\infty}\, b = \beta$ (isto é **novo** — a parte assintótica).

### Parte 1 — Variância → ver D14

A demonstração completa está em [[Demonstrações Econometria I mês 1#D14]]. Resumo do fio:
$$b = \beta + (X'X)^{-1}X'\varepsilon \;\Rightarrow\; \operatorname{Var}(b\mid X) = (X'X)^{-1}X'\underbrace{E[\varepsilon\varepsilon'\mid X]}_{\sigma^2 I}X(X'X)^{-1} = \sigma^2(X'X)^{-1}.$$

### Parte 2 — Consistência (a novidade)

**Fundamentação.** Não-viés é propriedade de amostra finita; **consistência** é o que acontece quando $n\to\infty$. Um estimador é consistente se converge em probabilidade para o parâmetro. É a base de toda a econometria assintótica (aulas de 11/09 em diante).

**Passo a passo.**

Parta da identidade fundamental e **divida por $n$** dentro dos fatores (o truque assintótico):
$$b = \beta + (X'X)^{-1}X'\varepsilon = \beta + \left(\frac{X'X}{n}\right)^{-1}\left(\frac{X'\varepsilon}{n}\right).$$

Subtraia $\beta$ e tome o limite em probabilidade:
$$\text{plim}(b - \beta) = \text{plim}\left[\left(\frac{X'X}{n}\right)^{-1}\left(\frac{X'\varepsilon}{n}\right)\right].$$

**Peça 1 — o primeiro fator converge para uma matriz finita e inversível.** Assume-se (condição de regularidade) que
$$\text{plim}\,\frac{X'X}{n} = Q, \qquad Q \text{ finita e positiva definida (inversível).}$$

**Peça 2 — o segundo fator converge para zero.** Pela exogeneidade, $E[X'\varepsilon] = 0$, e sob condições de momento (LGN):
$$\text{plim}\,\frac{X'\varepsilon}{n} = 0.$$

**Junta pela regra do produto dos plim (Slutsky):**
$$\text{plim}(b - \beta) = Q^{-1}\cdot 0 = 0 \;\Longrightarrow\; \boxed{\text{plim}\,b = \beta.}$$

MQO é **consistente**. $\blacksquare$

> [!info] O que o caderno registra
> No gabarito aparece explicitamente a linha $E[b-\beta] = \frac{\sigma^2}{n}(Q)^{-1}$ e depois $\lim_{n\to\infty}\frac{\sigma^2}{n}(Q)^{-1} = 0 \Rightarrow$ **consistente** — mostrando que a *variância* também colapsa a zero quando $n\to\infty$. Variância indo a zero + não-viés é, aliás, uma forma alternativa (suficiente) de provar consistência.

> [!success] 🎯 Ponte com a tese
> Consistência é o que autoriza você a confiar nas estimativas do seu [[DiD]] em amostras grandes de painel, mesmo quando as propriedades de amostra finita são difíceis de garantir. É o alicerce assintótico de toda a inferência causal aplicada.

---

## Q6 · O estimador de variáveis instrumentais

> [!note] O que se quer provar
> No modelo $y = X\beta + \varepsilon$ com **endogeneidade** $E[\varepsilon\mid X] = \eta \neq 0$ (e $\text{plim}\,\frac{X'\varepsilon}{n}\neq 0$, o que faz MQO ser **inconsistente**), suponha $L$ instrumentos na matriz $Z$ com $L = K$ (tantos instrumentos quanto regressores). Usando a condição $\text{plim}\left(\frac{Z'\varepsilon}{n}\right) = 0$, derivar:
> $$\boxed{\hat\beta_{IV} = (Z'X)^{-1}Z'y.}$$

**Fundamentação.** É a solução para endogeneidade — o núcleo de inferência causal (aula de 25/09). Quando $X$ é correlacionado com o erro, MQO mente; o instrumento $Z$ (correlacionado com $X$, mas não com $\varepsilon$) recupera a consistência. Este é o caso **exatamente identificado** ($L = K$).

**Passo a passo.**

Parta da condição de exogeneidade dos instrumentos (é a hipótese que *define* o IV):
$$\text{plim}\left(\frac{Z'\varepsilon}{n}\right) = 0.$$

Substitua $\varepsilon = y - X\beta$:
$$\text{plim}\left(\frac{Z'(y - X\beta)}{n}\right) = 0.$$

Distribua:
$$\text{plim}\left(\frac{Z'y}{n}\right) - \text{plim}\left(\frac{Z'X}{n}\right)\beta = 0.$$

Isole $\beta$ (a relevância garante que $\text{plim}\,\frac{Z'X}{n}$ é inversível):
$$\beta = \left[\text{plim}\left(\frac{Z'X}{n}\right)\right]^{-1}\text{plim}\left(\frac{Z'y}{n}\right).$$

O **análogo amostral** (trocando plim por médias amostrais e cancelando os $n$) é o estimador IV:
$$\boxed{\hat\beta_{IV} = (Z'X)^{-1}Z'y.} \qquad \blacksquare$$

> [!info] Leitura da estrutura
> Repare que $\hat\beta_{IV} = (Z'X)^{-1}Z'y$ tem a **mesma cara** do MQO $\hat\beta = (X'X)^{-1}X'y$, com $Z$ substituindo o primeiro $X$. Quando $Z = X$ (nenhuma endogeneidade, instrumento é o próprio regressor), o IV colapsa no MQO. É o caso $L = K$ (exatamente identificado); quando $L > K$ (sobreidentificado, como nos cigarros da Q2), usa-se MQ2E e é possível testar validade (Sargan).

> [!success] 🎯 Ponte com a tese
> IV é a alternativa ao seu [[DiD]] quando tendências paralelas falham — e o problema de endogeneidade que ele resolve é o **mesmo** que a estratégia de identificação da sua dissertação precisa vencer (seleção no tratamento). Dominar a derivação aqui é dominar a lógica da inferência causal.

---
---

# ✅ Checklist: pronto para a prova?

> [!todo] Demonstrações (metade da nota)
> - [ ] **Q3** — equações normais escalares + $\hat a$ + $\hat b$ → treino em D3/D4/D6
> - [ ] **Q4** — viés por erro de medição (não vicia, infla variância) → §Q4
> - [ ] **Q5** — $\operatorname{Var}(b)=\sigma^2(X'X)^{-1}$ (D14) **+ consistência** via plim → §Q5
> - [ ] **Q6** — derivar $\hat\beta_{IV} = (Z'X)^{-1}Z'y$ via plim → §Q6

> [!todo] Interpretação de output (a outra metade)
> - [ ] Ler tabela MQO: significância ($b/\text{E.p.}$ vs 1,96), IC, $\bar R^2$, dummy em log, ponto de máximo quadrático
> - [ ] Ler tabela IV: identificar endógena/instrumentos, Wu-Hausman, instrumentos fracos, Sargan, Wald conjunto
> - [ ] Decorar as **duas propriedades do instrumento** (relevância + exogeneidade) e como cada teste as checa
> - [ ] Saber montar **hipóteses** $H_0/H_1$ para cada teste (é metade dos pontos das questões aplicadas)

> [!tip] Estratégia de prova (mesmo professor)
> - As questões aplicadas (Q1/Q2) são **pontos rápidos** — resolva-as primeiro para garantir a nota fácil.
> - Nas demonstrações, **sempre escreva as hipóteses** e **justifique cada passo** — o Zambon dá ponto por rigor, não só pelo resultado final.
> - Confira **dimensões matriciais** antes de fechar cada conta.
> - Traga na ponta da língua o kit: identidade $\hat\beta = \beta + (X'X)^{-1}X'\varepsilon$, os pesos $k_i$ e suas 3 propriedades, e o truque de dividir por $n$ para a parte assintótica.

---

## 📚 Documentos relacionados

> [!note] No vault
> - [[Demonstrações Econometria I mês 1]] — as demonstrações D0–D16 (Q3 e Q5-variância saem daqui)
> - [[Plano Econometria I]] — cronograma até a prova
> - [[Lista 1]] — os 74 exercícios (a prova se baseia em aulas + lista + livro)
> - [[Variáveis instrumentais]] · [[MQ2E]] — aprofundamento de Q2/Q6
> - [[DiD]] — onde a endogeneidade encontra sua dissertação
