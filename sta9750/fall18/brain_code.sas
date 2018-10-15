PROC PRINT data=IQ;
RUN;

PROC REG data=IQ;
	model PIQ = brain height weight /
     selection = rsquare adjrsq bic cp;
RUN;

PROC REG data=IQ;
	model PIQ = brain height weight /
		selection = forward slentry=0.05;
RUN;

PROC REG data=IQ;
	model PIQ = brain height weight /
		selection = backward slstay =0.05;
RUN;

PROC REG data=IQ;
	model PIQ = brain height weight /
		selection = stepwise slentry=0.05 slstay =0.05;
RUN;

PROC REG data=IQ;
	model PIQ = brain height;
	output out=diagnostics
			r=residuals
			cookd =cooksd
			h=leverage;
RUN;

PROC PRINT data=diagnostics;
	WHERE cooksd > 0.15;
RUN;
