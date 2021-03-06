What's that all about...
========================================================

TL;DR
--------------------------------------------------------
In this page, you will be introduced with the solution proposed for 
the first (and only?) peer assessment of the Coursera's course: [Getting and Cleaning Data](https://class.coursera.org/getdata-002) (second take).

This documentation will be brief but yet divided in two folds, being:

1. a review of the code and an explaination on how to run check the results
2. a code book of the last point (create a tidy dataset of all variables average per subject and activity).


Code: what's in and how to use it
--------------------------------------------------------
The code is pretty (IMHO) straighforward but introduce small peculiarities.
Two helper functions:
* `get.or.compute` is there to limit the amount of computations. This function checks if a variable is already present in the current environment, if not it will be created with the result of a given expression -- it was handy when debugging everything in a single file.
* `rm.rf` is a shortcut for `rm(list=ls())` and was introduce to clean the workspace with less typing -- I'm very lazy _:-D_.

That means that all intermediary results will be computed only once, unless `rm` is called on it.

Regarding the logic it self, it merely follows the list of 5 points that the assessment required us to answer.

So each point is reached in a sequence of one or more steps which ends in a dedicated variable holding the result for it. This variable name is printed to the console like this for the first result: `print("The result of #1 is data.full")`, so by running the code, the `data.full` variable can be inspected easily from the console (f.i. `str(data.full)`).

Which leads to the question, _how the hell could I run it, then_. 
The easiest way to execute it is to stream the script in R, `R < run_analysis.R`.

The script should be standalone, which means that required packages are checked and installed if needed. So the pane to select the installation server might be requiring an action from you.

The important thing to know is also that a rather big ZIP file will be downloaded from the internet with all the data and doc in it. This ZIP file will be put the `data` folder and extracted in `data/expanded`.
These files were excluded from the github repo to reduce its weight (mostly for who won't run it...).

Code book generated for the 5th point
--------------------------------------------------------
### Features


### Choices

