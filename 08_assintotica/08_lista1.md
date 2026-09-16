---
title: "Módulo 08 — Lista 1 resolvida (ex. 73, com ligações para 3 e 68)"
modulo: "08"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
greene: "cap. 4 (§4.4–4.5); apêndice D"
slides: "SL08"
lista1: [73]
relevancia_p1: media
status: rascunho
verificacao:
  derivacao: pendente
  numerica: ok
  chave: pendente
tags:
  - econometria
  - mestrado/ppgeco
  - p1
aliases:
  - Assintótica — Lista 1
---

# Módulo 08 — Lista 1 resolvida

## Ex. 73 — Monte Carlo do Teorema do Limite Central

**Tipo:** computacional em R · **Chave:** ➖ (sem resposta desenvolvida) · **Cai como:** conceito por trás da Q1a e da Q5

**O que se pede.** Gerar 1000 valores de uma normal padrão, calcular a média amostral, repetir o procedimento 1000 vezes e examinar o histograma e a densidade das médias obtidas, comentando a normalidade.

**Código.** Seção "Ex. 73" de [08_assintotica.R](08_assintotica.R); a essência são duas linhas:

```r
set.seed(20261002)
medias <- replicate(1000, mean(rnorm(1000, mean = 0, sd = 1)))
```

**O que sai.**

| Medida | Simulado | Teórico |
|---|---|---|
| média das médias | $-0{,}000179$ | 0 |
| desvio-padrão das médias | 0,030879 | $\sigma/\sqrt n = 0{,}031623$ |
| assimetria | 0,0504 | 0 |
| curtose | 3,0017 | 3 |
| Jarque-Bera (p-valor) | 0,8078 | não rejeita a normalidade |

**Resposta.** A densidade das médias amostrais é visivelmente normal, centrada em $\mu=0$ e muito mais concentrada que a população: o desvio-padrão caiu de 1 para $1/\sqrt{1000}\approx 0{,}0316$. Assimetria perto de zero, curtose perto de 3 e o Jarque-Bera não rejeitando confirmam. Figura: [figuras/08_ex73_tlc_normal.png](figuras/08_ex73_tlc_normal.png).

> [!IMPORTANT]
> **O ponto que o exercício quer**
> Com população normal, a média amostral é normal **exatamente**, para qualquer $n$ — isso é propriedade da normal, não o TLC. A força do TLC aparece quando a população **não** é normal.

**A versão que mostra o TLC de verdade.** Repetindo com população exponencial (assimetria populacional igual a 2):

| $n$ de cada amostra | assimetria das médias | Jarque-Bera (p) |
|---|---|---|
| 5 | 0,8964 | 0,0000 |
| 30 | 0,4159 | — |
| 200 | 0,1907 | 0,0311 |

A assimetria cai na direção de zero conforme $n$ cresce: é o TLC funcionando. Figura: [figuras/08_ex73_tlc_exponencial.png](figuras/08_ex73_tlc_exponencial.png).

**Conferência numérica**

| chave_R | nota |
|---|---|
| m08_ex73_media_das_medias | -0,000179 |
| m08_ex73_dp_das_medias | 0,030879 |
| m08_ex73_dp_teorico | 0,031623 |
| m08_ex73_assimetria | 0,0504 |
| m08_ex73_curtose | 3,0017 |
| m08_ex73_jb_p | 0,8078 |
| m08_ex73_exp_assim_n5 | 0,8964 |
| m08_ex73_exp_assim_n30 | 0,4159 |
| m08_ex73_exp_assim_n200 | 0,1907 |

> [!TIP]
> **Como isso vira resposta de prova**
> "Pelo TLC, a distribuição da média amostral (e, por extensão, a do vetor de MQO, que também é uma soma ponderada dos erros) converge para a normal quando $n\to\infty$, qualquer que seja a distribuição da população. Por isso, com $n=4165$, a inferência usa $z$ e o teste de normalidade dos resíduos é dispensável."

---

## Exercícios do módulo 08 que moram em outros arquivos

| Ex. | Tema | Onde está |
|---|---|---|
| 3 | consistência da média amostral (Chebyshev) | [módulo 00](../00_fundamentos/00_lista1.md) — a ferramenta é a mesma de D08.1 |
| 68 | erro de medição no regressor: inconsistência e atenuação | [módulo 10](../10_endogeneidade_iv/10_lista1.md) — exemplo canônico de estimador **não** consistente |
| 69 | simultaneidade keynesiana | [módulo 10](../10_endogeneidade_iv/10_lista1.md) |
| 23 c) | "propriedades para pequenas e grandes amostras" | [módulo 03](../03_mqo_matricial/03_lista1.md), com a parte assintótica vindo de D08.1 e D08.2 |
