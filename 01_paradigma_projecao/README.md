---
title: "Módulo 01 — Paradigma, projeção e o modelo de regressão"
modulo: "01"
disciplina: Econometria I (PECO-5021/6021)
relevancia_p1: media
status: rascunho
tags:
  - econometria
  - mestrado/ppgeco
  - p1
aliases:
  - Módulo 01
---

# Módulo 01 — Paradigma, projeção e o modelo de regressão

O que exatamente se está estimando: esperança condicional, projeção linear e reta ajustada são três objetos distintos. Aqui também entram, pela primeira vez, as hipóteses A1 a A6.

| Arquivo | Conteúdo |
|---|---|
| [01_teoria.md](01_teoria.md) | paradigma e etapas, estruturas de dados, D01.1 (projeção linear) e D01.2 (quando coincide com a média condicional), tabela das hipóteses, base de Cornwell-Rupert |
| [01_lista1.md](01_lista1.md) | ex. 10, 11 e 12 |
| [01_paradigma_projecao.R](01_paradigma_projecao.R) | projeção contra média condicional numa simulação não linear; descritivas do PSID que aparecem no output da P1 2025/2 |

## O essencial

$$\beta=\operatorname{Var}(x)^{-1}\operatorname{Cov}(x,y),\qquad \alpha=E[y]-\beta'E[x]$$

A3 ($E[\varepsilon\mid X]=0$) é a hipótese crítica: sem ela, nem não-viés nem consistência. A4 mexe em eficiência e inferência; A6, só na inferência exata.

```bash
powershell -ExecutionPolicy Bypass -File scripts\r.ps1 01_paradigma_projecao\01_paradigma_projecao.R
```
