# Coursera Getting and Cleaning Data Course Project
# 2016-01-30

# This script will take the output of a UCI Machine Learning Repository -- Human
# Activity Recognition Using Smartphones Data Set and prepare a tidy data set for further analysis.
# Per the assignment, this script will:
# Step 1. Merge training and test data sets to create one data set.
# Step 2. Extract measurements on the mean and standard deviation for each measurement. 
# Step 3. Use descriptive activity names to name the activities in the data set
# Step 4. Label the data set with appropriately descriptive column names. 
# Step 5. From this Creates an independent tidy data set with the average of each variable for 
#         each activity and each subject. 


#Step 1. Merge training and test data sets

# Clean up the workspace
rm(list=ls())
    
# Set directory to location of downloaded data set and related files
setwd("C:/Users/Lawrence/Documents/Getting-and-Cleaning-Data")
  
# Read in all files
activities = read.table('./UCI HAR Dataset/activity_labels.txt',header=FALSE) 
features = read.table('./UCI HAR Dataset/features.txt',header=FALSE) 

testData = read.table('./UCI HAR Dataset/test/x_test.txt')
testActivities = read.table('./UCI HAR Dataset/test/y_test.txt')
testSubjects = read.table('./UCI HAR Dataset/test/subject_test.txt',header=FALSE)
      
trainData = read.table('./UCI HAR Dataset/train/x_train.txt')
trainActivities = read.table('./UCI HAR Dataset/train/y_train.txt')    
trainSubjects = read.table('./UCI HAR Dataset/train/subject_train.txt',header=FALSE)
  
# Merge data sets
colnames(testData) = features[,2]
colnames(trainData) = features[,2]
test = cbind(testSubjects, testActivities, testData)
train = cbind(trainSubjects, trainActivities, trainData)
allData = rbind(test, train)

#Step 2. Extract measurements on the mean and standard deviation

colNames = colnames(allData)
targetColnums <- grep(".*V1.*|.*V2.*|.*mean.*|.*std.*", colNames)
subsetData <- allData[,targetColnums]
names(subsetData)[1]<-"subjectId"
names(subsetData)[2]<-"activityId"


# Step 3. Use descriptive activity names to name the activities in the data set

names(activities)[1]<-"activityId"
names(activities)[2]<-"activityType"
finalData = merge(subsetData, activities, by='activityId',all.x = TRUE)


# Step 4. Label the data set with appropriately descriptive variable names

colNames = colnames(finalData)
newColnames = gsub('-std', 'Std', colNames) #Capitalize leading character
newColnames = gsub('-mean', 'Mean', newColnames) #Capitalize leading character
newColnames = gsub('[-()]','', newColnames) #Get rid of extra characters
newColnames = gsub('[-()]','', newColnames) 
names(finalData)<-newColnames

# Step 5. Creates an independent tidy data set with the average of each variable  
library(reshape2)
dataMelt<-melt(finalData, id=c("activityId", "subjectId", "activityType"))
dataMean<-dcast(dataMelt,subjectId + activityType ~ variable,mean)
write.table(dataMean, "tidy.txt", row.names = FALSE, quote = FALSE)