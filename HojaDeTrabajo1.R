
#Autores 
#Andrea Elias
#Diego Estrada
#Randy Venegas

# Hoja de Trabajo 1 - Analisis Exploratorio

library(dplyr)

setwd("C:\Users\diego\Documents\Universidad\7mo Semestre\Mineria\HDT1-Mineria-de-Datos")
movies <- read.csv("tmdb-movies.csv",header = TRUE)

#Inciso 1
summary(movies)
head(movies)

#Inciso 2
glimpse(movies)

#Inciso 3
#Variables cuantitativas.
library(e1071)
popularity = movies$popularity
kurtosis(popularity)

popularity = movies$popularity
kurtosis(popularity)

budget = movies$budget
kurtosis(budget)

revenue = movies$revenue
kurtosis(revenue)

runtime = movies$runtime
kurtosis(runtime)

vote_count = movies$vote_count
kurtosis(vote_count)

vote_average = movies$vote_average
kurtosis(vote_average)
hist(vote_average)

revenue_adj = movies$revenue_adj
kurtosis(revenue_adj)

budget_adj = movies$budget_adj
kurtosis(budget_adj)

#variables cualitativas

library(tidyr)

original_title <- data.frame(table(movies$original_title))

cast <- data.frame(table(do.call(c, lapply(movies$cast, function(x) unlist(strsplit(x, "\\|"))))))

homepage <- data.frame(table(movies$homepage))
homepage[homepage == ""] <- NA
homepage <- na.omit(homepage)

director <- data.frame(table(movies$director))
director[director == ""] <- NA
director <- na.omit(director)

tagline <- data.frame(table(movies$tagline))
tagline[tagline == ""] <- NA
tagline <- na.omit(tagline)

keywords <- data.frame(table(do.call(c, lapply(movies$keywords, function(x) unlist(strsplit(x, "\\|"))))))

overview <- data.frame(table(movies$overview))
overview[overview == ""] <- NA
overview <- na.omit(overview)

genres <- data.frame(table(do.call(c, lapply(movies$genres, function(x) unlist(strsplit(x, "\\|"))))))

production_companies <- data.frame(table(do.call(c, lapply(movies$production_companies, function(x) unlist(strsplit(x, "\\|"))))))

release_year <- data.frame(table(movies$release_year))

release_date <- data.frame(table(movies$release_date))

#4.1
budget<-movies[with(movies,order(-movies$budget)),1:6]
head(budget,10)

#4.2
budget<-movies[with(movies,order(-movies$revenue)),1:6]
head(budget,10)

#4.3
budget<-movies[with(movies,order(-movies$vote_count)),1:6]
head(budget$original_title,1)

#4.4
budget<-movies[with(movies,order(movies$vote_average)),1:6]
head(budget$original_title,1)

#4.5
movies$cuenta <- 1
movies 
years <- aggregate (movies$cuenta, by = list(movies$release_year), FUN = sum)
vec <- c (years)

colors = c("black","red","blue","grey","orange","pink","purple")
barplot(vec$x, names.arg = vec$Group.1, xlab = "año", ylab ="Cantidad de Licas",main = "Promedio de perdidas",col=colors)

#4.6
popularity<-movies[with(movies,order(-movies$popularity)),]
head(popularity$genres,20)

library(tidyr)
category<-popularity %>%separate(genres,c("categoria1","categoria2","categoria3","categoria4"),sep="\\|")
head(category$categoria1,20)


#4.7
graph <-aggregate(category$cuenta, by=list(category$categoria1), FUN=sum)
vec <- c(graph)

colors = c("black","red","blue","grey","orange","pink","purple")
barplot(vec$x, names.arg = vec$Group.1, xlab = "Genero", ylab ="Frecuencia",main = "¿Cuál es el género que predomina en el conjunto de datos? ",col=colors)


#4.8
ganancias<-aggregate(category$revenue, by=list(category$categoria1), FUN=sum)
View(ganancias)

#4.9
presupuesto2<-aggregate(category$budget, by=list(category$categoria1), FUN=sum)
View(presupuesto2)

#4.10
votaciones<-category[with(category,order(-category$vote_average)),1:10]
top20 = head(votaciones,30)
director<-aggregate(top20$vote_average, by=list(top20$director), FUN=sum)
View(director)

                    
#4.11
ingresos <-data.frame(movies$budget,movies$revenue, movies$original_title)
library(MASS)
cor(x=ingresos[,1], y=ingresos[,2])
plot(ingresos[,1], ingresos[,2], main="¿Cómo se correlacionan los presupuestos con los ingresos? " ,xlab="Budget", ylab="Revenue")
abline(lm(ingresos[,2]~ingresos[,1]), col="pink")
 #4.12
month<-movies %>%separate(release_date,c("mes","dia","anio"),sep="\\/")
ingresos1<-aggregate(month$revenue, by=list(month$mes), FUN=mean)
View(ingresos1)
vectorGraph <-(ingresos1)
colors = c("black","red","blue","grey","orange","pink","purple")
barplot(vectorGraph$x, names.arg = vectorGraph$Group.1, xlab = "mes", ylab ="ganancias", col=colors)
                    
#4.13
library(tidyr)
month<-movies %>%separate(release_date,c("mes","dia","anio"),sep="\\/")
                    View(sort(table(month$mes), decreasing = TRUE))
                    
 #4.14
exito<-data.frame(movies$revenue,movies$popularity, movies$original_title)
plot(exito[,2], ingresos[,1], main="Diagrama de Dispersion", xlab="Popularity", ylab="Revenue")
abline(lm(ingresos[,1]~exito[,2]), col="blue")
                    
#4.15
longtime<-category[with(category,order(-category$runtime)),]
head(longtime$categoria1,10)
                      
                      
                      