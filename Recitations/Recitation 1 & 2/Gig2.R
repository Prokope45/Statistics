#Create a vector called neat vector
neatVector = c(-3, 4, 7, 21, 5, 6, -2, 18)

#4th entry
neatVector[4]

#1st, 3rd, and 5th entry
neatVector[c(1, 3, 5)]

#2nd through 6th
neatVector[2:6]

#All but 7th
neatVector[-7]

#All but 3rd and 6th
neatVector[-c(2,6)]

#Load in the Gig2 dataset.
#If you want blank entries of a categorical variable to be treated as missing values,
#change the "na.strings" entry from NA to a blank in the import dataset options.

#Second row
Gig2[2,]

#Columns 2 through 4
Gig2[,2:4]

#Rows 3, 5, and 6 of Column 3
Gig2[c(3, 5, 6), 3]

#All rows but 4, 5, and 7
Gig2[-c(4, 5, 7),]

#The 25th entry of Industry
Gig2$Industry[25]

#Look at data
View(Gig2)
#How many observations and how many variables?
dim(Gig2)

#Looks like 604 observations, 4 variables.

#From our inspection, the EmployeeID variable is the only variable without NA's
#We can determine which observations have missing values for HourlyWage,Industry and Job
#using the which() and the is.na() functions
#Find the indices of the missing data for HourlyWage,Industry and Job
which(is.na(Gig2$HourlyWage))
which(is.na(Gig2$Industry))
which(is.na(Gig2$Job))

#For simplicity, we can store the list of indices into a new variable for 
# each of HourlyWage,Industry and Job respectively.
# The new variables we use here are whichmiss_HourlyWage, whichmiss_Industry and whichmiss_Job.
whichmissHourlyWage = which(is.na(Gig2$HourlyWage))
whichmissIndustry = which(is.na(Gig2$Industry))
whichmissJob = which(is.na(Gig2$Job))

##Use the length function to determine how many missing values there are for each variable
length(whichmissHourlyWage)
length(whichmissIndustry)
length(whichmissJob)

#Which observations are complete cases?
which(complete.cases(Gig2))
#Idea, store information into a variable that you want to use over and over again
#The variable ccobs will store which observations in the dataset are complete.cases()
ccobs = which(complete.cases(Gig2))

#Use the length function to determine how many complete cases we have
length(ccobs)

#There are 572 complete cases
#Let's make two new datasets
#1) A subset of Gig2 that just includes the complete cases
#2) A subset of Gig2 that just includes the incomplete cases
#Use square brackets [,] to subset the observations that correspond to each.

#First, just subset the complete cases.
#The observations that correspond to the complete cases are ccobs, 
#so we will only subset rows that are listed in ccobs 
#Include all columns (leave the space to the right of the comma blank.)
#Store as Gig2CC
Gig2CC = Gig2[ccobs, ]
#View this dataset
View(Gig2CC)
#Note, there are no missing data entries in this dataset.


# Use the table function to find the number of people working in each industry
table(Gig2$Industry)
#Also count NA's
table(Gig2$Industry, useNA = "ifany")

# Use the table function to find the number of people working in each job
table(Gig2$Job)
#Also count NA's
table(Gig2$Job, useNA = "ifany")

