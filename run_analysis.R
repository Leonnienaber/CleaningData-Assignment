##Setting up R to workand loading libraries
install.packages("tidyverse")
library(dplyr)

getwd()
setwd("G:/Coursera Data Science/3. Obtaining and Cleaning data/Project")

##End of setting up R to workand loading libraries
##---------------------------------------------------------------------------------------------------------------
##Start of downloading files adn creating the temp files needed
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "./FileDownloaded")
dateDownload <- date()

file.exists("Unzipped")
dir.create("Unzipped")

unzip(zipfile = "FileDownloaded",exdir = "./Unzipped")

## End of downloading the files
##---------------------------------------------------------------------------------------------------------------
## Start of understanding the content of the folders and files, loading and see structures

# Reading in the data
subject_test <- read.table("./Unzipped/UCI HAR Dataset/test/subject_test.txt", stringsAsFactors = FALSE)
X_test <- read.table("./Unzipped/UCI HAR Dataset/test/X_test.txt", stringsAsFactors = FALSE)
y_test <- read.table("./Unzipped/UCI HAR Dataset/test/y_test.txt", stringsAsFactors = FALSE)

subject_train <- read.table("./Unzipped/UCI HAR Dataset/train/subject_train.txt", stringsAsFactors = FALSE)
X_train <- read.table("./Unzipped/UCI HAR Dataset/train/X_train.txt", stringsAsFactors = FALSE)
y_train <- read.table("./Unzipped/UCI HAR Dataset/train/y_train.txt", stringsAsFactors = FALSE)


## End of understanding the content of the folders and files, loading and see structures
##---------------------------------------------------------------------------------------------------------------
## Start of Project question 1

# Building the full table by combining the two tables(X_test and X_train) by means of the rows.Similar for the subjects and labels
Testtrain_XDF <- rbind(X_test, X_train)
Testtrain_subjectDF <- rbind(subject_test, subject_train)
Testtrain_yDF <- rbind(y_test, y_train)

# Remove the tables to clean up space
rm(subject_test,X_test,y_test,subject_train,X_train,y_train)

## End of Project question 1
##---------------------------------------------------------------------------------------------------------------
## Start of Project question 2 and 4

#Loading the names in a list (561 in total)
featlist <- read.delim("./Unzipped/UCI HAR Dataset/features.txt", header = FALSE, stringsAsFactors = FALSE)

# Create a list of positions where the feature list only has a mean or std
positionlist <- grep(("mean\\()|std"),featlist$V1)
positionlist

#New table created, called mean_stdDF, containing only the data as per the positionlist
mean_stdDF <- Testtrain_XDF[positionlist]
#new list created, called mean_stdfeatlist, containg only the descriptions as per the positionlist
mean_stdfeatlist <- (featlist$V1[positionlist])

#Seperating the numbering or mean_stdfeatlist 
splitcol = strsplit(mean_stdfeatlist,"\\ ")
lastElement <- function(x){x[2]}
mean_stdfeatlist <- sapply(splitcol,lastElement)

#Removing all the brackets ("()") and dashes ("-") in the original .txt file
mean_stdfeatlist <- sub("-mean\\()","_Mean", mean_stdfeatlist)
mean_stdfeatlist <- sub("-std\\()","_Std", mean_stdfeatlist)
mean_stdfeatlist <- gsub("-","_", mean_stdfeatlist)

#Transform the t and f to understandable words
mean_stdfeatlist <- sub("^t","Time-", mean_stdfeatlist)
mean_stdfeatlist <- sub("^f","Freq-", mean_stdfeatlist)
mean_stdfeatlist

# Expanding the table by combining the person ID data, activity ID data and the mean/std readings in one table
FinalDF <- cbind(Testtrain_subjectDF,Testtrain_yDF,mean_stdDF)

# Expanding the feature list by combining the person ID name, activity ID name and the mean/std feature name in one table
FinalFeatlist <- c("PersonID", "Activity",mean_stdfeatlist)

# Reading the coloumn names in for the FinalDF table
colnames(FinalDF) <- FinalFeatlist[1:68]

# Remove the raw data tables to clean up space
rm(FinalFeatlist, mean_stdfeatlist, lastElement, splitcol, featlist, positionlist, mean_stdDF,Testtrain_subjectDF,Testtrain_yDF,Testtrain_XDF)

## End of Project question 2 and 4
##---------------------------------------------------------------------------------------------------------------
## Start of Project question 3

#Read the file with activity details
activ <- read.table("./Unzipped/UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)

#Merging the FinalDF and active tables
FinalDF <- merge(FinalDF,activ,by.x = "Activity", by.y = "V1")
names(FinalDF)[names(FinalDF) == 'V2'] <- "ActivityName"

#Removing the redundant colunm
FinalDF <- subset(FinalDF, select = -c(Activity))

#Bringing the ActivityName coloumn to the front
FinalDF <- FinalDF[,c(ncol(FinalDF),1:(ncol(FinalDF)-1))]

rm(activ)

## End of Project question 3
##---------------------------------------------------------------------------------------------------------------
## Start of Project question 4

# This has been done in question 2 

## End of Project question 4
##---------------------------------------------------------------------------------------------------------------
## Start of Project question 5

#Making use of dyplr package
Final2DF <- tbl_df(FinalDF)

# The table contains the average of each variable, first by activity then by subject.
AverageTable <- 
  Final2DF %>%
  group_by(ActivityName, PersonID) %>%
  summarize_all(funs(mean)) %>%
  arrange(ActivityName, PersonID) %>%
  print

#Export the final table to working directory
write.table(AverageTable,"AverageTable.txt",row.names=FALSE)

rm(Final2DF)

## End of Project question 5
##---------------------------------------------------------------------------------------------------------------


