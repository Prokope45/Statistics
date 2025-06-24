#After loading in the ClassGpa dataset, look at it.
#View the dataset ClassGpa
View(ClassGpa)

#How many observations and how many variables?
dim(ClassGpa)

#Looks like 30 observations, 4 variables.

#Which observations are complete cases?
which(complete.cases(ClassGpa))

#Idea, store information into a variable thatyou want to use over and over again
#The variable ccdata will store which observations in the dataset are complete.cases()
ccobs = which(complete.cases(ClassGpa))

#We can use the length function to determine how many complete cases we have
length(ccobs)

#There are 24 complete cases
#Let's make two new datasets
#1) A subset of ClassGpa that just includes the complete cases
#2) A subset of ClassGpa that just includes the incomplete cases
#Use square brackets [,] to subset the observations that correspond to each.

#First, just subset the complete cases.
#The observations that correspond to the complete cases are ccobs, 
#so we will only subset rows that are listed in ccobs 
#Include all columns (leave the space to the right of the comma blank.)
#Store as ClassGpaCC
ClassGpaCC = ClassGpa[ccobs, ]

#View this dataset
View(ClassGpaCC)

#Note, there are no missing data entries in this dataset.

#NEW IDEA: a minus sign in front of a list of observations tells R
#to keep everything except for the observations in the list.
#For example, to obtain all but the first three observations in classGPA, we can type
AllButFirstThree = ClassGpa[-c(1,2,3), ]
View(AllButFirstThree)

#We can use the ccobs variable and this minus sign to subset only the incomplete observations
ClassGpaInc = ClassGpa[-ccobs, ]
View(ClassGpaInc)

#We can determine which observations have missing values for HoursStudied 
#using the which() and the is.na() functions
which(is.na(ClassGpa$HoursStudied))

#For simplicity, we can store this list of observations into a variable called nohs
nohs = which(is.na(ClassGpa$HoursStudied))

#Use the length function to determine how many missing values there are for HoursStudies
length(nohs)

#Use the table function to find distribution of classes
table(ClassGpa$Class)

#Also count NA's
table(ClassGpa$Class, useNA = "ifany")

#Can use the sort function to view sorted values of one variable
#Sort GPAs in ascending order
#Set Decreasing = FALSE  to ensure ascending order
sort(ClassGpa$GPA, decreasing = FALSE)

#Sort GPAs in descending order
sort(ClassGpa$GPA, decreasing = TRUE)

#Order ClassGpa by GPA in increasing order
orderGPA = order(ClassGpa$GPA, decreasing = FALSE)
ClassGpa[orderGPA, ]

#Note, the above commands do not store the ordering
View(ClassGpa)

#If you want to store the ordering, you must create a new dataset
OrderClassGpa = ClassGpa[orderGPA, ]
View(OrderClassGpa)

#Order ClassGpa by Hours Studied in decreasing order
orderHS = order(ClassGpa$HoursStudied, decreasing = TRUE)
ClassGpa[orderHS, ]

#Note, if you are ordering with respect to a variable with missing values, 
#the observations with the missing values will appear at the end.

#Order the dataset first by GPA in decreasing order, then by Hours Studied in decreasing order
orderGPAHS = order(ClassGpa$GPA,ClassGpa$HoursStudied, decreasing = TRUE)
OrderClassGpa2 = ClassGpa[orderGPAHS, ]
View(OrderClassGpa2)

#Looks like there is an entry error.  Not possible for someone to have a GPA of 31.
#Likely just forgot the decimal.  
#Replace the 31 with 3.1

#First, which observation has the 31?
which(ClassGpa$GPA > 4)

#Looks like observation 12.
#Change the GPA of the 12th observation to 3.1
ClassGpa$GPA[12] = 3.1
View(ClassGpa)
sort(ClassGpa$GPA, decreasing = TRUE)

#We fixed it!

#How many students studied 10 hours or more?
#Use the which function to find the students, and store the result
#Then use the length function to count
whichmoreoreq10 = which(ClassGpa$HoursStudied >= 10)		
length(whichmoreoreq10)
View(ClassGpa[whichmoreoreq10,])
			
#How many students studied less than 5 hours?			
whichless5 = which(ClassGpa$HoursStudied < 5)	
length(whichless5)
			
#How many students studied exactly 9 hours			
whicheq9 = which(ClassGpa$HoursStudied == 9)	
length(whicheq9)



