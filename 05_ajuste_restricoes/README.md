---
title: "Módulo 05 — Ajuste e mínimos quadrados restritos"
modulo: "05"
disciplina: Econometria I (PECO-5021/6021)
relevancia_p1: alta
status: rascunho
tags:
  - econometria
  - mestrado/ppgeco
  - p1
aliases:
  - Módulo 05
---

# Módulo 05 — Ajuste e mínimos quadrados restritos

Medidas de ajuste ($R^2$, $\bar R^2$, AIC, SC), o que acontece ao incluir ou excluir variáveis e como impor e testar restrições lineares. Daqui saem o quadro de ANOVA e o teste de retornos constantes de escala.

| Arquivo | Conteúdo |
|---|---|
| [05_teoria.md](05_teoria.md) | $b$ minimiza $e'e$, $R^2$ e suas armadilhas, $\bar R^2$ e a regra do $\lvert t\rvert \gt 1$, critérios de informação, MQ restrito e as três formas do $F$ |
| [05_lista1.md](05_lista1.md) | ex. 27, 55, 56 e 62 |
| [05_ajuste_restricoes.R](05_ajuste_restricoes.R) | identidade do MQ restrito, equivalência das três formas do $F$, ANOVA reconstruída, critérios de informação em várias convenções |

## O essencial

$$b_*=b-(X'X)^{-1}R'\big[R(X'X)^{-1}R'\big]^{-1}(Rb-q)$$

$$F=\frac{(SQR_R-SQR_{IR})/J}{SQR_{IR}/(n-K)}=\frac{(R^2_{IR}-R^2_R)/J}{(1-R^2_{IR})/(n-K)},\qquad \bar R^2=1-\frac{n-1}{n-K}(1-R^2)$$

> [!TIP]
> **Intuição visual antes da álgebra**
> Figura(s) 3 da [galeria didática](../didatica/intuicao_visual.md): a decomposição SQT = SQE + SQR em um ponto.

## Como estudar

1. Derive o $F$ nas três formas e saiba dizer quando cada uma se aplica.
2. Treine reconstruir um quadro de ANOVA a partir de $R^2$, $SQR$ e $n$ (ex. 56): é item recorrente.
3. Faça o teste de retornos constantes com duas somas de quadrados (ex. 55) e confira por $t^2=F$.

```bash
powershell -ExecutionPolicy Bypass -File scripts\r.ps1 05_ajuste_restricoes\05_ajuste_restricoes.R
```
