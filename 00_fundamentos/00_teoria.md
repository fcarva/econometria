---
title: "Módulo 00 — Fundamentos: esperança, variância e estimadores (teoria)"
modulo: "00"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
greene: "apêndices B, C e D"
slides: "pré-requisito dos slides SL01 e SL02"
lista1: [1, 2, 3, 4, 5, 6, 7, 8, 9]
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
  - Fundamentos
---

# Módulo 00 — Fundamentos

## 0. Mapa

> [!NOTE]
> **O que é, por que importa, onde cai**
> Toda demonstração do curso é uma recombinação de três operadores: esperança, variância e covariância. Os nove primeiros exercícios da Lista 1 são exatamente isso — e reaparecem disfarçados em cada prova, porque não-viés é uma conta de esperança, variância do estimador é uma conta de variância, e consistência é uma conta de limite.

## 1. O kit de operadores

**Esperança.** Linear sempre, com ou sem independência:
$$E[a+bX]=a+bE[X],\qquad E\Big[\sum_i X_i\Big]=\sum_i E[X_i].$$

**Variância.** Para constantes $a$ e $b$:
$$\operatorname{Var}(a+bX)=b^2\operatorname{Var}(X),\qquad \operatorname{Var}(X)=E[X^2]-(E[X])^2 .$$
Para somas:
$$\operatorname{Var}\Big(\sum_i X_i\Big)=\sum_i\operatorname{Var}(X_i)+2\sum_{i\lt j}\operatorname{Cov}(X_i,X_j),$$
e, com independência, as covariâncias somem.

**Covariância.** Bilinear:
$$\operatorname{Cov}(X,Y)=E[XY]-E[X]E[Y],\qquad \operatorname{Cov}(a+bX,c+dY)=bd\operatorname{Cov}(X,Y).$$

**Forma matricial.** Para um vetor aleatório $x$ com matriz de covariância $\Sigma$ e uma matriz de constantes $A$:
$$\operatorname{Var}(Ax)=A\Sigma A' .$$
É esta regra, e só ela, que produz $\operatorname{Var}(b\mid X)=\sigma^2(X'X)^{-1}$ no [módulo 06](../06_amostra_finita_multicol/06_teoria.md).

## 2. Esperança condicional

$$E[y\mid x]=\int y\,f(y\mid x)\,dy$$

Três propriedades que sustentam o curso:

1. **Lei das esperanças iteradas:** $E[y]=E\big[E[y\mid x]\big]$. É como se passa do condicional ao incondicional — usada para mostrar que $E[b]=\beta$ sem condicionar em $X$.
2. **O que é função de $x$ sai:** $E[g(x)\,y\mid x]=g(x)E[y\mid x]$.
3. **Decomposição da variância:** $\operatorname{Var}(y)=\operatorname{Var}\big(E[y\mid x]\big)+E\big[\operatorname{Var}(y\mid x)\big]$ — variação explicada mais variação residual, o análogo populacional de $SQT=SQE+SQR$.

E a hipótese central do modelo, $E[\varepsilon\mid X]=0$, implica $E[\varepsilon]=0$ e $\operatorname{Cov}(X,\varepsilon)=0$ — mas **não** o contrário: covariância nula é condição mais fraca.

## 3. Propriedades de um estimador

| Propriedade | Definição | Onde aparece |
|---|---|---|
| Não-viés | $E[\hat\theta]=\theta$ | D9, ex. 14, 24 |
| Eficiência | menor variância na classe | Gauss-Markov, ex. 33 |
| EQM | $E[(\hat\theta-\theta)^2]=\operatorname{Var}+\text{viés}^2$ | ex. 9, ex. 53 |
| Consistência | $\operatorname{plim}\hat\theta=\theta$ | ex. 3, [módulo 08](../08_assintotica/08_teoria.md) |

### D00.1 · Decomposição do erro quadrático médio

$$EQM(\hat\theta)=E\big[(\hat\theta-\theta)^2\big]=E\big[(\hat\theta-E[\hat\theta]+E[\hat\theta]-\theta)^2\big]$$

Abrindo o quadrado, o termo cruzado é
$$2\,E\big[(\hat\theta-E[\hat\theta])\big]\big(E[\hat\theta]-\theta\big)=0,$$
porque $E[\hat\theta-E[\hat\theta]]=0$ e o segundo fator é constante. Sobram
$$EQM(\hat\theta)=\operatorname{Var}(\hat\theta)+\big[\text{viés}(\hat\theta)\big]^2 .\qquad\blacksquare$$

É a régua que permite comparar um estimador viesado e preciso com outro não viesado e ruidoso — exatamente a discussão do ex. 53 sobre excluir variável.

### D00.2 · Desigualdade de Chebyshev e consistência

Para qualquer variável com variância finita,
$$\Pr\big(\lvert Z-E[Z]\rvert\ge\delta\big)\le\frac{\operatorname{Var}(Z)}{\delta^2}.$$

Aplicada à média amostral, com $\operatorname{Var}(\bar X)=\sigma^2/n$:
$$\Pr\big(\lvert\bar X-\mu\rvert\ge\delta\big)\le\frac{\sigma^2}{n\delta^2}\ \xrightarrow[n\to\infty]{}\ 0,$$
o que é a definição de $\operatorname{plim}\bar X=\mu$. Este é o argumento-modelo: **média zero mais variância indo a zero implica consistência** — o mesmo usado em D08.1 para $X'\varepsilon/n$.

Chebyshev é conservadora: com $\sigma^2=4$, $n=100$ e $\delta=0{,}5$, o limite de Chebyshev é 0,16, o valor pelo TLC é 0,0124 e a frequência simulada, 0,0125. A desigualdade vale sempre; o TLC é preciso quando $n$ é grande.

## 4. Como cai na prova

Raramente como questão isolada: os operadores aparecem **dentro** das demonstrações. O que cai isolado, quando cai, é a decomposição do EQM e a consistência da média.

## 5. Armadilhas

> [!WARNING]
> **Quatro confusões clássicas**
> 1. $\operatorname{Var}(aX)=a^2\operatorname{Var}(X)$, não $a\operatorname{Var}(X)$.
> 2. Covariância zero **não** implica independência, exceto no caso normal conjunto (ex. 7).
> 3. $E[1/X]\neq 1/E[X]$ e $E[g(X)]\neq g(E[X])$ para $g$ não linear (desigualdade de Jensen).
> 4. Esperança **não** atravessa razão de variáveis aleatórias — é por isso que consistência é mais fácil de provar que não-viés.

## 6. Checklist

- [ ] Escrevo as regras de $E$, $\operatorname{Var}$ e $\operatorname{Cov}$ sem hesitar, com as condições de validade.
- [ ] Derivo $EQM=\operatorname{Var}+\text{viés}^2$ em três linhas.
- [ ] Provo a consistência da média amostral por Chebyshev.
- [ ] Explico por que covariância nula não é independência.
- [ ] Uso a lei das esperanças iteradas para passar de $E[\cdot\mid X]$ a $E[\cdot]$.

## 7. Conferência numérica

| chave_R | nota |
|---|---|
| m00_ex2_varteo_n100 | 0,04 |
| m00_ex2_var_n100 | 0,039688 |
| m00_ex3_cheb_n100 | 0,16 |
| m00_ex3_tlc_n100 | 0,012419 |
| m00_ex3_prob_n100 | 0,01245 |

## 8. Referências

- Greene, *Econometric Analysis*, apêndice B (probabilidade e distribuições), C (estimação e inferência) e D (resultados assintóticos).
- Hoffmann, *Estatística para Economistas* — referência citada pela chave da lista para os exercícios 1 a 9.
- Exercícios resolvidos: [00_lista1.md](00_lista1.md).
