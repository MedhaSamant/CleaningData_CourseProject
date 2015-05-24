# CleaningData_CourseProject
Course project for "getting and cleaning data" course

==================================================================
This repo contains R code and associated information to get mean data 
from the accelerometer and gyroscope 3-axial for 30 people over 
6 different activities.
==================================================================

The experiments have been carried out with a group of 30 volunteers 
within an age bracket of 19-48 years. Each person performed six 
activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, 
STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist.

The project directory includes  following files:
=========================================

- 'README.MD' 

- 'codeBook.txt': Code book containing information about variables used in the tody dataset.

- 'run_analysis.R': R code that acts on the original data to create the tidy data set.

Details of R code 'run_analysis.R'
=========================================
The steps carried out to create the tidy data set are as follows:

Step 1- Merge Train (X_train.txt) & Test (X_test.txt) data for all the 30 individuals using rbind operation

Step 2 - Merge Train (y_train.txt) & Test (y_test.txt) labels for all the 30 individuals using rbind operation

Step 3 - Merge labels data created in Step 2 with data from step 1 using cbind operation

Step 4 - Merge all 30 subjects (subject_train.txt and subject_test.txt) using rbind operation

Step 5 - Combine subjects data fromStep 4 to the merged data of labels and test data using cobind operation

Step 6 - Extract only the columns from the data in step 5 that are related to the mean and standard deviation for each measurement

Step 7 - Add appropriate column names to the data created in step 6

Step 8 - Convert entries in the "labels" column to include the appropriate activity name (e.g. WALKING for 1)

Step 9 - Using ddply function create a tidy data set from data in step 8 which will calculate mean for all the columns per subject per activity

Step 10 - Write the data created in Step 9 to "outTable.txt" file using wrie.table function