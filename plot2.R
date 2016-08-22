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
##------------------------------------------

Power <- read.table(file = "household_power_consumption 2.txt", sep = ";", header = TRUE, na.strings = "?")

##------------------------------------------------------------------
## CONVERT THE DATES COLUMN FROM A FACTOR OBJECT TO A DATES OBJECT
##------------------------------------------------------------------

Power$Date <- as.Date(Power$Date, format = "%d/%m/%Y")

##------------------------------------------------------
## SUBSET THE DATA FOR FEB. 01, 2007 AND FEB. 02, 2007
##------------------------------------------------------

february_power <- subset(Power, subset = Date >= "2007-02-01" & Date <= "2007-02-02")

##-------------------------------------------------------------------
## CONVERT THE DATE AND TIME COLUMNS INTO A SINGLE DATE/TIME OBJECT
##-------------------------------------------------------------------

datetime <- paste(february_power$Date, february_power$Time)
february_power$datetime <- as.POSIXct(datetime)

##-------------------------------------------------------------------
## PLOT DATE/TIME VERSUS GLOBAL ACTIVE POWER
##-------------------------------------------------------------------

plot(february_power$Global_active_power ~ february_power$datetime, type="l",
     xlab="", ylab = "Global Active Power (kilowatts)")

##--------------------------------------------------------------------
## SAVE THE PLOT TO A PNG FILE OF SPECIFIED WIDTH CALLED 'PLOT2'
##--------------------------------------------------------------------

dev.copy(png, file = "plot2.png",width=480, height = 480)
dev.off()










