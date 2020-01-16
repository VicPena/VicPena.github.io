# Intro to Machine Learning in `R` workshop

## Basics

**Days:** January 23-25, 2020. 

**Teaching times:** 10am to 1pm, then 2pm to 5pm. 

**Room:** 14-235 NVC. 

**My email address:** `victor.pena@baruch.cuny.edu`. 

## Prerequisites

* Some working `R` knowledge at the level of [Introduction to R](https://www.datacamp.com/courses/free-introduction-to-r).

* Some working knowledge of linear regression.

* Some prior coding background can be helpful, but it's not essential. 

* **Get access to Datacamp by [clicking on this link](https://www.datacamp.com/groups/shared_links/927d5587f2230ed904196a426e960624ab38eb26)**. Use your `@baruch.cuny.edu` email address to join Datacamp. If you want to use another email address, please let me know.

## Logistics

If you just took the introductory `R` course, we'll follow a similar strategy here.

Your backgrounds are diverse, so teaching a "one-size-fits-all" course wouldn't make sense. Also, after teaching programming for a couple of years now, I've learned that the only way to learn how to code in `R` (or any programming language, for that matter) is *by coding*. 

For these reasons, I'll keep my lecturing input to a bare minimum. I'm going to assign you some courses on [DataCamp](http://www.datacamp.com) and I'll give you access to some notes I have written for extra support.

My hope is that you work through the content in class while I assist you as needed. I give you recommended "paths" (i.e. sequences of Datacamp courses, notes, and exercises) based on your prior background below, but feel free to pick-and-choose. And, of course, feel free to ask me any questions you may have along the way. 

## Recommended paths

I suggest that you work through the [Introduction to Machine Learning](https://www.datacamp.com/courses/introduction-to-machine-learning-with-r) course on Datacamp. If you're familiar with the models and theoretical concepts, you can skip the videos (which explain them) and go straight to the exercises which focus on implementing the methods in `R`. 

If you don't have a strong coding background (e.g. if you're not comfortable with `for` loops), here's a list of exercises you might want to skip:

* "Using CV": this exercises uses  a `for` loop to implement cross-validation; in practice, we can use `library(caret)`, which does that automatically for us.  
* "Increasing the bias": this exercise involves editing a custom-made function in a hard-coded classifier, something that rarely happens in practice.
* "K's choice": you can tune this parameter using cross-validation, which is implemented in `library(caret)` .
* "Making a scree plot!": you can tune this parameter using cross-validation, which is implemented in `library(caret)`.
* "Your own k-NN algorithm": you can use `library(caret)` to fit this model without using a custom function.

Once you finish the course, I suggest that you take a look at my short notes on [using `library(caret)` for doing cross-validation](http://vicpena.github.io/workshops/caretCV.html).

After taking the course and reading through my notes on `library(caret)`, I recommend that you take [Introduction to text analysis in `R`](https://campus.datacamp.com/courses/introduction-to-text-analysis-in-r/) on Datacamp. It's a nice and gentle introduction to text analysis which uses packages in the `tidyverse`. 

## Books (all open-access)

* [Introduction to Statistical Learning](http://faculty.marshall.usc.edu/gareth-james/ISL/), by James, Witten, Hastie, and Tibshirani.

* [ModernDive](http://www.moderndive.com), by Chester Ismay and Albert Y. Kim.

* [R for Data Science](https://r4ds.had.co.nz/), by Hadley Wickham.

* [R Programming for Data Science](https://bookdown.org/rdpeng/rprogdatascience/), by Roger Peng. 

