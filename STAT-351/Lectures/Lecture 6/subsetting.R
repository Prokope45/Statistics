GamePlayers <- read.csv("Lectures/Lecture 6/GamePlayers.csv")

#Subset the data on the type of game purchased
action = which(GamePlayers$Type == "Action")
rpg = which(GamePlayers$Type == "Role Play")
sports = which(GamePlayers$Type == "Sports")

#Make separate data frames
gpaction = GamePlayers[action,]
gprpg = GamePlayers[rpg,]
gpsports = GamePlayers[sports,]

#Look at satisfaction across Type
prop.table(table(gpaction$Satisfaction))
prop.table(table(gprpg$Satisfaction))
prop.table(table(gpsports$Satisfaction))

#Spending this year across Type
mean(gpaction$SpendingThisYear)
mean(gprpg$SpendingThisYear)
mean(gpsports$SpendingThisYear)

#Subset the data on spending this year above and below 500
whichHighSpend = which(GamePlayers$SpendingThisYear > 500)
whichLowSpend = which(GamePlayers$SpendingThisYear <= 500)

#Make Separate data frames
highspend = GamePlayers[whichHighSpend, ]
lowspend = GamePlayers[whichLowSpend,]



#Look at proportion of Type bought by high/low spending
prop.table(table(highspend$Type))
prop.table(table(lowspend$Type))

#Look at proportion of Satisfaction bought by high/low spending
prop.table(table(highspend$Satisfaction))
prop.table(table(lowspend$Satisfaction))

#Low spenders seemed to be more satisfied than high spenders.

#Subset the data on spending this year above 500 and bought an action game
whichHighSpendAction = which(GamePlayers$SpendingThisYear > 500 &
                               GamePlayers$Type == "Action")
highSpendAction = GamePlayers[whichHighSpendAction,]

#Take mean and sd of this year spending by Type
aggregate(GamePlayers$SpendingThisYear, by = list(GamePlayers$Type), mean)
aggregate(GamePlayers$SpendingThisYear, by = list(GamePlayers$Type), sd)

#Take mean by both spending this year and satisfaction
aggregate(GamePlayers$SpendingThisYear, 
          by = list(GamePlayers$Type, GamePlayers$Satisfaction), mean)

