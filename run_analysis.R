# This script will download the data and merge the train and test sets to create one data set. 
# Then it will extract only the mean and standard deviation measurement results and create
# a second, independent tidy data set with the average of each variable for each activity 
# and each subject.

library(downloader)

# Download/Input file related constants
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipFile <- "uci_har_dataset.zip"
path <- "UCI HAR Dataset"

# Down load the zip file and unzip them to the working directory
if (!file.exists(zipFile)) {
        download.file(url, zipFile, method="auto")
}
unzip(zipFile)

# Done with the zip file - delete
if (file.exists(zipFile)) {
        file.remove(zipFile)
}

# Activity and features files constants
activityFile <- file.path(getwd(), path, "activity_labels.txt")
featureFile <- file.path(getwd(), path, "features.txt")

# Read activity and features table and give appropriate column names
activity <- read.table(activityFile, header=FALSE)
names(activity) <- c("activityID", "activityName")
featureData <- read.table(featureFile, header=FALSE)
names(featureData) <-c("id", "value")

# Test set data paths
testSubFile <- file.path(getwd(), path, "test", "subject_test.txt")
testXFile <- file.path(getwd(), path, "test", "X_test.txt")
testYFile <- file.path(getwd(), path, "test", "y_test.txt")

# Read test set data for Subject, X and Y files
testSub <- read.table(testSubFile, header=FALSE)
names(testSub) <- c("subjectID")
testX <- read.table(testXFile, header=FALSE)
testY <- read.table(testYFile, header=FALSE)
names(testY) <- c("activityID")

# Train set data paths
trainSubFile <- file.path(getwd(), path, "train", "subject_train.txt")
trainXFile <- file.path(getwd(), path, "train", "X_train.txt")
trainYFile <- file.path(getwd(), path, "train", "y_train.txt")

# Read train set data for Subject, X and Y files
trainSub <- read.table(trainSubFile, header=FALSE)
names(trainSub) <- c("subjectID")
trainX <- read.table(trainXFile, header=FALSE)
trainY <- read.table(trainYFile, header=FALSE)
names(trainY) <- c("activityID")

# Use descriptive activity names to name the activities in train data set
trainY$id <- 1:nrow(trainY) # add index variable to keep track of the order
trainAct <- merge(trainY, activity, by = "activityID")
trainAct <- trainAct[order(trainAct$id),]
trainAct <- subset(trainAct, select = c("activityID","activityName"))

# Use descriptive activity names to name the activities in test data set
# Next two line of code achieves the same thing as the train set code above but 
# the following code uses factor function instead of merge 
testY$activityID <- factor(testY$activityID)
levels(testY$activityID) <- activity$activityName

# Merge the subject id and activity id into one 
newTestData <- cbind(testSub$subjectID, as.character(testY$activityID))
newTrainData <- cbind(trainSub$subjectID, as.character(trainAct$activityName))

# Clean up - unnecessary data tables
rm(activity)
rm(trainAct)
rm(trainY)
rm(trainSub)
rm(testY)
rm(testSub)

# Extracts only the measurements on the mean and standard deviation for each measurement. 
reqColumns = c(grep("-mean()", featureData$value), grep("-std()", featureData$value))
newTestData <- cbind(newTestData, testX[,reqColumns])
newTrainData <- cbind(newTrainData, trainX[,reqColumns])

# Merges the training and the test sets to create one data set.
newData <- rbind(newTestData, newTrainData)

# Appropriately labels the data set with descriptive variable names. 
names(newData) <- c("subjectID", "activity", as.character(featureData$value[reqColumns]))

# Creates a second, independent tidy data set with the average of each variable 
# for each activity and each subject.
finalData = aggregate(newData[3:68], by=list(subjectId=newData$subjectID, 
                                             activity=newData$activity), mean)

# Clean up
rm(newTestData)
rm(newTrainData)
rm(testX)
rm(trainX)
rm(featureData)
rm(newData)

# writing the second independent tidy data set as file
write.table(finalData, "new_subjective_activity_tidy.txt", row.names=FALSE)