/******************/
/* One proportion */
/******************/

* 99% CI for recovery rate;
PROC FREQ data = drug;
	TABLES recovery / binomial riskdiff alpha = 0.01; /* alpha = (1-conf. level)*100 */
RUN;

/************/
/* One mean */
/************/

* 95% confidence interval for speed;
PROC TTEST data = speed alpha = 0.05;
	VAR speed;
RUN;


/*****************/
/* 2 indep means */
/*****************/

* 99% CI for diff "female - male"
* in speed;
* can find one-sided intervals using sides, as
* with the one-sample CIs;
PROC TTEST data = speed alpha = 0.01;
	VAR speed;
	CLASS gender;
RUN;

/*****************/
/* 2 proportions */
/*****************/

* 99% confidence interval for the difference
* in recovery rates for drugs A and B;
PROC FREQ data = twodrugs;
	TABLES recovery*drug / chisq riskdiff alpha = 0.01;
RUN;

/*************/
/* Tukey HSD */
/*************/

PROC FORMAT;
	value sesFmt 1 = 'low'
		         2 = 'middle'
		         3 = 'high';
RUN;
* apply format;
* drop ses;
DATA hsbnew;
	SET hsb2 ;
	format sesnew sesFmt.;
	IF ses = 'low' THEN sesnew = 1;
	ELSE IF ses = 'middle' THEN sesnew = 2;
	ELSE sesnew = 3;
	avg = MEAN(math, write, socst, read, science);
RUN;

PROC PRINT;
RUN;


PROC ANOVA data = hsbnew;
	CLASS ses;
	MODEL avg = ses;
	MEANS ses / Tukey alpha = 0.01; 
RUN;
QUIT;

/***************/
/* Correlation */
/***************/

PROC SGSCATTER data = hsbnew;
	matrix math write socst science read;
RUN;
PROC CORR data = hsbnew;
	VAR math write socst science read;
RUN;
