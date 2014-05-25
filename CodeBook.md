Source of the original data:
  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip .
Original description:
  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

 The R script run_analysis.R do a clean up of the data. It follows these steps :

* 1. Merge the training and test sets into one data set and add the labels The result is a 10299 x 561 data frame.

train/subject_train.txt with test/subject_test.txt -- the result is a 10299 x 1 data frame with subject IDs,

train/y_train.txt with test/y_test.txt -- the result is also a 10299 x 1 data frame with activity IDs.

* 2.  Reads file features.txt and extracts the measurements for the mean and standard deviation.

The result : a 10299 x 66 data frame.
All measurements ar in floating point 

* 3. Reads activity_labels.txt and applies descriptive activity names to name the activities in the data set:

walking

walkingupstairs

walkingdownstairs

sitting

standing

laying

* 4. The script also labels the data set with descriptive names:
all feature names (attributes) and activity names are converted to lower case,
underscores and brackets () are removed.

Then it merges the 10299x66 data frame containing features with
10299x1 data frames containing activity labels and subject IDs.

The result is saved as merged_clean_data.txt, a 10299x68 data frame
such that the first column contains subject IDs,
the second column activity names,
and the last 66 columns are measurements.
Subject IDs are integers between 1 and 30 inclusive.
Names of the attributes are similar to the following:

tbodyacc-mean-x 

tbodyacc-mean-y 

tbodyacc-mean-z 

tbodyacc-std-x 

tbodyacc-std-y 

tbodyacc-std-z 

tgravityacc-mean-x 

tgravityacc-mean-y

* 5. Finally, the script creates a 2nd, independent tidy data set with the average
of each measurement for each activity and each subject.

The result is saved as data_set_with_the_averages.txt, a 180x68 data frame, where as before,
the first column contains subject IDs, the second column contains activity names (see below),
and then the averages for each of the 66 attributes are in columns 3...68.
There are 30 subjects and 6 activities, thus 180 rows in this data set with averages.
