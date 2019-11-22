####Libraries####
library(easypackages)
libs<-c("tidyverse", "dplyr", "naniar", "sjlabelled", "car", "haven")
libraries(libs)
####Load in the data####
dat <- 
  readRDS("~/Desktop/R Programs/Research--Diana/Amerispeak/Prep for Wave 5/waves1234all.rds")
dat.orig<-dat
dat<-remove_all_labels(dat)
####Analyses####
# Perceived Inequality Analyses
## Code variance of FAIR1,3,4
dat <- dat %>%
  replace_with_na_at(.vars="FAIR3_W3", condition = ~.x %in% c(77, 98, 99))
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

## Make a figure

ggplot(aes(x=wave, color=party3), data=dat.govt.trust)+
  geom_point(aes(y=mean))+
  geom_errorbar(aes(ymin=lower, ymax=upper), width=.5)+
  scale_color_manual(values=c("dodgerblue1", "springgreen4", "firebrick1"))+
  theme_bw()

ggplot(aes(x=wave), data=dat.govt.trust.all)+
  geom_point(aes(y=mean))+
  geom_errorbar(aes(ymin=lower, ymax=upper), width=.5)+
  theme_bw()

#### Means by Wave and by Party####
# Variable Recodes
dat <- dat %>%
  replace_with_na_at(.vars="P_PARTYID7_W4", condition = ~.x %in% c(98))
dat$PARTYID7_W4<-dat$P_PARTYID7_W4
dat$PARTYID7_W2<-dat$partyid7_w2
dat <- dat %>%
  replace_with_na_at(.vars=c("P_IDEO_W4", "IDEO_W1", "IDEO_W2", "IDEO_W3"), 
                     condition = ~.x %in% c(8, 77, 98, 99))
dat$IDEO_W4<-dat$P_IDEO_W4
dat$worryterror_1 <- (4-dat$PT5_W1)
dat$worryterror_2 <- (4-dat$PT5_W2)
dat$worryterror_3 <- (4-dat$PT5_W3)
dat$worryterror_4 <- (4-dat$PT5_W4)

# Get Out Overall Means for _WX endings
dat.means<-dat %>%
  select(PARTYID7_W1, PARTYID7_W2, PARTYID7_W3, PARTYID7_W4, THERMTRUMP_W1, THERMTRUMP_W2,
         THERMTRUMP_W3, THERMTRUMP_W4, IDEO_W1, IDEO_W2, IDEO_W3, IDEO_W4) %>%
  pivot_longer(everything(), names_to=c(".value", "wave"), names_sep="_W") %>%
  group_by(wave) %>%
  pivot_longer(-wave, names_to = "variable", values_to = "value") %>%
  group_by(variable, wave) %>%
  summarize(mean=mean(value, na.rm=T)) %>%
  pivot_wider(everything(), names_from = "wave", values_from = "mean")
  
# Get Out Overall Means for _X endings

dat.means.x <- dat %>%
  select(party3_1, party3_2, party3_3, party3_4, party2_1, party2_2, party2_3, party2_4,
         socialtrust_1, socialtrust_2, socialtrust_3, socialtrust_4, yeswar_1, yeswar_2,
         yeswar_3, yeswar_4, immigindex_1, immigindex_2, immigindex_3, immigindex_4, 
         hc1r_1, hc1r_2, hc1r_3, hc1r_4, tr1r_1, tr1r_2, tr1r_3, tr1r_4, wayoflife_1, 
         wayoflife_2, wayoflife_3, wayoflife_4, polarindex_1, polarindex_2, polarindex_3,
         polarindex_4, isoindex_1, isoindex_2, isoindex_3, isoindex_4, tsn1r_1, tsn1r_2, 
         tsn1r_3, tsn1r_4, safetynet_1, safetynet_2, safetynet_3, safetynet_4, disblack_1, 
         disblack_2, disblack_3, disblack_4, dishispanic_1, dishispanic_2, dishispanic_3, 
         dishispanic_4, diswhite_1, diswhite_2, diswhite_3, diswhite_4, diswomen_1, 
         diswomen_2, diswomen_3, diswomen_4, dismen_1, dismen_2, dismen_3, dismen_4, 
         dismuslim_1, dismuslim_2, dismuslim_3, dismuslim_4, dischristian_1, dischristian_2,
         dischristian_3, dischristian_4, natsupindex_1, natsupindex_2, natsupindex_3, 
         natsupindex_4, govttrust_1, govttrust_2, govttrust_3, govttrust_4, sc1r_1, sc1r_2,
         sc1r_3, sc1r_4, ecoperc_1, ecoperc_2, ecoperc_3, ecoperc_4, perecoperc_1, 
         perecoperc_2, perecoperc_3, perecoperc_4, majorrelig_1, majorrelig_2, majorrelig_3, 
         majorrelig_4, majorrace_1,
         majorrace_2, majorrace_3, majorrace_4, majorsex_1, majorsex_2, majorsex_3, majorsex_4,
         syslegindex_1, syslegindex_2, syslegindex_3, syslegindex_4, worryterror_1, worryterror_2,
         worryterror_3, worryterror_4) %>%
  pivot_longer(everything(), names_to=c(".value", "wave"), names_sep="_") %>%
  group_by(wave) %>%
  pivot_longer(-wave, names_to = "variable", values_to = "value") %>%
  group_by(variable, wave) %>%
  summarize(mean=mean(value, na.rm=T)) %>%
  pivot_wider(everything(), names_from = "wave", values_from = "mean")

# Combine tables
dat.means.all<-full_join(dat.means.x, dat.means)

## round values and save output
dat.means.all[,-1]<-round(dat.means.all[,-1], 2)
write_csv(dat.means.all, path="Mean over time.csv")
# Broken down by party

##Rename IDEO and THERMTRUMP to remove _W
dat$ideo_1<-dat$IDEO_W1
dat$ideo_2<-dat$IDEO_W2
dat$ideo_3<-dat$IDEO_W3
dat$ideo_4<-dat$IDEO_W4
dat$thermtrump_1<-dat$THERMTRUMP_W1
dat$thermtrump_2<-dat$THERMTRUMP_W2
dat$thermtrump_3<-dat$THERMTRUMP_W3
dat$thermtrump_4<-dat$THERMTRUMP_W4

## Summarize the data

dat.means.party <- dat %>%
  select(party2_1, party2_2, party2_3, party2_4, ideo_1, ideo_2, ideo_3, ideo_4,
         socialtrust_1, socialtrust_2, socialtrust_3, socialtrust_4, yeswar_1, yeswar_2,
         yeswar_3, yeswar_4, immigindex_1, immigindex_2, immigindex_3, immigindex_4, 
         hc1r_1, hc1r_2, hc1r_3, hc1r_4, tr1r_1, tr1r_2, tr1r_3, tr1r_4, wayoflife_1, 
         wayoflife_2, wayoflife_3, wayoflife_4, polarindex_1, polarindex_2, polarindex_3,
         polarindex_4, isoindex_1, isoindex_2, isoindex_3, isoindex_4, tsn1r_1, tsn1r_2, 
         tsn1r_3, tsn1r_4, safetynet_1, safetynet_2, safetynet_3, safetynet_4, disblack_1, 
         disblack_2, disblack_3, disblack_4, dishispanic_1, dishispanic_2, dishispanic_3, 
         dishispanic_4, diswhite_1, diswhite_2, diswhite_3, diswhite_4, diswomen_1, 
         diswomen_2, diswomen_3, diswomen_4, dismen_1, dismen_2, dismen_3, dismen_4, 
         dismuslim_1, dismuslim_2, dismuslim_3, dismuslim_4, dischristian_1, dischristian_2,
         dischristian_3, dischristian_4, natsupindex_1, natsupindex_2, natsupindex_3, 
         natsupindex_4, govttrust_1, govttrust_2, govttrust_3, govttrust_4, sc1r_1, sc1r_2,
         sc1r_3, sc1r_4, ecoperc_1, ecoperc_2, ecoperc_3, ecoperc_4, perecoperc_1, 
         perecoperc_2, perecoperc_3, perecoperc_4, majorrelig_1, majorrelig_2, majorrelig_3, 
         majorrelig_4, majorrace_1,
         majorrace_2, majorrace_3, majorrace_4, majorsex_1, majorsex_2, majorsex_3, majorsex_4,
         syslegindex_1, syslegindex_2, syslegindex_3, syslegindex_4, worryterror_1, worryterror_2,
         worryterror_3, worryterror_4, thermtrump_1, thermtrump_2, thermtrump_3, thermtrump_4) %>%
  pivot_longer(everything(), names_to=c(".value", "wave"), names_sep="_") %>%
  group_by(wave, party2) %>%
  pivot_longer(-c(wave, party2), names_to = "variable", values_to = "value") %>%
  group_by(variable, wave, party2) %>%
  summarize(mean=mean(value, na.rm=T)) %>%
  pivot_wider(everything(), names_from = "wave", values_from = "mean")

### Drop NAs
dat.means.party <- na.omit(dat.means.party)

### Recode Party to add labels
dat.means.party$party2<-factor(dat.means.party$party2, labels=c("Democrats", "Republicans"))

### round values and save output
dat.means.party[,-c(1,2)]<-round(dat.means.party[,-c(1, 2)], 2)
write_csv(dat.means.party, path="Mean over time by party.csv")

# Make Figures of change over time for _WX Variables
## Get out data
dat.means.fig<-dat %>%
  select(PARTYID7_W1, PARTYID7_W2, PARTYID7_W3, PARTYID7_W4, THERMTRUMP_W1, THERMTRUMP_W2,
         THERMTRUMP_W3, THERMTRUMP_W4, IDEO_W1, IDEO_W2, IDEO_W3, IDEO_W4) %>%
  pivot_longer(everything(), names_to=c(".value", "wave"), names_sep="_W") %>%
  group_by(wave) %>%
  pivot_longer(-wave, names_to = "variable", values_to = "value") %>%
  group_by(variable, wave) %>%
  summarize(mean=mean(value, na.rm=T), 
            upper=mean(value, na.rm=T)+(1.96*(sd(value, na.rm=T)/sqrt(n()))),
            lower=mean(value, na.rm=T)-(1.96*(sd(value, na.rm=T)/sqrt(n()))))

## Make Figures
for(x in 1:(nrow(dat.means.fig)/4)){
  a <- 4*x-3
  b <- 4*x-2
  c <- 4*x-1
  d <- 4*x
  print(ggplot(aes(x=wave), data=dat.means.fig[c(a:d),])+
    geom_point(aes(y=mean))+
    geom_errorbar(aes(ymin=lower, ymax=upper), width=.5)+
    ggtitle(label=dat.means.fig$variable[a])+
    theme_bw()+
      labs(subtitle = paste("Range = (",
        range(dat[,grep(dat.means.x.fig$variable[a], colnames(dat))[1]], na.rm=T)[1], ", ",
        range(dat[,grep(dat.means.x.fig$variable[a], colnames(dat))[1]], na.rm=T)[2], ")",
        sep="")))+
    theme(plot.subtitle = element_text(size=10, hjust=0.5))
}

# Make Figures for Change over time for _X variables
## Get out the data
dat.means.x.fig <- dat %>%
  select(party3_1, party3_2, party3_3, party3_4, party2_1, party2_2, party2_3, party2_4,
         socialtrust_1, socialtrust_2, socialtrust_3, socialtrust_4, yeswar_1, yeswar_2,
         yeswar_3, yeswar_4, immigindex_1, immigindex_2, immigindex_3, immigindex_4, 
         hc1r_1, hc1r_2, hc1r_3, hc1r_4, tr1r_1, tr1r_2, tr1r_3, tr1r_4, wayoflife_1, 
         wayoflife_2, wayoflife_3, wayoflife_4, polarindex_1, polarindex_2, polarindex_3,
         polarindex_4, isoindex_1, isoindex_2, isoindex_3, isoindex_4, tsn1r_1, tsn1r_2, 
         tsn1r_3, tsn1r_4, safetynet_1, safetynet_2, safetynet_3, safetynet_4, disblack_1, 
         disblack_2, disblack_3, disblack_4, dishispanic_1, dishispanic_2, dishispanic_3, 
         dishispanic_4, diswhite_1, diswhite_2, diswhite_3, diswhite_4, diswomen_1, 
         diswomen_2, diswomen_3, diswomen_4, dismen_1, dismen_2, dismen_3, dismen_4, 
         dismuslim_1, dismuslim_2, dismuslim_3, dismuslim_4, dischristian_1, dischristian_2,
         dischristian_3, dischristian_4, natsupindex_1, natsupindex_2, natsupindex_3, 
         natsupindex_4, govttrust_1, govttrust_2, govttrust_3, govttrust_4, sc1r_1, sc1r_2,
         sc1r_3, sc1r_4, ecoperc_1, ecoperc_2, ecoperc_3, ecoperc_4, perecoperc_1, 
         perecoperc_2, perecoperc_3, perecoperc_4, majorrelig_1, majorrelig_2, majorrelig_3, 
         majorrelig_4, majorrace_1,
         majorrace_2, majorrace_3, majorrace_4, majorsex_1, majorsex_2, majorsex_3, majorsex_4,
         syslegindex_1, syslegindex_2, syslegindex_3, syslegindex_4, worryterror_1, worryterror_2,
         worryterror_3, worryterror_4) %>%
  pivot_longer(everything(), names_to=c(".value", "wave"), names_sep="_") %>%
  group_by(wave) %>%
  pivot_longer(-wave, names_to = "variable", values_to = "value") %>%
  group_by(variable, wave) %>%
  summarize(mean=mean(value, na.rm=T), 
            upper=mean(value, na.rm=T)+(1.96*(sd(value, na.rm=T)/sqrt(n()))),
            lower=mean(value, na.rm=T)-(1.96*(sd(value, na.rm=T)/sqrt(n()))))

## Make Figures
for(x in 1:(nrow(dat.means.x.fig)/4)){
  a <- 4*x-3
  b <- 4*x-2
  c <- 4*x-1
  d <- 4*x
  print(ggplot(aes(x=wave), data=dat.means.x.fig[c(a:d),])+
          geom_point(aes(y=mean))+
          geom_errorbar(aes(ymin=lower, ymax=upper), width=.5)+
          ggtitle(label=dat.means.x.fig$variable[a])+
          theme_bw()+
          labs(subtitle = paste("Range = (",
            range(dat[,grep(dat.means.x.fig$variable[a], colnames(dat))[1]], na.rm=T)[1], ", ",
            range(dat[,grep(dat.means.x.fig$variable[a], colnames(dat))[1]], na.rm=T)[2], ")",
            sep="")))+
          theme(plot.subtitle = element_text(size=10, hjust=0.5))
}

# Make Figures for Over time change by party
## Get Data
dat.means.party.fig <- dat %>%
  select(party2_1, party2_2, party2_3, party2_4, ideo_1, ideo_2, ideo_3, ideo_4,
         socialtrust_1, socialtrust_2, socialtrust_3, socialtrust_4, yeswar_1, yeswar_2,
         yeswar_3, yeswar_4, immigindex_1, immigindex_2, immigindex_3, immigindex_4, 
         hc1r_1, hc1r_2, hc1r_3, hc1r_4, tr1r_1, tr1r_2, tr1r_3, tr1r_4, wayoflife_1, 
         wayoflife_2, wayoflife_3, wayoflife_4, polarindex_1, polarindex_2, polarindex_3,
         polarindex_4, isoindex_1, isoindex_2, isoindex_3, isoindex_4, tsn1r_1, tsn1r_2, 
         tsn1r_3, tsn1r_4, safetynet_1, safetynet_2, safetynet_3, safetynet_4, disblack_1, 
         disblack_2, disblack_3, disblack_4, dishispanic_1, dishispanic_2, dishispanic_3, 
         dishispanic_4, diswhite_1, diswhite_2, diswhite_3, diswhite_4, diswomen_1, 
         diswomen_2, diswomen_3, diswomen_4, dismen_1, dismen_2, dismen_3, dismen_4, 
         dismuslim_1, dismuslim_2, dismuslim_3, dismuslim_4, dischristian_1, dischristian_2,
         dischristian_3, dischristian_4, natsupindex_1, natsupindex_2, natsupindex_3, 
         natsupindex_4, govttrust_1, govttrust_2, govttrust_3, govttrust_4, sc1r_1, sc1r_2,
         sc1r_3, sc1r_4, ecoperc_1, ecoperc_2, ecoperc_3, ecoperc_4, perecoperc_1, 
         perecoperc_2, perecoperc_3, perecoperc_4, majorrelig_1, majorrelig_2, majorrelig_3, 
         majorrelig_4, majorrace_1,
         majorrace_2, majorrace_3, majorrace_4, majorsex_1, majorsex_2, majorsex_3, majorsex_4,
         syslegindex_1, syslegindex_2, syslegindex_3, syslegindex_4, worryterror_1, worryterror_2,
         worryterror_3, worryterror_4, thermtrump_1, thermtrump_2, thermtrump_3, thermtrump_4) %>%
  pivot_longer(everything(), names_to=c(".value", "wave"), names_sep="_") %>%
  group_by(wave, party2) %>%
  pivot_longer(-c(wave, party2), names_to = "variable", values_to = "value") %>%
  group_by(variable, wave, party2) %>%
  summarize(mean=mean(value, na.rm=T), 
          upper=mean(value, na.rm=T)+(1.96*(sd(value, na.rm=T)/sqrt(n()))),
          lower=mean(value, na.rm=T)-(1.96*(sd(value, na.rm=T)/sqrt(n()))))

### Drop NAs
dat.means.party.fig <- na.omit(dat.means.party.fig)

### Recode Party to add labels
dat.means.party.fig$party2<-factor(dat.means.party.fig$party2, labels=c("Democrats", "Republicans"))

## Make Figures
for(x in 1:(nrow(dat.means.party.fig)/8)){
  a <- 8*x-7
  d <- 8*x
  print(ggplot(aes(x=wave, color=party2), data=dat.means.party.fig[c(a:d),])+
          geom_point(aes(y=mean))+
          geom_errorbar(aes(ymin=lower, ymax=upper), width=.5)+
          scale_color_manual(values=c("blue", "red"))+
          ggtitle(label=dat.means.party.fig$variable[a])+
          theme_bw()+
          labs(subtitle = paste("Range = (",
            range(dat[,grep(dat.means.party.fig$variable[a], colnames(dat))[1]], na.rm=T)[1], ", ",
            range(dat[,grep(dat.means.party.fig$variable[a], colnames(dat))[1]], na.rm=T)[2], ")",
            sep="")))+
          theme(plot.subtitle = element_text(size=10, hjust=0.5))
}

m.tol<-lm(polarindex_4~poltol_4+AGE_W4+EDUC4_W4+(GENDER_W4-1)+party3_4, data=dat)

#### Sociotropic measures--Means over time####
# Create the indices
dat$fair.ind_3<-rowMeans(cbind(dat$fair1r_3, dat$fair3r_3, dat$fair4r_3))
dat$fair.ind_4<-rowMeans(cbind(dat$fair1r_4, dat$fair3r_4, dat$fair4r_4))
# Check reliability
fair.index_3<-grep("fair", colnames(dat))[c(1, 3, 4)]
fair.index_4<-grep("fair", colnames(dat))[c(5:7)]
psych::alpha(dat[fair.index_3], check.keys=T)
psych::alpha(dat[fair.index_4], check.keys=T)
# Analyses
cor.test(dat$fair.ind_3, dat$fair.ind_4)
cor.test(dat$fair1r_3, dat$fair1r_4)
cor.test(dat$fair3r_3, dat$fair3r_4)
cor.test(dat$fair4r_3, dat$fair4r_4)

## Change over time by party
dat.fair.change.party <- dat %>%
  select(fair1r_3, fair1r_4, fair3r_3, fair3r_4, fair4r_3, fair4r_4, party2_3, party2_4) %>%
  pivot_longer(everything(), names_to=c(".value", "wave"), names_sep="_") %>%
  group_by(wave, party2) %>%
  pivot_longer(-c(wave, party2), names_to = "variable", values_to = "value") %>%
  group_by(variable, wave, party2) %>%
  summarize(mean=mean(value, na.rm=T), 
            upper=mean(value, na.rm=T)+(1.96*(sd(value, na.rm=T)/sqrt(n()))),
            lower=mean(value, na.rm=T)-(1.96*(sd(value, na.rm=T)/sqrt(n()))))
dat.fair.change.party<-na.omit(dat.fair.change.party)
### Make figures
for(x in 1:(nrow(dat.fair.change.party)/4)){
  a <- 4*x-3
  d <- 4*x
  print(ggplot(aes(x=wave, color=factor(party2)), data=dat.fair.change.party[c(a:d),])+
          geom_point(aes(y=mean))+
          geom_errorbar(aes(ymin=lower, ymax=upper), width=.5)+
          geom_hline(aes(yintercept = 2))+
          scale_color_manual(values=c("blue", "red"))+
          ggtitle(label=dat.fair.change.party$variable[a])+
          theme_bw()+
          labs(subtitle = paste("Range = (",
                                range(dat[,grep(dat.fair.change.party$variable[a], colnames(dat))[1]], na.rm=T)[1], ", ",
                                range(dat[,grep(dat.fair.change.party$variable[a], colnames(dat))[1]], na.rm=T)[2], ")",
                                sep="")))+
    theme(plot.subtitle = element_text(size=10, hjust=0.5))
}

## Change Over time
dat.fair.change <- dat %>%
  select(fair1r_3, fair1r_4, fair3r_3, fair3r_4, fair4r_3, fair4r_4) %>%
  pivot_longer(everything(), names_to=c(".value", "wave"), names_sep="_") %>%
  group_by(wave) %>%
  pivot_longer(-c(wave), names_to = "variable", values_to = "value") %>%
  group_by(variable, wave) %>%
  summarize(mean=mean(value, na.rm=T), 
            upper=mean(value, na.rm=T)+(1.96*(sd(value, na.rm=T)/sqrt(n()))),
            lower=mean(value, na.rm=T)-(1.96*(sd(value, na.rm=T)/sqrt(n()))))
dat.fair.change<-na.omit(dat.fair.change)
### Make figures
for(x in 1:(nrow(dat.fair.change)/2)){
  a <- 2*x-1
  d <- 2*x
  print(ggplot(aes(x=wave), data=dat.fair.change[c(a:d),])+
          geom_point(aes(y=mean))+
          geom_errorbar(aes(ymin=lower, ymax=upper), width=.5)+
          geom_hline(aes(yintercept = 2))+
          scale_color_manual(values=c("blue", "red"))+
          ggtitle(label=dat.fair.change$variable[a])+
          theme_bw()+
          labs(subtitle = paste("Range = (",
                                range(dat[,grep(dat.fair.change$variable[a], colnames(dat))[1]], na.rm=T)[1], ", ",
                                range(dat[,grep(dat.fair.change$variable[a], colnames(dat))[1]], na.rm=T)[2], ")",
                                sep="")))+
    theme(plot.subtitle = element_text(size=10, hjust=0.5))
}
#### Predicting perceived inequality ####
# Recode gender and race
dat$male_4<-ifelse(dat$GENDER_W4==1, 1, 0)
dat$white_4<-ifelse(dat$RACETHNICITY_W4==1, 1, 0)
m.ineq1<-lm(gap1r_4~AGE_W4+EDUC4_W4+INCOME_W4+party3_4+male_4+white_4+eco.var_4+fair.ind_4, 
            data=dat)
dat.gap<-cbind(m.ineq1$model, m.ineq1$fitted.values)
cor.test(dat.gap$gap1r_4, dat.gap$`m.ineq1$fitted.values`)

#### Predicting Interest from IDKs and skips on political attitude questions ####
# Read in uncleaned wave 4
dat.4u <- read_sav("Data/s7991_UPenn_LongPollW4_FINAL_WEIGHTED_client_7.11.2019.sav")
# Set up vectors of skipped/refused/DK values
na.2<-c(77, 98, 99)
na.3<-c(777, 998, 999)
#Construct alternative interest measure
index.w4<-grep("_W4", colnames(dat))
dat.4u$dk.skip_4<-NA
for(x in 1:nrow(dat.4u)){
  n<-0
  if(dat.4u$THERMTRUMP_W4[x] %in% na.3) {n<-n+1}
  if(dat.4u$GUNS_W4[x] %in% na.2) {n<-n+1}
  if(dat.4u$TSN1_W4[x] %in% na.2) {n<-n+1}
  if(dat.4u$TSN2_W4[x] %in% na.2) {n<-n+1}
  if(dat.4u$CHI_W4[x] %in% na.2) {n<-n+1}
  if(dat.4u$CHI2_W4[x] %in% na.2) {n<-n+1}
  if(dat.4u$RS1_W4[x] %in% na.2) {n<-n+1}
  if(dat.4u$CL1_W4[x] %in% na.2) {n<-n+1}
  if(dat.4u$SOCMED_W4[x] %in% na.2) {n<-n+1}
  if(dat.4u$RUS1_W4[x] %in% na.2) {n<-n+1}
    
  dat.4u$dk.skip_4[x]<-n
}
# Create Dataframe and merge with main data
dat.int<-cbind(dat.4u$CaseId, dat.4u$dk.skip_4)
colnames(dat.int)<-c('CaseId', 'dk.skip_4')
dat.int<-as_tibble(dat.int)
dat<-left_join(dat, dat.int, by='CaseId')
# Correlation between interest question and constructed measure
cor.test(dat$q16r_4, dat$dk.skip_4)

# Make a different measure of interest based on ALL wave 4 variables




