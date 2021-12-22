[![Check Allowed Files](https://github.com/statprog-s1-2020/proj1_tao-chen632/workflows/Check%20Allowed%20Files/badge.svg)](https://github.com/statprog-s1-2020/proj1_tao-chen632/actions?query=workflow:%22Check%20Allowed%20Files%22) [![Check RMarkdown Renders](https://github.com/statprog-s1-2020/proj1_tao-chen632/workflows/Check%20RMarkdown%20Renders/badge.svg)](https://github.com/statprog-s1-2020/proj1_tao-chen632/actions?query=workflow:%22Check%20RMarkdown%20Renders%22) [![Check Rmd Structure](https://github.com/statprog-s1-2020/proj1_tao-chen632/workflows/Check%20Rmd%20Structure/badge.svg)](https://github.com/statprog-s1-2020/proj1_tao-chen632/actions?query=workflow:%22Check%20Rmd%20Structure%22)


Statisitcal Programming - 2020 - Project 1
-----------

Due Monday, November 2nd by 5:00 pm (17:00) UK local time.

## Rules

1. Your solutions must be written up using the provided R Markdown file (`proj1.Rmd)`, this file must include your code and write up for each task.

2. This project is open book, open internet, closed other people. You may use *any* online or book based resource you would like, but you must include citations for any code that you use (directly or indirectly). You *may not* consult with anyone else about this exam other than the Lecturers or Tutors for this course - this includes posting anything online. You may post questions on Piazza, general questions are fine and can be posted publicly - any question containing code should be posted privately.

3. If you receive help *or* provide help to any other student in this course you will receive 0 marks for this assignment. Do not share your code with anyone else in this course.

4. You have until Monday, November 2nd by 5:00 pm (17:00) UK local time to complete this project and turn it in via your personal Github repo - late work will be subject to the standard university late policy. Technical difficulties are not an excuse for late work - do not wait until the last minute to commit / push.

5. All of your answers *must* include a brief description / write up of your approach. This includes both annotating / commenting your code *and* a separate written descriptions of all code / implementations. I should be able to suppress *all* code output in your document and still be able to read and make sense of your answers.

6. You may use any packages you like from *CRAN*, however all tasks can be accomplished using the packages provided by default in RStudio Cloud.

7. Your first goal is to write code that can accomplish all of the given tasks,  however keep in mind that marking will also be based on the quality of the code you write - elegant, efficient code will be given better marks and messy, slow code will be penalized.

<br />

## Data

For this exam you will be working with a data from the 2019 Formula 1 racing season. The data was downloaded from ergast.com in the form of several JSON files which contain information on the results of all 21 races from the 2019 season. These data were read into R using the `jsonlite` packages and your repo contains the resulting R object saved as `f1.rds` in the `data` directory. This file can be loaded into your R session using
```r
f1 = readRDS(file="data/f1.rds")
```

The data is structured as a list of lists of lists of lists and so on, it is up to you to look at the data and figure out how it is structured and how best to get at the information you need.

<br />

## Task 1 - Tidy the data

Starting from the `f1` object create a tidy data frame from these data with the following columns:

* `race_name` - The name of the race (character type)
* `round` - Round of the race (integer type, between 1 and 21)
* `date` - Date of the race (date class)
* `driver` - Name of a driver, including first and last name (character type)
* `constructor` - Name of a driver's constructor, i.e. team (character type)
* `position` - Position (place) driver finished in for the race (integer type, `NA` if they did not finish for any reason)
* `points` - Number of points the driver earned for the race (integer type)

Each row of this data frame should represent the result of a driver for a particular race.

Print out 10 rows of this data frame, clearly showing the structure and column types of your answer.

### Additional guidance

* For details on how the race results are reported in the data see the [race result page](https://ergast.com/mrd/methods/results/) on Ergast.

* An optimal solution to this task will not make repeated use of `unnest_longer` and `unnest_wider` - use these sparingly and avoid creating unnecessary columns.



<br/>


## Task 2 - Drivers' Championship

Using the data frame from Task 1, construct a table showing the World Drivers' Championship standings for this F1 season. This table should *resemble* but not be identical to the results available on [Wikipedia](https://en.wikipedia.org/wiki/2019_Formula_One_World_Championship#World_Drivers'_Championship_standings). Your data frame should also have 23 columns: Driver name, finishing position each of the 21 races, and finally thed driver's overall points total for the season. Your data frame should be sorted by points total, you do not need to include any additional logic to handle ties. 

Print out a nicely formatted version of the *complete* table in your rendered document. 


### Additional guidance

* Failure to finish for any reason (did not start, did not finish, disqualified, retired, etc.) should be coded as an `NA`.

* Race finishes and points total should all have an integer type.

* The order of the race columns should follow the chronological order in which the races occurred.

<br />

## Task 3 - Cumulative Constructors

Using the data frame from Task 1 (as a starting point), construct a table that contains the *cumulative* points earned by each of the 10 constructors (teams) at the end of each of the 21 races of the 2019 season. 

For example Mercedes earned 44 points from the Australian Grand Prix, 43 from the Bahrain Grand Prix, and 43 from the Chinese Grand Prix. Therefore the row for Mercedes in this data frame would contain the values 44, 87, 130 for the first three columns, corresponding to these races. 

Your final data frame should have 22 columns: Constructor name and one column for each of the 21 grand prix races. You results should be ordered by the constructors total points at the end of the season.

Print out a nicely formatted version of the *complete* table in your rendered document.

<br />

## Task 4 - Visualization

Design a visualization that shows the performance of *both* drivers and teams over the course of the 2019 F1 season in terms of the points earned toward the drivers' and constructors' Championship standings. This exercise is meant to be purposefully open ended, come up with a visualization that tells a compelling story about this season and use your write up to justify your design choices. Your write up *must* include a discussion of what you are trying to convey as well as how your visualization achieves those goals.

You may use any visualization tools and/or packages you would like as long as your results are reproducible (e.g. I should be able to change the source data and that change would be reflected in the visualization).


