#CodeBook

Data description
Accelerometer readings were carried out with a group of 30 volunteers aged 19-48 years. Each person performed six activities - WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING, wearing a smartphone (Samsung Galaxy S II) on their waist. 

Using accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity readings are captured. 
The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the 
training data and 30% the test data. 

A full description of the project is here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
The data for the project are here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Data files used
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

Intermediate files
- allData : merges the training set and test set to created single data set, adding training labels and test subject label
- subsetData : removes training set columns that are not means or standard deviations (labels do not have 'std' or 'mean' in the name
- finalData : adds an additional column with labels (WALKING, WALKING_UPSTAIRS, ...) corresponding to the codes for activity name (1, 2, ...) and cleans up the column labels by removing extraneous characters
- dataMelt : data in normalized form – single column with values, 3 descriptor columns
- dataMean : Recast to show mean activity value by subject and activity type

Final output
‘- tidy.txt : dataMean in text file format in active directory
