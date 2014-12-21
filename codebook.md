# Codebook for run_analysis.r

Run_analysis.r is a script that takes a raw dataset of human activity recognition data, cleans and reshapes the data, and builds and outputs a tidy dataset (tidyData.txt) in "wide" form for use in futher analysis.

## run_analysis.r - tasks/transformations

1. Check if run_analysis_r directory exists inside the current working directory then:
  1. If no, create run_analysis_r directory.
  2. If yes, do nothing.
2. Set the working directory to run_analysis_r.  All data, raw and final, will reside here.
3. Check if UCI HAR Dataset directory exists inside the run_analysis_r working directory then:
  1. If no, create UCI HAR Dataset directory.
  2. If yes, do nothing...
4. Download the following raw data files (from https://github.com/tnt16dj/CleaningDataProj) into the UCI HAR Dataset subdirectory:
  1. X_test.txt
  2. y_test.txt
  3. subject_test.txt
  4. X_train.txt
  5. y_train.txt
  6. subject_train.txt
  7. features.txt
  8. activity_labels.txt
  9. README.txt
  10. features_info.txt
5. Read all "test" data into memory: 
  1. X_test.txt is read into testData data.frame - represents all recorded data records
  2. y_test.txt is read into testLabels data.frame - represents the activity that generated each record
  3. subject_test.txt is read into testSubjects data.frame - represents the subject who generated the data
6. Read all "train" data into memory: 
  1. X_train.txt is read into trainData data.frame - represents all recorded data records
  2. y_train.txt is read into trainLabels data.frame - represents the activity that generated each record
  3. subject_train.txt is read into trainSubjects data.frame - represents the subject who generated the data
7. Read features.txt data into columnHeaders data.frame - represents column headers for all data observations
8. Using the columnHeaders data.frame apply colNames to testData and trainData.
9. Create a set of indices for all 'mean' and 'std' related columns by subsetting columnHeaders data.frame using grep into targetColumns.
10. Subset testData and trainData by applying the targetColumns indices against the data.frames.
11. Apply column headers to the following:
  1. testLabels and trainLabels apply "Activity_ID" as the column header to facilitate later data merging.
  2. testSubjects and trainSubjects apply "Subject" as the column header.
12. CBind testData, testLabels, and testSubjects into a single data.frame, testData.
13. CBind trainData, trainLabels, and trainSubjects into a single data.frame, trainData.
14. Create a mergeData dataset by using RBind passing in testData and trainData.
15. Read activity_labels.txt data into activityLabels.  The data represents the activities for which data was gathered.
16. Apply colNames to activityLabels to facilitate later merges by adding "Activity_ID" and "Activity" column headers.
17. Merge activityLabels data.frame with mergeData data.frame by "Activity_ID".  This adds meaningful activity labels to the combined data set.
18. Load package dplyr into the environment.
19. Apply dplyr's summarise_each function to mergeData applying the mean to all columns grouped by Subject and Activity_ID.  The resulting data is stored in a new tidyData data.frame.
20. Subset the tidyData data.frame to exclude "Activity_ID" using dplyr's select function.
21. Write the finalize tidyData data.frame to a tidyData.txt file in the working directory.
22. Free up memory of all obsolete objects.
23. Read the tidyData.txt file into R for further analysis by the end user.  Enjoy!

## run_analysis.r - final output

tidyData.txt contains all columns pertaining to mean or standard deviation measurements as per the requirements of the course project.  Each column in the tidyData dataset represents a different measurement that was observed.  Each measurement is grouped by the Subject that generated the measurement and the Activity the Subject was performing during the measurement (i.e. Laying, Walking, etc...).  All of the measurment columns represent the average (mean) of all observations of the given measurement (i.e. tBodyAcc.mean(), etc...) for the given Subject and Activity.