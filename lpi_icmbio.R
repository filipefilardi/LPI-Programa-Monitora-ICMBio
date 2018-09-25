
# Script para cálculo do LPI
# Baseado nas instruções disponíveis em https://github.com/Zoological-Society-of-London/rlpi
# Adaptado por Elildo Carvalho Jr, ICMBio/CENAP
# Função prepara dados do icmbio e chama funções do pacote rlpi
# Em fase de TESTE

# selecionar diretorio
setwd("/media/elildojr/Dados/r/lpi")

# abrir planilha de dados mastoaves
dados <- read.csv("Planilha_consolidacao_mastoaves_24_05_2018.csv", sep=",")

dados2 <- dados[dados$Espécies.validadas.para.análise.do.ICMBio != "",] # remover linhas com nome de espécie em branco

# Função lpi_icmbio:
lpi_icmbio <- function(x,y,z) # x = dados, y = UC, z = Classe
  {
  library(rlpi) # carrega pacote rlpi
  
  mydata <- x
  
    if(missing(y)) {    mydata <- mydata }
    else {  mydata <- subset(x, Local...Nome.da.Unidade.de.Conservação == y) } # seleciona UC
  
    if(missing(z)) {    mydata <- mydata }
    else {  mydata <- subset(mydata, Classe == z) } # seleciona taxon
  
  colnames(mydata)[20] <- "Binomial"
  mydata$Binomial <- gsub(" ", "_", mydata$Binomial) # necessário para rodar LPIMain
  mydata$Binomial <- as.factor(mydata$Binomial) # pode ser desnecessário, verificar
  mydata$Ano <- as.numeric(mydata$Ano)
  
  # colocar dados no formato exigido pela função LPIMain
  # passo 1, criar objeto a ser preenchido
  mydata2 <- data.frame(matrix(ncol = (2+length(unique(mydata$Ano))), nrow = length(unique(mydata$Binomial))))
  colnames(mydata2) <- c("ID", "Binomial","X2014","X2015","X2016","X2017") # Substituir futuramente por função que cria automaticamente os nomes de colunas de anos
  mydata2$ID <- c(1:nrow(mydata2))
  mydata2$Binomial <- sort(unique(mydata$Binomial))
  
  # passo 2, preencher objeto criado acima
  for(i in 1:nrow(mydata2)) {
    a <- subset(mydata, Binomial == mydata2[i,2])
    ano1 <- subset(a, Ano == 2014) # Substituir futuramente por função que extrai o ano automaticamente
    ano2 <- subset(a, Ano == 2015)
    ano3 <- subset(a, Ano == 2016)
    ano4 <- subset(a, Ano == 2017)
    mydata2[i,3] <-  nrow(ano1)/(sum(subset(mydata, Ano == 2014)$Dias.km.de.amostragem..esforço., na.rm=TRUE)/1000/10)
    mydata2[i,4] <-  nrow(ano2)/(sum(subset(mydata, Ano == 2015)$Dias.km.de.amostragem..esforço., na.rm=TRUE)/1000/10)
    mydata2[i,5] <-  nrow(ano3)/(sum(subset(mydata, Ano == 2016)$Dias.km.de.amostragem..esforço., na.rm=TRUE)/1000/10)
    mydata2[i,6] <-  nrow(ano4)/(sum(subset(mydata, Ano == 2017)$Dias.km.de.amostragem..esforço., na.rm=TRUE)/1000/10)
    }

  mydata3 <<- mydata2 # salva no workspace para conferir se está ok
  
  # criar vetor indice com TRUE para todas as linhas, pois todas as espécies serão incluídas
  index_vector = rep(TRUE, nrow(mydata2))
  
  # criar infile
  mydata_infile <- create_infile(mydata2, index_vector=index_vector, name="mydata_data", start_col_name = "X2014", end_col_name = "X2017", CUT_OFF_YEAR = 2014)
  
  # Calcular LPI com 100 bootstraps
  mydata_lpi <- LPIMain(mydata_infile, REF_YEAR = 2014, PLOT_MAX = 2017, BOOT_STRAP_SIZE = 100, VERBOSE=FALSE)
  
  # Remover NAs (anos seguidos sem dados)
  mydata_lpi <- mydata_lpi[complete.cases(mydata_lpi), ]
  
  # carregar função ggplot_lpi_modif
  source("ggplot_lpi_modif.R")
  
  # Gerar gráfico mais bonito usando função ggplot_lpi_modif
  ggplot_lpi_modif(mydata_lpi, col="cornflowerblue")
  
} # Fim da função

lpi_icmbio(dados2)
lpi_icmbio(dados2,z="Mamíferos")
lpi_icmbio(dados2,z="Aves")

lpi_icmbio(dados2, "Resex Cazumbá-Iracema")
lpi_icmbio(dados2, "Resex Cazumbá-Iracema", "Mamíferos")
lpi_icmbio(dados2, "Resex Cazumbá-Iracema", "Aves")


lpi_icmbio(dados2, "Resex Tapajós-Arapiuns", "Mamíferos")
lpi_icmbio(dados2, "Resex Tapajós-Arapiuns", "Aves")
lpi_icmbio(dados2, "Resex Tapajós-Arapiuns")


lpi_icmbio(dados2, "Esec Terra do Meio", "Mamíferos")
lpi_icmbio(dados2, "Esec Terra do Meio", "Aves")
lpi_icmbio(dados2, "Esec Terra do Meio")

lpi_icmbio(dados2, "Flona do Jamari", "Mamíferos")
lpi_icmbio(dados2, "Flona do Jamari", "Aves")
lpi_icmbio(dados2, "Flona do Jamari")

lpi_icmbio(dados2, "Parna do Juruena", "Mamíferos")
lpi_icmbio(dados2, "Parna do Juruena", "Aves")
lpi_icmbio(dados2, "Parna do Juruena")

lpi_icmbio(dados2, "Rebio Guaribas", "Mamíferos")
lpi_icmbio(dados2, "Rebio Guaribas", "Aves")
lpi_icmbio(dados2, "Rebio Guaribas")

