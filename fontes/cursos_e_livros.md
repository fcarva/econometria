---
title: "Cursos e livros: onde ler cada módulo em nível de doutorado"
disciplina: Econometria I (PECO-5021/6021)
periodo: 2026/2
relevancia_p1: media
status: rascunho
tags:
  - econometria
  - mestrado/ppgeco
  - fontes
aliases:
  - Cursos e livros
  - Leituras
---

# Cursos e livros

Duas perguntas práticas: **nos livros que você já tem, qual seção cobre cada módulo?** E, fora deles, **quais materiais abertos de nível de doutorado valem o tempo?** Links conferidos em 17/09/2026.

## Os livros de `materiais/`, módulo a módulo

O Greene é o livro do curso; os slides seguem a numeração dele. O Hayashi é a referência de doutorado mais próxima do nível da prova; o Wooldridge e o Stock-Watson servem para intuição e exemplos.

| Módulo | Greene (via slides) | Hayashi (2000) | Wooldridge (5ª ed.) | Stock-Watson |
|---|---|---|---|---|
| [00](../00_fundamentos/README.md) fundamentos | apêndices A–D | 2.1 | apêndices B e C | caps. 2 e 3 |
| [01](../01_paradigma_projecao/README.md) paradigma e projeção | caps. 1, 2 e 4 | 1.1 e 2.9 | cap. 1 | cap. 4 |
| [02](../02_mqo_simples/README.md) MQO simples | cap. 3 | 1.2 | cap. 2 | caps. 4, 5 e 17 |
| [03](../03_mqo_matricial/README.md) matricial | cap. 3 | 1.2 | apêndice E | cap. 18 |
| [04](../04_fwl_particionada/README.md) FWL | cap. 3 | 1.2 | 3.2 ("partialling out") | — |
| [05](../05_ajuste_restricoes/README.md) ajuste e restrições | caps. 3 e 5 | 1.4 | 6.3 | cap. 7 |
| [06](../06_amostra_finita_multicol/README.md) amostra finita | cap. 4 | 1.3 | 3.3 a 3.5 | caps. 6 e 18 |
| [07](../07_testes_hipoteses/README.md) testes | caps. 5 e 14 | 1.4, 2.4, 2.7 e 2.10 | cap. 4, 8.3 e 9.1 | cap. 7 |
| [08](../08_assintotica/README.md) assintótica | cap. 4 | 2.1 a 2.6 | cap. 5 e 8.2 | caps. 17 e 18 |
| [09](../09_dummies_forma_funcional/README.md) dummies e DiD | cap. 6 | — | cap. 7, 6.2 e 13.2 | caps. 8 e 13 |
| [10](../10_endogeneidade_iv/README.md) endogeneidade e VI | cap. 8 | 3.1 a 3.9 | 9.4, caps. 15 e 16 | cap. 12 |

As seções do Hayashi e do Wooldridge foram tiradas dos sumários dos PDFs. As do Stock-Watson seguem a estrutura de capítulos da 2ª e da 3ª edição, porque o PDF é escaneado e o sumário não pôde ser extraído.

> [!TIP]
> **O Hayashi no nível da prova**
> Quatro seções do Hayashi valem mais que capítulos inteiros de outros livros. A **1.2** traz a álgebra de MQ com $P$ e $M$. A **2.9** é a projeção linear, o paradigma do SL02. A **3.1** estuda o viés de endogeneidade com o exemplo de Working (curvas de oferta e demanda). A **3.9** aplica VI ao retorno à escolaridade, o mesmo problema de Card na [nota de fontes](fontes_primarias.md#módulo-10-endogeneidade-e-variáveis-instrumentais).

## Cursos abertos

| Curso | O que tem | Para quais módulos |
|---|---|---|
| **Stanford — STATS 305A, *Linear Models (and more)***, Art Owen · [notas](https://artowen.su.domains/courses/305a/) | notas próprias de mínimos quadrados (com SVD) e de regressão múltipla; o programa também cobre regularização e bootstrap. O curso se apresenta como o **último** curso de modelos lineares, não o primeiro | 03, 04, 06 |
| **MIT 14.381, *Statistical Method in Economics*** (2018) · [OCW](https://ocw.mit.edu/courses/14-381-statistical-method-in-economics-fall-2018/) | notas de aula de teoria estatística: distribuições, teoremas-limite, inferência, testes | 00, 07, 08 |
| **MIT 14.382, *Econometrics*** (2017), Victor Chernozhukov · [OCW](https://ocw.mit.edu/courses/14-382-econometrics-spring-2017/) | notas (com Iván Fernández-Val), dados e código; inclui notas do 14.381 e avança para modelos de alta dimensão | 08, 10 e além |
| **Stanford — ECON 270, 271 e 272** | a sequência de econometria do primeiro ano do doutorado; o catálogo descreve regressão linear, inferência e métodos causais (VI, RD, matching), mas as notas não são públicas | referência de escopo |

## Livros de nível de doutorado fora de `materiais/`

| Livro | Acesso | Por que |
|---|---|---|
| Hansen, B. E. *Econometrics*. Princeton University Press, 2022 · [site](https://users.ssc.wisc.edu/~bhansen/econometrics/) | pago; o site tem dados e programas | o manual de doutorado mais próximo do Greene em rigor, e mais moderno: começa por média condicional e projeção (o módulo 01). O volume anterior da série é *Probability and Statistics for Economists* |
| Chernozhukov, Hansen, Kallus, Spindler e Syrgkanis. *Applied Causal Inference Powered by ML and AI* · [site](https://causalml-book.org/) · [arXiv:2403.02467](https://arxiv.org/abs/2403.02467) | aberto | leva o FWL (módulo 04) até o *double machine learning*: o "partialling out" com milhares de controles |
| Cunningham, S. *Causal Inference: The Mixtape*. Yale University Press, 2021 · [versão web](https://mixtape.scunning.com/) | aberto | DiD e VI com código e as histórias dos artigos da [nota de fontes](fontes_primarias.md) |
| Huntington-Klein, N. *The Effect*. Chapman & Hall · [versão web](https://theeffectbook.net/) | aberto | desenho de pesquisa com diagramas causais; bom para a parte conceitual do módulo 10 |
| Angrist, J. D.; Pischke, J.-S. *Mostly Harmless Econometrics*. Princeton University Press, 2009 | pago | os teoremas da função de esperança condicional: por que a regressão é a melhor aproximação linear da média condicional |
| Goldberger, A. S. *A Course in Econometrics*. Harvard University Press, 1991 | pago | a sátira da micronumerosidade e a abordagem pela média condicional que inspirou os livros seguintes |

## Como estes materiais foram levantados

- **Referências:** cada artigo com DOI foi conferido na API pública do Crossref (título, periódico, volume, número e páginas). A lista gerada fica em [referencias.md](referencias.md) e o BibTeX em [referencias.bib](referencias.bib), pronto para importar no Zotero.
- **Literatura recente:** a busca em índices de artigos (arXiv) trouxe dois achados que entraram na nota: Basu (2023), que propõe o nome Yule-Frisch-Waugh-Lovell, e Ding (2021), o FWL para erros-padrão.
- **Sumários:** os capítulos do Hayashi e do Wooldridge vêm do texto extraído dos PDFs locais, que ficam fora do git.
