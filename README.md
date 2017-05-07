# GettingandCleaningData
Final Assignment - Project

The R script obtains data from an experiment that tries to determine activities
people are performing based on sensor data collected from smartphones.  
Our goal is to aggregate the sensor data from multiple files and extract
relevant data (means and std devs) and tidying it up.  


The data is sourced from [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## Directory and files structure

The sourced data is uncompressed without any changes to names and structure into subdirectory called "UCI HAR Dataset".  

The top directory contains the following:

* README.md : This file
* CodeBook.md : Transformations performed, descriptions of variables and data in the output file (see results.txt)
* run_analysis.R : The R script to produce the desired course output
* results.txt : The output of the R script
