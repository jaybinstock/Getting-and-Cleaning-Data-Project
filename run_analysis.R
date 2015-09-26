setwd("C://Users//jay//Documents//R//Getting & Cleaning Data Course//Project")

library(reshape2)

##STEP 0: download needed files from url given in assignment
filename = "projectDataset.zip" #filename to save in folder

#download and unzip the dataset if not already present
if (!file.exists(filename)){
     fileURL = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 
     download.file(fileURL, filename)
}  
if (!file.exists("UCI HAR Dataset")) { 
     unzip(filename) 
}


##STEP 1: merge training and testing sets

#read in training data
trainingParticipants = read.table("UCI HAR Dataset/train/subject_train.txt") #the participant the row of data corresponds to
trainingActivities = read.table("UCI HAR Dataset/train/Y_train.txt") #the activity the row of data corresponds to
trainingMeasurementData = read.table("UCI HAR Dataset/train/X_train.txt") #the training data itself

#read in testing data
testingParticipants = read.table("UCI HAR Dataset/test/subject_test.txt") #the participant the row of data corresponds to
testingActivities = read.table("UCI HAR Dataset/test/Y_test.txt") #the activity the row of data corresponds to
testingMeasurementData = read.table("UCI HAR Dataset/test/X_test.txt") #the testing data itself

#combine training and testing data
participants = rbind(trainingParticipants, testingParticipants)
activities = rbind(trainingActivities, testingActivities)
measurementData = rbind(trainingMeasurementData, testingMeasurementData)


##STEP 2: extract mean and standard deviation measurements

#read in measurements/features
measurementLabels = read.table("UCI HAR Dataset/features.txt")
measurementLabels[ , 2] = as.character(measurementsLabels[ , 2])

#extract mean and standard deviation measurements from features
measurementLabelsSubset = grep(".*mean.*|.*std.*", measurementLabels[,2])  #get row numbers of features that are mean or st dev from features table

#subset data for mean and st dev
measurementDataSubset = measurementData[ , measurementLabelsSubset]


##STEP 3: use descriptive activity names to replace the numeric activities in the data set

#read in activity labels 
activityLabels = read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[ , 2] = as.character(activityLabels[,2])

#rename the numeric activities in the activity datatable with descriptive names
activities[ , 1] = activityLabels[activities[ , 1], 2]


##STEP 4: combine measurement data with the participant and activity mappings and assign meaningful labels to columns

#combine our mean and st dev measurements data with the participant and activity data tables
dataCombined = cbind(participants, activities, measurementDataSubset)

#get the labels for the features we kept
measurementColNames = measurementLabels[measurementLabelsSubset,2]   

#tidy up labels for use as column names
measurementcolNames = gsub('-mean', 'Mean', measurementColNames)
measurementColNames = gsub('-std', 'StDev', measurementColNames)
measurementColNames = gsub('[-()]', '', measurementColNames)

columnLabels = c("participant", "activity", measurementColNames)

colnames(dataCombined) = columnLabels

##STEP 5: form a tidy data set with the mean of each measurement corresponding to each participant and activity

#melt data, indexing on participant and activity to calculate conditional averages on
dataCombinedLong = melt(dataCombined, id = c("participant", "activity"))

#calculate average of each variable for each activity and each participant
dataCombinedMean = dcast(dataCombinedLong, participant + activity ~ variable, mean)

#output the TIDY data to txt file
write.table(dataCombinedMean, "TidyAverages.txt", row.names = FALSE)





