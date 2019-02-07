/**************************/
/* 1D plots, quantitative */
/**************************/

* histogram math;
PROC SGPLOT data = hsb2;
	HISTOGRAM math;
RUN;

* options: nbins, binwidth, scale (percent, count or proportion);
* For example, 20 bins, and counts on the y axis;
PROC SGPLOT data = hsb2;
	title 'math scores';
	HISTOGRAM math / nbins = 20 scale = count;
RUN;
title;

* normal density plot math;
PROC SGPLOT data = hsb2;
	DENSITY math;
RUN;

* options: type (normal, kernel);
* example: kernel (nonparametric) estimate of density;
PROC SGPLOT data = hsb2;
	DENSITY math / type = kernel ;
RUN;

* overlay HISTOGRAM and normal DENSITY;
PROC SGPLOT data = hsb2;
	HISTOGRAM math;
	DENSITY math;
RUN;


* vertical boxplot math;
PROC SGPLOT data = hsb2;
	VBOX MATH;
RUN;

* horizontal boxplot math;
PROC SGPLOT data = hsb2;
	HBOX MATH;
RUN;


/*************************/
/* 1D plots, categorical */
/*************************/

* horizontal bar chart;
PROC SGPLOT data = hsb2;
	HBAR ses;
RUN;

* vertical bar chart;
PROC SGPLOT data = hsb2;
	VBAR ses;
RUN;
/*********************************/
/* 2D quantitative & categorical */
/*********************************/

* horizontal boxplots of math by socioeconomic status;
PROC SGPLOT data = hsb2;
	HBOX math / group = ses;
RUN;
* analogous code with VBOX would work as well;

* histograms by group?;
PROC SGPLOT data = hsb2;
	HISTOGRAM math / group = ses;
RUN;

* using SGPANEL instead;
PROC SGPANEL data = hsb2;
	PANELBY ses;
	HISTOGRAM math;
RUN;

* specifying number of rows in SGPANEL;
PROC SGPANEL data = hsb2;
	PANELBY ses / rows = 3;
	HISTOGRAM math;
RUN;
* can do the same thing with densities;

/**********************************/
/* 2D quantitative & quantitative */
/**********************************/

* scatterplot of math v write;
PROC SGPLOT data = hsb2;
	SCATTER x = math y = write;
RUN;

* scatterplot with regression line;
PROC SGPLOT data = hsb2;
	REG x = math y =write;
RUN;

* scatterplot with LOESS line;
PROC SGPLOT data = speed2;
	LOESS x = math y =write;
RUN;


/********************************/
/* 2D categorical & categorical */
/********************************/

* Stacked bar plot;
PROC SGPLOT data = hsb2;
	VBAR SES / group = RACE;
RUN;

* use % on y-axis;
PROC SGPLOT data = hsb2;
	VBAR SES / group = RACE stat = percent;
RUN;
* use % within each group;
PROC SGPLOT data = hsb2 pctlevel = group;
	VBAR SES / group = RACE stat = percent;
RUN;

* Side-by-side bar charts;
PROC SGPLOT data = hsb2;
	VBAR SES / group = RACE groupdisplay = CLUSTER;
RUN;

/**************/
/* More plots */
/**************/

* scatterplot of math and write by gender;
PROC SGPLOT data = hsb2;
	REG x = math y = write / group = gender;
RUN;

* table of average math and write by gender;
PROC TABULATE data = hsb2;
	CLASS gender;
	VAR math write;
	TABLE math*MEAN write*MEAN, gender;
RUN;

PROC MEANS data = hsb2;
	CLASS gender; 
	VAR math write;
RUN;

* further slicing by ses;
PROC SGPANEL data = hsb2;
	PANELBY ses / rows = 3;
	REG x = math y = write / group = gender;
RUN;


* use RESPONSE in HBAR / VBAR;
PROC SGPLOT data = hsb2;
	VBAR RACE / response = math STAT = mean;
RUN;

* boxplot of height by legalmax (data = speed2)
including missing as a category;
PROC SGPLOT data = speed2;
	VBOX height / group = legalmax missing;
RUN;
