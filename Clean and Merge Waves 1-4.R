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
#### Fix wave Variable
for(x in 1:nrow(dat.1234all)){
  if(is.na(dat.1234all$wave.x[x])) {dat.1234all$wave_1[x]=0}
  else if(dat.1234all$wave.x[x]==1) {dat.1234all$wave_1[x]=1}
  else{dat.1234all$wave_1[x]=0}
  
  if(is.na(dat.1234all$wave.y[x])) {dat.1234all$wave_2[x]=0}
  else if(dat.1234all$wave.y[x]==2) {dat.1234all$wave_2[x]=1}
  else{dat.1234all$wave_2[x]=0}
    
  if(is.na(dat.1234all$wave[x])) {dat.1234all$wave_3[x]=0}
  else if(dat.1234all$wave[x]==3) {dat.1234all$wave_3[x]=1}
  else{dat.1234all$wave_3[x]=0}
  
  if(is.na(dat.1234all$wave_4[x])) {dat.1234all$wave_4[x]=0}
  else if(dat.1234all$wave_4[x]==4) {dat.1234all$wave_4[x]=1}
  else{dat.1234all$wave_4[x]=0}
}

####Save Dataframe####
saveRDS(dat.1234all, file="waves1234all.rds")
write_sav(dat.1234all, path="waves1234all.sav")
