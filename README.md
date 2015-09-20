# Getting-and-Cleaning-Data-Project
This repository contains the course project for Getting and Cleaning Data

run_analysis.R is R code that produces the tidy data file called TidyAverages.txt

run_analysis.R does the following:

#STEP 0: download needed files from url given in assignment which is a zip file containing a bunch of data files that need to be combined to produce our analysis. 

In general, we have training and testing data that we need to map participant and activity information to

#STEP 1: merge training and testing sets
read in the following 3 files of information for BOTH training AND testing datasets (6 total files):

--partipant data

--activity data

--measurement data

for each of the 3 above types of information, merge the training and testing data together, resulting in 3 total dataframes:

--participants

--activities

--measurementData

#STEP 2: extract mean and standard deviation measurements

we need to take a subset of the columns in our measurement data dataframe for mean and st dev columns we want to summarize

we read in the file containing labels for each column in our measurement dataframe

we use grep to find the positions in the measurement labels dataframe for strings containing mean and std, so we know which 
columns we want to subset from the measurements data

we extract the columns from our measurements data dataframe that correspond to the mean and st dev measurements we want to summarize

#STEP 3: use descriptive activity names to replace the numeric activities in the activities data set

we read in the file that contains descriptive names for the numeric activity mappings we've already loaded

we rename the numeric activities in the activities dataframe with the descriptive labels we've just read in

#STEP 4: combine our all the data together and assign meaningful labels to columns

we combine the participant, activity and measurement data dataframes together, but we need to assign useful column names

for the measurement data column names, we first subset the column label dataframe to get the labels for the subset of measurements we kept

we tidy up the names/labels in the spirit of this course

we combine these measurement column names with the column names for participant and activity give our combined dataframe useful column names

#STEP 5: form a tidy data set with the mean of each measurement corresponding to each participant and activity

reshape2 package makes this very easy for us

we form a long dataframe of our data from step 4 but with rows indexed by participant and activity

we use this long dataframe to calculate means for each measurement conditional on participant and activity

we write the tidy data to a text file called "TidyAverages.txt"
