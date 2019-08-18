rm(list=ls())
library(tidyverse)
header<-c('BestMarket', 'Alcohol',
'Malic acid',
'Ash',
'Alcalinity of ash',
'Magnesium',
'Total phenols',
'Flavanoids',
'Nonflavanoid phenols',
'Proanthocyanins',
'Color intensity',
'Hue',
'OD280/OD315 of diluted wines',
'Proline')
read_csv('wine.data',col_names = header)%>%
  mutate(BestMarket=factor(BestMarket,
                             labels = c('Australia','Europe','Japan')))->w

rownames_to_column(w,var = 'ID')->wwn

old<-sample_frac(wwn,size = 0.7)
new<-anti_join(wwn,old,by="ID")
newr<-sample_n(new,53,replace = F)

select(old,-ID)%>%saveRDS('ExistingWines.rds')

select(new,-ID,-BestMarket)%>%saveRDS('NewWines.rds')
pull(new,BestMarket)%>%saveRDS('Test_y.rds')
