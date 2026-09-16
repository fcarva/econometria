---
title: "Módulo 09 — Dummies, forma funcional e quebra estrutural (teoria)"
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
  - Dummies e forma funcional
---

# Módulo 09 — Dummies, forma funcional e quebra estrutural (teoria)

## 0. Mapa

> [!NOTE]
> **O que é, por que importa, onde cai**
> O modelo linear é linear **nos parâmetros**, não nas variáveis. Este módulo explora essa liberdade: dummies para atributos qualitativos, interações para efeitos que mudam entre grupos, logaritmos e quadrados para efeitos não lineares, e dummies de período para quebra estrutural. Na P1, aparece dentro da Q1 — interpretar o coeficiente de uma dummy em modelo log e achar o ponto de máximo de um termo quadrático — e nas questões de quebra estrutural e DiD.

## 1. Notação

Modelo com dummy de intercepto e de inclinação:
$$Y_i=\alpha_1+\alpha_2D_i+\beta_1X_i+\beta_2(D_iX_i)+u_i,\qquad D_i\in\{0,1\}.$$

| Grupo | Intercepto | Inclinação |
|---|---|---|
| $D=0$ | $\alpha_1$ | $\beta_1$ |
| $D=1$ | $\alpha_1+\alpha_2$ | $\beta_1+\beta_2$ |

Testar $\alpha_2=0$ é testar diferença de nível; $\beta_2=0$, diferença de efeito marginal; os dois juntos, quebra estrutural completa.

## 2. Demonstrações

### D09.1 · O que a dummy faz com o intercepto e com a inclinação

Basta tomar a esperança condicional em cada grupo:
$$E[Y\mid X,D=0]=\alpha_1+\beta_1X,\qquad E[Y\mid X,D=1]=(\alpha_1+\alpha_2)+(\beta_1+\beta_2)X.$$
A diferença entre as duas retas é $\alpha_2+\beta_2X$: **depende de $X$** quando há interação. Por isso, com interação, não existe "o efeito da dummy": existe o efeito avaliado em um ponto (em geral, na média de $X$).

### D09.2 · A armadilha da variável dummy

> [!NOTE]
> **O que se quer provar**
> Com intercepto e as **duas** dummies complementares ($D_1$ homem, $D_2$ mulher), a matriz $X'X$ é singular.

**Passo a passo.**

1. Por construção, $D_{1i}+D_{2i}=1$ para todo $i$, isto é, $D_1+D_2=\iota$, a própria coluna de 1s.
2. Existe então $v=(1,-1,-1)'\neq 0$ com $Xv=\iota-D_1-D_2=0$: as colunas são linearmente dependentes.
3. Logo $\operatorname{posto}(X)\lt K$, violando **A2**, e $X'X$ não é inversível: $b=(X'X)^{-1}X'y$ não existe. Os parâmetros não são identificados — há infinitas combinações $(\alpha_1,\alpha_2,\alpha_3)$ com o mesmo ajuste. $\blacksquare$

**Verificação com $n=5$:** posto de $X$ igual a 2 com $K=3$; determinante de $X'X$ igual a $-4\times10^{-15}$ (zero numérico) e menor autovalor igual a $-2{,}7\times10^{-15}$.

**Soluções:** (i) $m-1$ dummies mais intercepto — o grupo omitido vira a base de comparação; (ii) $m$ dummies **sem** intercepto — cada coeficiente é a média do próprio grupo. Nunca as duas coisas juntas.

### D09.3 · Efeito exato de uma dummy em modelo log

Com $\ln Y=\beta_1+\beta_2D+\dots$, o efeito percentual exato de passar de $D=0$ para $D=1$ é
$$\frac{E[Y\mid D=1]}{E[Y\mid D=0]}-1=e^{\beta_2}-1,$$
logo o efeito em porcentagem é $100(e^{\beta_2}-1)$, e não $100\beta_2$ — esta é a aproximação de primeira ordem, boa só para $\beta_2$ pequeno.

**Exemplo da P1 2025/2 (coeficiente de SOUTH $=-0{,}07629$):** aproximação $-7{,}63\%$; exato $-7{,}35\%$; diferença de 0,28 ponto percentual. Ambos são aceitos, mas citar o exato mostra domínio.

### D09.4 · Elasticidade em cada forma funcional

Partindo de $\eta=\dfrac{\partial Y}{\partial X}\cdot\dfrac{X}{Y}$:

| Modelo | $\partial Y/\partial X$ | Elasticidade |
|---|---|---|
| $Y=\beta_1+\beta_2X$ | $\beta_2$ | $\beta_2 X/Y$ (varia; use $\bar X/\bar Y$) |
| $Y=\beta_1+\beta_2\ln X$ | $\beta_2/X$ | $\beta_2/Y$ |
| $\ln Y=\beta_1+\beta_2X$ | $\beta_2Y$ | $\beta_2X$ |
| $\ln Y=\beta_1+\beta_2\ln X$ | $\beta_2Y/X$ | $\beta_2$ (constante) |
| $Y=\beta_1+\beta_2/X$ | $-\beta_2/X^2$ | $-\beta_2/(XY)$ |

As duas demonstrações pedidas no ex. 43 são casos desta tabela: no modelo potência $Y=\beta_1X^{\beta_2}$, $\eta=\beta_2$; no lin-log, $\eta=\beta_2/Y$.

**Verificação com os dados de café:** as cinco formas dão elasticidades no ponto médio entre $-0{,}220$ e $-0{,}260$ — mesma história econômica (demanda inelástica), especificações diferentes.

### D09.5 · Ponto de máximo de um termo quadrático

Com $Y=\beta_1+\beta_2X+\beta_3X^2$, o efeito marginal é $\beta_2+2\beta_3X$; igualando a zero,
$$X^*=-\frac{\beta_2}{2\beta_3},$$
que é **máximo** se $\beta_3\lt 0$ (segunda derivada $2\beta_3\lt 0$) e mínimo se $\beta_3\gt 0$.

Na P1 2025/2, com $a_3=0{,}04292$ e $a_4=-0{,}00070803$: $X^*=30{,}31$ anos de experiência. Depois disso, mantido tudo constante, o log-salário **começa a cair** — o perfil idade-salário côncavo. O erro-padrão desse ponto sai pelo método delta ([módulo 08](../08_assintotica/08_teoria.md), D08.4): 0,71 ano.

### D09.6 · Linearização: quando o log salva e quando não salva

**Cobb-Douglas (ex. 47).** $Y=AX_1^{\alpha}X_2^{\beta}e^{u}$ não é linear nos parâmetros, mas o log é:
$$\ln Y=\ln A+\alpha\ln X_1+\beta\ln X_2+u,$$
estimável por MQO, com os coeficientes já sendo elasticidades e $\hat A=e^{\hat\beta_1}$. **Exponencial (ex. 48):** $EXP=\beta_1 RMUND^{\beta_2}e^{u}$ segue a mesma receita.

> [!WARNING]
> **A condição que quase todo mundo esquece**
> A linearização só funciona com erro **multiplicativo** ($e^u$). Com erro aditivo, $Y=AX_1^\alpha X_2^\beta+u$, tomar log não separa nada e o MQO fica viesado. Na simulação: com erro multiplicativo, $\hat\alpha=0{,}610$ para $\alpha=0{,}6$; com erro aditivo, $\hat\alpha=1{,}087$.

### D09.7 · Chow e o modelo interagido são o mesmo teste

> [!NOTE]
> **O que se quer provar**
> O $F$ de Chow, calculado com três regressões, é idêntico ao $F$ da significância conjunta de todas as interações com a dummy de período.

**Passo a passo.**

1. Estime o modelo **pooled** e guarde $SQR_P$ (é o modelo restrito: coeficientes iguais nos dois períodos).
2. Estime separadamente em cada subperíodo: $SQR_1+SQR_2$ é exatamente o $SQR$ do modelo com **todas** as variáveis interagidas com a dummy (é o irrestrito, que permite tudo diferente).
3. Aplique o $F$ de restrições ($J=K$ restrições, $n_1+n_2-2K$ graus de liberdade no denominador):
$$F=\frac{(SQR_P-(SQR_1+SQR_2))/K}{(SQR_1+SQR_2)/(n_1+n_2-2K)}.$$
Como as duas somas de quadrados coincidem com as do par restrito/irrestrito, as duas estatísticas são a mesma. $\blacksquare$

**Verificação com o ex. 57:** $SQR_P=0{,}5722$, $SQR_1=0{,}0265$, $SQR_2=0{,}2466$, o que dá $F=7{,}6665$ ($p=0{,}0056$); o $F$ do modelo totalmente interagido dá o mesmo valor, com diferença de $2\times10^{-14}$.

**Vantagem da versão com dummies:** além de dizer *se* houve quebra, diz *onde* — intercepto, inclinação ou ambos —, e ainda permite erros-padrão robustos.

### D09.8 · O estimador de diferenças em diferenças

> [!NOTE]
> **O que se quer provar (ex. 71)**
> No modelo $y_{it}=\beta_0+\beta_1D_{it}+\beta_2T_t+\beta_3D_{it}T_t+\beta'x_{it}+\varepsilon_{it}$, com $t=1,2$,
> $$E[\Delta y_{it}\mid x,D=1]-E[\Delta y_{it}\mid x,D=0]=\beta_3+\beta'\big[(\Delta x\mid D=1)-(\Delta x\mid D=0)\big].$$

**Passo a passo.**

1. Escreva o modelo nos dois períodos e tome a diferença. Como $T_1=0$ e $T_2=1$, e $D$ não varia no tempo:
$$\Delta y_i=\beta_2+\beta_3D_i+\beta'\Delta x_i+\Delta\varepsilon_i.$$
Note que $\beta_0$ e $\beta_1$ desaparecem: qualquer coisa fixa no tempo some na diferença.

2. Tome a esperança dentro de cada grupo:
$$E[\Delta y\mid D=1]=\beta_2+\beta_3+\beta'E[\Delta x\mid D=1],\qquad E[\Delta y\mid D=0]=\beta_2+\beta'E[\Delta x\mid D=0].$$

3. Subtraia: $\beta_2$ cancela e sobra
$$\beta_3+\beta'\big[E(\Delta x\mid D=1)-E(\Delta x\mid D=0)\big].\qquad\blacksquare$$

**Ex. 72: controles invariantes no tempo.** Se $x_{it}=x_i$, então $\Delta x_i=0$ e o colchete some:
$$E[\Delta y\mid D=1]-E[\Delta y\mid D=0]=\beta_3.$$
Ou seja, características fixas no tempo **não precisam ser observadas nem controladas** — é a força do DiD, a mesma da transformação within com efeitos fixos. Em compensação, seus efeitos também não são identificáveis.

**Verificação numérica:** as três vias dão exatamente o mesmo número — diferença de médias das diferenças, coeficiente da interação e regressão em primeiras diferenças: 1,58999746 (com $\beta_3=1{,}5$ verdadeiro e erro-padrão 0,1750). Incluir o controle invariante no tempo não muda nada (diferença de $10^{-15}$).

Aprofundamento e ligação com a dissertação: [did.md](did.md).

### D09.9 · Regressão descontínua e regressão em rampa (visão rápida)

Nos slides (SL09), dois desenhos aparecem depois do DiD:
- **Regressão descontínua:** o tratamento é determinado por um limiar de uma variável contínua $z$ (nota de corte, população mínima). Estima-se $y=\alpha+\beta\,1[z\ge z_0]+f(z)+\varepsilon$ e o salto $\beta$ em $z_0$ é o efeito causal local, sob a hipótese de que tudo o mais é contínuo em $z_0$.
- **Regressão em rampa (kinked):** o que muda no limiar é a **inclinação**, não o nível; modela-se com $(z-z_0)\cdot 1[z\ge z_0]$.

Na P1, é conteúdo de reconhecimento: saber o que é e qual a hipótese de identificação.

## 3. Como cai na prova

| Formato | O que fazer |
|---|---|
| "Interprete o coeficiente da dummy" (modelo log) | Semi-elasticidade: $100\beta\%$ aproximado, $100(e^\beta-1)\%$ exato. Diga em relação a qual categoria base. |
| "Depois de quantos anos atinge o máximo?" | $X^*=-\beta_2/(2\beta_3)$; confirme o sinal da segunda derivada e diga o que acontece depois. |
| "Escreva a equação com efeito da crise no intercepto e na inclinação" | $Y=\alpha_1+\alpha_2D+\beta_1X+\beta_2(DX)+u$, com os valores de $D$ por período explicitados. |
| "Como testar quebra estrutural?" | Chow com três regressões **ou** modelo interagido com $F$ conjunto. Dê hipóteses, estatística e gl. |
| "Por que não posso usar as duas dummies com intercepto?" | D09.2: dependência linear exata, A2 violada, $X'X$ singular. |
| "Derive o estimador DiD" | D09.8, em três passos, terminando na condição de tendências paralelas. |
| "Posso estimar essa Cobb-Douglas por MQO?" | Não diretamente; sim em logs, se o erro for multiplicativo. |

## 4. Interpretação de output

Numa regressão com dummy de crise interagida (ex. 59), a leitura é:
- coeficiente de $\ln(PIB)$: elasticidade no período **base** ($DUM=0$);
- coeficiente de $DUM\times\ln(PIB)$: **mudança** da elasticidade no período da crise;
- elasticidade no período da crise: a soma dos dois;
- significância da interação: é o teste de quebra estrutural na inclinação.

## 5. Armadilhas

> [!WARNING]
> **Cinco erros clássicos**
> 1. Interpretar o coeficiente da dummy sem dizer qual é a categoria base.
> 2. Esquecer que, com interação, o efeito da dummy depende de $X$.
> 3. Usar $100\beta$ como efeito exato quando $\beta$ é grande (com $\beta=0{,}5$, o erro passa de 14 p.p.).
> 4. Tomar log de modelo com erro aditivo e chamar de linearização.
> 5. No Chow, esquecer que os graus de liberdade do denominador são $n_1+n_2-2K$, e que cada subamostra precisa de $n_i\gt K$.

## 6. Checklist

- [ ] Escrevo o modelo com dummy de intercepto e de inclinação e leio as duas retas.
- [ ] Provo a armadilha da dummy com $n=5$ no papel.
- [ ] Calculo efeito exato e aproximado de dummy em log.
- [ ] Reproduzo a tabela de elasticidades das cinco formas funcionais.
- [ ] Acho $X^*$ e justifico que é máximo.
- [ ] Monto o teste de Chow pelas duas vias e sei dizer por que dão o mesmo $F$.
- [ ] Derivo o DiD (D09.8) e explico o que acontece com controles invariantes no tempo.

## 7. Conferência numérica

| chave_R | nota |
|---|---|
| m09_ex43_elast_loglog | -0,25305 |
| m09_ex43_elast_lin | -0,21971 |
| m09_ex43_loglog_r2 | 0,74480 |
| m09_chow_F | 7,6665 |
| m09_chow_p | 0,005642 |
| m09_chow_F_interagido | 7,6665 |
| m09_ex61_posto | 2 |
| m09_ex61_K | 3 |
| m09_dummy_aprox_pct | -7,6291 |
| m09_dummy_exato_pct | -7,3453 |
| m09_quad_xstar | 30,307 |
| m09_ex47_alfa_hat | 0,60998 |
| m09_ex47_alfa_aditivo | 1,0875 |
| m09_did_medias | 1,59000 |
| m09_did_regressao | 1,59000 |
| m09_did_primeiras_dif | 1,59000 |

## 8. Referências

- Greene, *Econometric Analysis*, cap. 6 (dummies, interações, forma funcional, quebra estrutural, DiD e regressão descontínua).
- Slides SL09.
- Exercícios resolvidos: [09_lista1.md](09_lista1.md). DiD aprofundado: [did.md](did.md).
- Método delta para o erro-padrão de $X^*$: [módulo 08](../08_assintotica/08_teoria.md).
