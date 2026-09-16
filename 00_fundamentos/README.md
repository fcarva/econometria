---
title: "Módulo 00 — Fundamentos"
modulo: "00"
disciplina: Econometria I (PECO-5021/6021)
relevancia_p1: media
status: rascunho
tags:
  - econometria
  - mestrado/ppgeco
  - p1
aliases:
  - Módulo 00
---

# Módulo 00 — Fundamentos

Esperança, variância, covariância, esperança condicional e propriedades de estimadores: a caixa de ferramentas que todas as demonstrações do curso recombinam.

| Arquivo | Conteúdo |
|---|---|
| [00_teoria.md](00_teoria.md) | kit de operadores, esperança condicional, propriedades de estimadores, D00.1 (EQM) e D00.2 (Chebyshev e consistência) |
| [00_lista1.md](00_lista1.md) | ex. 1 a 9 |
| [00_fundamentos.R](00_fundamentos.R) | simulações de média e variância amostrais, Chebyshev contra TLC, contraexemplo de covariância nula com dependência |

## O essencial

$$E[\bar X]=\mu,\qquad \operatorname{Var}(\bar X)=\frac{\sigma^2}{n},\qquad EQM(\hat\theta)=\operatorname{Var}(\hat\theta)+\big[\text{viés}(\hat\theta)\big]^2$$

$$\Pr\big(\lvert Z-E[Z]\rvert\ge\delta\big)\le\frac{\operatorname{Var}(Z)}{\delta^2}\quad\text{(Chebyshev)}$$

```bash
powershell -ExecutionPolicy Bypass -File scripts\r.ps1 00_fundamentos\00_fundamentos.R
```
