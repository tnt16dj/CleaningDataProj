## check if run_analysis.r output directory exists:
if (!file.exists("./run_analysis_r")) {
        dir.create("./run_analysis_r")
}


## set working directory to run_analysis_r
setwd("./run_analysis_r")


## create UCI HAR Dataset subdirectory...
if (!file.exists("./UCI HAR Dataset")) {
        dir.create("./UCI HAR Dataset")
}


## download the UCI HAR Dataset files into UCI HAR Dataset folder
## Test Data:
fileurl <- "https://raw.githubusercontent.com/tnt16dj/CleaningDataProj/master/UCI%20HAR%20Dataset/test/X_test.txt"
print("Downloading X_test.txt ...")
download.file(fileurl, destfile = "./UCI HAR Dataset/X_test.txt", method = "curl")
fileurl <- "https://raw.githubusercontent.com/tnt16dj/CleaningDataProj/master/UCI%20HAR%20Dataset/test/y_test.txt"
print("Downloading y_test.txt ...")
download.file(fileurl, destfile = "./UCI HAR Dataset/y_test.txt", method = "curl")
fileurl <- "https://raw.githubusercontent.com/tnt16dj/CleaningDataProj/master/UCI%20HAR%20Dataset/test/subject_test.txt"
print("Downloading subject_test.txt ...")
download.file(fileurl, destfile = "./UCI HAR Dataset/subject_test.txt", method = "curl")

## Train Data:
fileurl <- "https://raw.githubusercontent.com/tnt16dj/CleaningDataProj/master/UCI%20HAR%20Dataset/train/X_train.txt"
print("Downloading X_train.txt ...")
download.file(fileurl, destfile = "./UCI HAR Dataset/X_train.txt", method = "curl")
fileurl <- "https://raw.githubusercontent.com/tnt16dj/CleaningDataProj/master/UCI%20HAR%20Dataset/train/y_train.txt"
print("Downloading y_train.txt ...")
download.file(fileurl, destfile = "./UCI HAR Dataset/y_train.txt", method = "curl")
fileurl <- "https://raw.githubusercontent.com/tnt16dj/CleaningDataProj/master/UCI%20HAR%20Dataset/train/subject_train.txt"
print("Downloading subject_train.txt ...")
download.file(fileurl, destfile = "./UCI HAR Dataset/subject_train.txt", method = "curl")

## Supporting Data:
fileurl <- "https://raw.githubusercontent.com/tnt16dj/CleaningDataProj/master/UCI%20HAR%20Dataset/features.txt"
print("Downloading features.txt ...")
download.file(fileurl, destfile = "./UCI HAR Dataset/features.txt", method = "curl")
fileurl <- "https://raw.githubusercontent.com/tnt16dj/CleaningDataProj/master/UCI%20HAR%20Dataset/activity_labels.txt"
print("Downloading activity_labels.txt ...")
download.file(fileurl, destfile = "./UCI HAR Dataset/activity_labels.txt", method = "curl")
fileurl <- "https://raw.githubusercontent.com/tnt16dj/CleaningDataProj/master/UCI%20HAR%20Dataset/README.txt"
print("Downloading README.txt ...")
download.file(fileurl, destfile = "./UCI HAR Dataset/README.txt", method = "curl")
fileurl <- "https://raw.githubusercontent.com/tnt16dj/CleaningDataProj/master/UCI%20HAR%20Dataset/features_info.txt"
print("Downloading features_info.txt ...")
download.file(fileurl, destfile = "./UCI HAR Dataset/features_info.txt", method = "curl")


## set the file url to the x_test dataset path
fileurl <- "./UCI HAR Dataset/X_test.txt"
## read in X_test.txt - i.e. read in test data
print("Reading X_test.txt into memory...")
testData <- read.table(fileurl,stringsAsFactors=FALSE)
## reset file url to the y_test dataset path
fileurl <- "./UCI HAR Dataset/y_test.txt"
## read in y_test.txt - i.e. read in the activity label numbers
print("Reading y_test.txt into memory...")
testLabels <- read.table(fileurl,stringsAsFactors=FALSE)
## reset file url to the subject_test dataset path
fileurl <- "./UCI HAR Dataset/subject_test.txt"
## read in subject_test.txt - i.e. read in the subject for each record in testData
print("Reading subject_test.txt into memory...")
testSubjects <- read.table(fileurl,stringsAsFactors=FALSE)


## repeat above for train data
fileurl <- "./UCI HAR Dataset/X_train.txt"
print("Reading X_train.txt into memory...")
trainData <- read.table(fileurl,stringsAsFactors=FALSE)
fileurl <- "./UCI HAR Dataset/y_train.txt"
print("Reading y_train.txt into memory...")
trainLabels <- read.table(fileurl,stringsAsFactors=FALSE)
fileurl <- "./UCI HAR Dataset/subject_train.txt"
print("Reading subject_train.txt into memory...")
trainSubjects <- read.table(fileurl,stringsAsFactors=FALSE)


## load column header names into memory - i.e. load features.txt
fileurl <- "./UCI HAR Dataset/features.txt"
print("Reading features.txt into memory...")
columnHeaders <- read.table(fileurl,stringsAsFactors=FALSE)


## apply the column header names to testData and trainData
print("Applying column headers to test data...")
colnames(testData) <- columnHeaders[,2]
print("Applying column headers to train data...")
colnames(trainData) <- columnHeaders[,2]


## subset only those columns related to mean or std...
print("Subsetting all mean and std related columns...")
targetColumns <- grep("mean()|std()", columnHeaders[, 2])
## apply the targetColumns to the testData and trainData set to arrive a desired subset
print("Applying mean/std subset to test data...")
testData <- testData[,targetColumns]
print("Applying mean/std subset to train data...")
trainData <- trainData[,targetColumns]
## free up memory by purging columnHeaders and targetColumns
print("Freeing up memory of obsolete objects...")
rm(columnHeaders,targetColumns)


## apply column names to the testLabels, testSubjects, trainLabels, trainSubjects data frames
print("Applying column headers to y_test.txt and subject_test.txt datasets")
colnames(testLabels) <- "Activity_ID"
colnames(testSubjects) <- "Subject"
print("Applying column headers to y_train.txt and subject_train.txt datasets")
colnames(trainLabels) <- "Activity_ID"
colnames(trainSubjects) <- "Subject"


## merge testLabels and testSubjects to testData
print("Building complete test data - merging X_test.txt, y_test.txt, and subject_test.txt...")
testData <- cbind(testData,testLabels,testSubjects)
## merge trainLabels and trainSubjects to trainData
print("Building complete train data - merging X_train.txt, y_train.txt, and subject_train.txt...")
trainData <- cbind(trainData,trainLabels,trainSubjects)
## free up memory by removing trainLabels and trainSubjects
print("Freeing up memory of obsolete objects...")
rm(testLabels,testSubjects,trainLabels,trainSubjects)


## merge the two datasets together using rbind
print("Building complete test/train dataset - merging test data with train data...")
mergeData <- rbind(testData,trainData)


## free up memory by removing testData & trainData
print("Freeing up memory of obsolete objects...")
rm(testData,trainData)


## load in the activity labels from activity_labels.txt
fileurl <- "./UCI HAR Dataset/activity_labels.txt"
print("Reading activity label data into memory...")
activityLabels <- read.table(fileurl,stringsAsFactors=FALSE)


## apply column headers to activityLabels to facilitate later joins
print("Applying column headers to the activity label data...")
colnames(activityLabels) <- c("Activity_ID","Activity")
## merge activity names into mergeData
print("Merging activity label data with test/train data over Activity_ID...")
mergeData <- merge(mergeData,activityLabels,by="Activity_ID")
## free up memory by removing activityLabels and fileurl
print("Freeing up memory of obsolete objects...")
rm(activityLabels,fileurl)


## load dplyr library for use of summarise_each
print("Loading the dplyr package for use in summarizing the dataset...")
library(dplyr)


## create final tidyData dataset giving means of all columns grouped by Subject and Activity
print("Summarizing the dataset by applying mean over all columns grouped by Subject and Activity...")
tidyData <- summarise_each(group_by(mergeData, Subject, Activity), funs(mean))
tidyData <- select(tidyData,-Activity_ID)


## write out the tidyData dataset
print("Writing the tidyData dataset to memory...")
write.table(tidyData,file="tidyData.txt")


## free up memory by removing mergeData & tidyData
print("Freeing up memory of obsolete objects...")
rm(mergeData,tidyData)


## load the tidyData.txt file into memory for user review
print("Loading the completed 'tidy' dataset tidyData.txt into memory for further analysis...")
fileurl <- "./tidydata.txt"
tidyData <- read.table(fileurl,stringsAsFactors=FALSE)


## set working back to starting point
setwd("../")
print("Program complete.  Enjoy using the tidyData dataset.")