*********************************************;
* all subsets and stepwise selection, IQ data;
*********************************************;
PROC PRINT data=IQ;
RUN;

* runs all subsets (in this case, 8 models);
PROC REG data=IQ;
	model PIQ = brain height weight /
     selection = rsquare adjrsq bic cp;
RUN;

* forward selection using p-values < 0.05 as threshold;
PROC REG data=IQ;
	model PIQ = brain height weight /
		selection = forward slentry=0.05;
RUN;

* backward selection using p-values < 0.05 as threshold;
PROC REG data=IQ;
	model PIQ = brain height weight /
		selection = backward slstay =0.05;
RUN;

proc glmselect data = IQ;
 class gender;
 model PIQ = brain height weight / selection = backward(select =bic);
run;


* stepwise; 
PROC REG data=IQ;
	model PIQ = brain height weight /
		selection = stepwise slentry=0.05 slstay =0.05;
RUN;

************************************;
* speed data, categorical predictors;
************************************;

* additive model: same slope, different intercepts;
PROC GLM data = speed PLOTS(UNPACK)=DIAGNOSTICS;
	CLASS gender;
	MODEL speed = gender height / solution;
RUN;

* different slopes and intercepts;
PROC GLM data = speed plots = all;
	CLASS gender;
	MODEL speed = gender height gender*height / solution;
RUN;

* same intercept, different slopes (unusual);
PROC GLM data = speed;
	CLASS gender;
	MODEL speed = gender*height / solution;
RUN;

PROC GLMselect data = speed;
	CLASS gender;
	MODEL speed = gender height gender*height / selection = stepwise(select = sl sle = 0.05 SLS = 0.05);
RUN;
