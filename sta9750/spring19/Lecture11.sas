* plot data, adding animal names;
PROC SGPLOT data = animals;
	SCATTER x = body y = brain / datalabel = VAR1; 
RUN;

* get rid of elephants and dinosaur;
DATA animals2;
	SET animals;
	WHERE body < 20000 and brain < 4000;
RUN;

* there are more dinosaurs! and humans are too smart;
PROC SGPLOT data = animals2;
	SCATTER x = body y = brain / datalabel = VAR1; 
RUN;

* get rid of dinosaurs and humans;
DATA animals2;
	SET animals;
	WHERE body < 2000 and brain < 750;
RUN;

* chimps seem to be too smart for their weight;
PROC SGPLOT data = animals2;
	SCATTER x = body y = brain / datalabel = VAR1; 
RUN;

* get rid of chimps;
DATA animals2;
	SET animals2;
	IF VAR1 = 'Chimpanzee' THEN DELETE;
RUN;

* this seems to look mostly fine;
PROC SGPLOT data = animals2;
	SCATTER x = body y = brain / datalabel = VAR1; 
RUN;

* actually, residuals don't look very normal;
PROC REG data = animals2;
	MODEL brain = body;
RUN;

DATA animals;
	SET animals;
	logbrain = log(brain);
	logbody = log(body);
RUN;


* elephants and humans stick out;
PROC SGPLOT data = animals;
	SCATTER x = logbody y = brain / datalabel = VAR1; 
RUN;

PROC SGPLOT data = animals;
	SCATTER x = logbody y = logbrain / datalabel = VAR1; 
RUN;

DATA animals;
	SET animals;
	IF VAR1 = 'Brachiosaurus' or VAR1 = 'Triceratops' or VAR1 = 'Dipliodocus' THEN DELETE;
RUN;

PROC SGPLOT data = animals;
	SCATTER x = logbody y = logbrain / datalabel = VAR1; 
RUN;

PROC REG data = animals;
	MODEL logbrain = logbody;
RUN;

* identify big residual points;
PROC REG data = animals;
	MODEL logbrain = logbody;
	output out = diagnostics
		r = residuals;
RUN;
* humans and rhesus monkeys are smarter than predicted by the model;
PROC PRINT data = diagnostics;
	WHERE residuals > 1.5;
RUN;


* predict beagle;
* avg weight = 10kg; 
* source: wikipedia;

DATA beagle;
	INPUT VAR1 $ body;
	logbody = log(body);
	CARDS;
	Beagle 10
;

PROC PRINT data = beagle;
RUN;

DATA animals3;
	SET animals beagle;
RUN;

PROC PRINT;
RUN;


PROC REG data = animals;
	MODEL logbrain = logbody;
	output out = preds
		p = predictions
		lcl = lowpred
		ucl = uppred;
RUN;

PROC PRINT data = preds;
RUN;

