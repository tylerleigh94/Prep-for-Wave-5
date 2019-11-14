* Encoding: UTF-8.
**Syntax for cleaning Amerispeak Wave 4 Data

compute wave_4=4.

**Political Party

if (p_partyid7_w4 le 3) party2_4=0.
if (p_partyid7_w4 ge 5) party2_4=1.
value labels party2_4 0 'democrats' 1 'republicans'.
if (party2_4=1) rep_4=1.
if (party2_4=0) dem_4=1.
recode dem_4 rep_4 (1=1) (missing=0) (else=0).
recode p_partyid7_w4 (1,2,3=0) (else=1) into demnot_4.
recode p_partyid7_w4 (5,6,7=0) (else=1) into repnot_4.

if (p_partyid7_w4 lt 3) party3_4=0.
if (p_partyid7_w4 gt 5) party3_4=1.
if (p_partyid7_w4 = 3 or p_partyid7_w4 = 4 or p_partyid7_w4 = 5) party3_4=.5.
value labels party3_4 0 'democrats' .5 'independents' 1 'republicans'.

**General Media Trust. High=high

missing values GENMEDTRUST_W4 (77, 98, 99).

recode GENMEDTRUST_W4 (1=4) (2=3) (3=2) (4=1) into genmedtrustr_4.

**Sum of TV shows watched

compute tv.sum_4=SUM(me2a_1_w4 to me2a_21_w4, me2b_1_w4 to me2b_20_w4).

**Interest in Politics. High=high

missing values Q16_W4 (77, 98, 99).

recode  Q16_W4  (1=4) (2=3) (3=2) (4=1) into q16r_4.

**therms

missing values THERMTRUMP_W4 THERM5_W4 THERMNEW1_W4 THERMNEW2_W4 THERMNEW3_W4 (777, 998, 999).
compute therm1_4=THERMTRUMP_W4.
compute thermwarren_4=THERMNEW1_W4.
compute thermharris_4=THERMNEW2_W4.
compute thermsanders_4=THERMNEW3_W4.

**Primary nomination first choices

missing values DEM1_W4 DEM2_W4 DEM3_W4 DEM5_W4 (77, 98, 99).

compute bidenfirst_4=0.
if (DEM1_W4=1) bidenfirst_4=1.

compute sandersfirst_4=0.
if (DEM1_W4=2) sandersfirst_4=1.

compute harrisfirst_4=0.
if (DEM1_W4=3) harrisfirst_4=1.

compute warrenfirst_4=0.
if (DEM1_W4=4) warrenfirst_4=1.

compute orourkefirst_4=0.
if (DEM1_W4=5) orourkefirst_4=1.

compute buttigiegfirst_4=0. 
if (DEM1_W4=5) buttigiegfirst_4=1.

compute bookerfirst_4=0.
if (DEM1_W4=5) bookerfirst_4=1.

compute klobucharfirst_4=0.
if (DEM1_W4=5) klobucharfirst_4=1.

compute castrofirst_4=0.
if (DEM1_W4=5) castrofirst_4=1.

**Primary nomination second choice

compute bidensec_4=0.
if (DEM2_W4=1) bidensec_4=1.

compute sanderssec_4=0.
if (DEM2_W4=2) sanderssec_4=1.

compute harrissec_4=0.
if (DEM2_W4=3) harrissec_4=1.

compute warrensec_4=0.
if (DEM2_W4=4) warrensec_4=1.

compute orourkesec_4=0.
if (DEM2_W4=5) orourkesec_4=1.

compute buttigiegsec_4=0. 
if (DEM2_W4=5) buttigiegsec_4=1.

compute bookersec_4=0.
if (DEM2_W4=5) bookersec_4=1.

compute klobucharsec_4=0.
if (DEM2_W4=5) klobucharsec_4=1.

compute castrosec_4=0.
if (DEM2_W4=5) castrosec_4=1.

**First choice viability

compute bidenvia1_4=0.
if (DEM3_W4=1) bidenvia1_4=1.

compute sandersvia1_4=0.
if (DEM3_W4=2) sandersvia1_4=1.

compute harrisvia1_4=0.
if (DEM3_W4=3) harrisvia1_4=1.

compute warrenvia1_4=0.
if (DEM3_W4=4) warrenvia1_4=1.

compute orourkevia1_4=0.
if (DEM3_W4=5) orourkevia1_4=1.

compute buttigiegvia1_4=0. 
if (DEM3_W4=5) buttigiegvia1_4=1.

compute bookervia1_4=0.
if (DEM3_W4=5) bookervia1_4=1.

compute klobucharvia1_4=0.
if (DEM3_W4=5) klobucharvia1_4=1.

compute castrovia1_4=0.
if (DEM3_W4=5) castrovia1_4=1.

**Second choice viability

compute bidenvia2_4=0.
if (DEM4_W4=1) bidenvia2_4=1.

compute sandersvia2_4=0.
if (DEM4_W4=2) sandersvia2_4=1.

compute harrisvia2_4=0.
if (DEM4_W4=3) harrisvia2_4=1.

compute warrenvia2_4=0.
if (DEM4_W4=4) warrenvia2_4=1.

compute orourkevia2_4=0.
if (DEM4_W4=5) orourkevia2_4=1.

compute buttigiegvia2_4=0. 
if (DEM4_W4=5) buttigiegvia2_4=1.

compute bookervia2_4=0.
if (DEM4_W4=5) bookervia2_4=1.

compute klobucharvia2_4=0.
if (DEM4_W4=5) klobucharvia2_4=1.

compute castrovia2_4=0.
if (DEM4_W4=5) castrovia2_4=1.

**Dem Candidate electability

compute bidenelect_4=0.
if (DEM5_W4=1) bidenelect_4=1.

compute sanderselect_4=0.
if (DEM5_W4=2) sanderselect_4=1.

compute harriselect_4=0.
if (DEM5_W4=3) harriselect_4=1.

compute warrenelect_4=0.
if (DEM5_W4=4) warrenelect_4=1.

compute orourkeelect_4=0.
if (DEM5_W4=5) orourkeelect_4=1.

compute buttigiegelect_4=0. 
if (DEM5_W4=5) buttigiegelect_4=1.

compute bookerelect_4=0.
if (DEM5_W4=5) bookerelect_4=1.

compute klobucharelect_4=0.
if (DEM5_W4=5) klobucharelect_4=1.

compute castroelect_4=0.
if (DEM5_W4=5) castroelect_4=1.

**Candidate Ideological Position

missing values canscale_1_W4 canscale_2_W4 canscale_3_W4 canscale_4_W4 canscale_5_W4 (77, 98, 99).

compute trumpideo_4=canscale_1_W4.
compute bidenideo_4=canscale_2_W4.
compute sandersideo_4=canscale_3_w4.
compute harrisideo_4=canscale_4_w4.
compute warrenideo_4=canscale_5_w4.

**economic perceptions (5 = better)

missing values eco1_w4 eco3_w4 (77, 98, 99).

recode eco1_w4 (1=5) (5=3) (2=4) (3=2) (4=1) into ecoperc_4.
recode eco3_w4 (1=5) (5=3) (2=4) (3=2) (4=1) into perecoperc_4.

**Fairness (3=high)

missing values fair1_w4 fair3_w4 fair4_w4 (77, 98, 99).

recode fair1_w4 (1=3) (2=2) (3=1) into fair1r_4.
recode fair3_w4 (1=3) (2=2) (3=1) into fair3r_4.
recode fair4_w4 (1=3) (2=2) (3=1) into fair4r_4.

**Gap between rich and poor (high=larger gap)

missing values gap1_w4 (77, 98, 99).

recode gap1_w4 (1=5) (2=4) (3=3) (4=2) (5=1) into gap1r_4.

**Social trust (high=trusting)

missing values st1_w4 st2_w4 st3_w4 (77, 98, 99).

recode st1_W4 (1=1) (2=0) into st1r_4.
recode st2_W4 (1=0) (2=1) into st2r_4.
recode st3_W4 (1=1) (2=0) into st3r_4.

RELIABILITY
  /VARIABLES=st1r_4 st2r_4 st3r_4
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /SUMMARY=TOTAL.

compute socialtrust_4=mean.1(st1r_4, st2r_4, st3r_4).

***market conservatism (high=pro market forces)

missing values mkt1_W4 mkt2_W4 mkt3_W4 (77, 98, 99).

recode mkt1_W4 (1=4) (4=1) (2=3) (3=2) into mkt1r_4.
recode mkt2_W4 (1=4) (4=1) (2=3) (3=2) into mkt2r_4.
recode mkt3_W4 (1=4) (4=1) (2=3) (3=2) into mkt3r_4.

compute market_4=mean.1(mkt1r_4, mkt2r_4, mkt3r_4).

RELIABILITY
  /VARIABLES=mkt1r_4 mkt2r_4 mkt3r_4
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /SUMMARY=TOTAL.

**Foreign/Zeitgeist items (high=tolerant of foreign languages)

missing values foreign1_w4 foreign2_w4 (77, 98, 99).

recode foreign1_w4 (1=4) (4=1) (2=3) (3=2) into foreign1r_4.
compute foreign2_4=foreign2_w4.

**Government trust (high = high)

missing values gt1_w4 gt2_w4 gt3_w4 gt4_w4 (77, 98, 99).
recode gt1_w4 (1=1) (5=0) (4=.25) (2=.75) (3=.5) into gt1r_4.
recode gt2_w4 (1=0) (2=1) into gt2r_4.
recode gt3_w4 (1=0) (2=.5) (3=1) into gt3r_4.
recode gt4_w4 (1=0) (2=.25) (3=.5) (4=.75) (5=1) into gt4r_4.


RELIABILITY
  /VARIABLES= gt1r_4 gt2r_4 gt3r_4 gt4r_4
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /SUMMARY=TOTAL.

compute govttrust_4=mean.1(gt1r_4, gt2r_4, gt3r_4, gt4r_4).

***stereotypes (high=positive evaluation) 

missing values hardworking_b_w4 hardworking_W_w4 hardworking_H_w4 violent_B_w4  violent_W_w4  violent_H_w4 (777, 998, 999).

compute hardworking_BR_4=(100-hardworking_b_w4).
compute hardworking_wR_4=(100-hardworking_w_w4).
compute hardworking_hR_4=(100-hardworking_h_w4).

compute blackmean_4=mean.1(hardworking_BR_4, violent_B_w4).
compute whitemean_4=mean.1(hardworking_WR_4, violent_W_w4).
compute hispanicmean_4=mean.1(hardworking_HR_4, violent_H_w4).


do if (racethnicity_w4=1).
compute prejudice_4=whitemean_4-mean(hispanicmean_4, blackmean_4).
else if (racethnicity_w4=2).
compute prejudice_4=blackmean_4-mean(hispanicmean_4, whitemean_4).
else if (racethnicity_W4=4).
compute prejudice_4=hispanicmean_4-mean(whitemean_4, blackmean_4).
end if.



**feeling toward outgroup without comparison

do if (racethnicity_W4=1).
compute outgroupmean_4=mean(hispanicmean_4, blackmean_4).
else if (racethnicity_W4=2).
compute outgroupmean_4=mean(hispanicmean_4, whitemean_4).
else if (racethnicity_W4=4).
compute outgroupmean_4=mean(whitemean_4, blackmean_4).
else if (racethnicity_W4=3 or racethnicity_W4=5).
compute outgroupmean_4=mean(whitemean_4, blackmean_4, hispanicmean_4).
end if.

if (racethnicity_w4=1) white_4=1.
if (racethnicity_w4 ne 1) white_4=0.

if (employ_w4=3 or employ_w4=4) unemployed_4=1.
recode unemployed_4 (1=1) (missing=0).

**supreme court (high=support)

missing values sc1_w4 (77, 98, 99).

recode sc1_w4 (1=5) (5=1) (4=2) (2=4) (3=3) into sc1r_4.
missing values sc1r_4 (77, 98, 99).

**war

recode war1_W4 (77,98,99=99).
recode war1_W4 (1=1) (2=0) into yeswar_4.

**Guns (5/high=looser laws)

missing values guns_w4 (77, 98, 99).

**Immigration (high=support)

missing values im1_W4  im2_W4  im3_W4 (77, 98, 99).
compute im2r_4=im2_w4.
compute im3r_4=im3_w4.
recode im1_W4  (1=5) (5=1) (4=2) (2=4) (3=3) into im1r_4.


RELIABILITY
  /VARIABLES=im1r_4 im2r_4 im3r_4
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /SUMMARY=TOTAL.

compute immigindex_4=mean.1(im1r_4, im2r_4, im3r_4).

**healthcare (high=better/pro)

missing values hc1_w4 HC2_W4 (77, 98, 99).

recode hc1_w4 (1=5) (5=1) (4=2) (2=4) (3=3) into hc1r_4.
recode hc2_w4 (1=4) (2=3) (3=2) (4=1) into hc2r_4. 

**trade (high=pro)

missing values tr1_w4 (77, 98, 99).

recode tr1_w4 (1=5) (2=4) (3=3) (4=2) (5=1) into tr1r_4.

**Trade amount/personal effects/overall economic effects (high = increase/better)

missing values tradeamt_w4 tradepersonal_w4 tradecon2_w4 (77, 98, 99).

recode tradeamt_w4 (1=5) (2=4) (3=3) (4=2) (5=1) into tradeamtr_4.
recode tradepersonal_w4 (1=5) (2=4) (3=3) (4=2) (5=1) into tradepersonalr_4.
recode tradecon2_w4 (1=5) (2=4) (3=3) (4=2) (5=1) into tradecon2r_4.

**Peace (high = trade good for peace)

missing values peace_w4 (77, 98, 99).

recode peace_w4  (1=5) (2=4) (3=3) (4=2) (5=1) into peacer_4.

***worry/anxiety (high=more worried) DONE

recode pt1_W4 (1=4) (4=1) (2=3) (3=2) into pt1r_4.
recode pt2_W4  (1=4) (4=1) (2=3) (3=2) into pt2r_4.
recode pt3_W4  (1=4) (4=1) (2=3) (3=2) into pt3r_4.
recode pt4_W4  (1=4) (4=1) (2=3) (3=2) into wayoflife_4.
recode pt5_W4  (1=4) (4=1) (2=3) (3=2) into terrorismthreat_4.


RELIABILITY
  /VARIABLES=pt1r_4 pt2r_4 pt3r_4
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /SUMMARY=TOTAL.

**PREVIOUS WAVES ONLY USED 1-3, JUST WANT TO CONFIRM THAT IS CORECT

compute persecoinsecur_4=mean.1(pt1r_4, pt2r_4, pt3r_4). 

**Jobs (high = increased jobs)

missing values usjobs_w4 tpjobs_w4 (77, 98, 99).
recode usjobs_w4 (1=5) (2=4) (3=3) (4=2) (5=1) into usjobsr_4.
recode tpjobs_w4 (1=5) (2=4) (3=3) (4=2) (5=1) into tpjobsr_4.

**Polarization (high=polarized)

missing values pp1_w4 pp2_w4 pp3_w4 pp4_w4 (77, 98, 99).

recode PP3_w4 (1=4) (4=1) (2=3) (3=2) into pp3r_4.
recode PP4_w4 (1=4) (4=1) (2=3) (3=2) into pp4r_4.

RELIABILITY
  /VARIABLES=pp1_w4 pp2_w4 pp3r_4 pp4r_4
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /SUMMARY=TOTAL.

compute polarindex_4=mean.1(pp1_w4, pp2_w4, pp3r_4, pp4r_4).

**System Legitimacy (high=legit)

missing values sl1_w4 sl2_w4 sl3_w4 sl4_w4 (77, 98, 99).

recode sl1_w4 (1=5) (5=1) (2=4) (4=2) (3=3) into sl1r_4.
recode sl3_w4 (1=5) (5=1) (2=4) (4=2) (3=3) into sl3r_4.

RELIABILITY
  /VARIABLES= sl1r_4 sl2_w4 sl3r_4 sl4_w4
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /SUMMARY=TOTAL.

compute syslegindex_4=mean.1(sl1r_4, sl2_w4, sl3r_4, sl4_w4).

**Taxes/Safety net (high = higher taxes/more safety net)

missing values tsn1_w4 tsn2_w4 (77, 98, 99).

recode tsn1_w4 (1=5) (5=1) (2=4) (4=2) (3=3) into tsn1r_4.

***Can't calculate reliability with just two items. Previous waves included this code, so I included it here as well

RELIABILITY
  /VARIABLES=tsn1r_4 tsn2_w4
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /SUMMARY=TOTAL.

compute safetynet_4=mean.1(tsn1r_4, tsn2_w4).

**National Superiority (high=superior)

missing values ns1_w4 ns2_w4 ns3_w4 (77, 98, 99).
recode ns1_w4 (1=5) (5=1) (4=2) (2=4) (3=3) into ns1r_4.
recode ns2_w4 (1=5) (5=1) (4=2) (2=4) (3=3) into ns2r_4.
recode ns3_w4 (1=5) (5=1) (4=2) (2=4) (3=3) into ns3r_4.

RELIABILITY
  /VARIABLES= ns1r_4 ns2r_4 ns3r_4
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /SUMMARY=TOTAL.

compute natsupindex_4=mean.1(ns1r_4, ns2r_4, ns3r_4).

**Support for govt helping minorities (high = high support)

missing values race1_w4 (77, 98, 99).

recode race1_w4 (1=5) (2=4) (3=3) (4=2) (5=1) into race1r_4.

***perceived discrimination

missing values dis1_w4 to dis9_w4 (77, 98, 99).

recode dis1_w4 (1=5) (5=1) (4=2) (2=4) (3=3) into dis1r_4.
recode dis2_w4 (1=5) (5=1) (4=2) (2=4) (3=3) into dis2r_4.
recode dis3_w4 (1=5) (5=1) (4=2) (2=4) (3=3) into dis3r_4.
recode dis4_w4 (1=5) (5=1) (4=2) (2=4) (3=3) into dis4r_4.
recode dis5_w4 (1=5) (5=1) (4=2) (2=4) (3=3) into dis5r_4.
recode dis6_w4 (1=5) (5=1) (4=2) (2=4) (3=3) into dis6r_4.
recode dis7_w4 (1=5) (5=1) (4=2) (2=4) (3=3) into dis7r_4.
recode dis8_w4 (1=5) (5=1) (4=2) (2=4) (3=3) into dis8r_4.
recode dis9_w4 (1=5) (5=1) (4=2) (2=4) (3=3) into dis9r_4.
compute disblack_4=dis1r_4.
compute dishispanic_4=dis2r_4.
compute diswhite_4=dis3r_4.
compute diswomen_4 = dis4r_4.
compute dismen_4=dis5r_4.
compute dismuslim_4=dis6r_4.
compute dischristian_4=dis7r_4.
compute disrural_4=dis8r_4.
compute disasian_4=dis9r_4.

**What to do with asian and rural discrimination?

compute majorrelig_4=dischristian_4-dismuslim_4.
compute majorsex_4=dismen_4-diswomen_4.
compute majorrace_4=diswhite_4-disblack_4.
missing values majorrelig_4 majorsex_4 majorrace_4 (77,98,99).
correlations/variables = majorrelig_4 majorrace_4 majorsex_4.

RELIABILITY
  /VARIABLES= majorrelig_4 majorrace_4 majorsex_4
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /SUMMARY=TOTAL.

compute highstatusdisc_4=mean.1(majorrelig_4, majorrace_4, majorsex_4).

**US Standing (high=better)

missing values stand_w4 (77, 98, 99).

recode stand_w4 (1=5) (2=4) (3=3) (4=2) (5=1) into standr_w4.

**Isolationism (high=isolationist)

missing values iso1_w4 iso2_w4 iso3_w4 iso4_w4 iso5_w4 (77, 98, 99).
recode iso2_w4  (1=5) (5=1) (2=4) (4=2) (3=3) into iso2r_4.
recode iso4_w4 (1=5) (5=1) (2=4) (4=2) (3=3) into iso4r_4.


RELIABILITY
  /VARIABLES= iso1_w4 iso2r_4 iso3_w4 iso4r_4 iso5_w4
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /SUMMARY=TOTAL.

compute isoindex_4=mean.1(iso1_w4, iso2r_4, iso3_w4, iso4r_4, iso5_w4).

**Zeitgeist (high = became more supportive of immigration/trade)

missing values z1_w4 z2_w4 (77, 98, 99).

recode z1_w4 (1=5) (2=4) (3=3) (4=2) (5=1) into z1r_4.
recode z2_w4 (1=5) (2=4) (3=3) (4=2) (5=1) into z2r_4.

***sdo (high= high on sdo) ONLY W1

missing values sd1_w4 to sd4_w4 (77, 98, 99).
recode sd1_w4 (1=10) (10=1) (2=9) (9=2) (3=8) (8=3) (4=7) (7=4) (5=6) (6=5) into sd1r_4.
recode sd3_w4 (1=10) (10=1) (2=9) (9=2) (3=8) (8=3) (4=7) (7=4) (5=6) (6=5) into sd3r_4.
pearson corr vars = sd1r_4 sd2_w4 sd3r_4 sd4_w4.

RELIABILITY
  /VARIABLES= sd1r_4 sd2_w4 sd3r_4 sd4_w4
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /SUMMARY=TOTAL.

compute sdoindex_4=mean.1(sd1r_4, sd2_w4, sd3r_4, sd4_w4).

*China (high=pro/strong)

missing values chi_w4 chi2_w4 (77, 98, 99).
recode chi_w4 (3=2) (1=3) (2=1) into china_4.
recode chi2_w4 (1=2) (2=1) into chi2r_4.

**Civil Liberties vs security (high = too restrictive)

missing values cl1_w4 (77, 98, 99). 
recode cl1_w4 (1=2) (2=1) into sl1r_4.

**Russia Interference (high= high interference)

missing values rus1_w4 (77, 98, 99).
recode rus1_w4 (1=5) (2=4) (3=3) (4=2) (5=1) into rus1r_4.

** Social media use dummy variables (1= uses platform)

missing values social1_1_w4  social1_2_w4  social1_3_w4  social1_4_w4 (77, 98, 99).

compute fb.use.dum_4=0.
if (social1_1_w4 gt 1) fb.use.dum_4=1.

compute yt.use.dum_4=0.
if (social1_2_w4 gt 1) yt.use.dum_4=1.

compute tw.use.dum_4=0.
if (social1_3_w4 gt 1) tw.use.dum_4=1.

compute ig.use.dum_4=0.
if (social1_4_w4 gt 1) ig.use.dum_4=1.

**Perceived Credibility (high = credible)

missing values social2_1_w4 social2_2_w4 social2_3_w4 social2_4_w4 (77, 98, 99).

recode social2_1_w4 (1=6) (2=5) (3=4) (4=3) (5=2) (6=1) into fb.cred_4.
recode social2_2_w4 (1=6) (2=5) (3=4) (4=3) (5=2) (6=1) into yt.cred_4.
recode social2_3_w4 (1=6) (2=5) (3=4) (4=3) (5=2) (6=1) into tw.cred_4.
recode social2_4_w4 (1=6) (2=5) (3=4) (4=3) (5=2) (6=1) into ig.cred_4.

**Passive Exposure (high = high)

missing values social3_1_w4 social3_2_w4 social3_3_w4 social3_4_w4 (77, 98, 99).

compute fb.passive.exp_4=social3_1_w4.
compute yt.passive.exp_4=social3_2_w4.
compute tw.passive.exp_4=social3_3_w4.
compute ig.passive.exp_4=social3_4_w4.

**Active exposure (sum=total number of groups;

compute fb.group.sum_4=SUM(social4_facec_1_w4 to social4_facec_6_w4).
compute tw.group.sum_4=SUM(social4_twit_1_w4 to social4_twit_6_w4).
compute yt.group.sum_4=SUM(social4_you_1_w4 to social4_you_6_w4).
compute ig.group.sum_4=SUM(social4_inst_1_w4 to social4_inst_6_w4).

compute fb.pol.group.dum_4=social4_facec_1_w4.
compute yt.pol.group.dum_4=social4_you_1_w4.
compute tw.pol.group.dum_4=social4_twit_1_w4.
compute ig.pol.group.dum_4=social4_inst_1_w4.

compute fb.act.exp.prop_4=fb.pol.group.dum_4/fb.group.sum_4.
compute yt.act.exp.prop_4=yt.pol.group.dum_4/yt.group.sum_4.
compute tw.act.exp.prop_4=tw.pol.group.dum_4/tw.group.sum_4.
compute ig.act.exp.prop_4=ig.pol.group.dum_4/ig.group.sum_4.

**Social media (high=support taking down)

missing values socmed_w4 (77, 98, 99).
recode socmed_w4  (1=5) (2=4) (3=3) (4=2) (5=1) into socmedr_4.

**Perceived civility of discourse (high=civil)

missing values civil1_w4 civil2_w4 civil3_w4 civil4_w4 civil5_w4 (77, 98, 99).
recode civil2_w4 (1=10) (2=9) (3=8) (4=7) (5=6) (6=5) (7=4) (8=3) (9=2) (10=1) into civil2r_4.
recode civil4_w4 (1=10) (2=9) (3=8) (4=7) (5=6) (6=5) (7=4) (8=3) (9=2) (10=1) into civil4r_4. 
compute civil1r_4=civil1_w4.
compute civil3r_4=civil3_w4.
compute civil5r_4=civil5_w4.

RELIABILITY
    /VARIABLES=  civil1r_4 civil2r_4 civil3r_4 civil4r_4 civil5r_4
    /SCALE('ALL VARIABLES') ALL
    /MODEL=ALPHA
    /SUMMARY=TOTAL.

compute civildisc_4=mean.1(civil1r_4, civil2r_4, civil3r_4, civil4r_4, civil5r_4).

**International Trust (high=high trust)

missing values ITRUST_w4 (77, 98, 99).
recode itrust_w4 (1=5) (2=4) (3=3) (4=2) (5=1) into itrustr_4.

**Russia Interference (high= high interference)

missing values rus1_w4 (77, 98, 99).
recode rus1_w4 (1=5) (2=4) (3=3) (4=2) (5=1) into rus1r_4.

**Remove Trmump (high=remove)

missing values trump1_w4 (77, 98, 99).

recode trump1_w4 (1=4) (2=3) (3=2) (4=1) into trump1r_4.

**Political Tolerance

missing values pol_t2_1_w4 pol_t2_2_w4 pol_t2_3_w4 (77, 98, 99).

recode pol_t2_1_w4 (1=5) (2=4) (3=3) (4=2) (5=1) into pol_t2_1r_4.

reliability
    /variables= pol_t2_1r_4 pol_t2_2_w4 pol_t2_3_w4
    /scale('all variables')all
    /model=ALPHA
    /summary=total.

compute poltol_4=mean.1(pol_t2_1_w4, pol_t2_2_w4, pol_t2_3_w4).

EXECUTE.


descriptives civildisc_4.

