

/*********************************************/
/* Options: lines, labels, axes, styles etc. */
/*********************************************/

* add vertical/horizontal lines with REFLINE;
PROC SGPLOT data = hsb2;
	SCATTER x = math y = write;
	REFLINE 50 / axis = x label = "math score = 50";
	REFLINE 50 / axis = y label = "write score = 50";
RUN;

* change scale of axis, names;
PROC SGPLOT data = hsb2;
	SCATTER x = math y = write;
	XAXIS  LABEL = 'math scores in test' VALUES = (0 TO 100 BY 10);
	YAXIS  LABEL = 'writing scores in test' VALUES = (0 TO 100 BY 10);
RUN;

* change color, size of points;
PROC SGPLOT data = hsb2 ;
	SCATTER x = math y = write / markerattrs = (size = 3pt color = black symbol= starfilled);
	XAXIS  LABEL = 'math scores in test' VALUES = (0 TO 100 BY 10);
	YAXIS  LABEL = 'writing scores in test' VALUES = (0 TO 100 BY 10);
RUN;

PROC SGPLOT data = hsb2 pctlevel = group;
	styleattrs datacolors = (purple green blue black);
	HBAR gender / group = race stat = percent;
RUN;

* change colors and shapes of dots;
PROC SGPLOT data = hsb2;
	styleattrs datasymbols = (trianglefilled squarefilled) datacontrastcolors = (purple green);
	REG x = math y = write / group = gender;
	XAXIS  LABEL = 'math scores in test' VALUES = (0 TO 100 BY 10);
	YAXIS  LABEL = 'writing scores in test' VALUES = (0 TO 100 BY 10);
RUN;


* In SGPANEL, can change labels and values with ROWAXIS, COLAXIS;
PROC SGPANEL data = hsb2;
	PANELBY ses / ROWS = 3;
	REG x = math y = write;
	ROWAXIS LABEL = 'math scores in test' VALUES = (0 TO 100 BY 10);
	COLAXIS  LABEL = 'writing scores in test' VALUES = (0 TO 100 BY 10);
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

* specify length of new variable: 1 character;
DATA test2;
	SET test;
	v2 = PUT(v1,$1.);
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

* specify width of variable: 4 characters, 2 decimals;
DATA test2;
	SET test;
	v2 = INPUT(v1,4.2);
;

PROC CONTENTS;
RUN;

PROC PRINT;
RUN;
