---
title: "Módulo 07 — Lista 1 computacional (ex. 38, 39 e 74)"
modulo: "07"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
greene: "cap. 4; cap. 5; cap. 9; cap. 20"
slides: "SL06, SL07"
lista1: [38, 39, 74]
relevancia_p1: alta
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
  - Testes — Lista 1 computacional
---

# Módulo 07 — Lista 1 computacional (ex. 38, 39 e 74)

Os três exercícios que pedem software. Tudo é reproduzido em [07_computacional.R](07_computacional.R), com os dados da lista embutidos no script. A teoria dos testes está em [07_teoria.md](07_teoria.md).

---

## Ex. 38 — Vendas de cabos telefônicos (1993–2008)

**Tipo:** computacional · **Chave:** ⏳ · **Cai como:** base das questões de interpretação

Dezesseis observações anuais. $Y$ = vendas (milhões de metros); $X_1$ = novas moradias (milhares); $X_2$ = taxa de desemprego (%); $X_3$ = taxa de juros (%); $X_4$ = % de aumento das linhas; $X_5$ = PIB (milhões de US\$).

**(a) e (b) Regressão completa e sinais esperados.**

| Variável | Coeficiente | Erro padrão | $t$ | $p$ | Sinal esperado | Bate? |
|---|---|---|---|---|---|---|
| Constante | 5825,77 | 2402,26 | 2,425 | 0,036 | — | — |
| $X_1$ novas moradias | 2,6347 | 0,9789 | 2,692 | 0,023 | + (mais construção, mais cabo) | sim |
| $X_2$ desemprego | −792,04 | 193,83 | −4,086 | 0,002 | − (atividade fraca, menos demanda) | sim |
| $X_3$ juros | 59,91 | 153,98 | 0,389 | 0,705 | − (juro alto trava investimento) | não, mas é insignificante |
| $X_4$ % aumento de linhas | −813,69 | 275,66 | −2,952 | 0,014 | + (mais linhas, mais cabo) | não |
| $X_5$ PIB | 4,0599 | 2,9194 | 1,391 | 0,194 | + | sim |

$R^2=0{,}8253$; $\bar R^2=0{,}7379$; erro-padrão da regressão 623,11; $SQR=3\,882\,676$; $F(5,10)=9{,}447$ ($p=0{,}0015$).

**(c) Testes a 10%.** Global: $F=9{,}447 \gt F_{5;10;0,10}=2{,}522$ ⇒ a regressão é conjuntamente significativa. Individuais, contra $t_{10;0,05}=1{,}812$: significativos $X_1$, $X_2$ e $X_4$; não significativos $X_3$ e $X_5$.

Mantendo só os significativos, a equação reestimada tem $\bar R^2=0{,}5016$ — **queda** em relação a 0,7379, e $SQR$ sobe para 8.859.545. O teste conjunto de exclusão de $X_3$ e $X_5$ dá $F=6{,}409$ contra $F_{2;10;0,10}=2{,}924$: **rejeita-se** a exclusão. Ou seja, apesar dos $t$ individuais baixos, as duas variáveis contribuem em conjunto — sintoma clássico de multicolinearidade (item i).

**(d) Interpretação.** Mil moradias novas a mais elevam as vendas em 2,63 milhões de metros; um ponto percentual a mais de desemprego reduz as vendas em 792 milhões de metros; um ponto a mais no crescimento de linhas está associado a 814 milhões a menos (sinal contraintuitivo, provavelmente por colinearidade com o PIB e o desemprego).

**(e) $R^2$ e $\bar R^2$.** 82,5% da variação das vendas é explicada; ajustando pelos graus de liberdade (só 10 sobram), 73,8%. A diferença é grande porque há 6 parâmetros para 16 observações. O $R^2$ nunca cai com mais regressores; o ajustado pode cair — e cai aqui quando se removem variáveis úteis.

**Conferência numérica**

| chave_R | nota |
|---|---|
| m07a_ex38_b2 | 2,6347 |
| m07a_ex38_b3 | -792,04 |
| m07a_ex38_t3 | -4,0862 |
| m07a_ex38_r2 | 0,82528 |
| m07a_ex38_r2adj | 0,73792 |
| m07a_ex38_F | 9,4467 |
| m07a_ex38_Fcrit10 | 2,5216 |
| m07a_ex38_tcrit10 | 1,8125 |
| m07a_ex38r_r2adj | 0,50164 |
| m07a_ex38_Fconj | 6,4091 |

## Ex. 39 — Diagnósticos do mesmo modelo

**Tipo:** computacional · **Chave:** ⏳ · **Cai como:** bateria de testes

> [!NOTE]
> **Erro de digitação no enunciado**
> A equação do item (f) repete o termo $\beta_2X_1$. Trata-se do mesmo modelo do ex. 38; seguimos com os cinco regressores.

**(g) RESET.**

```text
Hipóteses:   H0: modelo corretamente especificado   vs   H1: má especificação
Estatística: F = 0,1311 (2 e 8 gl), p = 0,8790
Decisão:     0,1311 < 3,113 = F crítico a 10%   ⇒   não se rejeita H0
Conclusão:   não há evidência de má especificação (forma funcional ou variável omitida).
```

**(h) Matriz de correlação.** Os pares mais fortes são juros e % de linhas ($-0{,}800$) e desemprego com PIB ($0{,}727$). O determinante da matriz de correlação é 0,00538 (perto de zero) e o número de condição, 65,9: indícios de colinearidade relevante.

**(i) Fontes e consequências da multicolinearidade.** Fontes: variáveis que compartilham tendência comum (PIB, desemprego e juros movem-se juntos no ciclo), amostra pequena, especificação com proxies do mesmo conceito. Consequências: os estimadores continuam **não viesados e MELNV**, mas as variâncias explodem — $t$ pequenos, $F$ grande, sinais instáveis e sensibilidade a pequenas mudanças na amostra. Foi o que apareceu no ex. 38.

**(j) e (k) Regressões auxiliares e FIV.**

| Regressor | $R^2$ auxiliar | $F$ | FIV |
|---|---|---|---|
| $X_1$ moradias | 0,8315 | 13,571 ($p=0{,}00031$) | 5,935 |
| $X_2$ desemprego | — | — | 4,292 |
| $X_3$ juros | — | — | **18,107** |
| $X_4$ % linhas | — | — | 4,899 |
| $X_5$ PIB | — | — | 9,457 |

Para $X_1$, a 10%: $F=13{,}571$ contra $F_{crit}\approx 3{,}36$ ⇒ rejeita-se $H_0$ de que $X_1$ não é explicada pelas demais — há colinearidade. Pelo FIV, o caso grave é o dos **juros** (18,1 > 10), seguido do PIB (9,5).

**(l) Autocorrelação.**

```text
Durbin-Watson
Hipóteses:   H0: ρ = 0   vs   H1: ρ ≠ 0
Estatística: d = 2,4207  (n = 16, k' = 5)
Decisão:     d > 2 ⇒ lado negativo. Com dL = 0,562 e dU = 2,220 (α = 10%, bilateral por
             conveniência), 4 − dU = 1,780 e 4 − dL = 3,438; como 1,780 < 2,4207 < 3,438,
             o teste cai na região INCONCLUSIVA/limítrofe.
Conclusão:   o DW não permite decidir; recorra ao Breusch-Godfrey.

Breusch-Godfrey
Hipóteses:   H0: sem autocorrelação até a ordem p   vs   H1: há autocorrelação
Ordem 1:     LM = 2,002 (p = 0,157)            ⇒ não rejeita a 10%
Ordem 2:     LM = 7,030 (p = 0,0297)           ⇒ rejeita a 10% e a 5%
Ordem 3:     LM = 10,364 (p = 0,0157)          ⇒ rejeita
Conclusão:   há indício de autocorrelação de ordem superior a 1. A escolha de p deve seguir
             o critério de informação; com p = 2 já se rejeita a ausência de autocorrelação.
```

**(m) e (n) White.** Passos: (1) estimar o modelo e obter $\hat u$; (2) regredir $\hat u^2$ nos regressores, seus quadrados e produtos cruzados; (3) calcular $nR^2 \sim \chi^2$ com graus de liberdade iguais ao número de regressores da auxiliar; (4) rejeitar indica heterocedasticidade.

Aqui aparece o limite prático: a versão **completa** exigiria 21 parâmetros para 16 observações (posto 16) — impossível. Usando a versão só com quadrados: $nR^2=5{,}650$ ($p=0{,}342$) ⇒ **não se rejeita** homocedasticidade. Com quadrados e produtos cruzados parciais, $nR^2=14{,}009$ ($p=0{,}173$) ⇒ mesma conclusão.

**Conferência numérica**

| chave_R | nota |
|---|---|
| m07a_ex39_reset_F | 0,13110 |
| m07a_ex39_reset_p | 0,87898 |
| m07a_ex39_r_x3_x4 | -0,79972 |
| m07a_ex39_r_x2_x5 | 0,72657 |
| m07a_ex39_kappa | 65,870 |
| m07a_ex39_fiv_3 | 18,107 |
| m07a_ex39_fiv_5 | 9,4571 |
| m07a_ex39_aux_F_1 | 13,571 |
| m07a_ex39_dw | 2,4207 |
| m07a_ex39_bg1_LM | 2,0025 |
| m07a_ex39_bg2_LM | 7,0299 |
| m07a_ex39_bg2_pLM | 0,029749 |
| m07a_ex39_white_q_LM | 5,6495 |
| m07a_ex39_white_q_p | 0,34183 |

## Ex. 74 — Regressão múltipla livre

**Tipo:** computacional · **Chave:** ➖

Escolha justificada: equação de salários com `wooldridge::wage1` ($n=526$), tema do curso e do molde da prova.

$$\ln(\text{salário})=\beta_1+\beta_2\,educ+\beta_3\,exper+\beta_4\,exper^2+\beta_5\,tenure+\beta_6\,female+\beta_7\,married+u$$

| Variável | Coeficiente | $t$ | Leitura |
|---|---|---|---|
| educ | 0,079832 | 11,693 | cada ano de estudo: +7,98% (exato 8,31%) |
| exper | 0,030100 | 5,796 | perfil côncavo com o quadrado |
| exper² | −0,00060115 | −5,472 | máximo em torno de 25 anos |
| tenure | 0,016074 | 5,581 | +1,61% por ano na firma |
| female | −0,291130 | −8,024 | mulheres ganham 29,1% menos (exato −25,3%) |

$R^2=0{,}4361$; $\bar R^2=0{,}4296$; $F=66{,}906$.

**Interpretação.** Todos os coeficientes são significativos a 1% e têm os sinais da teoria de capital humano. O termo quadrático confirma a concavidade do perfil experiência-salário. O diferencial por sexo é grande e persiste mesmo controlando educação, experiência e tempo de casa — é a versão do curso do "gap de gênero condicional". O modelo explica 43,6% da variação do log-salário, ajuste típico de microdados.

**Conferência numérica**

| chave_R | nota |
|---|---|
| m07a_ex74_n | 526 |
| m07a_ex74_b_educ | 0,079832 |
| m07a_ex74_t_educ | 11,693 |
| m07a_ex74_b_female | -0,29113 |
| m07a_ex74_r2 | 0,43614 |
| m07a_ex74_r2adj | 0,42962 |
| m07a_ex74_F | 66,906 |
