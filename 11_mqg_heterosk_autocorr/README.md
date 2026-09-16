---
title: "Módulo 11 — MQG, heterocedasticidade e autocorrelação (esqueleto P2)"
modulo: "11"
disciplina: Econometria I (PECO-5021/6021)
greene: "caps. 9 e 20"
slides: "SL11"
relevancia_p1: baixa
status: esqueleto
tags:
  - econometria
  - mestrado/ppgeco
  - p2
aliases:
  - Módulo 11
---

# Módulo 11 — MQG, heterocedasticidade e autocorrelação

> [!NOTE]
> **Esqueleto para depois de 02/10**
> Conteúdo de P2. Aqui ficam só o mapa e os exercícios da Lista 2 que pertencem ao módulo, para o trabalho começar sem atrito depois da P1.

## O que o slide SL11 cobre

1. O modelo de regressão generalizado: $\operatorname{Var}(\varepsilon\mid X)=\sigma^2\Omega$, com $\Omega\neq I$.
2. Matriz de covariância robusta (White e Newey-West).
3. Heterocedasticidade: consequências, testes (White, Breusch-Pagan, Park, Goldfeld-Quandt) e correções.
4. Mínimos quadrados generalizados e o estimador factível (MQGF).
5. Mínimos quadrados ponderados e o modelo de Harvey.
6. Autocorrelação em séries temporais: AR(1), consequências, DW, Breusch-Godfrey.
7. Correções: Cochrane-Orcutt, Prais-Winsten, Newey-West.
8. Digressão sobre autorregressão vetorial.

## O essencial (para não esquecer)

$$\hat\beta_{MQG}=(X'\Omega^{-1}X)^{-1}X'\Omega^{-1}y,\qquad \operatorname{Var}(\hat\beta_{MQG})=\sigma^2(X'\Omega^{-1}X)^{-1}$$

Com $\Omega=TT'$ e $P'=T^{-1}$, o MQG é MQO nas variáveis transformadas $Py$ e $PX$ — é o teorema de Aitken: o MQG é MELNV quando $\Omega$ é conhecida.

## Exercícios da Lista 2 deste módulo

| Bloco | Exercícios | Assunto |
|---|---|---|
| Consequências e testes | 1, 2, 3, 9, 18, 19 | heterocedasticidade e autocorrelação: efeitos sobre MQO, IC e testes |
| Correção por MQP e MQG | 4, 7e, 25, 26, 28, 30 | ponderação, derivação de $\hat\beta_{MQG}$ e sua variância |
| Leitura de testes | 5, 6, 8, 10 a 17, 20 a 23 | RESET, White, Park, Breusch-Pagan, BG e DW em outputs |
| Autocorrelação teórica | 29 | provar $\operatorname{Corr}(\varepsilon_t,\varepsilon_{t-1})=\rho$ no AR(1) |
| Matricial | 24, 27 | $E(\mu\mu'\mid X)=\sigma^2I$ e violação das hipóteses |

## Na P2 2024/2

Caíram: derivação da variância do MQO sob heterocedasticidade, derivação do estimador de MQG por decomposição espectral, prova da homocedasticidade do modelo transformado e a autocorrelação do AR(1). Ver [mapa da P2](../provas/p2_2024_2/mapa.md).

## O que fazer depois da P1

- [ ] Escrever `11_teoria.md` com as demonstrações D11.x (MQG, MQP, AR(1), robustas).
- [ ] Resolver os exercícios acima em `11_lista1.md` (nome mantido por convenção) referenciando a Lista 2.
- [ ] Script `11_mqg_heterosk_autocorr.R` reproduzindo White, BP, BG, DW, Cochrane-Orcutt e Newey-West.
