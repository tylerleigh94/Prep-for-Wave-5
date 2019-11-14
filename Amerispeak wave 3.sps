* Encoding: UTF-8.
***syntax for wave 1, 2 of amerispeak panel

compute wave_3=3.

***new recodes

missing values PARTYID7_W3 (-1).
t-test/pairs= partyid7_w1 PARTYID7_W2.
t-test/pairs= partyid7_w1 partyid7_w3.
t-test/pairs= partyid7_w2 partyid7_w3.

FREQUENCIES vars = PARTYID7_W3.

**Convote recodes to vote dem, rep, or ind (1= vote, 0= no vote)

missing values convote_w3 (77, 98, 99).

if (p_hcmpgnType_w3=1 AND convote_w3=1) convoterep_3=0.
if (p_hcmpgnType_w3=1 AND convote_w3=1) convotedem_3=1.
if (p_hcmpgnType_w3=1 AND convote_w3=1) convoteind_3=0.

if (p_hcmpgnType_w3=1 AND convote_w3=2) convoterep_3=1.
if (p_hcmpgnType_w3=1 AND convote_w3=2) convotedem_3=0.
if (p_hcmpgnType_w3=1 AND convote_w3=2) convoteind_3=0.

if (p_hcmpgnType_w3=1 AND convote_w3=3) convoterep_3=0.
if (p_hcmpgnType_w3=1 AND convote_w3=3) convotedem_3=0.
if (p_hcmpgnType_w3=1 AND convote_w3=3) convoteind_3=0.

if (p_hcmpgnType_w3=1 AND convote_w3=5) convoterep_3=0.
if (p_hcmpgnType_w3=1 AND convote_w3=5) convotedem_3=0.
if (p_hcmpgnType_w3=1 AND convote_w3=5) convoteind_3=0.


if (p_hcmpgnType_w3=2 AND convote_w3=1) convoterep_3=0.
if (p_hcmpgnType_w3=2 AND convote_w3=1) convotedem_3=1.
if (p_hcmpgnType_w3=2 AND convote_w3=1) convoteind_3=0.

if (p_hcmpgnType_w3=2 AND convote_w3=2) convoterep_3=0.
if (p_hcmpgnType_w3=2 AND convote_w3=2) convotedem_3=0.
if (p_hcmpgnType_w3=2 AND convote_w3=2) convoteind_3=1.

if (p_hcmpgnType_w3=2 AND convote_w3=3) convoterep_3=0.
if (p_hcmpgnType_w3=2 AND convote_w3=3) convotedem_3=0.
if (p_hcmpgnType_w3=2 AND convote_w3=3) convoteind_3=0.

if (p_hcmpgnType_w3=2 AND convote_w3=5) convoterep_3=0.
if (p_hcmpgnType_w3=2 AND convote_w3=5) convotedem_3=0.
if (p_hcmpgnType_w3=2 AND convote_w3=5) convoteind_3=0.


if (p_hcmpgnType_w3=3 AND convote_w3=1) convoterep_3=1.
if (p_hcmpgnType_w3=3 AND convote_w3=1) convotedem_3=0.
if (p_hcmpgnType_w3=3 AND convote_w3=1) convoteind_3=0.

if (p_hcmpgnType_w3=3 AND convote_w3=2) convoterep_3=0.
if (p_hcmpgnType_w3=3 AND convote_w3=2) convotedem_3=0.
if (p_hcmpgnType_w3=3 AND convote_w3=2) convoteind_3=1.

if (p_hcmpgnType_w3=3 AND convote_w3=3) convoterep_3=0.
if (p_hcmpgnType_w3=3 AND convote_w3=3) convotedem_3=0.
if (p_hcmpgnType_w3=3 AND convote_w3=3) convoteind_3=0.

if (p_hcmpgnType_w3=3 AND convote_w3=5) convoterep_3=0.
if (p_hcmpgnType_w3=3 AND convote_w3=5) convotedem_3=0.
if (p_hcmpgnType_w3=3 AND convote_w3=5) convoteind_3=0.


if (p_hcmpgnType_w3=4 AND convote_w3=1) convoterep_3=0.
if (p_hcmpgnType_w3=4 AND convote_w3=1) convotedem_3=1.
if (p_hcmpgnType_w3=4 AND convote_w3=1) convoteind_3=0.

if (p_hcmpgnType_w3=4 AND convote_w3=2) convoterep_3=0.
if (p_hcmpgnType_w3=4 AND convote_w3=2) convotedem_3=1.
if (p_hcmpgnType_w3=4 AND convote_w3=2) convoteind_3=0.

if (p_hcmpgnType_w3=4 AND convote_w3=3) convoterep_3=0.
if (p_hcmpgnType_w3=4 AND convote_w3=3) convotedem_3=0.
if (p_hcmpgnType_w3=4 AND convote_w3=3) convoteind_3=0.

if (p_hcmpgnType_w3=4 AND convote_w3=5) convoterep_3=0.
if (p_hcmpgnType_w3=4 AND convote_w3=5) convotedem_3=0.
if (p_hcmpgnType_w3=4 AND convote_w3=5) convoteind_3=0.


if (p_hcmpgnType_w3=5 AND convote_w3=1) convoterep_3=1.
if (p_hcmpgnType_w3=5 AND convote_w3=1) convotedem_3=0.
if (p_hcmpgnType_w3=5 AND convote_w3=1) convoteind_3=0.

if (p_hcmpgnType_w3=5 AND convote_w3=2) convoterep_3=1.
if (p_hcmpgnType_w3=5 AND convote_w3=2) convotedem_3=0.
if (p_hcmpgnType_w3=5 AND convote_w3=2) convoteind_3=0.

if (p_hcmpgnType_w3=5 AND convote_w3=3) convoterep_3=0.
if (p_hcmpgnType_w3=5 AND convote_w3=3) convotedem_3=0.
if (p_hcmpgnType_w3=5 AND convote_w3=3) convoteind_3=0.

if (p_hcmpgnType_w3=5 AND convote_w3=5) convoterep_3=0.
if (p_hcmpgnType_w3=5 AND convote_w3=5) convotedem_3=0.
if (p_hcmpgnType_w3=5 AND convote_w3=5) convoteind_3=0.

FREQUENCIES vars= convoterep_3 convotedem_3 convoteind_3. 

**Candidate support for Trump (high=support)

missing values trumpcon_w3 trumpcon2_w3 (77, 98, 99).
recode trumpcon_w3 (1=3) (2=1) (3=2) into trumpconr_3.
recode trumpcon2_w3 (1=3) (2=1) (3=2) into trumpcon2r_3.

**Senate Candidate

missing values convote_w3 (77, 98, 99).

if (p_scmpgnType_w3=1 AND senvote_w3=1) senvoterep_3=0.
if (p_scmpgnType_w3=1 AND senvote_w3=1) senvotedem_3=1.
if (p_scmpgnType_w3=1 AND senvote_w3=1) senvoteind_3=0.

if (p_scmpgnType_w3=1 AND senvote_w3=2) senvoterep_3=1.
if (p_scmpgnType_w3=1 AND senvote_w3=2) senvotedem_3=0.
if (p_scmpgnType_w3=1 AND senvote_w3=2) senvoteind_3=0.

if (p_scmpgnType_w3=1 AND senvote_w3=3) senvoterep_3=0.
if (p_scmpgnType_w3=1 AND senvote_w3=3) senvotedem_3=0.
if (p_scmpgnType_w3=1 AND senvote_w3=3) senvoteind_3=0.

if (p_scmpgnType_w3=1 AND senvote_w3=5) senvoterep_3=0.
if (p_scmpgnType_w3=1 AND senvote_w3=5) senvotedem_3=0.
if (p_scmpgnType_w3=1 AND senvote_w3=5) senvoteind_3=0.


if (p_scmpgnType_w3=2 AND senvote_w3=1) senvoterep_3=0.
if (p_scmpgnType_w3=2 AND senvote_w3=1) senvotedem_3=1.
if (p_scmpgnType_w3=2 AND senvote_w3=1) senvoteind_3=0.

if (p_scmpgnType_w3=2 AND senvote_w3=2) senvoterep_3=0.
if (p_scmpgnType_w3=2 AND senvote_w3=2) senvotedem_3=0.
if (p_scmpgnType_w3=2 AND senvote_w3=2) senvoteind_3=1.

if (p_scmpgnType_w3=2 AND senvote_w3=3) senvoterep_3=0.
if (p_scmpgnType_w3=2 AND senvote_w3=3) senvotedem_3=0.
if (p_scmpgnType_w3=2 AND senvote_w3=3) senvoteind_3=0.

if (p_scmpgnType_w3=2 AND senvote_w3=5) senvoterep_3=0.
if (p_scmpgnType_w3=2 AND senvote_w3=5) senvotedem_3=0.
if (p_scmpgnType_w3=2 AND senvote_w3=5) senvoteind_3=0.


if (p_scmpgnType_w3=3 AND senvote_w3=1) senvoterep_3=1.
if (p_scmpgnType_w3=3 AND senvote_w3=1) senvotedem_3=0.
if (p_scmpgnType_w3=3 AND senvote_w3=1) senvoteind_3=0.

if (p_scmpgnType_w3=3 AND senvote_w3=2) senvoterep_3=0.
if (p_scmpgnType_w3=3 AND senvote_w3=2) senvotedem_3=0.
if (p_scmpgnType_w3=3 AND senvote_w3=2) senvoteind_3=1.

if (p_scmpgnType_w3=3 AND senvote_w3=3) senvoterep_3=0.
if (p_scmpgnType_w3=3 AND senvote_w3=3) senvotedem_3=0.
if (p_scmpgnType_w3=3 AND senvote_w3=3) senvoteind_3=0.

if (p_scmpgnType_w3=3 AND senvote_w3=5) senvoterep_3=0.
if (p_scmpgnType_w3=3 AND senvote_w3=5) senvotedem_3=0.
if (p_scmpgnType_w3=3 AND senvote_w3=5) senvoteind_3=0.


if (p_scmpgnType_w3=4 AND senvote_w3=1) senvoterep_3=0.
if (p_scmpgnType_w3=4 AND senvote_w3=1) senvotedem_3=1.
if (p_scmpgnType_w3=4 AND senvote_w3=1) senvoteind_3=0.

if (p_scmpgnType_w3=4 AND senvote_w3=2) senvoterep_3=0.
if (p_scmpgnType_w3=4 AND senvote_w3=2) senvotedem_3=1.
if (p_scmpgnType_w3=4 AND senvote_w3=2) senvoteind_3=0.

if (p_scmpgnType_w3=4 AND senvote_w3=3) senvoterep_3=0.
if (p_scmpgnType_w3=4 AND senvote_w3=3) senvotedem_3=0.
if (p_scmpgnType_w3=4 AND senvote_w3=3) senvoteind_3=0.

if (p_scmpgnType_w3=4 AND senvote_w3=5) senvoterep_3=0.
if (p_scmpgnType_w3=4 AND senvote_w3=5) senvotedem_3=0.
if (p_scmpgnType_w3=4 AND senvote_w3=5) senvoteind_3=0.


if (p_scmpgnType_w3=5 AND senvote_w3=1) senvoterep_3=1.
if (p_scmpgnType_w3=5 AND senvote_w3=1) senvotedem_3=0.
if (p_scmpgnType_w3=5 AND senvote_w3=1) senvoteind_3=0.

if (p_scmpgnType_w3=5 AND senvote_w3=2) senvoterep_3=1.
if (p_scmpgnType_w3=5 AND senvote_w3=2) senvotedem_3=0.
if (p_scmpgnType_w3=5 AND senvote_w3=2) senvoteind_3=0.

if (p_scmpgnType_w3=5 AND senvote_w3=3) senvoterep_3=0.
if (p_scmpgnType_w3=5 AND senvote_w3=3) senvotedem_3=0.
if (p_scmpgnType_w3=5 AND senvote_w3=3) senvoteind_3=0.

if (p_scmpgnType_w3=5 AND senvote_w3=5) senvoterep_3=0.
if (p_scmpgnType_w3=5 AND senvote_w3=5) senvotedem_3=0.
if (p_scmpgnType_w3=5 AND senvote_w3=5) senvoteind_3=0.

FREQUENCIES vars= senvoterep_3 senvotedem_3 senvoteind_3. 

**Senate candidate support for trump

missing values trumpsen_w3 (77, 98, 99).
recode trumpsen_w3  (1=3) (2=1) (3=2) into trumpsenr_3.

CORRELATIONS /variables=  senvoterep_3 senvotedem_3 senvoteind_3 trumpsenr_3.

**trust in own media (4=high).

missing values mtrust1_w3 mtrust2_w3 mtrust3_w3 (77, 98, 99).
recode mtrust1_w3 (1=4) (2=3) (3=2) (4=1) into mtrust1r_3.
recode mtrust2_w3 (1=4) (2=3) (3=2) (4=1) into mtrust2r_3.
recode mtrust3_w3 (1=4) (2=3) (3=2) (4=1) into mtrust3r_3.

**Thermometers.

missing values thermtrump_w3 therm3_w3 therm4_w3 therm5_w3 (777, 998, 999).
compute therm1_3=thermtrump_w3.

descriptives vars=thermtrump_w3.

**party therm recodes

if (rnd_03_w3=0) thermreps_3=therm3_w3.
if (rnd_03_w3=1) thermreps_3=therm4_w3.

if (rnd_03_w3=1) thermdems_3=therm3_w3.
if (rnd_03_w3=0) thermdems_3=therm4_w3.

correlations /variables=thermdems_3 thermreps_3.

compute thermdiffRD_3=thermreps_3-thermdems_3.

**Are multiple t-tests like this okay, or is it bad in the same way we don't use multiple t-tests in experimental analyses?

t-test/pairs= thermdiffRD_1 thermdiffRD_2.
t-test/pairs= thermdiffRD_1 thermdiffRD_3.
t-test/pairs= thermdiffRD_2 thermdiffRD_3.

t-test/pairs= thermreps_1 thermreps_2.
t-test/pairs= thermreps_1 thermreps_3.
t-test/pairs= thermreps_2 thermreps_3.

t-test/pairs=thermdems_1 thermdems_2.
t-test/pairs=thermdems_1 thermdems_3.
t-test/pairs=thermdems_2 thermdems_3.

**economic perceptions (5=high)

missing values eco1_w3 eco3_w3 (77, 98, 99).
recode eco1_w3 (1=5) (5=3) (2=4) (3=2) (4=1) into ecoperc_3.
recode eco3_w3 (1=5) (5=3) (2=4) (3=2) (4=1) into perecoperc_3.
missing values ecoperc_3 perecoperc_3 (77, 98, 99).

**Fairness (3=high)

missing values fair1_w3 fair2_w3 fair4_w3 (77, 98, 99).
recode fair1_w3 (1=3) (2=2) (3=1) into fair1r_3.
recode fair2_w3 (1=3) (2=2) (3=1) into fair2r_3.
recode fair3_w3 (1=3) (2=2) (3=1) into fair3r_3.
recode fair4_w3 (1=3) (2=2) (3=1) into fair4r_3.

**Guns (5/high=looser laws)

missing values guns_w3 (77, 98, 99).

**social trust items (high=trusting)

missing values st1_w3 st2_w3 st3_w3 (77, 98, 99).

recode st1_W3 (1=1) (2=0) into ST1r_3.
recode st2_W3 (1=0) (2=1) into st2r_3.
recode st3_W3 (1=1) (2=0) into st3r_3.
missing values st1r_3 st2r_3 st3r_3 (77, 98, 99).

correlations/ variables= st1r_3 st2r_3 st3r_3.

RELIABILITY
  /VARIABLES=st1r_3 st2r_3 st3r_3
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /SUMMARY=TOTAL.

compute socialtrust_3=mean.1(st1r_3, st2r_3, st3r_3).

**Government trust (high = high)

missing values gt1_w3 gt2_w3 gt3_w3 gt4_w3 (77, 98, 99).
recode gt1_w3 (1=1) (5=0) (4=.25) (2=.75) (3=.5) into gt1r_3.
recode gt2_w3 (1=0) (2=1) into gt2r_3.
recode gt3_w3 (1=0) (2=.5) (3=1) into gt3r_3.
recode gt4_w3 (1=0) (2=.25) (3=.5) (4=.75) (5=1) into gt4r_3.
missing values gt2r_3 gt3r_3 gt4r_3 (77, 98, 99).
pearson corr vars = gt1r_3 gt2r_3 gt3r_3 gt4r_3.


RELIABILITY
  /VARIABLES= gt1r_3 gt2r_3 gt3r_3 gt4r_3
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /SUMMARY=TOTAL.

compute govttrust_3=mean.1(gt1r_3, gt2r_3, gt3r_3, gt4r_3).

**supreme court (high=support)

missing values sc1_w3 (77, 98, 99).

recode sc1_w3 (1=5) (5=1) (4=2) (2=4) (3=3) into sc1r_3.
missing values sc1r_3 (77, 98, 99).

**war

recode war1_W3 (77,98,99=99).
recode war1_W3 (1=1) (2=0) into yeswar_3.

**war certainty (high = high)

missing values warcertain_w3 (77, 98, 99).

**Facebook (high=high)

missing values fbook1_w3 fbook3_w3 (77, 98, 99).

recode fbook1_w3 (1=7) (2=6) (3=5) (4=4) (5=3) (6=2) (7=1) into fbook1r_3.
recode fbook3_w3 (1=4) (2=3) (3=2) (4=1) into fbook3r_3.

**Immigration (high=support)

missing values im1_W3  im2_W3  im3_W3 im1a_w3 im1b_w3 (77, 98, 99).
compute im2r_3=im2_w3.
compute im3r_3=im3_w3.
recode im1_W3  (1=5) (5=1) (4=2) (2=4) (3=3) into im1r_3.
recode im1a_w3 (1=5) (2=4) (3=3) (4=2) (5=1) into im1ar_3.
recode im1b_w3 (1=5) (2=4) (3=3) (4=2) (5=1) into im1br_3.
missing values im1r_3 im2r_3 im3r_3 (77, 98, 99).
frequencies  vars=im1r_3 im2r_3 im3r_3.

RELIABILITY
  /VARIABLES=im1r_3 im2r_3 im3r_3
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /SUMMARY=TOTAL.

compute immigindex_3=mean.1(im1r_3, im2r_3, im3r_3).

***healthcare (high=better/favor). 

missing values hc1_w3  hc2_w3 hc3_w3 hc4_w3 (77, 98, 99).
recode hc1_w3 (1=5) (5=1) (4=2) (2=4) (3=3) into hc1r_3.
recode hc2_w3 (1=5) (5=1) (4=2) (2=4) (3=3) into hc2r_3.
recode hc3_w3 (1=5) (5=1) (4=2) (2=4) (3=3) into hc3r_3.
recode hc4_w3 (1=5) (5=1) (4=2) (2=4) (3=3) into hc4r_3.
missing values hc1r_3 hc2r_3 hc3r_3 hc4r_3 (77, 98,99).

**trade (high =pro)

missing values tr1_w3 tr4_w3 tr1a_w3 tr1b_w3 (77, 98, 99).
recode tr1_w3 (1=5) (2=4) (3=3) (4=2) (5=1) into tr1r_3.
recode tr4_w3  (1=5) (2=4) (3=3) (4=2) (5=1) into tr4r_3.
recode tr1a_w3 (1=5) (2=4) (3=3) (4=2) (5=1) into tr1ar_3.
recode tr1b_w3 (1=5) (2=4) (3=3) (4=2) (5=1) into tr1br_3.

FREQUENCIES vars = tr1r_3 tr4r_3 tr1ar_3 tr1br_3.
**Compute trade index as in previous waves? Questions differ so I didn't.

***worry/anxiety (high=more worried) 

missing values pt4_w3 pt5_w3 (77, 98, 99).
recode pt4_W3  (1=4) (4=1) (2=3) (3=2) into wayoflife_3.
recode pt5_W3  (1=4) (4=1) (2=3) (3=2) into terrorismthreat_3. 

**Jobs (high = increased jobs)

missing values usjobs_w3 tpjobs_w3 (77, 98, 99).
recode usjobs_w3 (1=5) (2=4) (3=3) (4=2) (5=1) into usjobsr_3.
recode tpjobs_w3 (1=5) (2=4) (3=3) (4=2) (5=1) into tpjobsr_3.

**Local trade (high =helped)

missing values localtrade_w3 (77, 98, 99).
recode localtrade_w3  (1=5) (2=4) (3=3) (4=2) (5=1) into localtrader_3.

**Party 
***Lots of D# variables associated with party in the script but not dealt with in the code files. Not sure what to do with those or if they have been captured elsewhere?

missing values partyid7_w3 (-1).

if (PARTYID7_w3 le 3) party2_3=0.
if (PARTYID7_w3 ge 5) party2_3=1.
value labels party2_3 0 'democrats' 1 'republicans'.
if (party2_3=1) rep_3=1.
if (party2_3=0) dem_3=1.
recode dem_3 rep_3 (1=1) (missing=0) (else=0).
recode partyid7_w3 (1,2,3=0) (else=1) into demnot_3.
recode partyid7_w3 (5,6,7=0) (else=1) into repnot_3.

if (PARTYID7_w3 lt 3) party3_3=0.
if (PARTYID7_w3 gt 5) party3_3=1.
if (PARTYID7_w3 = 3 or PARTYID7_w3 = 4 or PARTYID7_w3 = 5) party3_3=.5.
value labels party3_3 0 'democrats' .5 'independents' 1 'republicans'.

**Empathy (high=high)

missing values empathy_1_w3 empathy_2_w3 empathy_3_w3 empathy_4_w3 empathy_5_w3 (77, 98, 99).
recode empathy_3_w3 (1=5) (2=4) (3=3) (4=2) (5=1) into empathy_3r_3.
compute empathy_1r_3=empathy_1_w3.
compute empathy_2r_3=empathy_2_w3.
compute empathy_4r_3=empathy_4_w3.
compute empathy_5r_3=empathy_5_w3.

**Assumed we wanted empathy index:

RELIABILITY
    /VARIABLES empathy_1r_3 empathy_2r_3 empathy_3r_3 empathy_4r_3 empathy_5r_3 
    /SCALE('ALL VARIABLES') ALL
    /MODEL=ALPHA
    /SUMMARY=TOTAL.

compute empathyindex_3=mean1.(empathy_1r_3, empathy_2r_3, empathy_3r_3, empathy_4r_3, empathy_5r_3).

**Polarization (high=polarized)

missing values pp1_w3 pp2_w3 pp3_w3 pp4_w3 (77, 98, 99).

recode PP3_w3 (1=4) (4=1) (2=3) (3=2) into pp3r_3.

recode PP4_w3 (1=4) (4=1) (2=3) (3=2) into pp4r_3.

missing values pp3r_3 pp4r_3 (77, 98, 99).

RELIABILITY
  /VARIABLES=pp1_w3 pp2_w3 pp3r_3 pp4r_3
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /SUMMARY=TOTAL.

compute polarindex_3=mean.1(pp1_w3, pp2_w3, pp3r_3, pp4r_3).

**System Legitimacy (high=legit)

missing values sl1_w3 sl2_w3 sl3_w3 sl4_w3 (77, 98, 99).

recode sl1_w3 (1=5) (5=1) (2=4) (4=2) (3=3) into sl1r_3.
recode sl3_w3 (1=5) (5=1) (2=4) (4=2) (3=3) into sl3r_3.

missing values sl1r_3 sl3r_3 (77, 98, 99).

RELIABILITY
  /VARIABLES= sl1r_3 sl2_w3 sl3r_3 sl4_w3
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /SUMMARY=TOTAL.

compute syslegindex_3=mean.1(sl1r_3, sl2_w3, sl3r_3, sl4_w3).

**Taxes/Safety Net (high= higher taxes more safety net)

missing values tsn1_w3 tsn2_w3 (77, 98, 99).

recode tsn1_w3 (1=5) (5=1) (2=4) (4=2) (3=3) into tsn1r_3.

missing values tsn1r_3 (77, 98, 99).

RELIABILITY
  /VARIABLES=tsn1r_3 tsn2_w3
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /SUMMARY=TOTAL.

compute safetynet_3=mean.1(tsn1r_3, tsn2_w3).

**National Superiority (high=superior)

missing values ns1_w3 ns2_w3 ns3_w3 (77, 98, 99).
recode ns1_w3 (1=5) (5=1) (4=2) (2=4) (3=3) into ns1r_3.
recode ns2_w3 (1=5) (5=1) (4=2) (2=4) (3=3) into ns2r_3.
recode ns3_w3 (1=5) (5=1) (4=2) (2=4) (3=3) into ns3r_3.

pearson corr vars = ns1r_3 ns2r_3 ns3r_3.
RELIABILITY
  /VARIABLES= ns1r_3 ns2r_3 ns3r_3
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /SUMMARY=TOTAL.

compute natsupindex_3=mean.1(ns1r_3, ns2r_3, ns3r_3).

**Race (high=favor helping)

missing values race1_w3 race2_w3 race3_w3 (77, 98, 99).
recode race1_w3 (1=5) (2=4) (3=3) (4=2) (5=1)  into race1r_3.
recode race2_w3 (1=5) (2=4) (3=3) (4=2) (5=1)  into race2r_3.
recode race3_w3 (1=5) (2=4) (3=3) (4=2) (5=1)  into race3r_3.

***perceived discrimination

missing values dis1_w3 to dis9_w3 (77, 98, 99).

recode dis1_w3 (1=5) (5=1) (4=2) (2=4) (3=3) into dis1r_3.
recode dis2_w3 (1=5) (5=1) (4=2) (2=4) (3=3) into dis2r_3.
recode dis3_w3 (1=5) (5=1) (4=2) (2=4) (3=3) into dis3r_3.
recode dis4_w3 (1=5) (5=1) (4=2) (2=4) (3=3) into dis4r_3.
recode dis5_w3 (1=5) (5=1) (4=2) (2=4) (3=3) into dis5r_3.
recode dis6_w3 (1=5) (5=1) (4=2) (2=4) (3=3) into dis6r_3.
recode dis7_w3 (1=5) (5=1) (4=2) (2=4) (3=3) into dis7r_3.
recode dis8_w3 (1=5) (5=1) (4=2) (2=4) (3=3) into dis8r_3.
recode dis9_w3 (1=5) (5=1) (4=2) (2=4) (3=3) into dis9r_3.
compute disblack_3=dis1r_3.
compute dishispanic_3=dis2r_3.
compute diswhite_3=dis3r_3.
compute diswomen_3 = dis4r_3.
compute dismen_3=dis5r_3.
compute dismuslim_3=dis6r_3.
compute dischristian_3=dis7r_3.
compute disrural_3=dis8r_3.
compute disasian_3=dis9r_3.

**What to do with asian and rural discrimination?

compute majorrelig_3=dischristian_3-dismuslim_3.
compute majorsex_3=dismen_3-diswomen_3.
compute majorrace_3=diswhite_3-disblack_3.
missing values majorrelig_3 majorsex_3 majorrace_3 (77,98,99).
correlations/variables = majorrelig_3 majorrace_3 majorsex_3.

RELIABILITY
  /VARIABLES= majorrelig_3 majorrace_3 majorsex_3
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /SUMMARY=TOTAL.

compute highstatusdisc_3=mean.1(majorrelig_3, majorrace_3, majorsex_3).

**US Standing (high=better)

missing values stand_w3 (77, 98, 99).

recode stand_w3 (1=5) (2=4) (3=3) (4=2) (5=1) into standr_w3.

**Isolationism (high=isolationist)

missing values iso1_w3 iso2_w3 iso3_w3 iso4_w3 iso5_w3 (77, 98, 99).
recode iso2_w3  (1=5) (5=1) (2=4) (4=2) (3=3) into iso2r_3.
recode iso4_w3 (1=5) (5=1) (2=4) (4=2) (3=3) into iso4r_3.
missing values iso2r_3 iso4r_3 (77, 98, 99).

RELIABILITY
  /VARIABLES= iso1_w3 iso2r_3 iso3_w3 iso4r_3 iso5_w3
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /SUMMARY=TOTAL.

compute isoindex_3=mean.1(iso1_w3, iso2r_3, iso3_w3, iso4r_3, iso5_w3).


**Cooperative Internationalism (high=important)

missing values inter_w3 (77, 98, 99).
recode inter_w3 (1=4) (2=3) (3=2) (4=1) into interr_3.

*China (high=pro/strong)

missing values chi_w3 chi2_w3 chi3_w3 chi4_w3  (77, 98, 99).
recode chi_w3 (3=2) (1=3) (2=1) into china_3.
recode chi2_w3 (1=2) (2=1) into chi2r_3.
recode chi3_w3 (1=5) (2=4) (3=3) (4=2) (5=1) into chi3r_3.
recode chi4_w3 (1=5) (2=4) (3=3) (4=2) (5=1) into chi4r_3.

**Civil Liberties vs security (high = too restrictive)

missing values cl1_w3 (77, 98, 99). 
recode cl1_w3 (1=2) (2=1) into sl1r_3.

**Social media (high=support taking down)

missing values socmed_w3 (77, 98, 99).
recode socmed_w3  (1=5) (2=4) (3=3) (4=2) (5=1) into socmedr_w3.

**Perceived civility of discourse (high=civil)

missing values civil1_w3 civil2_w3 civil3_w3 civil4_w3 civil5_w3 (77, 98, 99).
recode civil2_w3 (1=10) (2=9) (3=8) (4=7) (5=6) (6=5) (7=4) (8=3) (9=2) (10=1) into civil2r_3.
recode civil4_w3 (1=10) (2=9) (3=8) (4=7) (5=6) (6=5) (7=4) (8=3) (9=2) (10=1) into civil4r_3. 

**Civility scale?

RELIABILITY
    /VARIABLES=  civil1_w3 civil2r_3 civil3_w3 civil4r_3 civil5_w3
    /SCALE('ALL VARIABLES') ALL
    /MODEL=ALPHA
    /SUMMARY=TOTAL.

compute civildisc_3=mean.1(civil1_w3, civil2r_3, civil3_w3, civil4r_3, civil5_w3).

**International Trust (high=high trust)

missing values ITRUST_w3 (77, 98, 99).
recode itrust_w3 (1=5) (2=4) (3=3) (4=2) (5=1) into itrustr_3.

**Russia Interference (high= high interference)

missing values rus1_w3 rus2_w3 (77, 98, 99).
recode rus1_w3 (1=5) (2=4) (3=3) (4=2) (5=1) into rus1r_3.

DESCRIPTIVES vars = rus2_w3.

**Remove Trmump (high=remove)

missing values trump1_w3 trump2_w3 (77, 98, 99).

recode trump1_w3 (1=4) (2=3) (3=2) (4=1) into trump1r_3.
recode trump2_w3 (1=5) (2=4) (3=3) (4=2) (5=1) into trump2r_3.

descriptives var=trump1r_3 trump2r_3.
CORRELATIONS/ variables=trump1r_3 trump2r_3 therm1_3.

**feeling toward outgroup without comparison

if (employ_w3=3 or employ_w3=4) unemployed_3=1.
recode unemployed_3 (1=1) (missing=0).
