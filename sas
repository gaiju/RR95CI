*Create sample data;
data have;
input mygroup $ subgroup $ b d;
cards;
se A 371130 11243
se N 214144 2214
se M 181841 5820
se F 168065 3288
ex M 779199 17987
ex F 155981 4578
ge s20 603224 14766
ge S25 263337 5918
ge o25 68607 1881
ac W 689531 17304
ac B 159304 3714
ac Ot 86345 1547
ed BH 1766 76
ed HS 806844 19491
ed Co 74217 2014
ed B 52171 979
q 99 66736 1373
q 92 376550 8726
q 64 259887 6356
q 49 221302 6009
q 29 2635 83
s fq 811106 19056
s tq 37385 1178
s pq 86689 2331
;
run;
data want;
set have;
by mygroup;
*tell sas to keep the denom across the rows;
retain denom;
*create the denominator value;
if _n_=1 then do;
rr=1;
denom=d/b;
end;
*calculate relative risk;
else rr=(d/b)/denom;
*calculate percent and 95%CI;
pct=d/b;
J=SQRT((((B-D)/D)/B)+(((B-D)/D)/B));
Lcl=EXP(log(pct)-(1.96*(J)));
Ucl=EXP(log(pct)-(1.96*(J)));
/*proc sort; by mygroup;*/
*format variables for appearance;
format pct percent8.1 rr 8.2;
run;
*print results;
proc print data=want;
run;
