Getting and Cleaning Data Course Project CodeBook
=================================================
This file describes the variables, the data, and any transformations or work that I have performed to clean up the data.  

The data for the project can be found at :  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
* The run_analysis.R script performs the following steps to clean the data:   
 1. Read X_train.txt, y_train.txt and subject_train.txt from the "train" folder and store them in *trainData*, *trainLabel* and *trainSubject* variables respectively.       
 2. Similarly as above it reads X_test.txt, y_test.txt and subject_test.txt from the "test" folder and store them in *testData*, *testLabel* and *testsubject* variables respectively.  
 3. Concatenate *testData* to *trainData* to generate a  data frame, *combinedData*; concatenate *testLabel* to *trainLabel* to generate a  data frame, *combinedLabel*; concatenate *testSubject* to *trainSubject* to generate a  data frame, *combinedSubject*.  
 4. Read the features.txt file store the data in a variable called *features*. We only extract the measurements on the mean and standard deviation. 
 5. Clean the column names of the subset. We remove the "()" and "-" symbols in the names.
 6. Read the activity_labels.txt file and store the data in a variable called *activity*.  
 7. Clean the activity names in the second column of *activity*. We first make all names to lower cases. If the name has an underscore between letters, we remove the underscore and capitalize the letter immediately after the underscore. This is done using the gsub(), toupper()  and substr() functions.
 8. Transform the values of *combinedLabel* according to the *activity* data frame.  
 9. Combine the *combinedSubject*, *combinedLabel* and *combinedData* by column to get a new cleaned data frame, *cleanedData*. Properly name the first two columns, "Subject" and "Activity". The "Subject" column contains integers that range from 1 to 30; the "activity" column contains 6 kinds of activity names; the remaining columns contain data which ranges from -1 to 1 based on the measurements.  
 11. The script then creates an independent tidy data set with the average of each measurement for each activity and each subject. Then, for each combination, we calculate the mean of each measurement with the corresponding combination. So, after initializing the *result* data frame and performing the two loops, we get a data frame.
 12. Write the *result* out to "tidy_dataSet.txt" file in current working directory. 