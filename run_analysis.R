# Getting and Cleaning the data Coursera Project
# Source of the data for this project:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# This R script does the following:
# 1. Merges the training and the test sets to create one data set.

#for X
X_train<-read.table("train/X_train.txt",header=F)
X_test<-read.table("test/X_test.txt",header=F)
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
names(y_total)<-"activityid"

##TEST
##any(dim(DataWearable) == c(10299  , 563))
##any(is.na(DataWearable))==FALSE


# 2. Extracts the measurements on the mean and standard deviation for each measurement.

##remove all columns but those concerning mean & std deviation + the columns subject & activtiy
X_mean_std<-X_total[,grep("-mean\\(\\)|-std\\(\\)",names(X_total))]
names(X_mean_std) <- gsub("\\(|\\)", "", names(X_mean_std))

# 3. Uses descriptive activity names to name the activities in the data set

#Get labels :
activities <- read.table("activity_labels.txt") ##need first column with number for merge...
names(activities)<-c("nb","activity")## keep nbr to simplify the merge
activities[, 2] <- gsub("_", "", tolower(as.character(activities[, 2])))


#Merge :
y_labels<-merge(y_total,activities, by.x = "activityid", by.y = "nb")
y_labels$activityid<-NULL


# 4. Appropriately labels the data set with descriptive activity names.

#Concat subject, activity & data
data_wearable<-cbind(subject_total,y_labels,X_mean_std)
names(data_wearable) <- tolower(names(data_wearable))   # see 'Editing Text Variables' (week 4)

write.table(data_wearable, "wearable_clean_data.txt")

# 5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.

unique_subjects = unique(data_wearable$subject)
nb_subjects = length(unique_subjects)
nb_activities = length(activities[,1])
nb_cols = ncol(data_wearable)
result = data_wearable[1:(nb_subjects*nb_activities), ]

row = 1
for (s in 1:nb_subjects) {
	for (a in 1:nb_activities) {
		result[row, 1] = unique_subjects[s]
		result[row, 2] = activities[a, 2]
		tmp <- data_wearable[data_wearable$subject==s & data_wearable$activity==activities[a, 2], ]
		result[row, 3:nb_cols] <- colMeans(tmp[, 3:nb_cols])
		row = row+1
	}
}
write.table(result, "wearable_data_with_averages.txt")
