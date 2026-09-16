---
title: "Banco de interpretação de outputs"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
relevancia_p1: alta
status: rascunho
verificacao:
  numerica: ok
tags:
  - econometria
  - mestrado/ppgeco
  - p1
  - prova
aliases:
  - Banco de interpretação
---

# Banco de interpretação de outputs

Doze blocos no formato da Q1 e da Q2 da prova. Todos os outputs foram **gerados pelo nosso R** (`gerar_outputs.R`) e estão em [outputs/](outputs/), no mesmo layout NLOGIT que o professor usa. Abra o arquivo indicado, responda no papel e só então confira.

O padrão de resposta está em [vocabulario_interpretacao.md](../../formulario/vocabulario_interpretacao.md): **hipóteses, estatística, decisão, conclusão**.

---

## Bloco 1 — Equação de salários de Cornwell-Rupert

**Output:** [outputs/psid_mqo.txt](outputs/psid_mqo.txt) — é o mesmo da P1 2025/2 ($n=4165$).

**Perguntas.** (a) Com $n=4165$, é necessário testar normalidade dos resíduos? (b) Teste ED com $z=1{,}96$. (c) Após quantos anos de EXP o log-salário é máximo? (d) IC de 95% para ED. (e) Interprete SOUTH e BLK, em aproximação e de forma exata. (f) Interprete o $\bar R^2$. (g) Qual a elasticidade do salário em relação a semanas trabalhadas, na média?

**Respostas.** (a) Não: pelo TLC a inferência é assintótica; a coluna do output já traz $P[\lvert Z\rvert\gt z]$. (b) $t=22{,}05\gt 1{,}96$: significativa; cada ano de estudo vale +6,11% (exato 6,30%). (c) $-a_3/(2a_4)=30{,}31$ anos; depois disso o salário cai. (d) $[0{,}0557;\ 0{,}0665]$. (e) SOUTH $-7{,}63\%$ (exato $-7{,}35\%$); BLK $-26{,}27\%$ (exato $-23{,}10\%$) — note que a diferença entre aproximado e exato **cresce** com o tamanho do coeficiente. (f) $\bar R^2=0{,}3432$: 34,3% da variação do log-salário, corrigido por graus de liberdade. (g) Elasticidade-semanas na média: $0{,}00484\times 46{,}81=0{,}2267$.

| chave_R | nota |
|---|---|
| bnc_psid_ed_exato | 6,3035 |
| bnc_psid_blk_exato | -23,102 |
| bnc_psid_elast_wks | 0,226654 |
| bnc_psid_r2_cabecalho | 0,344607 |

## Bloco 2 — Salários com dummies de sexo e sindicato

**Output:** [outputs/psid_mqo_fem_union.txt](outputs/psid_mqo_fem_union.txt)

**Perguntas.** (a) Interprete os coeficientes de FEM e UNION, de forma exata. (b) Teste a significância conjunta das duas dummies. (c) O que muda no coeficiente de ED ao incluí-las?

**Respostas.** (a) e (b) conferidas no script: as duas dummies são individualmente significativas e o $F$ conjunto rejeita a nulidade; sindicalizados ganham mais e mulheres, menos, controlando educação e experiência. (c) O coeficiente de ED muda pouco, sinal de que as dummies são quase ortogonais à educação — compare com o viés de omissão do ex. 15.

## Bloco 3 — Salários no CPS 1985

**Output:** [outputs/cps_mqo.txt](outputs/cps_mqo.txt) e [outputs/cps_testes.txt](outputs/cps_testes.txt)

É a Q1 do [Simulado 01](../simulados/simulado_01.md) — resolva lá, com gabarito e rubrica.

## Bloco 4 — Quebra estrutural por sexo (Chow via interação)

**Output:** [outputs/cps_chow_genero.txt](outputs/cps_chow_genero.txt)

**Perguntas.** (a) Monte o teste de Chow com as duas somas de quadrados impressas. (b) Qual a conclusão a 5%? (c) Por que a versão com interações é mais informativa?

**Respostas.** Com $SQR_R=113{,}0924$ (modelo sem FEM e sem interações, 4 parâmetros) e $SQR_{IR}=102{,}0724$ (8 parâmetros, $n=534$): $J=4$, $F=\frac{(113{,}0924-102{,}0724)/4}{102{,}0724/526}=14{,}19$, muito acima de $F_{4;526;0,05}\approx 2{,}39$ ⇒ rejeita-se a ausência de quebra. A versão interagida ainda diz **onde** está a diferença: no intercepto (FEM) e no retorno da educação (FEM·ED).

## Bloco 5 — Preço de imóveis

**Output:** [outputs/hprice_mqo.txt](outputs/hprice_mqo.txt) e [outputs/hprice_testes.txt](outputs/hprice_testes.txt) ($n=88$)

**Perguntas.** (a) Interprete o coeficiente de `sqrft` em modelo log-log. (b) Teste $H_0:\beta_{sqrft}=1$ (elasticidade unitária) a 5%. (c) Construa o IC de 95%. (d) O que dizem JB, RESET, Breusch-Pagan e White?

**Respostas.** (a) Elasticidade: 1% a mais de área eleva o preço em 0,700%. (b) $t=(0{,}7002-1)/0{,}09287=-3{,}228$, e $\lvert-3{,}228\rvert\gt 1{,}989$ ⇒ **rejeita-se** a elasticidade unitária. (c) $[0{,}5156;\ 0{,}8849]$, que não contém 1 — mesma conclusão. (d) JB $=34{,}889$ ($p\lt 0{,}0001$): rejeita normalidade, mas com $n=88$ a inferência assintótica segue de pé; RESET $=2{,}565$ ($p=0{,}0831$): não rejeita a 5%, rejeitaria a 10%; BP $=4{,}223$ ($p=0{,}238$) e White $=9{,}549$ ($p=0{,}388$): não há evidência de heterocedasticidade.

| chave_R | nota |
|---|---|
| bnc_hp_b_sqrft | 0,700232 |
| bnc_hp_t_sqrft_1 | -3,2280 |
| bnc_hp_ic_sqrft_inf | 0,515560 |
| bnc_hp_ic_sqrft_sup | 0,884905 |
| bnc_hp_jb | 34,889 |
| bnc_hp_reset | 2,5650 |
| bnc_hp_bp | 4,2232 |
| bnc_hp_white | 9,5494 |

## Bloco 6 — Função consumo agregada (série temporal)

**Output:** [outputs/consumo_anual.txt](outputs/consumo_anual.txt) ($n=44$)

**Perguntas.** (a) Interprete a propensão marginal a consumir em log-log. (b) Teste se a elasticidade é 1. (c) Mostre que $t^2=F$ e que $F$ sai do $R^2$. (d) Há autocorrelação? Use DW e Breusch-Godfrey.

**Respostas.** (a) Elasticidade-renda do consumo: 0,99497 — praticamente unitária. (b) $t=(0{,}99497-1)/0{,}0079534=-0{,}6327$, contra $t_{crit}=2{,}018$: **não** se rejeita elasticidade unitária. (c) $t^2=15\,650=F$, e $F$ reconstruído do $R^2$ dá o mesmo. (d) DW $=0{,}5208$, muito abaixo de $d_L$: autocorrelação positiva forte ($\hat\rho\approx 0{,}74$); BG de ordem 1 dá $22{,}44$ ($p\lt 0{,}0001$), confirmando. Consequência: os erros-padrão do output estão subestimados, e a inferência acima precisa de correção (P2).

| chave_R | nota |
|---|---|
| bnc_cons_b | 0,994968 |
| bnc_cons_t_elast1 | -0,632659 |
| bnc_cons_t2 | 15650,0 |
| bnc_cons_F_de_r2 | 15650,0 |
| bnc_cons_dw | 0,520771 |
| bnc_cons_rho_dw | 0,739614 |
| bnc_cons_bg1 | 22,438 |

## Bloco 7 — Função de produção estadual e retornos de escala

**Output:** [outputs/produc_1986.txt](outputs/produc_1986.txt) e [outputs/produc_1986_restrito.txt](outputs/produc_1986_restrito.txt)

**Perguntas.** (a) Interprete as elasticidades de capital e trabalho. (b) Teste retornos constantes de escala com as duas somas de quadrados. (c) Refaça pelo $t$ da soma, usando a covariância. (d) O modelo passa nos diagnósticos?

**Respostas.** (a) $\hat\beta_K=0{,}2889$ e $\hat\beta_L=0{,}7575$: 1% a mais de capital eleva o produto em 0,289%; de trabalho, 0,758%. (b) $SQR_R=0{,}289559$ e $SQR_{IR}=0{,}217166$, com $J=1$: $F=14{,}667$ ($p=0{,}0004$) contra $F_{crit}=4{,}062$ ⇒ **rejeita-se** retornos constantes. (c) Soma $=1{,}0465$ com erro-padrão $0{,}0121$ (usando $\operatorname{Var}(\hat\beta_K)+\operatorname{Var}(\hat\beta_L)+2\operatorname{Cov}$), logo $t=3{,}830$ e $t^2=14{,}67=F$: retornos **crescentes**. (d) RESET $1{,}617$ ($p=0{,}211$), BP $4{,}372$ ($p=0{,}224$), White $10{,}912$ ($p=0{,}282$), JB $0{,}944$ ($p=0{,}624$): passa em todos.

| chave_R | nota |
|---|---|
| bnc_crs86_ssr_u | 0,217166 |
| bnc_crs86_ssr_r | 0,289559 |
| bnc_crs86_F | 14,667 |
| bnc_crs86_soma | 1,04646 |
| bnc_crs86_ep_soma | 0,0121322 |
| bnc_crs86_t | 3,8298 |
| bnc_crs86_jb | 0,943735 |

## Bloco 8 — Quebra estrutural entre dois anos

**Output:** [outputs/produc_chow.txt](outputs/produc_chow.txt)

**Perguntas.** (a) Teste de Chow entre 1970 e 1986 a 5%. (b) Onde está a quebra?

**Respostas.** $SQR_R=0{,}941691$ (empilhado) contra $SQR_{IR}=0{,}819875$ (interagido): $F=3{,}269$ ($p=0{,}0151$) contra $F_{crit}=2{,}475$ ⇒ **rejeita-se** a estabilidade. O coeficiente da dummy de período é 0,649 e a interação com capital tem $t=-1{,}812$: a mudança é sobretudo de nível, com indício de alteração no retorno do capital.

| chave_R | nota |
|---|---|
| bnc_pchow_ssr_r | 0,941691 |
| bnc_pchow_ssr_u | 0,819875 |
| bnc_pchow_F | 3,2687 |
| bnc_pchow_p | 0,015082 |

## Bloco 9 — Demanda por cigarros com VI (o quadro da prova)

**Output:** [outputs/cig_ivreg_robusto.txt](outputs/cig_ivreg_robusto.txt), [outputs/cig_ivreg_classico.txt](outputs/cig_ivreg_classico.txt) e [outputs/cig_mqo.txt](outputs/cig_mqo.txt)

**Perguntas.** (a) Qual a endógena e quais os instrumentos? (b) Os três testes, a 5% **e** a 10%. (c) Compare o coeficiente do preço com o do MQO. (d) O que muda entre a versão robusta e a clássica?

**Respostas.** Resolvidas em detalhe no [módulo 10](../../10_endogeneidade_iv/10_lista1.md), ex. 67. Em resumo: endógena é $\log(\text{preço})$; instrumentos, a diferença de impostos e o imposto real. Instrumentos fortes ($F=228{,}7$); Wu-Hausman $p=0{,}0569$ — rejeita a 10%, **não** rejeita a 5%; Sargan $p=0{,}5641$, instrumentos válidos. MQO dá $-1{,}4065$ contra $-1{,}2774$ do MQ2E. Sem erros robustos, o $F$ de instrumentos fracos vira 244,7 e o Wu-Hausman, $p=0{,}0868$.

## Bloco 10 — Retornos da escolaridade com VI (Mroz)

**Output:** [outputs/mroz_mq2e.txt](outputs/mroz_mq2e.txt), [outputs/mroz_mqo.txt](outputs/mroz_mqo.txt) e [outputs/mroz_ivreg_fatheduc.txt](outputs/mroz_ivreg_fatheduc.txt)

É a Q2 do [Simulado 01](../simulados/simulado_01.md). O arquivo com um único instrumento (`fatheduc`) serve para o contraste: caso exatamente identificado, **sem** teste de Sargan.

## Bloco 11 — Retornos da escolaridade com proximidade de faculdade (Card)

**Output:** [outputs/card_mq2e.txt](outputs/card_mq2e.txt) e [outputs/card_mqo.txt](outputs/card_mqo.txt)

**Perguntas.** (a) Qual a lógica do instrumento? (b) Compare MQO e MQ2E. (c) O que o teste de instrumentos fracos indica?

**Respostas.** A proximidade de uma faculdade na juventude afeta a escolaridade (relevância) e, supõe-se, não afeta o salário por outro canal (exogeneidade — discutível, e é essa a crítica usual). Como em Mroz, o MQ2E tende a dar retorno **maior** que o MQO aqui, o que inverte a leitura simples de viés de habilidade e costuma ser atribuído a efeito de tratamento heterogêneo. Os valores exatos estão no output e no `resultados/bnc.csv`.

## Bloco 12 — Multicolinearidade extrema

**Output:** [outputs/cps_multicol.txt](outputs/cps_multicol.txt)

**Perguntas.** (a) O que acontece ao incluir simultaneamente idade, educação e experiência? (b) Leia os $t$ e o $F$. (c) Qual o FIV?

**Respostas.** Como experiência é construída a partir de idade e educação, as três são quase linearmente dependentes ($r_{age,exp}=0{,}978$). O resultado é o retrato da multicolinearidade: nenhum $t$ é significativo ($t_{ED}=1{,}561$, $t_{EXP}=0{,}812$, $t_{AGE}=-0{,}700$), mas o $F$ global é 48,99 e o modelo explica 27% da variação. O FIV de idade é **4623** e o de educação, 230; o erro-padrão de ED passa de 0,00799 (sem as colineares) para 0,1137 — catorze vezes maior.

| chave_R | nota |
|---|---|
| bnc_vif_cor_age_exp | 0,977961 |
| bnc_vif_age | 4623,49 |
| bnc_vif_ed | 230,224 |
| bnc_vif_se_ed | 0,113712 |
| bnc_vif_se_ed_curto | 0,00799421 |
| bnc_vif_t_ed | 1,56061 |
| bnc_vif_F | 48,989 |

---

## Como treinar

1. Faça **um bloco por dia** a partir de 20/09, sempre escrevendo as quatro linhas de cada teste.
2. Cronometre: cada bloco deve sair em 12 a 15 minutos — é o tempo real da Q1 na prova.
3. Erros vão para o [log](../log_erros.md) com a causa (não sabia a fórmula, li o output errado, inverti a hipótese nula).

> [!TIP]
> **O erro mais caro é ler o output errado**
> Antes de calcular qualquer coisa, localize no cabeçalho: $n$, número de parâmetros, graus de liberdade, $SQR$, $R^2$ e o $F$ global. Com esses seis números você reconstrói quase tudo o que a prova pede.
