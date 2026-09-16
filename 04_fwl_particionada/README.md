---
title: "Módulo 04 — Regressão particionada e FWL"
modulo: "04"
disciplina: Econometria I (PECO-5021/6021)
relevancia_p1: media
status: rascunho
tags:
  - econometria
  - mestrado/ppgeco
  - p1
aliases:
  - Módulo 04
---

# Módulo 04 — Regressão particionada e FWL

O que significa, algebricamente, "controlar por outras variáveis". Base do viés de omissão matricial, do FIV, da correlação parcial e dos efeitos fixos.

| Arquivo | Conteúdo |
|---|---|
| [04_teoria.md](04_teoria.md) | D04.1 solução particionada · D04.2 FWL · D04.3 constante e centragem · D04.4 viés de omissão matricial · D04.5 variância, FIV e correlação parcial · D04.6 within = FWL |
| [04_lista1.md](04_lista1.md) | ex. 25 |
| [04_fwl_particionada.R](04_fwl_particionada.R) | FWL na equação de salários, erro-padrão ingênuo × corrigido, FIV pela inversa particionada, within contra LSDV |

## O essencial

$$b_2=\big(X_2'M_1X_2\big)^{-1}X_2'M_1y,\qquad M_1=I-X_1(X_1'X_1)^{-1}X_1'$$

$$E[b_1\mid X]=\beta_1+(X_1'X_1)^{-1}X_1'X_2\,\beta_2\quad\text{(viés de omissão)}$$

```bash
powershell -ExecutionPolicy Bypass -File scripts\r.ps1 04_fwl_particionada\04_fwl_particionada.R
```
