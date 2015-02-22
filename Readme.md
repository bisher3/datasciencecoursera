Course Project for Coursera's "Getting and Cleaning Data" 
Submitted by Bisher Tarakji 2/2015

The following are just quick notes to the steps taken to obtain the tidy data:

1. The script should be run with the working directory pointing to INSIDE the Samsung data folder. Meaning the folder that has both the "train" and "test" folder within it.
2. The library "dplyr" is required for last step
3. All files are read into variables of the same name from both the train and test folders.
4. The inertia folder was not used as all the variables that will be read from it will be discarded later on when the data is filtered to take only the mean and standard deviation measurements.
5. Data was binded together with cbind and rbind without any "merge" functions
6. To change the activity column values from integers to meaningful names, the column was converted to a factor variable and then the its levels were set using the labels read from the activity_labels.txt. This also avoided the problematic merge function.
7. To find all the measurements that had mean() or std() on them the grep function was used. I specified ignore.case = F as not to take the measurements that have "Mean" with a capital "M" in them. 
8.dplyr piping functionality was used to group the resulting data by activity and subject and then run a summarise_each with the "mean()" function to calculate the mean of each variable for each subject,activity.