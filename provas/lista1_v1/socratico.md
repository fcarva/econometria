---
title: "Perguntas que levam às demonstrações — Lista 1 v.1"
disciplina: Econometria I (PECO-5021/6021)
professor: Edson Zambon Monte
periodo: 2026/2
relevancia_p1: alta
status: verificado
tags:
  - econometria
  - mestrado/ppgeco
  - p1
  - roteiro
aliases:
  - Material socrático
---

# Perguntas que levam às demonstrações

As dezesseis seções são as mesmas do [algoritmo das resoluções](algoritmo.md). Aqui cada uma é uma escada de perguntas: começa no que parece óbvio e sobe, uma pergunta puxando a seguinte, até a demonstração ficar inevitável. A última pergunta de cada seção é a armadilha que costuma custar ponto.

> [!TIP]
> **Como ler**
> Tape a resposta, responda em voz alta ou no papel, depois confira. Quando uma resposta não sair, não avance: a pergunta seguinte depende dela. Ao terminar a seção, vá ao algoritmo de mesmo número e escreva a demonstração inteira sem olhar.

---

## 1 · Equações normais e os estimadores da regressão simples

**P1.** Se você tivesse de passar uma reta por uma nuvem de pontos, que critério usaria para dizer que uma reta é melhor que outra?

*R.* Medir o quanto ela erra. O MQO mede pelos resíduos ao quadrado, $\sum\widehat u_i^2$: quadrado para que erros positivos e negativos não se cancelem e para punir mais os erros grandes.

**P2.** Esse critério é uma função de quê?

*R.* Dos dois números que definem a reta, $\widehat\beta_1$ e $\widehat\beta_2$. Os dados estão fixos; o que se escolhe é a reta.

**P3.** Como se acha o mínimo de uma função de duas variáveis?

*R.* Igualando a zero as duas derivadas parciais. Isso dá duas equações — as equações normais.

**P4.** O que a derivada em relação ao intercepto diz, em palavras?

*R.* Que $\sum\widehat u_i=0$: os resíduos somam zero. A reta não fica sistematicamente acima nem abaixo dos pontos.

**P5.** E a derivada em relação à inclinação?

*R.* Que $\sum X_i\widehat u_i=0$: os resíduos não guardam relação linear com $X$. Se guardassem, daria para inclinar mais a reta e errar menos.

**P6.** Da primeira equação, dividida por $n$, o que sai?

*R.* $\bar Y=\widehat\beta_1+\widehat\beta_2\bar X$, ou seja, $\widehat\beta_1=\bar Y-\widehat\beta_2\bar X$: a reta passa pelo ponto médio.

**P7.** Levando isso para a segunda equação, por que se pode trocar $X_i$ por $X_i-\bar X$ dentro das somas?

*R.* Porque a diferença entre as duas versões é $\bar X$ vezes uma soma de desvios em torno da média, e essa soma é zero.

**P8.** Então o que é $\widehat\beta_2$, em linguagem de estatística descritiva?

*R.* Covariância amostral entre $X$ e $Y$ dividida pela variância amostral de $X$: $S_{XY}/S_{XX}$.

**P9.** Como saber que o ponto encontrado é mínimo, e não máximo?

*R.* Pela segunda ordem: a Hessiana tem determinante $4nS_{XX}$, positivo desde que $X$ varie. Sem variação em $X$, não há inclinação a estimar.

**Armadilha.** "As equações normais são $\sum\widehat u_i=0$ e $\sum\widehat u_i^2$ mínimo." Errado: a segunda equação normal é $\sum X_i\widehat u_i=0$, uma condição de ortogonalidade, não o critério.

---

## 2 · O estimador matricial e a condição de mínimo

**P1.** Com $K$ regressores, quantas equações normais existem?

*R.* $K$ — uma por coeficiente. Escrever todas à mão é inviável; a forma matricial as empilha.

**P2.** Como escrever a soma dos quadrados dos resíduos com matrizes?

*R.* $S(\beta)=(\mathbf y-\mathbf X\beta)'(\mathbf y-\mathbf X\beta)$: um vetor transposto vezes ele mesmo é a soma dos quadrados dos seus elementos.

**P3.** Ao expandir, aparecem $\mathbf y'\mathbf X\beta$ e $\beta'\mathbf X'\mathbf y$. Por que viram um só termo?

*R.* Porque cada um é um escalar ($1\times 1$) e é a transposta do outro. Um escalar é igual à sua transposta.

**P4.** Quais regras de derivação vetorial você precisa?

*R.* Duas: a derivada de $\mathbf a'\beta$ é $\mathbf a$; a derivada de $\beta'\mathbf A\beta$, com $\mathbf A$ simétrica, é $2\mathbf A\beta$.

**P5.** O que dá a condição de primeira ordem?

*R.* $-2\mathbf X'\mathbf y+2\mathbf X'\mathbf X\beta=\mathbf 0$, isto é, $\mathbf X'\mathbf X\mathbf b=\mathbf X'\mathbf y$.

**P6.** O que é preciso para "dividir" por $\mathbf X'\mathbf X$?

*R.* Que ela seja invertível. É aí que entra o posto completo, H3.

**P7.** Por que posto completo garante a inversa?

*R.* Porque $\mathbf c'\mathbf X'\mathbf X\mathbf c=(\mathbf X\mathbf c)'(\mathbf X\mathbf c)$ é uma soma de quadrados, e com posto completo $\mathbf X\mathbf c\neq\mathbf 0$ para todo $\mathbf c\neq\mathbf 0$. Então a forma é positiva, a matriz é positiva definida e, portanto, invertível.

**P8.** E a segunda ordem?

*R.* A Hessiana é $2\mathbf X'\mathbf X$, positiva definida pelo mesmo argumento: é um mínimo.

**P9.** O que acontece na matriz do ex. 19, em que uma coluna é o dobro da outra?

*R.* Existe $\mathbf c\neq\mathbf 0$ com $\mathbf X\mathbf c=\mathbf 0$; $\mathbf X'\mathbf X$ é singular; os dois coeficientes envolvidos não podem ser separados — só uma combinação deles é identificada.

**Armadilha.** "Como $\mathbf X$ é $n\times K$, $(\mathbf X'\mathbf X)^{-1}=\mathbf X^{-1}(\mathbf X')^{-1}$." Errado: $\mathbf X$ não é quadrada e não tem inversa; só $\mathbf X'\mathbf X$, que é $K\times K$.

---

## 3 · Projeção, *residual maker* e a decomposição da variação

**P1.** Os resíduos dependem de $\mathbf y$ de que forma?

*R.* Linear: $\mathbf e=\mathbf y-\mathbf X(\mathbf X'\mathbf X)^{-1}\mathbf X'\mathbf y=\mathbf M\mathbf y$. A matriz $\mathbf M$ "fabrica resíduos".

**P2.** O que acontece se você aplicar $\mathbf M$ a uma coluna de $\mathbf X$?

*R.* Dá zero: $\mathbf M\mathbf X=\mathbf 0$. O resíduo de regredir $\mathbf X$ nela mesma é nulo.

**P3.** E se aplicar $\mathbf M$ duas vezes?

*R.* O mesmo que uma: $\mathbf M\mathbf M=\mathbf M$. Tirar a parte explicada de algo que já não tem parte explicada não muda nada.

**P4.** Qual a consequência de $\mathbf M\mathbf X=\mathbf 0$ para a relação entre resíduos e erros?

*R.* $\mathbf e=\mathbf M(\mathbf X\beta+\varepsilon)=\mathbf M\varepsilon$: os resíduos são os erros "limpos" da parte que $\mathbf X$ consegue imitar.

**P5.** Por que $\mathbf X'\mathbf e=\mathbf 0$?

*R.* $\mathbf X'\mathbf e=\mathbf X'\mathbf M\mathbf y=(\mathbf M\mathbf X)'\mathbf y=\mathbf 0$. São as equações normais de novo.

**P6.** Se $\mathbf X$ tem uma coluna de uns, o que a primeira linha de $\mathbf X'\mathbf e=\mathbf 0$ diz?

*R.* $\sum e_i=0$. Por isso a média dos ajustados é igual à média de $Y$.

**P7.** E a matriz $\mathbf P=\mathbf I-\mathbf M$?

*R.* Projeta $\mathbf y$ no espaço gerado pelas colunas de $\mathbf X$: $\widehat{\mathbf y}=\mathbf P\mathbf y$. Como $\mathbf P\mathbf M=\mathbf 0$, ajustados e resíduos são ortogonais.

**P8.** De $\mathbf y=\widehat{\mathbf y}+\mathbf e$ com as duas partes ortogonais, o que sai para as somas de quadrados?

*R.* Um "Pitágoras": centrando tudo na média, $SQT=SQE+SQR$. Daí $R^2=SQE/SQT$.

**P9.** Quanto vale $\operatorname{tr}(\mathbf P)$, e por que importa?

*R.* $K$, pela ciclicidade do traço. Então $\operatorname{tr}(\mathbf M)=n-K$: são os graus de liberdade dos resíduos, o divisor de $s^2$.

**Armadilha.** "$SQT=SQE+SQR$ vale sempre." Só vale com intercepto: sem a coluna de uns, $\sum e_i\neq 0$ e o termo cruzado não some (ex. 32).

---

## 4 · Frisch-Waugh-Lovell e o viés de variável omitida

**P1.** Numa regressão com dois blocos de regressores, $\mathbf X_1$ e $\mathbf X_2$, o que o coeficiente de $\mathbf X_2$ mede?

*R.* O efeito de $\mathbf X_2$ mantendo $\mathbf X_1$ constante. A pergunta é: como isso aparece na álgebra?

**P2.** Se você limpasse de $\mathbf y$ e de $\mathbf X_2$ tudo o que $\mathbf X_1$ explica, o que sobraria?

*R.* Os resíduos $\mathbf M_1\mathbf y$ e $\mathbf M_1\mathbf X_2$: as partes de $\mathbf y$ e $\mathbf X_2$ sem relação linear com $\mathbf X_1$.

**P3.** Regredindo um resíduo no outro, o que você obtém?

*R.* Exatamente $\mathbf b_2$ da regressão completa. É o teorema de FWL.

**P4.** Como prová-lo a partir das equações normais em blocos?

*R.* Isole $\mathbf b_1$ na primeira linha, substitua na segunda e agrupe: aparece $\mathbf X_2'\mathbf M_1\mathbf X_2\,\mathbf b_2=\mathbf X_2'\mathbf M_1\mathbf y$.

**P5.** Por que isso é "resíduo em resíduo"?

*R.* Porque $\mathbf M_1$ é simétrica e idempotente: $\mathbf X_2'\mathbf M_1\mathbf y=(\mathbf M_1\mathbf X_2)'(\mathbf M_1\mathbf y)$.

**P6.** Qual o caso mais simples, com $\mathbf X_1=\iota$?

*R.* $\mathbf M_1$ subtrai a média. A inclinação com intercepto é a regressão dos desvios sem intercepto — o ex. 31.

**P7.** Agora inverta a pergunta: e se você **não** incluir uma variável que deveria estar no modelo?

*R.* Seu efeito vai para o erro. Se ela for correlacionada com a incluída, o coeficiente da incluída absorve parte desse efeito.

**P8.** De quanto é o viés?

*R.* $\beta_3\widehat\delta_{32}$: o efeito da omitida vezes a inclinação da regressão da omitida na incluída.

**P9.** Quando o viés é zero?

*R.* Se a omitida não afeta $Y$ ($\beta_3=0$) ou se não é correlacionada com a incluída ($\widehat\delta_{32}=0$).

**P10.** E incluir uma variável que não deveria estar?

*R.* Não vicia — o modelo continua correto —, mas a variância dos outros coeficientes aumenta se ela for correlacionada com eles.

**Armadilha.** "Omitir uma variável relevante sempre vicia." Só se ela for correlacionada com as incluídas; se não for, o custo é só de precisão.

---

## 5 · O pivô: não-viés e variância

**P1.** $\mathbf b$ é um número ou uma variável aleatória?

*R.* Variável aleatória: muda de amostra para amostra porque depende de $\mathbf y$, que depende de $\varepsilon$.

**P2.** Como deixar explícita essa dependência de $\varepsilon$?

*R.* Substituindo $\mathbf y=\mathbf X\beta+\varepsilon$ em $\mathbf b$: $\mathbf b=\beta+(\mathbf X'\mathbf X)^{-1}\mathbf X'\varepsilon$. Essa é a identidade que resolve quase tudo.

**P3.** Para $\mathbf b$ ser não viesado, o que precisa acontecer com o segundo termo?

*R.* Ter média zero. Dado $\mathbf X$, a matriz na frente de $\varepsilon$ é constante; basta $E(\varepsilon\mid\mathbf X)=\mathbf 0$ — H2.

**P4.** E se $\mathbf X$ for aleatório?

*R.* Condiciona-se em $\mathbf X$ e depois usa-se a lei das esperanças iteradas: $E(\mathbf b)=E\big(E(\mathbf b\mid\mathbf X)\big)=\beta$.

**P5.** Para a variância, o que se calcula?

*R.* $E\big((\mathbf b-\beta)(\mathbf b-\beta)'\mid\mathbf X\big)$, e $\mathbf b-\beta=\mathbf A\varepsilon$ com $\mathbf A=(\mathbf X'\mathbf X)^{-1}\mathbf X'$.

**P6.** Que hipótese aparece quando a esperança chega a $\varepsilon\varepsilon'$?

*R.* H4: $E(\varepsilon\varepsilon'\mid\mathbf X)=\sigma^2\mathbf I$. Diagonal constante é homocedasticidade; zeros fora da diagonal, ausência de autocorrelação.

**P7.** E o resultado?

*R.* $\sigma^2\mathbf A\mathbf A'=\sigma^2(\mathbf X'\mathbf X)^{-1}$.

**P8.** Na regressão simples, como fica o pivô?

*R.* $\widehat\beta_2=\beta_2+\sum w_iu_i$, com $w_i=(X_i-\bar X)/S_{XX}$ — porque $\sum w_i=0$ e $\sum w_iX_i=1$ matam $\beta_1$ e deixam $\beta_2$ inteiro.

**P9.** E a variância da inclinação?

*R.* $\sigma^2\sum w_i^2=\sigma^2/S_{XX}$. Quanto mais espalhado $X$, mais precisa a estimativa.

**P10.** O que a multicolinearidade faz com essa variância?

*R.* Multiplica por $VIF_k=1/(1-R_k^2)$, em que $R_k^2$ é o ajuste de $X_k$ nos demais regressores. Variância alta, mas nenhum viés.

**Armadilha.** "Heterocedasticidade vicia o MQO." Não: o não-viés usa só H2. O que cai com a heterocedasticidade é a fórmula da variância — e com ela os erros-padrão.

---

## 6 · Gauss-Markov: por que o MQO é MELNV

**P1.** "Melhor" em relação a quê?

*R.* À menor variância, dentro de uma classe: estimadores **lineares** em $\mathbf y$ e **não viesados**.

**P2.** Como escrever um estimador linear qualquer, comparável ao MQO?

*R.* $\mathbf b^*=[(\mathbf X'\mathbf X)^{-1}\mathbf X'+\mathbf C]\mathbf y$: o MQO mais um desvio $\mathbf C$.

**P3.** Que condição o não-viés impõe a $\mathbf C$?

*R.* $\mathbf C\mathbf X=\mathbf 0$, porque $E(\mathbf b^*\mid\mathbf X)=(\mathbf I+\mathbf C\mathbf X)\beta$ precisa valer para todo $\beta$.

**P4.** Ao calcular $\operatorname{Var}(\mathbf b^*\mid\mathbf X)$, aparecem termos cruzados entre o MQO e $\mathbf C$. Por que somem?

*R.* Porque contêm $\mathbf C\mathbf X$, que é zero pela condição anterior.

**P5.** O que sobra?

*R.* $\operatorname{Var}(\mathbf b^*)=\operatorname{Var}(\mathbf b)+\sigma^2\mathbf C\mathbf C'$.

**P6.** Por que $\mathbf C\mathbf C'$ "aumenta" a variância?

*R.* Porque é semidefinida positiva: para qualquer $\mathbf d$, $\mathbf d'\mathbf C\mathbf C'\mathbf d$ é a soma dos quadrados de $\mathbf C'\mathbf d$.

**P7.** Em qual passo H4 foi usada?

*R.* Ao trocar $E(\varepsilon\varepsilon'\mid\mathbf X)$ por $\sigma^2\mathbf I$. Sem isso, os termos cruzados não somem e o MQO perde a coroa.

**P8.** A normalidade foi usada?

*R.* Não. Gauss-Markov vale sem H5.

**Armadilha.** "MQO é o melhor estimador." Só entre os lineares e não viesados: um estimador viesado pode ter erro quadrático médio menor.

---

## 7 · $E(s^2)=\sigma^2$: o truque do traço

**P1.** Se $\sigma^2$ é a variância dos erros, por que não estimá-la por $\sum e_i^2/n$?

*R.* Porque os resíduos são sistematicamente menores que os erros: $\mathbf b$ foi escolhido justamente para minimizar $\sum e_i^2$.

**P2.** Como escrever $\mathbf e'\mathbf e$ em termos dos erros?

*R.* $\mathbf e=\mathbf M\varepsilon$, logo $\mathbf e'\mathbf e=\varepsilon'\mathbf M\varepsilon$.

**P3.** Como tirar a esperança de uma forma quadrática?

*R.* Transformando o escalar em traço: $\varepsilon'\mathbf M\varepsilon=\operatorname{tr}(\mathbf M\varepsilon\varepsilon')$. Agora $\varepsilon\varepsilon'$ está sozinho, pronto para a esperança.

**P4.** E então?

*R.* $E(\mathbf e'\mathbf e\mid\mathbf X)=\operatorname{tr}(\mathbf M\sigma^2\mathbf I)=\sigma^2(n-K)$.

**P5.** Qual o divisor certo?

*R.* $n-K$: $s^2=\mathbf e'\mathbf e/(n-K)$ tem esperança $\sigma^2$.

**Armadilha.** "$s^2$ é não viesado por causa da lei dos grandes números." Não: não-viés é de amostra finita e vem do traço. A lei dos grandes números dá a consistência (§8).

---

## 8 · Consistência e normalidade assintótica

**P1.** O que significa um estimador ser consistente?

*R.* Que a probabilidade de ele se afastar do verdadeiro valor por mais que qualquer $\delta$ vai a zero quando $n$ cresce.

**P2.** Como provar isso para a média amostral?

*R.* Com Chebyshev: a probabilidade é no máximo $\sigma^2/(n\delta^2)$, que vai a zero.

**P3.** No pivô $\mathbf b=\beta+(\mathbf X'\mathbf X)^{-1}\mathbf X'\varepsilon$, por que dividir e multiplicar por $n$?

*R.* Para transformar somas que crescem em médias que convergem: $(\mathbf X'\mathbf X/n)^{-1}(\mathbf X'\varepsilon/n)$.

**P4.** Para onde vai cada média?

*R.* $\mathbf X'\mathbf X/n\to\mathbf Q$, finita e invertível; $\mathbf X'\varepsilon/n\to\mathbf 0$, porque tem média zero e variância que encolhe como $1/n$.

**P5.** Qual teorema junta os dois limites?

*R.* Slutsky: o plim de uma função contínua é a função dos plims. $\operatorname{plim}\mathbf b=\beta+\mathbf Q^{-1}\mathbf 0=\beta$.

**P6.** Se $\mathbf b$ é não viesado, por que se importar com consistência?

*R.* Porque há casos em que o não-viés falha e a consistência sobrevive — como o modelo com $Y_{t-1}$ —, e porque consistência garante que mais dados levam à verdade.

**P7.** Por que o modelo com $Y_{t-1}$ é viesado mas consistente?

*R.* O erro de hoje entra no regressor de amanhã (falha a exogeneidade estrita), mas não se correlaciona com o regressor de hoje (vale a contemporânea).

**P8.** E a distribuição de $\mathbf b$ quando os erros não são normais?

*R.* Pelo TLC, $\sqrt n(\mathbf b-\beta)$ fica aproximadamente $N(\mathbf 0,\sigma^2\mathbf Q^{-1})$. Por isso $t$ e $F$ valem com $n$ grande sem H5.

**P9.** E $s^2$?

*R.* Escrevendo $\mathbf e'\mathbf e=\varepsilon'\varepsilon-\varepsilon'\mathbf X(\mathbf X'\mathbf X)^{-1}\mathbf X'\varepsilon$ e dividindo por $n$: o primeiro termo vai a $\sigma^2$, o segundo a zero.

**Armadilha.** "Consistência é não-viés com $n$ grande." Não: são propriedades diferentes. Um estimador pode ser viesado e consistente, ou não viesado e inconsistente.

---

## 9 · Testes $t$ e $F$, intervalo de confiança

**P1.** Um coeficiente estimado de 0,84 é "grande"?

*R.* Depende da precisão. Só faz sentido em unidades de erro-padrão: $t_{cal}=0{,}84/0{,}20=4{,}2$.

**P2.** Que distribuição o $t$ segue, e com quantos graus de liberdade?

*R.* $t$ de Student com $n-k$ graus de liberdade sob H5; aproximadamente normal com $n$ grande.

**P3.** Qual a relação entre o teste $t$ e o intervalo de confiança?

*R.* O IC de 95% reúne os valores de $\beta$ que não seriam rejeitados a 5%. "IC sem o zero" é o mesmo que "rejeita $\beta=0$".

**P4.** Como testar várias restrições ao mesmo tempo?

*R.* Comparando o ajuste com e sem elas: se impor as restrições piora muito o $SQR$, elas são incompatíveis com os dados.

**P5.** "Piora muito" em relação a quê?

*R.* À variância residual do modelo irrestrito: $F=\dfrac{(SQR_R-SQR_{UR})/q}{SQR_{UR}/(n-k)}$.

**P6.** Por que o numerador é dividido por $q$?

*R.* Para medir a perda média por restrição. $q$ é o número de restrições, não o número de parâmetros.

**P7.** E se só houver o $R^2$?

*R.* Para a significância global, divida tudo por $SQT$: $F=\dfrac{R^2/(k-1)}{(1-R^2)/(n-k)}$.

**P8.** Com um único regressor, o $F$ global e o $t$ da inclinação dizem coisas diferentes?

*R.* Não: $F=t^2$, e as conclusões coincidem.

**P9.** Pode o $F$ rejeitar e nenhum $t$ rejeitar?

*R.* Sim, com multicolinearidade: o bloco explica, mas nenhum regressor isolado tem precisão suficiente.

**P10.** Por que preferir $F$ ao qui-quadrado de Wald em amostra pequena?

*R.* Porque o $F$ leva em conta que $\sigma^2$ foi estimado por $s^2$; o Wald trata $\sigma^2$ como conhecido.

**Armadilha.** "No $F$ por SQR, SQR é a soma da regressão." Nos ex. 41–42 a lista usa essa sigla assim, mas no $F$ de restrições SQR é a soma dos resíduos. Defina a sigla na primeira linha.

---

## 10 · Output de MQO em log: interpretar sem errar

**P1.** Se $\ln Y$ é a dependente e $X$ entra em nível, o que um coeficiente de 0,085 significa?

*R.* Uma unidade a mais de $X$ está associada a cerca de 8,5% a mais em $Y$.

**P2.** Por que "cerca de"?

*R.* Porque $100\beta$ é a aproximação para $\beta$ pequeno; o exato é $100(e^{\beta}-1)$.

**P3.** E se $X$ também estiver em log?

*R.* Aí o coeficiente é uma elasticidade: 1% a mais em $X$, $\beta\%$ a mais em $Y$, constante em toda a curva.

**P4.** Como ler um coeficiente de dummy em log, como $-0{,}18$ para mulheres?

*R.* Aproximadamente 18% menos; exatamente $100(e^{-0{,}18}-1)=-16{,}5\%$.

**P5.** Se o modelo tem $EXP$ e $EXP^2$, qual é o efeito de um ano a mais de experiência?

*R.* Depende do nível: $\beta_2+2\beta_3EXP$.

**P6.** Onde esse efeito é zero?

*R.* Em $EXP^*=-\beta_2/(2\beta_3)$: o pico, se $\beta_3<0$.

**P7.** Como testar se a experiência importa?

*R.* Com $F$ para $EXP$ e $EXP^2$ juntos — testar só um deles responde outra pergunta.

**P8.** O $R^2$ de 0,42 é "baixo"?

*R.* Diz que 42% da variação do log-salário é explicada linearmente. Em corte transversal isso é comum; o $R^2$ não mede a validade dos coeficientes.

**Armadilha.** "Se o JB rejeita a normalidade, os testes não valem." Com $n$ grande valem, pela normalidade assintótica (§8).

---

## 11 · Dummies, mudança estrutural e diferenças em diferenças

**P1.** Por que não incluir uma dummy para cada região junto com o intercepto?

*R.* Porque as dummies somam a coluna de uns: colinearidade perfeita, $\mathbf X'\mathbf X$ singular.

**P2.** Então o que o coeficiente de uma dummy mede?

*R.* A diferença em relação à categoria omitida.

**P3.** E para comparar duas categorias que não são a base?

*R.* Testar a diferença dos coeficientes, com a covariância entre eles no erro-padrão — ou trocar a base.

**P4.** Como deixar uma relação mudar depois de uma data?

*R.* Somando uma dummy (muda o intercepto) e a dummy vezes $X$ (muda a inclinação).

**P5.** Como testar se houve mudança?

*R.* $H_0$: os dois coeficientes novos são zero, juntos, por $F$. Juntos porque a mudança pode estar em qualquer um.

**P6.** E se a inclinação muda, mas a função não pode saltar?

*R.* Use $(X-X_0)D$ sem a dummy sozinha: o termo vale zero em $X_0$, então os dois ramos se encontram.

**P7.** No DiD, o que a primeira diferença no tempo faz com as características fixas de cada indivíduo?

*R.* Elimina todas, observadas ou não, porque não mudam entre os dois períodos.

**P8.** Então o que sobra para medir o efeito do tratamento?

*R.* $\beta_3$: a diferença entre a variação média dos tratados e a dos não tratados, descontada a diferença na variação dos controles.

**Armadilha.** "Testar a mudança estrutural com dois $t$ separados." Não responde à pergunta conjunta e pode falhar quando $D$ e $D\cdot X$ são correlacionados.

---

## 12 · Por que o MQO falha sob endogeneidade

**P1.** No pivô escalar $\widehat\beta_1=\beta_1+\sum x_iu_i/\sum x_i^2$, o que precisa acontecer para o MQO acertar com muitos dados?

*R.* A média $\sum x_iu_i/n$ tem de ir a zero, isto é, $\operatorname{Cov}(X,u)=0$.

**P2.** E se não for?

*R.* $\operatorname{plim}\widehat\beta_1=\beta_1+\operatorname{Cov}(X,u)/\operatorname{Var}(X)$: um viés que não some com $n$.

**P3.** Quais são as três fontes clássicas de $\operatorname{Cov}(X,u)\neq 0$?

*R.* Variável omitida correlacionada, erro de medição no regressor e simultaneidade.

**P4.** No modelo keynesiano, por que a renda é endógena na função consumo?

*R.* Porque a renda inclui o consumo, e o consumo inclui o choque $\mu_t$: um choque positivo eleva o consumo e, pela identidade, a renda.

**P5.** Como mostrar isso formalmente?

*R.* Pela forma reduzida: $Y_t$ escrita só com o investimento e o choque contém $\mu_t/(1-\beta_1)$, e daí $\operatorname{Cov}(Y_t,\mu_t)=\sigma^2/(1-\beta_1)$.

**P6.** Em que direção vai o viés?

*R.* Para cima, porque a covariância é positiva: a propensão marginal a consumir sai superestimada.

**Armadilha.** "Com amostra grande, o viés de endogeneidade some." Esse é o viés que não some: é inconsistência.

---

## 13 · Erro de medição: na dependente × no regressor

**P1.** Se $Y$ é medido com erro, para onde vai esse erro no modelo?

*R.* Para o termo de erro: $v_i=\mu_i+\varepsilon_i$.

**P2.** Isso cria correlação com o regressor?

*R.* Não, se o erro de medição não tem relação com $X$. O MQO continua não viesado.

**P3.** Então nada muda?

*R.* Muda a variância: $(\sigma_\mu^2+\sigma_\varepsilon^2)/\sum(x_i-\bar x)^2$, maior que sem o erro. Estimativa menos precisa.

**P4.** E se o erro estiver em $X$?

*R.* O regressor observado contém $w_i$, e o erro composto contém $-\beta w_i$: $\operatorname{Cov}(z,X)=-\beta\sigma_w^2$.

**P5.** Qual a consequência?

*R.* H2 cai: viés e inconsistência. $\operatorname{plim}b=\beta\,\sigma_{X^*}^2/(\sigma_{X^*}^2+\sigma_w^2)$.

**P6.** Por que se chama atenuação?

*R.* Porque o fator está entre 0 e 1: a estimativa é puxada para zero.

**Armadilha.** "Erro de medição sempre vicia." Na dependente, não; no regressor, sim.

---

## 14 · Variáveis instrumentais: as condições e o estimador

**P1.** Se $X$ está correlacionado com o erro, que tipo de variável ajudaria?

*R.* Uma que mexa com $X$ mas não tenha nada a ver com o erro: um instrumento.

**P2.** Quais são as duas condições, formalmente?

*R.* Relevância, $\operatorname{Cov}(Z,X)\neq 0$; exogeneidade, $\operatorname{Cov}(Z,u)=0$.

**P3.** Qual delas dá para testar?

*R.* A relevância, pelo primeiro estágio. A exogeneidade só é testável quando há instrumentos sobrando.

**P4.** No modelo simples, como o estimador de VI aproveita as duas condições?

*R.* $\operatorname{plim}\widehat\beta_1^{IV}=\beta_1+\operatorname{Cov}(Z,u)/\operatorname{Cov}(Z,X)$: a exogeneidade zera o numerador; a relevância evita dividir por quase zero.

**P5.** O que acontece com um instrumento fraco?

*R.* O denominador fica perto de zero: qualquer pequena violação da exogeneidade é amplificada, e a variância explode.

**P6.** Com $L=K$, de onde sai o estimador matricial?

*R.* Da condição de momento $\operatorname{plim}(\mathbf Z'\varepsilon/n)=\mathbf 0$, imitada na amostra por $\mathbf Z'(\mathbf y-\mathbf X\widehat\beta)=\mathbf 0$. Resolvendo: $\widehat\beta_{IV}=(\mathbf Z'\mathbf X)^{-1}\mathbf Z'\mathbf y$.

**P7.** Por que ele é consistente?

*R.* Pela mesma conta do MQO em §8, com $\mathbf Z'$ no lugar de $\mathbf X'$: $(\mathbf Z'\mathbf X/n)^{-1}(\mathbf Z'\varepsilon/n)\to\mathbf 0$.

**P8.** E com mais instrumentos que regressores?

*R.* MQ2E: projete $\mathbf X$ nos instrumentos e use a projeção no lugar de $\mathbf X$.

**Armadilha.** "Um instrumento forte resolve tudo." Forte e inválido continua inconsistente: só troca uma fonte de viés por outra.

---

## 15 · O output do `ivreg`

**P1.** Na fórmula do ex. 77, à esquerda da barra estão o log do preço e o log da renda; à direita, o log da renda, `tdiff` e o imposto especial. Quem é endógena?

*R.* `log(price)`: aparece à esquerda da barra e não à direita. Os instrumentos externos são `tdiff` e `I(tax/cpi)`.

**P2.** No teste de instrumentos fracos, rejeitar $H_0$ é bom ou ruim?

*R.* Bom: $H_0$ é "instrumentos fracos".

**P3.** O que o Wu-Hausman compara?

*R.* MQO e VI. Se o regressor é exógeno, os dois são consistentes e devem dar resultados parecidos; se é endógeno, só o VI acerta e a diferença cresce.

**P4.** Com $p=0{,}0469$ a 5%, o que se conclui?

*R.* Rejeita-se a exogeneidade: use VI/MQ2E. Pelo número impresso — o $p$ verdadeiro daquela estatística seria 0,0569.

**P5.** O que o Sargan testa, e com quantos graus de liberdade?

*R.* Se os instrumentos são válidos, com $L-K$ graus de liberdade: o número de instrumentos que sobram.

**P6.** Por que o Sargan não existe com um instrumento só?

*R.* Porque, exatamente identificado, o VI zera todas as condições de momento por construção; não sobra nada para testar.

**P7.** O Sargan não rejeitar prova que os instrumentos são válidos?

*R.* Não: ele detecta incompatibilidade entre instrumentos. Se todos forem inválidos do mesmo jeito, ele não percebe.

**P8.** O coeficiente $-1{,}28$ de `log(price)` diz que a demanda é elástica?

*R.* A estimativa pontual sim, mas o teste de $\beta=-1$ dá $t\approx-1{,}15$: não dá para rejeitar elasticidade unitária.

**Armadilha.** Decidir o Wu-Hausman pelo $p$ "de memória". O professor troca os números entre versões: leia o do enunciado.

---

## 16 · Violações das hipóteses: o quadro da seção 1

**P1.** Que hipótese, se violada, vicia o MQO?

*R.* Só H2, a exogeneidade estrita.

**P2.** Heterocedasticidade viola qual?

*R.* H4. O MQO segue não viesado e consistente, mas deixa de ser o mais eficiente e os erros-padrão usuais ficam errados.

**P3.** Como se detecta a heterocedasticidade?

*R.* Breusch-Pagan: regride-se $\widehat u_i^2$ nos regressores e compara-se $nR^2_{aux}$ com um qui-quadrado.

**P4.** E a autocorrelação?

*R.* Durbin-Watson: $d\approx 2(1-\widehat\rho)$; $d$ bem abaixo de 2 indica autocorrelação positiva.

**P5.** Multicolinearidade alta viola alguma hipótese?

*R.* Não — só a perfeita viola H3. A alta infla variâncias (VIF), sem viés.

**P6.** Mudar a escala de $Y$ muda a significância?

*R.* Não: coeficiente e erro-padrão mudam na mesma proporção, e $t$ e $R^2$ ficam iguais.

**P7.** Duas séries com tendência, sem relação nenhuma, podem dar $R^2$ alto?

*R.* Sim: regressão espúria. Sintoma: $R^2$ maior que o DW. Remédio: diferenciar.

**Armadilha.** "Autocorrelação nunca vicia." Com $Y_{t-1}$ entre os regressores e erro autocorrelacionado, vicia e torna inconsistente.
