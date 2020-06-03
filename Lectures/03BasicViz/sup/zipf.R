rm(list=ls())
library(tidyverse)
library(rvest)
library(purrr)
library(magrittr)
#url<-'http://australianpolitics.com/constitution/text/complete'
url<-'AusConstitution.html'
read_html(url)%>%
  html_nodes('p')%>%
  magrittr::extract(4:334)%>%
  map_chr(html_text)%>%
  paste(collapse = ' ')->AusCons
  
AusCons%>%
  tolower()%>%
  gsub('[[:punct:] ]+',' ',.)%>%
  strsplit(' ')%>%
  table%>%
  as_tibble()%>%
  arrange(desc(n))->AusConsFreq
  
AusConsFreq<-mutate(AusConsFreq,Word=.,Freq=n,Rank=1:NROW(AusConsFreq))


write_csv(AusConsFreq,'../data/AusConstitution.csv')

##Avengers Endgame

#url<-'https://www.springfieldspringfield.co.uk/movie_script.php?movie=avengers-endgame'
url<-'Avengers.html'
read_html(url)%>%
  html_nodes(css='.scrolling-script-container')%>%
  map_chr(html_text)->Avengers

Avengers%>%
  tolower()%>%
  gsub('[[:punct:] ]+',' ',.)%>%
  gsub("[\r\n]", "", .)%>%
  strsplit(' ')%>%
  table%>%
  as_tibble()%>%
  arrange(desc(n))->AvengersFreq

AvengersFreq<-mutate(AvengersFreq,Word=.,Freq=n)%>%
  filter(!(Word %in% c('t','s')))%>%
  mutate(Rank=1:(NROW(AvengersFreq)-2))



write_csv(AvengersFreq,'../data/Avengers.csv')

### Tao bao


url<-'https://world.taobao.com/'
read_html(url)%>%
  html_text%>%
  gsub("[^\U4E00-\U9FFF\U3000-\U303F]", "", .)%>%
  strsplit(split = '')%>%
  magrittr::extract2(1)%>%
  table%>%
  as_tibble()%>%
  arrange(desc(n))-> TaoBao
TaoBao<-rename(TaoBao,Character=.,Freq=n)%>%
  mutate(Rank=1:(NROW(TaoBao)))



write_csv(TaoBao,'../data/TaoBao.csv')
