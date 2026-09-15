---
title: "Índice de materiais (locais, fora do git)"
tags:
  - econometria
  - meta
aliases:
  - Materiais
---

# Índice de materiais

Os PDFs ficam em `materiais/`, que é **ignorada pelo git** (repositório público). Este índice dá o id de cada material, o caminho local e a referência. O texto extraído (`pdftotext -layout -enc UTF-8`) fica em `materiais/_txt/<nome>.txt`. Ele serve para buscar, mas perde símbolos matemáticos. Para fórmulas e tabelas, abra o PDF.

## Slides do professor (Econometrics I, baseados no curso do Greene na NYU Stern)

| Id | Arquivo local | Tema | Greene | Págs. | Prova |
|---|---|---|---|---|---|
| SL01 | `materiais/slides/sl01_paradigma.pdf` | Paradigma, construção de modelos, inferência | cap. 1 | 20 | P1 |
| SL02 | `materiais/slides/sl02_projecao_regressao.pdf` | Relações estatísticas, projeção × média condicional, MRL | caps. 2 e 4 | 33 | P1 |
| SL03 | `materiais/slides/sl03_algebra_mqo.pdf` | Álgebra de MQ: equações normais, CSO, *residual maker* | cap. 3 | 28 | P1 |
| SL04 | `materiais/slides/sl04_regressao_parcial_fwl.pdf` | Regressão particionada, Frisch–Waugh–Lovell, efeitos fixos | cap. 3 | 23 | P1 |
| SL05 | `materiais/slides/sl05_ajuste_mq_restrito.pdf` | $\min e'e$, incluir e excluir variáveis, $R^2$, $\bar R^2$, critérios de informação, MQ restrito | caps. 3 e 5 | 45 | P1 |
| SL06 | `materiais/slides/sl06_amostra_finita_multicol.pdf` | Não-viés, variância, Gauss-Markov, $s^2$, multicolinearidade, componentes principais | cap. 4 | 63 | P1 |
| SL07 | `materiais/slides/sl07_testes_hipoteses.pdf` | Hipótese linear geral, F, Wald, LM, LR, normalidade, modelos não aninhados | caps. 5 e 14 | 66 | P1 |
| SL08 | `materiais/slides/sl08_assintotica.pdf` | Consistência, distribuição assintótica, covariância robusta, bootstrap | cap. 4 | 29 | P1 |
| SL09 | `materiais/slides/sl09_dummies.pdf` | Dummies, interações, forma funcional, DiD, RD, Chow | cap. 6 | 50 | P1 |
| SL10 | `materiais/slides/sl10_endogeneidade_iv.pdf` | Endogeneidade, VI, MQ2E, testes de endogeneidade | cap. 8 | 46 | P1 |
| SL11 | `materiais/slides/sl11_mqg_heterosk_autocorr.pdf` | Modelo de regressão generalizado, heterocedasticidade, autocorrelação, MQG | caps. 9 e 20 | 49 | P2 |
| SL12 | `materiais/slides/sl12_painel_I.pdf` | Painel I: pooled, primeiras diferenças, efeitos fixos, within | cap. 11 | 46 | P2 |
| SL13 | `materiais/slides/sl13_painel_II.pdf` | Painel II: efeitos aleatórios, Hausman, Mundlak, painel dinâmico | cap. 11 | 29 | P2 |
| SL14 | `materiais/slides/sl14_mv_binarias.pdf` | Máxima verossimilhança, probit/logit, efeitos marginais | caps. 14 e 17 | 46 | P2 |

## Listas, chave e provas

| Id | Arquivo local | Conteúdo |
|---|---|---|
| L1 | `materiais/listas/lista1.pdf` | Lista 1: 74 exercícios, conteúdo da P1. Mapa em [LISTA1_MAPA.md](LISTA1_MAPA.md) |
| L1K | `materiais/listas/lista1_chave.pdf` | Chave de correção da Lista 1 (34 págs.). **Tem erros**: ver [errata](formulario/errata_chave_lista1.md) |
| L2 | `materiais/listas/lista2.pdf` | Lista 2: 57 exercícios, conteúdo da P2 |
| P1-25 | `materiais/provas/p1_2025_2_pag1.png` | Foto da pág. 1 da 1ª prova de 2025/2 (03/10/2025). Resolução completa em [provas/p1_2025_2](provas/p1_2025_2/econometria-i-prova-2025-2-resolvida.md) |
| P2-24 | `materiais/provas/p2_2024_2.pdf` | 2ª prova de 2024/2 (29/11/2024), em scan de celular |

## Livros

| Id | Arquivo local | Referência |
|---|---|---|
| GRE-AP | `materiais/livros/greene_apendices.pdf` | GREENE, W. H. *Econometric Analysis*. Apêndices A–E: álgebra matricial, probabilidade, amostragem, assintótica, otimização |
| HAY | `materiais/livros/hayashi_2000.pdf` | HAYASHI, F. *Econometrics*. Princeton University Press, 2000 |
| WOO | `materiais/livros/wooldridge_5e.pdf` | WOOLDRIDGE, J. M. *Introductory Econometrics: A Modern Approach*. 5ª ed. |
| SW | `materiais/livros/stock_watson_2010.pdf` | STOCK, J. H.; WATSON, M. W. *Introduction to Econometrics*. Addison-Wesley, 2010 (escaneado, sem texto) |

O livro-texto do curso é o Greene (2017/2018, 7ª/8ª ed.). Aqui só temos os apêndices. As seções do corpo do livro são citadas pelos slides, que seguem a numeração dele.
