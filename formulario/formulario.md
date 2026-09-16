---
title: "Formulário da P1"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
relevancia_p1: alta
status: rascunho
tags:
  - econometria
  - mestrado/ppgeco
  - p1
aliases:
  - Formulário
---

# Formulário da P1

Tudo o que precisa sair de cabeça em 02/10, na ordem dos módulos. A leitura dos testes está em [vocabulario_interpretacao.md](vocabulario_interpretacao.md).

---

## 0. Operadores ([módulo 00](../00_fundamentos/README.md))

$$E[a+bX]=a+bE[X],\qquad \operatorname{Var}(a+bX)=b^2\operatorname{Var}(X),\qquad \operatorname{Var}(X)=E[X^2]-(E[X])^2$$

$$\operatorname{Cov}(X,Y)=E[XY]-E[X]E[Y],\qquad \operatorname{Var}(X\pm Y)=\operatorname{Var}(X)+\operatorname{Var}(Y)\pm 2\operatorname{Cov}(X,Y)$$

$$\operatorname{Var}(Ax)=A\,\Sigma\,A' \quad (x \text{ vetor}),\qquad E[y]=E\big[E[y\mid x]\big] \ \text{(lei das esperanças iteradas)}$$

$$\operatorname{Var}(y)=\operatorname{Var}\big(E[y\mid x]\big)+E\big[\operatorname{Var}(y\mid x)\big]$$

Média amostral: $E[\bar X]=\mu$, $\operatorname{Var}(\bar X)=\sigma^2/n$, logo $\bar X$ é consistente (Chebyshev).

Erro quadrático médio: $EQM(\hat\theta)=E[(\hat\theta-\theta)^2]=\operatorname{Var}(\hat\theta)+[\text{viés}(\hat\theta)]^2$.

## 1. Modelo e hipóteses ([módulo 01](../01_paradigma_projecao/README.md))

Modelo: $y=X\beta+\varepsilon$, com $X$ de dimensão $n\times K$ incluindo a coluna de 1s.

| Id | Hipótese |
|---|---|
| A1 | linearidade nos parâmetros |
| A2 | posto completo, $\operatorname{posto}(X)=K$ |
| A3 | exogeneidade estrita, $E[\varepsilon\mid X]=0$ |
| A4 | erros esféricos, $E[\varepsilon\varepsilon'\mid X]=\sigma^2I$ |
| A5 | $X$ gerado independentemente do processo de $\varepsilon$ |
| A6 | normalidade, $\varepsilon\mid X\sim N(0,\sigma^2I)$ |

Projeção linear populacional: $\beta=\operatorname{Var}(x)^{-1}\operatorname{Cov}(x,y)$ e $\alpha=E[y]-\beta'E[x]$.

## 2. Regressão simples ([módulo 02](../02_mqo_simples/README.md))

Notação da lista: $Y_i=\beta_1+\beta_2X_i+u_i$; desvios $x_i=X_i-\bar X$, $y_i=Y_i-\bar Y$; $S_{XX}=\sum x_i^2$, $S_{XY}=\sum x_iy_i$.

$$\hat\beta_2=\frac{S_{XY}}{S_{XX}}=\frac{\widehat{\operatorname{Cov}}(X,Y)}{\widehat{\operatorname{Var}}(X)},\qquad \hat\beta_1=\bar Y-\hat\beta_2\bar X$$

Pesos: $k_i=x_i/S_{XX}$, com $\sum k_i=0$, $\sum k_iX_i=1$, $\sum k_i^2=1/S_{XX}$; daí $\hat\beta_2=\beta_2+\sum k_iu_i$.

$$\operatorname{Var}(\hat\beta_2\mid X)=\frac{\sigma^2}{S_{XX}},\qquad \operatorname{Var}(\hat\beta_1\mid X)=\sigma^2\left(\frac1n+\frac{\bar X^2}{S_{XX}}\right),\qquad \operatorname{Cov}(\hat\beta_1,\hat\beta_2)=-\bar X\frac{\sigma^2}{S_{XX}}$$

$$\hat\sigma^2=\frac{\sum \hat u_i^2}{n-2},\qquad R^2=r_{XY}^2,\qquad t^2=F \ \text{(regressão simples)}$$

Viés de omissão (escalar): omitindo $X_3$ verdadeiro,
$$E[\hat\beta_2]=\beta_2+\beta_3\frac{\sum(X_{i2}-\bar X_2)X_{i3}}{\sum(X_{i2}-\bar X_2)^2}=\beta_2+\beta_3\hat\delta.$$

Propriedades algébricas: $\sum\hat u_i=0$, $\sum X_i\hat u_i=0$, $\bar{\hat Y}=\bar Y$, e a reta passa por $(\bar X,\bar Y)$.

## 3. Forma matricial ([módulo 03](../03_mqo_matricial/README.md))

$$b=(X'X)^{-1}X'y,\qquad e=y-Xb=My,\qquad \hat y=Xb=Py$$

$$P=X(X'X)^{-1}X',\qquad M=I-P$$

$P$ e $M$ são simétricas e idempotentes, $PX=X$, $MX=0$, $PM=0$, $\operatorname{tr}(P)=K$, $\operatorname{tr}(M)=n-K$.

$$X'e=0,\qquad e'e=y'y-b'X'y,\qquad SQT=SQE+SQR \ \text{(com intercepto)}$$

## 4. Regressão particionada e FWL ([módulo 04](../04_fwl_particionada/README.md))

Com $y=X_1\beta_1+X_2\beta_2+\varepsilon$ e $M_1=I-X_1(X_1'X_1)^{-1}X_1'$:

$$b_2=(X_2'M_1X_2)^{-1}X_2'M_1y$$

Regredir $y$ em $X$ dá o mesmo $b_2$ que regredir $M_1y$ em $M_1X_2$; os resíduos coincidem. Incluir constante equivale a centrar as variáveis; efeitos fixos equivalem à transformação *within*.

Viés de omissão (matricial): $E[b_1\mid X]=\beta_1+(X_1'X_1)^{-1}X_1'X_2\beta_2$.

## 5. Ajuste e restrições ([módulo 05](../05_ajuste_restricoes/README.md))

$$R^2=1-\frac{e'e}{y'M^0y},\qquad \bar R^2=1-\frac{n-1}{n-K}(1-R^2)$$

$\bar R^2$ sobe ao incluir um regressor se e só se $\lvert t\rvert \gt 1$.

$$AIC=\frac{-2\ln L}{n}+\frac{2K}{n},\qquad SC=\frac{-2\ln L}{n}+\frac{K\ln n}{n},\qquad \ln L=-\frac n2\left[1+\ln 2\pi+\ln\frac{e'e}{n}\right]$$

Mínimos quadrados restritos, com $R\beta=q$:

$$b_*=b-(X'X)^{-1}R'\big[R(X'X)^{-1}R'\big]^{-1}(Rb-q)$$

$$e_*'e_*-e'e=(Rb-q)'\big[R(X'X)^{-1}R'\big]^{-1}(Rb-q)\ \ge 0$$

$$F=\frac{(Rb-q)'[R(X'X)^{-1}R']^{-1}(Rb-q)/J}{s^2}=\frac{(SQR_R-SQR_{IR})/J}{SQR_{IR}/(n-K)}=\frac{(R^2_{IR}-R^2_R)/J}{(1-R^2_{IR})/(n-K)}$$

Caso particular (todas as inclinações): $F=\dfrac{R^2/(K-1)}{(1-R^2)/(n-K)}$.

## 6. Amostra finita ([módulo 06](../06_amostra_finita_multicol/README.md))

$$E[b\mid X]=\beta,\qquad \operatorname{Var}(b\mid X)=\sigma^2(X'X)^{-1},\qquad s^2=\frac{e'e}{n-K},\qquad E[e'e\mid X]=\sigma^2(n-K)$$

Gauss-Markov: entre os lineares e não viesados, $b$ tem a menor variância. Para $b_*=[(X'X)^{-1}X'+C]y$, não-viés exige $CX=0$ e então $\operatorname{Var}(b_*)=\sigma^2(X'X)^{-1}+\sigma^2CC'$, com $CC'$ semidefinida positiva.

Sob A6: $b\mid X\sim N(\beta,\sigma^2(X'X)^{-1})$ e $(n-K)s^2/\sigma^2\sim\chi^2_{n-K}$, independentes.

$$\operatorname{Var}(b_k)=\frac{\sigma^2}{(1-R_k^2)\,S_{kk}},\qquad FIV_k=\frac{1}{1-R_k^2}$$

## 7. Testes ([módulo 07](../07_testes_hipoteses/README.md))

$$t=\frac{\hat\beta_k-\beta_k^0}{\text{E.p.}(\hat\beta_k)}\sim t_{n-K},\qquad W=J\cdot F\ \xrightarrow{d}\ \chi^2_J,\qquad LR=n\ln\frac{SQR_R}{SQR_{IR}},\qquad LM=nR^2_{aux}$$

$$JB=n\left[\frac{S^2}{6}+\frac{(C-3)^2}{24}\right]\sim\chi^2_2$$

Variável omitida relevante ⇒ viés; variável irrelevante incluída ⇒ não vicia, mas infla a variância.

## 8. Assintótica ([módulo 08](../08_assintotica/README.md))

$$b=\beta+\left(\frac{X'X}{n}\right)^{-1}\frac{X'\varepsilon}{n},\qquad \operatorname{plim}\frac{X'X}{n}=Q,\qquad \operatorname{plim}\frac{X'\varepsilon}{n}=0\ \Rightarrow\ \operatorname{plim} b=\beta$$

$$\sqrt n\,(b-\beta)\ \xrightarrow{d}\ N\!\left(0,\ \sigma^2Q^{-1}\right)$$

Slutsky: $\operatorname{plim}(g(x_n))=g(\operatorname{plim}x_n)$ para $g$ contínua; o plim de produto é o produto dos plims.

Covariância robusta de White (HC0):
$$\widehat{\operatorname{Var}}(b)=(X'X)^{-1}\left(\sum_i e_i^2x_ix_i'\right)(X'X)^{-1}$$

Método delta: se $\sqrt n(\hat\theta-\theta)\to N(0,\Sigma)$, então $g(\hat\theta)$ tem variância assintótica $g'(\theta)'\Sigma\,g'(\theta)/n$. Para o ponto de máximo $X^*=-a_3/(2a_4)$:
$$\frac{\partial X^*}{\partial a_3}=-\frac{1}{2a_4},\qquad \frac{\partial X^*}{\partial a_4}=\frac{a_3}{2a_4^2}.$$

## 9. Dummies e forma funcional ([módulo 09](../09_dummies_forma_funcional/README.md))

- Dummy de intercepto: $Y=\alpha_1+\alpha_2D+\beta X+u$; dummy de inclinação: interação $D\cdot X$.
- Efeito exato de dummy em modelo log: $100(e^{\hat\beta}-1)\%$.
- Armadilha da dummy: com intercepto, use $m-1$ dummies para $m$ categorias, senão $X'X$ é singular.
- Ponto de máximo do quadrático: $X^*=-\beta_2/(2\beta_3)$, máximo se $\beta_3\lt 0$.
- Cobb-Douglas $Y=AX_1^{\alpha}X_2^{\beta}e^{u}$ vira linear em logs; o erro precisa ser multiplicativo.
- Chow: $F=\dfrac{(SQR_P-(SQR_1+SQR_2))/K}{(SQR_1+SQR_2)/(n_1+n_2-2K)}$.
- Diferenças em diferenças: $y_{it}=\beta_0+\beta_1D_i+\beta_2T_t+\beta_3D_iT_t+\beta'x_{it}+\varepsilon_{it}$, com
$$E[\Delta y\mid D=1]-E[\Delta y\mid D=0]=\beta_3+\beta'\big[(\Delta x\mid D=1)-(\Delta x\mid D=0)\big].$$
Controles invariantes no tempo somem no $\Delta$: $\beta_3$ sozinho é o efeito do tratamento, sob tendências paralelas.

## 10. Endogeneidade e VI ([módulo 10](../10_endogeneidade_iv/README.md))

Endogeneidade: $\operatorname{plim}(X'\varepsilon/n)=\gamma\neq 0 \Rightarrow \operatorname{plim} b=\beta+Q^{-1}\gamma$ (MQO inconsistente).

Exatamente identificado ($L=K$), a partir de $\operatorname{plim}(Z'\varepsilon/n)=0$:
$$\hat\beta_{IV}=(Z'X)^{-1}Z'y$$

Sobreidentificado ($L\gt K$), com $\hat X=P_ZX$:
$$\hat\beta_{MQ2E}=\big[X'Z(Z'Z)^{-1}Z'X\big]^{-1}X'Z(Z'Z)^{-1}Z'y=(\hat X'\hat X)^{-1}\hat X'y$$

Se $Z=X$, o VI colapsa no MQO. Os erros-padrão do 2º estágio ingênuo estão errados: o resíduo tem de usar $X$, não $\hat X$.

Erro de medição no regressor ($X=X^*+w$): atenuação
$$\operatorname{plim}\hat\beta=\beta\,\frac{\sigma^2_{X^*}}{\sigma^2_{X^*}+\sigma^2_w}\ \Rightarrow\ \lvert\operatorname{plim}\hat\beta\rvert\lt\lvert\beta\rvert.$$

Erro de medição na dependente ($Y=Y^*+\varepsilon$): **não** vicia; só infla a variância,
$$\operatorname{Var}(\hat\beta)=\frac{\sigma^2_\mu+\sigma^2_\varepsilon}{S_{XX}}.$$

Simultaneidade keynesiana ($C_t=\beta_0+\beta_1Y_t+u_t$, $Y_t=C_t+I_t$):
$$\operatorname{plim}\hat\beta_1-\beta_1=\frac{(1-\beta_1)\sigma^2_u}{\sigma^2_I+\sigma^2_u}\gt 0.$$

## Valores críticos usuais

| Distribuição | 10% | 5% | 1% |
|---|---|---|---|
| $z$ bilateral | 1,645 | 1,960 | 2,576 |
| $z$ unilateral | 1,282 | 1,645 | 2,326 |
| $\chi^2_1$ | 2,706 | 3,841 | 6,635 |
| $\chi^2_2$ | 4,605 | 5,991 | 9,210 |
| $\chi^2_3$ | 6,251 | 7,815 | 11,345 |
| $\chi^2_5$ | 9,236 | 11,070 | 15,086 |

> [!TIP]
> **Na prova, o valor crítico costuma vir dado**
> O enunciado quase sempre entrega o $z$, $t$, $F$ ou $\chi^2$ tabelado. Use o número do enunciado, mesmo que difira do que você lembra, e diga qual foi usado.
