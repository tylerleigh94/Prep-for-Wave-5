####Libraries####
library(easypackages)
libs<-c("tidyverse", "ggplot2", "haven", "texreg", "naniar", "ggsignif", "ggpubr", 
        "plm", "broom", "lfe", "stargazer", "car")
libraries(libs)
####Import Datasets####
wave.3 <- read_sav("~/Desktop/R Programs/Research--Diana/Amerispeak/Facebook Presentation/Waves1-3 Data/Upenn_LongPollW3_FINAL_WEIGHTED_2018-11-20.sav")
wave.4 <- read_sav("~/Desktop/R Programs/Research--Diana/Amerispeak/Wave 4/Amerispeak-EV-2019/s7991_UPenn_LongPollW4_FINAL_WEIGHTED_client_7.11.2019.sav")
#Set waves for each dataset
wave.3$wave_W3<- 3
wave.4$wave_W4<- 4
####Merge waves 3 and 4 and add longitudinal indicator####
#Strip Case ID Attributes
attributes(wave.3$CaseId)<- NULL
attributes(wave.4$CaseId)<- NULL
#Merge waves
dat.34<- full_join(wave.3, wave.4, by="CaseId")
#create dummy for people in waves 3 and 4
dat.34$long<-ifelse(dat.34$wave_W3==3 & dat.34$wave_W4==4, 1, 0)
#Replace NAs with 0
dat.34$long<-ifelse(is.na(dat.34$long), 0, dat.34$long)
####Cleaning####
#Set up values for NA
na.values.2<-c(77, 98, 99)
na.values.3<- c(777, 998, 999)
#Get indices for Therms
therms<-grep("THERM", colnames(dat.34), fixed=T)
#vector of columns with 2-digit NAs
clean.length2<-colnames(dat.34[c(-1,-therms)])
#vector of columns with 3-digit NAs
clean.length3<- colnames(dat.34[therms])
#Remove NAs
dat.34<- dat.34 %>%
  replace_with_na_at(.vars=clean.length2, condition = ~.x %in% na.values.2)
dat.34 <-dat.34 %>%
  replace_with_na_at(.vars=clean.length3, condition = ~.x %in% na.values.3)
####Variable Manipulations and Recodes####
#dummy for social media platform use in wave 4
dat.34$fb.use.dummy<-ifelse(dat.34$SOCIAL1_1_W4>1, 1, 0)
dat.34$yt.use.dummy<-ifelse(dat.34$SOCIAL1_2_W4>1, 1, 0)
dat.34$tw.use.dummy<-ifelse(dat.34$SOCIAL1_3_W4>1, 1, 0)
dat.34$ig.use.dummy<-ifelse(dat.34$SOCIAL1_4_W4>1, 1, 0)
#Dummy for FB use in wave 3
dat.34$fbook1.dum_W3<-ifelse(dat.34$FBOOK1_W3==7, 0, 1)
#Recode credibility; positive = more credible
dat.34$fb.cred<-recode(dat.34$SOCIAL2_1_W4, "1=6; 2=5; 3=4; 4=3; 5=2; 6=1")
dat.34$yt.cred<-recode(dat.34$SOCIAL2_2_W4, "1=6; 2=5; 3=4; 4=3; 5=2; 6=1")
dat.34$tw.cred<-recode(dat.34$SOCIAL2_3_W4, "1=6; 2=5; 3=4; 4=3; 5=2; 6=1")
dat.34$ig.cred<-recode(dat.34$SOCIAL2_4_W4, "1=6; 2=5; 3=4; 4=3; 5=2; 6=1")
##Transform credibility; -1 = un-credible, +1 = credible
dat.34<-dat.34 %>%
  mutate(fb.cred.r=((2/5)*(fb.cred-1)-1), yt.cred.r=((2/5)*(yt.cred-1)-1), 
         tw.cred.r=((2/5)*(tw.cred-1)-1), ig.cred.r=((2/5)*(ig.cred-1)-1))
#Create measure of passive political info exposure per platform; [0,3] 3= high exposure
dat.34 <- dat.34 %>%
  mutate(fb.pass.exp=SOCIAL3_1_W4-1, yt.pass.exp=SOCIAL3_2_W4-1, tw.pass.exp=SOCIAL3_3_W4-1,
         ig.pass.exp=SOCIAL3_4_W4-1)
#Active News exposure
##Membership in political groups
dat.34$fb.group.dum<-ifelse(dat.34$SOCIAL1_1_W4>1, dat.34$SOCIAL4_FACE_1_W4, NA)
dat.34$yt.group.dum<-ifelse(dat.34$SOCIAL1_2_W4>1, dat.34$SOCIAL4_YOU_1_W4, NA)
dat.34$tw.group.dum<-ifelse(dat.34$SOCIAL1_3_W4>1, dat.34$SOCIAL4_TWIT_1_W4, NA)
dat.34$ig.group.dum<-ifelse(dat.34$SOCIAL1_4_W4>1, dat.34$SOCIAL4_INST_1_W4, NA)
##Total number of groups
dat.34 <- dat.34 %>%
  mutate(fb.group.sum=SOCIAL4_FACE_1_W4+SOCIAL4_FACE_2_W4+SOCIAL4_FACE_3_W4+SOCIAL4_FACE_4_W4+
           SOCIAL4_FACE_5_W4+SOCIAL4_FACE_6_W4,
         yt.group.sum=SOCIAL4_YOU_1_W4+SOCIAL4_YOU_2_W4+SOCIAL4_YOU_3_W4+SOCIAL4_YOU_4_W4+
           SOCIAL4_YOU_5_W4+SOCIAL4_YOU_6_W4,
         tw.group.sum=SOCIAL4_TWIT_1_W4+SOCIAL4_TWIT_2_W4+SOCIAL4_TWIT_3_W4+SOCIAL4_TWIT_4_W4+
           SOCIAL4_TWIT_5_W4+SOCIAL4_TWIT_6_W4,
         ig.group.sum=SOCIAL4_INST_1_W4+SOCIAL4_INST_2_W4+SOCIAL4_INST_3_W4+SOCIAL4_INST_4_W4+
           SOCIAL4_INST_5_W4+SOCIAL4_INST_6_W4)
##Political group membership as a proportion of group membership
dat.34<-dat.34 %>%
  mutate(fb.group.prop=fb.group.dum/fb.group.sum, yt.group.prop=yt.group.dum/yt.group.sum,
         tw.group.prop=tw.group.dum/tw.group.sum, ig.group.prop=ig.group.dum/ig.group.sum)
# Political Party
##Wave 3
###Recode (-1=Unknown) to 4=Moderate/None/Lean
dat.34$PARTYID7_W3[dat.34$PARTYID7_W3==-1]<-4
###Party 3, 1=D, 2=I, 3=R
dat.34$party3_W3<-ifelse(dat.34$PARTYID7_W3<=3, 1, 
                         ifelse(dat.34$PARTYID7_W3>=5, 3, 2))
###Party dummies
dat.34$dem_W3<-ifelse(dat.34$PARTYID7_W3<=3, 1, 0)
dat.34$rep_W3<-ifelse(dat.34$PARTYID7_W3>=5, 1, 0)
dat.34$ind_W3<-ifelse(dat.34$PARTYID7_W3==4, 1, 0)
##Wave 4 Party2 (Independents coded as NA and dropped) D=1, R= 2, as a factor
dat.34$party2_W3<-as.factor(ifelse(dat.34$party3_W3==1, 1, 
                                   ifelse(dat.34$party3_W3==3,2, NA)))
##Wave 4
###Recode (-1=Unknown) to 4=Moderate/None/Lean
dat.34$P_PARTYID7_W4[dat.34$P_PARTYID7_W4==-1]<-4
###Party 3, 1=D, 2=I, 3=R
dat.34$party3_W4<-ifelse(dat.34$P_PARTYID7_W4<=3, 1, 
                         ifelse(dat.34$P_PARTYID7_W4>=5, 3, 2))
###Party dummies
dat.34$dem_W4<-ifelse(dat.34$P_PARTYID7_W4<=3, 1, 0)
dat.34$rep_W4<-ifelse(dat.34$P_PARTYID7_W4>=5, 1, 0)
dat.34$ind_W4<-ifelse(dat.34$P_PARTYID7_W4==4, 1, 0)
##Wave 4 Party2 (Independents coded as NA and dropped) D=1, R= 2, as a factor
dat.34$party2_W4<-as.factor(ifelse(dat.34$party3_W4==1, 1, 
                                   ifelse(dat.34$party3_W4==3,2, NA)))
#Social media use variables
##Facebook use in wave 3, original scale recoded so high = high frequency of use (0-6)
dat.34$fb.use7<-recode(dat.34$FBOOK1_W3, "1=6; 2=5; 3=4; 4=3; 5=2; 6=1; 7=0")
##Facebook use standardized across waves; 0=never, 4=Many times a day
dat.34$fb.use5_W3<- recode(dat.34$FBOOK1_W3, "7=0; 6=1; 5=1; 4=1; 3=2; 2=3; 1=4")
dat.34$fb.use5_W4<- recode(dat.34$SOCIAL1_1_W4, "1=0; 2=1; 3=1; 4=2; 5=3; 6=4")
##Remaining social media questions, renamed for ease and brought to start at 0
dat.34 <- dat.34 %>%
  mutate(fb.use6=SOCIAL1_1_W4-1, yt.use6=SOCIAL1_2_W4-1, tw.use6=SOCIAL1_3_W4-1, ig.use6=SOCIAL1_4_W4-1)
#Perceived Polarization Scale; high=high perceived polarization
##Wave 3 recodes
dat.34$ppol1_W3<-dat.34$PP1_W3
dat.34$ppol2_W3<-dat.34$PP2_W3
dat.34$ppol3_W3<-recode(dat.34$PP3_W3, "1=4; 2=3; 3=2; 4=1")
dat.34$ppol4_W3<-recode(dat.34$PP4_W3, "1=4; 2=3; 3=2; 4=1")
##Wave 3 transformation to put on scale of (0,1)
dat.34 <- dat.34 %>%
  mutate(ppol1_W3=(ppol1_W3-1)/3, ppol2_W3=(ppol2_W3-1)/3, ppol3_W3=(ppol3_W3-1)/3, 
         ppol4_W3=(ppol4_W3-1)/3)
##Single index and reliability
dat.34 <- dat.34 %>%
  mutate(ppol.ind_W3=(ppol1_W3+ppol2_W3+ppol3_W3+ppol4_W3)/4)
ppol.index<-grep("ppol", colnames(dat.34), fixed = F)
alpha.ppol_W3<-psych::alpha(dat.34[ppol.index[c(1:4)]])
##Wave 4 Recodes
dat.34$ppol1_W4<-dat.34$PP1_W4
dat.34$ppol2_W4<-dat.34$PP2_W4
dat.34$ppol3_W4<-recode(dat.34$PP3_W4, "1=4; 2=3; 3=2; 4=1")
dat.34$ppol4_W4<-recode(dat.34$PP4_W4, "1=4; 2=3; 3=2; 4=1")
##Wave 4 transformation to put on scale of (0,1)
dat.34 <- dat.34 %>%
  mutate(ppol1_W4=(ppol1_W4-1)/3, ppol2_W4=(ppol2_W4-1)/3, ppol3_W4=(ppol3_W4-1)/3, 
         ppol4_W4=(ppol4_W4-1)/3)
##Single index and reliability
dat.34 <- dat.34 %>%
  mutate(ppol.ind_W4=(ppol1_W4+ppol2_W4+ppol3_W4+ppol4_W4)/4)
ppol.index<-grep("ppol", colnames(dat.34), fixed = F)
alpha.ppol_W4<-psych::alpha(dat.34[ppol.index[c(6:9)]])
#Gender and Race Recodes
##Gender: 1=male
dat.34$male.dum_W3<-ifelse(dat.34$GENDER_W3==1,1,0)
dat.34$male.dum_W4<-ifelse(dat.34$GENDER_W4==1,1,0)
##Race: 1=white
dat.34$white.dum_W3<-ifelse(dat.34$RACETHNICITY_W3==1,1,0)
dat.34$white.dum_W4<-ifelse(dat.34$RACETHNICITY_W4==1,1,0)
#Immigration Index; (0,1) high=pro-immigration
##Wave 3
dat.34$imm1_W3<-recode(dat.34$IM1_W3, "5=1;4=2;3=3;2=4;1=5")
dat.34$imm2_W3<-dat.34$IM2_W3
dat.34$imm3_W3<-dat.34$IM3_W3
###Collapsed into Scale and Standardized. Alpha reported
dat.34 <- dat.34 %>%
  mutate(imm.ind_W3=(((imm1_W3+imm2_W3+imm3_W3)/3)-1)/4)
imm.index<-grep("imm", colnames(dat.34), fixed = F)
alpha.imm_W3<-psych::alpha(dat.34[imm.index[1:3]])
##Wave 4
dat.34$imm1_W4<-recode(dat.34$IM1_W4, "5=1;4=2;3=3;2=4;1=5")
dat.34$imm2_W4<-dat.34$IM2_W4
dat.34$imm3_W4<-dat.34$IM3_W4
###Collapsed into Scale and Standardized. Alpha reported
dat.34 <- dat.34 %>%
  mutate(imm.ind_W4=(((imm1_W4+imm2_W4+imm3_W4)/3)-1)/4)
imm.index<-grep("imm", colnames(dat.34), fixed = F)
alpha.imm_W4<-psych::alpha(dat.34[imm.index[5:7]])
#Issue Polarization Scale; (0,1), 1=highly polarized, 0= middle of road/no polarization
##Wave 3
dat.34$iss1_W3<-recode(dat.34$GUNS_W3, "3=0;1=1;5=1;2=.5;4=.5")
dat.34$iss2_W3<-recode(dat.34$HC2_W3, "3=0;1=1;5=1;2=.5;4=.5")
dat.34$iss3_W3<-recode(dat.34$TSN1_W3, "3=0;1=1;5=1;2=.5;4=.5")
dat.34$iss4_W3<-recode(dat.34$TSN2_W3, "3=0;1=1;5=1;2=.5;4=.5")
dat.34$iss5_W3<-recode(dat.34$RUS1_W3, "3=0;1=1;5=1;2=.5;4=.5")
###Transformation of Immigration index
dat.34 <- dat.34 %>%
  mutate(iss6_W3=abs(imm.ind_W3-.5)*2)
##Index construction and alpha
dat.34 <- dat.34 %>%
  mutate(iss.pol_W3=(iss1_W3+iss2_W3+iss3_W3+iss4_W3+iss5_W3+iss6_W3)/6)
iss.pol.index<-grep("iss", colnames(dat.34), fixed=F)
alpha.iss.pol_W3<-psych::alpha(dat.34[iss.pol.index[c(1:6)]])
##Wave 4
dat.34$iss1_W4<-recode(dat.34$GUNS_W4, "3=0;1=1;5=1;2=.5;4=.5")
dat.34$iss2_W4<-recode(dat.34$HC2_W4, "3=0;1=1;5=1;2=.5;4=.5")
dat.34$iss3_W4<-recode(dat.34$TSN1_W4, "3=0;1=1;5=1;2=.5;4=.5")
dat.34$iss4_W4<-recode(dat.34$TSN2_W4, "3=0;1=1;5=1;2=.5;4=.5")
dat.34$iss5_W4<-recode(dat.34$RUS1_W4, "3=0;1=1;5=1;2=.5;4=.5")
###Transformation of Immigration index
dat.34 <- dat.34 %>%
  mutate(iss6_W4=abs(imm.ind_W4-.5)*2)
##Index construction and alpha
dat.34 <- dat.34 %>%
  mutate(iss.pol_W4=(iss1_W4+iss2_W4+iss3_W4+iss4_W4+iss5_W4+iss6_W4)/6)
iss.pol.index<-grep("iss", colnames(dat.34), fixed=F)
alpha.iss.pol_W4<-psych::alpha(dat.34[iss.pol.index[c(8:13)]])
#Extreme Ideology; (0,3) 3=extreme, 0=moderate
dat.34$ideo.x_W3<-recode(dat.34$IDEO_W3, "1=3;7=3;2=2;6=2;3=1;5=1;4=0;8=0;NA=0")
dat.34$ideo.x_W4<-recode(dat.34$P_IDEO_W4, "1=3;7=3;2=2;6=2;3=1;5=1;4=0;8=0;NA=0")
#Affective Polarization (Wave 3 Only); (0,1) 1=high affective polarization
dat.34 <- dat.34 %>%
  mutate(aff.pol_W3=(abs(THERM3_W3-THERM4_W3))/100)
##Test correlation with Biden/Trump Therm diff (correlation of .593)
dat.34 <- dat.34 %>%
  mutate(trump.biden.dif_W3=(abs(THERMTRUMP_W3-THERM5_W3))/100)
#Civility Index; (0,1), high=civil
##Wave 3
dat.34$civil.1_W3<-dat.34$CIVIL1_W3
dat.34$civil.2_W3<-recode(dat.34$CIVIL2_W3, "1=10; 2=9; 3=8; 4=7; 5=6; 6=5; 7=4; 8=3; 9=2; 10=1")
dat.34$civil.3_W3<-dat.34$CIVIL3_W3
dat.34$civil.4_W3<-recode(dat.34$CIVIL4_W3, "1=10; 2=9; 3=8; 4=7; 5=6; 6=5; 7=4; 8=3; 9=2; 10=1")
dat.34$civil.5_W3<-dat.34$CIVIL5_W3
###Create scale, standardized (0,1), and alpha
dat.34 <- dat.34 %>%
  mutate(civil.ind_W3=(((civil.1_W3+civil.2_W3+civil.3_W3+civil.4_W3+civil.5_W3)/5)-1)/9)
civil.index<-grep("civil.", colnames(dat.34), fixed=F)
alpha.civil_W3<-psych::alpha(dat.34[civil.index[1:5]])
##Wave 4
dat.34$civil.1_W4<-dat.34$CIVIL1_W4
dat.34$civil.2_W4<-recode(dat.34$CIVIL2_W4, "1=10; 2=9; 3=8; 4=7; 5=6; 6=5; 7=4; 8=3; 9=2; 10=1")
dat.34$civil.3_W4<-dat.34$CIVIL3_W4
dat.34$civil.4_W4<-recode(dat.34$CIVIL4_W4, "1=10; 2=9; 3=8; 4=7; 5=6; 6=5; 7=4; 8=3; 9=2; 10=1")
dat.34$civil.5_W4<-dat.34$CIVIL5_W4
###Create scale, standardized (0,1), and alpha
dat.34 <- dat.34 %>%
  mutate(civil.ind_W4=(((civil.1_W4+civil.2_W4+civil.3_W4+civil.4_W4+civil.5_W4)/5)-1)/9)
civil.index<-grep("civil.", colnames(dat.34), fixed=F)
alpha.civil_W4<-psych::alpha(dat.34[civil.index[7:11]])
#Social Trust
##Wave 3
dat.34$soc.tr1_W3<- recode(dat.34$ST1_W3, "1=1; 2=0")
dat.34$soc.tr2_W3<- recode(dat.34$ST2_W3, "1=0; 2=1")
dat.34$soc.tr3_W3<- recode(dat.34$ST3_W3, "1=1; 2=0")
###Construct scale and report alpha
dat.34 <- dat.34 %>%
  mutate(soc.tr.ind_W3=(soc.tr1_W3+soc.tr2_W3+soc.tr3_W3)/3)
soc.tr.index<-grep("soc.tr", colnames(dat.34), fixed=F)
alpha.soc.tr_W3<- psych::alpha(dat.34[soc.tr.index[1:3]])
##Wave 4
dat.34$soc.tr1_W4<- recode(dat.34$ST1_W4, "1=1; 2=0")
dat.34$soc.tr2_W4<- recode(dat.34$ST2_W4, "1=0; 2=1")
dat.34$soc.tr3_W4<- recode(dat.34$ST3_W4, "1=1; 2=0")
###Construct scale and report alpha
dat.34 <- dat.34 %>%
  mutate(soc.tr.ind_W4=(soc.tr1_W4+soc.tr2_W4+soc.tr3_W4)/3)
soc.tr.index<-grep("soc.tr", colnames(dat.34), fixed=F)
alpha.soc.tr_W4<- psych::alpha(dat.34[soc.tr.index[5:7]])
#Political interest; standardized (0,1) 1=very interest
dat.34$pol.interest<-recode(dat.34$Q16_W4, "1=1; 2=.666666667; 3=.333333333333; 4=0")
#Media diet
##Variable for number of different types of sources
index<-grep("ME1_", colnames(dat.34))[1:6]
dat.34 <- dat.34 %>%
  mutate(media.sum=ME1_1_W4+ME1_2_W4+ME1_3_W4+ME1_4_W4+ME1_5_W4+ME1_6_W4)
##TV News
###Watches TV news dummy
dat.34$tv.dummy<-ifelse(dat.34$ME1_1_W4==1 | dat.34$ME1_3_W4==1, 1, 0)
###Number of tv news programs watched
dat.34 <- dat.34 %>%
  mutate(tv.sum=ME2A_1_W4+ME2A_2_W4+ME2A_3_W4+ME2A_4_W4+ME2A_5_W4+ME2A_6_W4+ME2A_7_W4+ME2A_8_W4+
           ME2A_9_W4+ME2A_10_W4+ME2A_11_W4+ME2A_12_W4+ME2A_13_W4+ME2A_14_W4+ME2A_15_W4+ME2A_16_W4+
           ME2A_17_W4+ME2A_18_W4+ME2A_19_W4+ME2A_20_W4+ME2A_21_W4+ME2B_1_W4+ME2B_2_W4+ME2B_3_W4+
           ME2B_4_W4+ME2B_5_W4+ME2B_6_W4+ME2B_7_W4+ME2B_8_W4+ME2B_9_W4+ME2B_10_W4+ME2B_11_W4+ME2B_12_W4+
           ME2B_13_W4+ME2B_14_W4+ME2B_15_W4+ME2B_16_W4+ME2B_17_W4+ME2B_18_W4+ME2B_19_W4+ME2B_20_W4)
##Newspaper
###Newspaper dummy
dat.34$paper.dummy<-ifelse(dat.34$ME1_2_W4==1, 1, 0)
#Perceived party polarization (wave 3 only)
dat.34 <- dat.34 %>% 
  mutate(im.diff_W3=abs(IM1A_W3-IM1B_W3)/4)
dat.34 <- dat.34 %>%
  mutate(hc.diff_W3=abs(HC3_W3-HC4_W3)/4)
dat.34 <- dat.34 %>%
  mutate(tr.diff_W3=abs(TR1A_W3-TR1B_W3)/4)
dat.34 <- dat.34 %>%
  mutate(party.pol_W3=(im.diff_W3+hc.diff_W3+tr.diff_W3)/3)
##Alpha
index<-grep(".diff_W3", colnames(dat.34))
alpha.party.pol<- psych::alpha(dat.34[index])
#In-party thermometer (w3 only)
##Assign party to therms3/4 based on RND_03
dat.34$dem.therm<-ifelse(dat.34$RND_03_W3==0, dat.34$THERM4_W3, 
                         ifelse(dat.34$RND_03_W3==1, dat.34$THERM3_W3, NA))
dat.34$rep.therm<-ifelse(dat.34$RND_03_W3==0, dat.34$THERM3_W3, 
                         ifelse(dat.34$RND_03_W3==1, dat.34$THERM4_W3, NA))
##Assign party therms as in-party therms
dat.34$inparty.therm<-ifelse(dat.34$rep_W3==1, dat.34$rep.therm,
                             ifelse(dat.34$dem_W3==1, dat.34$dem.therm, NA))
#Out-Party Therm (w3 only)
dat.34$outparty.therm<-ifelse(dat.34$rep_W3==1, dat.34$dem.therm,
                              ifelse(dat.34$dem_W3==1, dat.34$rep.therm, NA))
#Political Tolerance Scale
dat.34 <- dat.34 %>%
  mutate(tol1=5-POL_T2_1_W4/4, tol2=(POL_T2_2_W4-1)/4, tol3=(POL_T2_3_W4-1)/4, 
         tol.ind=(tol1+tol2+tol3)/3)
##Alpha Pol tolerance
index.tol<-grep("tol", colnames(dat.34))[1:3]
psych::alpha(dat.34[index.tol], check.keys = T)
#Ideology Recode so that (8=HAven;t thought much about it) is recoded to 0; scale range (0-7)
dat.34$ideo_W3<-ifelse(dat.34$IDEO_W3==8, 0, dat.34$IDEO_W3)
dat.34$ideo_W4<-ifelse(dat.34$P_IDEO_W4==8, 0, dat.34$P_IDEO_W4)
# Party 7 variable (-3=Strong Dem, 3=Strong Rep)
dat.34<-dat.34 %>%
  mutate(party7_W3=PARTYID7_W3-4, party7_W4=P_PARTYID7_W4-4)
# System Legitimacy
##Wave 3
###Recodes so that 5=high system legitimacy
dat.34$sys.leg1_W3<-car::recode(dat.34$SL1_W3, "1=5; 2=4; 3=3; 4=2; 5=1; else=NA")
dat.34$sys.leg2_W3<-dat.34$SL2_W3
dat.34$sys.leg3_W3<-car::recode(dat.34$SL3_W3, "1=5; 2=4; 3=3; 4=2; 5=1; else=NA")
dat.34$sys.leg4_W3<-dat.34$SL4_W3
###Create an index and get reliability
dat.34<- dat.34 %>%
  mutate(sys.ind_W3=(sys.leg1_W3+sys.leg2_W3+sys.leg3_W3+sys.leg4_W3)/4)
index.sys_W3<-grep("sys.", colnames(dat.34))[c(1:4)]
alpha.sys_W3<-psych::alpha(dat.34[index.sys_W3], check.keys = T)
##Wave 4
###Recodes so that 5=high system legitimacy
dat.34$sys.leg1_W4<-car::recode(dat.34$SL1_W4, "1=5; 2=4; 3=3; 4=2; 5=1; else=NA")
dat.34$sys.leg2_W4<-dat.34$SL2_W4
dat.34$sys.leg3_W4<-car::recode(dat.34$SL3_W4, "1=5; 2=4; 3=3; 4=2; 5=1; else=NA")
dat.34$sys.leg4_W4<-dat.34$SL4_W4
###Create an index and get reliability
dat.34<- dat.34 %>%
  mutate(sys.ind_W4=(sys.leg1_W4+sys.leg2_W4+sys.leg3_W4+sys.leg4_W4)/4)
index.sys_W4<-grep("sys.", colnames(dat.34))[c(6:9)]
alpha.sys_W4<-psych::alpha(dat.34[index.sys_W4], check.keys = T)
#### Rename Dataframe ####
dat<-dat.34
###########################################
##### RUN ALL ABOVE PRIOR TO ANALYSIS #####
###########################################
#### Analyses ####
# Political Interest
## Correlation with education
cor.test(dat$EDUC_W4, dat$pol.interest)
##Make and test correlation with ideo.x
cor.test(dat$pol.interest, dat$ideo.x_W4)
## Predict Interest from education, extremity, and demographics
m.interest<-lm(pol.interest~EDUC_W4+ideo.x_W4+AGE_W4+male.dum_W4+white.dum_W4+party3_W4+INCOME_W4, 
               data=dat)
sum(summary(m.interest)$coeff[,1])

