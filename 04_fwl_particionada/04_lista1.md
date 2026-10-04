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

**O que se pede.** O modelo verdadeiro é $\mathbf y=\mathbf X_1\beta_1+\mathbf X_2\beta_2+\varepsilon$, mas estima-se apenas $\widehat{\mathbf y}=\mathbf X_1\mathbf b_1$, com $\mathbf b_1=(\mathbf X_1'\mathbf X_1)^{-1}\mathbf X_1'\mathbf y$. O estimador $\mathbf b_1$ é viciado?

**Resposta: sim, em geral.**

**Passo a passo.**

1. Substitua o modelo **verdadeiro** dentro do estimador curto:
$$\mathbf b_1=(\mathbf X_1'\mathbf X_1)^{-1}\mathbf X_1'\big(\mathbf X_1\beta_1+\mathbf X_2\beta_2+\varepsilon\big).$$

2. Distribua, usando $(\mathbf X_1'\mathbf X_1)^{-1}\mathbf X_1'\mathbf X_1=\mathbf I$:
$$\mathbf b_1=\beta_1+(\mathbf X_1'\mathbf X_1)^{-1}\mathbf X_1'\mathbf X_2\,\beta_2+(\mathbf X_1'\mathbf X_1)^{-1}\mathbf X_1'\varepsilon .$$

3. Tome a esperança condicional em $\mathbf X$; o último termo morre por exogeneidade *[H2]*:
$$\boxed{E(\mathbf b_1\mid \mathbf X)=\beta_1+(\mathbf X_1'\mathbf X_1)^{-1}\mathbf X_1'\mathbf X_2\,\beta_2 .}$$

4. O **viés** é $(\mathbf X_1'\mathbf X_1)^{-1}\mathbf X_1'\mathbf X_2\beta_2$. A matriz $\mathbf P_{12}=(\mathbf X_1'\mathbf X_1)^{-1}\mathbf X_1'\mathbf X_2$ é exatamente a matriz de coeficientes das regressões auxiliares de cada coluna de $\mathbf X_2$ sobre $\mathbf X_1$: ela mede **quanto de $\mathbf X_2$ está embutido em $\mathbf X_1$**.

**Quando o viés desaparece.**

| Condição | Leitura |
|---|---|
| $\beta_2=0$ | o bloco omitido era irrelevante; omiti-lo não custa nada |
| $X_1'X_2=0$ | blocos ortogonais na amostra: $X_1$ não carrega informação de $X_2$ |

**Sinal do viés.** No caso de uma variável omitida, o viés é $\beta_2\widehat\delta$, com $\widehat\delta$ o coeficiente da auxiliar. Ele é positivo quando $\beta_2$ e $\widehat\delta$ têm o mesmo sinal (por exemplo: habilidade eleva o salário e é positivamente correlacionada com escolaridade ⇒ o retorno da escolaridade é superestimado).

> [!TIP]
> **Como escrever na prova**
> Três linhas de álgebra, o quadro do viés e **uma frase** dizendo quando ele é zero. Se sobrar tempo, acrescente que a versão escalar é o ex. 15 e que a variância da regressão curta é **menor** — o clássico dilema viés-variância.

**Relação com o resto do módulo.** O complemento de D04.4 é o teorema de Frisch-Waugh-Lovell (D04.2): ele mostra que o coeficiente **longo** $b_2$ é o da regressão entre as partes limpas, e que o coeficiente **curto** difere justamente pelo que $X_1$ e $X_2$ compartilham.

<!-- conferência numérica: valores conferidos contra resultados/*.csv pelo scripts/check_numbers.R — (equação de salários, `AER::PSID7682`)
| chave_R | nota |
|---|---|
| m04_pc_r2_curta | 0,267917 |
| m04_pc_r2_longa | 0,344607 |
| m04_pc_queda_ssr | 68,0168 |
| m04_psid_b_ed | 0,0611277 |
-->
