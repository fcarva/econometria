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

Tudo o que precisa sair de cabeça em 09/10, na ordem dos módulos. A leitura dos testes está em [vocabulario_interpretacao.md](vocabulario_interpretacao.md).

---

## 0. Operadores ([módulo 00](../00_fundamentos/README.md))

$$E(a+bX)=a+bE(X),\qquad \operatorname{Var}(a+bX)=b^2\operatorname{Var}(X),\qquad \operatorname{Var}(X)=E(X^2)-(E(X))^2$$

$$\operatorname{Cov}(X,Y)=E(XY)-E(X)E(Y),\qquad \operatorname{Var}(X\pm Y)=\operatorname{Var}(X)+\operatorname{Var}(Y)\pm 2\operatorname{Cov}(X,Y)$$

$$\operatorname{Var}(\mathbf{A}x)=\mathbf A\,\Sigma\,\mathbf A' \quad (x \text{ vetor}),\qquad E(\mathbf y)=E\big(E(\mathbf y\mid x)\big) \ \text{(lei das esperanças iteradas)}$$

$$\operatorname{Var}(y)=\operatorname{Var}\big(E(y\mid x)\big)+E\big(\operatorname{Var}(y\mid x)\big)$$

Média amostral: $E(\bar X)=\mu$, $\operatorname{Var}(\bar X)=\sigma^2/n$, logo $\bar X$ é consistente (Chebyshev).

Erro quadrático médio: $EQM(\widehat\theta)=E((\widehat\theta-\theta)^2)=\operatorname{Var}(\widehat\theta)+[\text{viés}(\widehat\theta)]^2$.

## 1. Modelo e hipóteses ([módulo 01](../01_paradigma_projecao/README.md))

Modelo: $y=X\beta+\varepsilon$, com $X$ de dimensão $n\times K$ incluindo a coluna de 1s.

| Id | Hipótese |
|---|---|
| H1 | linearidade nos parâmetros |
| H3 | posto completo, $\operatorname{posto}(X)=K$ |
| H2 | exogeneidade estrita, $E(\varepsilon\mid X)=0$ |
| H4 | erros esféricos, $E(\varepsilon\varepsilon'\mid X)=\sigma^2I$ |
| H2 | $X$ gerado independentemente do processo de $\varepsilon$ |
| H5 | normalidade, $\varepsilon\mid X\sim N(0,\sigma^2I)$ |

Projeção linear populacional: $\beta=\operatorname{Var}(x)^{-1}\operatorname{Cov}(x,\mathbf y)$ e $\alpha=E(\mathbf y)-\beta'E(x)$.

## 2. Regressão simples ([módulo 02](../02_mqo_simples/README.md))

Notação da lista: $Y_i=\beta_1+\beta_2X_i+u_i$; desvios $x_i=X_i-\bar X$, $y_i=Y_i-\bar Y$; $S_{XX}=\sum x_i^2$, $S_{XY}=\sum x_iy_i$.

$$\widehat\beta_2=\frac{S_{XY}}{S_{XX}}=\frac{\widehat{\operatorname{Cov}}(X,Y)}{\widehat{\operatorname{Var}}(X)},\qquad \widehat\beta_1=\bar Y-\widehat\beta_2\bar X$$

Pesos: $w_i=x_i/S_{XX}$, com $\sum w_i=0$, $\sum w_iX_i=1$, $\sum w_i^2=1/S_{XX}$; daí $\widehat\beta_2=\beta_2+\sum w_iu_i$.

$$\operatorname{Var}(\widehat\beta_2\mid X)=\frac{\sigma^2}{S_{XX}},\qquad \operatorname{Var}(\widehat\beta_1\mid X)=\sigma^2\left(\frac1n+\frac{\bar X^2}{S_{XX}}\right),\qquad \operatorname{Cov}(\widehat\beta_1,\widehat\beta_2)=-\bar X\frac{\sigma^2}{S_{XX}}$$

$$\widehat\sigma^2=\frac{\sum \widehat u_i^2}{n-2},\qquad R^2=r_{XY}^2,\qquad t^2=F \ \text{(regressão simples)}$$

Viés de omissão (escalar): omitindo $X_3$ verdadeiro,
$$E(\widehat\beta_2)=\beta_2+\beta_3\frac{\sum(X_{i2}-\bar X_2)X_{i3}}{\sum(X_{i2}-\bar X_2)^2}=\beta_2+\beta_3\widehat\delta.$$

Propriedades algébricas: $\sum\widehat u_i=0$, $\sum X_i\widehat u_i=0$, $\bar{\widehat Y}=\bar Y$, e a reta passa por $(\bar X,\bar Y)$.

## 3. Forma matricial ([módulo 03](../03_mqo_matricial/README.md))

$$\mathbf b=(\mathbf X'\mathbf X)^{-1}\mathbf X'\mathbf y,\qquad \mathbf e=\mathbf y-\mathbf X\mathbf b=\mathbf M\mathbf y,\qquad \widehat{\mathbf y}=\mathbf X\mathbf b=\mathbf P\mathbf y$$

$$\mathbf P=\mathbf X(\mathbf X'\mathbf X)^{-1}\mathbf X',\qquad \mathbf M=\mathbf I-\mathbf P$$

$\mathbf P$ e $\mathbf M$ são simétricas e idempotentes, $\mathbf P\mathbf X=\mathbf X$, $\mathbf M\mathbf X=0$, $\mathbf P\mathbf M=0$, $\operatorname{tr}(\mathbf P)=K$, $\operatorname{tr}(\mathbf M)=n-K$.

$$\mathbf X'\mathbf e=0,\qquad \mathbf e'\mathbf e=\mathbf y'\mathbf y-\mathbf b'\mathbf X'\mathbf y,\qquad SQT=SQE+SQR \ \text{(com intercepto)}$$

## 4. Regressão particionada e FWL ([módulo 04](../04_fwl_particionada/README.md))

Com $\mathbf y=\mathbf X_1\beta_1+\mathbf X_2\beta_2+\varepsilon$ e $\mathbf M_1=\mathbf I-\mathbf X_1(\mathbf X_1'\mathbf X_1)^{-1}\mathbf X_1'$:

$$\mathbf b_2=(\mathbf X_2'\mathbf M_1\mathbf X_2)^{-1}\mathbf X_2'\mathbf M_1\mathbf y$$

Regredir $\mathbf y$ em $\mathbf X$ dá o mesmo $\mathbf b_2$ que regredir $\mathbf M_1\mathbf y$ em $\mathbf M_1\mathbf X_2$; os resíduos coincidem. Incluir constante equivale a centrar as variáveis; efeitos fixos equivalem à transformação *within*.

Viés de omissão (matricial): $E(\mathbf b_1\mid \mathbf X)=\beta_1+(\mathbf X_1'\mathbf X_1)^{-1}\mathbf X_1'\mathbf X_2\beta_2$.

## 5. Ajuste e restrições ([módulo 05](../05_ajuste_restricoes/README.md))

$$R^2=1-\frac{\mathbf e'\mathbf e}{\mathbf y'\mathbf M^0\mathbf y},\qquad \bar R^2=1-\frac{n-1}{n-K}(1-R^2)$$

$\bar R^2$ sobe ao incluir um regressor se e só se $\lvert t\rvert \gt 1$.

$$AIC=\frac{-2\ln L}{n}+\frac{2K}{n},\qquad SC=\frac{-2\ln L}{n}+\frac{K\ln n}{n},\qquad \ln L=-\frac n2\left[1+\ln 2\pi+\ln\frac{\mathbf e'\mathbf e}{n}\right]$$

Mínimos quadrados restritos, com $R\beta=r$:

$$\mathbf b_R=\mathbf b-(\mathbf X'\mathbf X)^{-1}\mathbf R'\big[\mathbf R(\mathbf X'\mathbf X)^{-1}\mathbf R'\big]^{-1}(\mathbf R\mathbf b-\mathbf r)$$

$$\mathbf e_{\mathbf R}'\mathbf e_R-\mathbf e'\mathbf e=(\mathbf R\mathbf b-\mathbf r)'\big[\mathbf R(\mathbf X'\mathbf X)^{-1}\mathbf R'\big]^{-1}(\mathbf R\mathbf b-\mathbf r)\ \ge 0$$

$$F=\frac{(\mathbf R\mathbf b-\mathbf r)'[\mathbf R(\mathbf X'\mathbf X)^{-1}\mathbf R']^{-1}(\mathbf R\mathbf b-\mathbf r)/q}{s^2}=\frac{(SQR_R-SQR_{UR})/q}{SQR_{UR}/(n-K)}=\frac{(R^2_{UR}-R^2_R)/q}{(1-R^2_{UR})/(n-K)}$$

Caso particular (todas as inclinações): $F=\dfrac{R^2/(K-1)}{(1-R^2)/(n-K)}$.

## 6. Amostra finita ([módulo 06](../06_amostra_finita_multicol/README.md))

$$E(\mathbf b\mid \mathbf X)=\beta,\qquad \operatorname{Var}(\mathbf b\mid \mathbf X)=\sigma^2(\mathbf X'\mathbf X)^{-1},\qquad s^2=\frac{\mathbf e'\mathbf e}{n-K},\qquad E(\mathbf e'\mathbf e\mid \mathbf X)=\sigma^2(n-K)$$

Gauss-Markov: entre os lineares e não viesados, $\mathbf b$ tem a menor variância. Para $\mathbf b_{\mathbf R}=[(\mathbf X'\mathbf X)^{-1}\mathbf X'+\mathbf C]\mathbf y$, não-viés exige $\mathbf C\mathbf X=0$ e então $\operatorname{Var}(\mathbf b_R)=\sigma^2(\mathbf X'\mathbf X)^{-1}+\sigma^2\mathbf C\mathbf C'$, com $\mathbf C\mathbf C'$ semidefinida positiva.

Sob H5: $\mathbf b\mid \mathbf X\sim N(\beta,\sigma^2(\mathbf X'\mathbf X)^{-1})$ e $(n-K)s^2/\sigma^2\sim\chi^2_{n-K}$, independentes.

$$\operatorname{Var}(b_k)=\frac{\sigma^2}{(1-R_k^2)\,S_{kk}},\qquad VIF_k=\frac{1}{1-R_k^2}$$

## 7. Testes ([módulo 07](../07_testes_hipoteses/README.md))

$$t=\frac{\widehat\beta_k-\beta_k^0}{ep(\widehat\beta_k)}\sim t_{n-K},\qquad W=q\cdot F\ \xrightarrow{d}\ \chi^2_q,\qquad LR=n\ln\frac{SQR_R}{SQR_{UR}},\qquad LM=nR^2_{aux}$$

$$JB=n\left[\frac{S^2}{6}+\frac{(C-3)^2}{24}\right]\sim\chi^2_2$$

Variável omitida relevante ⇒ viés; variável irrelevante incluída ⇒ não vicia, mas infla a variância.

## 8. Assintótica ([módulo 08](../08_assintotica/README.md))

$$\mathbf b=\beta+\left(\frac{\mathbf X'\mathbf X}{n}\right)^{-1}\frac{\mathbf X'\varepsilon}{n},\qquad \operatorname{plim}\frac{\mathbf X'\mathbf X}{n}=\mathbf Q,\qquad \operatorname{plim}\frac{\mathbf X'\varepsilon}{n}=0\ \Rightarrow\ \operatorname{plim} \mathbf b=\beta$$

$$\sqrt n\,(\mathbf b-\beta)\ \xrightarrow{d}\ N\!\left(0,\ \sigma^2\mathbf Q^{-1}\right)$$

Slutsky: $\operatorname{plim}(g(x_n))=g(\operatorname{plim}x_n)$ para $g$ contínua; o plim de produto é o produto dos plims.

Covariância robusta de White (HC0):
$$\widehat{\operatorname{Var}}(\mathbf b)=(\mathbf X'\mathbf X)^{-1}\left(\sum_i e_i^2\mathbf x_i\mathbf x_i'\right)(\mathbf X'\mathbf X)^{-1}$$

Método delta: se $\sqrt n(\widehat\theta-\theta)\to N(0,\Sigma)$, então $g(\widehat\theta)$ tem variância assintótica $g'(\theta)'\Sigma\,g'(\theta)/n$. Para o ponto de máximo $\mathbf X^*=-a_3/(2a_4)$:
$$\frac{\partial X^*}{\partial a_3}=-\frac{1}{2a_4},\qquad \frac{\partial X^*}{\partial a_4}=\frac{a_3}{2a_4^2}.$$

## 9. Dummies e forma funcional ([módulo 09](../09_dummies_forma_funcional/README.md))

- Dummy de intercepto: $Y=\alpha_1+\alpha_2D+\beta X+u$; dummy de inclinação: interação $D\cdot X$.
- Efeito exato de dummy em modelo log: $100(e^{\widehat\beta}-1)\%$.
- Armadilha da dummy: com intercepto, use $m-1$ dummies para $m$ categorias, senão $\mathbf X'\mathbf X$ é singular.
- Ponto de máximo do quadrático: $X^*=-\beta_2/(2\beta_3)$, máximo se $\beta_3\lt 0$.
- Cobb-Douglas $Y=AX_1^{\alpha}X_2^{\beta}e^{u}$ vira linear em logs; o erro precisa ser multiplicativo.
- Chow: $F=\dfrac{(SQR_P-(SQR_1+SQR_2))/K}{(SQR_1+SQR_2)/(n_1+n_2-2K)}$.
- Diferenças em diferenças: $y_{it}=\beta_0+\beta_1D_i+\beta_2T_t+\beta_3D_iT_t+\beta'x_{it}+\varepsilon_{it}$, com
$$E(\Delta y\mid D=1)-E(\Delta y\mid D=0)=\beta_3+\beta'\big[(\Delta x\mid D=1)-(\Delta x\mid D=0)\big].$$
Controles invariantes no tempo somem no $\Delta$: $\beta_3$ sozinho é o efeito do tratamento, sob tendências paralelas.

## 10. Endogeneidade e VI ([módulo 10](../10_endogeneidade_iv/README.md))

Endogeneidade: $\operatorname{plim}(\mathbf X'\varepsilon/n)=\gamma\neq 0 \Rightarrow \operatorname{plim} \mathbf b=\beta+\mathbf Q^{-1}\gamma$ (MQO inconsistente).

Exatamente identificado ($L=K$), a partir de $\operatorname{plim}(\mathbf Z'\varepsilon/n)=0$:
$$\widehat\beta_{IV}=(\mathbf Z'\mathbf X)^{-1}\mathbf Z'\mathbf y$$

Sobreidentificado ($L\gt K$), com $\widehat X=P_ZX$:
$$\widehat\beta_{MQ2E}=\big[\mathbf X'\mathbf Z(\mathbf Z'\mathbf Z)^{-1}\mathbf Z'\mathbf X\big]^{-1}\mathbf X'\mathbf Z(\mathbf Z'\mathbf Z)^{-1}\mathbf Z'\mathbf y=(\widehat{\mathbf X}'\widehat{\mathbf X})^{-1}\widehat{\mathbf X}'\mathbf y$$

Se $\mathbf Z=\mathbf X$, o VI colapsa no MQO. Os erros-padrão do 2º estágio ingênuo estão errados: o resíduo tem de usar $\mathbf X$, não $\widehat{\mathbf X}$.

Erro de medição no regressor ($X=X^*+w$): atenuação
$$\operatorname{plim}\widehat\beta=\beta\,\frac{\sigma^2_{X^*}}{\sigma^2_{X^*}+\sigma^2_w}\ \Rightarrow\ \lvert\operatorname{plim}\widehat\beta\rvert\lt\lvert\beta\rvert.$$

Erro de medição na dependente ($Y=Y^*+\varepsilon$): **não** vicia; só infla a variância,
$$\operatorname{Var}(\widehat\beta)=\frac{\sigma^2_\mu+\sigma^2_\varepsilon}{S_{XX}}.$$

Simultaneidade keynesiana ($C_t=\beta_0+\beta_1Y_t+u_t$, $Y_t=C_t+I_t$):
$$\operatorname{plim}\widehat\beta_1-\beta_1=\frac{(1-\beta_1)\sigma^2_u}{\sigma^2_I+\sigma^2_u}\gt 0.$$

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
