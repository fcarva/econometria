---
title: "Módulo 14 — Máxima verossimilhança e escolha binária (esqueleto P2)"
modulo: "14"
disciplina: Econometria I (PECO-5021/6021)
greene: "caps. 14 e 17"
slides: "SL14"
relevancia_p1: baixa
status: esqueleto
tags:
  - econometria
  - mestrado/ppgeco
  - p2
aliases:
  - Módulo 14
---

# Módulo 14 — Máxima verossimilhança e escolha binária

> [!NOTE]
> **Esqueleto para depois de 02/10**
> Conteúdo de P2. A trindade Wald, LM e LR já aparece na P1 ([módulo 07](../07_testes_hipoteses/07_teoria.md), D07.5); aqui ela ganha a forma geral da máxima verossimilhança.

## O que o slide SL14 cobre

1. Máxima verossimilhança: função de verossimilhança, escore, informação de Fisher, propriedades assintóticas.
2. Modelos para variável dependente binária: probabilidade linear, logit, probit.
3. Efeitos marginais (na média e médias dos efeitos marginais).
4. Qualidade do ajuste e previsão: pseudo-$R^2$, tabela de classificação.
5. Matriz de covariância robusta e cluster.
6. A trindade de testes sob máxima verossimilhança.

## O essencial

$$\ln L=\sum_i \Big\{y_i\ln F(x_i'\beta)+(1-y_i)\ln\big[1-F(x_i'\beta)\big]\Big\}$$

- **Logit:** $F(z)=\dfrac{1}{1+e^{-z}}$, efeito marginal $\beta_k\,F(z)[1-F(z)]$.
- **Probit:** $F(z)=\Phi(z)$, efeito marginal $\beta_k\,\phi(z)$.
- **Modelo de probabilidade linear:** simples, mas com erro heterocedástico por construção e previsões fora de $[0,1]$.

## Exercícios da Lista 2 deste módulo

| Bloco | Exercícios | Assunto |
|---|---|---|
| Máxima verossimilhança | 47, 48, 49 | derivar estimadores de MV da normal e do modelo linear; a trindade de testes |
| Escolha binária | 51, 52 | problemas do modelo de probabilidade linear; logit e probit |
| Efeitos marginais | 53, 54, 55 | derivar e calcular efeitos marginais em logit e probit |
| Variância do erro | 56 | mostrar que o MPL é heterocedástico por construção |
| Livro | 57 | exercício 3 do capítulo 17 do Greene |

## Na P2 2024/2

Caiu a leitura do teste de razão de verossimilhança com $-2\ln\lambda$. Ver [mapa da P2](../provas/p2_2024_2/mapa.md).

## O que fazer depois da P1

- [ ] `14_teoria.md` com D14.x: escore, informação, normalidade assintótica do estimador de MV, efeitos marginais, trindade.
- [ ] Resolver os exercícios com `glm` e comparar efeitos marginais na média contra média dos efeitos marginais.
