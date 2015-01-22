### README.MD

Getting and Cleaning Data Course Project
========================================


Overview
==============
This is Coursera ["Getting and Cleaning Data"](https://class.coursera.org/getdata-010) project, with repo containing README, CodeBook, one script named `run_analysis.R` and output file named `new_subjective_activity_tidy.txt`. 

The dataset from *Human Activity Recognition Using Smartphones Dataset (Version 1.0)* is used to get the average of each variable for each activity and each subject. This input dataset contains results from an experiment that have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, the result captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

Using this dataset, one R script called `run_analysis.R` was created. 
This script does the following: 

- Downloads the *Human Activity Recognition Using Smartphones Dataset (Version 1.0)* zip file and downloads the files to the current working directory.

- Uses descriptive activity names to name the activities in the data set

- Extracts only the measurements on the mean and standard deviation for each measurement. 

- Merges the training and the test sets to create one data set.

- Appropriately labels the data set with descriptive variable names. 

- From the data set in previous step, creates a second, independent tidy data set with the average of each variable for each activity and each subject, which is named new_subjective_activity_tidy.txt

Please check `CodeBook.md` for more details

Before you start
----------------
Please note, the input data will be downloaded under a folder named 'UCI HAR Dataset', under the root folder (your R working directory). 

If you do not know your work directory, find it in R by typing:
	getwd()
	
If needed, load the appropriate libraries & packages in R before running the script.
	library(data.table) 
	library(stats)
	library(downloader)

The script, run_analysis.R can be can be found in the same folder as this README file or to run it, you can clone this repo.

Usage : How to run 
==================
1. Clone this repo
2. Run the script:
```s
run_analysis.R
```


The output dataset includes the following file:
------------------------------------------------
`new_subjective_activity_tidy.txt`

The output file will be in the current working directory.


`new_subjective_activity_tidy.txt` provides:
---------------------------------------------------
- An identifier of the subject who carried out the experiment.
- Its activity label. 
- The average of each variable for each activity and each subject.


