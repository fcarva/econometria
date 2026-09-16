---
title: "Econometria I — estudo para a P1"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
tags:
  - econometria
  - mestrado/ppgeco
aliases:
  - Econometria I — repositório
---

# Econometria I: estudo para a P1

Material de estudo de **Econometria I** (PECO-5021/6021, Prof. Edson Zambon Monte, PPGEco/UFES, 2026/2). Livro-base: Greene, *Econometric Analysis*. A preparação mira a **P1 de 02/10/2026**. Tem três objetivos:

- **demonstrar** tudo o que cai na prova (rotas escalar, matricial e assintótica, com cada passo justificado);
- **interpretar outputs** no formato do professor (tabela NLOGIT/LIMDEP e diagnósticos do `ivreg` do R);
- **conferir tudo em R**: identidades algébricas testadas, números da Lista 1 reproduzidos, erros da chave apontados.

As notas são Markdown compatível com o Obsidian (abra **a raiz do repositório** como cofre) e também renderizam no GitHub.

> [!IMPORTANT]
> **Material de terceiros fica fora do git**
> Livros, slides, listas, chave e provas moram em `materiais/`, que está no `.gitignore`: o repositório é público. As notas citam esses materiais por id (`SL07`, `lista1.pdf`, `P1-25`). Ver [MATERIAIS_INDEX.md](MATERIAIS_INDEX.md).

## Início rápido

Da raiz do repositório (Windows; o R 4.6+ não precisa estar no PATH):

```powershell
powershell -ExecutionPolicy Bypass -File scripts\build.ps1
```

O `build.ps1` roda em sequência:
1. confere os pacotes;
2. roda o testthat;
3. roda todos os scripts dos módulos;
4. confere os números das notas contra o R;
5. passa o lint;
6. regenera o índice de demonstrações.

Para rodar um script isolado:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\r.ps1 02_mqo_simples\02_mqo_simples.R
```

Primeira vez nesta máquina: `scripts\r.ps1 R\00_setup.R` instala o que faltar.

## Como estudar

| Para… | Abra |
|---|---|
| Saber o que fazer hoje | [CRONOGRAMA.md](CRONOGRAMA.md) |
| Entender a lógica do plano | [PLANO_ESTUDO.md](PLANO_ESTUDO.md) |
| Revisar fórmulas | [formulario/formulario.md](formulario/formulario.md) |
| Escrever H0/H1, decisão e conclusão sem errar | [formulario/vocabulario_interpretacao.md](formulario/vocabulario_interpretacao.md) |
| Treinar no formato da prova | [provas/](provas/README.md): banco de derivações, banco de outputs, simulados |
| Achar uma demonstração | [demonstracoes/INDICE_D.md](demonstracoes/INDICE_D.md) |
| Achar um exercício da Lista 1 | [LISTA1_MAPA.md](LISTA1_MAPA.md) |
| Ver onde a chave do professor erra | [formulario/errata_chave_lista1.md](formulario/errata_chave_lista1.md) |

## Módulos da P1

| Módulo | Tema | Slides | Lista 1 |
|---|---|---|---|
| [00](00_fundamentos/README.md) | Fundamentos de probabilidade e estimadores | Greene Ap. B–D | 1–9 |
| [01](01_paradigma_projecao/README.md) | Paradigma, projeção × média condicional, hipóteses A1–A6 | SL01, SL02 | 10–12 |
| [02](02_mqo_simples/README.md) | MQO na regressão simples | SL03 | 13–22, 40 |
| [03](03_mqo_matricial/README.md) | Álgebra matricial do MQO, P e M | SL03 | 23, 24, 28–31, 34, 35 |
| [04](04_fwl_particionada/README.md) | Regressão particionada e Frisch–Waugh–Lovell | SL04 | 25 |
| [05](05_ajuste_restricoes/README.md) | Ajuste ($R^2$, $\bar R^2$, critérios de informação) e MQ restrito | SL05 | 27, 55, 56, 62 |
| [06](06_amostra_finita_multicol/README.md) | Amostra finita, Gauss-Markov, $s^2$, multicolinearidade | SL06 | 26, 32, 33, 36, 37, 53, 54, 63, 64 |
| [07](07_testes_hipoteses/README.md) | Testes de hipóteses: F, Wald, LM, LR, JB, RESET, diagnósticos | SL07 | 38, 39, 41–46, 49–52, 74 |
| [08](08_assintotica/README.md) | Assintótica: consistência, normalidade, HC0, método delta | SL08 | 73 |
| [09](09_dummies_forma_funcional/README.md) | Dummies, forma funcional, Chow, [DiD](09_dummies_forma_funcional/did.md) | SL09 | 43, 47, 48, 57–61, 71, 72 |
| [10](10_endogeneidade_iv/README.md) | Endogeneidade, VI, MQ2E, Hausman, erro de medição | SL10 | 65–70 |

As demonstrações centrais D0–D16 do primeiro mês estão em [demonstracoes/](demonstracoes/econometria-i-demonstracoes-mes-1-1.md). A P1 de 2025/2, resolvida e usada como molde da prova, está em [provas/p1_2025_2/](provas/p1_2025_2/econometria-i-prova-2025-2-resolvida.md).

**P2 (esqueletos, para depois de 02/10):**
- [11 MQG, heterocedasticidade e autocorrelação](11_mqg_heterosk_autocorr/README.md)
- [12 Painel I](12_painel_I/README.md)
- [13 Painel II](13_painel_II/README.md)
- [14 MV e escolha binária](14_mv_binarias/README.md)

## Estrutura

```text
econometrics/
├── NN_tema/            módulo: README, NN_teoria.md, NN_lista1.md, NN_tema.R, figuras/
├── demonstracoes/      núcleo D0–D16 + INDICE_D.md (gerado)
├── provas/             P1 2025/2 resolvida e reproduzida, banco de questões, simulados, log de erros
├── formulario/         formulário, vocabulário de interpretação, errata da chave
├── R/                  helpers (raiz, resultados, ols, saída no formato NLOGIT)
├── tests/testthat/     identidades algébricas e números das provas/listas
├── scripts/            r.ps1, build.ps1, run_all, check_numbers, lint, indice_D
├── resultados/         números gerados pelos scripts (conferidos contra as notas)
└── materiais/          (fora do git) livros, slides, listas, provas, texto extraído
```

Regras de escrita (notação, callouts, formato das demonstrações e dos exercícios, código R, direitos autorais) em [CONVENCOES.md](CONVENCOES.md).

## Estado atual

Build completo passando em 15/09/2026: pacotes conferidos, **82 testes** do testthat, **14 scripts** de módulo executados, **605 números** das notas conferidos contra o R, lint sem erros e índice com **105 demonstrações**.

| Módulo | Teoria | Lista 1 | Script R |
|---|---|---|---|
| 00 fundamentos | ✅ | ✅ ex. 1–9 | ✅ |
| 01 paradigma e projeção | ✅ | ✅ ex. 10–12 | ✅ |
| 02 MQO simples | ✅ D02.1–D02.16 | ✅ ex. 13–22, 40 | ✅ |
| 03 MQO matricial | ✅ | ✅ ex. 23, 24, 28–31, 34, 35 | ✅ |
| 04 FWL | ✅ D04.1–D04.6 | ✅ ex. 25 | ✅ |
| 05 ajuste e restrições | ✅ | ✅ ex. 27, 55, 56, 62 | ✅ |
| 06 amostra finita e multicolinearidade | ✅ | ✅ ex. 26, 32, 33, 36, 37, 53, 54, 63, 64 | ✅ |
| 07 testes de hipóteses | ✅ D07.1–D07.7 | ✅ ex. 41–46, 49–52 + computacional 38, 39, 74 | ✅ |
| 08 assintótica | ✅ D08.1–D08.6 | ✅ ex. 73 | ✅ |
| 09 dummies, forma funcional, DiD | ✅ D09.1–D09.9 | ✅ ex. 43, 47, 48, 57–61, 71, 72 | ✅ |
| 10 endogeneidade e VI | ✅ D10.1–D10.11 | ✅ ex. 65–70 | ✅ |
| 11–14 (P2) | esqueleto | mapa da Lista 2 | — |

Provas: [P1 2025/2 resolvida e reproduzida em R](provas/p1_2025_2/econometria-i-prova-2025-2-resolvida.md), [banco de derivações](provas/banco/derivacoes.md) com 36 itens, [banco de interpretação](provas/banco/interpretacao.md) com 12 blocos e **três simulados completos** com gabarito e rubrica ([01](provas/simulados/simulado_01.md), [02](provas/simulados/simulado_02.md), [03](provas/simulados/simulado_03.md)).

Dois achados que valem nota e estão registrados na [errata](formulario/errata_chave_lista1.md): a chave inverte a decisão do RESET no ex. 50, e a matriz de correlação do ex. 64 é matematicamente impossível (autovalor negativo).
