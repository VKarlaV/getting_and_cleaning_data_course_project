# ReadMe

This repository includes `run_analysis.R`,`tidy_data.txt` (result dataset of `run_analysis.R`), `README.md` and `CodeBook.md` as dataset documentation.

## Data transformation to create dataset

By running `run_analysis.R`, you will be able to get the `tidy_data.txt`. The data transformation includes the following steps:

+ Merges the training and the test sets to create one data set.
+ Extracts only the measurements on the mean and standard deviation for each measurement.
+ Uses descriptive activity names to name the activities in the data set 
+ Appropriately labels the data set with descriptive variable names.
+ From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.