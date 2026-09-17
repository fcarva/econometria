---
title: "Caderno de aula — mapa das páginas e da notação do professor"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
aulas: [14/08, 21/08]
relevancia_p1: alta
status: rascunho
verificacao:
  derivacao: pendente
tags:
  - econometria
  - mestrado/ppgeco
  - p1
  - caderno
aliases:
  - Caderno de aula
  - Mapa do caderno
---

# Caderno de aula: o que o professor efetivamente derivou

As fotos estão em `materiais/caderno/` (fora do git), 15 páginas cobrindo as aulas de **14/08** e **21/08**. Este mapa serve para três coisas: achar rápido a página que interessa, **usar a notação do professor** na prova e conferir que nenhuma derivação dada em aula ficou de fora do repositório.

> [!IMPORTANT]
> **A descoberta mais útil do caderno**
> O professor numera as hipóteses do modelo como **h1 a h5**, não como A1–A6 do Greene. Na prova, escreva na numeração dele. A tradução está na seção 2.

## 1. Mapa das páginas

A ordem física das fotos não é a ordem da aula. Esta é a sequência lógica:

| # | Arquivo (`materiais/caderno/…15.28.19*.jpeg`) | Conteúdo | Onde está no repositório |
|---|---|---|---|
| 1 | `(14)` | **14/08 — abertura.** Avaliação (prova, lista, livros), bibliografia, arco do curso: MQO → máxima verossimilhança → endogeneidade (viciado e inconsistente). Já anuncia MQO como linear, não viesado e eficiente | [PLANO_ESTUDO](../PLANO_ESTUDO.md), [módulo 01](../01_paradigma_projecao/01_teoria.md) |
| 2 | `(13)` | Regressão simples, $\varepsilon_i\sim iid(0,\sigma^2)$, **correlação ≠ dependência**, a FRP como esperança condicional: $E[y_i\mid x_i]=\beta_0+\beta_1x_i$ e $y_i=E[y_i\mid x_i]+\varepsilon_i$ | [D01.1, D01.2](../01_paradigma_projecao/01_teoria.md) |
| 3 | `(12)` | $\operatorname{Cov}(x,y)=\beta_1\operatorname{Var}(x)$, daí $\beta_1=\operatorname{Cov}/\operatorname{Var}$ e $\beta_0=E[y]-\beta_1E[x]$. Menciona máxima verossimilhança e lineariza a Cobb-Douglas: $\ln y=\ln A+\alpha\ln K+\beta\ln L$ | [D01.1](../01_paradigma_projecao/01_teoria.md), [D09.6](../09_dummies_forma_funcional/09_teoria.md) |
| 4 | `(11)` | Passagem população → amostra; $\min\sum\hat u_i^2$; as duas condições de primeira ordem, dando $\sum e_i=0$ e $\sum e_ix_i=0$ | [D02.1](../02_mqo_simples/02_teoria.md) |
| 5 | `(7)` | O critério de mínimos quadrados escrito com o desenho da reta e dos resíduos; primeira CPO | [D02.1](../02_mqo_simples/02_teoria.md) |
| 6 | `(4)` | Derivação completa: $\hat\beta_0=\bar y-\hat\beta_1\bar x$, a reta passando por $(\bar x,\bar y)$, e a segunda CPO aberta termo a termo | [D02.1](../02_mqo_simples/02_teoria.md) |
| 7 | `(6)` | Segunda condição e as **identidades de somatório** em todas as formas equivalentes | [D02.1, D02.2](../02_mqo_simples/02_teoria.md), ex. 22 |
| 8 | `(5)` | "Resultados": $\sum(y_i-\bar y)(x_i-\bar x)=\sum y_ix_i-n\bar x\bar y$, $\sum(x_i-\bar x)^2=\sum x_i^2-n\bar x^2$, e $\sum\hat u_ix_i=0\Rightarrow\widehat{\operatorname{Cov}}(\hat u,x)=0$ | [D02.2](../02_mqo_simples/02_teoria.md), ex. 17 |
| 9 | `(10)` | Fecha a álgebra: $b_1=\dfrac{\sum y_ix_i-\frac{\sum y_i\sum x_i}{n}}{\sum x_i^2-\frac{(\sum x_i)^2}{n}}$. Depois, a média amostral como "centro de massa": $E[\bar x]=\mu$, $\operatorname{Var}[\bar x]=\sigma^2/n$ e $\lim_{n\to\infty}\sigma^2/n=0$ | [D02.1](../02_mqo_simples/02_teoria.md), [ex. 2 e 3](../00_fundamentos/00_lista1.md) |
| 10 | `(3)` | $\hat\beta_1=\widehat{\operatorname{Cov}}(y,x)/\widehat{\operatorname{Var}}(x)$ e o **resumo** da aula: $\sum\hat u_i=0$, $\sum\hat u_ix_i=0$, $\hat\beta_0=\bar y-\hat\beta_1\bar x$ | [D02.1, D02.2](../02_mqo_simples/02_teoria.md) |
| 11 | `(9)` | **Propriedades estatísticas**: linear, não tendencioso. Introduz os pesos $k_i$, abre $b_1=\sum k_iy_i$ e prova $E[b_1\mid x]=\beta_1$ usando $\sum k_i=0$ e $\sum k_ix_i=1$ | [D02.4, D02.5](../02_mqo_simples/02_teoria.md), ex. 14 |
| 12 | `(8)` | $\operatorname{Var}(b_1\mid x)=\sigma^2/\sum(x_i-\bar x)^2$, com homocedasticidade e ausência de autocorrelação. O **desenho do alvo** (viés × dispersão), Gauss-Markov e $EQM[\hat\theta]=\operatorname{Var}[\hat\theta]+[\text{viés}]^2$ | [D02.6](../02_mqo_simples/02_teoria.md), [D00.1](../00_fundamentos/00_teoria.md), ex. 9 e 16 |
| 13 | `(2)` | **21/08 — regressão múltipla.** Do escalar ao empilhamento linha a linha até $y=X\beta+\varepsilon$, com $\varepsilon\sim iid$ | [módulo 03](../03_mqo_matricial/03_teoria.md) |
| 14 | `(1)` | Hipóteses h1, h2 e h3; **coeficiente de determinação**: $SQT=SQE+SQR$, $R^2=1-SQR/SQT$, leitura em porcentagem e $\bar R^2$ ajustado pelos graus de liberdade | [módulo 05](../05_ajuste_restricoes/05_teoria.md) |
| 15 | *(sem sufixo)* | Hipóteses h4 e h5; $b=(X'X)^{-1}X'y$; a inversa pela **adjunta sobre o determinante**; colinearidade perfeita ⇒ determinante zero ⇒ sem estimativa; $\operatorname{Var}(b\mid X)=\sigma^2(X'X)^{-1}$ | [módulo 03](../03_mqo_matricial/03_lista1.md) ex. 35, [módulo 06](../06_amostra_finita_multicol/06_lista1.md) ex. 26 |

## 2. A numeração das hipóteses: h1–h5 × A1–A6

> [!IMPORTANT]
> **Use a numeração do professor na prova**
> Escrever "pela h4" comunica direto com quem corrige. Nas notas do repositório usamos a numeração do Greene (A1–A6), porque é a dos slides; esta tabela faz a ponte.

| Professor | Enunciado no caderno | Greene | O que garante |
|---|---|---|---|
| **h1** | parâmetros lineares | A1 | a álgebra do MQO se aplica |
| **h2** | amostra aleatória | A5 | as observações são um sorteio da população |
| **h3** | variação em $X$ (a fórmula $b_2=\frac{\sum(x_i-\bar x)(y_i-\bar y)}{\sum(x_i-\bar x)^2}$ exige $\sum(x_i-\bar x)^2\gt 0$) | A2 no caso escalar | identificação: sem variação em $X$, não há inclinação |
| **h4** | $E[\varepsilon\mid X]=0$, escrita vetor a vetor — "exogeneidade estrita", sem correlação entre erro e variável explicativa | A3 | **não-viés e consistência** |
| **h5** | ausência de multicolinearidade: não existem $\lambda$ com $\lambda_2X_2+\lambda_3X_3=0$ (exemplo do caderno: $X_2-2X_3=0$) | A2 no caso matricial | $\det(X'X)\neq 0$, logo a inversa existe |

Homocedasticidade e ausência de autocorrelação aparecem no caderno **junto com a variância** (página 12 do mapa), não na lista numerada — é a A4 do Greene. A normalidade (A6) não é numerada: entra só quando se fala de inferência exata.

> [!TIP]
> **O jeito do professor de pedir a inversa**
> No caderno, $(X'X)^{-1}=\dfrac{1}{\det(X'X)}\operatorname{adj}(X'X)$. É exatamente o caminho do ex. 34, e é o que ele espera ver numa conta $2\times 2$ feita à mão — não "resolvi o sistema". Ver [03_lista1.md](../03_mqo_matricial/03_lista1.md).

## 3. Vocabulário do professor

Vale usar as palavras dele:

| Ele escreve | Equivalente no repositório |
|---|---|
| não tendencioso / não viciado / sem viés | não viesado |
| MELNV | melhor estimador linear não viesado (BLUE) |
| SQT, SQE, SQR | soma de quadrados total, explicada e dos resíduos |
| centro de massa | a média amostral como estimador de $\mu$ |
| exogeneidade estrita | $E[\varepsilon\mid X]=0$ |
| viciado e inconsistente | o par de consequências da endogeneidade |

## 4. O que o caderno confirma sobre a prova

1. **A rota escalar completa foi dada em aula**, passo a passo, duas vezes (páginas 4 a 10 do mapa): é a Q3 da prova, e o professor espera exatamente esse encadeamento — CPOs → intercepto → identidades → inclinação.
2. **Os pesos $k_i$ são o método dele para o não-viés** (página 11). Quem prova por $k_i$ está falando a língua da aula.
3. **O desenho do alvo** (página 12) é a imagem que ele usa para separar viés de variância — e cai como "explique a diferença entre não-viés e eficiência".
4. **A colinearidade perfeita foi dada com um exemplo numérico** ($X_2-2X_3=0$), que é o ex. 35 da Lista 1 e reapareceu na prova como conceito.
5. **O arco do curso está na primeira página**: MQO → máxima verossimilhança → endogeneidade. A P1 para na endogeneidade; a máxima verossimilhança volta na P2 ([módulo 14](../14_mv_binarias/README.md)).

## 5. O que ainda não está no caderno

As fotos cobrem 14/08 e 21/08. Não há páginas de 28/08 em diante — justamente as aulas de **testes de hipóteses, assintótica, dummies e VI**. Se elas existirem, vale fotografar: são o conteúdo das questões Q1, Q2, Q5 e Q6 da prova, e a numeração de hipóteses e o vocabulário podem mudar de tom nesses tópicos.

Enquanto isso, a cobertura desses assuntos no repositório vem dos slides (SL06 a SL10) e da Lista 1, que são fontes do próprio professor.
