---
title: "Módulo 03 — Álgebra matricial do MQO"
modulo: "03"
disciplina: Econometria I (PECO-5021/6021)
relevancia_p1: alta
status: rascunho
tags:
  - econometria
  - mestrado/ppgeco
  - p1
aliases:
  - Módulo 03
---

# Módulo 03 — Álgebra matricial do MQO

A mesma dedução do [módulo 02](../02_mqo_simples/README.md), agora em vetores: equações normais, matrizes de projeção e geradora de resíduos, decomposição da variação. É a linguagem em que o professor escreve as questões de demonstração.

| Arquivo | Conteúdo |
|---|---|
| [03_teoria.md](03_teoria.md) | cálculo matricial, equações normais, condição de segunda ordem, $P$ e $M$, decomposição $SQT=SQE+SQR$ |
| [03_lista1.md](03_lista1.md) | ex. 23, 24, 28 a 31, 34 (conta à mão) e 35 (colinearidade perfeita) |
| [03_mqo_matricial.R](03_mqo_matricial.R) | ex. 34 e 35 conferidos, propriedades de $P$ e $M$, Monte Carlo do não-viés |

## O essencial

$$b=(X'X)^{-1}X'y,\qquad P=X(X'X)^{-1}X',\qquad M=I-P$$

$$e=My,\qquad \hat y=Py,\qquad X'e=0,\qquad e'e=y'y-b'X'y,\qquad \operatorname{tr}(M)=n-K$$

## Como estudar

1. Derive $b$ pelas equações normais, com as dimensões anotadas em cada passo.
2. Prove as propriedades de $P$ e $M$ (simetria, idempotência, $MX=0$, traços) — são itens curtos e certos.
3. Faça o ex. 34 inteiro à mão e confira com o script.
4. Use o ex. 35 para fixar a diferença entre colinearidade perfeita e alta.

```bash
powershell -ExecutionPolicy Bypass -File scripts\r.ps1 03_mqo_matricial\03_mqo_matricial.R
```
