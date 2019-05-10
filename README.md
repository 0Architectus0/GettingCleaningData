## Peer-graded Assignment: Getting and Cleaning Data Course Project
Vincent Rodriguez <br>
Peer-graded Assignment: Getting and Cleaning Data Course Project<br>
vincent.rodriguez@live.com

Synopsis: Extract data from online repository, clean, transform, and present data from disparate data sources using skills learned in course.

### Assignment Criteria
> 1. The submitted data set is tidy.
> 2. The Github repo contains the required scripts.
> 3. GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.
> 4. The README that explains the analysis files is clear and understandable.
> 5. The work submitted for this project is the work of the student who submitted it.

Composed r script criteria given as:

>R script should:
>1. Merges the training and the test sets to create one data set.
> 2. Extracts only the measurements on the mean and standard deviation for each measurement.
> 3. Uses descriptive activity names to name the activities in the data set
> 4. Appropriately labels the data set with descriptive variable names.
> 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Script downloads the data from the link provided; merges and transforms datasets as instructed.  

A final datasets is presented:
1. subjectActivity_Summary 


For each record in 'subjectActivity_Summary', it is provided:
---
- 561-feature vectors with time and frequency domain variables are reduced to only the mean and standard deviation for each measurement, 66 features remain.The remaining 66 features are grouped by activityID and subjectID then aggregated by mean of activity measures
- Its activity key, 'activityID'
- Its activity label, 'activity_name'
- An identifier of the subject who carried out the experiment, 'subjectID'

The dataset includes the following files:
---
- 'README.md'

- 'CODEBOOK.txt'

- 'subjectActivity_Summary.txt': independent tidy data set with the average of each variable for each activity and each subject.

- 'run_analysis.r': 


Notes: 
======

For more information about this dataset contact: vincent.rodriguez@live.com

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Vincent Rodriguez. May 2019.
