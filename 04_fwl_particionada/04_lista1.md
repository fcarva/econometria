---
title: "Módulo 04 — Lista 1 resolvida (ex. 25)"
modulo: "04"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
greene: "cap. 3 (§3.3–3.5)"
slides: "SL04"
lista1: [25]
relevancia_p1: media
status: rascunho
verificacao:
  derivacao: pendente
  numerica: ok
  chave: pendente
tags:
  - econometria
  - mestrado/ppgeco
  - p1
aliases:
  - FWL — Lista 1
---

# Módulo 04 — Lista 1 resolvida

## Ex. 25 — Viés por omissão no modelo particionado

**Tipo:** derivação · **Chave:** ➖ · **Cai como:** Q4, versão matricial

**O que se pede.** O modelo verdadeiro é $y=X_1\beta_1+X_2\beta_2+\varepsilon$, mas estima-se apenas $\hat y=X_1b_1$, com $b_1=(X_1'X_1)^{-1}X_1'y$. O estimador $b_1$ é viciado?

**Resposta: sim, em geral.**

**Passo a passo.**

1. Substitua o modelo **verdadeiro** dentro do estimador curto:
$$b_1=(X_1'X_1)^{-1}X_1'\big(X_1\beta_1+X_2\beta_2+\varepsilon\big).$$

2. Distribua, usando $(X_1'X_1)^{-1}X_1'X_1=I$:
$$b_1=\beta_1+(X_1'X_1)^{-1}X_1'X_2\,\beta_2+(X_1'X_1)^{-1}X_1'\varepsilon .$$

3. Tome a esperança condicional em $X$; o último termo morre por exogeneidade *[A3]*:
$$\boxed{E[b_1\mid X]=\beta_1+(X_1'X_1)^{-1}X_1'X_2\,\beta_2 .}$$

4. O **viés** é $(X_1'X_1)^{-1}X_1'X_2\beta_2$. A matriz $P_{12}=(X_1'X_1)^{-1}X_1'X_2$ é exatamente a matriz de coeficientes das regressões auxiliares de cada coluna de $X_2$ sobre $X_1$: ela mede **quanto de $X_2$ está embutido em $X_1$**.

**Quando o viés desaparece.**

| Condição | Leitura |
|---|---|
| $\beta_2=0$ | o bloco omitido era irrelevante; omiti-lo não custa nada |
| $X_1'X_2=0$ | blocos ortogonais na amostra: $X_1$ não carrega informação de $X_2$ |

**Sinal do viés.** No caso de uma variável omitida, o viés é $\beta_2\hat\delta$, com $\hat\delta$ o coeficiente da auxiliar. Ele é positivo quando $\beta_2$ e $\hat\delta$ têm o mesmo sinal (por exemplo: habilidade eleva o salário e é positivamente correlacionada com escolaridade ⇒ o retorno da escolaridade é superestimado).

> [!TIP]
> **Como escrever na prova**
> Três linhas de álgebra, o quadro do viés e **uma frase** dizendo quando ele é zero. Se sobrar tempo, acrescente que a versão escalar é o ex. 15 e que a variância da regressão curta é **menor** — o clássico dilema viés-variância.

**Relação com o resto do módulo.** O complemento de D04.4 é o teorema de Frisch-Waugh-Lovell (D04.2): ele mostra que o coeficiente **longo** $b_2$ é o da regressão entre as partes limpas, e que o coeficiente **curto** difere justamente pelo que $X_1$ e $X_2$ compartilham.

**Conferência numérica** (equação de salários, `AER::PSID7682`)

| chave_R | nota |
|---|---|
| m04_pc_r2_curta | 0,267917 |
| m04_pc_r2_longa | 0,344607 |
| m04_pc_queda_ssr | 68,0168 |
| m04_psid_b_ed | 0,0611277 |
