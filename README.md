# Getting and Cleaning Data Project README
## Using the Samsung data set from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

This R file (load and call the function run_analysis()) will do the following:

1. Load the unzipped samsung data set including the following files:
** Test Dataset
** Training Dataset
** Activity Labels
** Features

2. Using the test and training data sets, the program will keep the data pertaining to Mean and Standard Deviation.

3. Merge the activity and subjet info for the datasets, and merges the datasets together.

4. Creates a final, "tidy" dataset that contains the mean value for subject and activities and saves it to the file tidy.txt
