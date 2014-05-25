# Getting and Cleaning the data Coursera Project
# Source of the data for this project:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# This R script does the following:
# 1. Merges the training and the test sets to create one data set.

#for X
X_train<-read.table("UCI HAR Dataset/train/X_train.txt",header=F)
X_test<-read.table("train/X_test.txt",header=F)
X_total<-rbind(X_train,X_test)

features<-read.table("features.txt",colClasses=c("NULL",NA))
names(X_total)<-features[,1] ##put the features names for the columns of X_total

#for subject :
subject_train<-read.table("train/subject_train.txt")
subject_test<-read.table("test/subject_test.txt")
subject_total<-rbind(subject_train,subject_test)

names(subject_total)<-"subject" 

#for activity :
y_train<-read.table("train/y_train.txt")
y_test<-read.table("test/y_test.txt")
y_total<-rbind(y_train,y_test)

names(y_total)<-"activity"

#Concat X, SUBJECT & ACTIVITY
DataWearable<-cbind(X_total,subject_total,y_total)
names(DataWearable) <- tolower(names(DataWearable))   # see 'Editing Text Variables' (week 4)
##names(DataWearable) <- gsub("\\(|\\)", "", names(DataWearable))

##TEST
##any(dim(DataWearable) == c(10299  , 563))
##any(is.na(DataWearable))==FALSE


# 2. Extracts the measurements on the mean and standard deviation for each measurement.

##remove all columns but those concerning mean & std deviation + the columns subject & activtiy
DataWearMeanStd<-DataWearable[,c(grep("-mean\\(\\)|-std\\(\\)",names(DataWearable)),length(names(DataWearable))-1,length(names(DataWearable)))]


# 3. Uses descriptive activity names to name the activities in the data set

#Get labels :
labelsActivity <- read.table("activity_labels.txt") ##need first column with number for merge...
names(labelsActivity)<-c("nb","activitydescription")## keep nbr to simplify the merge
labelsActivities[, 2] <- gsub("_", "", tolower(as.character(labelsActivities[, 2])))

#Merge :
DataWearMeanStdLabels<-merge(DataWearMeanStd,labelsActivity, by.x = "activity", by.y = "nb")
DataWearMeanStdLabels<-DataWearMeanStdLabels[,c(2:length(DataWearMeanStdLabels),1)] #reorder

# 4. Appropriately labels the data set with descriptive activity names.

write.table(DataWearMeanStd, "merged_clean_data.txt")

# 5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.

uniqueSubjects = unique(DataWearMeanStd$subject)
numSubjects = length(uniqueSubjects)
numActivities = length(labelsActivity[,1])
numCols = dim(DataWearMeanStd)[2]
result = DataWearMeanStd[1:(numSubjects*numActivities), ]

row = 1
for (s in 1:numSubjects) {
	for (a in 1:numActivities) {
		result[row, 1] = uniqueSubjects[s]
		result[row, 2] = labelsActivity[a, 2]
		tmp <- DataWearMeanStd[DataWearMeanStd$subject==s & DataWearMeanStd$activity==labelsActivity[a, 2], ]
		result[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
		row = row+1
	}
}
write.table(result, "data_set_with_the_averages.txt")
