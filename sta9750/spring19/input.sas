* STA9750: Intro to reading in data with SAS;

/****************/
/* Manual input */
/****************/

* copy first 4 rows of Pollution.prn;
* variables: city, so2, pop, temp;
/* Doesn't work */
DATA pol2; 
	INPUT CITY SO2 POP TEMP;
	DATALINES;
Phoenix       10 582 70.3
Little Rock   13 132 61
San Francisco 12 716 56.7
Denver        17 515 51.9
;
* add $, which indicates that CITY is a categorical variable;
* Doesn't work because of the spaces between "Little" and "Rock" and "San" and "Francisco";
DATA pol2; 
	INPUT CITY $ SO2 POP TEMP;
	DATALINES;
Phoenix       10 582 70.3
Little Rock   13 132 61
San Francisco 12 716 56.7
Denver        17 515 51.9
;

*If we get rid of spaces, things work!;
DATA pol2; 
	INPUT CITY $ SO2 POP TEMP;
	DATALINES;
Phoenix       10 582 70.3
LittleRock    13 132 61
SanFrancisco  12 716 56.7
Denver        17 515 51.9
;

* Let's try to read in the data differently in list input, with a single space separating columns;
DATA pol2; 
	INPUT CITY $ SO2 POP TEMP;
	DATALINES;
Phoenix 10 582 70.3
LittleRock 13 132 61
SanFrancisco 12 716 56.7
Denver 17 515 51.9
;

* specify length of list input, it works!;
DATA pol2;
	LENGTH city $ 12.;
	INPUT city $ so2 pop temp;
	DATALINES;
Phoenix 10 582 70.3
LittleRock 13 132 61
SanFrancisco 12 716 56.7
Denver 17 515 51.9
;
* categorical variable w/ spaces;
/* Use space-delimited columns (all columns start at the same point), then specify location of categorical variable */
DATA pol2; 
	INPUT CITY $ 1-13 SO2 POP TEMP;
	DATALINES;
Phoenix       10 582 70.3
Little Rock   13 132 61
San Francisco 12 716 56.7
Denver        17 515 51.9
;
/******************************************/
/* Read in nice text files without wizard */
/******************************************/
DATA pol3;
	INFILE 'C:\Users\victor.pena90\Desktop\Pollution.prn';
	INPUT CITY $ 1-17 SO2 POP TEMP;
;

/***********************************/
/* Read in nice files, with wizard */
/***********************************/
PROC IMPORT OUT= WORK.POLXL 
            DATAFILE= "C:\Users\victor.pena90\Desktop\Pollution.xls" 
            DBMS=EXCEL REPLACE;
     RANGE="USAIR$"; 
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

/**************/
/* PROC PRINT */
/**************/

* You can print subsets of variables;
PROC PRINT data=POLXL;
	VAR SO2 TEMP;
RUN;

* You can print, say, the first 10 observations;
PROC PRINT data=POLXL (obs = 10);
RUN;

* Print observations 5 thru 10;
PROC PRINT data=POLXL (firstobs = 5 obs = 10);
RUN;

* Print observations filtering by some values of the variables;
PROC PRINT data = POLXL;
	WHERE SO2 > 50 or TEMP > 70;
RUN;

/**************/
/* PROC MEANS */
/**************/

* Some univariate summaries of the variables;
PROC MEANS data = POLXL;
RUN;

/********************/
/* PROC UNIVARIATE **/
/********************/

* More univariate summaries of the variables;
PROC UNIVARIATE data = POLXL;
RUN;
