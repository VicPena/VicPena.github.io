* Galton 1886 data, males subset;
PROC PRINT data = galton;
RUN;

* Plot scatter father height vs son height;
PROC SGPLOT data = galton;
	SCATTER x = father y = height;
RUN;

* find correlation;
PROC CORR data = galton;
	VAR father height;
RUN;

* introduce least squares;
* overlay least squares line to scatterplot;
PROC SGPLOT data = galton;
	SCATTER x = father y = height;
RUN;

* overlay 'y = x';
PROC SGPLOT data = galton;
	REG x = father y = height;
	LINEPARM x = 60 y= 60 slope = 1 / lineattrs = (color = red);
RUN;

PROC REG data = galton;
	MODEL height = father;
RUN;

* animals data;
PROC PRINT data = animals;
RUN;

* plot data, adding animal names;
PROC SGPLOT data = animals;
	SCATTER x = body y = brain / datalabel = VAR1; 
RUN;
