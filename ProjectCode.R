## MA 342 PROJECT ##

setwd("C:/Users/kaele/OneDrive/Documents/WASHBURN/FALL 2021/MA 342/Project DataSets")
set.seed(1567)

require(readxl)
require(tidyverse)
require(ggplot2)

SeasonData <- read_excel("SeasonData.xlsx")
SalaryData <- read_excel("SalaryData.xlsx")
Schedule <- read_excel("Schedule.xlsx")

## DATA CLEANUP ## 
##########  Removing players that played for multiple teams during the season ###########
for (i in 1:length(SeasonData$Tm)){
  if(SeasonData$Tm[i] =="TOT"){
    SeasonData$Tm[i] = "ZZTOT"
  }
}
SeasonData <- SeasonData[order(SeasonData$Tm,decreasing = TRUE),]
SeasonData <- SeasonData[!duplicated(SeasonData$Player),]
for (i in 1:length(SeasonData$Tm)){
  if(SeasonData$Tm[i] == "ZZTOT"){
    SeasonData$Tm[i] = "TOT"
  }#Change abreviation for Charolette Hornets
  if(SeasonData$Tm[i]=="CHO"){
    SeasonData$Tm[i]="CHA"
  }
}
#######################################################################################################
## change position to include only primary position ##
## Example PG-SG becomes PG ##
for(i in 1:length(SeasonData$Position)){
  SeasonData$Position[i] <- substr(SeasonData$Position[i],1,2)
  if(SeasonData$Position[i]=="C-"){
    SeasonData$Position[i] = "C"
  }
}
## if 0 shots of one type were taken make percentage 0 instead of NA ##
for( i in 1:length(SeasonData$`3P`)){
  if (SeasonData$`3PA`[i] == 0){
    SeasonData$`3P%`[i] = 0
  }
}
for (i in 1:length(SeasonData$`2P`)){ 
  if(SeasonData$`2PA`[i] == 0){
    SeasonData$`2P%`[i] = 0
  }
}
for (i in 1:length(SeasonData$FT)){
  if(SeasonData$FTA[i] == 0){
    SeasonData$`FT%`[i] = 0
  }
}

## takes out players with salary and no stats ##

fullset <- merge.data.frame(SalaryData,SeasonData,by = "Player")
fullset$PPG <- fullset$PTS/fullset$G

Team <- fullset[order(fullset$Tm,decreasing = FALSE),] ##subset out Tm == TOT 
Team <- Team[!duplicated(Team$Tm),7]
Standings <- as.data.frame(Team)
Standings <- subset(Standings, Standings$Team != "TOT")
Standings$Wins <- 0
Standings$Loses <- 0  ## calculate by taking 72 - wins
Standings$PF <- 0
Standings$PA <- 0

#######################################################################################################
#################################### SIMULATE SEASON GAME #############################################

for(k in 1:length(Schedule$Visitor)){
  hometeam <- subset(fullset, fullset$Tm == Schedule$Home[k])
  for(i in 1:length(hometeam$PPG)){
    hometeam$Points[i] = floor((1/10)*hometeam$PPG[i]*rpois(1,10))
  }
  hometeam$totalpoints <- sum(hometeam$Points)

  visitingteam <- subset(fullset, fullset$Tm == Schedule$Visitor[k])
  for(i in 1:length(visitingteam$PPG)){
    visitingteam$Points[i] = floor((1/10)*visitingteam$PPG[i]*rpois(1,10))
  }
  visitingteam$totalpoints <- sum(visitingteam$Points)

  if(hometeam$totalpoints[1] >= visitingteam$totalpoints[1]){
    hometeam$Wins <- 1
    visitingteam$Wins <- 0
  }else{
    hometeam$Wins <- 0 
    visitingteam$Wins <- 1
  }
  for(i in 1:length(Standings$Team)){
    if(Standings$Team[i] == hometeam$Tm[1]){
      Standings$Wins[i] = Standings$Wins[i] + hometeam$Wins[1]
      Standings$PF[i] = Standings$PF[i] + hometeam$totalpoints[1]
      Standings$PA[i] = Standings$PA[i] + visitingteam$totalpoints[1]
    }
    if(Standings$Team[i] == visitingteam$Tm[1]){
      Standings$Wins[i] = Standings$Wins[i] + visitingteam$Wins[1]
      Standings$PF[i] = Standings$PF[i] + visitingteam$totalpoints[1]
      Standings$PA[i] = Standings$PA[i] + hometeam$totalpoints[1]
    }
  }
}
for(i in 1:length(Standings$Loses)){
  Standings$Loses[i] <- 72-Standings$Wins[i]
}
Standings$PD <- Standings$PF-Standings$PA #Point Differential
Standings$WAM <- Standings$Wins-36 #Wins above .500

###################### GRAPHICS ########################################################
ggplot(data = Standings, aes(x=`PD`, y=`Wins`)) +
  geom_point(aes(color = `Team`)) +
  ggtitle("Wins vs Point Differential", subtitle = "Simulated 2020-2021 NBA Season") +
  xlab("Point Differential") +
  ylab("Wins")

ggplot(data = Standings, aes(x=`PF`, y=`Wins`)) +
  geom_point(aes(color = `Team`)) +
  ggtitle("Wins vs Points For", subtitle = "Simulated 2020-2021 NBA Season") +
  xlab("Points For") +
  ylab("Wins")

ggplot(data = Standings, aes(x=`PA`, y=`Wins`)) +
  geom_point(aes(color = `Team`)) +
  ggtitle("Wins vs Points Against", subtitle = "Simulated 2020-2021 NBA Season") +
  xlab("Points Against") +
  ylab("Wins")

