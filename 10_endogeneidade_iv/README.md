---
title: "Módulo 10 — Endogeneidade e variáveis instrumentais"
modulo: "10"
disciplina: Econometria I (PECO-5021/6021)
relevancia_p1: alta
status: rascunho
tags:
  - econometria
  - mestrado/ppgeco
  - p1
  - vi
aliases:
  - Módulo 10
---

# Módulo 10 — Endogeneidade e variáveis instrumentais

O módulo que mais cai: na P1 2025/2 rendeu **três** questões (Q2 output de VI, Q4 erro de medição, Q6 derivação de $\hat\beta_{IV}$).

| Arquivo | Conteúdo |
|---|---|
| [10_teoria.md](10_teoria.md) | D10.1 inconsistência do MQO · D10.2 atenuação · D10.3 erro em $Y$ · D10.4 simultaneidade · D10.5 VI · D10.6 consistência e variância assintótica · D10.7 MQ2E · D10.8 VI = MQO quando $Z=X$ · D10.9 custo do instrumento fraco · D10.10 Wu-Hausman · D10.11 Sargan |
| [10_lista1.md](10_lista1.md) | ex. 65 a 70 resolvidos, com o output de cigarros lido a 5% e a 10% |
| [10_endogeneidade_iv.R](10_endogeneidade_iv.R) | reprodução do `ivreg` (robusto e não robusto), MQ2E manual, Sargan à mão, Monte Carlo de atenuação e de simultaneidade |

## O essencial

$$\operatorname{plim}b=\beta+Q^{-1}\gamma \quad\text{(MQO inconsistente)},\qquad \hat\beta_{IV}=(Z'X)^{-1}Z'y,\qquad \hat\beta_{MQ2E}=(\hat X'\hat X)^{-1}\hat X'y$$

Instrumento válido: **relevante** ($\operatorname{Cov}(Z,X)\neq 0$, testável pelo $F$ do primeiro estágio) e **exógeno** ($\operatorname{Cov}(Z,\varepsilon)=0$, só testável com sobreidentificação, via Sargan).

## Os três testes, na ordem da prova

| Teste | H0 | Rejeitar significa |
|---|---|---|
| Instrumentos fracos | instrumentos fracos | instrumentos fortes — **bom** |
| Wu-Hausman | regressor exógeno | há endogeneidade: use MQ2E |
| Sargan | instrumentos válidos | algum instrumento é inválido — **ruim** |

> [!CAUTION]
> **Decida pelo número impresso**
> O mesmo quadro aparece nas provas com p-valores trocados (0,0569 na lista, 0,0369 na P2 2024/2, 0,0469 na P1 2025/2). Com Wu-Hausman de 0,0569, a 10% rejeita e a 5% não.

> [!TIP]
> **Intuição visual antes da álgebra**
> Figura(s) 11 e 12 da [galeria didática](../didatica/intuicao_visual.md): a atenuação por erro de medição e o instrumento como peneira.

## Como estudar

1. D10.5 e D10.7 no papel, sem olhar: são a Q6.
2. D10.2 e D10.3 lado a lado: é o contraste que a Q4 cobra.
3. Rode o script e leia o bloco de diagnóstico do `ivreg`, com e sem erros robustos.
4. Feche com o ex. 67 escrito no molde de quatro linhas.

```bash
powershell -ExecutionPolicy Bypass -File scripts\r.ps1 10_endogeneidade_iv\10_endogeneidade_iv.R
```
