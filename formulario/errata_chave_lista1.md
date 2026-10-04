---
title: "Errata da chave de correção da Lista 1"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
status: rascunho
verificacao:
  chave: parcial
tags:
  - econometria
  - mestrado/ppgeco
  - lista
aliases:
  - Errata da chave
---

# Errata da chave de correção da Lista 1

A chave (`materiais/listas/lista1_chave.pdf`) é útil, mas tem erros e inconsistências. Aqui ficam registrados os pontos em que a nossa resposta diverge, sempre com o motivo. Nada da chave é reproduzido: cada linha descreve o conteúdo com palavras próprias.

> [!WARNING]
> **Como usar**
> Se na prova aparecer uma dessas situações, responda pelo argumento correto, não pelo que a chave diz. Em caso de ambiguidade genuína, escreva a regra de decisão explicitamente ("como $p \gt \alpha$, não se rejeita H0") — é isso que garante o ponto.

| Ex. | O que a chave conclui | O correto | Por quê | Impacto na prova |
|---|---|---|---|---|
| 50 | que o modelo está mal especificado | **não** há evidência de má especificação | O RESET traz $F=2{,}284568$ contra $F_{crit}=4{,}10$, e $p=0{,}20267 \gt 0{,}05$. Com a estatística abaixo do crítico, não se rejeita H0, e H0 é "modelo corretamente especificado". | Alto: RESET é candidato garantido a questão de interpretação. Erre a direção da decisão e perde a questão inteira. |
| 46 f | conclusão de não normalidade | a conclusão (rejeitar normalidade) está certa, mas os **números não batem entre lista e chave** | O enunciado da lista mostra $JB = 18{,}870682$; a chave usa $10{,}48190$. Os dois superam o crítico de $\chi^2_2$ a 5% (5,99), então a decisão não muda — mas o valor crítico citado nos dois lugares também difere. | Médio: mostra que os números do enunciado podem estar desalinhados. Sempre cite qual estatística e qual crítico você usou. |

## Na prova de 2025/2 (fotos em `materiais/provas/p1_2025_2/`)

| Onde | O que está impresso | O problema | O que fazer |
|---|---|---|---|
| Q2, quadro do `ivreg` | Sargan com **gl1 = 2** | Com 2 instrumentos externos para 1 endógena, a sobreidentificação é $L-K=1$: o Sargan tem **1** grau de liberdade, não 2 | Use o **p-valor impresso** para decidir e, se sobrar espaço, registre em uma linha que o gl correto seria 1 |
| Q2, p-valores | Wu-Hausman 0,0469 e Sargan 0,8468 | Não são os valores que a mesma especificação produz em R (0,0569 e 0,5641): o professor edita os números entre versões | Decida sempre pelo número do **seu** enunciado; nunca de memória |

O gabarito manuscrito da Q2 confirma a leitura esperada: com $p=0{,}0469 \lt 0{,}05$, rejeita-se H0 do Wu-Hausman e o MQ2E é o consistente.

## Chave v.1 (lista de 79 exercícios)

A versão v.1 (`materiais/listas/lista1_v1_chave.pdf`) foi conferida exercício a exercício; os números estão em [lista1_v1.R](../provas/lista1_v1/lista1_v1.R) e o status de cada um no [mapa da v.1](../provas/lista1_v1/mapa.md). Quase tudo confere. A boa notícia: **o erro do RESET (ex. 50 antigo, agora ex. 63) foi corrigido** — a v.1 conclui que não há evidência de má especificação.

| Ex. v.1 | O que a chave faz | O correto | Impacto na prova |
|---|---|---|---|
| 79 | escreve a estatística de Sargan como $n$ vezes a forma quadrática $\widehat\varepsilon'\mathbf Z(\mathbf Z'\mathbf Z)^{-1}\mathbf Z'\widehat\varepsilon$ dividida por $s^2$ | sem o $n$: a forma quadrática dividida por $\widehat\varepsilon'\widehat\varepsilon/n$, que é $nR^2_{aux}$. Nos cigarros, a fórmula certa dá 0,333 (o valor do R); com o $n$ extra, 15,97 | Médio: se pedirem a fórmula do Sargan, escreva $nR^2_{aux}$ |
| 77 e | repete o Sargan com 2 gl e p = 0,8468 | com 2 instrumentos externos para 1 endógena, $L-K=1$ gl e p = 0,564 | Baixo: a decisão não muda; use o p impresso |
| 77 d | rejeita o Wu-Hausman a 5% com p = 0,0469 | a estatística 3,823 com $F(1,44)$ dá p = 0,0569, que **não** rejeitaria a 5% | Alto: a lista antiga pedia 10%; a v.1 pede 5%. Decida pelo p impresso e escreva a comparação |
| 41, 42 | usa SQR para a soma da regressão e SQE para a dos resíduos, seguindo o enunciado | é o contrário da convenção dos ex. 29, 43, 45, 50 e 64 (SQR = resíduos) | Alto: defina a sigla na primeira linha da resposta |
| 59 e | passo intermediário da elasticidade da forma inversa que simplifica para $-\widehat\beta_2/\bar Y$ | $\eta=-\beta_2/(XY)$, que é a expressão final da própria chave | Baixo: só o passo do meio está errado |
| 67 | na primeira diferença, deixa um termo $\beta_1 D(T_2-T_1)$ e depois o some sem justificar | $\beta_1(D_{i2}-D_{i1})=0$ porque o grupo de tratamento não muda no tempo; o resultado final ($\beta_3$ mais a diferença dos controles) está certo | Médio: na prova, escreva por que o $\beta_1$ some |
| 40 b | diz que o ganho de eficiência do MQ restrito é positivo quando a amostra não satisfaz a restrição | a diferença de variâncias depende só de $X$ e $R$, não de $y$: é semidefinida positiva com posto $q$ sempre | Baixo |
| 61 a | chama $e^{\widehat\alpha}$ de custo esperado no ano-base | é a mediana (média geométrica): $E(e^{u})\ne 1$ | Baixo |
| 15 | remete a normalidade aos "exercícios 29–31" | o resultado assintótico que dispensa a normalidade é o ex. 53 | Nenhum |

**No enunciado da v.1 (não na chave):**

| Ex. | O que está impresso | O problema | O que fazer |
|---|---|---|---|
| 6 | $F=42{,}5$ com $R^2=0{,}78$, $n=50$, $k=4$ | pela fórmula do ex. 42, esse $R^2$ dá $F=54{,}4$ | Decida com o 42,5 impresso |
| 46 | crítico $\chi^2=2{,}54$ "ao nível usual" | o $\chi^2(2)$ a 5% é 5,99; 2,54 corresponde a $\alpha\approx 28\%$ | Use o impresso; a decisão não muda |
| 44 | variáveis sem unidades nem nome da dependente | a chave interpreta como PIB estadual em bilhões, emprestando o contexto do ex. 41 antigo | Interprete com as unidades que a prova der |
| 5, 45 | $\bar R^2$ impresso 0,76 e 0,40 | as contas dão 0,766 e 0,408 (o enunciado trunca) | Irrelevante para decisões |

## Padrão de resposta quando a chave e a conta divergem

1. Escreva as hipóteses.
2. Cite a estatística **do enunciado** e o crítico **do enunciado**.
3. Compare explicitamente e conclua.
4. Se o resultado contrariar o "esperado", diga em uma linha por que a decisão é essa.

Esse roteiro deixa o argumento verificável, que é o que vale ponto.

## A conferir

A auditoria exercício a exercício da chave ainda não terminou. Boa parte dos itens da chave apenas remete a livro (Gujarati, Wooldridge, Greene) e não tem resposta desenvolvida — esses entram como ➖ no [LISTA1_MAPA.md](../LISTA1_MAPA.md).
