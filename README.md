## Getting and Cleaning Data Project

5 steps to follow :

* Download and unzip the source
 (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip )
  into a folder on your local drive, say C:\Users\YourName\Documents\R\
  This should create a subfolder UCI HAR Dataset with some files in it
 
* Put the R script file run_analysis.R into  C:\Users\YourName\Documents\R\UCI HAR Dataset\

* in R, write the command :
  setwd("C:\\Users\\YourName\\Documents\\R\\UCI HAR Dataset\\")

  and then:
  source("run_analysis.R")

* The latter will run the script, it will read the dataset and write these files:

  merged_clean_data.txt  -- 10299x68 data frame

  wearable_data_with_averages.txt  -- 180x68 data frame

* Write the command : 
  data <- read.table("wearable_data_with_averages.txt")
  to read the latter.
  It is 180x68 because there are 30 subjects and 6 activities,
  thus "for each activity and each subject" means 30*6=180 rows.
