nlsClean <- read.csv("Assignments/Assignment 3/NLSClean.csv")

areaTable <- table(nlsClean$Area)
barplot(areaTable, xlab="Area", ylab="Observations", col=c("blue", "orange"))

hist(nlsClean$Height, col = "purple", xlab="Height", main="Histogram of Height")

plot(nlsClean$Weight, nlsClean$FamilySize, xlab="Weight", ylab="Family Size", main="Plot of Weight against Family Size", pch=16, xlim=c(105,240))
