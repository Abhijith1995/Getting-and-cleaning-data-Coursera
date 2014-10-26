Getting-and-cleaning-data-Coursera
==================================

Final course project for the getting and cleaning data class on Coursera, Oct 2014. 

This file describes how run_analysis.R script works.

First, unzip the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and rename the folder with "data".

Second, use source("run_analysis.R") command in RStudio.Then type runAnalysis() to execute the script.
Third, a file called tidy_dataSet.txt is outputted by the script. It has a data frame called result with 180*68 dimension. This is the file required by the assignment.

Finally, use data <- read.table("tidy_dataSet.txt") command in RStudio to read the file. Since we are required to get the average of each variable for each activity and each subject, and there are 6 activities and 30 subjects in total. THus we have 180 rows with all combinations for each of the 66 features.