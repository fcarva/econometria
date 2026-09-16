---
title: "P2 2024/2 — mapa das questões"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
prova: "2ª prova de 2024/2 (29/11/2024)"
slides: "SL07–SL13"
relevancia_p1: media
status: rascunho
tags:
  - econometria
  - mestrado/ppgeco
  - prova
  - p2
aliases:
  - Mapa P2 2024/2
---

# P2 2024/2: mapa das questões

> [!NOTE]
> **Por que olhar uma P2 antes da P1**
> A P2 cobre a matéria de SL11–SL14 (MQG, painel, MV), fora do escopo da P1. Mas a última questão é um output de MQ2E de log-salário com diagnósticos de VI, conteúdo de SL10 e da P1. E a prova mostra o hábito do professor de reciclar outputs. O original fica em `materiais/provas/` (id P2-24, fora do git). Aqui estão só paráfrases.

## Questões e onde estudar

| Q. | Tipo (paráfrase) | Formato | Módulo |
|---|---|---|---|
| 1a | Modelo de regressão generalizado com $E[\varepsilon\varepsilon'\mid X]=\sigma^2\Omega$, $\Omega$ diagonal (pesos da heterocedasticidade): derivar a variância do estimador de MQO | derivação matricial | [11](../../11_mqg_heterosk_autocorr/) (P2); a base é D14 de P1, com $\sigma^2\Omega$ no lugar de $\sigma^2I$ |
| 1b | Mesmo modelo, com a decomposição espectral $\Omega=C\Lambda C'$ e a matriz de transformação $P$ tal que $\Omega^{-1}=P'P$: derivar o estimador de MQG | derivação matricial | [11](../../11_mqg_heterosk_autocorr/) (P2) |
| 1c | Provar que os erros do modelo transformado ($Py=PX\beta+P\varepsilon$) são homocedásticos. Com $\Omega$ diagonal, é o MQP (mínimos quadrados ponderados) | derivação | [11](../../11_mqg_heterosk_autocorr/) (P2) |
| 2 | Erro AR(1) estacionário, $\varepsilon_t=\rho\varepsilon_{t-1}+\mu_t$ com $\lvert\rho\rvert\lt 1$: provar que a correlação entre $\varepsilon_t$ e $\varepsilon_{t-1}$ é $\rho$ | derivação | [11](../../11_mqg_heterosk_autocorr/) (P2); usa o kit D0 |
| 3 | Efeitos aleatórios, $\eta_{it}=\varepsilon_{it}+\mu_i$: significado de $E[\eta_{it}\eta_{is}\mid X]=\sigma_\mu^2$ para $t\neq s$ e se MQO serve para estimar o modelo | derivação + conceito | [13](../../13_painel_II/) (P2) |
| 4 | Teste F de efeitos fixos contra *pooling* (PIB industrial × financiamentos, municípios do ES): conclusão a partir do output | interpretação | [12](../../12_painel_I/) (P2); a lógica do F restrito é a de [05](../../05_ajuste_restricoes/05_teoria.md) (D05.12) |
| 5 | Teste de Hausman, efeitos fixos contra aleatórios, mesmos dados: conclusão | interpretação | [13](../../13_painel_II/) (P2); mesma lógica do Wu-Hausman de [10](../../10_endogeneidade_iv/) |
| 6a | Output MQ2E de LWAGE (dados de Cornwell e Rupert): pelo teste adequado a 5%, MQO ou MQ2E? | interpretação | [10](../../10_endogeneidade_iv/) (**P1**) |
| 6b | Instrumentos fracos a 5% | interpretação | [10](../../10_endogeneidade_iv/) (**P1**) |
| 6c | Sargan: os instrumentos são válidos a 5%? | interpretação | [10](../../10_endogeneidade_iv/) (**P1**) |
| 6d | Jarque-Bera dado no enunciado: normalidade dos resíduos | interpretação | [07](../../07_testes_hipoteses/) (**P1**) |
| 6e | Significância conjunta dos efeitos marginais | interpretação | [07](../../07_testes_hipoteses/) (**P1**) |
| 6f | Teste $t$ de EXP com $z=1{,}96$ | interpretação | [07](../../07_testes_hipoteses/) (**P1**) |
| 6g | Ponto de máximo do quadrático em EXP, com a conta | cálculo | [09](../../09_dummies_forma_funcional/) (**P1**) |

> [!IMPORTANT]
> **O que a Q6 ensina para a P1**
> Os itens 6f e 6g repetem, quase literalmente, os itens (b) e (c) da Q1 da P1 2025/2. Os itens 6a–6c são os mesmos três testes de VI da Q2 da P1 2025/2 e da Lista 1, ex. 67. O professor troca o dado (cigarros ↔ salário) e o α, mas mantém as perguntas.

## A regressão MQ2E da Q6, reproduzida

A tabela da Q6 sai exatamente com `AER::PSID7682` (os dados de Cornwell e Rupert), LWAGE com 5 casas decimais (como no arquivo do Greene), **WKS endógena** e **UNION e FEM como instrumentos excluídos**. O NLOGIT usa $s^2=e'e/n$ no MQ2E, sem correção de graus de liberdade. Com essa convenção, coeficientes e erros padrão batem nas 8 casas. O output está em [banco/outputs/psid_mq2e_wks.txt](../banco/outputs/psid_mq2e_wks.txt).

| chave_R | nota |
|---|---|
| bnc_p2_r2 | 0,3192467 |
| bnc_p2_r2adj | 0,3177722 |
| bnc_p2_F | 216,50 |
| bnc_p2_b_wks | 0,01922950 |
| bnc_p2_se_wks | 0,00583960 |
| bnc_p2_s | 0,3807377 |
| bnc_p2_ssr | 603,7634 |
| bnc_p2_ssr_nlogit | 602,3138 |
| bnc_p2_expstar | 30,83 |

O NLOGIT imprime como "soma dos quadrados" o valor $s^2(n-K)$ com $s^2=e'e/n$, e não o $e'e$ verdadeiro. Por isso a linha da prova difere da soma de quadrados que o R calcula.

> [!CAUTION]
> **O bloco de diagnósticos da Q6 foi colado de outro exemplo**
> Os diagnósticos impressos sob a regressão de LWAGE são Weak instruments 228,738 (gl 2 e 44, p 0,0000), Wu-Hausman 3,823 (gl 1 e 44, p 0,0369) e Sargan 0,333 (gl 1, p 0,5641). Os graus de liberdade **44** são os da demanda por cigarros ($n=48$), não os de uma regressão com $n=4165$, que teria gl2 = 4154. As estatísticas coincidem com as da Lista 1, ex. 67, só o p-valor do Wu-Hausman foi editado (lá, 0,0569). Os diagnósticos verdadeiros da regressão de LWAGE, calculados pelo R, estão abaixo. Na prova, **responda com o que está impresso**: a 5%, instrumentos fortes, rejeita-se a exogeneidade (MQ2E) e os instrumentos são válidos. Os números verdadeiros levariam à conclusão oposta no Sargan.

| chave_R | nota |
|---|---|
| bnc_p2_df2 | 4154 |
| bnc_p2_weak | 84,569 |
| bnc_p2_wh | 6,555 |
| bnc_p2_wh_p | 0,0105 |
| bnc_p2_sargan | 502,98 |
| bnc_p2_sargan_p | 0 |

Com os números verdadeiros, o Sargan rejeita a validade dos instrumentos com folga. UNION e FEM afetam o salário por outros canais além de WKS (prêmio sindical, diferencial por gênero), e por isso não são exógenos na equação de salário. É um bom exemplo de por que a exogeneidade do instrumento é a hipótese mais frágil.

> [!TIP]
> **Como o professor pode torcer**
> - Trocar o α (5% ↔ 10%) mantendo o p-valor 0,0369 ou 0,0569: refaça a decisão do Wu-Hausman.
> - Perguntar por que o Sargan existe aqui (2 instrumentos excluídos para 1 endógena: sobreidentificação de grau 1) e por que não existiria com um instrumento só.
> - Pedir o ponto de máximo de EXP com os coeficientes do MQ2E, e não os do MQO: a conta é a mesma, $-a_3/(2a_4)$, com os números da tabela impressa.
