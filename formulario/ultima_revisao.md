---
title: "Folha de última revisão — véspera e dia da prova"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
prova-1: 2026-10-09
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

$$\widehat\beta_2=\frac{S_{XY}}{S_{XX}},\qquad \widehat\beta_1=\bar Y-\widehat\beta_2\bar X,\qquad \operatorname{Var}(\widehat\beta_2)=\frac{\sigma^2}{S_{XX}}$$

$$\mathbf b=(\mathbf X'\mathbf X)^{-1}\mathbf X'\mathbf y,\qquad \operatorname{Var}(\mathbf b\mid \mathbf X)=\sigma^2(\mathbf X'\mathbf X)^{-1},\qquad s^2=\frac{\mathbf e'\mathbf e}{n-K}$$

$$\widehat\beta_{IV}=(\mathbf Z'\mathbf X)^{-1}\mathbf Z'\mathbf y$$

## 2. As quatro identidades que salvam contas

| Identidade | Serve para |
|---|---|
| $\mathbf b=\beta+(\mathbf X'\mathbf X)^{-1}\mathbf X'\varepsilon$ | não-viés, variância e consistência saem daqui |
| $\widehat\beta_2=\beta_2+\sum w_iu_i$, com $\sum w_i=0$, $\sum w_iX_i=1$, $\sum w_i^2=1/S_{XX}$ | toda a rota escalar |
| $\mathbf e=\mathbf M\varepsilon$, $\operatorname{tr}(\mathbf M)=n-K$ | $E(\mathbf e'\mathbf e)=\sigma^2(n-K)$ |
| $SQT=SQE+SQR$ e $SQT=SQR/(1-R^2)$ | reconstruir ANOVA de qualquer output |

## 3. O molde de resposta (vale metade dos pontos)

- **Hipóteses:** $H_0:\dots$ vs. $H_1:\dots$
- **Estatística:** valor calculado ($t_{cal}$, $F_{cal}$, $nR^2_{aux}$), distribuição e graus de liberdade.
- **Decisão:** "como $t_{cal}=\dots>t_{tab}=\dots$, rejeita-se $H_0$ ao nível de 5%" — ou a comparação do $p$ com o nível.
- **Conclusão:** uma frase em português, com conteúdo econômico.

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

## 6b. O que a Lista 1 v.1 avisa

A prova sai da [lista nova](../provas/lista1_v1/README.md). Quatro lembretes que vêm dela:

1. **F por SQR**, sempre com a sigla definida na primeira linha ("SQR = soma dos quadrados dos resíduos"):

$$F=\frac{(SQR_R-SQR_{UR})/q}{SQR_{UR}/(n-k)}$$

2. **Wu-Hausman a 5%**: decida pelo p impresso e escreva a comparação ("0,0469 < 0,05 ⇒ rejeita"). O p verdadeiro daquela estatística é 0,0569.
3. **Pico do quadrático em log**: $EXP^*=-\widehat\beta_2/(2\widehat\beta_3)$ e efeito marginal $\widehat\beta_2+2\widehat\beta_3EXP$, em pontos percentuais vezes 100.
4. **O quadro do ex. 14**: só a violação da exogeneidade estrita, H2 ($E(\varepsilon\mid X)=0$) tira não-viés e consistência; heterocedasticidade e autocorrelação tiram eficiência e os ep usuais.

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
