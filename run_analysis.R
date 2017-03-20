library(dplyr)

###
### Read and merge the datasets
###

data_dir <- "UCI HAR Dataset/" # set the source data directory name

# Function: read_data() - this will read a file into a dataframe
#   read.table with separator of "" means that it can handle multiple spaces between columns (as per help page)
#              none of the files have headers
#              they are all space separated
read_data <- function(file_name) {
  read.table(paste0(data_dir, file_name), sep = "" , header = FALSE )
}

# Read in the features file - this has the variables names
features      <- read_data("features.txt")
feature_names <- features[,2] # names are in second column

# Read in activity labels which will be used to translate activity numbers into text
activity_labels <- read_data("activity_labels.txt")

#
# Read in TEST data
#
test_set        <- read_data("test/X_test.txt")          # activity measurements
test_subjects   <- read_data("test/subject_test.txt")    # subject IDs
test_activities <- read_data("test/y_test.txt")          # activity IDs

#
# Read in TRAIN data
#
train_set        <- read_data("train/X_train.txt")       # activity measurements
train_subjects   <- read_data("train/subject_train.txt") # subject IDs
train_activities <- read_data("train/y_train.txt")       # activity IDs

#
# Merge (bind) the test and train data sets
#
test_train_set        <- rbind(test_set,        train_set)
test_train_subjects   <- rbind(test_subjects,   train_subjects)
test_train_activities <- rbind(test_activities, train_activities)



###
### Select columns that we are interested in
###

# Extract the column location for each of the mean and std columns
mean_col_indexes <- feature_names %>% grep("mean", ., ignore.case = TRUE)
std_col_indexes  <- feature_names %>% grep("std",  ., ignore.case = TRUE)
col_indexes      <- sort(union(mean_col_indexes, std_col_indexes))

# apply that index to the data set - to extract the mean and std columns only
test_train_set    <- test_train_set[,col_indexes]

###
### Add variable names
###

# Assign proper variables names to the test & train set - based on which columns
# we have extracted
# This is done before adding subjects and activities otherwise these two columns
# will have NA as their names
names(test_train_set) <- feature_names[col_indexes]


###
### Add activity names and subjects
###

# Add subject and activity variables to data set
test_train_set$subjects   <- test_train_subjects[,1]   # IDs are in first column
test_train_set$activities <- test_train_activities[,1] # IDs are in first column

# Assign activity labels based on the activities ID
test_train_set$activity_labels <- activity_labels[test_train_set$activities,2]
# remove the acitivities ID column
test_train_set <- test_train_set %>% select(-activities)


###
### Generate table containing the averages
###

# From dplry help : help(package = "dplyr")
#   summarise_all : Summarise and mutate multiple columns.
#                   This will apply a function only to the non-grouping variables
summary_test_train_set <- test_train_set %>%
                            group_by(subjects,activity_labels) %>%
                            summarise_all(mean)

# Write out to file
write.table(summary_test_train_set, "summary_test_train_set.txt", row.names = FALSE)

# End of run_analysis.R
