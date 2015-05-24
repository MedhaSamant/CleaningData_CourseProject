library(plyr)
require(plyr)

##Merge Train & Test data
xTrain <- read.table("UCI HAR Dataset/train/X_train.txt")
xTest <-  read.table("UCI HAR Dataset/test/X_test.txt")
mergeData <- rbind(xTrain, xTest)

##Merge Train & Test labels
yTrain<- read.table("UCI HAR Dataset/train/y_train.txt")
yTest <-  read.table("UCI HAR Dataset/test/y_test.txt")
mergeLabels<-rbind(yTrain,yTest)

##Merge labels + data
mergeSet <-cbind(mergeLabels, mergeData)

##Merge Train & Test data subject
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
subjectTest <-  read.table("UCI HAR Dataset/test/subject_test.txt")
mergeSubjects<-rbind(subjectTrain, subjectTest)

##Merge subjects, labels and data
mergedData <-cbind(mergeSubjects, mergeSet)

##Extracts only the measurements on the mean and standard deviation for each measurement. 
newSet<-subset(mergedData, select = c(1,2,3,4,5,6,7,8,43,44,45,46,47,48,83,84,85,86,87,88,123,124,125,126,127,128,
                                    163,164,165,166,167,168,203,204,216,217,229,230,
                                    242,243,255,256,268,269,270,271,272,273,347,348,349,350,351,352,
                                    426,427,428,429,430,431,505,506,518,519,531,532,544,545))


##Provide aapropriate column names
cnames<-c("subject", "activity",
          "tBodyAcc-mean-X","tBodyAcc-mean-Y", "tBodyAcc-mean-Z","tBodyAcc-std-X","tBodyAcc-std-Y","tBodyAcc-std-Z",
          "tGravityAcc-mean-X","tGravityAcc-mean-Y","tGravityAcc-mean-Z","tGravityAcc-std-X","tGravityAcc-std-Y","tGravityAcc-std-Z",
          "tBodyAccJerk-mean-X","tBodyAccJerk-mean-Y","tBodyAccJerk-mean-Z","tBodyAccJerk-std-X","tBodyAccJerk-std-Y","tBodyAccJerk-std-Z",
          "tBodyGyro-mean-X","tBodyGyro-mean-Y","tBodyGyro-mean-Z","tBodyGyro-std-X","tBodyGyro-std-Y","tBodyGyro-std-Z",
          "tBodyGyroJerk-mean-X","tBodyGyroJerk-mean-Y","tBodyGyroJerk-mean-Z","tBodyGyroJerk-std-X","tBodyGyroJerk-std-Y","tBodyGyroJerk-std-Z",
          "tBodyAccMag-mean","tBodyAccMag-std","tGravityAccMag-mean","tGravityAccMag-std","tBodyAccJerkMag-mean","tBodyAccJerkMag-std",
          "tBodyGyroMag-mean","tBodyGyroMag-std", "tBodyGyroJerkMag-mean","tBodyGyroJerkMag-std", 
          "fBodyAcc-mean-X","fBodyAcc-mean-Y","fBodyAcc-mean-Z","fBodyAcc-std-X","fBodyAcc-std-Y","fBodyAcc-std-Z",
          "fBodyAccJerk-mean-X","fBodyAccJerk-mean-Y","fBodyAccJerk-mean-Z","fBodyAccJerk-std-X","fBodyAccJerk-std-Y","fBodyAccJerk-std-Z",
          "fBodyGyro-mean-X","fBodyGyro-mean-Y","fBodyGyro-mean-Z","fBodyGyro-std-X","fBodyGyro-std-Y","fBodyGyro-std-Z",
          " fBodyAccMag-mean"," fBodyAccMag-std","fBodyBodyAccJerkMag-mean","fBodyBodyAccJerkMag-std","fBodyBodyGyroMag-mean","fBodyBodyGyroMag-std",
          " fBodyBodyGyroJerkMag-mean"," fBodyBodyGyroJerkMag-std")
          
colnames(newSet)<-cnames

newSet$activity[newSet$activity =="1"] <- "WALKING"
newSet$activity[newSet$activity =="2"] <- "WALKING_UPSTAIRS"
newSet$activity[newSet$activity =="3"] <- "WALKING_DOWNSTAIRS"
newSet$activity[newSet$activity =="4"] <- "SITTING"
newSet$activity[newSet$activity =="5"] <- "STANDING"
newSet$activity[newSet$activity =="6"] <- "LAYING"

##print(head(newSet))
cat (nrow(newSet), ncol(newSet))


##convert columns to numeric
newSet[, c(1,3:68)] <- sapply(newSet[, c(1,3:68)], as.numeric)
##print(colnames(newSet))
##write.csv(newSet, file="output.csv")



cdata<-ddply(newSet, .(subject,activity), numcolwise(mean))
write.table(cdata, file="outTable.txt", row.name=FALSE )
