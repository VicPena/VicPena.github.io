PROC PRINT data=iq;
RUN;

PROC SGPLOT data=iq;
	scatter x=brain y=PIQ;
RUN;

PROC REG data=iq;
	MODEL PIQ = brain height weight;
		output out = diagnostic 
			r = errors
			h = leverage
			cookd = cooks;
RUN;

PROC PRINT data=diagnostic;
	WHERE (errors>40) or (leverage>0.20) or (cooks>0.075);
RUN;
