---
title: "Folha de última revisão — 01 e 02 de outubro"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
prova-1: 2026-10-02
relevancia_p1: alta
status: rascunho
tags:
  - econometria
  - mestrado/ppgeco
  - p1
aliases:
  - Última revisão
---

# Folha de última revisão

Uma página. É o que você lê na véspera e nos 15 minutos antes da prova — nada mais. O resto do repositório serve para chegar até aqui.

## 1. As sete fórmulas que abrem qualquer questão

$$\hat\beta_2=\frac{S_{XY}}{S_{XX}},\qquad \hat\beta_1=\bar Y-\hat\beta_2\bar X,\qquad \operatorname{Var}(\hat\beta_2)=\frac{\sigma^2}{S_{XX}}$$

$$b=(X'X)^{-1}X'y,\qquad \operatorname{Var}(b\mid X)=\sigma^2(X'X)^{-1},\qquad s^2=\frac{e'e}{n-K}$$

$$\hat\beta_{IV}=(Z'X)^{-1}Z'y$$

## 2. As quatro identidades que salvam contas

| Identidade | Serve para |
|---|---|
| $b=\beta+(X'X)^{-1}X'\varepsilon$ | não-viés, variância e consistência saem daqui |
| $\hat\beta_2=\beta_2+\sum k_iu_i$, com $\sum k_i=0$, $\sum k_iX_i=1$, $\sum k_i^2=1/S_{XX}$ | toda a rota escalar |
| $e=M\varepsilon$, $\operatorname{tr}(M)=n-K$ | $E[e'e]=\sigma^2(n-K)$ |
| $SQT=SQE+SQR$ e $SQT=SQR/(1-R^2)$ | reconstruir ANOVA de qualquer output |

## 3. O molde de resposta (vale metade dos pontos)

```text
Hipóteses:   H0: ...   vs   H1: ...
Estatística: valor, distribuição e graus de liberdade
Decisão:     comparação explícita com o crítico OU com o α  ⇒  rejeita / não rejeita
Conclusão:   uma frase em português, econômica
```

## 4. As seis decisões que mais caem

| Teste | H0 | Rejeitar significa |
|---|---|---|
| $t$ | $\beta_k=0$ | a variável é significativa |
| $F$ global | todas as inclinações nulas | a regressão explica algo |
| $F$ restrito | a restrição vale (ex.: retornos constantes) | os dados contrariam a teoria |
| RESET | modelo bem especificado | **há** má especificação |
| Wu-Hausman | regressor exógeno | use MQ2E |
| Sargan | instrumentos válidos | algum instrumento é **inválido** |

Instrumentos fracos é o único em que **rejeitar é a boa notícia**: H0 é "instrumentos fracos".

## 5. Interpretação em cinco linhas

- **log-log:** elasticidade, $\beta\%$ por 1%.
- **log-lin:** semi-elasticidade, $100\beta\%$ por unidade.
- **dummy em log:** aproximado $100\beta\%$, exato $100(e^\beta-1)\%$.
- **quadrático:** máximo em $X^*=-\beta_2/(2\beta_3)$, se $\beta_3\lt0$.
- **linear, elasticidade na média:** $\beta\,\bar X/\bar Y$.

## 6. Valores críticos

$z$: 1,645 (10%) · 1,96 (5%) · 2,576 (1%)  
$\chi^2_1$: 2,71 · 3,84 · 6,63  
$\chi^2_2$: 4,61 · 5,99 · 9,21

> [!TIP]
> **O enunciado quase sempre dá o crítico**
> Use o número que está no papel, mesmo que difira do que você lembra, e diga qual usou.

## 7. Estratégia no dia

1. **Leia a prova inteira** (3 min) e marque as questões de output — na P1 2025/2 elas valeram 6,5 dos 10 pontos.
2. **Resolva as de output primeiro**, no molde de quatro linhas.
3. Nas demonstrações, **escreva as hipóteses antes da álgebra**: passo justificado vale ponto mesmo com erro de conta.
4. Confira **dimensões** em todo produto de matrizes e **graus de liberdade** em todo teste.
5. Se travar numa derivação, escreva o ponto de partida e o que pretendia fazer. Meia demonstração organizada vale mais que meia página em branco.
6. Sobrou tempo: releia as **conclusões**. Toda decisão precisa terminar em frase econômica.

> [!CAUTION]
> **Os três erros que mais custam**
> 1. Inverter a decisão do RESET ou do Sargan.
> 2. Decidir por p-valor de memória: o professor troca os números entre versões da prova.
> 3. Esquecer a covariância ao testar soma de coeficientes ($\beta_2+\beta_3=1$) — sem ela, a conclusão inverte.

## 8. Antes de sair de casa

- [ ] Calculadora
- [ ] Documento
- [ ] Ler esta folha uma vez, sem pressa
- [ ] Não abrir material novo: nas últimas horas, revisar só o que já sabe
