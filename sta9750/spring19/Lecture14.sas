PROC PRINT DATA=evals;
RUN;

* scatterplot of numerical variables;
PROC SGSCATTER data=evals;
	MATRIX score bty_avg age; 
RUN;

* teaching evals by rank;
PROC SGPLOT DATA=evals;
	hbox score / group = rank;
RUN;
PROC SGPANEL data=evals;
	panelby rank / rows = 3;
	histogram score;
RUN;
* are there significant differences between ranks? 
* at the 0.05 signficance level?; 
PROC ANOVA DATA=evals;
	class rank;
	model score = rank;
	means rank / tukey;
RUN;

PROC PRINT data=evals;
RUN;

* is the gender dist'n equal among ranks?; 
PROC SGPLOT data=evals;
	hbar rank / group = gender;
RUN;

PROC FREQ data = evals;
	TABLE rank*gender / chisq;
RUN;

* visualize age vs gender;
PROC SGPLOT data = evals;
	HBOX age / group = gender;
RUN;

* predict teaching evals as a function of bty_avg and gender;
* different intercepts, same slopes;
PROC GLM data=evals plots = all;
	class gender;
	model score= bty_avg gender  / solution;
RUN;


* different slopes and intercepts;
PROC GLM data=evals plots = all;
	class gender;
	model score= bty_avg gender bty_avg*gender / solution;
RUN;

* include age and rank as well;
PROC GLM data = evals plots=  all;
	class gender rank;
	model score= age rank bty_avg gender bty_avg*gender / solution;
RUN;


* glmselect: choose "best model" using backward selection + BIC;
PROC GLMselect data = evals;
	class gender rank;
	model score= age rank bty_avg gender bty_avg*gender / selection=backward select=bic;
RUN;

* check residuals of "best model";
PROC GLM data = evals plots = all;
	CLASS gender rank;
	MODEL score = age rank gender*bty_avg / solution; 
RUN;

* with best model, predict teaching eval
* for 29 yo male tenure-track prof of average attractiveness;
DATA pred;
	INPUT age rank $ 8-19 gender $ bty_avg;
	DATALINES;
	29 tenure track male 4.4
;

DATA evals2;
	SET evals pred;
RUN;	

PROC GLM data = evals2 plots = all;
	CLASS gender rank;
	MODEL score = age rank gender*bty_avg; 
	OUTPUT out = predout
			p = pointpred
			ucl = upperpred
			lcl = lowerpred;
RUN;

PROC PRINT data = predout;
RUN;
