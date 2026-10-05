---
title: "Banco de derivações para a P1"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
relevancia_p1: alta
status: rascunho
tags:
  - econometria
  - mestrado/ppgeco
  - p1
  - prova
aliases:
  - Banco de derivações
---

# Banco de derivações

Trinta e seis demonstrações no formato em que o professor cobra. Use assim: leia o enunciado, feche o repositório, escreva no papel dentro do **tempo-alvo** e só então confira na demonstração indicada. O que não sair no tempo vai para o [log de erros](../log_erros.md) e volta na revisão de +1, +3 e +7 dias.

**Legenda de prioridade:** 🔴 caiu na P1 2025/2 ou é quase certa · 🟡 provável · ⚪ menos provável, mas barata de aprender.

---

## Rota escalar (regressão simples)

| # | Enunciado | Tempo | Onde conferir | Passos que valem ponto |
|---|---|---|---|---|
| E1 🔴 | Obtenha as duas equações normais minimizando a soma de quadrados dos resíduos | 4 min | [D02.1](../../02_mqo_simples/02_teoria.md) | derivar em $\widehat\beta_1$ e $\widehat\beta_2$; igualar a zero; escrever o sistema |
| E2 🔴 | Resolva o sistema e obtenha $\widehat\beta_1$ e $\widehat\beta_2$ | 6 min | [D02.1](../../02_mqo_simples/02_teoria.md) | dividir por $n$; substituir o intercepto; usar as identidades de somatório |
| E3 🟡 | Prove as quatro formas equivalentes de $S_{XY}$ | 5 min | D5 no [núcleo](../../demonstracoes/econometria-i-demonstracoes-mes-1-1.md) | abrir o produto; usar $\sum(X_i-\bar X)=0$ |
| E4 🟡 | Mostre que a condição de 2ª ordem garante mínimo | 4 min | D7 | Hessiana; $2n\gt 0$ e determinante $4n\sum x_i^2\gt 0$ |
| E5 🔴 | Prove que $\sum\widehat u_i=0$ e $\sum X_i\widehat u_i=0$ | 3 min | [D02.2](../../02_mqo_simples/02_teoria.md) | são as próprias CPOs; dizer que exigem intercepto |
| E6 🟡 | Mostre que $\bar{\widehat Y}=\bar Y$ e que a reta passa por $(\bar X,\bar Y)$ | 3 min | [D02.2](../../02_mqo_simples/02_teoria.md) | substituir o intercepto |
| E7 🟡 | Escreva o modelo em desvios da média e mostre que a inclinação não muda | 4 min | [D02.3](../../02_mqo_simples/02_teoria.md) | somar médias; subtrair; concluir resíduos idênticos |
| E8 🔴 | Prove que $\widehat\beta_2$ é não viesado | 6 min | [D02.5](../../02_mqo_simples/02_teoria.md) | pesos $w_i$ e suas 3 propriedades; substituir o modelo; $E(u\mid X)=0$ |
| E9 🟡 | Prove que $\widehat\beta_1$ é não viesado | 5 min | [D02.5](../../02_mqo_simples/02_teoria.md) | usar $\widehat\beta_1=\bar Y-\widehat\beta_2\bar X$ e o resultado de E8 |
| E10 🔴 | Obtenha $\operatorname{Var}(\widehat\beta_2)$ e $\operatorname{Var}(\widehat\beta_1)$ | 7 min | [D02.6](../../02_mqo_simples/02_teoria.md) | identidade com $w_i$; homocedasticidade; $\sum w_i^2=1/S_{XX}$ |
| E11 🟡 | Obtenha $\operatorname{Cov}(\widehat\beta_1,\widehat\beta_2)$ e explique o sinal | 5 min | [D02.7](../../02_mqo_simples/02_teoria.md) | bilinearidade; interpretar o $-\bar X$ |
| E12 🟡 | Mostre que $E(\widehat\sigma^2)=\sigma^2$ na regressão simples | 8 min | [D02.8](../../02_mqo_simples/02_teoria.md) | escrever $\widehat u_i$ em função de $u_i$; esperança das somas |
| E13 🔴 | Deduza o viés de omissão de variável relevante (escalar) | 6 min | [D02.9](../../02_mqo_simples/02_teoria.md) | substituir o modelo verdadeiro; identificar $\widehat\delta$; condições de anulação |
| E14 🟡 | Prove $t^2=F$ na regressão simples | 4 min | [D02.11](../../02_mqo_simples/02_teoria.md) | elevar o $t$ ao quadrado; $SQE=\widehat\beta_2^2S_{XX}$ |
| E15 🟡 | Escreva o $F$ em função do $R^2$ | 3 min | [D02.12](../../02_mqo_simples/02_teoria.md) | dividir numerador e denominador por $SQT$ |
| E16 ⚪ | Mostre que $R^2=r^2_{XY}$ na regressão simples | 4 min | [D02.10](../../02_mqo_simples/02_teoria.md) | escrever $SQE$ e $SQT$ com somas centradas |
| E17 🔴 | Gauss-Markov escalar: MQO é MELNV | 9 min | D11 | estimador linear alternativo; não-viés impõe restrições; variância maior |

## Rota matricial

| # | Enunciado | Tempo | Onde conferir | Passos que valem ponto |
|---|---|---|---|---|
| M1 🔴 | Derive $\mathbf b=(\mathbf X'\mathbf X)^{-1}\mathbf X'\mathbf y$ pelas equações normais | 5 min | [03_teoria](../../03_mqo_matricial/03_teoria.md) | gradiente de $\mathbf e'\mathbf e$; CPO; posto completo |
| M2 🟡 | Mostre que a condição de 2ª ordem vale ($\mathbf X'\mathbf X$ definida positiva) | 4 min | [03_teoria](../../03_mqo_matricial/03_teoria.md) | $v'\mathbf X'Xv=\lVert Xv\rVert^2\gt 0$ |
| M3 🔴 | Prove que $\mathbf b$ é não viesado | 4 min | [03_lista1, ex. 24](../../03_mqo_matricial/03_lista1.md) | identidade $\mathbf b=\beta+(\mathbf X'\mathbf X)^{-1}\mathbf X'\varepsilon$; $E(\varepsilon\mid \mathbf X)=0$; LIE |
| M4 🔴 | Prove $\operatorname{Var}(\mathbf b\mid \mathbf X)=\sigma^2(\mathbf X'\mathbf X)^{-1}$ | 6 min | [06_lista1, ex. 26](../../06_amostra_finita_multicol/06_lista1.md) | definição; tirar $\mathbf X$ da esperança; $E(\varepsilon\varepsilon'\mid \mathbf X)=\sigma^2\mathbf I$ |
| M5 🟡 | Prove $\mathbf e=\mathbf M\mathbf y$, com $\mathbf M$ simétrica e idempotente | 4 min | [03_lista1, ex. 28](../../03_mqo_matricial/03_lista1.md) | substituir $\mathbf b$; verificar $\mathbf M'=\mathbf M$ e $\mathbf M\mathbf M=\mathbf M$; $\mathbf M\mathbf X=0$ |
| M6 🟡 | Prove $\widehat{\mathbf y}=\mathbf P\mathbf y$ e liste as propriedades de $\mathbf P$ | 4 min | [03_lista1, ex. 29](../../03_mqo_matricial/03_lista1.md) | idempotência; $\mathbf P\mathbf X=\mathbf X$; $\mathbf P\mathbf M=0$; traços |
| M7 🟡 | Prove $\mathbf e'\mathbf e=\mathbf y'\mathbf y-\mathbf b'\mathbf X'\mathbf y$ | 3 min | [03_lista1, ex. 30](../../03_mqo_matricial/03_lista1.md) | abrir o quadrado; usar as equações normais |
| M8 🟡 | Prove $\mathbf X'\mathbf e=0$ e as consequências com intercepto | 3 min | [03_lista1, ex. 31](../../03_mqo_matricial/03_lista1.md) | substituir $\mathbf b$; primeira linha dá $\sum e_i=0$ |
| M9 🔴 | Prove $E(\mathbf e'\mathbf e\mid \mathbf X)=\sigma^2(n-K)$ pelo truque do traço | 8 min | [06_teoria](../../06_amostra_finita_multicol/06_teoria.md) | $\mathbf e'\mathbf e=\varepsilon'\mathbf M\varepsilon$; esperança de forma quadrática; $\operatorname{tr}(\mathbf M)=n-K$ |
| M10 🔴 | Gauss-Markov matricial com $\mathbf b^*=[(\mathbf X'\mathbf X)^{-1}\mathbf X'+\mathbf C]\mathbf y$ | 10 min | [06_lista1, ex. 33](../../06_amostra_finita_multicol/06_lista1.md) | não-viés exige $\mathbf C\mathbf X=0$; variância com $\sigma^2\mathbf C\mathbf C'$; semidefinida positiva |
| M11 🟡 | Teorema de Frisch-Waugh-Lovell | 8 min | [D04.2](../../04_fwl_particionada/04_teoria.md) | equações normais particionadas; isolar $b_1$; substituir |
| M12 🔴 | Viés de omissão no modelo particionado | 5 min | [D04.4](../../04_fwl_particionada/04_teoria.md) | substituir o verdadeiro; esperança; matriz $P_{12}$ |
| M13 🟡 | Derive o estimador de mínimos quadrados restritos | 9 min | [05_teoria](../../05_ajuste_restricoes/05_teoria.md) | lagrangiano; CPOs; isolar o multiplicador |
| M14 🟡 | Mostre $\mathbf e_*'\mathbf e_*-\mathbf e'\mathbf e=(\mathbf R\mathbf b-\mathbf r)'[\mathbf R(\mathbf X'\mathbf X)^{-1}\mathbf R']^{-1}(\mathbf R\mathbf b-\mathbf r)$ | 8 min | [05_teoria](../../05_ajuste_restricoes/05_teoria.md) | substituir $\mathbf b_*$; usar a forma quadrática |
| M15 🔴 | Derive a estatística $F$ da hipótese linear geral | 8 min | [D07.2](../../07_testes_hipoteses/07_teoria.md) | distribuição de $\mathbf R\mathbf b$; forma quadrática $\chi^2$; independência via $\mathbf M\mathbf X=0$ |
| M16 🟡 | Mostre as três formas equivalentes do $F$ | 6 min | [D07.4](../../07_testes_hipoteses/07_teoria.md) | Wald, somas de quadrados e $R^2$ |
| M17 ⚪ | Derive a variância de um coeficiente com $1-R_k^2$ e o VIF | 6 min | [D04.5](../../04_fwl_particionada/04_teoria.md) | bloco da inversa particionada |

## Rota assintótica

| # | Enunciado | Tempo | Onde conferir | Passos que valem ponto |
|---|---|---|---|---|
| H1 🔴 | Prove que o MQO é consistente | 6 min | [D08.1](../../08_assintotica/08_teoria.md) | dividir por $n$; $\operatorname{plim}\mathbf X'\mathbf X/n=\mathbf Q$; $\operatorname{plim}\mathbf X'\varepsilon/n=0$; Slutsky |
| H3 🟡 | Mostre que $\operatorname{plim}(\mathbf X'\varepsilon/n)=0$ pela variância | 4 min | [D08.1](../../08_assintotica/08_teoria.md) | média zero; variância $\sigma^2\mathbf Q/n\to 0$; convergência em média quadrática |
| H2 🟡 | Esboce a normalidade assintótica de $\mathbf b$ | 7 min | [D08.2](../../08_assintotica/08_teoria.md) | multiplicar por $\sqrt n$; TLC em $\mathbf X'\varepsilon/\sqrt n$; Slutsky |
| H4 ⚪ | Prove a consistência de $s^2$ | 5 min | [D08.3](../../08_assintotica/08_teoria.md) | decompor $\varepsilon'M\varepsilon/n$; LGN |
| H2 🟡 | Método delta aplicado ao ponto de máximo $-a_3/(2a_4)$ | 6 min | [D08.4](../../08_assintotica/08_teoria.md) | expansão de Taylor; gradiente; variância da combinação |
| H5 🟡 | Prove que a média amostral é consistente (Chebyshev) | 4 min | [00_lista1, ex. 3](../../00_fundamentos/00_lista1.md) | $E(\bar X)=\mu$; $\operatorname{Var}=\sigma^2/n$; desigualdade |
| A7 ⚪ | Decomposição $EQM=\operatorname{Var}+\text{viés}^2$ | 3 min | [D00.1](../../00_fundamentos/00_teoria.md) | somar e subtrair $E(\widehat\theta)$; termo cruzado nulo |

## Endogeneidade e variáveis instrumentais

| # | Enunciado | Tempo | Onde conferir | Passos que valem ponto |
|---|---|---|---|---|
| V1 🔴 | Derive $\widehat\beta_{IV}=(\mathbf Z'\mathbf X)^{-1}\mathbf Z'\mathbf y$ via plim | 6 min | [D10.5](../../10_endogeneidade_iv/10_teoria.md) | condição de exogeneidade; substituir $\varepsilon$; isolar; análogo amostral |
| V2 🟡 | Derive o estimador de MQ2E e mostre que colapsa no VI | 7 min | [D10.7](../../10_endogeneidade_iv/10_teoria.md) | projeção $P_Z$; idempotência; caso $L=K$ |
| V3 🔴 | Mostre que o MQO é inconsistente sob endogeneidade | 5 min | [D10.1](../../10_endogeneidade_iv/10_teoria.md) | $\operatorname{plim}\mathbf b=\beta+\mathbf Q^{-1}\gamma$ |
| V4 🔴 | Erro de medição no regressor: viés de atenuação | 7 min | [D10.2](../../10_endogeneidade_iv/10_teoria.md) | $\operatorname{Cov}(z,X)=-\beta\sigma_w^2$; plim com o fator $\lambda$ |
| V5 🔴 | Erro de medição na dependente: não vicia, infla variância | 5 min | [D10.3](../../10_endogeneidade_iv/10_teoria.md) | $v=\mu+\varepsilon$; $E(v\mid X)=0$; variância somada |
| V6 🟡 | Simultaneidade keynesiana: inconsistência de $\widehat\beta_1$ | 8 min | [D10.4](../../10_endogeneidade_iv/10_teoria.md) | forma reduzida; $\operatorname{Cov}(Y,\mu)$; $\operatorname{Var}(Y)$; plim |
| V7 ⚪ | Mostre que o VI colapsa no MQO quando $Z=X$ | 2 min | [D10.8](../../10_endogeneidade_iv/10_teoria.md) | substituição direta |

## Dummies, forma funcional e DiD

| # | Enunciado | Tempo | Onde conferir | Passos que valem ponto |
|---|---|---|---|---|
| F1 🟡 | Armadilha da dummy: mostre que $\mathbf X'\mathbf X$ é singular | 4 min | [D09.2](../../09_dummies_forma_funcional/09_teoria.md) | dependência linear exata; posto; H3 violada |
| F2 🔴 | Efeito exato de dummy em modelo log | 3 min | [D09.3](../../09_dummies_forma_funcional/09_teoria.md) | razão de esperanças; $100(e^\beta-1)$ |
| F3 🔴 | Ponto de máximo de um termo quadrático | 3 min | [D09.5](../../09_dummies_forma_funcional/09_teoria.md) | derivada igual a zero; sinal da segunda derivada |
| F4 🟡 | Linearize a Cobb-Douglas e diga a condição sobre o erro | 4 min | [D09.6](../../09_dummies_forma_funcional/09_teoria.md) | logs; erro multiplicativo |
| F5 🟡 | Mostre que Chow e o modelo interagido dão o mesmo $F$ | 6 min | [D09.7](../../09_dummies_forma_funcional/09_teoria.md) | $SQR_1+SQR_2$ é o irrestrito; contar restrições |
| F6 🔴 | Derive o estimador de diferenças em diferenças | 7 min | [D09.8](../../09_dummies_forma_funcional/09_teoria.md) | diferença temporal; esperança por grupo; subtrair |
| F7 🟡 | DiD com controles invariantes no tempo | 3 min | [did.md](../../09_dummies_forma_funcional/did.md) | $\Delta x=0$; sobra $\beta_3$ |
| F8 ⚪ | Tabela de elasticidades das cinco formas funcionais | 5 min | [D09.4](../../09_dummies_forma_funcional/09_teoria.md) | derivar cada forma; multiplicar por $X/Y$ |

---

## Como treinar

1. **Bloco cronometrado.** Sorteie 8 a 10 itens, misturando as rotas, e resolva em sequência sem consultar. Some os tempos-alvo: é o seu orçamento.
2. **Correção honesta.** Compare com a demonstração indicada e marque ✅ (saiu inteira), ⚠️ (saiu com falha) ou ❌ (travou).
3. **Fila de revisão.** Todo ⚠️ e ❌ volta no dia seguinte, depois em 3 e em 7 dias.
4. **Meta antes do dia 09/10.** Todos os 🔴 em ✅ por duas rodadas seguidas. Os ⚪ podem ficar por último.

> [!TIP]
> **O que o professor premia**
> Hipótese citada em cada passo, dimensões conferidas e a frase final de conclusão. Uma derivação impecável sem dizer onde usou $E(\varepsilon\mid X)=0$ perde ponto; uma derivação com erro de álgebra, mas com o caminho e as hipóteses corretos, quase não perde.
