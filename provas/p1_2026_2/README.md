---
title: "P1 2026/2 — mapa da prova, autoavaliação e lições"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
prova: "P1 — 09/10/2026"
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
  - P1 2026/2
---

# P1 2026/2 — a prova que veio

Prova aplicada em **09/10/2026**, sem consulta, 10 pontos, com $e=2{,}718$ e duas casas decimais. As fotos ficam em `materiais/provas/p1_2026_2/` (fora do git, como todo material do professor).

| Arquivo | Para quê |
|---|---|
| [resolucao.md](resolucao.md) | gabarito comentado, item a item, com rubrica por passo |
| [reproducao.R](reproducao.R) | confere todas as contas e as três demonstrações em R; grava `resultados/p26.csv` |

## 1. O mapa da prova

> [!IMPORTANT]
> **A estrutura mudou em relação à P1 2025/2**
> Em 2025/2, dois terços da nota foram leitura de output (NLOGIT e `ivreg`). Em 2026/2 **não houve output**: a Parte I (6,0) trouxe números prontos para **calcular** (matriz pequena, $t$, $F$, efeito marginal, VI) e a Parte II (4,0) três demonstrações clássicas. O peso saiu da interpretação e foi para a mecânica de conta.

| Questão | Tema | Itens (pontos) | Total | Onde estava no repositório |
|---|---|---|---|---|
| **Q1** | MQO matricial, $n=4$, $\mathbf X'\mathbf X$ diagonal | a) $\mathbf X'\mathbf X$ e $\mathbf X'\mathbf y$ (0,5) · b) inversa e $\widehat\beta$ (0,5) · c) resíduos e $\mathbf X'\widehat u=\mathbf 0$ (0,25) · d) interpretar (0,25) | **1,5** | [03_teoria](../../03_mqo_matricial/03_teoria.md), D03.2 |
| **Q2** | Log-salário com EXP² e dummy | a) semi-elasticidades (0,25) · b) teste $t$ de FEMALE (0,25) · c) $F$ conjunto de EXP e EXP² (0,5) · d) efeito marginal e reversão (0,5) | **1,5** | [09_teoria](../../09_dummies_forma_funcional/09_teoria.md), D09.3 e D09.5; [07_teoria](../../07_testes_hipoteses/07_teoria.md) |
| **Q3** | Mudança estrutural com dummies (Chow) | a) $\delta_0$ e $\delta_1$ (0,25) · b) $H_0$ conjunta (0,25) · **c) calcular $F$ (0,75)** · d) significado (0,25) | **1,5** | D09.7 em [09_teoria](../../09_dummies_forma_funcional/09_teoria.md) |
| **Q4** | Endogeneidade e VI no modelo simples | a) plim do MQO (0,5) · b) $\widehat\beta_1^{IV}$ e $\widehat\beta_0^{IV}$ (0,25) · c) condições e instrumento fraco (0,5) · d) $\operatorname{Cov}(Z,u)\neq 0$ (0,25) | **1,5** | [10_teoria](../../10_endogeneidade_iv/10_teoria.md), D10.1, D10.5, D10.9 |
| **Q5** | Gauss-Markov com $\widehat\beta^*=[(\mathbf X'\mathbf X)^{-1}\mathbf X'+\mathbf C]\mathbf y$ | demonstração única | **1,5** | **D06.5**, idêntica, em [06_teoria](../../06_amostra_finita_multicol/06_teoria.md) |
| **Q6** | Frisch-Waugh-Lovell | demonstração única | **1,0** | **D04.1 e D04.2** em [04_teoria](../../04_fwl_particionada/04_teoria.md) |
| **Q7** | Consistência do MQO por Slutsky | demonstração única | **1,5** | **D08.1** em [08_teoria](../../08_assintotica/08_teoria.md) |

> [!NOTE]
> **As três demonstrações já estavam escritas aqui**
> Q5, Q6 e Q7 correspondem a D06.5, D04.1–D04.2 e D08.1, com a mesma notação. Os 4,0 pontos da Parte II eram os mais previsíveis da prova.

## 2. Autoavaliação (relato de 09/10, antes da nota oficial)

Estimativa feita a partir do que foi relatado logo depois da prova, item a item, contra a rubrica de [resolucao.md](resolucao.md).

| Questão | Vale | O que foi feito | Estimativa |
|---|---|---|---|
| Q1 | 1,5 | não resolvida | 0 |
| Q2 | 1,5 | a, b e c completos; d com o ponto de reversão certo (32,14) e o efeito marginal como 4,5%, sem o termo $2\beta_3EXP$ | 1,00–1,25 |
| Q3 | 1,5 | a, b e d respondidos; rejeitou $H_0$ sem calcular o $F$ | 0,75–1,00 |
| Q4 | 1,5 | c feito; a e b em branco | 0,50–0,75 |
| Q5 | 1,5 | chegou em $\sigma^2\mathbf C\mathbf C'$ pela subtração; sem a prova de que é semidefinida positiva | 1,00–1,25 |
| Q6 | 1,0 | incompleta: faltou isolar $\mathbf b_2$ com $\mathbf I-\mathbf P_1$ | 0,25–0,50 |
| Q7 | 1,5 | feita | 1,00–1,50 |
| **Total** | **10,0** | | **≈ 4,5 a 6,25** |

Quando a nota oficial sair, registre-a aqui e compare com a estimativa por questão: a diferença mostra quanto o professor dá de crédito parcial.

## 3. O diagnóstico

> [!WARNING]
> **Os pontos perdidos estão na conta, não no conceito**
> As demonstrações e as interpretações saíram. O que ficou em branco foram as contas curtas: a Q1 inteira (matriz diagonal, inversão trivial), o $F$ da Q3 (uma linha, 0,75 ponto) e os dois números da Q4b (340/85 e 50 − 32). Somados, são **cerca de 2,5 pontos** que não exigiam nada além da fórmula.

O que fazer com isso, nesta ordem:

1. **Começar pela Parte I e, dentro dela, pelos itens de conta.** Na prova de 2026/2, a ordem certa seria Q3c → Q2c → Q4b → Q1, todos de fórmula direta. A estratégia do [guia de provas](../README.md) (outputs primeiro) não se aplicou porque não houve output; a regra que sobrevive é "**pontos rápidos e certos primeiro**".
2. **Toda conta começa pela fórmula escrita.** Escrever $F=\frac{(SQR_R-SQR_{UR})/q}{SQR_{UR}/(n-k)}$ antes dos números teria salvado o item de 0,75 da Q3, e escrever $\partial\ln W/\partial EXP=\beta_2+2\beta_3EXP$ teria evitado o 4,5% da Q2d.
3. **Demonstração termina na conclusão pedida, não no último resultado algébrico.** Na Q5, $\sigma^2\mathbf C\mathbf C'$ não é o fim: falta a linha $\mathbf a'\mathbf C\mathbf C'\mathbf a=\lVert\mathbf C'\mathbf a\rVert^2\ge 0$. Releia o verbo do enunciado ("mostre que", "conclua") antes de fechar.
4. **Matriz pequena se treina.** Faça três exercícios de $\mathbf X'\mathbf X$, inversa $3\times 3$ e $\widehat\beta$ com $n\le 5$ (Lista 1, ex. matriciais do [mapa](../../LISTA1_MAPA.md)), cronometrando 12 minutos cada.

Os erros desta prova estão no [log de erros](../log_erros.md), com revisões em +1, +3 e +7 dias.

<!-- conferência numérica: valores conferidos contra resultados/*.csv pelo scripts/check_numbers.R
| chave_R | nota |
|---|---|
| p26_q2_exp_max | 32,14 |
| p26_q2_erro_comum | 4,5 |
| p26_q4_b1iv | 4 |
-->
