---
title: "Módulo 08 — Assintótica"
modulo: "08"
disciplina: Econometria I (PECO-5021/6021)
relevancia_p1: alta
status: rascunho
tags:
  - econometria
  - mestrado/ppgeco
  - p1
aliases:
  - Módulo 08
---

# Módulo 08 — Assintótica

O que acontece com o MQO quando $n\to\infty$: consistência, normalidade assintótica, erros-padrão robustos, método delta e bootstrap. É a base da **Q5** da prova e da resposta sobre Jarque-Bera na **Q1a**.

| Arquivo | Conteúdo |
|---|---|
| [08_teoria.md](08_teoria.md) | D08.1 consistência · D08.2 normalidade assintótica · D08.3 consistência de $s^2$ · D08.4 método delta · D08.5 HC0 · D08.6 bootstrap |
| [08_lista1.md](08_lista1.md) | ex. 73 (Monte Carlo do TLC) e o mapa dos exercícios assintóticos que estão em outros módulos |
| [08_assintotica.R](08_assintotica.R) | Monte Carlo do TLC, consistência de $b$ e de $s^2$, HC0 à mão contra `sandwich`, método delta e bootstrap do ponto de máximo |
| [figuras/](figuras/) | TLC com normal e com exponencial; bootstrap contra método delta |

## O essencial

$$b=\beta+\left(\frac{X'X}{n}\right)^{-1}\left(\frac{X'\varepsilon}{n}\right)\ \Longrightarrow\ \operatorname{plim}b=\beta,\qquad \sqrt n\,(b-\beta)\xrightarrow{d}N(0,\sigma^2Q^{-1})$$

Ponto de máximo da P1 2025/2, com erro-padrão pelo método delta: $X^*=30{,}31$ anos, E.p. $=0{,}71$.

## Como estudar

1. Leia o mapa e as ferramentas (§0 e §1 da teoria) — plim, Slutsky, Chebyshev, LGN, TLC.
2. Derive D08.1 no papel, sem olhar. É a Q5.
3. Rode o script e olhe as duas figuras do TLC: a com exponencial é a que explica o teorema.
4. Feche com a lista e o item "como cai na prova".

Rodar o script:

```bash
powershell -ExecutionPolicy Bypass -File scripts\r.ps1 08_assintotica\08_assintotica.R
```
