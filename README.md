# Getting and Cleaing Data Project

# README

Note markdown text follows rstudio guidlines -
  http://rmarkdown.rstudio.com/authoring_basics.html

Lots of helpful guideance from:
https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/

This README describes the `run_analysis.R` script and should be read along with the code book - CodeBook.md.


# Running the script

The run_analysis.R script has been tested on:

* R version 3.3.3 (2017-03-06) -- "Another Canoe"
* macOS 10.12.3

The "UCI HAR Dataset" directory must be in the same directory as the script.
The script can be executed by:

```
Rscript run_analysis.R
```

It will create a file called "summary_test_train_set.txt".  See "Output data set file" below.



## Approach to processing

* Read and merge data sets
* Select columns that we are interested in
* Add variable names to columns
* Add activity names and subjects to the data set
* Generate table containing the averages


### Read and merge data sets

Firstly, the script reads in data that is the same across both the test and train files.  These are:

* Read in features.txt - this will be the column names
* Read in activity_labels.txt - this be a lookup to cross reference the activity ID with its label


Then, read in data that is the different per test and train sets.

* From the test and train diretories, read in:
    + train/X_train.txt
    + train/subject_train.txt
    + train/y_train.txt
    + test/X_test.txt
    + test/subject_test.txt
    + test/y_test.txt
* Combine test and train datasets into one data set called `test_train_set`


### Select columns that we are interested in

> Extracts only the measurements on the mean and standard deviation for each
> measurement.

Note that there are duplicate columns names in the X_train/test data sets

This code shows which column names are duplicated

```{r}
  source("run_analysis.R")
  feature_name_counts <- as.data.frame( table(feature_names) )
  feature_name_counts[feature_name_counts$Freq > 1,]
```

This meant that using `dplyr::select()` and `dplyr::contains()` did not work.

The script therefore selects columns containing the word "mean" or "std" - ignoring case and assuming the strings "mean" and "std" can occurr anywhere in the measurement name.

Noted from features_info.txt

> The set of variables that were estimated from these signals are:
> mean(): Mean value
> std(): Standard deviation

and also:

> Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:
```
gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean
```

The script uses `grep()` to create two sets - one containing the numbers for the location of column names with "mean" in their names, the other containing numbers for names with "std".

These two sets are combined to create a vector that can be used to extract the columns from test_train_set, and also to name the variables (see below).


###  Add variable names

> Appropriately labels the data set with descriptive variable names.

The script has read in the variable names from features.txt.  It then applies the
names that match the strings "mean" and "std" to the test_train_set using the
col_indexes vector.

This is a check to see that we have the same number of columns.
```{r}
identical(ncol(test_train_set), length(col_indexes))
```


### Add activity names and subjects

> Uses descriptive activity names to name the activities in the data set

The script adds the subject and activty data to the combined test & train data set.  The following code can be used to ensure that they have been added and the data is in the correct order.

```{r}
identical(test_train_set$subjects,   test_train_subjects$V1)
identical(test_train_set$activities, test_train_activities$V1)
```

The script applies names from activity_labels dataframe to the data set based on the activity ID (`activities`).
The activity ID variable is then removed so that it is not included in the summary data.



### Generate table containing the averages

> From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The test/train data set is piped through `group_by()` to group the data by subject and
activity label.

The `dplyr::summarise_all()` function summarises a dataframe by applying a specified
function (`mean`) to all the columns except the columns used in the `group_by()`.  This gives a tidy, wide dataset.  See:  Week 1 presentation "Components of Tidy Data".

The resulting data set is: `summary_test_train_set`, a data frame of dimensions [180 x 88]


### Output data set file

The data set is written to a file called "summary_test_train_set.txt".  This can be read back in using:

```{r}
summary_test_train_set <- read.table("summary_test_train_set.txt", header = TRUE)
```

Note that the columns names for target data set of read.table() the have the "()-" string replaced by "...".



