

PROC PRINT data=bp;
RUN;

PROC SGSCATTER data=bp;
	matrix BP Age Weight BSA Dur Pulse Stress ;
RUN; 

PROC CORR data=bp;
RUN;


PROC REG data=bp;
	model BP = BSA;
RUN;


PROC REG data=bp;
	model BP = Weight;
RUN;


PROC REG data=bp;
	model BP = Weight BSA / vif;
RUN;

PROC REG data=bp;
	model BP = Weight BSA / vif;
RUN;


PROC GLMSELECT data=bp;
	model BP = Age Weight BSA Dur Pulse Stress;
RUN;

PROC GLMSELECT data=bp;
	model BP = Age Weight BSA Dur Pulse Stress / selection = stepwise(select =
SL SLE=0.05 SLS = 0.05);
RUN;


PROC GLMSELECT data=bp;
	model BP = Age Weight BSA Dur Pulse Stress  / selection=lasso(stop=none);
RUN;

PROC REG data=bp;
model BP = Age Weight BSA Dur Pulse Stress / selection = cp best = 5;
RUN;
