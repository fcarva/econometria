---
title: "Módulo 13 — Painel II: efeitos aleatórios, Hausman e Mundlak (esqueleto P2)"
modulo: "13"
disciplina: Econometria I (PECO-5021/6021)
greene: "cap. 11"
slides: "SL13"
relevancia_p1: baixa
status: esqueleto
tags:
  - econometria
  - mestrado/ppgeco
  - p2
aliases:
  - Módulo 13
---

# Módulo 13 — Painel II

> [!NOTE]
> **Esqueleto para depois de 02/10**
> Conteúdo de P2. O teste de Hausman aqui é primo do Wu-Hausman da P1 ([módulo 10](../10_endogeneidade_iv/10_teoria.md), D10.10): mesma lógica de comparar um estimador consistente-sempre com outro eficiente-sob-H0.

## O que o slide SL13 cobre

1. O modelo de efeitos aleatórios: $c_i$ como componente do erro, com $E[c_i\mid X_i]=0$.
2. Estimação por MQO, MQG e MQG factível.
3. Teste de Breusch-Pagan para efeitos aleatórios (pooling contra EA).
4. Efeitos fixos contra efeitos aleatórios: teste de Hausman.
5. Efeitos aleatórios correlacionados e a formulação de Mundlak.
6. Painéis dinâmicos.

## O essencial

$$\operatorname{Var}(\eta_{it})=\sigma^2_\mu+\sigma^2_\varepsilon,\qquad \operatorname{Cov}(\eta_{it},\eta_{is})=\sigma^2_\mu\ (t\neq s)$$

$$H=(b_{EF}-b_{EA})'\big[\operatorname{Var}(b_{EF})-\operatorname{Var}(b_{EA})\big]^{-1}(b_{EF}-b_{EA})\sim\chi^2_J$$

Rejeitar Hausman ⇒ $c_i$ é correlacionado com os regressores ⇒ **efeitos fixos**. Não rejeitar ⇒ efeitos aleatórios, que é eficiente e ainda estima coeficientes de variáveis invariantes no tempo.

## Exercícios da Lista 2 deste módulo

| Bloco | Exercícios | Assunto |
|---|---|---|
| Conceito | 34, 38 | problemas do modelo de efeitos aleatórios; por que não comparar por $R^2$ |
| Demonstração | 36 | provar $E(\eta_{it}\eta_{is}\mid X)=\sigma^2_\mu$ e o que isso significa |
| Testes | 42, 44, 45 | Hausman e Breusch-Pagan em outputs |

## Na P2 2024/2

Caíram a demonstração da covariância dos erros compostos no modelo de efeitos aleatórios e a leitura do teste de Hausman. Ver [mapa da P2](../provas/p2_2024_2/mapa.md).

## O que fazer depois da P1

- [ ] `13_teoria.md` com D13.x: estrutura de $\Omega$ no EA, MQGF, Hausman, Mundlak.
- [ ] Resolver 34, 36, 38, 42, 44 e 45 com outputs reproduzidos via `plm`.
