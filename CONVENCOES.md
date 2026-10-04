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

A notação é a **do professor**, tirada da Lista 1 v.1 e da sua chave (`materiais/listas/lista1_v1*.pdf`), que seguem o Greene. Quando a lista e o Greene divergem, vale a lista: foi escrita junto com a prova. O `scripts/lint_repo.R` recusa as formas da coluna "não usar".

**Escalar (seções 1, 3 e 4 da lista):**

| Objeto | Escrever | Não usar |
|---|---|---|
| Modelo simples | $Y_i=\beta_1+\beta_2X_i+u_i$, com **$\beta_1$ = intercepto** | $\beta_0$ para o intercepto |
| FRP e FRA | $E(Y\mid X_i)=\beta_1+\beta_2X_i$ e $\widehat Y_i=\widehat\beta_1+\widehat\beta_2X_i$ | |
| Estimadores, ajustados, resíduos | $\widehat\beta_2$, $\widehat Y_i$, $\widehat u_i$ (chapéu largo) | `\hat` |
| Desvios em relação à média | $x_i=X_i-\bar X$ e $y_i=Y_i-\bar Y$ | |
| Somas de quadrados de $X$ | $S_{XX}=\sum_{i=1}^n(X_i-\bar X)^2$ | |
| Pesos do estimador linear | $w_i=(X_i-\bar X)/S_{XX}$, com $\widehat\beta_2=\beta_2+\sum w_iu_i$ | $k_i$ |
| Esperança, variância, covariância | $E(\cdot)$, $\operatorname{Var}(\cdot)$, $\operatorname{Cov}(\cdot,\cdot)$, **com parênteses**: $E(u_i\mid X_i)=0$ | $E[\cdot]$ |
| Erro-padrão | $ep(\widehat\beta_2)$ | E.p., se |
| Elasticidade | $\eta=\dfrac{dY}{dX}\cdot\dfrac{X}{Y}$ | |

**Matricial (seções 2, 3, 4, 7 e 9):** vetores e matrizes em **negrito**; $\beta$ e $\varepsilon$ ficam sem negrito, como na lista.

| Objeto | Escrever |
|---|---|
| Modelo | $\mathbf y=\mathbf X\beta+\varepsilon$, com $\mathbf y$ $(n\times 1)$, $\mathbf X$ $(n\times K)$ **com** a coluna de uns, $\beta$ $(K\times 1)$ |
| MQO e resíduos | $\mathbf b=(\mathbf X'\mathbf X)^{-1}\mathbf X'\mathbf y$ e $\mathbf e=\mathbf y-\mathbf X\mathbf b$ |
| Projeção e *residual maker* | $\mathbf P=\mathbf X(\mathbf X'\mathbf X)^{-1}\mathbf X'$, $\mathbf M=\mathbf I-\mathbf P$; partição $\mathbf X=[\mathbf X_1\ \mathbf X_2]$, $\mathbf M_1$ |
| Variância do erro | $s^2=\mathbf e'\mathbf e/(n-K)$ |
| Assintótica | $\operatorname{plim}(\mathbf X'\mathbf X/n)=\mathbf Q$, $\xrightarrow{p}$, $\xrightarrow{d}$, $\sqrt n(\mathbf b-\beta)\xrightarrow{d}N(\mathbf 0,\sigma^2\mathbf Q^{-1})$ |
| Restrições lineares | $\mathbf R\beta=\mathbf r$, com $q$ restrições; MQ restrito $\mathbf b_R$ (não $Rb-q$, $J$ ou $b_*$) |
| Variáveis instrumentais | $\widehat\beta_{IV}=(\mathbf Z'\mathbf X)^{-1}\mathbf Z'\mathbf y$, com $L$ instrumentos e $K$ regressores; no simples, $\widehat\beta_1^{IV}$ |

**Testes, como a chave escreve:**

| Objeto | Escrever | Não usar |
|---|---|---|
| Hipóteses | $H_0:\beta_2=0$ vs. $H_1:\beta_2\neq 0$ | H0/H1 sem subscrito |
| Estatística e crítico | $t_{cal}$, $t_{tab}$; $F_{cal}$, $F_{tab}(q,\,n-k)$; $\chi^2_{tab}(1)$; $nR^2_{aux}$ | "t crítico", "F crítico" |
| Decisão | "Como $\lvert t_{cal}\rvert=4{,}20>t_{tab}=2{,}101$, rejeita-se $H_0$ ao nível de 5%" | |
| Intervalo de confiança | $IC_{95\%}(\beta_2)=\widehat\beta_2\pm t_{tab}\cdot ep(\widehat\beta_2)$ | |
| Somas de quadrados | $SQT=SQE+SQR$: **E** = explicada, **R** = resíduos; $SQR_R$ e $SQR_{UR}$, $k_{UR}$ | $SQR_{IR}$ |
| Multicolinearidade | $VIF_k=1/(1-R_k^2)$ | FIV |
| Propriedade ótima | MELNV (BLUE) | |

> [!WARNING]
> **A sigla SQR muda nos ex. 41 e 42 da lista**
> Lá o enunciado chama de SQR a soma da regressão e de SQE a dos resíduos. Em todo o resto (ex. 29, 43, 45, 50, 64) é o contrário, e é o que usamos. Nas respostas, defina a sigla na primeira linha.

Nas questões de prova reproduzidas, preservar a notação do enunciado ($a_1,a_2,\dots$; $\mu$).

**Hipóteses do MRLC.** A chave v.1 (ex. 15) numera assim; nos passos de uma demonstração, cite entre colchetes, por exemplo *[H2]*. Na prova, escreva o nome junto do número ("pela exogeneidade estrita, H2").

| Id | Hipótese | Greene |
|---|---|---|
| H1 | Linearidade: $\mathbf y=\mathbf X\beta+\varepsilon$ | A1 |
| H2 | Exogeneidade estrita: $E(\varepsilon\mid\mathbf X)=\mathbf 0$ | A3 (e A5: $\mathbf X$ fixo ou independente de $\varepsilon$) |
| H3 | Posto completo: $\operatorname{posto}(\mathbf X)=K$ | A2 |
| H4 | Esfericidade: $E(\varepsilon\varepsilon'\mid\mathbf X)=\sigma^2\mathbf I_n$ (homocedasticidade e ausência de autocorrelação) | A4 |
| H5 | Normalidade (opcional): $\varepsilon\mid\mathbf X\sim N(\mathbf 0,\sigma^2\mathbf I_n)$ | A6 |

No modelo simples, a chave (ex. 3) lista as hipóteses por extenso, de (i) a (vi): linearidade, $X_i$ fixo ou independente de $u_i$, $E(u_i\mid X_i)=0$, homocedasticidade, ausência de autocorrelação e variação amostral de $X$.

> [!CAUTION]
> **O caderno de aula numera de outro jeito**
> Nas aulas de agosto (ver [caderno_aulas.md](demonstracoes/caderno_aulas.md) §2) o professor usou h1–h5 na ordem do Wooldridge: h1 parâmetros lineares, h2 amostra aleatória, h3 variação em $X$, h4 exogeneidade, h5 ausência de multicolinearidade. A chave v.1 é posterior e foi feita junto com a prova; por isso o repositório segue a chave. Escrever o nome da hipótese ao lado do número elimina a ambiguidade.

**Graus de liberdade.** Seções 1, 5 e 8 da lista: $n-k$, com $k$ parâmetros **incluindo** o intercepto ($n-2$ na simples). Seções matriciais: $n-K$, o mesmo número. Escreva "graus de liberdade" por extenso ou "gl".

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
- Vetores e matrizes **em negrito** nos trechos matriciais (`\mathbf X`, `\mathbf b`; em índice, `_{\mathbf X}`); escalares, $\beta$ e $\varepsilon$ sem negrito. Transposta com `'`. Esperança condicional como $E(\cdot\mid\mathbf X)$.
- Nada de bloco de código para resposta ou output: teste em quatro itens com matemática (§11) e output como tabela Markdown no formato da lista (§12). Bloco de código é só para código.

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

1. Frase dizendo o que se faz. *[H2]*

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

<!-- conferência numérica: valores conferidos contra resultados/*.csv pelo scripts/check_numbers.R
| chave_R | nota |
|---|---|
| m02_ex40_b1 | 0,4656 |
-->
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

**Tabela `chave_R | nota`.** O `scripts/check_numbers.R` compara a coluna `nota` com o valor em `resultados/*.csv`. A tabela fica **dentro de um comentário HTML**, como no modelo acima: é conferência, não leitura, e não aparece no GitHub, no Obsidian nem no PDF.
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
- **Estilo das figuras:** use `R/estilo_grafico.R` (paleta Flexoki, `tema_editorial()`, `titulo_editorial()` e `salvar_figura()`, que exporta PNG e SVG juntos). Título é frase que conclui algo; rodapé sempre com `Fonte:`. Ver [didatica/README.md](didatica/README.md).
- **Figuras:** gráficos base do R em `NN_tema/figuras/*.png`, com `png(w = 1600, h = 1000, res = 200)`. Títulos em português. Sem imagem de terceiros.
- Seções do script por exercício (`## ---- Ex. 40 ----`), comentadas em pt-BR. O script precisa terminar com status 0.
- Arquivos de texto em UTF-8 sem BOM.

## 9. Direitos autorais (repositório público)

- Proibido copiar trechos de slides, listas, chave, provas ou livros. O lint rejeita qualquer sequência de 12 palavras idêntica às de `materiais/_txt/`.
- Citar pela referência: "Greene, 8ª ed., §4.3", "SL06, p. 12", "Lista 1, ex. 33".
- Nada de `materiais/` entra no git. As notas mencionam arquivos por id (`SL07`, `lista1.pdf`), nunca pelo nome original.
- Artigos se citam por autor e ano no texto, como "Frisch e Waugh (1933)". Toda referência nova entra em [fontes/referencias.R](fontes/referencias.R), com o DOI conferido no Crossref, e o script regenera o `.bib` e a lista.
- Nota nova que deva ir para o PDF entra nas listas de `volume_teoria()` ou `volume_exercicios()` em [caderno/montar_caderno.R](caderno/montar_caderno.R).

## 10. Links

- Nos arquivos novos, links relativos em Markdown, que funcionam no GitHub e no Obsidian, no formato `[D06.2]` seguido do caminho relativo entre parênteses. Cite o D pelo id no texto; não confie em âncoras.
- Wikilinks `[[...]]` só existem nas notas antigas e resolvem pelos aliases da §3.

## 11. Modelo de resposta de teste (vale ponto na prova)

Quatro itens, com a matemática diagramada e as palavras da chave:

- **Hipóteses:** $H_0:a_3=0$ (EXP não afeta LWAGE) vs. $H_1:a_3\neq 0$.
- **Estatística:** $t_{cal}=b/ep=18{,}677$, aproximadamente $N(0,1)$, pois $n=4165$.
- **Decisão:** como $\lvert t_{cal}\rvert=18{,}677>t_{tab}=1{,}96$, rejeita-se $H_0$ ao nível de 5% (ou: $p=0{,}0000<0{,}05$).
- **Conclusão:** EXP é estatisticamente significativa; mais experiência está associada a salário maior.

Sempre os quatro itens. A decisão pode vir pelo valor tabelado **ou** pelo p-valor, com o nível que o enunciado der. **Decida pelo número impresso no enunciado:** o professor reaproveita outputs e troca os p-valores entre versões.

## 12. Outputs

Outputs entram como tabela Markdown no formato das tabelas da Lista 1 v.1 (ex. 44 e 77): uma linha em negrito com a variável dependente e o método, a tabela de coeficientes e, embaixo, uma linha com $n$, $K$, $R^2$, $\bar R^2$, $SQR$, erro-padrão da regressão e $F$. Diagnósticos em tabela própria.

| Variável | Coeficiente | Erro padrão | Estatística $t$ | Prob. |
|---|---|---|---|---|
| C | 0,4656190 | 0,1175147 | 3,962 | 0,0016 |

Para MQ2E, a coluna da estatística é "Valor $z$". O layout cru do NLOGIT, que a P1 2025/2 imprimiu, fica nos arquivos gerados em `provas/banco/outputs/*.txt`, para treinar a leitura.
