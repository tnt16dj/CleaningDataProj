# README for run_analysis.r

Run_analysis.r is a script that takes a raw dataset of human activity recognition data, cleans and reshapes the data, and builds then outputs a tidy dataset (tidyData.txt) in "wide" form for use in futher analysis.  The program will download all relevant files from https://github.com/tnt16dj/CleaningDataProj and will ultimately create a folder in your R Working Directory called run_analysis_r that will house the raw dataset (UCI HAR Dataset) and the tidyData.txt tidy dataset.

## Raw Data

The raw data required for using run_analysis.r is stored in the UCI HAR Dataset folder in this repository.  The data was originally sourced from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.  

The dataset contains activity recognition data recorded via a smartphone collected by a group of 30 volunteers within an age bracket of 19-48 years each performing six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) while wearing a smartphone (Samsung Galaxy S II) on the waist.  Using the smartphones embedded accelerometer and gyroscope, data on 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz was collected.  The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The relevant files that will be used by run_analysis.r are:
* X_test.txt - raw measurement data from the "test" group in the experiment
* y_test.txt - raw activity data from the "test" group in the form of activity id numbers
* subject_test.txt - subject id data that associates a row of x and y test data to a subject
* X_train.txt - raw measurement data from the "train" group in the experiment
* y_train.txt - raw activity data from the "train" group in the form of activity id numbers
* subject_train.txt - subject id data that associates a row of x and y train data to a subject
* features.txt - contains column header data describing the raw data in X_test.txt and X_train.txt
* activity_labels.txt - activity labels (Walking, Laying, etc...) that relate to y_test.txt and y_train.txt

## run_analysis.r - using the script

Requirements:
1. ** The dplyr package is installed ** before running the script.  Use install.package("dplyr") to install
2. Set your working directory to the directory where you would like the raw and output data to reside.  Use setwd("your_path") at the R Terminal to set.