---
title: "P1 2025/2 — mapa da prova, pontuação e conferência"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2025/2
relevancia_p1: alta
status: rascunho
verificacao:
  numerica: ok
tags:
  - econometria
  - mestrado/ppgeco
  - p1
  - prova
aliases:
  - P1 2025/2
---

# P1 2025/2 — o molde da sua prova

Prova aplicada em **03/10/2025**, mesmo professor e mesma ementa. As fotos estão em `materiais/provas/p1_2025_2/` (fora do git): três páginas de enunciado (`p1_2025_2_pag1/2/3.jpeg`) e cinco de resolução manuscrita (`gabarito_q1`, `gabarito_q2`, `gabarito_q3_q4a`, `gabarito_q4b_q5`, `gabarito_q6`).

A resolução comentada está em [econometria-i-prova-2025-2-resolvida.md](econometria-i-prova-2025-2-resolvida.md); a reprodução em R, em [reproducao.R](reproducao.R).

## A distribuição de pontos

> [!IMPORTANT]
> **Dois terços da prova foram interpretação de output**
> Q1 e Q2 somaram **6,5 dos 10 pontos**. As quatro demonstrações valeram 3,5. Isso muda a estratégia: o vocabulário de interpretação vale mais que qualquer demonstração isolada — e as questões de output são as mais rápidas.

| Questão | Tema | Itens | Pontos | Onde estudar |
|---|---|---|---|---|
| **Q1** | Output de MQO, equação de salários de Cornwell-Rupert ($n=4165$) | a) JB é necessário? · b) teste $t$ de ED com $z=1{,}96$ · c) ponto de máximo de EXP · d) IC de ED · e) interpretar SOUTH · f) interpretar $\bar R^2$ | **3,0** | [módulo 07](../../07_testes_hipoteses/07_teoria.md), [módulo 09](../../09_dummies_forma_funcional/09_teoria.md), [vocabulário](../../formulario/vocabulario_interpretacao.md) |
| **Q2** | Output de `ivreg`, demanda por cigarros (Stock e Watson, 48 estados, 1995) | a) endógena e instrumentos · b) as duas propriedades · c) Wu-Hausman a 5% · d) instrumentos fracos · e) Sargan · f) significância conjunta com $\chi^2=11{,}07$ · g) interpretar log(price) | **3,5** | [módulo 10](../../10_endogeneidade_iv/10_lista1.md), ex. 67 |
| **Q3** | Derivação escalar do MQO ($y=Xb+e$) | a) equações normais $\sum e_i$ e $\sum x_ie_i$ · b) $a=\bar y-b\bar x$ · c) fórmula de $b$ | **1,25** | [módulo 02](../../02_mqo_simples/02_teoria.md), D02.1 |
| **Q4** | Erro de medição na **dependente** | a) o estimador é viesado? · b) variância e implicações | **1,0** | [módulo 10](../../10_endogeneidade_iv/10_teoria.md), D10.3 |
| **Q5** | Variância de MQO **e** consistência por teoria assintótica | demonstração única | **0,75** | [módulo 06](../../06_amostra_finita_multicol/06_lista1.md) ex. 26 + [módulo 08](../../08_assintotica/08_teoria.md) D08.1 |
| **Q6** | Derivar $\hat\beta_{IV}$ com $L=K$, a partir de $\operatorname{plim}(Z'\varepsilon/n)=0$ | demonstração única | **0,5** | [módulo 10](../../10_endogeneidade_iv/10_teoria.md), D10.5 |

## O que as fotos confirmam

1. **Os p-valores da Q2 são editados.** O quadro do `ivreg` traz Wu-Hausman $p=0{,}0469$ e Sargan $p=0{,}8468$, enquanto a mesma especificação em R produz 0,0569 e 0,5641 (e a Lista 1, ex. 67, imprime os valores do R). Some-se a isso que o Sargan aparece com **gl1 = 2**, quando a sobreidentificação é $L-K=1$. Ver [errata](../../formulario/errata_chave_lista1.md).
2. **A Q5 pede duas coisas numa só questão:** deduzir $\operatorname{Var}(b)=\sigma^2(X'X)^{-1}$ **e** provar a consistência. O gabarito manuscrito fecha a consistência pelo caminho da variância: $\frac{\sigma^2}{n}Q^{-1}\to 0$.
3. **A Q3 é a derivação escalar completa**, mas o enunciado entrega a estrutura: pede as equações normais, depois o intercepto a partir de $\sum e_i=0$ e só então a inclinação. Quem sabe o encadeamento ganha os 1,25 rápido.
4. **A Q4 é o erro de medição na dependente** — o caso benigno (não vicia, infla variância). O contraste com o erro no regressor (atenuação) é o que distingue uma resposta completa.
5. **O enunciado da Q1 dá os valores críticos** ($z=1{,}96$). O padrão do professor é entregar o crítico: use o que está no papel.

## Como usar esta prova

| Quando | O quê |
|---|---|
| Hoje (diagnóstico) | Resolva Q3 a Q6 sem consulta, 90 min, e corrija pela nota resolvida |
| Semana 2 | Refaça Q1 e Q2 cronometrando 12 min cada, checando contra a [reprodução em R](reproducao.R) |
| Véspera | Releia só o mapa acima: ele mostra onde estão os pontos |
