---
title: "Módulo 09 — Dummies, forma funcional e quebra estrutural"
modulo: "09"
disciplina: Econometria I (PECO-5021/6021)
relevancia_p1: alta
status: rascunho
tags:
  - econometria
  - mestrado/ppgeco
  - p1
aliases:
  - Módulo 09
---

# Módulo 09 — Dummies, forma funcional e quebra estrutural

Como o modelo linear acomoda atributos qualitativos, efeitos não lineares e mudanças de regime. É daqui que saem dois itens quase certos da Q1: interpretar uma dummy em modelo log e achar o ponto de máximo de um termo quadrático.

| Arquivo | Conteúdo |
|---|---|
| [09_teoria.md](09_teoria.md) | D09.1 a D09.9: dummies, armadilha, efeito exato em log, elasticidades por forma funcional, ponto de máximo, linearização, Chow e DiD |
| [09_lista1.md](09_lista1.md) | ex. 43, 47, 48, 57 a 61, 71 e 72 |
| [did.md](did.md) | nota dedicada a diferenças em diferenças (alias `DiD`) |
| [09_dummies_forma_funcional.R](09_dummies_forma_funcional.R) | café (cinco formas), poupança com dummies e Chow, armadilha da dummy, linearização com erro multiplicativo e aditivo, simulação de DiD |

## O essencial

$$Y=\alpha_1+\alpha_2D+\beta_1X+\beta_2(DX)+u,\qquad X^*=-\frac{\beta_2}{2\beta_3},\qquad \text{efeito exato de dummy em log}=100(e^{\beta}-1)\%$$

$$F_{Chow}=\frac{(SQR_P-(SQR_1+SQR_2))/K}{(SQR_1+SQR_2)/(n_1+n_2-2K)}\ \equiv\ F \text{ das interações}$$

## Como estudar

1. D09.2 (armadilha) e D09.3 (efeito exato) primeiro: são os itens rápidos da prova.
2. Tabela de elasticidades (D09.4) na ponta da língua — cai em toda prova de interpretação.
3. Chow pelas duas vias (D09.7), conferindo que dão o mesmo $F$.
4. DiD (D09.8 e [did.md](did.md)) por último, com atenção ao papel dos controles invariantes no tempo.

```bash
powershell -ExecutionPolicy Bypass -File scripts\r.ps1 09_dummies_forma_funcional\09_dummies_forma_funcional.R
```
