/*****************/
/* Midterms data */
/*****************/
PROC PRINT data = midterms;
RUN;
PROC CONTENTS;
RUN;
* in my computer, "change" is read as categorical;
* convert it to numerical;
DATA midterms;
	SET midterms;
	changeseats = INPUT(change, 4.); 
RUN;

* part 2: track changes over time, line at 2018 change in seats (-38);
PROC SORT data = midterms;
	BY year;
RUN;

PROC SGPLOT data = midterms;
	SERIES x = year y = changeseats;
	REFLINE -38 / AXIS = y LABEL = "2018 midterms";
RUN; 


* part 4: create variable s.t. "passed" if approval > 50 and "failed" ow/;
DATA midterms;
	SET midterms;
	IF approval > 50 then approval2 = "passed";
	ELSE approval2 = "failed";
RUN;
* 4.a: Plot the distribution of changes in seats by the levels of the new variable;
PROC SGPLOT data = midterms;
	VBOX changeseats / group = approval2;
RUN;

* 4.b: create a table that shows changes in seats by the levels of the
new variable and party affiliation;
PROC TABULATE data = midterms;
	CLASS approval2 party;
	VAR changeseats;
	TABLE (N MEAN)*changeseats, approval2*party;
RUN;

* 4.c: Using parts a. and b. and more figures / tables as necessary, describe the relationship
between party affiliation, change in seats, and the new variable;
PROC SGPANEL data = midterms;
	PANELBY PARTY;
	HBOX changeseats / group = approval2;
RUN;

PROC TTEST data = midterms;
	CLASS party;
	VAR approval;
RUN;

/*********************/
/* Stacking datasets */
/*********************/

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

* stack data1 and data2, output conc;
DATA conc;
	SET data1 data2;
;

* has name and gender, but has race instead of age;
DATA data3;
	INPUT name $ race $ gender $;
	CARDS;
	Gaby   hispanic female 
	Homer  black    male   
	Ingrid white    female 
;
RUN;

* stack conc and data3;
DATA conc2;
	SET conc data3;
;

PROC PRINT;
RUN;
/*****************************************/
/* Merging datasets by column identifier */
/*****************************************/

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

* merge match 1 and match 2;
DATA matched;
	MERGE match1 match2;
	BY name;
RUN;
* unfortuntately, it doesn't work;

* sort match2 by name;
PROC SORT data=match2;
	BY name;
RUN;

* now, we can match!;
DATA matched;
	MERGE match1 match2;
	BY name;
RUN;

PROC PRINT;
RUN;
* scores for Alice and Bob;
DATA match3;
	INPUT name $ score;
	CARDS;
	Alice 95
	Alice 90
	Bob   80
	Bob   85
;

* Merge w/ match1;
DATA matched;
	MERGE match1 match3;
	BY name;
RUN;

PROC PRINT;
RUN;

* create merged dataset, dropping missing data;
DATA matched;
	MERGE match1 (in = inmatch1) match3 (in = inmatch3);
	BY name;
	if inmatch1 and inmatch3;
RUN;

PROC PRINT;
RUN;
/* Exercise 3 */

* print datasets;
PROC PRINT data= before;
RUN;

PROC PRINT data = after;
RUN;

* merge before and after;
PROC SORT data = after;
	BY id;
RUN;

DATA mergedscores;
	MERGE before after;
	BY id;
RUN;

* drop missing values;
DATA complete;
	MERGE before (in = inbefore) after (in = inafter);
	BY id;
	if inbefore and inafter;
RUN;

* print and summarize complete data;
PROC PRINT data = complete;
RUN;

PROC MEANS data = complete;
RUN;

* create difference "after-before";
DATA complete;
	SET complete;
	diff = after-before;
RUN;

* plot difference "after-before";
PROC SGPLOT data = complete2;
	HBOX diff;
RUN;

* how many students improved their scores after the summer school?;
PROC MEANS data = complete2;
	WHERE diff > 0;
RUN;
