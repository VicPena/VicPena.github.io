/******************/
/* One proportion */
/******************/

* H0: p <= 0.5 against H1: p > 0.5;
* data are assumed to be independent;
PROC FREQ data = drug;
	TABLES recovery / binomial (p = 0.5);
RUN;
/************/
/* One mean */
/************/

* H0: avg pop speed <= 85mph against H1: avg pop speed > 85mph;
* data assumed to be independent; 
* either: data roughly normal or sample  size "big enough" and finite variance;
PROC TTEST data = speed sides = U H0 = 85 ;
	VAR speed;
RUN;

PROC PRINT data = speed;
RUN;
/*****************/
/* 2 indep means */
/*****************/

* H0: max speed women = max speed men 
* against H1 : different max speeds by gender;
* observations within groups are indep;
* groups are indep;
* within groups, either: data roughly normal or sample  size "big enough" and finite variance;
PROC TTEST data = speed;
	VAR speed;
	CLASS gender;
RUN;
