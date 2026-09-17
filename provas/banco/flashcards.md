---
title: "Flashcards — revisão espaçada para a P1"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
relevancia_p1: alta
status: rascunho
tags:
  - econometria
  - mestrado/ppgeco
  - p1
  - revisao
aliases:
  - Flashcards
---

# Flashcards

Sessenta perguntas curtas para as revisões de +1, +3 e +7 dias do [cronograma](../../CRONOGRAMA.md). A resposta fica escondida: leia a pergunta, responda **em voz alta ou no papel**, só então abra.

> [!TIP]
> **Como usar**
> Dez cartões por sessão, 6 minutos. Todo cartão errado vai para o [log de erros](../log_erros.md) e volta no dia seguinte. Não vale "eu sabia mais ou menos": ou saiu completo, ou está errado.

---

## Fundamentos e hipóteses

**1.** Quais são as cinco hipóteses na numeração do professor (h1 a h5)?
<details><summary>resposta</summary>
h1 parâmetros lineares · h2 amostra aleatória · h3 variação em X · h4 exogeneidade estrita, E[ε|X]=0 · h5 ausência de multicolinearidade. Homocedasticidade e ausência de autocorrelação entram junto com a variância; normalidade, só na inferência exata.
</details>

**2.** Qual hipótese garante o não-viés, e qual garante a eficiência?
<details><summary>resposta</summary>
Não-viés: h4 (A3), $E[\varepsilon\mid X]=0$. Eficiência: A4, erros esféricos $E[\varepsilon\varepsilon'\mid X]=\sigma^2I$, que é o que sustenta Gauss-Markov.
</details>

**3.** O que a normalidade do erro acrescenta?
<details><summary>resposta</summary>
Nada para não-viés ou Gauss-Markov. Ela dá a distribuição **exata** de $t$ e $F$ em amostra pequena. Com $n$ grande, o TLC substitui.
</details>

**4.** Diferença entre erro e resíduo.
<details><summary>resposta</summary>
Erro $\varepsilon_i$ é populacional e não observável; resíduo $\hat u_i$ é amostral e calculado a partir da reta estimada.
</details>

**5.** $EQM(\hat\theta)$ em função de variância e viés.
<details><summary>resposta</summary>
$EQM=\operatorname{Var}(\hat\theta)+[\text{viés}(\hat\theta)]^2$. É o que permite preferir um estimador viesado, se ele for bem mais preciso.
</details>

**6.** Covariância zero implica independência?
<details><summary>resposta</summary>
Não — só mede associação linear. Contraexemplo: $X$ simétrica em zero e $Y=X^2$. Vale a volta só sob normalidade conjunta.
</details>

**7.** Prove em uma linha que a média amostral é consistente.
<details><summary>resposta</summary>
$E[\bar X]=\mu$ e $\operatorname{Var}(\bar X)=\sigma^2/n\to 0$; por Chebyshev, $\Pr(\lvert\bar X-\mu\rvert\ge\delta)\le\sigma^2/(n\delta^2)\to 0$.
</details>

## MQO escalar

**8.** As duas equações normais.
<details><summary>resposta</summary>
$\sum\hat u_i=0$ e $\sum X_i\hat u_i=0$ — são as condições de primeira ordem, não hipóteses.
</details>

**9.** $\hat\beta_2$ em três formas equivalentes.
<details><summary>resposta</summary>
$\dfrac{S_{XY}}{S_{XX}}=\dfrac{\sum(X_i-\bar X)(Y_i-\bar Y)}{\sum(X_i-\bar X)^2}=\dfrac{\widehat{\operatorname{Cov}}(X,Y)}{\widehat{\operatorname{Var}}(X)}$.
</details>

**10.** As três propriedades dos pesos $k_i$.
<details><summary>resposta</summary>
$\sum k_i=0$, $\sum k_iX_i=1$, $\sum k_i^2=1/S_{XX}$, com $k_i=(X_i-\bar X)/S_{XX}$.
</details>

**11.** Por que $\hat\beta_2=\beta_2+\sum k_i u_i$ resolve o não-viés?
<details><summary>resposta</summary>
Porque, condicionando em $X$, os $k_i$ são constantes e $E[u_i\mid X]=0$, então a soma some.
</details>

**12.** $\operatorname{Var}(\hat\beta_1)$ e $\operatorname{Cov}(\hat\beta_1,\hat\beta_2)$.
<details><summary>resposta</summary>
$\operatorname{Var}(\hat\beta_1)=\sigma^2\left(\frac1n+\frac{\bar X^2}{S_{XX}}\right)$ e $\operatorname{Cov}=-\bar X\sigma^2/S_{XX}$ — negativa quando $\bar X\gt0$, porque a reta passa por $(\bar X,\bar Y)$.
</details>

**13.** Por que $\hat\sigma^2$ divide por $n-2$?
<details><summary>resposta</summary>
Porque dois parâmetros foram estimados: $E[\sum\hat u_i^2]=(n-2)\sigma^2$. Dividir por $n$ daria estimador viesado para baixo.
</details>

**14.** Fórmula do viés de variável omitida (escalar).
<details><summary>resposta</summary>
$\text{viés}=\beta_3\cdot\dfrac{\sum(X_{i2}-\bar X_2)X_{i3}}{\sum(X_{i2}-\bar X_2)^2}$, ou seja $\beta_3$ vezes o coeficiente da auxiliar de $X_3$ em $X_2$.
</details>

**15.** Quando o viés de omissão é zero?
<details><summary>resposta</summary>
Se $\beta_3=0$ (variável irrelevante) ou se $X_2$ e $X_3$ forem ortogonais na amostra.
</details>

**16.** Prove $t^2=F$ na regressão simples.
<details><summary>resposta</summary>
$t^2=\hat\beta_2^2S_{XX}/\hat\sigma^2$; como $SQE=\hat\beta_2^2S_{XX}$ e o numerador tem 1 gl, isso é $\frac{SQE/1}{SQR/(n-2)}=F$.
</details>

**17.** Maior dispersão de $X$: melhor ou pior?
<details><summary>resposta</summary>
Melhor. $\operatorname{Var}(\hat\beta_2)=\sigma^2/S_{XX}$ cai quando $S_{XX}$ cresce — mais precisão.
</details>

## MQO matricial

**18.** Derive $b$ em três passos.
<details><summary>resposta</summary>
Minimize $e'e=(y-Xb)'(y-Xb)$; a CPO dá $-2X'y+2X'Xb=0$; com posto completo, $b=(X'X)^{-1}X'y$.
</details>

**19.** Por que $X'X$ é definida positiva?
<details><summary>resposta</summary>
$v'X'Xv=\lVert Xv\rVert^2\gt0$ para todo $v\neq0$, desde que $X$ tenha posto completo (h5).
</details>

**20.** Propriedades de $P$ e $M$.
<details><summary>resposta</summary>
Simétricas e idempotentes; $PX=X$, $MX=0$, $PM=0$, $P+M=I$, $\operatorname{tr}P=K$, $\operatorname{tr}M=n-K$.
</details>

**21.** Prove $e'e=y'y-b'X'y$.
<details><summary>resposta</summary>
Abra $(y-Xb)'(y-Xb)=y'y-2b'X'y+b'X'Xb$ e use $X'Xb=X'y$.
</details>

**22.** O que $X'e=0$ implica quando há intercepto?
<details><summary>resposta</summary>
A primeira linha dá $\sum e_i=0$, logo $\overline{\hat y}=\bar y$ e a covariância amostral entre regressores e resíduos é zero.
</details>

**23.** Como o professor pede a inversa de uma matriz 2×2?
<details><summary>resposta</summary>
Pela adjunta: $(X'X)^{-1}=\frac{1}{\det(X'X)}\operatorname{adj}(X'X)$. Troque a diagonal principal, inverta o sinal da secundária, divida pelo determinante.
</details>

**24.** Colinearidade perfeita: o que acontece?
<details><summary>resposta</summary>
Posto de $X$ menor que $K$, $\det(X'X)=0$, inversa não existe, parâmetros não identificados. Viola h5 (A2).
</details>

## Amostra finita

**25.** Demonstre $\operatorname{Var}(b\mid X)=\sigma^2(X'X)^{-1}$.
<details><summary>resposta</summary>
$b-\beta=(X'X)^{-1}X'\varepsilon$; a variância é $(X'X)^{-1}X'E[\varepsilon\varepsilon'\mid X]X(X'X)^{-1}$; com $\sigma^2I$ no meio, sobra $\sigma^2(X'X)^{-1}$.
</details>

**26.** Prove $E[e'e\mid X]=\sigma^2(n-K)$.
<details><summary>resposta</summary>
$e'e=\varepsilon'M\varepsilon$; a esperança de forma quadrática é $\sigma^2\operatorname{tr}(M)$; e $\operatorname{tr}(M)=n-K$.
</details>

**27.** Gauss-Markov: qual condição o competidor precisa satisfazer?
<details><summary>resposta</summary>
Com $b^*=[(X'X)^{-1}X'+C]y$, o não-viés exige $CX=0$; então $\operatorname{Var}(b^*)=\sigma^2(X'X)^{-1}+\sigma^2CC'$, maior ou igual.
</details>

**28.** Var de um coeficiente com FIV.
<details><summary>resposta</summary>
$\operatorname{Var}(b_k)=\dfrac{\sigma^2}{(1-R_k^2)S_{kk}}$, com $FIV_k=1/(1-R_k^2)$ e $R_k^2$ da auxiliar de $x_k$ nos demais.
</details>

**29.** Multicolinearidade alta viola alguma hipótese?
<details><summary>resposta</summary>
Não. O MQO segue MELNV; o problema é variância inflada — $t$ baixos com $F$ alto, sinais instáveis.
</details>

**30.** Excluir variável para curar multicolinearidade: qual o custo?
<details><summary>resposta</summary>
Viés de omissão, que não some com mais dados. Troca-se imprecisão por inconsistência.
</details>

## Testes

**31.** Escreva $H_0$ de retornos constantes de escala em forma $R\beta=q$.
<details><summary>resposta</summary>
$R=[0\ 1\ 1\ 0\dots]$, $q=1$, testando $\beta_2+\beta_3=1$ com $J=1$.
</details>

**32.** As três formas equivalentes do $F$.
<details><summary>resposta</summary>
Wald com $(Rb-q)$; duas somas de quadrados $\frac{(SQR_R-SQR_{IR})/J}{SQR_{IR}/(n-K)}$; e via $R^2$, quando a dependente é a mesma.
</details>

**33.** Por que o $F$ tem distribuição $F$?
<details><summary>resposta</summary>
Numerador $\chi^2_J$ e denominador $\chi^2_{n-K}$, independentes porque $b$ e $e$ são não correlacionados ($X'M=0$) e normais.
</details>

**34.** Wald, LM e LR: o que cada um estima?
<details><summary>resposta</summary>
Wald só o irrestrito; LM só o restrito; LR os dois. Todos $\chi^2_J$, com $W\ge LR\ge LM$.
</details>

**35.** Fórmula do Jarque-Bera e seus graus de liberdade.
<details><summary>resposta</summary>
$JB=n[S^2/6+(C-3)^2/24]\sim\chi^2_2$ — dois gl porque são duas restrições (assimetria e curtose).
</details>

**36.** RESET: passos e direção da decisão.
<details><summary>resposta</summary>
Regride $y$ nos $X$ mais $\hat y^2$ e $\hat y^3$; testa se esses coeficientes são nulos. **Rejeitar** indica má especificação.
</details>

**37.** Omitir variável relevante × incluir irrelevante.
<details><summary>resposta</summary>
Omitir relevante vicia e infla $s^2$; incluir irrelevante não vicia, mas aumenta a variância pelo fator $1/(1-R^2)$.
</details>

**38.** Interpretação correta de um IC de 95%.
<details><summary>resposta</summary>
Em 95 de cada 100 amostras, intervalos construídos assim conteriam o verdadeiro parâmetro. O aleatório é o intervalo.
</details>

**39.** Como reconstruir SQT a partir de um output?
<details><summary>resposta</summary>
$SQT=SQR/(1-R^2)$, com $SQR$ = "Sum squared resid". Daí $SQE=SQT-SQR$ e o quadro de ANOVA fecha.
</details>

**40.** Durbin-Watson: valor que indica ausência de autocorrelação e o que fazer se $d\gt2$.
<details><summary>resposta</summary>
$d\approx2$. Se $d\gt2$, o lado testado é o negativo: compare com $4-d_U$ e $4-d_L$.
</details>

## Assintótica

**41.** Demonstre a consistência do MQO.
<details><summary>resposta</summary>
$b=\beta+(X'X/n)^{-1}(X'\varepsilon/n)$; com $\operatorname{plim}(X'X/n)=Q$ e $\operatorname{plim}(X'\varepsilon/n)=0$, o produto dá zero.
</details>

**42.** Por que $\operatorname{plim}(X'\varepsilon/n)=0$?
<details><summary>resposta</summary>
Média zero por exogeneidade e variância $\sigma^2Q/n\to0$: converge em média quadrática, logo em probabilidade.
</details>

**43.** Enuncie a normalidade assintótica.
<details><summary>resposta</summary>
$\sqrt n(b-\beta)\xrightarrow{d}N(0,\sigma^2Q^{-1})$, via TLC em $X'\varepsilon/\sqrt n$ e Slutsky no outro fator.
</details>

**44.** Consistência implica não-viés?
<details><summary>resposta</summary>
Não, e nem o contrário. São propriedades de naturezas diferentes: limite versus amostra finita.
</details>

**45.** Por que o JB é dispensável com $n=4165$?
<details><summary>resposta</summary>
Porque $b$ é soma ponderada dos erros; pelo TLC é assintoticamente normal, e a inferência usa $z$ independentemente da distribuição do erro.
</details>

**46.** Fórmula do HC0.
<details><summary>resposta</summary>
$(X'X)^{-1}\left(\sum_i e_i^2x_ix_i'\right)(X'X)^{-1}$ — consistente sob heterocedasticidade de forma desconhecida.
</details>

**47.** Método delta para $X^*=-a_3/(2a_4)$: qual o gradiente?
<details><summary>resposta</summary>
$\partial X^*/\partial a_3=-1/(2a_4)$ e $\partial X^*/\partial a_4=a_3/(2a_4^2)$; a variância é $g'Vg$.
</details>

## Forma funcional e dummies

**48.** Elasticidade em cada forma funcional.
<details><summary>resposta</summary>
Linear: $\beta\bar X/\bar Y$. Log-log: $\beta$. Log-lin: $\beta X$. Lin-log: $\beta/Y$. Inversa: $-\beta/(XY)$.
</details>

**49.** Efeito exato de dummy em modelo log.
<details><summary>resposta</summary>
$100(e^{\beta}-1)\%$. A aproximação $100\beta$ só serve para $\beta$ pequeno.
</details>

**50.** Ponto de máximo de um quadrático e como justificar.
<details><summary>resposta</summary>
$X^*=-\beta_2/(2\beta_3)$; é máximo se $\beta_3\lt0$, porque a segunda derivada é $2\beta_3$.
</details>

**51.** Armadilha da dummy: o que exatamente quebra?
<details><summary>resposta</summary>
Com intercepto e todas as dummies, as colunas somam a constante: posto incompleto, $X'X$ singular, parâmetros não identificados.
</details>

**52.** Condição para linearizar a Cobb-Douglas.
<details><summary>resposta</summary>
O erro precisa ser **multiplicativo** ($e^u$). Com erro aditivo o log não separa e o MQO fica viesado.
</details>

**53.** Fórmula do teste de Chow.
<details><summary>resposta</summary>
$F=\dfrac{(SQR_P-(SQR_1+SQR_2))/K}{(SQR_1+SQR_2)/(n_1+n_2-2K)}$ — idêntico ao $F$ do modelo totalmente interagido.
</details>

**54.** DiD: qual coeficiente e qual hipótese?
<details><summary>resposta</summary>
O da interação $D\times T$; a hipótese é tendências paralelas — na ausência do tratamento, a diferença entre grupos teria se mantido.
</details>

**55.** DiD com controles invariantes no tempo?
<details><summary>resposta</summary>
Somem na primeira diferença ($\Delta x=0$) e sobra $\beta_3$ puro: não precisam ser observados, mas seus efeitos não são estimáveis.
</details>

## Endogeneidade e VI

**56.** Derive $\hat\beta_{IV}$ em quatro passos.
<details><summary>resposta</summary>
$\operatorname{plim}(Z'\varepsilon/n)=0$ → substitui $\varepsilon=y-X\beta$ → distribui → isola: $\hat\beta_{IV}=(Z'X)^{-1}Z'y$.
</details>

**57.** As duas propriedades de um instrumento e qual é testável.
<details><summary>resposta</summary>
Relevância $\operatorname{Cov}(Z,X)\neq0$ (testável pelo $F$ do 1º estágio) e exogeneidade $\operatorname{Cov}(Z,\varepsilon)=0$ (só testável com sobreidentificação, via Sargan).
</details>

**58.** Atenuação por erro de medição no regressor.
<details><summary>resposta</summary>
$\operatorname{plim}\hat\beta=\beta\dfrac{\sigma^2_{X^*}}{\sigma^2_{X^*}+\sigma^2_w}$, sempre em direção a zero. Não some com mais dados.
</details>

**59.** Erro de medição na dependente: o que muda?
<details><summary>resposta</summary>
Nada no não-viés; a variância vira $\dfrac{\sigma^2_\mu+\sigma^2_\varepsilon}{S_{XX}}$, maior — perde-se precisão, não acerto.
</details>

**60.** As três hipóteses nulas do quadro de diagnóstico do `ivreg`.
<details><summary>resposta</summary>
Instrumentos fracos (rejeitar é bom); Wu-Hausman: regressor exógeno (rejeitar manda usar MQ2E); Sargan: instrumentos válidos (rejeitar é ruim).
</details>
