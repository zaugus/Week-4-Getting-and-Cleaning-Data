# Week-4-Getting-and-Cleaning-Data

## Project work - Getting and Cleaning Data. 

  Source file is run_analysis.R, the R script does the following:

1. Download the dataset if it does not already exist in the working directory
2. Load the activity and feature info. Read data from file into variables.
      . Read the Activity files.
      . Read the Subject files.
      . Read Features files.
3. Loads both the training and test datasets, keeping only those columns which reflect a mean or standard deviation
      . Subset Name of Features by measurements on the mean and standard deviation.
      . Subset the data frame Data by selected names of Features.
4. Loads the activity and subject data for each dataset, and merges those columns with the dataset
     . Concatenate the data tables by rows.
     . set names to variables.
     . Merge columns to get the data frame Data for all data
5. Merges the two datasets
6. Converts the activity and subject columns into factors
7. Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair

 The end result is shown in the file tidy.txt.
