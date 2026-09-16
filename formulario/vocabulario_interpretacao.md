---
title: "Vocabulário de interpretação: H0, decisão e conclusão"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
relevancia_p1: alta
status: rascunho
tags:
  - econometria
  - mestrado/ppgeco
  - p1
  - testes
aliases:
  - Vocabulário de interpretação
---

# Vocabulário de interpretação

Metade da P1 é ler um output e decidir. O que vale ponto não é a conta: é **hipótese, estatística, decisão e conclusão**, nesta ordem, com a frase econômica no fim.

> [!IMPORTANT]
> **O molde de quatro linhas**
> Escreva sempre assim, em qualquer teste: **Hipóteses** → **Estatística** (valor e distribuição) → **Decisão** (comparação explícita com o valor crítico ou com o $\alpha$) → **Conclusão** (frase em português, econômica).

```text
Hipóteses:   H0: a3 = 0 (EXP não afeta LWAGE)   vs   H1: a3 ≠ 0
Estatística: t = b/E.p. = 18,677  (~ N(0,1), pois n = 4165)
Decisão:     |18,677| > 1,96 = z crítico (α = 5%)  ⇒  rejeita-se H0   [ou: p = 0,0000 < 0,05]
Conclusão:   EXP é estatisticamente significativa; mais experiência está associada a salário maior.
```

> [!CAUTION]
> **O professor recicla outputs e troca os p-valores**
> O mesmo quadro de `ivreg` aparece em versões diferentes com p-valores diferentes:
>
> | Onde | Instrumentos fracos | Wu-Hausman | Sargan |
> |---|---|---|---|
> | Lista 1, ex. 67 | 228,738 (p = 0,0000) | 3,823 (p = 0,0569) | 0,333 (p = 0,5641) |
> | P2 2024/2 | 228,738 (p = 0,0000) | 3,823 (p = 0,0369) | 0,333 (p = 0,5641) |
> | P1 2025/2 | 228,738 (p = 0,0000) | p = 0,0469 | p = 0,8468 |
>
> Nunca responda de memória: **decida pelo número impresso na sua prova e pelo $\alpha$ que o enunciado deu**. Com Wu-Hausman de p = 0,0569, a 10% rejeita-se H0 e a 5% não — a conclusão inverte.

---

## 1. Significância individual: teste $t$

| | |
|---|---|
| **H0** | $\beta_k = 0$ (o regressor não afeta $y$) |
| **H1** | $\beta_k \neq 0$ |
| **Estatística** | $t = \hat\beta_k/\text{E.p.}(\hat\beta_k) \sim t_{n-K}$; com $n$ grande, $\approx N(0,1)$ |
| **Decisão** | rejeita H0 se $\lvert t\rvert > t_{crit}$ (ou $p \lt \alpha$) |
| **Conclusão** | "o coeficiente é estatisticamente significativo a $\alpha$; a variável se relaciona com $y$" |

**Armadilha.** Significância estatística não é relevância econômica; com $n$ enorme quase tudo é significativo. Teste unilateral usa $t_{\alpha}$, não $t_{\alpha/2}$.

## 2. Significância conjunta: teste $F$ global

| | |
|---|---|
| **H0** | $\beta_2=\beta_3=\dots=\beta_K=0$ (o modelo não explica nada; o intercepto fica de fora) |
| **H1** | ao menos um $\beta_k \neq 0$ |
| **Estatística** | $F=\dfrac{SQE/(K-1)}{SQR/(n-K)}=\dfrac{R^2/(K-1)}{(1-R^2)/(n-K)}\sim F_{K-1,\,n-K}$ |
| **Decisão** | rejeita H0 se $F \gt F_{crit}$ (ou $p \lt \alpha$) |
| **Conclusão** | "a regressão é conjuntamente significativa" |

**Armadilha.** $F$ alto com todos os $t$ baixos é sintoma clássico de **multicolinearidade**. O $F$ global nunca testa o intercepto.

## 3. Restrição linear: teste $F$ restrito

| | |
|---|---|
| **H0** | $R\beta = q$ (ex.: $\beta_2+\beta_3=1$, retornos constantes de escala) |
| **H1** | $R\beta \neq q$ |
| **Estatística** | $F=\dfrac{(SQR_R-SQR_{IR})/J}{SQR_{IR}/(n-K)}\sim F_{J,\,n-K}$, com $J$ restrições |
| **Decisão** | rejeita H0 se $F \gt F_{crit}$ |
| **Conclusão** | "os dados rejeitam (ou não) a restrição; há (ou não) retornos constantes de escala" |

**Armadilha.** $SQR_R \ge SQR_{IR}$ sempre: diferença negativa significa que você trocou os modelos. Com $J=1$, $F=t^2$.

## 4. Intervalo de confiança

$$IC_{1-\alpha}(\beta_k) = \left[\hat\beta_k \pm t_{\alpha/2}\cdot \text{E.p.}(\hat\beta_k)\right].$$

**Conclusão.** "Em 95 de cada 100 amostras, intervalos construídos assim conteriam o verdadeiro $\beta_k$."

**Armadilha.** O aleatório é o intervalo, não o parâmetro: não diga "há 95% de chance de $\beta$ estar aqui". Se o IC contém zero, o teste bilateral não rejeita H0 — é a mesma decisão.

## 5. Normalidade dos resíduos: Jarque-Bera

| | |
|---|---|
| **H0** | os resíduos são normais |
| **H1** | não são normais |
| **Estatística** | $JB=n\left[\dfrac{S^2}{6}+\dfrac{(C-3)^2}{24}\right]\sim \chi^2_2$, com $S$ = assimetria e $C$ = curtose |
| **Decisão** | rejeita H0 se $JB \gt \chi^2_{2,\alpha}$ (5%: 5,99; 1%: 9,21) |
| **Conclusão** | "há (ou não) evidência contra a normalidade dos resíduos" |

**Armadilha.** Com $n$ grande o teste perde importância: pelo TLC, $b$ é assintoticamente normal mesmo com erro não normal, e a inferência usa $z$. Foi isso que a P1 2025/2 cobrou com $n = 4165$. Normalidade importa para a inferência **exata** em amostra pequena.

## 6. Especificação: teste RESET (Ramsey)

| | |
|---|---|
| **H0** | o modelo está corretamente especificado (os termos $\hat y^2,\hat y^3$ não entram) |
| **H1** | há má especificação (forma funcional ou variável omitida) |
| **Estatística** | $F$ da significância conjunta de $\hat y^2,\hat y^3$ na regressão aumentada |
| **Decisão** | rejeita H0 se $F \gt F_{crit}$ |
| **Conclusão** | "há (ou não) indício de má especificação" |

**Armadilha.** É o erro da chave no ex. 50: $F=2,28 \lt 4,10$ e $p=0,20 \gt 0,05$, então **não se rejeita** H0 — não há evidência de má especificação. Ver [errata](errata_chave_lista1.md).

## 7. Heterocedasticidade: White

| | |
|---|---|
| **H0** | homocedasticidade, $E(u_i^2)=\sigma^2$ |
| **H1** | heterocedasticidade |
| **Estatística** | $nR^2$ da auxiliar de $\hat u_i^2$ nos regressores, seus quadrados e produtos cruzados; $\sim \chi^2_{gl}$, $gl$ = número de regressores da auxiliar |
| **Decisão** | rejeita H0 se $nR^2 \gt \chi^2_{crit}$ |
| **Conclusão** | "há (ou não) heterocedasticidade; com ela, os erros-padrão de MQO ficam viesados" |

**Armadilha.** White consome muitos graus de liberdade: em amostra pequena use a versão sem produtos cruzados. O teste **não** diz qual é a forma da heterocedasticidade.

## 8. Heterocedasticidade: Breusch-Pagan-Godfrey

Mesmas hipóteses; a auxiliar regride $\hat u_i^2$ apenas nos regressores. Estatística $nR^2\sim\chi^2_{K-1}$.

**Armadilha.** É sensível à não normalidade; White é mais geral.

## 9. Autocorrelação: Durbin-Watson

| | |
|---|---|
| **H0** | $\rho=0$ (sem autocorrelação de 1ª ordem) |
| **H1** | $\rho \neq 0$ |
| **Estatística** | $d=\dfrac{\sum_{t=2}^n(\hat u_t-\hat u_{t-1})^2}{\sum_t \hat u_t^2}\approx 2(1-\hat\rho)$, com $0\le d\le 4$ |

| Faixa de $d$ | Decisão |
|---|---|
| $0 \lt d \lt d_L$ | rejeita H0: autocorrelação **positiva** |
| $d_L \le d \le d_U$ | **inconclusivo** |
| $d_U \lt d \lt 4-d_U$ | não rejeita H0: sem autocorrelação |
| $4-d_U \le d \le 4-d_L$ | inconclusivo |
| $4-d_L \lt d \lt 4$ | rejeita H0: autocorrelação **negativa** |

**Armadilha.** $d\approx 2$ é o "sem autocorrelação". DW não vale com defasagem da dependente entre os regressores (use o $h$ de Durbin ou o BG) e só enxerga a 1ª ordem. Quando $d \gt 2$, o lado testado é o negativo: compare com $4-d_L$ e $4-d_U$.

## 10. Autocorrelação: Breusch-Godfrey (LM)

| | |
|---|---|
| **H0** | $\rho_1=\dots=\rho_p=0$ (sem autocorrelação até a ordem $p$) |
| **H1** | ao menos um $\rho_j\neq 0$ |
| **Estatística** | $nR^2$ da auxiliar de $\hat u_t$ nos regressores e em $\hat u_{t-1},\dots,\hat u_{t-p}$; $\sim\chi^2_p$ |

**Armadilha.** A escolha de $p$ vai pelo critério de informação (o menor SIC). Aceita defasagem da dependente, ao contrário do DW.

## 11. Quebra estrutural: teste de Chow

| | |
|---|---|
| **H0** | não há quebra: os coeficientes são iguais nos dois períodos |
| **H1** | há quebra |
| **Estatística** | $F=\dfrac{(SQR_P-(SQR_1+SQR_2))/K}{(SQR_1+SQR_2)/(n_1+n_2-2K)}\sim F_{K,\,n_1+n_2-2K}$ |

**Armadilha.** Exige variância igual nos dois subperíodos e $n_i \gt K$. A versão com dummy e interações testa a mesma coisa e ainda diz **onde** quebrou: intercepto, inclinação ou ambos.

## 12. Trindade assintótica: Wald, LM e LR

| Teste | Estatística | Distribuição | O que precisa estimar |
|---|---|---|---|
| Wald | $W=(Rb-q)'[R\,\widehat{\operatorname{Var}}(b)\,R']^{-1}(Rb-q)$ | $\chi^2_J$ | só o modelo irrestrito |
| LM (escore) | $nR^2$ da auxiliar dos resíduos restritos | $\chi^2_J$ | só o modelo restrito |
| LR | $-2\ln\lambda = n\ln(SQR_R/SQR_{IR})$ | $\chi^2_J$ | os dois |

Todos testam $H_0: R\beta=q$. No modelo linear normal vale $W \ge LR \ge LM$, então podem discordar na fronteira; e $W = J\cdot F$.

**Armadilha.** São testes **assintóticos**: compare com $\chi^2$, não com $F$. Atenção ao que o enunciado chama de $\lambda$: a razão de verossimilhanças ou já o $-2\ln\lambda$.

## 13. Endogeneidade: Wu-Hausman

| | |
|---|---|
| **H0** | o regressor é exógeno: MQO e VI são consistentes e MQO é eficiente |
| **H1** | o regressor é endógeno: só VI é consistente |
| **Estatística** | $F$ (ou $\chi^2$) do resíduo do 1º estágio incluído na equação original |
| **Decisão** | rejeita H0 ⇒ use **MQ2E/VI**; não rejeita ⇒ fique com **MQO**, que é eficiente |
| **Conclusão** | "há (ou não) evidência de endogeneidade; o método consistente é …" |

**Armadilha.** Não rejeitar **não prova** exogeneidade, principalmente com instrumento fraco. E o $\alpha$ decide: p = 0,0569 rejeita a 10% e não rejeita a 5%.

## 14. Instrumentos fracos

| | |
|---|---|
| **H0** | os instrumentos são fracos (irrelevantes) |
| **H1** | são fortes (relevantes) |
| **Estatística** | $F$ do 1º estágio sobre os instrumentos excluídos |
| **Decisão** | rejeita H0 (p pequeno, ou $F \gt 10$ pela regra de Staiger-Stock) ⇒ instrumentos fortes |
| **Conclusão** | "os instrumentos são relevantes; não há problema de instrumento fraco" |

**Armadilha.** Com instrumento fraco o VI fica viesado na direção do MQO e a inferência quebra. Relevância é testável; **exogeneidade não é**, a não ser por sobreidentificação.

## 15. Validade dos instrumentos: Sargan

| | |
|---|---|
| **H0** | todos os instrumentos são válidos (exógenos) |
| **H1** | ao menos um é inválido |
| **Estatística** | $nR^2$ da regressão dos resíduos de MQ2E em todos os instrumentos; $\sim\chi^2_{L-K}$ |
| **Decisão** | rejeita H0 ⇒ algum instrumento é inválido |
| **Conclusão** | "não se rejeita a validade dos instrumentos" |

**Armadilha.** Só existe com $L \gt K$ (sobreidentificação). No caso exatamente identificado não há teste — por isso vale usar dois instrumentos e MQ2E.

## 16. Multicolinearidade: FIV e regressão auxiliar

- $FIV_k = \dfrac{1}{1-R_k^2}$, com $R_k^2$ da regressão de $X_k$ nos demais regressores. Regra prática: $FIV \gt 10$, isto é $R_k^2 \gt 0,9$.
- Regressão auxiliar: H0 "$X_k$ não é explicada pelas demais" contra H1 "é"; estatística $F$ da auxiliar.

**Armadilha.** Multicolinearidade não perfeita **não viola** hipótese nenhuma do MRLC, e o MQO continua MELNV: o problema é variância grande. Correlação baixa entre pares não descarta multicolinearidade envolvendo três ou mais variáveis. Excluir variável para "curar" gera viés de omissão: troca-se variância por viés.

## 17. Ajuste: $R^2$, $\bar R^2$ e critérios de informação

- $R^2 = 1 - SQR/SQT$: fração da variação de $y$ explicada. Só faz sentido com intercepto e nunca cai ao acrescentar regressor.
- $\bar R^2 = 1-\dfrac{n-1}{n-K}(1-R^2)$: sobe quando o regressor acrescentado tem $\lvert t\rvert \gt 1$; pode ser negativo.
- AIC e SC (Schwarz): quanto **menor**, melhor; o SC pune mais parâmetros, então escolhe modelos menores.

**Armadilha.** Comparar $R^2$ entre modelos exige a **mesma variável dependente** e o mesmo $n$: modelo em nível e modelo em log não se comparam por $R^2$.

## 18. Interpretação do coeficiente por forma funcional

| Modelo | Papel de $\hat\beta_2$ | Leitura |
|---|---|---|
| $Y=\beta_1+\beta_2X$ | efeito marginal | $X$ sobe 1 unidade ⇒ $Y$ varia $\beta_2$ unidades |
| $\ln Y=\beta_1+\beta_2X$ | semi-elasticidade | $X$ sobe 1 unidade ⇒ $Y$ varia $100\beta_2\%$ |
| $Y=\beta_1+\beta_2\ln X$ | — | $X$ sobe 1% ⇒ $Y$ varia $\beta_2/100$ unidades |
| $\ln Y=\beta_1+\beta_2\ln X$ | elasticidade | $X$ sobe 1% ⇒ $Y$ varia $\beta_2\%$ |
| $Y=\beta_1+\beta_2(1/X)$ | — | efeito marginal $-\beta_2/X^2$; assíntota em $\beta_1$ |
| dummy em modelo log | semi-elasticidade | aproximado $100\beta\%$; **exato** $100(e^{\beta}-1)\%$ |
| quadrático $\beta_2X+\beta_3X^2$ | efeito marginal $\beta_2+2\beta_3X$ | máximo (se $\beta_3\lt 0$) em $X^*=-\beta_2/(2\beta_3)$ |

Elasticidade no ponto médio, no modelo linear: $\hat\eta = \hat\beta_2\,\bar X/\bar Y$.

**Armadilha.** No log-log a elasticidade é constante; no linear ela muda em cada ponto, e o enunciado precisa dizer **onde** calcular — quase sempre na média.

## 19. Quadro de análise de variância

| Variação | Graus de liberdade | Soma de quadrados | Quadrado médio | $F$ |
|---|---|---|---|---|
| Regressão | $K-1$ | $SQE$ | $SQE/(K-1)$ | $\dfrac{SQE/(K-1)}{SQR/(n-K)}$ |
| Resíduos | $n-K$ | $SQR$ | $SQR/(n-K)=s^2$ | |
| Total | $n-1$ | $SQT$ | | |

Do output você tira: $SQR$ = "Sum squared resid"; $SQT = SQR/(1-R^2)$; $SQE = SQT - SQR$; $s$ = "S.E. of regression".
