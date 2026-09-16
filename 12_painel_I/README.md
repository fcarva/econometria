---
title: "Módulo 12 — Painel I: pooled, primeiras diferenças e efeitos fixos (esqueleto P2)"
modulo: "12"
disciplina: Econometria I (PECO-5021/6021)
greene: "cap. 11"
slides: "SL12"
relevancia_p1: baixa
status: esqueleto
tags:
  - econometria
  - mestrado/ppgeco
  - p2
aliases:
  - Módulo 12
---

# Módulo 12 — Painel I

> [!NOTE]
> **Esqueleto para depois de 02/10**
> Conteúdo de P2. O único elo com a P1 é o teorema de Frisch-Waugh-Lovell: a transformação *within* é FWL com dummies de unidade ([módulo 04](../04_fwl_particionada/04_teoria.md), D04.6).

## O que o slide SL12 cobre

1. Dados de painel: o que são, vantagens, o que não resolvem.
2. Modelo básico $y_{it}=x_{it}'\beta+c_i+\varepsilon_{it}$.
3. Regressão empilhada (*pooled*) e inferência robusta em cluster.
4. Primeiras diferenças e diferenças em diferenças.
5. Efeitos fixos: *within*, LSDV e equivalência entre os dois.
6. Aplicação a Cornwell e Rupert (a mesma base da P1 2025/2).
7. Matriz de covariância robusta para o LSDV.
8. O estimador *within* como caso de variáveis instrumentais.
9. Regressores invariantes no tempo: por que somem.

## O essencial

$$\tilde y_{it}=y_{it}-\bar y_i,\qquad \hat\beta_{EF}=\Big(\sum_i \tilde X_i'\tilde X_i\Big)^{-1}\sum_i \tilde X_i'\tilde y_i$$

Efeitos fixos controlam toda heterogeneidade **fixa no tempo**, observada ou não — e, em troca, não identificam o efeito de nada que não varie no tempo.

## Exercícios da Lista 2 deste módulo

| Bloco | Exercícios | Assunto |
|---|---|---|
| Conceito | 31, 32, 33 | o que é painel, vantagens, pooled e efeitos fixos |
| Estimação e inferência | 35, 39, 40 | motivação e estimação de EF e EA; primeiras diferenças |
| Testes | 37, 41, 43 | teste F restrito (pooling contra efeitos fixos) |
| Aplicação | 46 | leitura de output de painel com municípios do Espírito Santo |

## Na P2 2024/2

Caiu o teste F restrito para escolher entre MQO empilhado e efeitos fixos, com output do PIB industrial contra financiamentos. Ver [mapa da P2](../provas/p2_2024_2/mapa.md).

## O que fazer depois da P1

- [ ] `12_teoria.md` com D12.x: within, LSDV, equivalência, graus de liberdade corretos, cluster.
- [ ] Resolver os exercícios acima, reproduzindo os outputs com `plm`.
- [ ] Conectar com [did.md](../09_dummies_forma_funcional/did.md): DiD de dois períodos é efeito fixo com dois períodos.
