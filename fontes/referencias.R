# Bibliografia das fontes primárias: fonte única para o .bib e para a lista em Markdown.
# Toda referência com DOI foi conferida no Crossref em 17/09/2026 (título, periódico,
# volume, número e páginas). As sem DOI são livros ou artigos da AER anteriores ao
# registro de DOI, citados pela forma usual.
# Rodar: powershell -ExecutionPolicy Bypass -File scripts\r.ps1 fontes\referencias.R
# Gera: fontes/referencias.bib (importável no Zotero) e fontes/referencias.md

# --- bootstrap: localizar a raiz do repo e carregar helpers ---
.d <- getwd(); while (!file.exists(file.path(.d, ".repo-root")) && dirname(.d) != .d) .d <- dirname(.d)
source(file.path(.d, "R", "raiz.R"))

REFS <- list()
ref <- function(chave, autores, ano, titulo, onde, vol = NA, num = NA, pag = NA,
                doi = NA, tipo = "article", editora = NA, mod = NA) {
  REFS[[chave]] <<- list(chave = chave, autores = autores, ano = ano, titulo = titulo,
                         onde = onde, vol = vol, num = num, pag = pag, doi = doi,
                         tipo = tipo, editora = editora, mod = mod)
}

EMA <- "Econometrica"
JASA <- "Journal of the American Statistical Association"
JOE <- "Journal of Econometrics"
AER <- "American Economic Review"
JEP <- "Journal of Economic Perspectives"
AMS <- "Annals of Mathematical Statistics"
AST <- "The American Statistician"
REST <- "Review of Economics and Statistics"
BERK <- "Proceedings of the Fifth Berkeley Symposium on Mathematical Statistics and Probability"

## ---- MQO, Gauss-Markov, projeção (módulos 00-03) ---------------------------
ref("fisher1922", "Fisher, R. A.", 1922, "On the mathematical foundations of theoretical statistics",
    "Philosophical Transactions of the Royal Society of London, Series A", 222, "594-604", "309-368",
    "10.1098/rsta.1922.0009", mod = "00")
ref("legendre1805", "Legendre, A.-M.", 1805, "Nouvelles méthodes pour la détermination des orbites des comètes",
    NA, tipo = "book", editora = "Paris: Courcier", mod = "02")
ref("gauss1809", "Gauss, C. F.", 1809, "Theoria motus corporum coelestium in sectionibus conicis solem ambientium",
    NA, tipo = "book", editora = "Hamburgo: Perthes et Besser", mod = "02")
ref("gauss1823", "Gauss, C. F.", 1823, "Theoria combinationis observationum erroribus minimis obnoxiae",
    NA, tipo = "book", editora = "Göttingen: Dieterich", mod = "06")
ref("markov1900", "Markov, A. A.", 1900, "Ischislenie veroyatnostei [Cálculo das probabilidades]",
    NA, tipo = "book", editora = "São Petersburgo", mod = "06")
ref("galton1886", "Galton, F.", 1886, "Regression towards mediocrity in hereditary stature",
    "Journal of the Anthropological Institute of Great Britain and Ireland", 15, NA, "246-263",
    "10.2307/2841583", mod = "02")
ref("yule1897", "Yule, G. U.", 1897, "On the theory of correlation",
    "Journal of the Royal Statistical Society", 60, 4, "812-854", "10.2307/2979746", mod = "01")
ref("stigler1981", "Stigler, S. M.", 1981, "Gauss and the invention of least squares",
    "Annals of Statistics", 9, 3, "465-474", "10.1214/aos/1176345451", mod = "02")
ref("plackett1949", "Plackett, R. L.", 1949, "A historical note on the method of least squares",
    "Biometrika", 36, "3/4", "458-460", "10.2307/2332682", mod = "06")
ref("plackett1950", "Plackett, R. L.", 1950, "Some theorems in least squares",
    "Biometrika", 37, "1/2", "149-157", "10.2307/2332158", mod = "03")
ref("aitken1936", "Aitken, A. C.", 1936, "On least squares and linear combination of observations",
    "Proceedings of the Royal Society of Edinburgh", 55, NA, "42-48", "10.1017/S0370164600014346", mod = "03")
ref("neyman1934", "Neyman, J.", 1934,
    "On the two different aspects of the representative method: the method of stratified sampling and the method of purposive selection",
    "Journal of the Royal Statistical Society", 97, 4, "558-625", "10.2307/2342192", mod = "06")
ref("haavelmo1944", "Haavelmo, T.", 1944, "The probability approach in econometrics",
    EMA, 12, "suplemento", "iii-115", "10.2307/1906935", mod = "01")
ref("white1980ier", "White, H.", 1980, "Using least squares to approximate unknown regression functions",
    "International Economic Review", 21, 1, "149-170", "10.2307/2526245", mod = "01")
ref("hoaglin1978", "Hoaglin, D. C.; Welsch, R. E.", 1978, "The hat matrix in regression and ANOVA",
    AST, 32, 1, "17-22", "10.1080/00031305.1978.10479237", mod = "03")
ref("anscombe1973", "Anscombe, F. J.", 1973, "Graphs in statistical analysis",
    AST, 27, 1, "17-21", "10.1080/00031305.1973.10478966", mod = "02")

## ---- FWL (módulo 04) ---------------------------------------------------------
ref("yule1907", "Yule, G. U.", 1907,
    "On the theory of correlation for any number of variables, treated by a new system of notation",
    "Proceedings of the Royal Society of London, Series A", 79, 529, "182-193", "10.1098/rspa.1907.0028", mod = "04")
ref("frisch1933", "Frisch, R.; Waugh, F. V.", 1933, "Partial time regressions as compared with individual trends",
    EMA, 1, 4, "387-401", "10.2307/1907330", mod = "04")
ref("lovell1963", "Lovell, M. C.", 1963, "Seasonal adjustment of economic time series and multiple regression analysis",
    JASA, 58, 304, "993-1010", "10.1080/01621459.1963.10480682", mod = "04")
ref("lovell2008", "Lovell, M. C.", 2008, "A simple proof of the FWL theorem",
    "Journal of Economic Education", 39, 1, "88-91", "10.3200/JECE.39.1.88-91", mod = "04")
ref("ding2021", "Ding, P.", 2021, "The Frisch-Waugh-Lovell theorem for standard errors",
    "Statistics & Probability Letters", 168, NA, "108945", "10.1016/j.spl.2020.108945", mod = "04")
ref("basu2023", "Basu, D.", 2023, "The Yule-Frisch-Waugh-Lovell theorem",
    "arXiv:2307.00369 [econ.EM]", tipo = "misc", mod = "04")

## ---- Ajuste, restrições, multicolinearidade (módulos 05-06) ----------------
ref("ezekiel1930", "Ezekiel, M.", 1930, "Methods of Correlation Analysis", NA,
    tipo = "book", editora = "Nova York: Wiley", mod = "05")
ref("theil1961", "Theil, H.", 1961, "Economic Forecasts and Policy", NA,
    tipo = "book", editora = "2. ed. Amsterdã: North-Holland", mod = "05")
ref("theil1961mixed", "Theil, H.; Goldberger, A. S.", 1961, "On pure and mixed statistical estimation in economics",
    "International Economic Review", 2, 1, "65-78", "10.2307/2525589", mod = "05")
ref("akaike1974", "Akaike, H.", 1974, "A new look at the statistical model identification",
    "IEEE Transactions on Automatic Control", 19, 6, "716-723", "10.1109/TAC.1974.1100705", mod = "05")
ref("schwarz1978", "Schwarz, G.", 1978, "Estimating the dimension of a model",
    "Annals of Statistics", 6, 2, "461-464", "10.1214/aos/1176344136", mod = "05")
ref("frisch1934", "Frisch, R.", 1934, "Statistical Confluence Analysis by Means of Complete Regression Systems",
    NA, tipo = "book", editora = "Oslo: Universitetets Økonomiske Institutt", mod = "06")
ref("farrar1967", "Farrar, D. E.; Glauber, R. R.", 1967, "Multicollinearity in regression analysis: the problem revisited",
    REST, 49, 1, "92-107", "10.2307/1937887", mod = "06")
ref("marquardt1970", "Marquardt, D. W.", 1970,
    "Generalized inverses, ridge regression, biased linear estimation, and nonlinear estimation",
    "Technometrics", 12, 3, "591-612", "10.1080/00401706.1970.10488699", mod = "06")
ref("belsley1980", "Belsley, D. A.; Kuh, E.; Welsch, R. E.", 1980,
    "Regression Diagnostics: Identifying Influential Data and Sources of Collinearity", NA,
    tipo = "book", editora = "Nova York: Wiley", mod = "06")
ref("goldberger1991", "Goldberger, A. S.", 1991, "A Course in Econometrics", NA,
    tipo = "book", editora = "Cambridge, MA: Harvard University Press", mod = "06")

## ---- Testes (módulo 07) ------------------------------------------------------
ref("wald1943", "Wald, A.", 1943,
    "Tests of statistical hypotheses concerning several parameters when the number of observations is large",
    "Transactions of the American Mathematical Society", 54, 3, "426-482",
    "10.1090/S0002-9947-1943-0012401-3", mod = "07")
ref("rao1948", "Rao, C. R.", 1948,
    "Large sample tests of statistical hypotheses concerning several parameters with applications to problems of estimation",
    "Mathematical Proceedings of the Cambridge Philosophical Society", 44, 1, "50-57",
    "10.1017/S0305004100023987", mod = "07")
ref("silvey1959", "Silvey, S. D.", 1959, "The Lagrangian multiplier test",
    AMS, 30, 2, "389-407", "10.1214/aoms/1177706259", mod = "07")
ref("berndt1977", "Berndt, E. R.; Savin, N. E.", 1977,
    "Conflict among criteria for testing hypotheses in the multivariate linear regression model",
    EMA, 45, 5, "1263-1277", "10.2307/1914072", mod = "07")
ref("breusch1979conflict", "Breusch, T. S.", 1979, "Conflict among criteria for testing hypotheses: extensions and comments",
    EMA, 47, 1, "203-207", "10.2307/1912356", mod = "07")
ref("engle1984", "Engle, R. F.", 1984, "Wald, likelihood ratio, and Lagrange multiplier tests in econometrics",
    "Handbook of Econometrics, v. 2 (Griliches, Z.; Intriligator, M. D., orgs.)", NA, NA, "775-826",
    "10.1016/S1573-4412(84)02005-5", tipo = "incollection", editora = "Amsterdã: North-Holland", mod = "07")
ref("bowman1975", "Bowman, K. O.; Shenton, L. R.", 1975,
    "Omnibus test contours for departures from normality based on sqrt(b1) and b2",
    "Biometrika", 62, 2, "243-250", "10.1093/biomet/62.2.243", mod = "07")
ref("jarque1980", "Jarque, C. M.; Bera, A. K.", 1980,
    "Efficient tests for normality, homoscedasticity and serial independence of regression residuals",
    "Economics Letters", 6, 3, "255-259", "10.1016/0165-1765(80)90024-5", mod = "07")
ref("jarque1987", "Jarque, C. M.; Bera, A. K.", 1987, "A test for normality of observations and regression residuals",
    "International Statistical Review", 55, 2, "163-172", "10.2307/1403192", mod = "07")
ref("ramsey1969", "Ramsey, J. B.", 1969,
    "Tests for specification errors in classical linear least-squares regression analysis",
    "Journal of the Royal Statistical Society, Series B", 31, 2, "350-371",
    "10.1111/j.2517-6161.1969.tb00796.x", mod = "07")
ref("ramsey1976", "Ramsey, J. B.; Schmidt, P.", 1976,
    "Some further results on the use of OLS and BLUS residuals in specification error tests",
    JASA, 71, 354, "389-390", "10.1080/01621459.1976.10480355", mod = "07")
ref("chow1960", "Chow, G. C.", 1960, "Tests of equality between sets of coefficients in two linear regressions",
    EMA, 28, 3, "591-605", "10.2307/1910133", mod = "07, 09")
ref("toyoda1974", "Toyoda, T.", 1974, "Use of the Chow test under heteroscedasticity",
    EMA, 42, 3, "601-608", "10.2307/1911796", mod = "07, 09")
ref("breusch1979bp", "Breusch, T. S.; Pagan, A. R.", 1979,
    "A simple test for heteroscedasticity and random coefficient variation",
    EMA, 47, 5, "1287-1294", "10.2307/1911963", mod = "07")
ref("koenker1981", "Koenker, R.", 1981, "A note on studentizing a test for heteroscedasticity",
    JOE, 17, 1, "107-112", "10.1016/0304-4076(81)90062-2", mod = "07")
ref("white1980", "White, H.", 1980,
    "A heteroskedasticity-consistent covariance matrix estimator and a direct test for heteroskedasticity",
    EMA, 48, 4, "817-838", "10.2307/1912934", mod = "07, 08")
ref("durbin1950", "Durbin, J.; Watson, G. S.", 1950, "Testing for serial correlation in least squares regression. I",
    "Biometrika", 37, "3/4", "409-428", "10.2307/2332391", mod = "07")
ref("durbin1951", "Durbin, J.; Watson, G. S.", 1951, "Testing for serial correlation in least squares regression. II",
    "Biometrika", 38, "1/2", "159-178", "10.2307/2332325", mod = "07")
ref("durbin1970", "Durbin, J.", 1970,
    "Testing for serial correlation in least-squares regression when some of the regressors are lagged dependent variables",
    EMA, 38, 3, "410-421", "10.2307/1909547", mod = "07")
ref("breusch1978", "Breusch, T. S.", 1978, "Testing for autocorrelation in dynamic linear models",
    "Australian Economic Papers", 17, 31, "334-355", "10.1111/j.1467-8454.1978.tb00635.x", mod = "07")
ref("godfrey1978", "Godfrey, L. G.", 1978,
    "Testing against general autoregressive and moving average error models when the regressors include lagged dependent variables",
    EMA, 46, 6, "1293-1301", "10.2307/1913829", mod = "07")

## ---- Assintótica e inferência robusta (módulo 08) ---------------------------
ref("doob1935", "Doob, J. L.", 1935, "The limiting distributions of certain statistics",
    AMS, 6, 3, "160-169", "10.1214/aoms/1177732594", mod = "08")
ref("mann1943", "Mann, H. B.; Wald, A.", 1943, "On stochastic limit and order relationships",
    AMS, 14, 3, "217-226", "10.1214/aoms/1177731415", mod = "08")
ref("eicker1967", "Eicker, F.", 1967, "Limit theorems for regressions with unequal and dependent errors",
    BERK, 1, NA, "59-82", tipo = "incollection", editora = "Berkeley: University of California Press", mod = "08")
ref("huber1967", "Huber, P. J.", 1967, "The behavior of maximum likelihood estimates under nonstandard conditions",
    BERK, 1, NA, "221-233", tipo = "incollection", editora = "Berkeley: University of California Press", mod = "08")
ref("mackinnon1985", "MacKinnon, J. G.; White, H.", 1985,
    "Some heteroskedasticity-consistent covariance matrix estimators with improved finite sample properties",
    JOE, 29, 3, "305-325", "10.1016/0304-4076(85)90158-7", mod = "08")
ref("long2000", "Long, J. S.; Ervin, L. H.", 2000,
    "Using heteroscedasticity consistent standard errors in the linear regression model",
    AST, 54, 3, "217-224", "10.1080/00031305.2000.10474549", mod = "08")
ref("oehlert1992", "Oehlert, G. W.", 1992, "A note on the delta method",
    AST, 46, 1, "27-29", "10.1080/00031305.1992.10475842", mod = "08")

## ---- Dummies, forma funcional, DiD (módulo 09) -----------------------------
ref("suits1957", "Suits, D. B.", 1957, "Use of dummy variables in regression equations",
    JASA, 52, 280, "548-551", "10.1080/01621459.1957.10501412", mod = "09")
ref("halvorsen1980", "Halvorsen, R.; Palmquist, R.", 1980,
    "The interpretation of dummy variables in semilogarithmic equations", AER, 70, 3, "474-475", mod = "09")
ref("kennedy1981", "Kennedy, P. E.", 1981,
    "Estimation with correctly interpreted dummy variables in semilogarithmic equations", AER, 71, 4, "801", mod = "09")
ref("giles1982", "Giles, D. E. A.", 1982, "The interpretation of dummy variables in semilogarithmic equations",
    "Economics Letters", 10, "1-2", "77-79", "10.1016/0165-1765(82)90119-7", mod = "09")
ref("box1964", "Box, G. E. P.; Cox, D. R.", 1964, "An analysis of transformations",
    "Journal of the Royal Statistical Society, Series B", 26, 2, "211-243",
    "10.1111/j.2517-6161.1964.tb00553.x", mod = "09")
ref("snow1855", "Snow, J.", 1855, "On the Mode of Communication of Cholera", NA,
    tipo = "book", editora = "2. ed. Londres: John Churchill", mod = "09")
ref("ashenfelter1978", "Ashenfelter, O.", 1978, "Estimating the effect of training programs on earnings",
    REST, 60, 1, "47-57", "10.2307/1924332", mod = "09")
ref("ashenfelter1985", "Ashenfelter, O.; Card, D.", 1985,
    "Using the longitudinal structure of earnings to estimate the effect of training programs",
    REST, 67, 4, "648-660", "10.2307/1924810", mod = "09")
ref("card1994", "Card, D.; Krueger, A. B.", 1994,
    "Minimum wages and employment: a case study of the fast-food industry in New Jersey and Pennsylvania",
    AER, 84, 4, "772-793", mod = "09")
ref("bertrand2004", "Bertrand, M.; Duflo, E.; Mullainathan, S.", 2004,
    "How much should we trust differences-in-differences estimates?",
    "Quarterly Journal of Economics", 119, 1, "249-275", "10.1162/003355304772839588", mod = "09")
ref("chaisemartin2020", "de Chaisemartin, C.; D'Haultfoeuille, X.", 2020,
    "Two-way fixed effects estimators with heterogeneous treatment effects",
    AER, 110, 9, "2964-2996", "10.1257/aer.20181169", mod = "09")
ref("callaway2021", "Callaway, B.; Sant'Anna, P. H. C.", 2021, "Difference-in-differences with multiple time periods",
    JOE, 225, 2, "200-230", "10.1016/j.jeconom.2020.12.001", mod = "09")
ref("goodmanbacon2021", "Goodman-Bacon, A.", 2021, "Difference-in-differences with variation in treatment timing",
    JOE, 225, 2, "254-277", "10.1016/j.jeconom.2021.03.014", mod = "09")
ref("roth2023", "Roth, J.; Sant'Anna, P. H. C.; Bilinski, A.; Poe, J.", 2023,
    "What's trending in difference-in-differences? A synthesis of the recent econometrics literature",
    JOE, 235, 2, "2218-2244", "10.1016/j.jeconom.2023.03.008", mod = "09")

## ---- Endogeneidade e VI (módulo 10) -----------------------------------------
ref("spearman1904", "Spearman, C.", 1904, "The proof and measurement of association between two things",
    "American Journal of Psychology", 15, 1, "72-101", "10.2307/1412159", mod = "10")
ref("wright1928", "Wright, P. G.", 1928, "The Tariff on Animal and Vegetable Oils", NA,
    tipo = "book", editora = "Nova York: Macmillan", mod = "10")
ref("reiersol1941", "Reiersøl, O.", 1941,
    "Confluence analysis by means of lag moments and other methods of confluence analysis",
    EMA, 9, 1, "1-24", "10.2307/1907171", mod = "10")
ref("haavelmo1943", "Haavelmo, T.", 1943, "The statistical implications of a system of simultaneous equations",
    EMA, 11, 1, "1-12", "10.2307/1905714", mod = "10")
ref("haavelmo1947", "Haavelmo, T.", 1947, "Methods of measuring the marginal propensity to consume",
    JASA, 42, 237, "105-122", "10.1080/01621459.1947.10501917", mod = "10")
ref("anderson1949", "Anderson, T. W.; Rubin, H.", 1949,
    "Estimation of the parameters of a single equation in a complete system of stochastic equations",
    AMS, 20, 1, "46-63", "10.1214/aoms/1177730090", mod = "10")
ref("durbin1954", "Durbin, J.", 1954, "Errors in variables",
    "Review of the International Statistical Institute", 22, "1/3", "23-32", "10.2307/1401917", mod = "10")
ref("basmann1957", "Basmann, R. L.", 1957,
    "A generalized classical method of linear estimation of coefficients in a structural equation",
    EMA, 25, 1, "77-83", "10.2307/1907743", mod = "10")
ref("sargan1958", "Sargan, J. D.", 1958, "The estimation of economic relationships using instrumental variables",
    EMA, 26, 3, "393-415", "10.2307/1907619", mod = "10")
ref("wu1973", "Wu, D.-M.", 1973, "Alternative tests of independence between stochastic regressors and disturbances",
    EMA, 41, 4, "733-750", "10.2307/1914093", mod = "10")
ref("griliches1977", "Griliches, Z.", 1977, "Estimating the returns to schooling: some econometric problems",
    EMA, 45, 1, "1-22", "10.2307/1913285", mod = "10")
ref("hausman1978", "Hausman, J. A.", 1978, "Specification tests in econometrics",
    EMA, 46, 6, "1251-1271", "10.2307/1913827", mod = "10")
ref("hansen1982", "Hansen, L. P.", 1982, "Large sample properties of generalized method of moments estimators",
    EMA, 50, 4, "1029-1054", "10.2307/1912775", mod = "10")
ref("leamer1983", "Leamer, E. E.", 1983, "Let's take the con out of econometrics", AER, 73, 1, "31-43", mod = "10")
ref("cornwell1988", "Cornwell, C.; Rupert, P.", 1988,
    "Efficient estimation with panel data: an empirical comparison of instrumental variables estimators",
    "Journal of Applied Econometrics", 3, 2, "149-155", "10.1002/jae.3950030206", mod = "07")
ref("nelson1990", "Nelson, C. R.; Startz, R.", 1990,
    "Some further results on the exact small sample properties of the instrumental variable estimator",
    EMA, 58, 4, "967-976", "10.2307/2938359", mod = "10")
ref("angrist1991", "Angrist, J. D.; Krueger, A. B.", 1991,
    "Does compulsory school attendance affect schooling and earnings?",
    "Quarterly Journal of Economics", 106, 4, "979-1014", "10.2307/2937954", mod = "10")
ref("imbens1994", "Imbens, G. W.; Angrist, J. D.", 1994,
    "Identification and estimation of local average treatment effects",
    EMA, 62, 2, "467-475", "10.2307/2951620", mod = "10")
ref("bound1995", "Bound, J.; Jaeger, D. A.; Baker, R. M.", 1995,
    "Problems with instrumental variables estimation when the correlation between the instruments and the endogenous explanatory variable is weak",
    JASA, 90, 430, "443-450", "10.1080/01621459.1995.10476536", mod = "10")
ref("card1995", "Card, D.", 1995,
    "Using geographic variation in college proximity to estimate the return to schooling",
    "Aspects of Labour Market Behaviour: Essays in Honour of John Vanderkamp (Christofides, L. N.; Grant, E. K.; Swidinsky, R., orgs.)",
    NA, NA, "201-222", tipo = "incollection", editora = "Toronto: University of Toronto Press", mod = "10")
ref("staiger1997", "Staiger, D.; Stock, J. H.", 1997, "Instrumental variables regression with weak instruments",
    EMA, 65, 3, "557-586", "10.2307/2171753", mod = "10")
ref("card2001", "Card, D.", 2001,
    "Estimating the return to schooling: progress on some persistent econometric problems",
    EMA, 69, 5, "1127-1160", "10.1111/1468-0262.00237", mod = "10")
ref("angrist2001", "Angrist, J. D.; Krueger, A. B.", 2001,
    "Instrumental variables and the search for identification: from supply and demand to natural experiments",
    JEP, 15, 4, "69-85", "10.1257/jep.15.4.69", mod = "10")
ref("stock2002", "Stock, J. H.; Wright, J. H.; Yogo, M.", 2002,
    "A survey of weak instruments and weak identification in generalized method of moments",
    "Journal of Business & Economic Statistics", 20, 4, "518-529", "10.1198/073500102288618658", mod = "10")
ref("stock2003", "Stock, J. H.; Trebbi, F.", 2003, "Retrospectives: who invented instrumental variable regression?",
    JEP, 17, 3, "177-194", "10.1257/089533003769204416", mod = "10")
ref("stock2005", "Stock, J. H.; Yogo, M.", 2005, "Testing for weak instruments in linear IV regression",
    "Identification and Inference for Econometric Models: Essays in Honor of Thomas Rothenberg (Andrews, D. W. K.; Stock, J. H., orgs.)",
    NA, NA, "80-108", "10.1017/CBO9780511614491.006", tipo = "incollection",
    editora = "Cambridge: Cambridge University Press", mod = "10")
ref("angrist2010", "Angrist, J. D.; Pischke, J.-S.", 2010,
    "The credibility revolution in empirical economics: how better research design is taking the con out of econometrics",
    JEP, 24, 2, "3-30", "10.1257/jep.24.2.3", mod = "10")
ref("montielolea2013", "Montiel Olea, J. L.; Pflueger, C.", 2013, "A robust test for weak instruments",
    "Journal of Business & Economic Statistics", 31, 3, "358-369", "10.1080/00401706.2013.806694", mod = "10")
ref("andrews2019", "Andrews, I.; Stock, J. H.; Sun, L.", 2019,
    "Weak instruments in instrumental variables regression: theory and practice",
    "Annual Review of Economics", 11, NA, "727-753", "10.1146/annurev-economics-080218-025643", mod = "10")
ref("lee2022", "Lee, D. S.; McCrary, J.; Moreira, M. J.; Porter, J.", 2022, "Valid t-ratio inference for IV",
    AER, 112, 10, "3260-3290", "10.1257/aer.20211063", mod = "10")

## ---- Geração -------------------------------------------------------------------
tem <- function(x) !is.null(x) && length(x) == 1 && !is.na(x) && nzchar(as.character(x))
pag_md <- function(p) gsub("-", "–", p, fixed = TRUE)

ordem <- order(vapply(REFS, function(r) paste(tolower(r$autores), r$ano), ""))
REFS <- REFS[ordem]

# --- BibTeX ---
bib <- character()
for (r in REFS) {
  campos <- c(sprintf("  author = {%s}", gsub("; ", " and ", r$autores, fixed = TRUE)),
              sprintf("  year = {%s}", r$ano),
              sprintf("  title = {{%s}}", r$titulo))
  if (r$tipo == "article" && tem(r$onde)) campos <- c(campos, sprintf("  journal = {%s}", r$onde))
  if (r$tipo == "incollection") campos <- c(campos, sprintf("  booktitle = {%s}", r$onde))
  if (r$tipo == "misc") campos <- c(campos, sprintf("  howpublished = {%s}", r$onde))
  if (tem(r$vol)) campos <- c(campos, sprintf("  volume = {%s}", r$vol))
  if (tem(r$num)) campos <- c(campos, sprintf("  number = {%s}", r$num))
  if (tem(r$pag)) campos <- c(campos, sprintf("  pages = {%s}", gsub("-", "--", r$pag, fixed = TRUE)))
  if (tem(r$editora)) campos <- c(campos, sprintf("  publisher = {%s}", r$editora))
  if (tem(r$doi)) campos <- c(campos, sprintf("  doi = {%s}", r$doi))
  bib <- c(bib, sprintf("@%s{%s,", r$tipo, r$chave), paste(campos, collapse = ",\n"), "}", "")
}
writeLines(enc2utf8(c("% Gerado por fontes/referencias.R. Não editar à mão.", "", bib)),
           file.path(raiz(), "fontes", "referencias.bib"), useBytes = TRUE)

# --- Markdown ---
linha_md <- function(r) {
  tit <- if (r$tipo == "book") paste0("*", r$titulo, "*") else r$titulo
  if (!grepl("[?.!]\\**$", tit)) tit <- paste0(tit, ".")
  s <- sprintf("%s (%s). %s", r$autores, r$ano, tit)
  if (r$tipo == "article" && tem(r$onde)) {
    s <- paste0(s, " *", r$onde, "*")
    if (tem(r$vol)) s <- paste0(s, ", v. ", r$vol)
    if (tem(r$num)) s <- paste0(s, ", n. ", r$num)
    if (tem(r$pag)) s <- paste0(s, ", p. ", pag_md(r$pag))
    s <- paste0(s, ".")
  } else if (r$tipo == "incollection") {
    s <- paste0(s, " In: *", r$onde, "*")
    if (tem(r$vol)) s <- paste0(s, ", v. ", r$vol)
    if (tem(r$pag)) s <- paste0(s, ", p. ", pag_md(r$pag))
    if (tem(r$editora)) s <- paste0(s, ". ", r$editora)
    s <- paste0(s, ".")
  } else if (r$tipo == "misc") {
    s <- paste0(s, " ", r$onde, ".")
  } else if (tem(r$editora)) {
    s <- paste0(s, " ", r$editora, ".")
  }
  if (tem(r$doi)) s <- paste0(s, " [doi:", r$doi, "](https://doi.org/", r$doi, ")")
  if (tem(r$mod)) s <- paste0(s, " · módulo ", r$mod)
  paste0("- ", s)
}
cabec <- c(
  "---",
  "title: \"Referências das fontes primárias\"",
  "disciplina: Econometria I (PECO-5021/6021)",
  "tags:",
  "  - econometria",
  "  - fontes",
  "aliases:",
  "  - Referências",
  "---",
  "",
  "# Referências",
  "",
  "> [!NOTE]",
  "> **Arquivo gerado**",
  sprintf("> Gerado por [referencias.R](referencias.R), que também produz o [BibTeX](referencias.bib) para importar no Zotero. São %d referências. Todas as que têm DOI foram conferidas no Crossref (título, periódico, volume, número e páginas); as sem DOI são livros ou artigos da *American Economic Review* anteriores ao registro de DOI.", length(REFS)),
  ""
)
writeLines(enc2utf8(c(cabec, vapply(REFS, linha_md, ""), "")),
           file.path(raiz(), "fontes", "referencias.md"), useBytes = TRUE)
cat(sprintf("%d referências gravadas em fontes/referencias.bib e fontes/referencias.md\n", length(REFS)))
