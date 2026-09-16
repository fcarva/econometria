---
title: "Convenções do repositório"
tags:
  - econometria
  - meta
aliases:
  - Convenções
---

# Convenções do repositório

Contrato para quem escreve aqui, você ou um agente. Tudo o que é novo segue estas regras. As notas antigas, anteriores ao repositório (as de `demonstracoes/`, `02_mqo_simples/mqo-*.md` e `provas/p1_2025_2/`), ficam como estão.

---

## 1. Estrutura e ids

| Pasta | Conteúdo | id dos scripts |
|---|---|---|
| `NN_tema/` (00–10) | `README.md` (hub), `NN_teoria.md`, `NN_lista1.md`, `NN_tema.R`, `figuras/` | `m00` … `m10` |
| `07_testes_hipoteses/` | também `07_lista1_computacional.md` e `07_computacional.R` | `m07a` (computacional), `m07b` (resto) |
| `provas/` | banco de questões, simulados, reprodução das provas, `gerar_outputs.R` | `prv` |
| `R/` | helpers: `raiz.R`, `resultados.R`, `ols.R`, `saida_nlogit.R` | — |
| `tests/testthat/` | testes das identidades algébricas e dos números | — |
| `scripts/` | `r.ps1`, `build.ps1`, `run_all.R`, `check_numbers.R`, `lint_repo.R`, `indice_D.R` | — |
| `materiais/` | **fora do git**: livros, slides, listas, chave, provas, `_txt/` | — |

Nomes de arquivo: ASCII, minúsculas, sem espaço nem acento.

Ids dos slides: `SL01` … `SL14`. Arquivos em `materiais/slides/`, texto em `materiais/_txt/`. Ver [MATERIAIS_INDEX.md](MATERIAIS_INDEX.md).

## 2. Notação

A notação base é a do **Greene**, também usada nos slides.

**Matricial:**
- $y$ é $n\times 1$; $X$ é $n\times K$, **com** a coluna de 1s; $\beta$ é $K\times 1$; $\varepsilon$ é $n\times 1$.
- Estimador de MQO: $b=(X'X)^{-1}X'y$. Resíduos: $e=y-Xb$.
- $P=X(X'X)^{-1}X'$, $M=I-P$, $M^0=I-\tfrac1n\iota\iota'$.
- $s^2=e'e/(n-K)$ e $Q=\operatorname{plim} X'X/n$.

**Escalar (notação da Lista 1):**
- $Y_i=\beta_1+\beta_2X_i+u_i$, com **$\beta_1$ = intercepto**.
- Desvios: $x_i=X_i-\bar X$ e $y_i=Y_i-\bar Y$.
- $S_{XX}=\sum x_i^2$ e pesos $k_i=x_i/S_{XX}$. Resíduos: $\hat u_i$.

Nas questões de prova, preservar a notação do enunciado ($a_1,a_2,\dots$; $\varepsilon$; $\mu$).

**Hipóteses do Greene.** Nos passos de uma demonstração, citar entre colchetes, por exemplo *[A3]*.

| Id | Hipótese |
|---|---|
| A1 | Linearidade: $y=X\beta+\varepsilon$ |
| A2 | Posto completo: $\operatorname{posto}(X)=K$ |
| A3 | Exogeneidade: $E[\varepsilon\mid X]=0$ |
| A4 | Erros esféricos: $E[\varepsilon\varepsilon'\mid X]=\sigma^2I$ (homocedasticidade e ausência de autocorrelação) |
| A5 | $X$ gerado independentemente do processo de $\varepsilon$ (fixo ou aleatório) |
| A6 | Normalidade: $\varepsilon\mid X\sim N(0,\sigma^2I)$ |

**Graus de liberdade.**
- Greene: $n-K$, com $K$ incluindo a constante.
- Wooldridge: $n-k-1$, o mesmo número, com $k$ inclinações.
- Lista: $n-2$ na regressão simples.
- Deixar explícito qual convenção está em uso.

## 3. Frontmatter

Arquivos de módulo e de prova:

```yaml
---
title: "Módulo 07 — Testes de hipóteses"
modulo: "07"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
greene: "cap. 5 (5.1–5.6); 14.6"
slides: "SL07"
lista1: [41, 42, 44]
relevancia_p1: alta        # alta | media | baixa
status: rascunho           # rascunho | verificado
verificacao:
  derivacao: pendente      # pendente | ok | corrigir
  numerica: pendente
  chave: pendente
tags:
  - econometria
  - mestrado/ppgeco
  - p1
aliases:
  - Testes de hipóteses
---
```

Aliases são **únicos** no repositório. Eles fazem funcionar os wikilinks antigos:

| Alias | Arquivo |
|---|---|
| `Lista 1` | `LISTA1_MAPA.md` |
| `Plano Econometria I` | `PLANO_ESTUDO.md` |
| `DiD` | `09_dummies_forma_funcional/did.md` |
| `Frisch-Waugh-Lovell` | `04_fwl_particionada/04_teoria.md` |
| `Variáveis instrumentais` e `MQ2E` | `10_endogeneidade_iv/10_teoria.md` |

## 4. Callouts: só os 5 tipos que o GitHub renderiza

Nos arquivos novos, use **somente** `NOTE`, `TIP`, `IMPORTANT`, `WARNING` e `CAUTION`. O Obsidian renderiza os mesmos cinco. Outros tipos (`abstract`, `success`, `todo`…) aparecem como texto cru no GitHub.

```markdown
> [!NOTE]
> **O que se quer provar**
> Texto do callout, com $\hat\beta$ inline.
```

Regras:
- O marcador fica **sozinho** na linha. O título vai em negrito na linha seguinte.
- Sem `-` ou `+` de dobra e sem callout aninhado.
- Matemática em bloco (cifrão duplo) de preferência **fora** do callout.

| Tipo | Uso |
|---|---|
| `NOTE` | enunciado, "o que se quer provar", mapa do módulo |
| `TIP` | como escrever na prova, macete, "como o professor pode torcer" |
| `IMPORTANT` | resultado-chave que precisa sair de cabeça |
| `WARNING` | armadilha conceitual ou de conta |
| `CAUTION` | divergência ou erro na chave do professor, ou número que muda entre versões da prova |

## 5. Matemática

- Fórmula no meio da frase entre cifrões simples; fórmula em bloco entre cifrões duplos, em linhas próprias, com linha em branco antes e depois.
- Dinheiro: escrever `R\$` (senão o `$` abre matemática).
- Dentro de tabela: nada de `|` na matemática; use `\mid`, `\lvert`, `\rvert`, `\lVert`.
- Sinal de menor seguido de letra: use `\lt`.
- Vírgula decimal: no texto `0,05`; na matemática `0{,}05`.
- Vetores e matrizes sem negrito obrigatório. Transposta com `'`. Esperança condicional como $E[\cdot\mid X]$.

## 6. Demonstrações (padrão D)

- **D0–D16** são o núcleo já escrito em `demonstracoes/econometria-i-demonstracoes-mes-1-1.md`. **Não duplicar:** referenciar ("ver D9") e só acrescentar o que falta.
- Demonstrações novas usam o namespace do módulo: `D02.1`, `D02.2`, …, `D10.4`.
- Cabeçalho exato, que o `indice_D.R` lê: `### D07.3 · Título curto`

Estrutura de cada D:

````markdown
### D07.3 · Estatística F a partir do R²

> [!NOTE]
> **O que se quer provar**
> Enunciado limpo, com as hipóteses usadas.

**Por que importa.** De onde vem, para onde vai, onde cai na prova.

**Passo a passo.**

1. Frase dizendo o que se faz. *[A3]*

$$ \dots $$

2. …

$$\boxed{\text{resultado}}$$

> [!TIP]
> **Como o professor pode torcer**
> Variações prováveis e o que muda na resposta.
````

Regras:
- Cada linha algébrica tem justificativa: hipótese, propriedade de $E$, $\operatorname{Var}$, traço ou plim, ou identidade anterior.
- Conferir a dimensão das matrizes em todo produto.

## 7. Exercícios da Lista 1 (`NN_lista1.md`)

````markdown
## Ex. 15 — Viés de variável omitida na regressão simples

**Tipo:** derivação · **Chave:** ✅ confere · **Cai como:** Q4 da P1 2025/2

**Resolução.** …

> [!TIP]
> **Como escrever na prova**
> Versão curta que vale nota cheia: hipóteses → passos → conclusão.

**Conferência numérica** (só se houver número)

| chave_R | nota |
|---|---|
| m02_ex40_b1 | 0,4656 |
````

- **Enunciado: nunca copiar.** Use título-paráfrase de uma linha e, se preciso, 1–2 frases próprias descrevendo o que é pedido.
- Os dados numéricos (tabelas de observações) ficam no script R, com a fonte citada.

**Status em relação à chave:**

| Símbolo | Significado |
|---|---|
| ✅ | confere |
| ⚠️ | diverge, com explicação |
| ❌ | chave errada (vai para a errata) |
| ➖ | chave sem resposta, só remete a livro |
| ⏳ | não conferido |

**Tabela `chave_R | nota`.** O `scripts/check_numbers.R` compara a coluna `nota` com o valor em `resultados/*.csv`.
- A tolerância é meia unidade da última casa decimal escrita.
- Escreva o número sem separador de milhar. A vírgula decimal é aceita.

## 8. Código R

- **Só R.** Rodar sempre via `powershell -ExecutionPolicy Bypass -File scripts\r.ps1 <arquivo.R>`, a partir de qualquer pasta. O `r.ps1` entra na raiz do repositório.
- Topo obrigatório de todo script:

```r
# --- bootstrap: localizar a raiz do repo e carregar helpers ---
.d <- getwd(); while (!file.exists(file.path(.d, ".repo-root")) && dirname(.d) != .d) .d <- dirname(.d)
source(file.path(.d, "R", "raiz.R"))
```

- **Resultados:** `registrar("m02_ex40_b1", b[2])` e, no fim, `gravar_resultados("m02")`. As chaves são globais, prefixadas pelo id do script.
- `set.seed()` antes de qualquer simulação.
- Rodar sem internet e sem `materiais/`: dados embutidos no script ou vindos de pacotes (`AER`, `wooldridge`).
- Pacotes permitidos: `AER` (`ivreg`, `PSID7682`, `CigarettesSW`, `CPS1985`), `lmtest`, `car`, `sandwich`, `tseries`, `moments`, `MASS`, `wooldridge`, `plm`, `testthat`, `ggplot2`.
- **Figuras:** gráficos base do R em `NN_tema/figuras/*.png`, com `png(w = 1600, h = 1000, res = 200)`. Títulos em português. Sem imagem de terceiros.
- Seções do script por exercício (`## ---- Ex. 40 ----`), comentadas em pt-BR. O script precisa terminar com status 0.
- Arquivos de texto em UTF-8 sem BOM.

## 9. Direitos autorais (repositório público)

- Proibido copiar trechos de slides, listas, chave, provas ou livros. O lint rejeita qualquer sequência de 12 palavras idêntica às de `materiais/_txt/`.
- Citar pela referência: "Greene, 8ª ed., §4.3", "SL06, p. 12", "Lista 1, ex. 33".
- Nada de `materiais/` entra no git. As notas mencionam arquivos por id (`SL07`, `lista1.pdf`), nunca pelo nome original.

## 10. Links

- Nos arquivos novos, links relativos em Markdown, que funcionam no GitHub e no Obsidian, no formato `[D06.2]` seguido do caminho relativo entre parênteses. Cite o D pelo id no texto; não confie em âncoras.
- Wikilinks `[[...]]` só existem nas notas antigas e resolvem pelos aliases da §3.

## 11. Modelo de resposta de teste (vale ponto na prova)

```text
Hipóteses:  H0: a3 = 0  (EXP não afeta LWAGE)   vs   H1: a3 ≠ 0
Estatística: t = b/E.p. = 18,677  (≈ N(0,1) com n = 4165)
Decisão:    |18,677| > 1,96 = z crítico (α = 5%)  ⇒  rejeita-se H0   [ou: p = 0,0000 < 0,05]
Conclusão:  EXP é estatisticamente significativo; mais experiência está associada a maior salário.
```

Sempre as quatro linhas. A decisão pode vir pelo valor crítico **ou** pelo p-valor, com o α que o enunciado der. **Decida pelo número impresso no enunciado:** o professor reaproveita outputs e troca os p-valores entre versões.
