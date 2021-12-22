[![Check Allowed Files](https://github.com/statprog-s1-2020/hw02_tut03_team01/workflows/Check%20Allowed%20Files/badge.svg)](https://github.com/statprog-s1-2020/hw02_tut03_team01/actions?query=workflow:%22Check%20Allowed%20Files%22) [![Check RMarkdown Renders](https://github.com/statprog-s1-2020/hw02_tut03_team01/workflows/Check%20RMarkdown%20Renders/badge.svg)](https://github.com/statprog-s1-2020/hw02_tut03_team01/actions?query=workflow:%22Check%20RMarkdown%20Renders%22) [![Check Rmd Structure](https://github.com/statprog-s1-2020/hw02_tut03_team01/workflows/Check%20Rmd%20Structure/badge.svg)](https://github.com/statprog-s1-2020/hw02_tut03_team01/actions?query=workflow:%22Check%20Rmd%20Structure%22)


Statistical Programming - Homework 2
------------
Due on Friday October 23rd by 17:00 UK local time.
* Tao Chen (Ed) - s2022911@ed.ac.uk
* Lin Zixu - s2042541@ed.ac.uk
* Song Yuli (Yuli) - s2116641@ed.ac.uk
* Chang John (Florence) - s2080507@ed.ac.uk
<br/>

## Task 1 - Lego Sales Data

### Data

For this task you will be working with a synthetic data set of sales records for Lego construction sets. We will assume that the original data was stored in a JSON format but a colleague has managed to import it into R as a list of lists (of lists). The code below will load a copy of the object, called `sales`, into your environment.

```r
sales = readRDS("data/lego_sales.rds")
```

The original JSON file is also available, as `data/lego_sales.json` in your repo, if you would prefer to examine a text based representation of these data.

The data is structured such that each entry in the top list represents a different purchaser. These list entries contain basic information about the purchaser (name, age, phone number, etc.) as well as their purchase history. Everyone in the data set has purchased at least one lego set but many have purchased more than one. The purchase histories are stored in the `purchases` element which is also a list of lists. Each entry within the `purchases` list reflects a different Lego set which the customer purchased. Note that the customer may have purchased more than one copy of any particular set, this number is stored as `Quantity` within the purchase record.

<br/>

### Part 1 - Tidy the data

Your job here is to covert the `sales` object into a tidy data frame. Tidy in this case means each row should represents a separate purchase of a lego set by an individual and the columns should correspond to the keys in the JSON data. Duplicate columns should be avoided as much as possible and no data should be lost / ignored in the conversion.

Several guidelines / hints:

1. Be careful about making assumptions about the data - it is not as messy as real world data, but it is also not pristine and you are meant to run into several hiccups along the way.

2. Pay attention to types - the data frame you create should have columns that are of a type that matches the original data. 

3. Don't worry about duplicated data - since a customer can purchase multiple Lego sets that customer's information may show up in multiple rows. This is fine and expected given the structure of the data. For the CS types: first normal form is ok in this case regardless of whatever your Databases professor may have told you.

4. Dealing with duplicate purchases - some customers purchased more than one copy of a particular lego set, for these individuals you can choose to code the purchase as multiple rows within the data frame or as a single row that also includes the quantity value. Either approach is fine, but your write up should discuss your choice. 

5. Avoid hard coding features of the data into your solutions (e.g. column names for your data frame should be determined at runtime as much as possible). 

6. Do not use magic numbers, always use column names whenever possible, similarly don't assume a specific size for the data (e.g. number of columns or rows) - all of these should be determined at run time.

7. More generally, assume that the specific data could be changed at any time, and a new but identically structured data set could be provided. Make as few assumptions as possible about the data (some will be necessary, but should be stated explicitly in your write up).

8. You may assume that *purchasers* are uniquely identified by the first name, last name, and phone number.

9. When answering questions, in the case of a tie - all equivalent rows should be returned.

<br/>


### Part 2 - Questions

This task will involve answering a number of questions about that data that will involve manipulating and summarizing the data frame you created in part 1. You are also welcome to use the original `sales` object if you believe that approach is more efficient for any particular question.

No write up is needed for these questions as long as you include reasonably well documented code (using comments). Make sure that your code outputs your answer and only your answer. 

<br/>

1. What are the three most common first names of purchasers?

1. Which Lego theme has made the most money for Lego?

1. Do men or women buy more Lego sets (per person) on average?

1. What are the five most popular hobbies of Lego purchasers?

1. Which area code has spent the most money on Legos? (In the US the area code is the first 3 digits of a phone number)


## Task 2 - GitHub and dplyr

### Data

This is similarly structured data to what you were given in Task 1. In this case you are provided with details on all of the commits made to the dplyr package on GitHub since the beginning of the year. These data were obtained from the GitHub API and were originally formatted as JSON. Once again, we have pre-processed these data into a list of lists of lists (etc.) and the resulting object can be read into R using the following code:

```r
commits = readRDS("data/dplyr_commits.rds")
```

These data are somewhat more complicated than the lego data, however much of the data values provided are redundant and/or irrelevant for the assigned tasks. Our goal initially is to tidy up a subset of these data to construct a useful data frame which can then be used to answer several questions about the development and contributions to dplyr this year.

Some relevant details about git / GitHub that will be useful for understanding / working with these data:

* git commits are uniquely identified by a hexidecimal hash called the `sha`

* git makes a distinction between who wrote the code and who committed it, the vast majority of the time these are the same and we will not worry about the cases where this is not true. For this task, you should assume that data stored under `author` should be used when determining who is responsible for a commit.

* Remember that a commit can involve a single file or multiple files, the reported `stats` are for all the files collectively, individual file's stats are available within the `files` element.

* git / GitHub tracks the changes made to files in terms of additions and deletions - these changes might be as little as deleting a single character to as complicated as adding hundreds of lines of new functions. These statistics are stored for the commit as a whole in `stats` and on a per file basis within `files`.

* The data contains information on the commit history of the repository, including which commit is descended from which, while interesting none of this will be necessary for completing the rest of the task. Examples of this type of data can be found the in the `parents` entry. 


### Part 1 - Structure of a commit

Examine the structure of one or more commits in the `commits` object. Briefly describe the structure of this data structure for a single commit. You should not describe the values that are present for a specific commit but rather describe the general organization of the data - e.g. what is reported about the commit, the author, the files modified, etc.

### Part 2 - Tidy the data

Just like the previous task you are now expected to create a tidy data frame from these data. As mentioned in the introduction to the task there is a lot of information stored in this object that is not necessary for Part 3 of this task. Your data frame should not include every value from the commits object, instead it should only have columns that are relevant for the next task. Note that it is undesirable (inefficient) to create columns to only drop them later - keep this in mind as you go about rectangling these data.

Your write up should detail your process for generating this tidy data frame as well as details about which columns you chose to include and why.

### Part 3 - Questions

1. Who are the top five contributors (in terms of the most commits) to dplyr in 2020?

2. Who is the top contributor who is not a current employee of RStudio? Current employees can be found [here](https://rstudio.com/about/). Briefly describe one or more of their commits to the project.

3. Which four files have been modified most often? (i.e. show up in the most number of commits)

4. Describe the general pattern for development of dplyr. Specifically, show a tabulation or visualization for the number of commits made for each hour of the day and day of the week and then describe the general patterns that you see.

5. dplyr has had 5 releases to [CRAN](https://cran.r-project.org/web/packages/dplyr/index.html) in 2020, create a visualization exploring an interesting relationship between these releases and the commit history.


<br/>

## Submission and Grading

This homework is due by *17:00 pm Friday, October 23rd* UK local time. You are to complete the assignment as a group and to keep everything (code, write ups, etc.) on your team's github repository (commit early and often). All team members are expected to contribute equally to the completion of this assignment and group assessments will be given at its completion - anyone judged to not have sufficient contributed to the final product will have their grade penalized. While different teams members may have different coding backgrounds and abilities, it is the responsibility of every team member to understand how and why all code in the assignment works.

The final product for this assignment should be a single Rmd document (`hw2.Rmd`, a template of which is provided) that contains all code and text for the tasks described above. This document should be clearly and cleanly formatted and present all of your write up and results. Style, efficiency, formatting, and readability all count for this assignment, so please take the time to make sure everything looks good and your text and code are properly formatted. This document must be reproducible and I must be able to compile it with minimal intervention - documents that do not compile will be given a 0. 

<br/>


