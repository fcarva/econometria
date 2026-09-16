---
title: "Módulo 01 — Lista 1 resolvida (ex. 10, 11 e 12)"
modulo: "01"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
greene: "cap. 1; cap. 4"
slides: "SL01, SL02"
lista1: [10, 11, 12]
relevancia_p1: media
status: rascunho
verificacao:
  derivacao: pendente
  numerica: ok
  chave: ok
tags:
  - econometria
  - mestrado/ppgeco
  - p1
aliases:
  - Paradigma — Lista 1
---

# Módulo 01 — Lista 1 resolvida (ex. 10, 11 e 12)

Três questões conceituais que abrem provas e valem ponto rápido — desde que a resposta seja organizada. Teoria em [01_teoria.md](01_teoria.md).

---

## Ex. 10 — Etapas da análise econométrica

**Tipo:** conceitual · **Chave:** ➖ (a chave não desenvolve) · **Cai como:** item de abertura

1. **Formular a questão e a teoria.** De onde vem a relação a ser investigada (teoria do consumo, função de produção, equação de salários).
2. **Especificar o modelo econométrico.** Escolher variáveis, forma funcional e a natureza do termo de erro. É aqui que a teoria vira equação estimável.
3. **Coletar os dados.** Definir a estrutura (corte transversal, série temporal ou painel), a fonte e o período; avaliar erro de medida.
4. **Estimar os parâmetros.** MQO no caso clássico; MQG, VI ou MV quando alguma hipótese cai.
5. **Testar hipóteses e checar pressupostos.** Significância individual e conjunta, restrições teóricas, especificação (RESET), normalidade (JB), heterocedasticidade e autocorrelação.
6. **Interpretar e usar.** Sinais, magnitudes, elasticidades, previsão e avaliação de política — sempre com as limitações declaradas.

> [!TIP]
> **Como ganhar o ponto inteiro**
> Uma frase por etapa e, na última, uma menção ao ciclo: se o diagnóstico reprova o modelo, volta-se à especificação. Mostrar que o processo é iterativo é o que diferencia a resposta.

## Ex. 11 — Hipóteses do modelo de regressão linear simples

**Tipo:** conceitual · **Chave:** ✅ confere

Na versão escalar, cobrada pela chave, são cinco:

| Hipótese | Enunciado | Para que serve |
|---|---|---|
| Linearidade | $Y_i=\beta_1+\beta_2X_i+u_i$, linear **nos parâmetros** | permite a álgebra do MQO |
| Média condicional nula | $E[u_i\mid X]=0$ | garante o **não-viés** (e implica $\operatorname{Cov}(X,u)=0$) |
| Homocedasticidade | $\operatorname{Var}(u_i\mid X)=\sigma^2$ para todo $i$ | dá $\operatorname{Var}(\hat\beta_2)=\sigma^2/S_{XX}$ e sustenta Gauss-Markov |
| Ausência de autocorrelação | $\operatorname{Cov}(u_i,u_j\mid X)=0$ para $i\neq j$ | idem; crítica em séries temporais |
| Variação em $X$ | $\sum_i(X_i-\bar X)^2\gt 0$ | sem variação não há identificação: $S_{XX}$ no denominador |

Na forma matricial, as mesmas ideias viram A1 a A6, com a normalidade (A6) acrescentada para a inferência exata — ver [CONVENCOES.md](../CONVENCOES.md) §2 e a tabela comentada em [01_teoria.md](01_teoria.md).

> [!WARNING]
> **A hipótese que a maioria esquece**
> "X deve variar" parece trivial, mas é a versão escalar de A2 (posto completo). Sem ela, $\hat\beta_2=S_{XY}/S_{XX}$ é divisão por zero — é o mesmo problema dos ex. 35 e 61, agora em uma dimensão.

## Ex. 12 — Propriedades ótimas do MQO em amostras pequenas

**Tipo:** conceitual · **Chave:** ✅ confere

Sob as hipóteses acima, o estimador de MQO é **MELNV** (melhor estimador linear não viesado; em inglês, BLUE):

| Propriedade | Significado | Onde é provada |
|---|---|---|
| **Linear** | é combinação linear dos $Y_i$: $\hat\beta_2=\sum_i k_iY_i$ | D02.4 |
| **Não viesado** | $E[\hat\beta_j]=\beta_j$: acerta em média, em amostras repetidas | D9, D02.5, ex. 14 e 24 |
| **Eficiente** | tem a menor variância entre os lineares não viesados | D11, D16, ex. 33 |

O conjunto é o **teorema de Gauss-Markov**. Três observações que valem ponto:

1. A eficiência é relativa a uma classe: **entre os lineares não viesados**. Um estimador não linear, ou viesado, pode ter EQM menor (ex. 9 e ex. 53).
2. **Nada disso exige normalidade.** A normalidade entra só para a inferência exata em amostra pequena.
3. São propriedades de **amostra finita**, válidas para qualquer $n$. As propriedades assintóticas — consistência e normalidade assintótica — são outra conversa, no [módulo 08](../08_assintotica/08_teoria.md).
