### codigo criado por Iuri Santos (iurix_ms@hotmail.com / iuri.santos@tecgraf.puc-rio.br)
# para rodar as funcoes de EstimaDistribuiçao.R
#LIMPA AMBIENTE DE TRABALHO
rm(list=ls())

# #CHAMADA DE PACOTES externa
library(tidyverse) # gera tibbles/dataframes
#library(here)
library(modules)
library(rstudioapi)

###  para rodar o modulo, recomenda-se ter instalado os seguintes pacotes:
# magrittr,dplyr,tidyr,tibble,broom,fitdistrplus,graphics,stats,dgof,actuar,triangle,goftest,grDevices

######### LEITURA DE DADOS ##################
getwd()
setwd(dirname(rstudioapi::getSourceEditorContext()$path))#"C://Users//iuri.santos//Downloads")#here()) # "C://Users//iuri.santos//Downloads") # substituir pelo seu wd

### chamada de modulo
# para chamar funcao, recomendo usar como modelo
# https://cran.r-project.org/web/packages/modules/vignettes/modulesInR.html
# install.packages("modules")
m <- modules::use("estimaDistribuiçao.R")

############# codigo de exemplo #############
# gerando amostras do exemplo
alpha = 10
theta = 150 / 60
# Creates dataframe
df1 = tibble(
  obs = 1:1000,
  y = rgamma(n = 1000, shape = alpha, scale = theta)*100,
  x = rweibull(n = 1000, shape = alpha, scale = theta*10)*100,
  SomaDeHorasApontadasUnitario = append(rweibull(n = 500, shape = alpha, scale = theta*10),
                                        rgamma(n = 500, shape = alpha, scale = theta))*100
)
# Creates another dataframe
df2 = tibble(
  obs = 1:800,
  y = rgamma(n = 800, shape = alpha, scale = theta)*100,
  x = rweibull(n = 800, shape = alpha, scale = theta*10)*100,
  SomaDeHorasApontadasUnitario = append(append(rweibull(n = 300, shape = alpha, scale = theta*10),
                                        rgamma(n = 300, shape = alpha, scale = theta)),
                                        rlnorm(n=200, meanlog = 3.2, sdlog = .3))*100
)
# junta dfs numa lista
dadosTestes<-list(df1,df2)
# testa a funcao
resultadoTeste=m$estima_distribuicao(dadosTestes,TRUE, coluna='x')
# vendo resultado do exemplo
resultadoTeste
#segundo teste
resultadoTeste=m$estima_distribuicao(dadosTestes,TRUE)
# vendo resultado do exemplo
resultadoTeste
#terceiro teste
resultadoTeste=m$estima_distribuicao(dadosTestes,TRUE,quant_amostragens=2)
# vendo resultado do exemplo
resultadoTeste

#quarto teste
resultadoTeste=m$estima_distribuicao(df1,FALSE,quant_amostragens=1)
# vendo resultado do exemplo
resultadoTeste