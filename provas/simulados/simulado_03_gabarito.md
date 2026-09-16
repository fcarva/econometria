---
title: "Simulado 03 — gabarito com rubrica"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
relevancia_p1: media
status: rascunho
tags:
  - econometria
  - mestrado/ppgeco
  - p1
  - simulado
aliases:
  - Gabarito Simulado 03
---

# Simulado 03 — gabarito

---

## Questão 1 (2,5)

### a) Qual coeficiente mede o efeito (0,5)

O da **interação**, Y81NRINC ($\hat\beta_3=-0{,}13151$). Ele é a diferença das diferenças: a variação de preço dos imóveis próximos entre 1978 e 1981, **menos** a variação dos imóveis distantes no mesmo período. A primeira diferença elimina o que é fixo na localização; a segunda desconta a tendência geral do mercado, estimada pelo grupo de controle.

### b) Teste e interpretação (0,75)

```text
Hipóteses:   H0: β3 = 0 (o incinerador não afetou os preços)   vs   H1: β3 ≠ 0
Estatística: t = −0,13151 / 0,05197 = −2,531
Decisão:     |−2,531| > 1,96   (p = 0,0114 < 0,05)   ⇒   rejeita-se H0
Conclusão:   o anúncio do incinerador reduziu o preço dos imóveis próximos em
             aproximadamente 13,2% (exatamente 100(e^−0,13151 − 1) = −12,32%),
             em relação ao que teria ocorrido sem o incinerador.
```

| Rubrica | Pontos |
|---|---|
| Hipóteses e estatística | 0,25 |
| Decisão com o crítico | 0,2 |
| Interpretação aproximada e exata, com o contrafactual explícito | 0,3 |

### c) Y81 e NEARINC (0,5)

$\hat\beta_{Y81}=0{,}16207$: entre 1978 e 1981, os preços reais subiram cerca de 16,2% (exato 17,6%) para o grupo **de controle**, controlando as características do imóvel — é a **tendência comum**.

$\hat\beta_{NEARINC}=0{,}03223$, com $t=0{,}679$: **não** significativo. Ele mede a diferença de nível **pré-existente** entre as duas regiões, em 1978, antes de qualquer anúncio.

**Por que NEARINC não mede o efeito:** ele compara lugares, não períodos. Qualquer diferença permanente entre as regiões (acesso, infraestrutura, renda do bairro) entra nesse coeficiente. O efeito causal exige a dupla diferença, que limpa essas características fixas.

### d) Hipótese de identificação (0,5)

**Tendências paralelas:** na ausência do incinerador, os preços dos imóveis próximos e distantes teriam evoluído **da mesma forma** entre 1978 e 1981. É uma hipótese sobre um contrafactual, e por isso não testável diretamente.

Com mais anos, verifica-se: (i) **tendências pré-tratamento**, estimando o modelo com dummies de ano interagidas para períodos anteriores ao anúncio — os coeficientes devem ser nulos (*event study*); (ii) **placebo no tempo**, fingindo um anúncio em ano anterior; (iii) robustez a controles que variem no tempo.

### e) AGE e AGESQ (0,25)

O efeito da idade é $\hat\beta_{AGE}+2\hat\beta_{AGESQ}\,AGE=-0{,}00835914+2(0{,}0000376348)AGE$, negativo no começo e crescente. O **mínimo** do preço ocorre em
$$AGE^*=-\frac{-0{,}00835914}{2\times 0{,}0000376348}\approx 111\ \text{anos}.$$
Ou seja: no intervalo relevante da amostra (média de 18 anos), imóveis mais velhos valem menos; a curvatura positiva só reverte o efeito muito além dos dados — aí começaria o prêmio de imóvel histórico.

---

## Questão 2 (2,0)

### a) Os três testes a 5% e a 10% (1,0)

```text
Instrumentos fracos
Hipóteses:   H0: instrumentos fracos   vs   H1: instrumentos fortes
Estatística: F = 244,734 (2 e 44), p = 0,0000
Decisão:     rejeita-se H0 a 5% e a 10%    ⇒ instrumentos relevantes. Conclusão não muda.

Wu-Hausman
Hipóteses:   H0: preço exógeno (MQO consistente e eficiente)   vs   H1: preço endógeno
Estatística: F = 3,068 (1 e 44), p = 0,0868
Decisão a 5%:  0,0868 > 0,05  ⇒ NÃO rejeita ⇒ usa-se MQO
Decisão a 10%: 0,0868 < 0,10  ⇒ rejeita     ⇒ usa-se MQ2E
                                             ⇒ é AQUI que a conclusão muda.

Sargan
Hipóteses:   H0: instrumentos válidos   vs   H1: ao menos um inválido
Estatística: 0,333 ~ χ²(1), p = 0,5641
Decisão:     não se rejeita a 5% nem a 10%  ⇒ instrumentos válidos. Conclusão não muda.
```

| Rubrica | Pontos |
|---|---|
| Três pares de hipóteses corretos | 0,4 |
| Decisões nos dois níveis | 0,4 |
| Identificar o Wu-Hausman como o teste que vira | 0,2 |

### b) Elasticidade-preço (0,5)

$\hat\beta=-1{,}27742$, em modelo log-log: 1% de aumento no preço reduz o consumo em cerca de 1,28%. Como $\lvert-1{,}277\rvert\gt 1$, a demanda é **elástica** — resultado relevante para política tributária, porque implica que o aumento de imposto reduz consumo mais que proporcionalmente.

### c) O que a comparação robusta indica (0,5)

Os coeficientes são idênticos nas duas versões (o estimador é o mesmo); só os **erros-padrão** e os diagnósticos mudam. Como as estatísticas se alteram de forma perceptível (244,7 → 228,7 e $p=0{,}0868$ → $0{,}0569$), há indício de **heterocedasticidade**: a hipótese A4 é duvidosa, e a versão robusta é a mais confiável.

Para a conclusão substantiva: a evidência de endogeneidade é **frágil** nas duas versões — fica sempre entre 5% e 10%. A resposta honesta reporta o p-valor, diz qual $\alpha$ está usando e reconhece que a decisão depende dessa escolha.

---

## Questão 3 (1,5)

### a) Simetria, idempotência e $MX=0$ (0,5)

$P'=\big[X(X'X)^{-1}X'\big]'=X\big[(X'X)^{-1}\big]'X'=P$, porque $(X'X)^{-1}$ é simétrica.
$PP=X(X'X)^{-1}\underbrace{X'X(X'X)^{-1}}_{I}X'=P$.
$M'=(I-P)'=I-P=M$ e $MM=I-2P+PP=I-P=M$.
$MX=X-X(X'X)^{-1}X'X=X-X=0$.

### b) $e=My$ e $X'e=0$ (0,5)

$$e=y-Xb=y-X(X'X)^{-1}X'y=(I-P)y=My .$$
$$X'e=X'y-X'X(X'X)^{-1}X'y=X'y-X'y=0 .$$
Com intercepto, a primeira linha de $X'e=0$ é $\iota'e=\sum_i e_i=0$: os resíduos somam zero e, portanto, $\overline{\hat y}=\bar y$. Também segue que a covariância amostral entre cada regressor e os resíduos é nula.

### c) $e'e=y'y-b'X'y$ (0,5)

$$e'e=(y-Xb)'(y-Xb)=y'y-2b'X'y+b'X'Xb .$$
Pelas equações normais, $X'Xb=X'y$, logo $b'X'Xb=b'X'y$ e
$$e'e=y'y-2b'X'y+b'X'y=y'y-b'X'y .$$

---

## Questão 4 (1,5)

### a) $t^2=F$ (0,75)

$$t_0=\frac{\hat\beta_2}{\text{E.p.}(\hat\beta_2)}=\frac{\hat\beta_2}{\sqrt{QMR/S_{XX}}}\ \Longrightarrow\ t_0^2=\frac{\hat\beta_2^2\,S_{XX}}{QMR}.$$
Na regressão simples, $SQE=\hat\beta_2^2S_{XX}$ e a regressão tem 1 grau de liberdade, então $QM_{reg}=SQE=\hat\beta_2^2S_{XX}$. Como $QMR=SQR/(n-2)$,
$$t_0^2=\frac{QM_{reg}}{QMR}=F_0 .$$

### b) $F$ em função do $R^2$ (0,5)

$$F=\frac{SQE}{SQR/(n-2)}=\frac{SQE/SQT}{[SQR/SQT]/(n-2)}=\frac{R^2}{(1-R^2)/(n-2)} .$$

### c) Mesma decisão (0,25)

As duas estatísticas são função monótona uma da outra ($F=t^2$), e os valores críticos guardam a mesma relação: $F_{1;n-2;\alpha}=t^2_{n-2;\alpha/2}$. Logo, rejeitar por uma é rejeitar pela outra. A diferença é de forma: o $t$ permite teste **unilateral** e dá o sinal do efeito; o $F$, não.

---

## Questão 5 (1,5)

### a) A derivação (1,0)

Escreva o modelo nos dois períodos, com $T_1=0$ e $T_2=1$, e note que $D_i$ não varia no tempo:
$$y_{i2}-y_{i1}=\beta_2+\beta_3D_i+\beta'(x_{i2}-x_{i1})+(\varepsilon_{i2}-\varepsilon_{i1}),$$
isto é, $\Delta y_i=\beta_2+\beta_3D_i+\beta'\Delta x_i+\Delta\varepsilon_i$. **Tudo o que é fixo no tempo — $\beta_0$ e $\beta_1D_i$ — desaparece.**

Tomando a esperança em cada grupo, com $E[\Delta\varepsilon\mid x,D]=0$:
$$E[\Delta y\mid x,D=1]=\beta_2+\beta_3+\beta'E[\Delta x\mid D=1]$$
$$E[\Delta y\mid x,D=0]=\beta_2+\beta'E[\Delta x\mid D=0]$$

Subtraindo, $\beta_2$ cancela:
$$E[\Delta y\mid D=1]-E[\Delta y\mid D=0]=\beta_3+\beta'\big[E(\Delta x\mid D=1)-E(\Delta x\mid D=0)\big].\ \blacksquare$$

| Rubrica | Pontos |
|---|---|
| Tomar a diferença e notar que o que é fixo some | 0,4 |
| Esperança condicional em cada grupo | 0,3 |
| Subtrair e chegar à expressão | 0,3 |

### b) Controles invariantes no tempo (0,5)

Se $x_{it}=x_i$, então $\Delta x_i=0$ e o colchete é nulo:
$$E[\Delta y\mid D=1]-E[\Delta y\mid D=0]=\beta_3 .$$

**Conclusão.** Características fixas no tempo — observadas ou não — não precisam ser controladas: a primeira diferença as elimina, e $\beta_3$ identifica sozinho o efeito do tratamento. O preço é que os efeitos dessas características não podem ser estimados. É a mesma propriedade dos efeitos fixos em painel.

---

## Questão 6 (1,0)

### a) FIV (0,5)

$$FIV_2=\frac{1}{1-R_1^2}=\frac{1}{1-0{,}95}=20 .$$

Interpretação: a variância de $\hat\beta_2$ é **20 vezes** maior do que seria se $X_1$ fosse ortogonal aos demais regressores; o erro-padrão fica $\sqrt{20}\approx 4{,}5$ vezes maior. Muito acima da regra prática de 10 — multicolinearidade severa.

### b) Viola alguma hipótese? (0,5)

**Não**, desde que não seja perfeita. A hipótese A2 exige apenas posto completo; com $R^2_{aux}=0{,}95$ a matriz $X'X$ ainda é inversível, só mal condicionada. O MQO **continua MELNV**: não viesado e de mínima variância na classe dos lineares não viesados.

**Consequências:** variâncias e erros-padrão inflados, $t$ pequenos com $F$ global grande, coeficientes instáveis a pequenas mudanças na amostra e sinais às vezes contraintuitivos. A estimação conjunta continua boa — previsões não sofrem —, o que sofre é a identificação do efeito **individual** de cada regressor.

**Por que excluir $X_2$ piora:** se $X_2$ pertence ao modelo, retirá-la gera **viés de variável omitida**, com $E[\tilde\beta]=\beta+\text{viés}$, e o viés não desaparece com mais dados. Troca-se um problema de precisão (que mais dados resolvem) por um de consistência (que não resolvem). As alternativas preferíveis são obter mais dados, usar informação externa sobre os parâmetros ou aceitar a imprecisão e reportá-la.

---

## Fechamento

| Questão | Tema | Pontos | Sua nota |
|---|---|---|---|
| 1 | Output de DiD, identificação e quadrática | 2,5 | |
| 2 | MQ2E clássico contra robusto, três testes | 2,0 | |
| 3 | Álgebra de $P$ e $M$ | 1,5 | |
| 4 | $t^2=F$ e $F$ via $R^2$ | 1,5 | |
| 5 | Derivação do DiD | 1,5 | |
| 6 | Multicolinearidade e FIV | 1,0 | |
| | **Total** | **10,0** | |
