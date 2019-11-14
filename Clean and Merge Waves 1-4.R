####Libraries####
library(easypackages)
libs<-c("tidyr", "dplyr", "car", "haven")
libraries(libs)
####Read in Data####
dat.123 <- read_sav("Data/mergedpwavesfilesONLYall123.sav")
dat.4 <- read_sav("Data/wave 4 cleaned.sav")
####Merge Datasets together####
dat.1234all<-full_join(dat.123, dat.4, by="CaseId")
saveRDS(dat.1234all, file="waves1234all.rds")
