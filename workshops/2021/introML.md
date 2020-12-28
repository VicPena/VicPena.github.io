# Intro to Machine Learning in `R` workshop

## Basics

**Days:** January 11th, 13th, and 15th.  

**Teaching times:** 10am to noon, then 2pm to 4pm. We'll meet on Zoom. You'll receive an email with my personal meeting room information.

**My email address:** `victor.pena@baruch.cuny.edu`. 

**Office hours:** By appointment. Send me an email and we'll make it work.

## Prerequisites

* Some working `R` knowledge at the level of [Introduction to R](https://www.datacamp.com/courses/free-introduction-to-r).

* Some working knowledge of linear regression.

* Some additional coding background can be helpful, but it's not essential. 

* **Getting access to Datacamp:** Unfortunately, I'm waiting on Datacamp to activate our course. I'll let you know when they approve it. You will have to register with your `@baruch.cuny.edu` email address to join Datacamp. If you want to use another email address, please let me know.

## Logistics

I suggest that you work through the [Introduction to Machine Learning](https://www.datacamp.com/courses/introduction-to-machine-learning-with-r) course on Datacamp. If you're familiar with the models and theoretical concepts, you can skip the videos (which explain them) and go straight to the exercises which focus on implementing the methods in `R`. 

If you don't have a strong coding background (e.g. if you're not comfortable with `for` loops), here's a list of exercises you might want to skip:

* **"Using CV":** this exercise uses  a `for` loop to implement cross-validation; in practice, we can use `library(caret)`, which does that automatically for us.  
* **"Increasing the bias":** this exercise involves editing a custom-made function in a hard-coded classifier, something that rarely happens in practice.
* **"K's choice":** you can tune this parameter using cross-validation, which is implemented in `library(caret)` .
* **"Making a scree plot!":** you can tune this parameter using cross-validation, which is implemented in `library(caret)`.
* **"Your own k-NN algorithm":** you can use `library(caret)` to fit this model without using a custom function.

Once you finish the course, I suggest that you take a look at my short notes on [using `library(caret)` for doing cross-validation](http://vicpena.github.io/workshops/caretCV.html).

## Books (all open-access)

* [Introduction to Statistical Learning](http://faculty.marshall.usc.edu/gareth-james/ISL/), by James, Witten, Hastie, and Tibshirani.

* [ModernDive](http://www.moderndive.com), by Chester Ismay and Albert Y. Kim.

* [R for Data Science](https://r4ds.had.co.nz/), by Hadley Wickham.

* [R Programming for Data Science](https://bookdown.org/rdpeng/rprogdatascience/), by Roger Peng. 

