---
title: "Módulo 01 — Paradigma econométrico, projeção e o modelo de regressão (teoria)"
modulo: "01"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
greene: "cap. 1; cap. 2; cap. 4 (§4.1–4.2)"
slides: "SL01, SL02"
lista1: [10, 11, 12]
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
  - Paradigma e projeção
---

# Módulo 01 — Paradigma, projeção e o modelo de regressão

## 0. Mapa

> [!NOTE]
> **O que é, por que importa, onde cai**
> Antes de estimar, é preciso saber **o que** se está estimando. Este módulo separa três objetos que costumam ser confundidos: a **função de regressão populacional** $E[y\mid x]$, a **projeção linear** (a melhor aproximação linear de $y$ por $x$) e a **reta ajustada** na amostra. As hipóteses A1 a A6 aparecem aqui pela primeira vez, e é delas que sai tudo o mais. Na prova, cai como item conceitual de abertura e como a lista de hipóteses que qualquer demonstração precisa citar.

## 1. O paradigma econométrico

A econometria junta três ingredientes: **teoria econômica** (que dá a relação a ser testada), **dados** (que trazem variação) e **método estatístico** (que separa sinal de ruído). As etapas clássicas:

1. formular a questão e a **teoria**;
2. especificar o **modelo econométrico** (variáveis, forma funcional, erro);
3. levantar os **dados**;
4. **estimar** os parâmetros;
5. **testar** hipóteses e verificar os pressupostos;
6. **interpretar** e usar o modelo para previsão ou política.

**Estruturas de dados.** Corte transversal ($n$ unidades num momento), série temporal (uma unidade ao longo do tempo), painel (as duas dimensões) e dados agrupados. A estrutura determina quais hipóteses são críveis: autocorrelação é problema típico de série temporal; heterocedasticidade, de corte transversal; heterogeneidade não observada, de painel.

## 2. Três objetos diferentes

| Objeto | Definição | Natureza |
|---|---|---|
| Função de regressão populacional | $E[y\mid x]$ | populacional, pode ser não linear |
| Projeção linear | $\alpha+\beta'x$ que minimiza $E[(y-\alpha-\beta'x)^2]$ | populacional, linear por construção |
| Reta ajustada | $\hat y=x'b$ | amostral, calculada dos dados |

### D01.1 · A projeção linear populacional

> [!NOTE]
> **O que se quer provar**
> Os coeficientes da melhor aproximação linear de $y$ por $x$ são
> $$\beta=\operatorname{Var}(x)^{-1}\operatorname{Cov}(x,y),\qquad \alpha=E[y]-\beta'E[x].$$

**Passo a passo.**

1. Minimize $S(\alpha,\beta)=E\big[(y-\alpha-\beta'x)^2\big]$ em relação a $\alpha$:
$$\frac{\partial S}{\partial\alpha}=-2E[y-\alpha-\beta'x]=0\ \Longrightarrow\ \alpha=E[y]-\beta'E[x].$$

2. Substitua e derive em relação a $\beta$:
$$\frac{\partial S}{\partial\beta}=-2E\big[x\,(y-\alpha-\beta'x)\big]=0\ \Longrightarrow\ \operatorname{Cov}(x,y)=\operatorname{Var}(x)\beta .$$

3. Com $\operatorname{Var}(x)$ não singular,
$$\beta=\operatorname{Var}(x)^{-1}\operatorname{Cov}(x,y).\qquad\blacksquare$$

**Leitura.** São as **condições de momento** $E[\varepsilon]=0$ e $E[x\varepsilon]=0$ que definem a projeção — e o MQO é o análogo amostral exato dessas condições. Por isso o MQO sempre estima **alguma coisa** (a projeção), mesmo quando a esperança condicional não é linear; o que se perde, nesse caso, é a interpretação causal ou estrutural.

### D01.2 · Quando a projeção coincide com a esperança condicional

Se $E[y\mid x]$ **é** linear em $x$, projeção e esperança condicional coincidem. Isso acontece, por exemplo, quando $(y,x)$ têm distribuição normal conjunta. Caso contrário, a projeção é a melhor aproximação linear, e a diferença $E[y\mid x]-(\alpha+\beta'x)$ é o erro de especificação funcional — o que o RESET detecta ([módulo 07](../07_testes_hipoteses/07_teoria.md)).

**Verificação.** Simulando $E[y\mid x]=x^2$ com $x$ uniforme, a projeção linear ajusta uma reta com inclinação positiva que não é a média condicional em ponto nenhum; o gráfico [figuras/](figuras/) mostra as duas curvas lado a lado.

## 3. As hipóteses do modelo clássico

| Id | Hipótese | O que garante | O que quebra sem ela |
|---|---|---|---|
| A1 | linearidade nos parâmetros | o modelo é $y=X\beta+\varepsilon$ | especificação errada, viés |
| A2 | posto completo de $X$ | identificação e existência de $(X'X)^{-1}$ | parâmetros não identificados (ex. 35, 61) |
| A3 | $E[\varepsilon\mid X]=0$ | não-viés e consistência | viés e inconsistência ([módulo 10](../10_endogeneidade_iv/10_teoria.md)) |
| A4 | $E[\varepsilon\varepsilon'\mid X]=\sigma^2I$ | $\operatorname{Var}(b)=\sigma^2(X'X)^{-1}$ e Gauss-Markov | erros-padrão errados, MQO ineficiente |
| A5 | $X$ gerado exogenamente | condicionamento em $X$ é legítimo | inferência condicional inválida |
| A6 | normalidade do erro | inferência **exata** ($t$ e $F$) | só resta a inferência assintótica ([módulo 08](../08_assintotica/08_teoria.md)) |

**Na numeração do professor.** Em aula essas hipóteses são **h1 a h5** (h4 é a exogeneidade estrita e h5 a ausência de multicolinearidade); homocedasticidade e ausência de autocorrelação vêm junto com a variância. Ver [caderno_aulas.md](../demonstracoes/caderno_aulas.md) §2 e responda na numeração dele.

> [!IMPORTANT]
> **A hierarquia que vale ponto**
> A3 é a hipótese crítica: sem ela não há não-viés nem consistência. A4 afeta **eficiência e inferência**, não o não-viés. A6 afeta só a inferência exata em amostra pequena. Saber dizer **qual propriedade cai com qual hipótese** é o que separa uma resposta boa de uma decorada.

## 4. A aplicação que atravessa o curso

A base de Cornwell e Rupert (`AER::PSID7682`) é o exemplo dos slides e caiu na P1 2025/2: 595 indivíduos observados em 7 anos (1976–1982), 4165 observações, tratadas como corte transversal na prova.

Médias que aparecem na coluna "Média de X" do output da prova, reproduzidas exatamente pelo script: educação 12,8454 anos; experiência 19,8538; semanas trabalhadas 46,8115; 29,03% no Sul; 65,38% em região metropolitana; 7,23% negros; salário médio em log 6,6763.

## 5. Como cai na prova

| Formato | O que fazer |
|---|---|
| "Cite e explique as etapas da análise econométrica" | a lista da §1, com uma frase por etapa |
| "Quais as hipóteses do MRL?" | A1 a A6 (ou as cinco da versão simples), cada uma com o que garante |
| "Quais as propriedades ótimas do MQO?" | linear, não viesado, eficiente: MELNV, por Gauss-Markov |
| "O que é o termo de erro?" | tudo o que afeta $y$ e não está no modelo, mais erro de medida e aleatoriedade intrínseca |

## 6. Armadilhas

> [!WARNING]
> **Três confusões que custam ponto**
> 1. Confundir **erro** $\varepsilon_i$ (populacional, não observável) com **resíduo** $e_i$ (amostral, calculado).
> 2. Dizer que o MQO "supõe normalidade": não supõe, para não-viés e Gauss-Markov. A normalidade só é usada na inferência exata.
> 3. Tratar linearidade como restrição sobre as **variáveis**: o modelo é linear **nos parâmetros**, e aceita logs, quadrados e interações ([módulo 09](../09_dummies_forma_funcional/09_teoria.md)).

## 7. Checklist

- [ ] Explico a diferença entre $E[y\mid x]$, projeção linear e reta ajustada.
- [ ] Derivo $\beta=\operatorname{Var}(x)^{-1}\operatorname{Cov}(x,y)$ (D01.1).
- [ ] Listo A1 a A6 dizendo o que cada uma garante e o que cai sem ela.
- [ ] Digo as etapas da análise econométrica sem travar.

## 8. Conferência numérica

| chave_R | nota |
|---|---|
| m01_psid_n | 4165 |
| m01_psid_nind | 595 |
| m01_psid_media_ed | 12,8454 |
| m01_psid_media_exp | 19,8538 |
| m01_psid_media_wks | 46,8115 |
| m01_psid_media_south | 0,290276 |
| m01_psid_media_smsa | 0,653782 |
| m01_psid_media_lwage | 6,67635 |

## 9. Referências

- Greene, *Econometric Analysis*, cap. 1 (paradigma), cap. 2 (o modelo de regressão), §4.1–4.2.
- Slides SL01 e SL02.
- Exercícios resolvidos: [01_lista1.md](01_lista1.md).
