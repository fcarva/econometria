---
title: "Didática — a camada visual e metafórica"
disciplina: Econometria I (PECO-5021/6021)
relevancia_p1: alta
status: rascunho
tags:
  - econometria
  - mestrado/ppgeco
  - didatica
aliases:
  - Didática
---

# Didática

O resto do repositório prova. Esta pasta **faz ver**. São dezesseis figuras no padrão editorial (paleta Flexoki, exportação em PNG e SVG), cada uma acompanhada de uma metáfora — e do ponto exato em que a metáfora deixa de valer.

| Arquivo | Conteúdo |
|---|---|
| [intuicao_visual.md](intuicao_visual.md) | a galeria comentada: o que olhar, a metáfora, onde ela quebra, e o link para o módulo |
| [didatica.R](didatica.R) | gera as 16 figuras e registra os números citados (id `dtc`) |
| [figuras/](figuras/) | PNG para leitura rápida, SVG para imprimir ou projetar sem perder qualidade |

## Bancada interativa

O que a figura estática não faz: **[Bancada de Regressão](https://claude.ai/artifact/SP86pYTZzigmoEDA5YZ8ee)** — três experimentos em que você mexe e os números reagem na hora.

| Experimento | O que testar |
|---|---|
| 1 · A reta e os resíduos | arraste um ponto para longe na horizontal e veja a alavancagem disparar; ligue os quadrados para entender por que o MQO odeia erro grande |
| 2 · Viés de variável omitida | zere a separação entre grupos **ou** o efeito do grupo: o viés some nos dois casos, porque ele é o produto $\beta_3\hat\delta$ |
| 3 · Erro de medição e instrumento | aumente o ruído e veja o MQO escorregar para zero enquanto o MQ2E resiste; enfraqueça o instrumento e veja o erro-padrão explodir |

## Por que metáfora com fronteira

Uma analogia boa faz o conceito grudar; uma analogia solta cria erro conceitual difícil de desfazer. "O instrumento é uma peneira" ajuda — até a pessoa achar que basta ter um instrumento qualquer. Por isso toda entrada da galeria termina em **onde quebra**: é ali que mora a diferença entre intuição e rigor.

## Regenerar as figuras

```bash
powershell -ExecutionPolicy Bypass -File scripts\r.ps1 didatica\didatica.R
```

O estilo compartilhado está em [R/estilo_grafico.R](../R/estilo_grafico.R): paleta, tema, título editorial com fonte e observação, e `salvar_figura()`, que exporta PNG e SVG de uma vez. Qualquer figura nova do repositório deve usá-lo.

## Convenções visuais

| Elemento | Regra |
|---|---|
| Fundo | papel Flexoki, sem moldura, sem grade vertical |
| Título | frase afirmativa que **conclui** algo, não rótulo do gráfico |
| Subtítulo | a leitura que o título não cabe |
| Rodapé | `Fonte:` sempre; `Obs.:` quando houver ressalva |
| Cores | verde-azulado = o resultado correto · laranja = a comparação · vermelho = o problema · amarelo = o ponto de atenção |
| Anotação | em itálico, dentro da figura, apontando o que olhar |
