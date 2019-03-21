

* iq data:
* height: inches, weight: pounds, brain: not really brain weight, head circumf. in some unit;
PROC PRINT data=iq;
RUN;

* pairwise scatterplots;
PROC SGSCATTER data=iq;
	MATRIX PIQ brain height weight;
RUN;

* fit regression model and output diagnostics;
PROC REG data=iq;
	MODEL PIQ = brain height weight;
		output out = diagnostic 
			r = errors
			h = leverage
			cookd = cooks;
RUN;

* big errors, high leverage and high cook's distance;
PROC PRINT data=diagnostic;
	WHERE (errors>40) or (leverage>0.20) or (cooks>0.075);
RUN;

* taking out weight, which is not significant;
PROC REG data=iq;
	MODEL PIQ = brain height ;
RUN;
