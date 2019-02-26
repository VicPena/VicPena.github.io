/****************/
/* Paired means */
/****************/


* should we go to summer school?;
* print before and after scores;
PROC PRINT data = before;
RUN;

PROC PRINT data = after;
RUN;

* Sort by after by id;
PROC SORT data = after;
	BY id;
RUN;

* merge before and after data by id, drop missing values;
DATA complete;
	MERGE before (in = inbefore) after (in = inafter);
	BY id;
	if inbefore and inafter;
	diff = after-before;
RUN;

PROC PRINT data = complete;
RUN;

* plot before and after scores;
PROC SGPLOT Data = complete;
	REG x = before y = after;
RUN;
 

* Is there evidence to claim that there's a positive improvemnt 
* at the 0.05 significance level?;
PROC TTEST data = complete H0 = 0 sides = U;
	VAR diff;
RUN;
/*****************/
/* 2 proportions */
/*****************/

* goal: compare recovery rates of 2 drugs;
PROC PRINT data = twodrugs;
RUN;

* plot recovery % by drug;
PROC SGPLOT data = twodrugs pctlevel = group;
	HBAR drug/ group = recovery stat= percent; 
RUN;

* is there evidence to claim that the drugs have
* different recovery rates, at the 0.05 significance level?;
PROC FREQ data = twodrugs;
	TABLES drug*recovery / chisq riskdiff;
RUN;
/************************/
/* Indep. of cat. vars. */
/************************/

* does the % of people who go to 
* public school depend on socioeconomic status?;

* plot schooltype by socioeconomic status;
PROC SGPLOT data = hsb2 pctlevel = group;
	VBAR ses / group = schtyp stat = percent;
RUN;

* is there evidence at the 0.05 significance level
* that the % of people who go to public school
* is dependent on socioeconomic status?;
PROC FREQ data = hsb2;
	TABLES schtyp*ses / chisq;
RUN;

DATA hsb2; 
	set hsb2;
	avg = MEAN(math, read, write, socst);
	IF avg > 60 then rank = "A";
	ELSE IF avg >= 45 and avg <= 60 then rank = "B";
	ELSE rank = "C";
RUN;

PROC FREQ data = hsb2;
	TABLES rank*gender / chisq;
RUN;

PROC FREQ data = hsb2;
	TABLES rank*race / chisq;
RUN;

PROC PRINT Data = hsb2;
RUN;
