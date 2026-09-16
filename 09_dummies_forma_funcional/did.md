---
title: "Diferenças em diferenças (DiD)"
modulo: "09"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
greene: "cap. 6 (§6.3); cap. 11"
slides: "SL09, SL12"
lista1: [71, 72]
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
  - did
  - inferencia-causal
aliases:
  - DiD
  - Diferenças em diferenças
---

# Diferenças em diferenças

> [!NOTE]
> **Por que esta nota existe**
> O DiD aparece duas vezes na Lista 1 (ex. 71 e 72), é a ponte entre o módulo 09 (dummies e interações) e o painel da P2, e é a estratégia de identificação da dissertação. Vale dominar além do que a prova pede.

## 1. A ideia em uma tabela

Dois grupos (tratado e controle), dois períodos (antes e depois). As médias de $y$:

| | Antes ($T=0$) | Depois ($T=1$) | Diferença no tempo |
|---|---|---|---|
| **Controle** ($D=0$) | $\beta_0$ | $\beta_0+\beta_2$ | $\beta_2$ |
| **Tratado** ($D=1$) | $\beta_0+\beta_1$ | $\beta_0+\beta_1+\beta_2+\beta_3$ | $\beta_2+\beta_3$ |
| **Diferença entre grupos** | $\beta_1$ | $\beta_1+\beta_3$ | $\boxed{\beta_3}$ |

O estimador é a **diferença das diferenças**:
$$\hat\beta_3=\big(\bar y_{1,depois}-\bar y_{1,antes}\big)-\big(\bar y_{0,depois}-\bar y_{0,antes}\big).$$

A primeira diferença elimina tudo o que é fixo no grupo tratado; a segunda desconta a tendência comum, estimada pelo controle.

## 2. A forma de regressão

$$y_{it}=\beta_0+\beta_1D_i+\beta_2T_t+\beta_3(D_i\cdot T_t)+\beta'x_{it}+\varepsilon_{it}$$

- $\beta_1$: diferença de nível pré-existente entre os grupos (não é efeito de tratamento);
- $\beta_2$: tendência comum, capturada pelo controle;
- $\beta_3$: **o efeito do tratamento** (ATT, sob as hipóteses abaixo).

Vantagens sobre a conta de médias: erros-padrão automáticos, controles, mais de dois períodos e mais de dois grupos (com efeitos fixos de unidade e de tempo).

**Verificação numérica** (simulação com $\beta_3=1{,}5$ verdadeiro, 400 unidades em 2 períodos): as três vias dão exatamente o mesmo número.

| Via | Estimativa |
|---|---|
| diferença das diferenças de médias | 1,58999746 |
| coeficiente da interação $D\times T$ | 1,58999746 |
| regressão em primeiras diferenças | 1,58999746 |

Erro-padrão da interação: 0,1750.

## 3. A derivação que cai na prova (ex. 71 e 72)

Está em [09_teoria.md](09_teoria.md), D09.8. O esqueleto:

1. Escreva o modelo em $t=1$ e $t=2$ e **tome a diferença**: $\beta_0$ e $\beta_1D_i$ somem, porque não variam no tempo.
$$\Delta y_i=\beta_2+\beta_3D_i+\beta'\Delta x_i+\Delta\varepsilon_i$$
2. Tome a esperança dentro de cada grupo e subtraia:
$$E[\Delta y\mid D=1]-E[\Delta y\mid D=0]=\beta_3+\beta'\big[E(\Delta x\mid D=1)-E(\Delta x\mid D=0)\big]$$
3. **Ex. 72:** se os controles são invariantes no tempo ($x_{it}=x_i$), então $\Delta x_i=0$ e sobra $\beta_3$ puro.

> [!IMPORTANT]
> **A leitura econômica do ex. 72**
> Características fixas no tempo — habilidade, cultura organizacional, geografia — não precisam ser observadas: a primeira diferença as elimina. Em troca, seus efeitos ficam inestimáveis. É o mesmo trade-off dos efeitos fixos em painel.

## 4. A hipótese que segura tudo: tendências paralelas

Na ausência do tratamento, a diferença média entre tratados e controles teria permanecido constante:
$$E[y^{0}_{i,depois}-y^{0}_{i,antes}\mid D=1]=E[y^{0}_{i,depois}-y^{0}_{i,antes}\mid D=0].$$

É uma hipótese sobre um **contrafactual**, logo não testável diretamente. O que se faz na prática:

| Checagem | O que é |
|---|---|
| Tendências pré-tratamento | com mais períodos antes, verificar se as trajetórias eram paralelas (event study) |
| Placebo no tempo | fingir que o tratamento ocorreu num período anterior; o efeito deve ser nulo |
| Placebo no grupo | aplicar a um grupo não tratado |
| Robustez a controles | o efeito muda muito ao incluir covariáveis que variam no tempo? |

Outras exigências: nenhuma composição do grupo mudando por causa do tratamento (não há seleção induzida), ausência de efeito antecipatório e ausência de transbordamento para o controle (SUTVA).

## 5. Erros-padrão

Com poucos grupos e muitos períodos, a autocorrelação serial infla a significância (Bertrand, Duflo e Mullainathan). Padrão mínimo: **cluster na unidade de tratamento**. Com poucos clusters, o cluster convencional ainda é otimista — daí o bootstrap selvagem (*wild cluster bootstrap*).

## 6. Ligações

| Ligação | Onde |
|---|---|
| Interações e dummies, base algébrica | [09_teoria.md](09_teoria.md) |
| Efeitos fixos e within como generalização | [módulo 12 (P2)](../12_painel_I/README.md) |
| FWL: DiD como regressão parcial | [módulo 04](../04_fwl_particionada/04_teoria.md) |
| Quando as tendências paralelas falham: VI | [módulo 10](../10_endogeneidade_iv/10_teoria.md) |
| Script com a simulação | [09_dummies_forma_funcional.R](09_dummies_forma_funcional.R), seção "Ex. 71 e 72" |

> [!TIP]
> **Ponte com a dissertação**
> O DiD compra identificação com uma hipótese sobre trajetórias; o VI compra com uma hipótese sobre exclusão. Quando o paralelismo é duvidoso, a alternativa natural é instrumentar o tratamento — é a mesma conversa de endogeneidade do [módulo 10](../10_endogeneidade_iv/10_teoria.md), vista de outro ângulo.
