* Show all active datasets in workspace;
PROC DATASETS;
RUN;
QUIT;

********************;
* new dataset: speed;
********************;

PROC PRINT data=speed;
RUN;

* keep speed gender height;
DATA speed;
	SET speed;
	KEEP speed gender height;
RUN;

* find variable legalmax;
* highest speed limit in US: 85mph, Pickle parkway;
DATA speed;
	SET speed;
	IF speed > 85 THEN legalmax = 'illegal';
	ELSE legalmax = 'legal';
RUN;

PROC PRINT data = speed;
RUN;

* problems with missing data!;
* missing data treated as smallest than any numeric value;
DATA speed2;
	SET speed;
	IF speed = '.' THEN legalmax = ' ';
	ELSE IF speed > 85 THEN legalmax = 'illegal';
	ELSE legalmax = 'legal';
RUN;

PROC PRINT data = speed2;
RUN;

/*****************************/
/* PROC MEANS and UNIVARIATE */
/*****************************/

* Back to hsb2;
* Summary of math score by race and ses;
PROC MEANS data=hsb2;
	var math;
	class race ses;
RUN;

* In speed;
* Summary of height by legalmax;
PROC MEANS data=speed;
	var height;
	class legalmax;
RUN;

* add missing data;
PROC MEANS data=speed MISSING;
	var height;
	class legalmax;
RUN;

* PROC UNIVARIATE with normality tests;
PROC UNIVARIATE data=speed NORMAL PLOT;
RUN;
PROC UNIVARIATE data = hsb2;
	VAR math;
	class ses;
RUN;

/*************/
/* PROC FREQ */
/*************/

* one-way tables for legalmax and gender;
PROC FREQ data=speed;
	tables gender legalmax; 
RUN;

* two-way table for legalmax and gender;
PROC FREQ data=speed;
	tables gender*legalmax; 
RUN;

* show missing values;
PROC FREQ data=speed;
	tables gender legalmax / missing; 
RUN;

PROC FREQ data=speed;
	tables gender*legalmax / missing; 
RUN;

* show only frequencies;
PROC FREQ data = speed;
	tables gender*legalmax / NOCOL NOROW NOPERCENT missing;
RUN;

* two-way table for race and ses, hsb2, percentages only;
PROC FREQ data = hsb2;
	tables race*ses / NOFREQ;
RUN;

* create new numerical variable;
DATA hsbtest;
	SET hsb2 ;
	IF ses = 'low' THEN sesnew = 1;
	ELSE IF ses = 'middle' THEN sesnew = 2;
	ELSE sesnew = 3;
RUN;

* table according to numerical variable;
PROC FREQ data = hsbtest;
	tables race*sesnew / NOFREQ;
RUN;


* create format;
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
	drop ses;
	IF ses = 'low' THEN sesnew = 1;
	ELSE IF ses = 'middle' THEN sesnew = 2;
	ELSE sesnew = 3;
RUN;

PROC PRINT;
RUN;

* rename sesnew to ses;
DATA hsbnew;
	set hsbnew (RENAME = (sesnew = ses));
RUN;

PROC PRINT data=hsbnew;
RUN;

* Tabulate again;
PROC FREQ data = hsbnew;
	tables race*ses / NOFREQ;
RUN;

/*****************/
/* PROC TABULATE */
/*****************/

* Can summarize quant variables by categorical vars;

* Tabulate sample size, mean, stddev and median of math;
PROC TABULATE data = hsbnew;
	VAR math;
	TABLE math*(N MEAN STDDEV MEDIAN);
RUN;

* Tabulate mean and stddev of math, by ses;
PROC TABULATE data = hsbnew;
	CLASS ses;
	VAR math;
	TABLE math*(MEAN STDDEV), ses;
RUN;

* Transpose previous table: order is TABLE <rows> , <columns>;
PROC TABULATE data = hsbnew;
	CLASS ses;
	VAR math;
	TABLE ses, math*(MEAN STDDEV);
RUN;

* Break down math scores by race (rows);
PROC TABULATE data = hsbnew;
	CLASS ses race;
	VAR math;
	TABLE math*race*(MEAN STDDEV), ses;
RUN;

* Break down math scores by race (columns);
PROC TABULATE data = hsbnew;
	CLASS ses race;
	VAR math;
	TABLE math*(MEAN STDDEV), ses*race;
RUN;

* add N;
PROC TABULATE data = hsbnew;
	CLASS ses race;
	VAR math;
	TABLE math*(N MEAN STDDEV), ses*race;
RUN;

* 3D table with gender;
PROC TABULATE data = hsbnew;
	CLASS gender ses race;
	VAR math;
	TABLE gender, math*(N MEAN STDDEV), ses*race;
RUN;

* clean up table below: drop "math", "ses", "race";
PROC TABULATE data = hsbnew;
	CLASS ses race;
	VAR math;
	TABLE math*(N MEAN STDDEV), ses*race;
RUN;

* clean up table below: drop "math", "ses", "race";
PROC TABULATE data = hsbnew;
	Title 'Math scores by socioeconomic status and race';
	CLASS ses race;
	VAR math;
	TABLE (math = ' ')*(N MEAN STDDEV), (ses = ' ')*(race = ' ');
RUN;
	title;

* Export result to Excel;

* Output as rtf file (text);
ODS RTF BODY = 'C:\Users\victor.pena90\Desktop\test.rtf';
PROC TABULATE data = hsbnew;
	CLASS ses race;
	VAR math;
	TABLE (math = ' ')*(N MEAN STDDEV), (ses = ' ')*(race = ' ') / Box = 'math scores by race and ses';
RUN;
ODS RTF CLOSE;

/***************/
/* PROC SGPLOT */
/***************/

* histogram math;
PROC SGPLOT data = hsb2;
	HISTOGRAM MATH;
RUN;

* vertical boxplot math;
PROC SGPLOT data = hsb2;
	VBOX MATH;
RUN;

* horizontal boxplot math;
PROC SGPLOT data = hsb2;
	HBOX MATH;
RUN;

* vertical barplot race;
PROC SGPLOT data = hsb2;
	VBAR race;
RUN;

* horizontal bar plot ses;
PROC SGPLOT data = hsb2;
	HBAR ses;
RUN;

* vertical boxplot math by ses;
PROC SGPLOT data = hsb2;
	VBOX MATH / group = ses;
RUN;

* horizontal barplot by race;
PROC SGPLOT data = hsb2;
	HBAR ses / group = race;
RUN;
