PROC PRINT DATA=evals;
RUN;

PROC SGPLOT DATA=evals;
	SCATTER y=score x=bty_avg;
RUN;

PROC SGSCATTER data=evals;
	MATRIX score bty_avg age; 
RUN;

PROC SGPLOT DATA=evals;
	histogram score / group = rank transparency=0.1;
RUN;

PROC SGPANEL data=evals;
	panelby rank / rows = 3;
	histogram score;
RUN;

PROC ANOVA DATA=evals;
	class rank;
	model score = rank;
RUN;

PROC PRINT data=evals;
RUN;

PROC SGPLOT data=evals;
	hbar rank / group = gender;
RUN;

PROC GLM data=evals;
	class gender;
	model score= bty_avg*gender / solution;
RUN;
