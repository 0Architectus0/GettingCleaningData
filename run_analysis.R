# 1. The submitted data set is tidy.
# 2. The Github repo contains the required scripts.
#    a. run_analysis.R
#    b. 
# 3. GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.
# 4. The README that explains the analysis files is clear and understandable.
# 5. The work submitted for this project is the work of the student who submitted it.
#     Truth
#
# R Version 3.5.3

# R script should:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# download data to temp directory
if(!file.exists("UCI HAR Dataset") ){
  temp <- tempfile( fileext = ".zip")
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", temp)
  # extract file to current directory subfolder 'data'
  unzip(temp, exdir = ".")
  unlink(temp)
}

# get file paths to read from folders
cmnfiles <- list.files(path = "./UCI HAR Dataset", pattern = "*.txt", full.names = TRUE)
trainfiles <- list.files(path = "./UCI HAR Dataset/train", pattern = "*.txt", full.names = TRUE)
testfiles <- list.files(path = "./UCI HAR Dataset/test", pattern = "*.txt", full.names = TRUE)

# read files to list
trainfile_list <- lapply(trainfiles, read.table, stringsAsFactors=FALSE )
testfile_list <- lapply(testfiles, read.table, stringsAsFactors=FALSE )
label_list <- lapply(cmnfiles[1:2], read.table, stringsAsFactors=FALSE )

# rename files in list
names(trainfile_list) <- substring(trainfiles, 25)
names(testfile_list) <- substring(testfiles, 24)
names(label_list) <- substring(cmnfiles[1:2], 19)

# apply feature labels to data frames in train list
colnames(trainfile_list$X_train.txt) <- label_list$features.txt[,2]
colnames(trainfile_list$y_train.txt) <- 'activityID'
colnames(trainfile_list$subject_train.txt) <- 'subjectID'

# apply feature labels to data frames in test list
colnames(testfile_list$X_test.txt) <- label_list$features.txt[,2]
colnames(testfile_list$y_test.txt) <- 'activityID'
colnames(testfile_list$subject_test.txt) <- 'subjectID'

# load dplyr librar for data manipulations
if (!'dplyr' %in% installed.packages() ){
  install.packages('dplyr', dependencies = TRUE)
}

library(dplyr)

# merge datasets
trainTest_meanStd_Activities <- bind_cols(trainfile_list) %>%
        # bind rows of merged test files 
        bind_rows(., bind_cols(testfile_list)) %>%
        # reorder dataset
        select(., c(1, length(.), 2:length(.)-1 ) ) %>%
        # remove columns whose labels do not include 'ID', 'mean()', or 'std()'
        .[,ifelse(regexpr('*ID|mean[()]|*std[()]*', colnames(.) ) > 0 , TRUE, FALSE) ] %>%
        # summmarize dataset by activity ID, subject ID, and mean of each feature 
        aggregate(., list( .$activityID, .$subjectID), mean) %>%
        # append acctvity names      
        left_join(., label_list$activity_labels.txt, by = c( 'activityID' = 'V1')) %>%
        # remove groups created by agg function
        select(., c(-1,-2)) %>%
        # reorder data set
        select(., c(1,2,length(.), 3:(length(.)-1) ) ) %>%
        # rename activty name
        rename('activty_name' = "V2")
  
write.table(trainTest_meanStd_Activities, file = "trainTest_meanStd_Activities.txt", row.names = FALSE, col.names = TRUE)
