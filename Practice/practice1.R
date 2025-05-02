library(forecast)
library(readxl)
myData <- read_excel()("C:/Users/Jared/Documents/R Projects/STAT-351/Practice/jaggia_ba_2e_ch10_data.xlsx")

# Use ts to create time series object
newData <- ts(myData$Revenue)