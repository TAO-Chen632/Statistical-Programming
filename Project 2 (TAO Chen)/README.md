[![Check Allowed Files](https://github.com/statprog-s1-2020/proj2_tao-chen632/workflows/Check%20Allowed%20Files/badge.svg)](https://github.com/statprog-s1-2020/proj2_tao-chen632/actions?query=workflow:%22Check%20Allowed%20Files%22) [![Check RMarkdown Renders](https://github.com/statprog-s1-2020/proj2_tao-chen632/workflows/Check%20RMarkdown%20Renders/badge.svg)](https://github.com/statprog-s1-2020/proj2_tao-chen632/actions?query=workflow:%22Check%20RMarkdown%20Renders%22)


Statistical Programming - Project 2
------------
Due on Monday, December 7th by 17:00 UK local time.

## Rules

1. Your solutions must be written up using the provided R Markdown file (`proj2.Rmd)`, this file must include your code and write up for each task.

2. This project is open book, open internet, closed other people. You may use *any* online or book based resource you would like, but you must include citations for any code that you use (directly or indirectly). You *may not* consult with anyone else about this exam other than the Lecturers or Tutors for this course - this includes posting anything online. You may post questions on Piazza, general questions are fine and can be posted publicly - any question containing code should be posted privately.

3. If you receive help *or* provide help to any other student in this course you will receive 0 marks for this assignment. Do not share your code with anyone else in this course.


## Overview

This practical revisits the cars data from Homework 4. The aim is to compare three Bayesian models for these data, by implementing the models in JAGS, having JAGS sample from the corresponding posterior densities, checking that this is working properly, and then using the deviance information criterion, DIC, for model comparison. 

You should write up your analysis using the provided R markdown file (`proj2.Rmd`). Your write up should concisely explain what you have done so that another statistician could understand your approach and replicate it. Your write up should be concise enough that when knitted to pdf it is *at most* 8 pages in length - a guideline optimal length is 6 pages. You should explain which model you think is most appropriate and why. It is fine to be selective in what is included in the markdown document, perhaps simply briefly describing the results of some of the chain checking, for example, rather than including everything (you do need to include some evidence that the chains are mixing and converging properly, of course, just be selective). 

Remember when writing up that *no one wants to read your diary*. Your report should not read as 'we did this, and then we did that and then we did another thing and then...' Your aim is to communicate clearly what the analysis is about and how you approached it, in a way that lets the reader understand the aims, how they were achieved, what the conclusions are, and how to replicate the results.

The models that you should compare are described in detail in the `proj2.Rmd` file that has been provided. They are a constant variance normal model, a normal model in which the standard deviation increases with speed, and a gamma model.

Obviously you can not complete this task entirely in a single markdown file, as you will need to write JAGS model specification code in a file for each model. It is also likely to be most efficient to work out what you are doing in a separate R script, transferring to markdown once you are sure things are working, rather than writing all your R code directly in markdown. All JAGS model specification files required to knit your final R markdown file must be in your repository at submission time. Any and all R script files and JAGS code files must be contained in a folder called `scripts` in your repository. 



### Task 1 - JAGS model specifications

Write JAGS code to implement the three models, and make sure that you can simulate from their posterior distributions using the functions in the `rjags` package. The code specifying the models should be included in your R markdown file. 

### Task 2 - Simulation and checking

Using the functions in the `coda` package you should check the convergence and mixing of your chains, selecting appropriate run lengths and thinning if it seems appropriate. Aiming for effective sample sizes of over 1000 for each parameter is sensible. Your report should include the checking results you think are most appropriate, and mention of any other checks that you did, but do *think* about what is most reasonable to show and discuss in the limited space available. 

Since your aim is to help a reader follow your analysis and repeat it, you should show enough code for the reader to understand how to produce the reported results, but not show repeated code for each model. 

### Task 3 - Model comparison

Use DIC to evaluate and choose between the three models. As a check that the choice is sensible, also compare the model predictions of the distance versus speed curves produced by a sensible sub-sample of draws from each model's posterior. 


<br/>


