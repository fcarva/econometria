---
title: "Plano de estudo — Econometria I (P1)"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
prova-1: 2026-10-02
tags:
  - econometria
  - mestrado/ppgeco
  - p1
aliases:
  - Plano Econometria I
---

# Plano de estudo — Econometria I

## Objetivo

Chegar em **02/10/2026** capaz de fazer duas coisas sob pressão:

1. **Demonstrar** no papel, sem consulta, qualquer resultado do MQO nas três rotas — escalar, matricial e assintótica — com cada passo justificado por uma hipótese.
2. **Ler um output** no formato do professor (NLOGIT ou `ivreg` do R) e escrever hipóteses, estatística, decisão e conclusão em quatro linhas.

Tudo o mais no repositório existe para servir a esses dois objetivos.

## Escopo

| | Conteúdo | Situação |
|---|---|---|
| **P1 (02/10)** | slides SL01 a SL10, Lista 1 inteira (ex. 1–74), molde da P1 2025/2 | módulos [00](00_fundamentos/README.md) a [10](10_endogeneidade_iv/README.md) |
| **P2 (depois)** | MQG, heterocedasticidade, autocorrelação, painel, máxima verossimilhança e escolha binária; Lista 2 | esqueletos [11](11_mqg_heterosk_autocorr/README.md) a [14](14_mv_binarias/README.md) |

## Como cada módulo funciona

Sempre a mesma sequência, na ordem:

1. **`NN_teoria.md`** — mapa do módulo, hipóteses, demonstrações numeradas (`DNN.k`), "como cai na prova", armadilhas e checklist.
2. **`NN_lista1.md`** — os exercícios da Lista 1 daquele módulo, resolvidos no formato e no tamanho da prova.
3. **`NN_tema.R`** — o script que confere cada número citado na nota e gera as figuras.
4. **Checklist** no fim da teoria — só marque quando conseguir reproduzir **sem olhar**.

As demonstrações centrais do primeiro mês (D0 a D16) estão em [demonstracoes/](demonstracoes/econometria-i-demonstracoes-mes-1-1.md), escritas antes do repositório; os módulos referenciam em vez de repetir. O [índice de demonstrações](demonstracoes/INDICE_D.md) lista todas, geradas e antigas.

## Rotina diária sugerida

| Bloco | Duração | O que fazer |
|---|---|---|
| Aquecimento | 15 min | refazer de cabeça duas demonstrações antigas (revisão espaçada) |
| Núcleo | 90 min | teoria do dia + as demonstrações novas, escrevendo no papel |
| Aplicação | 60 min | exercícios da lista do módulo + um output do [banco](provas/banco/interpretacao.md) |
| Fecho | 15 min | atualizar o [log de erros](provas/log_erros.md) e marcar o checklist |

O calendário completo está em [CRONOGRAMA.md](CRONOGRAMA.md).

## Materiais de apoio

| Recurso | Para quê |
|---|---|
| [formulario/formulario.md](formulario/formulario.md) | todas as fórmulas, por módulo |
| [formulario/vocabulario_interpretacao.md](formulario/vocabulario_interpretacao.md) | H0, decisão e frase de conclusão de cada teste |
| [formulario/errata_chave_lista1.md](formulario/errata_chave_lista1.md) | onde a chave do professor erra |
| [LISTA1_MAPA.md](LISTA1_MAPA.md) | de qual módulo é cada um dos 74 exercícios |
| [provas/](provas/README.md) | banco de questões, três simulados e a P1 2025/2 reproduzida |
| [MATERIAIS_INDEX.md](MATERIAIS_INDEX.md) | onde está cada PDF (fora do git) |

## Verificação

O repositório se autoverifica. Da raiz:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\build.ps1
```

- `check_numbers.R` compara **cada número citado nas notas** com o valor gravado pelos scripts em `resultados/`. Divergência é erro de build.
- `lint_repo.R` confere frontmatter, callouts que o GitHub renderiza, links, aliases, ids de demonstração e, principalmente, que nenhum material de terceiros foi versionado ou copiado.
- `indice_D.R` regenera o índice de demonstrações.

## Instruções para o agente

Se um agente (ou você mesmo, em outra sessão) for continuar este repositório:

1. **Leia [CONVENCOES.md](CONVENCOES.md) primeiro.** Ele é o contrato: notação, frontmatter, os cinco callouts permitidos, o padrão `DNN.k` das demonstrações, o formato dos exercícios e as regras de código R.
2. **Nunca copie** enunciado, chave, slide ou livro. Parafraseie em uma linha e cite pela referência (`SL07`, `Lista 1, ex. 33`, `Greene §5.3`). O lint rejeita 12 palavras seguidas iguais às dos materiais.
3. **Todo número citado vem do R.** Registre com `registrar()` no script do módulo e cite na nota dentro de uma tabela `chave_R | nota`. Rode `check_numbers.R` antes de considerar a tarefa pronta.
4. **Demonstração é passo a passo com justificativa.** Cada linha algébrica indica a hipótese (`[A3]`) ou a regra usada. Confira as dimensões das matrizes. Antecipe como o professor pode torcer o enunciado.
5. **Não duplique D0–D16**: referencie e complemente.
6. **`materiais/` nunca entra no git.** Antes de qualquer commit, rode o lint; antes de qualquer push, confira `git ls-files`.
7. **Ao terminar um módulo**, atualize o status no frontmatter (`status`, `verificacao`) e o [LISTA1_MAPA.md](LISTA1_MAPA.md).

## Depois da P1

1. Reabrir os esqueletos 11 a 14 e repetir o processo com a Lista 2 e a [P2 2024/2](provas/p2_2024_2/mapa.md).
2. Trazer o painel para o terreno da dissertação: [did.md](09_dummies_forma_funcional/did.md) já faz a ponte entre DiD, efeitos fixos e VI.
3. Manter o hábito do log de erros — ele é o que transforma simulado em nota.
