# Getting-and-Cleaning-Data-Course-Project
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set.

A full description is available at the site where the data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Project
You should create one R script called run_analysis.R that does the following:
*	Merges the training and the test sets to create one data set.
*	Extracts only the measurements on the mean and standard deviation for each measurement.
*	Uses descriptive activity names to name the activities in the data set.
*	Appropriately labels the data set with descriptive variable names.
*	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


## Execution
* Download and extract data source to local drive (folder: UCI HAR Dataset)
* Set working directory as UCI HAR Dataset in R. 
* Run run_analysis.R, which will generate two new files (cleandata1.txt and cleandata2.txt) in working directory. 

## Dependencies
*	run_analysis.R will install two packages automaticall; dplyr and reshape2. 


