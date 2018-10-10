PROC ANOVA Data=scores;
	class instructor;
	model score = instructor;
RUN;


PROC GLM DATA=scores;
	class instructor;
	model score = instructor;
	means instructor / hovtest=levene;
RUN;

