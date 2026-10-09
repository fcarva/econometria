---
title: "P1 2026/2 — resolução comentada com rubrica"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
prova: "P1 — 09/10/2026"
greene: "cap. 3, 4, 5, 6 e 8"
slides: "SL03–SL10"
relevancia_p1: alta
status: verificado
verificacao:
  derivacao: ok
  numerica: ok
  chave: pendente
tags:
  - econometria
  - mestrado/ppgeco
  - p1
  - prova
aliases:
  - Resolução P1 2026/2
---

# P1 2026/2 — resolução comentada

Gabarito não oficial da prova de 09/10/2026, montado pelas fotos do enunciado. O enunciado não é reproduzido: cada item tem um título-paráfrase e os dados numéricos necessários. As contas estão conferidas em [reproducao.R](reproducao.R) e o mapa da prova está no [README](README.md).

> [!NOTE]
> **Notação**
> Aqui vale a notação **do enunciado**, como manda a CONVENCOES §2 para provas reproduzidas: intercepto $\beta_0$, erro $\mu$ na Q5 e $u$ nas demais, estimador de MQO $b$ ou $\widehat\beta$ conforme a questão.

> [!TIP]
> **Como se corrigir**
> A rubrica de cada item reparte os pontos por passo, como na [lógica de correção](../README.md) do guia de provas. Some o que você escreveu de fato, não o que sabia. Cada passo que faltou vira uma linha no [log de erros](../log_erros.md).

---

## Parte I — Questões aplicadas (6,0)

## Questão 1 (1,5) — MQO matricial com quatro observações

Vendas mensais $Y$ (em mil R\$) contra marketing $X_1$ e P&D $X_2$, ambos padronizados, com $n=4$:

$$
\mathbf y=\begin{pmatrix}8\\7\\10\\14\end{pmatrix},\qquad
\mathbf X=\begin{pmatrix}1&-3&1\\1&-1&-1\\1&1&-1\\1&3&1\end{pmatrix}.
$$

### a) $\mathbf X'\mathbf X$ e $\mathbf X'\mathbf y$ (0,5)

Cada elemento de $\mathbf X'\mathbf X$ é a soma do produto de duas colunas. As colunas de $X_1$ e $X_2$ somam zero e são ortogonais entre si ($\sum X_{i1}X_{i2}=-3+1-1+3=0$), então a matriz sai **diagonal**:

$$
\mathbf X'\mathbf X=\begin{pmatrix}n&\sum X_{i1}&\sum X_{i2}\\ \sum X_{i1}&\sum X_{i1}^2&\sum X_{i1}X_{i2}\\ \sum X_{i2}&\sum X_{i1}X_{i2}&\sum X_{i2}^2\end{pmatrix}
=\begin{pmatrix}4&0&0\\0&20&0\\0&0&4\end{pmatrix},
\qquad
\mathbf X'\mathbf y=\begin{pmatrix}\sum Y_i\\ \sum X_{i1}Y_i\\ \sum X_{i2}Y_i\end{pmatrix}=\begin{pmatrix}39\\21\\5\end{pmatrix}.
$$

As contas: $\sum X_{i1}^2=9+1+1+9=20$; $\sum X_{i1}Y_i=-24-7+10+42=21$; $\sum X_{i2}Y_i=8-7-10+14=5$.

| Rubrica | Pontos |
|---|---|
| Estrutura de $\mathbf X'\mathbf X$ (somas de produtos cruzados) e os três elementos da diagonal | 0,25 |
| $\mathbf X'\mathbf y$ com as contas | 0,25 |

### b) $(\mathbf X'\mathbf X)^{-1}$ e $\widehat\beta$ (0,5)

A inversa de uma matriz diagonal é a diagonal dos inversos:

$$
(\mathbf X'\mathbf X)^{-1}=\begin{pmatrix}0{,}25&0&0\\0&0{,}05&0\\0&0&0{,}25\end{pmatrix},
\qquad
\widehat\beta=(\mathbf X'\mathbf X)^{-1}\mathbf X'\mathbf y=\begin{pmatrix}39/4\\21/20\\5/4\end{pmatrix}=\begin{pmatrix}9{,}75\\1{,}05\\1{,}25\end{pmatrix}.
$$

$$\boxed{\widehat Y_i=9{,}75+1{,}05X_{i1}+1{,}25X_{i2}}$$

> [!TIP]
> **O atalho que a prova escondeu**
> Com colunas ortogonais, cada coeficiente é uma regressão simples separada: $\widehat\beta_1=\sum X_{i1}Y_i/\sum X_{i1}^2$. Quem nota a diagonal resolve a Q1 inteira em menos de 10 minutos, sem inverter matriz.

| Rubrica | Pontos |
|---|---|
| Inversa correta, com a justificativa da diagonal (ou a conta por cofatores) | 0,25 |
| Produto $(\mathbf X'\mathbf X)^{-1}\mathbf X'\mathbf y$ e $\widehat\beta$ | 0,25 |

### c) Resíduos e a condição $\mathbf X'\widehat u=\mathbf 0$ (0,25)

Valores ajustados e resíduos:

| $i$ | $Y_i$ | $\widehat Y_i$ | $\widehat u_i=Y_i-\widehat Y_i$ |
|---|---|---|---|
| 1 | 8 | $9{,}75-3{,}15+1{,}25=7{,}85$ | 0,15 |
| 2 | 7 | $9{,}75-1{,}05-1{,}25=7{,}45$ | −0,45 |
| 3 | 10 | $9{,}75+1{,}05-1{,}25=9{,}55$ | 0,45 |
| 4 | 14 | $9{,}75+3{,}15+1{,}25=14{,}15$ | −0,15 |

$$
\mathbf X'\widehat u=\begin{pmatrix}0{,}15-0{,}45+0{,}45-0{,}15\\ -0{,}45+0{,}45+0{,}45-0{,}45\\ 0{,}15+0{,}45-0{,}45-0{,}15\end{pmatrix}=\begin{pmatrix}0\\0\\0\end{pmatrix}.
$$

**Significado.** São as equações normais: $\mathbf X'(\mathbf y-\mathbf X\widehat\beta)=\mathbf 0$. O resíduo não tem correlação amostral com nenhum regressor, ou seja, o MQO extraiu de $X_1$ e $X_2$ toda a informação linear sobre as vendas; o que sobra em $\widehat u$ não pode ser previsto linearmente por marketing nem por P&D. Como há intercepto, a primeira linha dá $\sum\widehat u_i=0$: em média o modelo não erra para cima nem para baixo, e a média dos ajustados é igual à média das vendas (9,75).

| Rubrica | Pontos |
|---|---|
| Vetor de resíduos e o produto $\mathbf X'\widehat u$ | 0,15 |
| Significado (ortogonalidade, nada linear sobra; $\sum\widehat u_i=0$ pelo intercepto) | 0,10 |

### d) Interpretar $\widehat\beta_1$ e $\widehat\beta_2$ (0,25)

- $\widehat\beta_1=1{,}05$: aumentar o gasto com marketing em uma unidade padronizada eleva as vendas mensais em 1,05 mil R\$ (R\$ 1.050), mantido o P&D constante.
- $\widehat\beta_2=1{,}25$: aumentar o P&D em uma unidade padronizada eleva as vendas mensais em 1,25 mil R\$ (R\$ 1.250), mantido o marketing constante.

> [!WARNING]
> **Unidade e *ceteris paribus***
> As duas palavras que valem o ponto são "mil R\$" (a unidade de $Y$) e "mantido o outro constante". Sem elas a interpretação fica pela metade.

<!-- conferência numérica: valores conferidos contra resultados/*.csv pelo scripts/check_numbers.R
| chave_R | nota |
|---|---|
| p26_q1_xtx22 | 20 |
| p26_q1_xty1 | 39 |
| p26_q1_xty2 | 21 |
| p26_q1_xty3 | 5 |
| p26_q1_inv22 | 0,05 |
| p26_q1_b0 | 9,75 |
| p26_q1_b1 | 1,05 |
| p26_q1_b2 | 1,25 |
| p26_q1_e1 | 0,15 |
| p26_q1_e2 | -0,45 |
| p26_q1_yhat1 | 7,85 |
| p26_q1_yhat4 | 14,15 |
-->

---

## Questão 2 (1,5) — Equação de log-salário

Equação estimada com $n=200$, $k=5$, erros-padrão entre parênteses:

$$
\ln(\widehat{WAGE}_i)=\underset{(0{,}15)}{1{,}200}+\underset{(0{,}010)}{0{,}0850}\,EDUC_i+\underset{(0{,}012)}{0{,}0450}\,EXP_i-\underset{(0{,}0002)}{0{,}0007}\,EXP_i^2-\underset{(0{,}05)}{0{,}1800}\,FEMALE_i
$$

### a) Interpretar $\widehat\beta_1$ e $\widehat\beta_4$ no modelo log-nível (0,25)

No log-nível, $100\cdot\beta_j$ é a variação percentual **aproximada** de $WAGE$; a exata é $100(e^{\beta_j}-1)$. Com $e=2{,}718$, como manda o enunciado:

- **EDUC:** cada ano a mais de escolaridade eleva o salário em cerca de 8,5%, tudo mais constante. Exato: $100(2{,}718^{0{,}085}-1)=8{,}87\%$.
- **FEMALE:** a mulher ganha cerca de 18% menos que um homem com a mesma escolaridade e a mesma experiência. Exato: $100(2{,}718^{-0{,}18}-1)=-16{,}47\%$.

> [!IMPORTANT]
> **Para dummy, a forma exata é a correta**
> A aproximação $100\beta$ só vale para variação marginal. A dummy vai de 0 a 1, um salto discreto, então o efeito correto é $e^{\beta_4}-1$ (ver D09.3 em [09_teoria](../../09_dummies_forma_funcional/09_teoria.md)). Com $\beta_4=-0{,}18$ a diferença é de 1,5 ponto percentual: dar as duas mostra domínio.

| Rubrica | Pontos |
|---|---|
| EDUC como semi-elasticidade, com *ceteris paribus* | 0,10 |
| FEMALE como diferencial percentual, com a forma exata | 0,15 |

### b) Significância individual de $\widehat\beta_4$ (0,25)

- **Hipóteses:** $H_0:\beta_4=0$ (não há diferencial salarial por gênero) vs. $H_1:\beta_4\neq 0$.
- **Estatística:** $t_{cal}=\widehat\beta_4/ep(\widehat\beta_4)=-0{,}18/0{,}05=-3{,}60$, com $n-k=195$ graus de liberdade.
- **Decisão:** como $\lvert t_{cal}\rvert=3{,}60>t_{tab}=1{,}96$, rejeita-se $H_0$ ao nível de 5%.
- **Conclusão:** FEMALE é estatisticamente significativa: há diferencial salarial contra as mulheres, mesmo controlando escolaridade e experiência.

### c) Teste $F$ de significância conjunta de EXP e EXP² (0,5)

- **Hipóteses:** $H_0:\beta_2=\beta_3=0$ (a experiência não afeta o salário) vs. $H_1$: pelo menos um dos dois é diferente de zero.
- **Estatística:**

$$
F_{cal}=\frac{(SQR_R-SQR_{UR})/q}{SQR_{UR}/(n-k)}=\frac{(128-120)/2}{120/195}=\frac{4}{0{,}6154}=6{,}50.
$$

- **Decisão:** como $F_{cal}=6{,}50>F_{tab}(2,\,195)=3{,}00$, rejeita-se $H_0$ ao nível de 5%.
- **Conclusão:** a experiência é conjuntamente relevante; os dois termos devem ficar no modelo.

> [!WARNING]
> **Teste conjunto, não dois testes $t$**
> EXP e EXP² são quase colineares, então os $t$ individuais podem enganar. A pergunta "a experiência importa?" é sobre o par de coeficientes, e por isso o teste é $F$ com $q=2$.

| Rubrica | Pontos |
|---|---|
| Hipóteses conjuntas | 0,10 |
| Fórmula com $q=2$ e $n-k=195$ | 0,15 |
| Conta (6,50) | 0,10 |
| Decisão e conclusão | 0,15 |

### d) Efeito marginal com 10 anos e ponto de reversão (0,5)

Derive antes de substituir:

$$
\frac{\partial\ln(WAGE)}{\partial EXP}=\beta_2+2\beta_3EXP=0{,}045+2(-0{,}0007)(10)=0{,}045-0{,}014=0{,}031.
$$

Com 10 anos de experiência, um ano a mais eleva o salário em cerca de **3,1%**, tudo mais constante.

Ponto de reversão: iguale a derivada a zero.

$$
EXP^*=-\frac{\beta_2}{2\beta_3}=-\frac{0{,}045}{2(-0{,}0007)}=\frac{0{,}045}{0{,}0014}=32{,}14\ \text{anos}.
$$

Como $\beta_3\lt 0$, a segunda derivada $2\beta_3$ é negativa: o perfil é **côncavo** e $EXP^*$ é um máximo. O retorno da experiência é positivo e decrescente até cerca de 32 anos; a partir daí, um ano a mais **reduz** o salário esperado (desgaste, obsolescência do capital humano).

> [!CAUTION]
> **O erro mais comum neste item: 4,5%**
> Responder 4,5% é ler só o $\widehat\beta_2$ e esquecer o termo $2\beta_3EXP$. Com termo quadrático, o efeito marginal **depende do nível** de EXP; com 10 anos, ele já caiu para 3,1%. É o erro registrado no [log](../log_erros.md) desta prova. Ver D09.5 em [09_teoria](../../09_dummies_forma_funcional/09_teoria.md).

| Rubrica | Pontos |
|---|---|
| Derivada $\beta_2+2\beta_3EXP$ | 0,15 |
| Efeito em 10 anos (3,1%) | 0,10 |
| Ponto de reversão (32,14) | 0,15 |
| Interpretação (concavidade, retorno decrescente, o que ocorre depois) | 0,10 |

<!-- conferência numérica: valores conferidos contra resultados/*.csv pelo scripts/check_numbers.R
| chave_R | nota |
|---|---|
| p26_q2_educ_exato | 8,87 |
| p26_q2_fem_exato | -16,47 |
| p26_q2_t_fem | -3,60 |
| p26_q2_F | 6,50 |
| p26_q2_gl2 | 195 |
| p26_q2_efm10 | 0,031 |
| p26_q2_erro_comum | 4,5 |
| p26_q2_exp_max | 32,14 |
-->

---

## Questão 3 (1,5) — Mudança estrutural com dummies (Chow)

Modelo com possibilidade de quebra após a reforma em $T_0$, com $D_t=1$ depois de $T_0$:

$$
GROWTH_i=\beta_0+\beta_1INV_i+\delta_0D_i+\delta_1(D_i\cdot INV_i)+u_i
$$

Dados: $SQR_R=240$, $SQR_{UR}=210$, $n=120$, $k_{UR}=4$, $F_{tab}(2,\,116)=3{,}08$.

### a) Interpretar $\delta_0$ e $\delta_1$ (0,25)

Escreva as duas retas:

$$
\text{antes de }T_0\ (D=0):\ E(GROWTH)=\beta_0+\beta_1INV,\qquad
\text{depois}\ (D=1):\ E(GROWTH)=(\beta_0+\delta_0)+(\beta_1+\delta_1)INV.
$$

- $\delta_0$ é a **mudança no intercepto**: quanto o crescimento médio se deslocou depois da reforma, para uma mesma taxa de investimento.
- $\delta_1$ é a **mudança na inclinação**: quanto mudou o efeito de um ponto a mais de investimento sobre o crescimento. Depois da reforma, o efeito passa a ser $\beta_1+\delta_1$.

### b) Hipótese nula de ausência de quebra (0,25)

$$H_0:\delta_0=\delta_1=0\qquad\text{vs.}\qquad H_1:\ \delta_0\neq 0\ \text{ou}\ \delta_1\neq 0.$$

A relação só é a mesma nos dois períodos se **as duas retas coincidem**, o que exige o mesmo intercepto **e** a mesma inclinação. A quebra pode aparecer no nível, na inclinação ou em ambos; testar só $\delta_0$ ou só $\delta_1$ deixaria a outra forma de quebra de fora. Por isso o teste é conjunto, com $q=2$ restrições. É o teste de Chow escrito com dummies (ver D09.7 em [09_teoria](../../09_dummies_forma_funcional/09_teoria.md)).

### c) Estatística $F$ e conclusão (0,75)

- **Hipóteses:** $H_0:\delta_0=\delta_1=0$ vs. $H_1$: pelo menos um é diferente de zero.
- **Estatística:**

$$
F_{cal}=\frac{(SQR_R-SQR_{UR})/q}{SQR_{UR}/(n-k_{UR})}=\frac{(240-210)/2}{210/(120-4)}=\frac{15}{1{,}8103}=8{,}29.
$$

- **Decisão:** como $F_{cal}=8{,}29>F_{tab}(2,\,116)=3{,}08$, rejeita-se $H_0$ ao nível de 5%.
- **Conclusão:** há evidência de mudança estrutural na relação entre investimento e crescimento a partir de $T_0$.

> [!WARNING]
> **Este item vale metade da questão**
> São 0,75 dos 1,5 pontos, e quase tudo está na conta. "Rejeito $H_0$" sem a estatística calculada não demonstra nada: o enunciado exige os cálculos intermediários. Treine a fórmula até sair sem pensar: diferença das $SQR$ sobre $q$, dividida por $SQR_{UR}$ sobre $n-k$.

| Rubrica | Pontos |
|---|---|
| Hipóteses | 0,10 |
| Fórmula com $q=2$ e $n-k_{UR}=116$ | 0,20 |
| Conta (8,29) | 0,25 |
| Decisão pelo $F_{tab}$ dado e conclusão | 0,20 |

### d) O que significa rejeitar $H_0$ (0,25)

A relação investimento-crescimento **não é a mesma** antes e depois da reforma: ela mudou de nível ($\delta_0$), de inclinação ($\delta_1$) ou dos dois jeitos. Em termos econômicos, a reforma institucional alterou o crescimento associado a uma dada taxa de investimento ou a eficácia do investimento em gerar crescimento. O $F$ conjunto não diz **qual** dos dois coeficientes mudou; para isso seriam precisos os testes $t$ de $\delta_0$ e de $\delta_1$. Uma regressão única para o período todo estaria mal especificada.

<!-- conferência numérica: valores conferidos contra resultados/*.csv pelo scripts/check_numbers.R
| chave_R | nota |
|---|---|
| p26_q3_num | 15 |
| p26_q3_den | 1,8103 |
| p26_q3_gl2 | 116 |
| p26_q3_F | 8,29 |
-->

---

## Questão 4 (1,5) — Endogeneidade e variáveis instrumentais

Modelo simples $Y_i=\beta_0+\beta_1X_i+u_i$ com $\operatorname{Cov}(X,u)\neq 0$. Dados em desvios: $\sum z_iy_i=340$, $\sum z_ix_i=85$, $\bar Y=50$, $\bar X=8$.

### a) Por que $\operatorname{Cov}(X,u)\neq 0$ destrói a consistência do MQO (0,5)

1. Substitua o modelo no estimador. Em desvios, $y_i=\beta_1x_i+(u_i-\bar u)$ e $\sum x_i\bar u=0$:

$$
\widehat\beta_1=\frac{\sum x_iy_i}{\sum x_i^2}=\beta_1+\frac{\sum x_iu_i}{\sum x_i^2}=\beta_1+\frac{\frac1n\sum x_iu_i}{\frac1n\sum x_i^2}.
$$

2. Aplique a lei dos grandes números a numerador e denominador: $\frac1n\sum x_iu_i\xrightarrow{p}\operatorname{Cov}(X,u)$ e $\frac1n\sum x_i^2\xrightarrow{p}\operatorname{Var}(X)>0$.

3. Pelo teorema de Slutsky, o plim da razão é a razão dos plims:

$$\boxed{\operatorname{plim}\widehat\beta_1=\beta_1+\frac{\operatorname{Cov}(X,u)}{\operatorname{Var}(X)}\neq\beta_1}$$

O viés **não some com $n$**: mais dados não corrigem o problema. O sinal do viés assintótico é o sinal de $\operatorname{Cov}(X,u)$ (ver D10.1 em [10_teoria](../../10_endogeneidade_iv/10_teoria.md)). A simulação de [reproducao.R](reproducao.R), com $\beta_1=3$, $\operatorname{Cov}(X,u)=0{,}8$ e $\operatorname{Var}(X)=1{,}25$, dá MQO em torno de 3,64 com $n=100.000$, exatamente $\beta_1+0{,}8/1{,}25$.

| Rubrica | Pontos |
|---|---|
| Decomposição $\widehat\beta_1=\beta_1+\sum x_iu_i/\sum x_i^2$ | 0,20 |
| LGN e Slutsky na razão | 0,15 |
| Expressão do plim e a conclusão (inconsistente; viés não some com $n$) | 0,15 |

### b) Estimador de VI (0,25)

$$
\widehat\beta_1^{IV}=\frac{\sum z_iy_i}{\sum z_ix_i}=\frac{340}{85}=4{,}00,
\qquad
\widehat\beta_0^{IV}=\bar Y-\widehat\beta_1^{IV}\bar X=50-4(8)=18{,}00.
$$

### c) As condições do instrumento e o instrumento fraco (0,5)

- **Relevância:** $\operatorname{Cov}(Z,X)\neq 0$. O instrumento precisa mover $X$; sem isso o denominador $\sum z_ix_i$ não carrega informação e o estimador nem está definido no limite.
- **Exogeneidade:** $\operatorname{Cov}(Z,u)=0$. O instrumento só afeta $Y$ por meio de $X$, sem canal direto e sem correlação com os fatores omitidos.

Com as duas, $\operatorname{plim}\widehat\beta_1^{IV}=\beta_1+\operatorname{Cov}(Z,u)/\operatorname{Cov}(Z,X)=\beta_1$.

**Instrumento fraco** ($\operatorname{Cov}(Z,X)$ perto de zero) gera três problemas:

1. **Variância alta:** $\operatorname{Var}(\widehat\beta_1^{IV})\approx\dfrac{\sigma^2}{n\,\sigma_X^2\,\rho_{XZ}^2}$, que explode quando $\rho_{XZ}\to 0$. A estimativa fica imprecisa.
2. **Viés em amostra finita na direção do MQO:** o VI é consistente, mas com instrumento fraco a distribuição em amostras usuais fica centrada perto do MQO viesado, e a aproximação normal falha. Testes $t$ e intervalos deixam de ser confiáveis.
3. **Amplificação:** qualquer pequena violação da exogeneidade é dividida por um $\operatorname{Cov}(Z,X)$ pequeno. O VI com instrumento fraco pode ficar **mais** inconsistente que o próprio MQO.

Regra prática: $F$ do primeiro estágio abaixo de 10 sinaliza instrumento fraco (ver D10.9 em [10_teoria](../../10_endogeneidade_iv/10_teoria.md)).

| Rubrica | Pontos |
|---|---|
| Relevância e exogeneidade, cada uma com o significado econômico | 0,25 |
| Instrumento fraco: variância, viés em amostra finita e amplificação | 0,25 |

### d) Instrumento relevante mas correlacionado com o erro (0,25)

$$
\operatorname{plim}\widehat\beta_1^{IV}=\beta_1+\frac{\operatorname{Cov}(Z,u)}{\operatorname{Cov}(Z,X)}\neq\beta_1.
$$

O VI continua **inconsistente**: o problema de endogeneidade passou de $X$ para $Z$. A relevância não salva nada, porque ela só entra no denominador; o numerador $\operatorname{Cov}(Z,u)$ é que precisa ser zero. E se o instrumento ainda for fraco, o viés pode ser maior que o do MQO.

<!-- conferência numérica: valores conferidos contra resultados/*.csv pelo scripts/check_numbers.R
| chave_R | nota |
|---|---|
| p26_q4_b1iv | 4,00 |
| p26_q4_b0iv | 18,00 |
| p26_q4_sim_plim_mqo | 3,64 |
| p26_q4_sim_mqo | 3,64 |
| p26_q4_sim_iv | 3,01 |
-->

---

## Parte II — Demonstrações (4,0)

## Questão 5 (1,5) — Gauss-Markov com $\widehat\beta^*=[(\mathbf X'\mathbf X)^{-1}\mathbf X'+\mathbf C]\mathbf y$

> [!NOTE]
> **O que se quer provar**
> Sob $E(\mu\mid\mathbf X)=\mathbf 0$ e $E(\mu\mu'\mid\mathbf X)=\sigma^2\mathbf I$, (i) $\widehat\beta^*$ é não viesado se e só se $\mathbf C\mathbf X=\mathbf 0$; (ii) $\operatorname{Var}(\widehat\beta^*\mid\mathbf X)-\operatorname{Var}(\widehat\beta\mid\mathbf X)=\sigma^2\mathbf C\mathbf C'$, que é semidefinida positiva. É a D06.5 de [06_teoria](../../06_amostra_finita_multicol/06_teoria.md), quase palavra por palavra.

**Passo a passo.**

1. Substitua $\mathbf y=\mathbf X\beta+\mu$. Escreva $\mathbf A=(\mathbf X'\mathbf X)^{-1}\mathbf X'+\mathbf C$, matriz $K\times n$ de constantes dado $\mathbf X$. *[H1]*

$$
\widehat\beta^*=\mathbf A(\mathbf X\beta+\mu)=\underbrace{(\mathbf X'\mathbf X)^{-1}\mathbf X'\mathbf X}_{\mathbf I}\beta+\mathbf C\mathbf X\beta+\mathbf A\mu=\beta+\mathbf C\mathbf X\beta+\mathbf A\mu.
$$

2. Tome a esperança condicional; $\mathbf A$ sai porque é função de $\mathbf X$. *[H2]*

$$
E(\widehat\beta^*\mid\mathbf X)=\beta+\mathbf C\mathbf X\beta+\mathbf A\,E(\mu\mid\mathbf X)=\beta+\mathbf C\mathbf X\beta.
$$

O estimador é não viesado **para todo** $\beta$ se e só se $\mathbf C\mathbf X\beta=\mathbf 0$ para todo $\beta$, ou seja, $\boxed{\mathbf C\mathbf X=\mathbf 0}$. Transpondo, também $\mathbf X'\mathbf C'=\mathbf 0$.

3. Com $\mathbf C\mathbf X=\mathbf 0$, o erro amostral é $\widehat\beta^*-\beta=\mathbf A\mu$. A variância é *[H4]*:

$$
\operatorname{Var}(\widehat\beta^*\mid\mathbf X)=\mathbf A\,E(\mu\mu'\mid\mathbf X)\,\mathbf A'=\sigma^2\mathbf A\mathbf A'.
$$

4. Expanda $\mathbf A\mathbf A'$ e use $\mathbf C\mathbf X=\mathbf 0$ e $\mathbf X'\mathbf C'=\mathbf 0$ nos termos cruzados:

$$
\mathbf A\mathbf A'=(\mathbf X'\mathbf X)^{-1}\mathbf X'\mathbf X(\mathbf X'\mathbf X)^{-1}+(\mathbf X'\mathbf X)^{-1}\underbrace{\mathbf X'\mathbf C'}_{\mathbf 0}+\underbrace{\mathbf C\mathbf X}_{\mathbf 0}(\mathbf X'\mathbf X)^{-1}+\mathbf C\mathbf C'=(\mathbf X'\mathbf X)^{-1}+\mathbf C\mathbf C'.
$$

5. Como $\operatorname{Var}(\widehat\beta\mid\mathbf X)=\sigma^2(\mathbf X'\mathbf X)^{-1}$:

$$\boxed{\operatorname{Var}(\widehat\beta^*\mid\mathbf X)-\operatorname{Var}(\widehat\beta\mid\mathbf X)=\sigma^2\mathbf C\mathbf C'}$$

6. **Semidefinida positiva.** Para qualquer vetor $\mathbf a$ $(K\times 1)$, com $\mathbf w=\mathbf C'\mathbf a$:

$$
\mathbf a'(\sigma^2\mathbf C\mathbf C')\mathbf a=\sigma^2(\mathbf C'\mathbf a)'(\mathbf C'\mathbf a)=\sigma^2\mathbf w'\mathbf w=\sigma^2\sum_{i=1}^n w_i^2\ \ge 0.
$$

7. **Conclusão.** Para qualquer combinação linear $\mathbf a'\beta$, inclusive cada coeficiente isolado ($\mathbf a$ = vetor canônico), a variância de $\mathbf a'\widehat\beta^*$ nunca é menor que a de $\mathbf a'\widehat\beta$. A igualdade só ocorre com $\mathbf C=\mathbf 0$, que é o próprio MQO. Logo o MQO é o **melhor estimador linear não viesado (MELNV, BLUE)**: o Teorema de Gauss-Markov.

> [!WARNING]
> **Onde se perde ponto**
> Chegar em $\sigma^2\mathbf C\mathbf C'$ e parar. O enunciado pede para **mostrar** que a diferença é semidefinida positiva, e isso é o passo 6: a forma quadrática vira uma soma de quadrados. Sem ele, a conclusão de eficiência não está demonstrada. Também vale ponto dizer **por que** os termos cruzados somem (é o $\mathbf C\mathbf X=\mathbf 0$ do passo 2).

| Rubrica | Pontos |
|---|---|
| Substituir o modelo e obter $E(\widehat\beta^*\mid\mathbf X)=\beta+\mathbf C\mathbf X\beta$, logo $\mathbf C\mathbf X=\mathbf 0$ | 0,40 |
| $\operatorname{Var}(\widehat\beta^*\mid\mathbf X)=\sigma^2\mathbf A\mathbf A'$ com a hipótese de esfericidade | 0,25 |
| Expandir e zerar os termos cruzados, chegar em $\sigma^2\mathbf C\mathbf C'$ | 0,40 |
| Mostrar $\mathbf a'\mathbf C\mathbf C'\mathbf a=\lVert\mathbf C'\mathbf a\rVert^2\ge 0$ | 0,30 |
| Conclusão: MQO é MELNV | 0,15 |

<!-- conferência numérica: valores conferidos contra resultados/*.csv pelo scripts/check_numbers.R
| chave_R | nota |
|---|---|
| p26_q5_min_autoval | 32,46 |
-->

---

## Questão 6 (1,0) — Frisch-Waugh-Lovell

> [!NOTE]
> **O que se quer provar**
> No modelo $\mathbf y=\mathbf X_1\beta_1+\mathbf X_2\beta_2+\mathbf u$, com $\mathbf M_1=\mathbf I-\mathbf X_1(\mathbf X_1'\mathbf X_1)^{-1}\mathbf X_1'$: (i) $\mathbf b_2=(\mathbf X_2'\mathbf M_1\mathbf X_2)^{-1}\mathbf X_2'\mathbf M_1\mathbf y$; (ii) esse é o estimador da regressão de $\mathbf M_1\mathbf y$ em $\mathbf M_1\mathbf X_2$. São a D04.1 e a D04.2 de [04_teoria](../../04_fwl_particionada/04_teoria.md).

**Passo a passo.**

1. Escreva as equações normais $\mathbf X'\mathbf X\mathbf b=\mathbf X'\mathbf y$ em blocos, com $\mathbf X=[\mathbf X_1\ \mathbf X_2]$:

$$
\begin{aligned}
\mathbf X_1'\mathbf X_1\mathbf b_1+\mathbf X_1'\mathbf X_2\mathbf b_2&=\mathbf X_1'\mathbf y\qquad(1)\\
\mathbf X_2'\mathbf X_1\mathbf b_1+\mathbf X_2'\mathbf X_2\mathbf b_2&=\mathbf X_2'\mathbf y\qquad(2)
\end{aligned}
$$

2. Isole $\mathbf b_1$ em (1). $\mathbf X_1'\mathbf X_1$ é invertível porque $\mathbf X$ tem posto completo. *[H3]*

$$
\mathbf b_1=(\mathbf X_1'\mathbf X_1)^{-1}\mathbf X_1'(\mathbf y-\mathbf X_2\mathbf b_2).
$$

3. Substitua em (2) e use $\mathbf P_1=\mathbf X_1(\mathbf X_1'\mathbf X_1)^{-1}\mathbf X_1'$:

$$
\mathbf X_2'\mathbf P_1(\mathbf y-\mathbf X_2\mathbf b_2)+\mathbf X_2'\mathbf X_2\mathbf b_2=\mathbf X_2'\mathbf y
\ \Longrightarrow\
\mathbf X_2'(\mathbf I-\mathbf P_1)\mathbf X_2\,\mathbf b_2=\mathbf X_2'(\mathbf I-\mathbf P_1)\mathbf y.
$$

4. Como $\mathbf I-\mathbf P_1=\mathbf M_1$:

$$\boxed{\mathbf b_2=(\mathbf X_2'\mathbf M_1\mathbf X_2)^{-1}\mathbf X_2'\mathbf M_1\mathbf y}$$

5. **$\mathbf M_1$ é simétrica e idempotente.** Simétrica porque $\mathbf P_1'=\mathbf P_1$. Idempotente:

$$
\mathbf M_1\mathbf M_1=\mathbf I-2\mathbf P_1+\mathbf P_1\mathbf P_1=\mathbf I-2\mathbf P_1+\mathbf P_1=\mathbf M_1,
\quad\text{pois}\quad
\mathbf P_1\mathbf P_1=\mathbf X_1(\mathbf X_1'\mathbf X_1)^{-1}\underbrace{\mathbf X_1'\mathbf X_1(\mathbf X_1'\mathbf X_1)^{-1}}_{\mathbf I}\mathbf X_1'=\mathbf P_1.
$$

6. **É a regressão de $\mathbf M_1\mathbf y$ em $\mathbf M_1\mathbf X_2$.** Chame $\mathbf y^*=\mathbf M_1\mathbf y$ e $\mathbf X_2^*=\mathbf M_1\mathbf X_2$. O MQO dessa regressão é

$$
(\mathbf X_2^{*\prime}\mathbf X_2^*)^{-1}\mathbf X_2^{*\prime}\mathbf y^*=(\mathbf X_2'\mathbf M_1'\mathbf M_1\mathbf X_2)^{-1}\mathbf X_2'\mathbf M_1'\mathbf M_1\mathbf y=(\mathbf X_2'\mathbf M_1\mathbf X_2)^{-1}\mathbf X_2'\mathbf M_1\mathbf y=\mathbf b_2,
$$

usando $\mathbf M_1'\mathbf M_1=\mathbf M_1\mathbf M_1=\mathbf M_1$ do passo 5.

**Interpretação.** $\mathbf M_1\mathbf y$ e $\mathbf M_1\mathbf X_2$ são os resíduos de $\mathbf y$ e de $\mathbf X_2$ depois de regredidos em $\mathbf X_1$. O coeficiente de $\mathbf X_2$ no modelo completo mede só a variação de $\mathbf X_2$ que não é explicada por $\mathbf X_1$: é isso que "controlar por $\mathbf X_1$" quer dizer.

> [!TIP]
> **Como o professor pode torcer**
> Pedir que regredir $\mathbf y$ (sem filtrar) em $\mathbf M_1\mathbf X_2$ dá o mesmo $\mathbf b_2$ (dá: $\mathbf X_2'\mathbf M_1\mathbf y=\mathbf X_2'\mathbf M_1\mathbf M_1\mathbf y$), mas os resíduos não são os mesmos. Ou o caso $\mathbf X_1=\mathbf i$, em que $\mathbf M_1$ centra as variáveis (D04.3).

| Rubrica | Pontos |
|---|---|
| Equações normais particionadas | 0,20 |
| Isolar $\mathbf b_1$, substituir e chegar em $\mathbf b_2$ com $\mathbf M_1$ | 0,40 |
| $\mathbf M_1$ simétrica e idempotente (com a conta de $\mathbf P_1\mathbf P_1$) | 0,20 |
| Mostrar que é a regressão de $\mathbf M_1\mathbf y$ em $\mathbf M_1\mathbf X_2$ | 0,20 |

---

## Questão 7 (1,5) — Consistência do MQO por Slutsky

> [!NOTE]
> **O que se quer provar**
> Em $\mathbf y=\mathbf X\beta+\mathbf u$ com $\operatorname{plim}(\mathbf X'\mathbf X/n)=\mathbf Q$ finita e não singular e $\operatorname{plim}(\mathbf X'\mathbf u/n)=\mathbf 0$, mostrar que $\operatorname{plim}\mathbf b=\beta$. É a D08.1 de [08_teoria](../../08_assintotica/08_teoria.md).

**Passo a passo.**

1. Substitua o modelo no estimador. *[H1]*

$$
\mathbf b=(\mathbf X'\mathbf X)^{-1}\mathbf X'(\mathbf X\beta+\mathbf u)=\beta+(\mathbf X'\mathbf X)^{-1}\mathbf X'\mathbf u.
$$

2. Multiplique e divida por $n$ para criar médias amostrais, que têm limite:

$$
\mathbf b=\beta+\left(\frac{\mathbf X'\mathbf X}{n}\right)^{-1}\left(\frac{\mathbf X'\mathbf u}{n}\right).
$$

3. **Teorema de Slutsky:** se $g$ é contínua no ponto $\operatorname{plim}\mathbf W_n$, então $\operatorname{plim}g(\mathbf W_n)=g(\operatorname{plim}\mathbf W_n)$. A inversa de matriz é contínua em toda matriz não singular, e $\mathbf Q$ é não singular por hipótese:

$$
\operatorname{plim}\left(\frac{\mathbf X'\mathbf X}{n}\right)^{-1}=\left[\operatorname{plim}\frac{\mathbf X'\mathbf X}{n}\right]^{-1}=\mathbf Q^{-1}.
$$

4. O produto também é função contínua, então o plim do produto é o produto dos plims:

$$
\operatorname{plim}\mathbf b=\beta+\mathbf Q^{-1}\cdot\operatorname{plim}\frac{\mathbf X'\mathbf u}{n}=\beta+\mathbf Q^{-1}\cdot\mathbf 0
$$

$$\boxed{\operatorname{plim}\mathbf b=\beta}$$

**Significado estatístico.** Para todo $\varepsilon>0$, $P(\lVert\mathbf b-\beta\rVert>\varepsilon)\to 0$ quando $n\to\infty$: a distribuição de $\mathbf b$ se concentra cada vez mais em torno de $\beta$. É uma propriedade de **amostra grande**, diferente do não viesamento ($E(\mathbf b)=\beta$ para todo $n$). Um estimador pode ser viesado e consistente, como o AR(1) com variável dependente defasada (D08.7). A prova não usa normalidade: a simulação de [reproducao.R](reproducao.R), com erro $t$ de Student, dá $P(\lvert b_2-\beta_2\rvert>0{,}05)$ de 0,775 com $n=50$ e zero com $n=50.000$.

**Significado econômico.** Com amostras grandes, a estimativa recupera o verdadeiro parâmetro de comportamento (o retorno da educação, a propensão a consumir). Isso depende das duas hipóteses: (i) $\operatorname{plim}(\mathbf X'\mathbf u/n)=\mathbf 0$, os regressores não se correlacionam com os fatores não observados, exatamente o que falha na Q4; (ii) $\mathbf Q$ finita e não singular, os regressores variam o bastante e sem multicolinearidade perfeita, para que a informação cresça com $n$.

> [!WARNING]
> **Os dois cuidados que separam a nota cheia**
> Dizer que a inversa é contínua **porque $\mathbf Q$ é não singular** (é aí que essa hipótese entra) e explicar a diferença entre consistência e não viesamento. Sem esses dois pontos, a resposta perde a parte de "significado".

| Rubrica | Pontos |
|---|---|
| Decomposição $\mathbf b=\beta+(\mathbf X'\mathbf X/n)^{-1}(\mathbf X'\mathbf u/n)$ | 0,40 |
| Slutsky com a continuidade da inversa (Q não singular) | 0,40 |
| Resultado $\operatorname{plim}\mathbf b=\beta$ | 0,20 |
| Significado estatístico (convergência em probabilidade; ≠ não viesamento) | 0,25 |
| Significado econômico, ligado às duas hipóteses | 0,25 |

<!-- conferência numérica: valores conferidos contra resultados/*.csv pelo scripts/check_numbers.R
| chave_R | nota |
|---|---|
| p26_q7_prob_n50 | 0,775 |
| p26_q7_prob_n50000 | 0 |
-->
