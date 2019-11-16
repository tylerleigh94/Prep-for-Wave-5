####Libraries####
library(easypackages)
libs<-c("tidyverse", "dplyr", "car")
libraries(libs)
####Load in the data####
dat <- 
  readRDS("~/Desktop/R Programs/Research--Diana/Amerispeak/Prep for Wave 5/waves1234all.rds")
####Analyses####
# Perceived Inequality Analyses
## Code variance of FAIR1,3,4
dat$eco.var_3 <- NA
for(x in 1:nrow(dat)){
  if(is.na(dat$FAIR1_W3[x]) | is.na(dat$FAIR3_W3[x]) | is.na(dat$FAIR4_W3[x])) {dat$eco.var_3[x]<-NA}
  else {dat$eco.var_3[x]<- sd(c(dat$FAIR1_W3[x], dat$FAIR3_W3[x], dat$FAIR4_W3[x]))}
}
dat$eco.var_4<-NA
for (x in 1:nrow(dat)) {
  if(is.na(dat$FAIR1_W4[x]) | is.na(dat$FAIR3_W4[x]) | is.na(dat$FAIR4_W4[x])) {dat$eco.var_4[x]<-NA}
  else (dat$eco.var_4[x]<- sd(c(dat$FAIR1_W4[x], dat$FAIR3_W4[x], dat$FAIR4_W4[x])))
}
## Check for correlations between waves
cor.test(dat$eco.var_3, dat$eco.var_4)
cor.test(dat$ecoperc_3, dat$ecoperc_4)
cor.test(dat$perecoperc_3, dat$perecoperc_4)
## Check for correlation with GAP1
cor.test(dat$gap1r_4, dat$eco.var_4)
## Correlations with overall economic performance
cor.test(dat$eco.var_3, dat$ecoperc_3)
cor.test(dat$eco.var_4, dat$ecoperc_4)
cor.test(dat$eco.var_3, dat$perecoperc_3)
cor.test(dat$eco.var_4, dat$perecoperc_4)
psych::alpha(dat[,c(1319, 1184, 1189)], check.keys = T)
# Government Trust
##Pull the data and summarize
dat.govt.trust<- dat %>%
  select(govttrust_1, govttrust_2, govttrust_3, govttrust_4, party3_1, party3_2, party3_3, party3_4) %>%
  pivot_longer(everything(),names_to=c(".value", "wave"), names_sep="_")%>%
  group_by(party3, wave)%>%
  summarize(mean=mean(govttrust, na.rm=T), 
            upper=mean(govttrust, na.rm=T)+(1.96*(sd(govttrust, na.rm=T)/sqrt(n()))),
            lower=mean(govttrust, na.rm=T)-(1.96*(sd(govttrust, na.rm=T)/sqrt(n()))))
dat.govt.trust$party3<-factor(dat.govt.trust$party3, labels = c("Democrats", "Independents", 
                                                                "Republicans"))
dat.govt.trust<-na.omit(dat.govt.trust)
### Get out an overall trendline
dat.govt.trust.all<-dat %>%
  select(govttrust_1, govttrust_2, govttrust_3, govttrust_4, party3_1, party3_2, party3_3, party3_4) %>%
  pivot_longer(everything(),names_to=c(".value", "wave"), names_sep="_")%>%
  group_by(wave)%>%
  summarize(mean=mean(govttrust, na.rm=T), 
            upper=mean(govttrust, na.rm=T)+(1.96*(sd(govttrust, na.rm=T)/sqrt(n()))),
            lower=mean(govttrust, na.rm=T)-(1.96*(sd(govttrust, na.rm=T)/sqrt(n()))),
            party3=4)

dat.govt.trust.all$party3<-factor(dat.govt.trust.all$party3, labels="All")
dat.govt.trust<-full_join(dat.govt.trust, dat.govt.trust.all)
## Make a figure
ggplot(aes(x=wave, color=party3), data=dat.govt.trust)+
  geom_point(aes(y=mean))+
  geom_errorbar(aes(ymin=lower, ymax=upper), width=.5)+
  scale_color_manual(values=c("dodgerblue1", "springgreen4", "firebrick1"))+
  theme_bw()+
  coord_cartesian(ylim=c(0,1))
# Political Interest
## Correlation with education
cor.test(dat$EDUC_W4, dat$q16r_4)
##Make and test correlation with ideo.x
dat$ideo.x_4<-recode(as.numeric(dat$P_IDEO_W4), "1=3;7=3;2=2;6=2;3=1;5=1;4=0;8=0;NA=0;77=NA;98=NA")
cor.test(dat$q16r_4)



