---
title: "Lista 1 v.1 — mapa dos 79 exercícios"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
relevancia_p1: alta
status: verificado
verificacao:
  chave: ok
tags:
  - econometria
  - mestrado/ppgeco
  - lista
  - p1
aliases:
  - Lista 1 v.1
---

# Lista 1 v.1: mapa dos 79 exercícios

A versão v.1 da Lista 1 (`materiais/listas/lista1_v1.pdf`, chave em `lista1_v1_chave.pdf`) **substitui** a lista de 74 exercícios como referência da P1. Cada linha dá uma paráfrase, o tipo, o número equivalente na lista antiga, onde está resolvido e o status da chave v.1. A leitura do que isso diz sobre a prova está no [README](README.md).

**Tipo:** D derivação · C cálculo à mão · I interpretação de output · T conceitual · R computacional.

**Chave v.1:** ✅ confere · ⚠️ resultado certo com passo ou número a corrigir · ❌ erro · ➖ sem números ("solução ilustrativa"). Detalhes na [errata](../../formulario/errata_chave_lista1.md).

**Prova:** ★★★ caiu na P1 2025/2 ou é análogo direto · ★★ núcleo (derivação ou conta típica) · ★ periférico.

> [!NOTE]
> **Onde procurar**
> "novos" é a nota [novos.md](novos.md) desta pasta. Os ids D apontam para o [índice de demonstrações](../../demonstracoes/INDICE_D.md). "Antiga" é o número na Lista 1 de 74 exercícios, cujo mapa continua em [LISTA1_MAPA.md](../../LISTA1_MAPA.md).

## Seção 1 — revisão de graduação

| Ex. | Tema (paráfrase) | Tipo | Antiga | Onde está | Chave | Prova |
|---|---|---|---|---|---|---|
| 1 | FRP × FRA e o papel do erro | T | 11 | [01 lista](../../01_paradigma_projecao/01_lista1.md), D1 | ✅ | ★ |
| 2 | Equações normais e fórmulas da regressão simples | D | 13 | D02.1, D3–D6 | ✅ | ★★★ |
| 3 | Gauss-Markov escalar e por que precisa de homocedasticidade | T | 12 | D11, D02.16 | ✅ | ★★ |
| 4 | IC e teste t da inclinação, $n=20$ | C | 42 | novos | ✅ | ★★ |
| 5 | Parciais do preço de imóveis; $R^2$ nunca cai, $\bar R^2$ pode cair | I/D | — | D05.4, D05.7, novos | ✅ | ★★ |
| 6 | F conjunto com 3 restrições; F rejeita e t não | I/T | — | novos | ⚠️ | ★★ |
| 7 | Dummies regionais, armadilha, Sudeste contra Sul | I/T | 61 | D09.1, D09.2, novos | ✅ | ★★ |
| 8 | Multicolinearidade: variância, VIF com $r=0{,}95$, remédios | C/T | 64 | D06.9, D06.11, novos | ✅ | ★★ |
| 9 | Heterocedasticidade e Breusch-Pagan | T/C | 39 | [07 teoria](../../07_testes_hipoteses/07_teoria.md), novos | ✅ | ★★ |
| 10 | Autocorrelação AR(1) e Durbin-Watson | T/C | 39 | novos | ✅ | ★★ |
| 11 | Omitir relevante × incluir irrelevante | T | 53 | D07.7, D06.10 | ✅ | ★★ |
| 12 | Mudança de escala de $Y$ e de $X$ | D | — | D02.17 | ✅ | ★ |
| 13 | Regressão espúria | T | — | novos | ✅ | ★ |
| 14 | Quadro: viés e consistência sob cada violação | T | — | novos | ✅ | ★★★ |

## Seção 2 — MRLC com álgebra linear

| Ex. | Tema (paráfrase) | Tipo | Antiga | Onde está | Chave | Prova |
|---|---|---|---|---|---|---|
| 15 | Hipóteses do MRLC em notação matricial | T | 23 | D12, [convenções H1–H5](../../CONVENCOES.md) | ⚠️ | ★★ |
| 16 | $\mathbf M$ simétrica e idempotente, $\mathbf e=\mathbf M\mathbf y$, $\mathbf M\mathbf X=0$ | D | 28 | D03.4, D06.6 | ✅ | ★★ |
| 17 | $\mathbf P$ simétrica e idempotente, $\widehat{\mathbf y}=\mathbf P\mathbf y$, $\mathbf M\mathbf P=0$ | D | 29 | D03.4 | ✅ | ★★ |
| 18 | $\mathbf X'\mathbf e=0$ e resíduos somando zero | D | 31 | D03.2, D02.2 | ✅ | ★★ |
| 19 | $\mathbf X$ com colinearidade perfeita | C | 35 | D06.11, novos | ✅ | ★★ |
| 20 | FWL pelas equações normais particionadas | D | 25 | D04.1, D04.2 | ✅ | ★★ |
| 21 | $(\mathbf A\mathbf B)'=\mathbf B'\mathbf A'$; $\mathbf X'\mathbf X$ simétrica e semidefinida positiva | D | — | D03.3, novos | ✅ | ★ |
| 22 | $\operatorname{tr}(P)=K$ e $\operatorname{tr}(M)=n-K$ | D | — | D06.7 | ✅ | ★★ |
| 23 | Cauchy-Schwarz, $\lvert r\rvert\le 1$, $R^2=r^2$ | D | 41 | D02.18, D02.10 | ✅ | ★ |
| 24 | Diagonal de $(\mathbf X'\mathbf X)^{-1}$ e o VIF | D | — | D06.9, D04.5 | ✅ | ★★ |

## Seção 3 — estimação por MQO

| Ex. | Tema (paráfrase) | Tipo | Antiga | Onde está | Chave | Prova |
|---|---|---|---|---|---|---|
| 25 | Equações normais matriciais e condição de 2ª ordem | D | — | D03.2, D03.3 | ✅ | ★★ |
| 26 | MQO à mão com $X$ ortogonal (4 obs.) | C | — | novos | ✅ | ★★ |
| 27 | MQO à mão (5 obs.) | C | 34 | [03 lista](../../03_mqo_matricial/03_lista1.md), novos | ✅ | ★★ |
| 28 | Equações normais escalares, intercepto, forma em desvios | D | 13, 22 | D02.1, D02.3 | ✅ | ★★★ |
| 29 | Média dos ajustados, $\mathbf e'\mathbf e=\mathbf y'\mathbf y-\mathbf b'\mathbf X'\mathbf y$, $SQT=SQE+SQR$ | D | 21, 30 | D02.2, D05.2 | ✅ | ★★ |
| 30 | Cabos telefônicos: estimação, sinais, $R^2$ e $\bar R^2$ | R | 38 | [07 computacional](../../07_testes_hipoteses/07_lista1_computacional.md) | ➖ | ★ |
| 31 | FWL com números (5 obs.) | C | — | novos | ✅ | ★★ |
| 32 | Regressão pela origem | D | — | D02.19 | ✅ | ★★ |

## Seção 4 — propriedades em amostra finita

| Ex. | Tema (paráfrase) | Tipo | Antiga | Onde está | Chave | Prova |
|---|---|---|---|---|---|---|
| 33 | $\mathbf b$ não viesado, matricial e escalar | D | 14, 24 | D06.2, D02.5, D9 | ✅ | ★★★ |
| 34 | Viés de variável omitida | D | 15, 25 | D02.9, D04.4 | ✅ | ★★★ |
| 35 | $\operatorname{Var}(\mathbf b\mid \mathbf X)=\sigma^2(\mathbf X'\mathbf X)^{-1}$ | D | 26 | D06.3, D14 | ✅ | ★★★ |
| 36 | Variância e covariância na simples; papel da dispersão de $\mathbf X$ | D | 16, 20 | D02.6, D02.7, D02.13 | ✅ | ★★ |
| 37 | $E(\varepsilon\varepsilon'\mid X)=\sigma^2I$ elemento a elemento | D | 32 | D06.4 | ✅ | ★★ |
| 38 | Gauss-Markov matricial com $\mathbf b^*$ | D | 33 | D06.5, D16 | ✅ | ★★★ |
| 39 | $E(s^2)=\sigma^2$ pelo traço | D | — | D06.7 | ✅ | ★★★ |
| 40 | MQ restrito: não-viés e ganho de variância | D | — | D05.11, novos | ⚠️ | ★★ |

## Seção 5 — testes e seleção de modelos

| Ex. | Tema (paráfrase) | Tipo | Antiga | Onde está | Chave | Prova |
|---|---|---|---|---|---|---|
| 41 | $t^2=F$ na simples | D | 18 | D02.11, D07.3 | ⚠️ | ★★ |
| 42 | F escrito com o $R^2$ (simples e múltipla) | D | 19, 27 | D02.12, D05.12 | ⚠️ | ★★ |
| 43 | F da hipótese linear geral por SQR restrita e irrestrita | D | — | D07.2, D05.10 | ✅ | ★★ |
| 44 | Output com $n=27$: sinal, IC, t, $R^2$ | I | 41, 42 | [07 lista](../../07_testes_hipoteses/07_lista1.md), novos | ✅ | ★★★ |
| 45 | Salários log-nível: t de FEMALE, F de EXP e EXP² | I/C | — | novos | ✅ | ★★★ |
| 46 | Jarque-Bera | I | 44, 46 | D07.6, novos | ⚠️ | ★★ |
| 47 | Cabos: F e t a 10%, modelo só com significativos | R | 38 | [07 computacional](../../07_testes_hipoteses/07_lista1_computacional.md) | ➖ | ★ |
| 48 | AIC e BIC | T | — | D05.8 | ✅ | ★ |
| 49 | Wald: $\chi^2(q)$ e $W/q=F$ | D | — | D07.5, novos | ✅ | ★★ |
| 50 | F de duas restrições por SQR | C | — | novos | ✅ | ★★★ |

A lista pula a seção 6: não há bloco de multicolinearidade e diagnósticos computacionais (o antigo ex. 39). A própria chave menciona, no ex. 30, um "bloco não coberto nesta lista".

## Seção 7 — propriedades assintóticas

| Ex. | Tema (paráfrase) | Tipo | Antiga | Onde está | Chave | Prova |
|---|---|---|---|---|---|---|
| 51 | Consistência da média amostral por Chebyshev | D | 3 | D00.2 | ✅ | ★★ |
| 52 | $\operatorname{plim}\mathbf b=\beta$ por Slutsky | D | 23 | D08.1 | ✅ | ★★★ |
| 53 | Normalidade assintótica e inferência sem normalidade | T | — | D08.2 | ✅ | ★★ |
| 54 | $\operatorname{plim}s^2=\sigma^2$ | D | — | D08.3 | ✅ | ★★ |
| 55 | Monte Carlo das médias amostrais | R | 73 | [08 lista](../../08_assintotica/08_lista1.md) | ✅ | ★ |
| 56 | Exogeneidade estrita × contemporânea; AR(1) | T/D | — | D08.7 | ✅ | ★★ |

## Seção 8 — forma funcional e mudança estrutural

| Ex. | Tema (paráfrase) | Tipo | Antiga | Onde está | Chave | Prova |
|---|---|---|---|---|---|---|
| 57 | Elasticidade constante no log-log | D | 47 | D09.4 | ✅ | ★★ |
| 58 | Elasticidade no lin-log | D | — | D09.4 | ✅ | ★★ |
| 59 | Café: cinco formas funcionais | R | 43 | [09 lista](../../09_dummies_forma_funcional/09_lista1.md), novos | ⚠️ | ★ |
| 60 | Linearizar Cobb-Douglas e exponencial | D | 47, 48 | D09.6 | ✅ | ★★ |
| 61 | Custo: tendência log-lin e elasticidade custo-produção | I | 45 | novos | ⚠️ | ★★ |
| 62 | Salários: EDUC, FEMALE, efeito marginal e pico de EXP | I/C | — | novos, D09.3, D09.5 | ✅ | ★★★ |
| 63 | Má especificação e RESET | T/I | 49, 50 | [07 lista](../../07_testes_hipoteses/07_lista1.md), novos | ✅ | ★★★ |
| 64 | Mudança estrutural com dummy e interação (Chow) | I/C | 60 | D09.7, novos | ✅ | ★★★ |
| 65 | Armadilha da dummy com $n=5$ | D | 61 | D09.2 | ✅ | ★★ |
| 66 | Poupança: dummies de intercepto e de inclinação | R | 57 | [09 lista](../../09_dummies_forma_funcional/09_lista1.md) | ➖ | ★ |
| 67 | DiD como mudança estrutural | D | 71 | D09.8 | ⚠️ | ★★★ |
| 68 | DiD com controles invariantes no tempo | D | 72 | D09.8 | ✅ | ★★ |
| 69 | Coeficientes padronizados | D | — | D02.20 | ✅ | ★ |
| 70 | Spline linear | D/T | — | D09.10 | ✅ | ★ |

## Seção 9 — endogeneidade e VI

| Ex. | Tema (paráfrase) | Tipo | Antiga | Onde está | Chave | Prova |
|---|---|---|---|---|---|---|
| 71 | plim do MQO sob endogeneidade; simultaneidade keynesiana | D | 69 | D10.1, D10.4 | ✅ | ★★★ |
| 72 | Relevância, exogeneidade, instrumento fraco e inválido | T | 66 | D10.9, [10 teoria](../../10_endogeneidade_iv/10_teoria.md) | ✅ | ★★ |
| 73 | VI à mão e derivação de $\widehat\beta_{IV}$ com $L=K$ | C/D | 65 | D10.5, novos | ✅ | ★★★ |
| 74 | Erro de medição na dependente | D | 70 | D10.3, D02.14 | ✅ | ★★★ |
| 75 | Erro de medição no regressor: atenuação | D | 68 | D10.2 | ✅ | ★★★ |
| 76 | VI, MQ2E e GMM: dissertativa | T | 66 | [10 lista](../../10_endogeneidade_iv/10_lista1.md) | ✅ | ★★ |
| 77 | `ivreg` dos cigarros a 5% | I | 67 | [10 lista](../../10_endogeneidade_iv/10_lista1.md), novos | ⚠️ | ★★★ |
| 78 | Hausman na forma geral | T | — | D10.10, D10.12 | ✅ | ★★ |
| 79 | Identificação exata × sobreidentificação; limite do Sargan | T | — | D10.11, novos | ❌ | ★★ |

## Contagem

| | Exercícios |
|---|---|
| Com equivalente na lista antiga | 51 |
| Sem equivalente, mas já cobertos pela teoria dos módulos (22, 24, 25, 39, 43, 48, 53, 54, 58) | 9 |
| Sem equivalente, resolvidos agora em [novos.md](novos.md) ou em D novo | 19 |
| Marcados ★★★ | 21 |
