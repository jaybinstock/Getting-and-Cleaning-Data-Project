##Variables & Process

-filename and url are the name of the raw data we are saving and the url of that file respectively

-training and testing participants, activities and measurements are raw datatables files that we unzip and bind together

-measurement and activity labels contain the labels for measurement and activity data, which we map

-we use the measurement labels to choose only the columns related to means and standard deviation

-we combine all the data, rename the columns to increase readability, and summarize into a tidy dataset featuring: averages of each column by participant and activity
