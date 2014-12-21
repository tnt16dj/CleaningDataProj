## set the file url to the x_test dataset path
fileurl <- "./UCI HAR Dataset/test/X_test.txt"
## read in X_test.txt - i.e. read in test data
testData <- read.table(fileurl,stringsAsFactors=FALSE)


## reset file url to the y_test dataset path
fileurl <- "./UCI HAR Dataset/test/y_test.txt"
## read in y_test.txt - i.e. read in the activity label numbers
testLabels <- read.table(fileurl,stringsAsFactors=FALSE)


## reset file url to the subject_test dataset path
fileurl <- "./UCI HAR Dataset/test/subject_test.txt"
## read in subject_test.txt - i.e. read in the subject for each record in testData
testSubjects <- read.table(fileurl,stringsAsFactors=FALSE)


## repeat above for train data
fileurl <- "./UCI HAR Dataset/train/X_train.txt"
trainData <- read.table(fileurl,stringsAsFactors=FALSE)

fileurl <- "./UCI HAR Dataset/train/y_train.txt"
trainLabels <- read.table(fileurl,stringsAsFactors=FALSE)

fileurl <- "./UCI HAR Dataset/train/subject_train.txt"
trainSubjects <- read.table(fileurl,stringsAsFactors=FALSE)


## load column header names into memory - i.e. load features.txt
fileurl <- "./UCI HAR Dataset/features.txt"
columnHeaders <- read.table(fileurl,stringsAsFactors=FALSE)


## apply the column header names to testData and trainData
colnames(testData) <- columnHeaders[,2]
colnames(trainData) <- columnHeaders[,2]


## subset only those columns related to mean or std...
targetColumns <- grep("mean()|std()", columnHeaders[, 2])
## apply the targetColumns to the testData and trainData set to arrive a desired subset
testData <- testData[,targetColumns]
trainData <- trainData[,targetColumns]
## free up memory by purging columnHeaders and targetColumns
rm(columnHeaders,targetColumns)


## apply column names to the testLabels, testSubjects, trainLabels, trainSubjects data frames
colnames(testLabels) <- "Activity_ID"
colnames(testSubjects) <- "Subject"

colnames(trainLabels) <- "Activity_ID"
colnames(trainSubjects) <- "Subject"


## merge testLabels and testSubjects to testData
testData <- cbind(testData,testLabels,testSubjects)
## free up memory by removing testLabels & testSubjects
rm(testLabels,testSubjects)


## merge trainLabels and trainSubjects to trainData
trainData <- cbind(trainData,trainLabels,trainSubjects)
## free up memory by removing trainLabels and trainSubjects
rm(trainLabels,trainSubjects)


## merge the two datasets together using rbind
mergeData <- rbind(testData,trainData)


## free up memory by removing testData & trainData
rm(testData,trainData)


## load in the activity labels from activity_labels.txt
fileurl <- "./UCI HAR Dataset/activity_labels.txt"
activityLabels <- read.table(fileurl,stringsAsFactors=FALSE)


## apply column headers to activityLabels to facilitate later joins
colnames(activityLabels) <- c("Activity_ID","Activity")
## merge activity names into mergeData
mergeData <- merge(mergeData,activityLabels,by="Activity_ID")
## free up memory by removing activityLabels and fileurl
rm(activityLabels,fileurl)


## load dplyr library for use of summarise_each
library(dplyr)


## create final tidyData dataset giving means of all columns grouped by Subject and Activity
tidyData <- summarise_each(group_by(mergeData, Subject, Activity), funs(mean))
tidyData <- select(tidyData,-Activity_ID)


## write out the tidyData dataset
write.table(tidyData,file="tidyData.txt")


## free up memory by removing mergeData & tidyData
rm(mergeData,tidyData)


## load the tidyData.txt file into memory for user review
fileurl <- "./tidydata.txt"
tidyData <- read.table(fileurl,stringsAsFactors=FALSE)