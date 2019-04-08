#' ---
#' title: "Introduction to `ggplot2` "
#' author: "Víctor Peña"
#' output:
#'   html_document:
#'     toc: true
#'     theme: cosmo
#' ---
#' 
#' 
#' 
#' ---
#' # Commenting out some stuff
#' ---
#' 
#' ---
#' # Don't print messages, errors, warnings
#' ---
## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(error = FALSE, message = FALSE, warning = FALSE)

#' 
#' Today (and most likely next time) we'll learn a little bit about `ggplot2`. There are many good resources on the topic. 
#' 
#' Some of them are:
#' 
#' * [Cookbook for R](http://www.cookbook-r.com/Graphs/)
#' 
#' * [ggplot2 cheatsheet](https://github.com/rstudio/cheatsheets/blob/master/data-visualization-2.1.pdf)
#' 
#' * [r-statistics.co](http://r-statistics.co/ggplot2-cheatsheet.html)
#' 
#' We will use the `diamonds` dataset in `library(ggplot2)`, so we load the library and the dataset.
#' 
## ------------------------------------------------------------------------
library(ggplot2)
data(diamonds)

#' 
#' The dataset has `r nrow(diamonds)` observations and `r ncol(diamonds)` columns, with column names
#' 
## ----echo=FALSE----------------------------------------------------------
colnames(diamonds)

#' 
#' You can get more information on what the variables are by running the `R` command
#' 
## ----eval=FALSE----------------------------------------------------------
## ?diamonds

#' 
#' # Basic plots with `qplot`
#' 
#' We have seen how to create some basic plots with `qplot` already. Now it's time to summarize what we learned and go a little deeper. The good thing about `qplot` is that it has good defaults for a decent amount of situations.
#' 
#' ## Univariate plots
#' 
#' One variable at a time!
#' 
#' ### Categorical
#' 
#' The most common plots for univariate categorical data are pie charts and bar plots. People who have done research on data visualization agree that pie charts are bad. For example, if you get help for the function `pie` (which produces pie charts in the base `graphics` library on `R`), you get the following *note*:
#' 
#' > Pie charts are a very bad way of displaying information. The eye is good at judging linear measures and bad at judging relative areas. A bar chart or dot chart is a preferable way of displaying this type of data.
#' 
#' > Cleveland (1985), page 264: "Data that can be shown by pie charts always can be shown by a dot chart. This means that judgements of position along a common scale can be made instead of the less accurate angle judgements." This statement is based on the empirical investigations of Cleveland and McGill as well as investigations by perceptual psychologists.
#' 
#' It's possible to create pie charts with `ggplot2` (see e.g. [this link](https://stackoverflow.com/questions/20442693/how-to-use-ggplot2-to-generate-a-pie-graph)) but we won't cover them here.
#' 
#' Creating a bar plot with `qplot` is very easy:
## ------------------------------------------------------------------------
qplot(cut, data=diamonds)

#' 
#' In `ggplot2`, plots can be saved as variables. This is a useful feature because, in `ggplot2`, we create visualizations *sequentially* by adding layers to a plot. It also makes the code cleaner. Let's save the plot in a variable and add stuff to it.
#' 
## ------------------------------------------------------------------------
barcut = qplot(cut, data=diamonds)

#' 
#' Sometimes I feel like the default fontsize of the plots is too small. You can change the font size as follows
#' 
## ------------------------------------------------------------------------
barcut = barcut+theme(text=element_text(size=15))
barcut

#' 
#' You can change the color of the bars:
#' 
## ------------------------------------------------------------------------
barcut = barcut+geom_bar(fill='steelblue')
barcut

#' 
#' And you can flip the coordinates
#' 
## ------------------------------------------------------------------------
barcut = barcut+coord_flip()
barcut

#' 
#' You can add a title, too!
#' 
## ------------------------------------------------------------------------
barcut = barcut+ggtitle("Quality of cut")
barcut 

#' 
#' If you want to center the title:
#' 
## ------------------------------------------------------------------------
barcut + theme(plot.title = element_text(hjust = 0.5))

#' 
#' As you saw, since we were saving the changes as we produced them, all the previous changes to the plot were saved. As you might imagine, an equivalent chunk of code to produce the plot is
#' 
## ---- eval=FALSE---------------------------------------------------------
## qplot(cut, data=diamonds)+
##   theme(text=element_text(size=15))+
##   geom_bar(fill='steelblue')+
##   coord_flip()+
##   ggtitle("Quality of cut")+
##   theme(plot.title = element_text(hjust = 0.5))

#' 
#' You can change the general theme quite easily as well:
#' 
## ------------------------------------------------------------------------
qplot(cut, data=diamonds)+theme_minimal()

#' 
#' You can find a list of default themes [here](https://ggplot2.tidyverse.org/reference/ggtheme.html). You'll have access to more themes if you install `library(ggthemes)`. See [this reference](http://www.sthda.com/english/wiki/ggplot2-themes-and-background-colors-the-3-elements) for more details. 
#' 
#' ### Quantitative
#' 
#' In `qplot`, the default plot for quantitative data looks like this
#' 
## ------------------------------------------------------------------------
qplot(price,data=diamonds)

#' 
#' You can also make density plots.
#' 
## ------------------------------------------------------------------------
qplot(price, geom='density', data=diamonds) 

#' 
#' You can change the color of the density plot as follows:
#' 
## ------------------------------------------------------------------------
qplot(price, geom='density', data=diamonds) + geom_density(fill='steelblue')

#' 
#' ## Bivariate
#' 
#' ### Categorical vs Categorical
#' 
#' Creating stacked barplots is easy.
#' 
## ------------------------------------------------------------------------
q1 = qplot(x=cut, fill=color, data=diamonds)
q1

#' 
#' Alternatively,
#' 
## ------------------------------------------------------------------------
q2 = qplot(x=color, fill=cut, data=diamonds)
q2 

#' 
#' You can play around with the color palette with `scale_fill_brewer`. 
#' 
## ------------------------------------------------------------------------
q2 + scale_fill_brewer(palette="Spectral")

#' 
#' More info [here](https://ggplot2.tidyverse.org/reference/scale_brewer.html) and [here](http://www.cookbook-r.com/Graphs/Colors_(ggplot2)/).
#' 
#' **Exercise** How would you flip the coordinates?
#' 
#' **Solution** 
#' 
## ------------------------------------------------------------------------
q2 + coord_flip()

#' 
#' **Exercise** Does the distribution of colors depend on the quality of the cut? 
#' 
#' **Solution** We can answer this question with a $\chi^2$-test.
#' 
## ------------------------------------------------------------------------
tab = table(diamonds$color, diamonds$cut)
round(prop.table(tab,1),2)
round(prop.table(tab,2),2)
chisq.test(tab)

#' 
#' ### Categorical vs Quantitative
#' 
#' Different options here! But some of them are bad. For example, I think this is a bad plot:
#' 
## ------------------------------------------------------------------------
qplot(x=price, fill=cut, data=diamonds)

#' 
#' How can we create a better plot? A less bad plot is 
#' 
## ------------------------------------------------------------------------
qplot(x=price, color=cut, geom='density', data=diamonds)

#' 
#' Side-by-side boxplots are a better alternative:
#' 
## ------------------------------------------------------------------------
qplot(x=cut, y=price, geom='boxplot', data=diamonds)+coord_flip()

#' 
#' You can add color using `fill`:
#' 
## ------------------------------------------------------------------------
qplot(x=cut, y=price, fill=cut, geom='boxplot', data=diamonds)+
  theme(legend.position="none")+
  coord_flip()

#' 
#' The code `theme(legend.position="none")` gets rid of the legend. 
#' 
#' Another option is using `facets`.
#' 
## ------------------------------------------------------------------------
qplot(price, facets = cut ~ ., data=diamonds)

#' 
#' ### Quantitative vs Quantitative
#' 
#' Scatterplots are your best bet here.
#' 
## ------------------------------------------------------------------------
qplot(x=carat, y=price, data=diamonds)

#' 
#' You can add some smoothed trend:
#' 
## ------------------------------------------------------------------------
qplot(x=carat, y=price, data=diamonds)+geom_smooth()

#' 
#' And you can fit some linear trend:
#' 
## ------------------------------------------------------------------------
qplot(x=carat, y=price, data=diamonds)+geom_smooth(method='lm')

#' 
#' **Exercise** Can we use transformations to make the linear fit better?
#' 
#' **Solution** Yes, if you take logs of both variables, it'll look better. There are still some patches which are probably due to the existence of some *hidden* variable(s). The variance doesn't seem to be constant.
#' 
## ------------------------------------------------------------------------
qplot(x=log(carat), y=log(price), data=diamonds)+geom_smooth(method='lm')

#' 
#' ## Axes, titles and labels
#' 
#' The relevant commands here are
#' 
#' * `ggtitle`: for changing the title
#' 
#' * `xlab`, `ylab`: $x$ and $y$ labels
#' 
#' * `xlim`, `ylim`: limits / scale of the plot
#' 
## ------------------------------------------------------------------------
qplot(x=carat, y=price, data=diamonds)+ 
  xlab("carat (weight)") + 
  ylab("price ($)") + 
  ggtitle("Price vs carat") +
  xlim(c(0,10))+
  ylim(c(0,30000))

