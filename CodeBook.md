	
###CODE BOOK

This code book describes the data in `run_analysis.R`.

High-level breakdown:
====================

- Variables and Constants

- Download input files

- Read data sets

- Uses descriptive activity names to name the activities in the data set

- Extracts only the measurements on the mean and standard deviation for each measurement

- Merge multiple data sets

- Labels the data set with descriptive variable names

- Get the average of each variable for each activity and each subject

- Write to TXT file

- Clean up code

*The description can be also understood and followed using the comments within the code.*

Variables and Constants 
------------------------
All the file paths and file names were saved with appropriate variable names:

- url : input zip file paths
- zipFile : name of the zip file to download
- path : unzipped folder name
- activityFile : path to activity_labels.txt
- dataFile : path to features.txt
- testSubFile : path to subject_test.txt
- testXFile : path to X_test.txt
- testYFile : path to y_test.txt
- trainSubFile : path to subject_train.txt
- trainXFile : path to X_train.txt
- trainYFile : path to y_train.txt

*Others explained below*

Download input files
------------------------
- Downloads the zip file if it doesn't exist. Since this is running in Windows, method is set to auto.
- unzip the file to the default working directory
- clean up and delete the downloaded *.zip file from the current directory

Read data sets
------------------------
- Read activity_labels, features, as well as subject_, X_ and y_ files for both test and train sets into activity, dataFile, testSubFile, testXfile, testYfile, trainSub, trainXfile, and trainYfile.
- None of the input files had defined header names, so for activity table, set the column names to be *activityID*, *activityName*
- For features table, which contains feature id and its value, name the columns *id*, *value*
- Similarly with subject_test and subject_train data, add column name *subjectID*
- Set testYFile and trainYFile columns to be *activityID*
- testX and trainX as well as featuresData will not have a column name set since these are result data and list of all features. 

Uses descriptive activity names to name the activities in the data set
------------------------------------------------------------------------
In this section of the code, two different functions were used to achieve the same thing.
For train data set, merge function was used to join activity ID from trainY with activity name from activity table, by using activeID. In order to keep the order, which will be lost when using merge function, index variable was added so that after the merge, they can be re-ordered to be the original ordering of rows.
For test data set, factor function was used to associate the activity name using levels.
Then for both, used cbind to put the two columns together. The activityID value was saved as the descriptive name.
Two different methods were used but result of getting the descriptive activity names were the same.

Extracts only the measurements on the mean and standard deviation for each measurement
----------------------------------------------------------------------------------------
- Identify the mean and std columns using grep function, on featureData value column. Save the identified list of rows as reqColumns.
- Use cbind to put the subjectiveID, activity, and testX result for only the columns in reqColumns. Put the result set in newTestData and newTrainData.

Merge multiple data sets   
------------------------
- Use rbind to have each rows of newTestData and newTrainData tables combined.
- Store the new set into newData

Labels the data set with descriptive variable names
----------------------------------------------------
Since the newData set doesn't have the column names defined, set it as *subjectID*, *activity* and the feature column names defined in featureData table.

Get the average of each variable for each activity and each subject
------------------------------------------------------------------------
- Use aggregate function from stats library to get the mean of all the results which are found in column 3-68
- Store the new set into finalData
Here is part of the finalData table:
```S
	> head(finalData[,1:6], n=5)
	  subjectId activity tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z tGravityAcc-mean()-X
	1        10   LAYING         0.2802306       -0.02429448        -0.1171686           -0.4530697
	2        12   LAYING         0.2601134       -0.01752039        -0.1081601           -0.3785921
	3        13   LAYING         0.2767164       -0.02044045        -0.1043319           -0.1568522
	4        18   LAYING         0.2746916       -0.01739377        -0.1076989           -0.2206005
	5         2   LAYING         0.2813734       -0.01815874        -0.1072456           -0.5097542
```

Write to TXT file
-----------------
- Use write.table to set the output file name as `new_subjective_activity_tidy.txt` and don't get the row names.

Clean up code
--------------
Through out the code, when the data table was no longer needed, they were removed. This was called twice in the code. Once after the merging of subject ID information and activity description, and another called right before writing the new tidy data into a file. 
