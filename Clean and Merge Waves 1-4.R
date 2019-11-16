####Libraries####
library(easypackages)
libs<-c("tidyr", "dplyr", "car", "haven")
libraries(libs)
####Read in Data####
dat.1 <- read_sav("Data/wave1 clean.sav")
dat.2<- read_sav("Data/wave 2 cleaned.sav")
dat.3 <- read_sav("Data/wave 3 cleaned.sav")
dat.4 <- read_sav("Data/wave 4 cleaned.sav")
####Merge Datasets together####
dat.12<-full_join(dat.1, dat.2, by="CaseId")
dat.123<-full_join(dat.12, dat.3, by='CaseId')
dat.1234all<-full_join(dat.123, dat.4, by='CaseId')
saveRDS(dat.1234all, file="waves1234all.rds")
