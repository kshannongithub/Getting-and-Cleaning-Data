# Getting-and-Cleaning-Data
Repo for Coursera JHU Data Science C3W4 "Getting-and-Cleaning-Data" course assignment

Background: Experiments were carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The dataset includes the following files:
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.
- 'subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

Data was manipulated as follows:
- Merge the training and the test sets to create one data set.
- Extract only the measurements on the mean and standard deviation for each measurement.
- Use descriptive activity names to name the activities in the data set
- Label the data set with descriptive variable names.
- Create a tidy data set with the average of each variable for each activity and each subject.

Requirements for the assignment (posted to GitHub):
- R script (named as "run_analysis").
- Code Book that describes variables and calculated summaries, along with units, and any other relevant information.
- README that explains the analysis files is clear and understandable
- The submitted data set must be tidy.
