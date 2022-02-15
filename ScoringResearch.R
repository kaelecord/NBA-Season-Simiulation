setwd("C:/Users/kaele/OneDrive/Documents/WASHBURN/FALL 2021/MA 342/Project DataSets")

scoring <- read_excel("Scoring.xlsx")


stephpois <-(1/10)*fullset$PPG[384]*rpois(10000,10)
hist(scoring$StephCurry, main = "Steph Curry Per Game Scoring", breaks = c(0:65),probability = TRUE)
lines(density(stephpois),col = "Blue",lwd=2)

lupois <- (1/10)*fullset$PPG[276]*rpois(10000,10)
hist(scoring$LuDort, main = "Lu Dort Per Game Scoring",breaks = c(0:65),probability = TRUE)
lines(density(lupois),col = "Blue",lwd = 2)



lonzopois <- (1/10)*fullset$PPG[274]*rpois(10000,10)
hist(scoring$LonzoBall,na.rm = TRUE, main = "Lonzo Ball Per Game Scoring", breaks = c(0:65), probability = TRUE)
lines(density(lonzopois), col="Blue", lwd = 2)

dannypois <- (1/10)*fullset$PPG[82]*rpois(10000,10)
hist(scoring$DannyGreen,na.rm = TRUE, main = "Danny Green Per Game Scoring", breaks = c(0:65),probability = TRUE)
lines(density(dannypois),col = "Blue",lwd = 2)


hist(scoring$JoshHart,na.rm = TRUE, main = "Josh Hart Per Game Scoring", breaks = c(0:65))

sd(scoring$LuDort,na.rm = TRUE)
sd(scoring$LonzoBall,na.rm = TRUE)
sd(scoring$DannyGreen,na.rm = TRUE)
sd(scoring$JoshHart,na.rm = TRUE)

