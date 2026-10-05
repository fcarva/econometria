---
title: "Cronograma até a P1"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
prova-1: 2026-10-09
tags:
  - econometria
  - mestrado/ppgeco
  - p1
aliases:
  - Cronograma
---

# Cronograma até a P1

## Reta final: 05 a 09/10, pela Lista 1 v.1

**Prova: sexta, 09/10, das 7h às 11h.** As aulas da semana estão marcadas como ocupadas; o estudo vai no tempo livre que sobra, com pausas e refeições respeitadas. A [Lista 1 v.1](provas/lista1_v1/README.md) é o roteiro, porque absorveu as seis questões da P1 2025/2. A ordem segue o peso na prova: em 2025, os dois outputs valeram 6,5 dos 10 pontos.

### A semana

| Dia | Manhã | Tarde | Noite |
|---|---|---|---|
| Dom 04/10 | — | — | livre: dormir cedo |
| Seg 05/10 | **Bloco 1** · 8h30–12h00 | **ocupado** · aula 14h00–16h30 | **Bloco 2** · 17h30–21h00 |
| Ter 06/10 | **Bloco 3** · 8h30–12h30 | **Bloco 4** · 13h30–18h15 (com o simulado) | **Bloco 5** · 19h30–21h00 |
| Qua 07/10 | **Bloco 6** · 8h00–9h30 · **ocupado** · aula 10h00–12h00 | **ocupado** · aula 14h00–18h00 | **Bloco 7** · 19h00–21h00 |
| Qui 08/10 | **Bloco 8** · 8h00–9h30 · **ocupado** · aula 10h00–12h00 | **Bloco 9** · 13h30–16h30 | livre: descanso, dormir até 22h |
| Sex 09/10 | **prova** · 7h00–11h00 | — | — |

São cerca de 20 horas de estudo: o grosso entre segunda e terça, revisão espaçada nas brechas de quarta e quinta.

> [!IMPORTANT]
> **O ciclo de cada demonstração**
> 1. Leia as perguntas da seção no [material socrático](provas/lista1_v1/socratico.md), tapando as respostas.
> 2. Leia o [algoritmo](provas/lista1_v1/algoritmo.md) de mesmo número.
> 3. Feche tudo e escreva a demonstração no papel, cronometrando.
> 4. Confira com o algoritmo e anote no [log de erros](provas/log_erros.md) o passo que faltou.
>
> No papel, o volume 3 do caderno (`caderno/pdf/caderno_volume3_reta_final.pdf`) já traz perguntas e algoritmo intercalados, seção por seção.

Os "§" são as seções do algoritmo e do socrático. Os "ex." são da Lista 1 v.1; as contas resolvidas estão em [novos.md](provas/lista1_v1/novos.md).

### Segunda, 05/10

**Bloco 1 · 8h30–12h00 · os dois outputs (o que mais vale)**

- [ ] **8h30–8h40 · Aquecimento.** Seção 6b da [folha de última revisão](formulario/ultima_revisao.md): $F$ por SQR, Wu-Hausman a 5%, pico do quadrático e o quadro do ex. 14.
- [ ] **8h40–9h30 · Output de MQO em log (§10).** Ciclo completo da §10. Depois os ex. 45 e 62 sem olhar: $t$ de FEMALE, $F$ de EXP e EXP², EDUC aproximado e exato, efeito marginal e pico. Meta: 12 minutos para o par, com os quatro itens em cada teste.
- [ ] **9h30–9h40 · Pausa.**
- [ ] **9h40–10h40 · Output do `ivreg` a 5% (§14, perguntas P1–P5, e §15).** Ciclo das duas seções; depois o ex. 77 inteiro em 12 minutos — endógena e instrumentos, as duas propriedades, fracos, Wu-Hausman, Sargan e a elasticidade, com o teste de $\beta=-1$. Corrija pelo [novos.md](provas/lista1_v1/novos.md).
- [ ] **10h40–10h50 · Pausa.**
- [ ] **10h50–11h45 · Contas de teste (§9).** IC e $t$ (ex. 4 e 44); $F$ por SQR (ex. 45b, 50 e 64b); $F$ pelo $R^2$ (ex. 6). Até 4 minutos cada, SQR definida na primeira linha.
- [ ] **11h45–12h00 · Fechamento.** Erros no log; 10 flashcards da seção "Testes" do [banco](provas/banco/flashcards.md).

**14h00–16h30 · ocupado (aula).**

**Bloco 2 · 17h30–21h00 · a álgebra do MQO** (com o jantar no meio)

- [ ] **17h30–18h15 · MQO escalar (§1).** Ciclo completo; depois a derivação escalar inteira de cabeça — a Q3 de 2025 —, com a meta de 10 minutos.
- [ ] **18h15–19h00 · MQO matricial (§2) e $\mathbf M$, $\mathbf P$ (§3).** $\mathbf X'\mathbf X\mathbf b=\mathbf X'\mathbf y$ com a condição de segunda ordem; $\mathbf M$ simétrica e idempotente, $\mathbf M\mathbf X=\mathbf 0$, $\mathbf X'\mathbf e=\mathbf 0$, $SQT=SQE+SQR$, $\operatorname{tr}(\mathbf M)=n-K$ (ex. 16–18, 22, 29).
- [ ] **19h00–19h45 · Jantar.**
- [ ] **19h45–20h40 · Contas à mão.** MQO matricial 3×3 e 2×2 (ex. 26 e 27), FWL com números (ex. 31), VI com somatórios (ex. 73a). Até 8 minutos cada.
- [ ] **20h40–21h00 · Revisão +0 do Bloco 1.** Refaça só os ex. 45b e 64b, sem olhar.

### Terça, 06/10

**Bloco 3 · 8h30–12h30 · amostra finita e assintótica**

- [ ] **8h30–9h30 · O pivô (§5).** Ciclo completo. De cabeça: $E(\mathbf b\mid\mathbf X)=\beta$, $\operatorname{Var}(\mathbf b\mid\mathbf X)=\sigma^2(\mathbf X'\mathbf X)^{-1}$ (ex. 35) e a versão escalar com $\operatorname{Cov}(\widehat\beta_1,\widehat\beta_2)$ (ex. 36).
- [ ] **9h30–9h40 · Pausa.**
- [ ] **9h40–10h20 · Gauss-Markov (§6).** Uma vez, inteiro (ex. 38).
- [ ] **10h20–10h50 · $E(s^2)=\sigma^2$ (§7).** O truque do traço (ex. 39).
- [ ] **10h50–11h00 · Pausa.**
- [ ] **11h00–12h15 · Assintótica (§8).** $\operatorname{plim}\mathbf b=\beta$ pelas duas rotas — Slutsky e variância que vai a zero — junto com a variância (ex. 35 com 52: a Q5 de 2025). Depois $\operatorname{plim}s^2$ e a estrita × contemporânea (ex. 54 e 56).
- [ ] **12h15–12h30 · Revisão +1 do Bloco 1.** O ex. 77 de memória, em 6 minutos.

**Bloco 4 · 13h30–18h15 · endogeneidade e simulado**

- [ ] **13h30–15h00 · Endogeneidade (§12, §13 e §14).** Simultaneidade keynesiana (ex. 71b); erro de medição em $Y$ e em $X$, com a tabela de contraste (ex. 74 e 75 — a Q4 de 2025 foi o 74); $\widehat\beta_{IV}=(\mathbf Z'\mathbf X)^{-1}\mathbf Z'\mathbf y$ pela condição de plim (ex. 73b — a Q6 de 2025). As três de cabeça.
- [ ] **15h00–15h20 · Pausa longa.** Longe da mesa.
- [ ] **15h20–17h05 · Simulado.** A [P1 2025/2](provas/p1_2025_2/econometria-i-prova-2025-2-resolvida.md) inteira, sem consulta, em 1h45. Ela está toda dentro da lista nova (Q1 ↔ ex. 45/62, Q2 ↔ 77, Q3 ↔ 2/28, Q4 ↔ 74, Q5 ↔ 35+52, Q6 ↔ 73b). Na ordem da estratégia de sexta: outputs primeiro.
- [ ] **17h05–17h45 · Correção.** Item por item, com a pontuação do [mapa da prova](provas/p1_2025_2/README.md). Marque em vermelho no log o que perdeu ponto.
- [ ] **17h45–18h15 · Os três pontos mais fracos.** Escreva-os no topo do log: eles são o conteúdo de quarta e quinta.

**Bloco 5 · 19h30–21h00 · dummies e FWL, só o essencial**

- [ ] **19h30–20h15 · Dummies, mudança estrutural e DiD (§11).** Perguntas do socrático; escreva o DiD com controles invariantes (ex. 67–68) e o $F$ de mudança estrutural (ex. 64).
- [ ] **20h15–21h00 · FWL e viés de omissão (§4).** FWL pelas equações particionadas (ex. 20) e o viés de omissão escalar (ex. 34).

### Quarta, 07/10

**Bloco 6 · 8h00–9h30 · primeiro ataque aos vermelhos**

- [ ] **8h00–9h00 · Os três pontos vermelhos do simulado.** Para cada um: ciclo da seção e reescrita de cabeça.
- [ ] **9h00–9h30 · Revisão +2 da álgebra.** O pivô e $E(s^2)$ de cabeça, sem olhar, cronometrando.

**10h00–12h00 · ocupado (aula). 14h00–18h00 · ocupado (aula).**

**Bloco 7 · 19h00–21h00 · seção 1, testes e segunda volta**

- [ ] **19h00–19h35 · Violações das hipóteses (§16).** O quadro de memória, com Breusch-Pagan e Durbin-Watson (ex. 9, 10 e 14).
- [ ] **19h35–20h05 · Testes, peças que faltam (§9).** $t^2=F$ e $F$ pelo $R^2$ (ex. 41 e 42); Wald e $W/q=F$ (ex. 49).
- [ ] **20h05–20h45 · Segunda volta nos vermelhos.** Só os que ainda não saíram de manhã.
- [ ] **20h45–21h00 · Revisão +2 dos outputs.** Flashcards de testes e de endogeneidade.

### Quinta, 08/10

**Bloco 8 · 8h00–9h30 · revisão espaçada**

- [ ] **8h00–9h00 · As três derivações que mais caem, de cabeça.** Derivação escalar (§1), variância com consistência (§5 e §8) e $\widehat\beta_{IV}$ (§14).
- [ ] **9h00–9h30 · Volume 3 do caderno.** Só as perguntas, das 16 seções, em leitura rápida.

**10h00–12h00 · ocupado (aula).**

**Bloco 9 · 13h30–16h30 · fechamento**

- [ ] **13h30–14h30 · O que ainda estiver vermelho no log.** Última reescrita.
- [ ] **14h30–15h00 · Os dois outputs, uma última vez.** Ex. 45/62 e 77, só conferindo os quatro itens de cada teste.
- [ ] **15h00–15h10 · Pausa.**
- [ ] **15h10–16h00 · Formulário de memória.** Escreva o [formulário](formulario/formulario.md) numa folha e compare. Leia a seção v.1 da [errata](formulario/errata_chave_lista1.md).
- [ ] **16h00–16h30 · Encerrar.** Leia a [folha de última revisão](formulario/ultima_revisao.md) e separe documento, calculadora, lápis e caneta. Depois disso, nada de matéria nova.

**Quinta à noite: descanso.** A prova começa às 7h: durma até as 22h.

### Sexta, 09/10 · prova, 7h–11h

- [ ] **Antes de sair.** 15 minutos com a [folha de última revisão](formulario/ultima_revisao.md), só ela.
- [ ] **7h00–7h05 · Leia a prova inteira** e marque as questões de output e o valor de cada uma.
- [ ] **Outputs primeiro.** Em 2025 eles valeram 6,5 de 10. Reserve até 1h40 para eles: quatro itens em todo teste, decisão pelo número impresso, SQR definida na primeira linha.
- [ ] **Depois as demonstrações**, das que valem mais para as que valem menos, com as hipóteses escritas pelo nome e pelo número (H1–H5 da chave) antes da álgebra.
- [ ] **Últimos 20 minutos:** releia as conclusões. Toda decisão precisa terminar numa frase com conteúdo econômico.

> [!TIP]
> **Ritmo para 4 horas**
> Dez pontos em 240 minutos dão cerca de 20 minutos por ponto, já com folga para revisar. Se uma demonstração travar por mais de 10 minutos, escreva o ponto de partida e as hipóteses, deixe espaço e siga: meia demonstração organizada vale mais do que uma página em branco.

### Se o tempo apertar

Corte nesta ordem: o Bloco 5 (§11 e §4) → as peças da §9 no Bloco 7 → Gauss-Markov (§6). Nunca corte os outputs (§10, §15), o pivô (§5), a derivação escalar (§1) nem o simulado de terça.

---

## Plano original (15/09 a 02/10)

17 dias, duas aulas pela frente (18/09 e 25/09) e dois simulados cronometrados. A regra que sustenta o plano: **revisão espaçada em +1, +3 e +7 dias**, usando os [flashcards](provas/banco/flashcards.md) — dez cartões por sessão, seis minutos. Revisar aqui significa derivar duas demonstrações de cabeça, em papel, e resolver três itens de interpretação — anotando tudo o que sair errado em [provas/log_erros.md](provas/log_erros.md).

> [!IMPORTANT]
> **A regra dos 20 minutos**
> Nenhuma demonstração pode levar mais de 20 minutos na primeira vez. Se travar, olhe o passo seguinte na nota, feche e refaça do zero. O objetivo é reconstruir, não reconhecer.

### Semana 1

- [x] **Ter 15/09 — diagnóstico.** Resolva as Q3 a Q6 da [P1 2025/2](provas/p1_2025_2/econometria-i-prova-2025-2-resolvida.md) sem consulta, cronometrando (90 min). Corrija com a nota e registre cada erro no log. É esse diagnóstico que define onde você vai gastar os 17 dias.
- [ ] **Qua 16/09 — módulo 02, MQO simples.** [Teoria](02_mqo_simples/02_teoria.md) e [lista](02_mqo_simples/02_lista1.md) (ex. 13–22 e 40). Meta: escrever D0 a D8 de cabeça. É a Q3 da prova.
- [ ] **Qui 17/09 — módulos 03 e 04.** [Matricial](03_mqo_matricial/03_teoria.md) (ex. 23, 24, 28–31, 34, 35) e [FWL](04_fwl_particionada/04_teoria.md) (ex. 25). · revisão do 02 (+1)
- [ ] **Sex 18/09 — módulo 06 + aula.** Manhã: não-viés, $\operatorname{Var}(\mathbf b)=\sigma^2(\mathbf X'\mathbf X)^{-1}$, Gauss-Markov e $E(\mathbf e'\mathbf e)=\sigma^2(n-K)$ (ex. 26, 32, 33, 36, 37). Aula à noite. Depois da aula, 20 min consolidando o que foi dado: se for conteúdo de P2, uma nota curta no esqueleto do [módulo 11](11_mqg_heterosk_autocorr/README.md) basta.
- [ ] **Sáb 19/09 — multicolinearidade e ajuste.** Módulo 06 (ex. 53, 54, 63, 64) e [módulo 05](05_ajuste_restricoes/05_teoria.md) (ex. 27, 55, 56, 62). · revisão do 02 (+3) e do 03 (+2)
- [ ] **Dom 20/09 — meio período.** [Módulo 07](07_testes_hipoteses/07_teoria.md): teoria dos testes e interpretação de output (ex. 41–46, 49–52). Treine o [vocabulário](formulario/vocabulario_interpretacao.md) escrevendo as quatro linhas para cada teste, sem olhar.

### Semana 2

- [ ] **Seg 21/09 — 07 em R e módulo 08.** Exercícios computacionais 38 e 39 ([parte computacional](07_testes_hipoteses/07_lista1_computacional.md)) e [assintótica](08_assintotica/08_teoria.md) (ex. 73). · revisão de 03/04 (+4) e do 06 (+3)
- [ ] **Ter 22/09 — módulo 09.** [Dummies, forma funcional, Chow e DiD](09_dummies_forma_funcional/09_teoria.md) (ex. 43, 47, 48, 57–61, 71, 72). · revisão de 05 e 07
- [ ] **Qua 23/09 — módulo 10, endogeneidade e VI.** [Teoria](10_endogeneidade_iv/10_teoria.md) e ex. 65–70. Rode o output do `ivreg` robusto e não robusto e decida a 5% e a 10%: é a armadilha do Wu-Hausman. · revisão do 02 (+7) e do 08
- [ ] **Qui 24/09 — banco, bloco 1.** Dez derivações cronometradas do [banco](provas/banco/derivacoes.md) e seis itens de [interpretação](provas/banco/interpretacao.md). · revisão do 03 (+7) e do 09
- [ ] **Sex 25/09 — vermelhos + aula.** Refaça todas as demonstrações que ficaram marcadas em vermelho no log. Escreva o [formulário](formulario/formulario.md) de memória, numa folha, e compare. Aula à noite. · revisão do 10 (+2)
- [ ] **Sáb 26/09 — Simulado 1.** [Simulado 01](provas/simulados/simulado_01.md) cronometrado, sem consulta, no tempo real da prova. Corrija pelo [gabarito](provas/simulados/simulado_01_gabarito.md) usando a rubrica e registre tudo no log.
- [ ] **Dom 27/09 — dia leve.** Ataque só os três pontos mais fracos do simulado. Nada de matéria nova. · revisão de 06/07 (+7)

### Reta final (plano original)

- [ ] **Seg 28/09 — banco, bloco 2.** VI, erro de medição, viés de omissão, consistência e Gauss-Markov, mais seis outputs. · revisão de 09/10
- [ ] **Ter 29/09 — Simulado 2.** [Simulado 02](provas/simulados/simulado_02.md) cronometrado + correção. Compare a nota com a do S1: o que subiu, o que não.
- [ ] **Qua 30/09 — revisão final.** Todo o log de erros e todas as demonstrações em vermelho. Formulário fechado. Se sobrar fôlego, partes do [Simulado 03](provas/simulados/simulado_03.md), no máximo 90 min. **Pare às 18h.**
- [ ] **Qui 01/10 — descanso.** No máximo 45 min com a [folha de última revisão](formulario/ultima_revisao.md). Durma cedo: rendimento na prova depende mais disso do que de mais uma hora de estudo.
- [ ] **Sex 02/10 — P1.** Leia a [folha de última revisão](formulario/ultima_revisao.md) por 15 min antes. Na prova: **resolva primeiro as questões de output**, que são pontos rápidos, e deixe as demonstrações para depois, com as hipóteses sempre escritas.

### Se o tempo apertar

A ordem de prioridade, do que mais cai para o que menos cai:

1. módulo 02 (Q3 garantida) e módulo 10 (Q2, Q4 e Q6 da P1 2025/2);
2. módulo 06 (variância, Gauss-Markov, consistência: Q5);
3. módulo 07 e o vocabulário de interpretação (Q1);
4. módulo 03;
5. módulos 09, 05, 08, 04, 00 e 01.
