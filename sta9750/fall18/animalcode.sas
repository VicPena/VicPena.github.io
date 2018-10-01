PROC PRINT DATA=animals;
RUN;

PROC PRINT DATA=animals;
	WHERE body > 6000;
RUN;

PROC REG DATA=animals;
	MODEL brain = body;
RUN;

DATA animals2;
	SET animals;
	IF body > 60000 THEN delete;
RUN;

PROC REG data=animals2;
	MODEL brain = body;
RUN;

DATA loganimals;
	SET animals;
	logbrain = LOG(brain);
	logbody = LOG(body);
RUN;

PROC PRINT data=loganimals;
RUN;

PROC REG data=loganimals;
	MODEL logbrain = body;
RUN;

PROC REG data=loganimals;
	MODEL logbrain = logbody;
RUN;
