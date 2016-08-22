install.packages("dplyr")
install.packages("data.table")
install.packages("stringr")
install.packages("ggplot2")
install.packages("lubridate")

library(dplyr)
library(stringr)
library(data.table)
library(ggplot2)
library(lubridate)

##-------------------------------------------
## READ HOUSEHOLD POWER DATA FROM TEXT FILE 
##-------------------------------------------

Power <- read.table(file = "household_power_consumption 2.txt", sep = ";", header = TRUE, na.strings = "?")

##------------------------------------------------------------------
## CONVERT THE DATES COLUMN FROM A FACTOR OBJECT TO A DATES OBJECT
##------------------------------------------------------------------

Power$Date <- as.Date(Power$Date, format = "%d/%m/%Y")

##------------------------------------------------------
## SUBSET THE DATA FOR FEB. 01, 2007 AND FEB. 02, 2007
##------------------------------------------------------

february_power <- subset(Power, subset = Date >= "2007-02-01" & Date <= "2007-02-02")

##--------------------------------------------------------------
## DRAW A HISTOGRAM OF GLOBAL ACTIVE POWER FOR THE SUBSET DATA
##--------------------------------------------------------------

hist(february_power$Global_active_power, col ="red", main = "Global Active Power", 
     xlab="Global Active Power (kilowatts)")

##--------------------------------------------------------------------
## SAVE THE HISTOGRAM TO A PNG FILE OF SPECIFIED WIDTH CALLED 'PLOT1'
##--------------------------------------------------------------------

dev.copy(png, file = "plot1.png",width=480, height = 480)
dev.off()





