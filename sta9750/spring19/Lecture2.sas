/*************/
/* PROC SORT */
/*************/

* Sort data ascending order by population;
PROC SORT data = pollution;
	by pop;
RUN;

PROC PRINT;
RUN;

* Sort data DESCENDING order by population;
PROC SORT data = pollution;
	by DESCENDING pop;
RUN;

PROC PRINT;
RUN;

* Sort data by city in ascending alphabetical order;
PROC SORT data = pollution;
	by city;
RUN;

PROC PRINT;
RUN;

/************************/
/* Comparison operators */
/************************/

* Print all cities with population under 100k;
PROC PRINT data = pollution;
	WHERE pop < 100;
RUN;

* Print all data except SF, use "^=";
PROC PRINT data=pollution;
	WHERE city ^= 'San Francisco';
RUN;

* Print SF and Little Rock (AR), use "in";
PROC PRINT data=pollution;
	WHERE city in ('San Francisco', 'Little Rock');
RUN;

/*********************/
/* Logical operators */
/*********************/

* Print all but SF and Little Rock, using "not" and "in";
PROC PRINT data=pollution;
	WHERE city not in ('San Francisco', 'Little Rock');
RUN;
* Print cities with a population over 500k with an avg temp > 60;
PROC PRINT data = pollution;
	WHERE pop > 500 and temp > 60;
RUN;

* Q: Print the same, but exclude the observations in TX;
PROC PRINT data = pollution;
	WHERE pop > 500 and temp > 60 and city not in ('Houston', 'Dallas');
RUN;

/**********************/
/* Renaming variables */
/**********************/

* Change TEMP to temperature and POP to population;
DATA pollution;
	SET pollution (RENAME = (TEMP = temperature POP = population) );
RUN;

PROC PRINT;
RUN;

*******************;
* new dataset: HSB2;
*******************;

PROC PRINT data=hsb2;
RUN;


/************************/
/* Subsetting variables */
/************************/

* drop VAR1 and id;
DATA hsb2;
	SET hsb2;
	DROP VAR1 id;
RUN;

PROC PRINT data=hsb2;
RUN;

* create a subset keeping math, gender, and race;
DATA hsbmath;
	SET hsb2;
	KEEP math gender race;
RUN;

PROC PRINT data=hsbmath;
RUN;

/***************************/
/* Subsetting observations */
/***************************/

* Create a subset of students whose math > 70;
DATA goodmath;
	SET hsb2;
	WHERE math > 70;
RUN;

PROC PRINT data = goodmath;
RUN;

* Q: Create a subset of students whose scores are all > 60;
DATA goodstudents;
	SET hsb2;
	WHERE math > 60 and read > 60 and write > 60 and science > 60 and socst > 60;
RUN; 

PROC PRINT data = goodstudents;
RUN;

/************************/
/* Create new variables */
/************************/

* Create variables: (arith.) mean and geom. mean;
DATA hsbmeans;
	SET hsb2;
	DROP math read write science socst;
	avg = (math+read+write+science+socst)/5;
	geommean = (math*read*write*science*socst)**(1/5);
;

PROC PRINT data=hsbmeans;
RUN;

* Faster way of finding subset of student whose scores all > 60;
DATA goodstudents;
	SET hsb2;
	WHERE min(math,read,write,science,socst) > 60;
RUN; 

* Faster way of finding means;
DATA hsbmeans;
	SET hsb2;
	DROP math read write science socst;
	avg = MEAN(math,read,write,science,socst);
	geommean = (math*read*write*science*socst)**(1/5);
;

* Create variable 'result';
* 'pass' if avg >= 50 and 'fail' otherwise;
DATA hsbmeans;
	SET hsbmeans;
	IF avg >= 50 THEN result = 'pass';
	ELSE result = 'fail';
;

PROC PRINT data = hsbmeans;
RUN;

