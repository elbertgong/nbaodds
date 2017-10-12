rm(list=ls())
#install.packages("httr")
library(xml2)
library(rvest)
library(XML)
library(httr)
library(RCurl)

playerlast = "James"
playerfirst = "Lebron"
year = "2010"
number = "01"

url<-paste("https://www.basketball-reference.com/players/",substr(playerlast, start = 1, stop = 1),"/",substr(playerlast, start = 1, stop = 5),substr(playerfirst, start = 1, stop = 2),number,"/gamelog/",year,sep="")
links<-c(url)

text<-c()
for (i in links)
{
  url<- (i)
  urls <- try(url %>% read_html () %>% html_nodes ("#pgl_basic a , .right , .center") %>% html_text () %>% data.frame, silent=TRUE)
  text<-c(text,urls)
}

je <- data.frame(matrix(0,nrow=(length(urls[[1]])-1)/30,ncol=30))

for (i in 1:nrow(je))
{
  je[i,] = urls[[1]][(30*i+1):(30*(i+1))]
}

write.csv(je,file=paste(playerlast,playerfirst,year))
