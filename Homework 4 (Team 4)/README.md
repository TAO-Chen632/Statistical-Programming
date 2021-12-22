[![Check Allowed Files](https://github.com/statprog-s1-2020/hw04_tut03_team04/workflows/Check%20Allowed%20Files/badge.svg)](https://github.com/statprog-s1-2020/hw04_tut03_team04/actions?query=workflow:%22Check%20Allowed%20Files%22) [![Check RMarkdown Renders](https://github.com/statprog-s1-2020/hw04_tut03_team04/workflows/Check%20RMarkdown%20Renders/badge.svg)](https://github.com/statprog-s1-2020/hw04_tut03_team04/actions?query=workflow:%22Check%20RMarkdown%20Renders%22)


Statistical Programming - Homework 4
================

Due on Friday November 27th by 17:00 UK local time.
* Aurora Wu - s2018109@ed.ac.uk
* Naomi Shakesheff - s2093080@ed.ac.uk
* Rao Miao - s2045476@ed.ac.uk
* Tao Chen - s2022911@ed.ac.uk
<br/>

## Overview

In this practical you will use bootstrapping and Metropolis Hastings
sampling for inference about the `cars` data supplied in R. The `cars`
data frame contains stopping distances for cars along with the speed
they were traveling at when signaled to stop. The data can be modelled
using a simple linear model

![
{\\tt dist}\_i = \\beta\_1 + \\beta\_2{\\tt speed}\_i + \\beta\_3 {\\tt speed}\_i^2 + \\epsilon\_i
](https://latex.codecogs.com/png.latex?%0A%7B%5Ctt%20dist%7D_i%20%3D%20%5Cbeta_1%20%2B%20%5Cbeta_2%7B%5Ctt%20speed%7D_i%20%2B%20%5Cbeta_3%20%7B%5Ctt%20speed%7D_i%5E2%20%2B%20%5Cepsilon_i%0A "
{\tt dist}_i = \beta_1 + \beta_2{\tt speed}_i + \beta_3 {\tt speed}_i^2 + \epsilon_i
")

where the
![\\beta\_j](https://latex.codecogs.com/png.latex?%5Cbeta_j "\beta_j")
are parameters and
![\\epsilon\_i](https://latex.codecogs.com/png.latex?%5Cepsilon_i "\epsilon_i")
are zero mean random variables. From physical first principles one might
expect that
![\\beta\_1=0](https://latex.codecogs.com/png.latex?%5Cbeta_1%3D0 "\beta_1=0"),
while
![\\beta\_2](https://latex.codecogs.com/png.latex?%5Cbeta_2 "\beta_2")
relates to the reaction time of the driver before applying the car’s
brakes.

In R the model can be estimated using
`lm(dist ~ speed + I(speed^2), data = cars)`, but standard inference
about the model depends on the
![\\epsilon\_i](https://latex.codecogs.com/png.latex?%5Cepsilon_i "\epsilon_i")
having constant variance, which appears doubtful if you examine the
model fit. This homework addresses this problem in two ways, first by
using bootstrapping to find confidence intervals for the model
coefficients, and then using a Bayesian approach and Metropolis Hastings
sampling to use a slightly different model in which the distances are
treated as gamma random variables.

This homework should be submitted as a single R markdown file. However
it is strongly advised that you develop your code in an R script file,
and only construct the `.Rmd` file once everything is working. Otherwise
your code will be more difficult to check and debug in a sensible and
efficient manner.

## Task 1 - Bootstrapping the linear model

### Part 1

Write code to generate 1000 bootstrap replicate estimates of the cars
model coefficient vector, examine the resulting parameter estimate
distributions graphically, and find 95% confidence intervals for the
parameters. This will involve refitting the model to each bootstrap
replicate data set.

Briefly discuss what, if any, conclusions you can draw from your
results.

### Part 2

In the light of your results from Part 1, propose and justify a modified
model. Again use the bootstrap to obtain confidence intervals for the
coefficients of your new model. Report your results and concisely
discuss any conclusions you can draw from these new results.

When writing up your second analysis, your compiled markdown document
should not show the modified bootstrap code, but simply its results,
along with a statement of what has been modified.

<br/>

## Task 2 - A gamma model for the cars data.

An alternative model for the data assumes a gamma distribution for the
distances.

![
E({\\tt dist}\_i) = \\beta\_1 + \\beta\_2{\\tt speed}\_i + \\beta\_3 {\\tt speed}\_i^2
\\qquad\\qquad
{\\tt dist\_i} \\sim \\text{gamma}
](https://latex.codecogs.com/png.latex?%0AE%28%7B%5Ctt%20dist%7D_i%29%20%3D%20%5Cbeta_1%20%2B%20%5Cbeta_2%7B%5Ctt%20speed%7D_i%20%2B%20%5Cbeta_3%20%7B%5Ctt%20speed%7D_i%5E2%0A%5Cqquad%5Cqquad%0A%7B%5Ctt%20dist_i%7D%20%5Csim%20%5Ctext%7Bgamma%7D%0A "
E({\tt dist}_i) = \beta_1 + \beta_2{\tt speed}_i + \beta_3 {\tt speed}_i^2
\qquad\qquad
{\tt dist_i} \sim \text{gamma}
")

Suppose that
![\\phi](https://latex.codecogs.com/png.latex?%5Cphi "\phi") is the
scale parameter of the gamma. Then the shape parameter of the gamma is
given by
![E({\\tt dist}\_i)/\\phi](https://latex.codecogs.com/png.latex?E%28%7B%5Ctt%20dist%7D_i%29%2F%5Cphi "E({\tt dist}_i)/\phi").

### Part 1

Write an R function to evaluate the log likelihood of this model. The
first argument of the function should be a parameter vector, `theta`
(![\\theta](https://latex.codecogs.com/png.latex?%5Ctheta "\theta")) the
next two arguments should be
![{\\tt speed}](https://latex.codecogs.com/png.latex?%7B%5Ctt%20speed%7D "{\tt speed}")
and
![{\\tt distance}](https://latex.codecogs.com/png.latex?%7B%5Ctt%20distance%7D "{\tt distance}")
vectors. To ensure that the
![\\beta\_j](https://latex.codecogs.com/png.latex?%5Cbeta_j "\beta_j")
and ![\\phi](https://latex.codecogs.com/png.latex?%5Cphi "\phi") remain
positive use the parameterization
![\\beta\_j = \\exp(\\theta\_j)](https://latex.codecogs.com/png.latex?%5Cbeta_j%20%3D%20%5Cexp%28%5Ctheta_j%29 "\beta_j = \exp(\theta_j)")
for
![j=1,2,3](https://latex.codecogs.com/png.latex?j%3D1%2C2%2C3 "j=1,2,3")
and
![\\phi = \\exp(\\theta\_4)](https://latex.codecogs.com/png.latex?%5Cphi%20%3D%20%5Cexp%28%5Ctheta_4%29 "\phi = \exp(\theta_4)").
Hint: a useful check of your log likelihood is that you get sensible
MLEs when a negative version is optimized using `optim` (this should not
be in your write up).

### Part 2

Further suppose that you have priors
![\\theta\_1 \\sim N(-1,1)](https://latex.codecogs.com/png.latex?%5Ctheta_1%20%5Csim%20N%28-1%2C1%29 "\theta_1 \sim N(-1,1)"),
![\\theta\_2 \\sim N(-.1,1)](https://latex.codecogs.com/png.latex?%5Ctheta_2%20%5Csim%20N%28-.1%2C1%29 "\theta_2 \sim N(-.1,1)")
and
![\\theta\_3 \\sim N(-1,1)](https://latex.codecogs.com/png.latex?%5Ctheta_3%20%5Csim%20N%28-1%2C1%29 "\theta_3 \sim N(-1,1)"),
but that an improper uniform prior is to be used for
![\\theta\_4](https://latex.codecogs.com/png.latex?%5Ctheta_4 "\theta_4").
Write an R function to evaluate the log prior probability density for a
vector `theta`.

### Part 3

Now write a function, `MHsample` for Metropolis Hastings sampling with a
random walk proposal, given (at least) the following arguments: an
initial parameter vector `theta`; a function `ll` evaluating the log
likelihood of the model parameters (extra arguments to `ll` should be
passed via the `...` argument to `MHsample`); a function `lp` evaluating
the log prior density of the model parameters; a vector `psd` of
standard deviations for each component of the random walk proposal; the
number of samples to generate, `ns`; optionally, `thin`, the number of
MH steps to take between each output of the state of the chain. The
function should be well commented, and should be included in your final
report.

`MHsample` should return a matrix of parameter vectors simulated from
the posterior for the model. It should print the acceptance rate of the
sampler before returning. The following are reasonable starting
parameters and random walk standard deviations.

``` r
th0 <- log(c(2, 1, 0.1, 4)) ## initial
psd <- c(0.2, 0.2, 0.1, 0.04)*1.5 ## proposal sd 
```

### Part 4

Use your function to simulate from the posterior distribution of the
model parameters. Use suitable plots to examine chain convergence and
mixing.

### Part 5

Write code to compare the model prior densities to the posterior
densities graphically, and comment on the results. Compute 95% credible
intervals for the three
![\\beta\_j](https://latex.codecogs.com/png.latex?%5Cbeta_j "\beta_j")
parameters.

### Part 6

Finally produce a plot illustrating the variability in the model fits,
by plotting `dist` versus `speed` for the raw data, and overlaying 100
approximately independent draws from the posterior distribution of the
curves of
![E({\\tt dist})](https://latex.codecogs.com/png.latex?E%28%7B%5Ctt%20dist%7D%29 "E({\tt dist})")
as a function of
![{\\tt speed}](https://latex.codecogs.com/png.latex?%7B%5Ctt%20speed%7D "{\tt speed}").

## Submission and Grading

This homework is due by *17:00 pm Friday, November 27th* UK local time.
You are to complete the assignment as a group and to keep everything
(code, write ups, etc.) on your team’s github repository (commit early
and often). All team members are expected to contribute equally to the
completion of this assignment and group assessments will be given at its
completion - anyone judged to not have sufficient contributed to the
final product will have their grade penalized. While different teams
members may have different coding backgrounds and abilities, it is the
responsibility of every team member to understand how and why all code
in the assignment works.

The final product for this assignment should be a single Rmd document,
`hw4.Rmd`, that contains all the code and text for the tasks described
above. The report should be readable by someone who has not seen this
homework description: so it should start with a brief description of the
cars data and the model being fitted, and a plot showing the model fit
(see `?predict.lm` for how to generate model predictions from a fitted
`lm` model object), to illustrate the problem with the standard linear
modeling constant variance assumption. The report should include clear
concise code, R output and plots, and text briefly explaining what is
being done and why, with brief conclusions where appropriate. It should
be structured with sensible sections and subsections. Don’t forget that
figure dimensions can be set in R markdown using e.g. `fig.dim=c(10,3)`
at the start of the R code block.

Note that we have provided a number of **Parts** to each Task within
this document - your report should *not* reference these parts
explicitly. They have been included purely to help guide you through the
assignment and do not provide guidance on how to organize your report.

The purpose of the document is to present the two alternative approaches
to inference about the model coefficients
![\\beta\_j](https://latex.codecogs.com/png.latex?%5Cbeta_j "\beta_j"),
in a way that shows the reader exactly how to undertake the analysis in
R, while also providing the general routine for simple random walk
Metropolis Hastings sampling.

Your document ***must*** knit. As a guide, a report knitted to pdf
should ideally be 6 pages or less in length, and certainly not much
longer.

<br/>
