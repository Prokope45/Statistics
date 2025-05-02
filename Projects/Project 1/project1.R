class = read.csv("Projects\Project 1\ClassSurvey.csv", header=TRUE)

# ----------------------------------- Part 1 -----------------------------------

# Num of students in dataset
dim(class) # 226 rows 9 columns

# Missing values for each variable
length(which(is.na(class$Section))) # 0
length(which(is.na(class$Biological.Sex))) # 0
length(which(is.na(class$GPA))) # 1
length(which(is.na(class$Miss_Class))) # 3
length(which(is.na(class$Seating))) # 0
length(which(is.na(class$Monthly_Parties))) # 1
length(which(is.na(class$Drinking_Days))) # 1
length(which(is.na(class$Weekly_Study))) # 0
length(which(is.na(class$Book_Cost))) # 0

length(which(complete.cases(class$Section))) # 226
length(which(complete.cases(class$Biological.Sex))) # 226
length(which(complete.cases(class$GPA))) # 225
length(which(complete.cases(class$Miss_Class))) # 223
length(which(complete.cases(class$Seating))) # 226
length(which(complete.cases(class$Monthly_Parties))) # 225
length(which(complete.cases(class$Drinking_Days)))  # 225
length(which(complete.cases(class$Weekly_Study))) # 226
length(which(complete.cases(class$Book_Cost))) # 226

# Clean up missing data by removal or imputation
# Remove GPA due to other variables impacting GPA rates
whichHaveGPA = which(!is.na(class$GPA))
class = class[whichHaveGPA,]

# Impute miss_class with median (due to multiple nils)
missClassMedian = median(class$Miss_Class, na.rm=TRUE)
whichMissClass = which(is.na(class$Miss_Class))
class[whichMissClass,]
class$Miss_Class[whichMissClass] = missClassMedian
class[whichMissClass,]

# Impute the last two with mean
# NA monthly parties observation is removed in above GPA removal step.
monthlyPartiesMean = mean(class$Monthly_Parties, na.rm=TRUE)
whichMissingMonthlyParties = which(is.na(class$Monthly_Parties))
whichMissingMonthlyParties

drinkingDaysMean = mean(class$Drinking_Days, na.rm=TRUE)
whichMissingDrinkingDays = which(is.na(class$Drinking_Days))
class$Drinking_Days[whichMissingDrinkingDays] = drinkingDaysMean

# Remove students with monthly parties greater than 12 from dataset
whichMonthlyPartiesGT12 = which(class$Monthly_Parties > 12)
class[whichMonthlyPartiesGT12,]
# Remove by omission
whichMonthlyPartiesLTEq12 = which(class$Monthly_Parties <= 12)
class[whichMonthlyPartiesLTEq12,]
class = class[whichMonthlyPartiesLTEq12,]

# Add column to dataset obtained by taking log base 10 of book cost.
bookCostLog10 = log(class$Book_Cost, base=10)
class$Book_Cost_Log10 = bookCostLog10

# Add column to dataset obtained by taking square root of book cost.
bookCostSqrt = sqrt(class$Book_Cost)
class$Book_Cost_Sqrt = bookCostSqrt

# Create variable that is 1 if Missing days are greater than 3 and is 0 otherwise.
# Add as column to dataset.
missingDaysGT3 = ifelse(class$Miss_Class > 3, 1, 0)
class$More_than_3_Missing_Days = missingDaysGT3


# Replace 6th entry of seating variable with first and last name
class[6, 5]
class[6, 5] = "Jared Paubel"
class[6, 5]

# Export new CSV as CleanedClass.csv
write.csv(class, "CleanedClass.csv", row.names=FALSE)

# ----------------------------------- Part 2 -----------------------------------


cleanedClass = read.csv("Projects\Project 1\CleanedClass.csv", header=TRUE)

# How many different sections are included in the dataset, and how many students are in each section?
table(cleanedClass$Section)

# For each section, give average GPA. Which section has the highest and lowest GPA?
aggregate(cleanedClass$GPA, by=list(cleanedClass$Section), mean)
# Section 16 has lowest; Section 15 has highest

# For each section, give the sd of Book Cost within that section. Which section has highest and lowest sd?
aggregate(cleanedClass$Book_Cost, by=list(cleanedClass$Section), sd)
# Section 16 has lowest; section 14 has lowest.

# Give correlation between GPA and Drinking Days
cor(cleanedClass$GPA, cleanedClass$Drinking_Days)

# Give correlation between GPA and Monthly Parties
cor(cleanedClass$GPA, cleanedClass$Monthly_Parties)

# Give section with largest Drinking Days
cleanedClass[which.max(cleanedClass$Drinking_Days),]$Section

# Give section with smallest Weekly Study
cleanedClass[which.min(cleanedClass$Weekly_Study),]$Section

# List all sections that has students with missing days less than 3.
studentsWithLT3MissingDays = which(cleanedClass$More_than_3_Missing_Days == 0)
cleanedClass[studentsWithLT3MissingDays, ]$Section

# Make two histograms:
# One of log base 10 of Book Cost and one of number of Drinking Days.
# Describe shape of both of these histograms.
hist(
  cleanedClass$Book_Cost_Log10,
  breaks=5,
  col="purple",
  xlab="Cost",
  main="Base-10 Book Cost Histogram"
)
# Positively skewed, unimodal

hist(
  cleanedClass$Drinking_Days,
  breaks=5,
  col="purple",
  xlab="Drinking Days",
  main="Drinking Days Histogram"
)
# Negatively skewed, unimodal


# Make scatterplot where GPA is on x-axis and Drinking Days is on the y-axis.
# Use your first and last name as the title of the plot
# Describe the shape of the plot.
# Does shape of this plot match answer in part 2d?
plot(
  cleanedClass$GPA,
  cleanedClass$Drinking_Days,
  xlab="GPA",
  ylab="Drinking Days",
  main="Jared Paubel",
  pch=16
)


# Make a side-by-side boxplots comparing the GPA between students with
# Missing days greater than 3 to those with Missing Days less than 3
# What does this plot show?
boxplot(
  cleanedClass$GPA ~ cleanedClass$More_than_3_Missing_Days,
  xlab="Missed More than 3 Days",
  ylab="GPA",
  main="Boxplot of GPA and 3 Missing Days or More"
)
# The average GPA for those who missed less than 3 days is higher than the
#  average of those who missed more then 3 days.

