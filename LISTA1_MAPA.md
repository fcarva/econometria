---
title: "Lista 1 — mapa dos 74 exercícios"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
tags:
  - econometria
  - mestrado/ppgeco
  - lista
  - p1
aliases:
  - Lista 1
---

# Lista 1: mapa dos 74 exercícios

A Lista 1 cobre toda a P1. Cada exercício aparece aqui com uma paráfrase (o enunciado fica em `materiais/listas/lista1.pdf`), o tipo, o módulo onde está resolvido e o status em relação à chave do professor.

**Tipo:**

| Letra | Significado |
|---|---|
| **D** | derivação (demonstração) |
| **C** | cálculo à mão |
| **I** | interpretação de output |
| **T** | conceitual |
| **R** | computacional em R |

**Status em relação à chave:**

| Símbolo | Significado |
|---|---|
| ✅ | confere |
| ⚠️ | diverge, com explicação |
| ❌ | chave errada (ver [errata](formulario/errata_chave_lista1.md)) |
| ➖ | chave só remete a livro |
| ⏳ | não conferido |

| Ex. | Tema (paráfrase) | Tipo | Módulo | Chave |
|---|---|---|---|---|
| 1 | Variância de uma v.a. multiplicada por constante | D | [00](00_fundamentos/00_lista1.md) | ⏳ |
| 2 | Esperança e variância da média amostral | D | [00](00_fundamentos/00_lista1.md) | ⏳ |
| 3 | Consistência da média amostral | D | [00](00_fundamentos/00_lista1.md) | ⏳ |
| 4 | Duas formas da variância | D | [00](00_fundamentos/00_lista1.md) | ⏳ |
| 5 | Duas formas da covariância | D | [00](00_fundamentos/00_lista1.md) | ⏳ |
| 6 | Independência implica covariância nula | D | [00](00_fundamentos/00_lista1.md) | ⏳ |
| 7 | Covariância nula implica independência? | T | [00](00_fundamentos/00_lista1.md) | ⏳ |
| 8 | Soma dos desvios em relação à média é zero | D | [00](00_fundamentos/00_lista1.md) | ⏳ |
| 9 | EQM = variância + viés² | D | [00](00_fundamentos/00_lista1.md) | ⏳ |
| 10 | Etapas da análise econométrica | T | [01](01_paradigma_projecao/01_lista1.md) | ⏳ |
| 11 | Hipóteses do MRL simples | T | [01](01_paradigma_projecao/01_lista1.md) | ⏳ |
| 12 | Propriedades ótimas do MQO em amostra finita | T | [01](01_paradigma_projecao/01_lista1.md) | ⏳ |
| 13 | Investimento público × PIB estadual: interpretação, obtenção por MQO, por que é o "melhor" | D/T | [02](02_mqo_simples/02_lista1.md) | ⏳ |
| 14 | Não-viés de $\hat\beta_1$ e $\hat\beta_2$ | D | [02](02_mqo_simples/02_lista1.md) | ⏳ |
| 15 | Viés de variável omitida na regressão simples | D | [02](02_mqo_simples/02_lista1.md) | ⏳ |
| 16 | Variâncias e covariância de $\hat\beta_1,\hat\beta_2$ | D | [02](02_mqo_simples/02_lista1.md) | ⏳ |
| 17 | Resíduos somam zero e são ortogonais a $X$ | D | [02](02_mqo_simples/02_lista1.md) | ⏳ |
| 18 | $t^2=F$ na regressão simples | D | [02](02_mqo_simples/02_lista1.md) | ⏳ |
| 19 | F escrito com $R^2$ (simples) | D | [02](02_mqo_simples/02_lista1.md) | ⏳ |
| 20 | Dispersão de $X$ e precisão de $\hat\beta_2$ | T | [02](02_mqo_simples/02_lista1.md) | ⏳ |
| 21 | Média dos ajustados = média observada | D | [02](02_mqo_simples/02_lista1.md) | ⏳ |
| 22 | Regressão em desvios da média | D | [02](02_mqo_simples/02_lista1.md) | ⏳ |
| 23 | Regressão múltipla matricial: hipóteses, $b$ e sua variância, propriedades finitas e assintóticas, endogeneidade | D/T | [03](03_mqo_matricial/03_lista1.md) | ⏳ |
| 24 | $b$ é não viesado | D | [03](03_mqo_matricial/03_lista1.md) | ⏳ |
| 25 | Viés de omissão no modelo particionado | D | [04](04_fwl_particionada/04_lista1.md) | ⏳ |
| 26 | $\operatorname{Var}(b\mid X)=\sigma^2(X'X)^{-1}$ | D | [06](06_amostra_finita_multicol/06_lista1.md) | ⏳ |
| 27 | F escrito com $R^2$ (múltipla) | D | [05](05_ajuste_restricoes/05_lista1.md) | ⏳ |
| 28 | Resíduos $e=My$ (*residual maker*) | D | [03](03_mqo_matricial/03_lista1.md) | ⏳ |
| 29 | Ajustados $\hat y=Py$ (projeção) | D | [03](03_mqo_matricial/03_lista1.md) | ⏳ |
| 30 | $e'e=y'y-b'X'y$ | D | [03](03_mqo_matricial/03_lista1.md) | ⏳ |
| 31 | $X'e=0$ | D | [03](03_mqo_matricial/03_lista1.md) | ⏳ |
| 32 | Significado de $E(\mu\mu'\mid X)=\sigma^2I$ | D/T | [06](06_amostra_finita_multicol/06_lista1.md) | ⏳ |
| 33 | Gauss-Markov matricial com $b^*=[(X'X)^{-1}X'+C]y$ | D | [06](06_amostra_finita_multicol/06_lista1.md) | ⏳ |
| 34 | MQO matricial à mão (5 observações) | C | [03](03_mqo_matricial/03_lista1.md) | ⏳ |
| 35 | Colinearidade perfeita: $X'X$ não inversível | C | [03](03_mqo_matricial/03_lista1.md) | ⏳ |
| 36 | Significado de $E(u_i^2)=\sigma_i^2$ | T | [06](06_amostra_finita_multicol/06_lista1.md) | ⏳ |
| 37 | Matriz de covariância dos erros não diagonal: qual hipótese cai | T | [06](06_amostra_finita_multicol/06_lista1.md) | ⏳ |
| 38 | Vendas de cabos: regressão múltipla, sinais, F e t a 10%, $R^2$ e $\bar R^2$ | R | [07](07_testes_hipoteses/07_lista1_computacional.md) | ⏳ |
| 39 | Vendas de cabos: RESET, correlações, multicolinearidade, regressões auxiliares, DW, BG, White | R | [07](07_testes_hipoteses/07_lista1_computacional.md) | ⏳ |
| 40 | Função de produção à mão: MQO, previsão, elasticidade na média | C | [02](02_mqo_simples/02_lista1.md) | ⏳ |
| 41 | PIB × investimento (output): sinais, $R^2$, $r$ vs $R^2$, efeito de variação | I | [07](07_testes_hipoteses/07_lista1.md) | ⏳ |
| 42 | IC e teste t para a inclinação do ex. 41 | I | [07](07_testes_hipoteses/07_lista1.md) | ⏳ |
| 43 | Consumo de café: cinco formas funcionais e elasticidades | R/D | [09](09_dummies_forma_funcional/09_lista1.md) | ⏳ |
| 44 | Custo total × quantidade (output): elasticidade, t, F, IC, JB | I | [07](07_testes_hipoteses/07_lista1.md) | ⏳ |
| 45 | Modelos log-lin e log-log do custo: interpretação | I | [07](07_testes_hipoteses/07_lista1.md) | ⏳ |
| 46 | PIB × crédito log-log (output): interpretação, t, IC, $R^2$, JB, ANOVA, elasticidade | I | [07](07_testes_hipoteses/07_lista1.md) | ⏳ |
| 47 | Linearizar a Cobb-Douglas para usar MQO | D | [09](09_dummies_forma_funcional/09_lista1.md) | ⏳ |
| 48 | Linearizar a relação exponencial exportações × renda | D | [09](09_dummies_forma_funcional/09_lista1.md) | ⏳ |
| 49 | Má especificação e passos do RESET | T | [07](07_testes_hipoteses/07_lista1.md) | ⏳ |
| 50 | Leitura de um RESET | I | [07](07_testes_hipoteses/07_lista1.md) | ⏳ |
| 51 | Quadrática verdadeira × reta ajustada: qual propriedade se perde | T | [07](07_testes_hipoteses/07_lista1.md) | ⏳ |
| 52 | Teste LM: restrita × irrestrita | I | [07](07_testes_hipoteses/07_lista1.md) | ⏳ |
| 53 | Excluir variável para curar multicolinearidade e o viés que isso gera | T | [06](06_amostra_finita_multicol/06_lista1.md) | ⏳ |
| 54 | Passos do teste por regressão auxiliar | T | [06](06_amostra_finita_multicol/06_lista1.md) | ⏳ |
| 55 | Retornos de escala no setor informal: t, F e F restrito | I/C | [05](05_ajuste_restricoes/05_lista1.md) | ⏳ |
| 56 | Demanda por energia (output): ANOVA, interpretação, F e t | I | [05](05_ajuste_restricoes/05_lista1.md) | ⏳ |
| 57 | Poupança × renda com dummies de intercepto e de inclinação | R | [09](09_dummies_forma_funcional/09_lista1.md) | ⏳ |
| 58 | Demanda log-log: sinais, F conjunto, elasticidade, dummy de crise | I | [09](09_dummies_forma_funcional/09_lista1.md) | ⏳ |
| 59 | Demanda por etanol com DUMMY×PIB: F, t, elasticidade, quebra | I | [09](09_dummies_forma_funcional/09_lista1.md) | ⏳ |
| 60 | Montar teste de quebra estrutural com dummies | T/D | [09](09_dummies_forma_funcional/09_lista1.md) | ⏳ |
| 61 | Armadilha da variável dummy | D | [09](09_dummies_forma_funcional/09_lista1.md) | ⏳ |
| 62 | Retornos constantes de escala por F restrito | I | [05](05_ajuste_restricoes/05_lista1.md) | ⏳ |
| 63 | Matriz de correlação: indício de colinearidade | I | [06](06_amostra_finita_multicol/06_lista1.md) | ⏳ |
| 64 | Matriz de correlação e FIV | C | [06](06_amostra_finita_multicol/06_lista1.md) | ⏳ |
| 65 | Derivar $\hat\beta_{IV}$ via plim | D | [10](10_endogeneidade_iv/10_lista1.md) | ⏳ |
| 66 | VI, MQ2E e GMM: motivação, estimação, inferência | T | [10](10_endogeneidade_iv/10_lista1.md) | ⏳ |
| 67 | Output do `ivreg` a 10%: instrumentos fracos, Wu-Hausman, Sargan | I | [10](10_endogeneidade_iv/10_lista1.md) | ⏳ |
| 68 | Erro de medição no regressor: viés e inconsistência | D | [10](10_endogeneidade_iv/10_lista1.md) | ⏳ |
| 69 | Simultaneidade keynesiana: $\hat\beta_1$ inconsistente | D | [10](10_endogeneidade_iv/10_lista1.md) | ⏳ |
| 70 | Erro de medição na dependente: viés e variância | D | [10](10_endogeneidade_iv/10_lista1.md) | ⏳ |
| 71 | Estimador de diferenças em diferenças | D | [09](09_dummies_forma_funcional/09_lista1.md) | ⏳ |
| 72 | DiD com controles invariantes no tempo | D | [09](09_dummies_forma_funcional/09_lista1.md) | ⏳ |
| 73 | Monte Carlo do TLC para a média amostral (R) | R | [08](08_assintotica/08_lista1.md) | ⏳ |
| 74 | Regressão múltipla livre com dados reais | R | [07](07_testes_hipoteses/07_lista1_computacional.md) | ⏳ |

## Distribuição por módulo

| Módulo | Exercícios | Qtd. |
|---|---|---|
| 00 fundamentos | 1–9 | 9 |
| 01 paradigma e projeção | 10–12 | 3 |
| 02 MQO simples | 13–22, 40 | 11 |
| 03 MQO matricial | 23, 24, 28–31, 34, 35 | 8 |
| 04 FWL e particionada | 25 | 1 |
| 05 ajuste e restrições | 27, 55, 56, 62 | 4 |
| 06 amostra finita e multicolinearidade | 26, 32, 33, 36, 37, 53, 54, 63, 64 | 9 |
| 07 testes de hipóteses | 38, 39, 41, 42, 44–46, 49–52, 74 | 12 |
| 08 assintótica | 73 (e ligações com 3 e 68) | 1 |
| 09 dummies e forma funcional | 43, 47, 48, 57–61, 71, 72 | 10 |
| 10 endogeneidade e VI | 65–70 | 6 |
