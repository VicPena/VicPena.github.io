PROC DATASETS;
RUN;

/*********************************************/
/* Options: lines, labels, axes, styles etc. */
/*********************************************/

* add vertical/horizontal lines with REFLINE;
* scatter plot math and write with lines at math = 50 
* and write = 50;
PROC SGPLOT data = hsb2;
	SCATTER x=write y = math;
	REFLINE 50 / axis = x label = "write = 50"; 
	REFLINE 50 / axis = y label = "math = 50"; 
RUN;
* change scale of axis, labels;
* from 0 to 100 by 10;
PROC SGPLOT data = hsb2;
	SCATTER x=write y = math;
	REFLINE 50 / axis = x label = "write = 50"; 
	REFLINE 50 / axis = y label = "math = 50"; 
	XAXIS VALUES = (0 TO 100 BY 10) label = "write scores";
	YAXIS VALUES = (0 TO 100 BY 10) label = "math scores";
RUN;

* change color, size of points;
PROC SGPLOT data = hsb2;
	SCATTER x=write y = math / markerattrs=(size = 3pt color = purple symbol=starfilled);
	REFLINE 50 / axis = x label = "write = 50"; 
	REFLINE 50 / axis = y label = "math = 50"; 
	XAXIS VALUES = (0 TO 100 BY 10) label = "write scores";
	YAXIS VALUES = (0 TO 100 BY 10) label = "math scores";
RUN;

* stacked barplot of gender by race, change colors;


* change colors and shapes of dots in the plot below;
PROC SGPLOT data = hsb2;
	REG x = math y = write / group = gender;
	XAXIS  LABEL = 'math scores in test' VALUES = (0 TO 100 BY 10);
	YAXIS  LABEL = 'writing scores in test' VALUES = (0 TO 100 BY 10);
RUN;


* In SGPANEL, can change labels and values with ROWAXIS, COLAXIS;
PROC SGPANEL data = hsb2;
	PANELBY ses / ROWS = 3;
	REG x = math y = write;
	ROWAXIS VALUES=(0 to 100 by 10) label='hey';
	COLAXIS VALUES=(0 to 100 by 10) label='hey but in columns';
RUN;

* KEYLEGEND options: NOBORDER
* 					 POSITION (BOTTOM, BOTTOMLEFT, BOTTOMRIGHT, same w/ TOP)
*					 LOCATION (INSIDE or OUTSIDE);

* Legend without border, top right, inside ;
PROC SGPLOT data = hsb2;
	REG x = math y = write / group = gender;
	XAXIS  LABEL = 'math scores' VALUES = (0 TO 100 BY 10);
	YAXIS  LABEL = 'writing scores' VALUES = (0 TO 100 BY 10);
	KEYLEGEND / NOBORDER POSITION = TOPRIGHT LOCATION = INSIDE;
RUN;


/*******************/
/* Type conversion */
/*******************/

* Numeric (quantitative) to categorical;
DATA test;
	INPUT V1;
	DATALINES;
1
1
1
2
2
2
3
3
3
;

DATA test2;
	SET test;
	* create categorical version of V1;
	V2 = PUT(V1,$1.);
;

PROC CONTENTS;
RUN;

PROC PRINT;
RUN;

* Categorical to numeric (quantitative);
DATA test;
	INPUT V1 $ 1-4;
	DATALINES;
1.34
2.25
3.35
;

DATA test2;
	SET test;
	* create numeric version of V1;
	V2 = INPUT(V1,4.2);
;

PROC CONTENTS;
RUN;

PROC PRINT;
RUN;

/**************************/
/* Concatenating datasets */
/**************************/

DATA data1;
	INPUT name $ gender $ age;
	CARDS;
	Alice     female  56
	Bob       male    70
	Carl      male    45
;  


DATA data2;
	INPUT name $ gender $ age;
	CARDS;
	Danny     male    35 
	Eve       female  55
	Felicia   female  65
;

DATA conc;
	* stack datasets data1 and data2;
;

DATA data3;
	INPUT name $ race $ gender $;
	CARDS;
	Gaby   hispanic female 
	Homer  black    male   
	Ingrid white    female 
;
RUN;

DATA conc2;
	* stack conc and data3;
;

PROC PRINT;
RUN;
/**********************************/
/* One-to-one match by identifier */
/**********************************/

DATA match1;
	INPUT name $ gender $ age;
	CARDS;
	Alice     female  56
	Bob       male    70
	Carl      male    45
;  

DATA match2;
	INPUT name $ race $;
	CARDS;
	Carl   black
	Bob    white
	Alice  white
	Danny  hispanic
;

DATA matched;
	* merge match 1 and match 2 by name;
RUN;

DATA match3;
	INPUT name $ score;
	CARDS;
	Alice 95
	Alice 90
	Bob   80
	Bob   85
;


PROC PRINT;
RUN;

DATA matched;
	* merge match1 and match3 by name;
RUN;

PROC PRINT;
RUN;


DATA matched;
	* merge match 1 and match3 and get rid of missing data;
RUN;

PROC PRINT;
RUN;


