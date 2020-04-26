---
title: "README"
author: "Leon Nienaber"
date: "26 April 2020"
output: html_document

---
<https://github.com/Leonnienaber/CleaningData-Assignment>

## Introduction

This document serves as the README file for the following project assignment:

Course:	Obtaining and Cleaning Data  
Assignement: Peer-graded Assignment  
Reference:

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a 
Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012


## Transformation of data sources

### Step 1 in assignment:

Each of the datasets have been read by the script:  
	1. Activity labels (Named: "activity_labels")  
	2. Dataset for test features		(Named: "X_test)  
	3. Dataset for train features		(Named: "X_train)  
	4. List for test subjects (1-30)	(Named: "subject_test)  
	5. List for train subjects (1-30)	(Named: "subject_train)  
	6. Activity class label for test (1-6)	(Named: "y_test)  
	7. Activity class label for train (1-6)	(Named: "y_test)  

The structure of the data have been investigated

The test and train data have been combined for the (1) activity class, (2) features and (3) subjects respectively.  
The feature list has been imported.

### Step 2 and 4 in assignment:

A position list has been created to pull only required features being the mean or std.

* All the entries on the feature list with ```mean()``` and ```std()``` was used for the dataset, as it measured the mean and standard deviation of a measurement.  
* The ```meanFreq()``` and ```angle()``` sets was excluded, as it is measuring frequency and angles, not the mean of a measurement.

The position list has been applied to the

* Newly created (test and train) data set and 
* Feature list

Additionally the feature list has been cleaned to reflect tidy variable names:

* Numbering and spaces was removed
* Brackets removed
* Dashes was made underscores
* t (Time) and F(Freq) was written out

The FinalDF was put together with the respective coloumn names.

### Step 3 in assignment:

The Activity label table was read

The FinalDF and activity label table was merged. 

* The column with the tags was removed
* The column with the labels was brought to be front of the table

### Step 4 in assignment:

See step 2
 
### Step 5 in assignment:

By making use of package dplyr, the AverageTable was created by grouping by Activity and Subjects.

The mean was taken for each measurement.  

The AverageTable is exported as ```AverageTable.txt```

##### Notes:

1. Various places coding was used to understand the table structures, sizes and layout. This script has been removed.
2. Cleaning and removal of temporary tables and list are done thoughout the script.

### END

