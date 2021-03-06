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
## PLOT FOUR PLOTS IN ONE WINDOW
##-------------------------------------------------------------------

par(mfrow = c(2,2))

##---------
## PLOT1
##---------

plot(february_power$Global_active_power ~ february_power$datetime, type="l",
     xlab="", ylab = "Global Active Power (kilowatts)")

##---------
## PLOT2
##---------

plot(february_power$Voltage ~ february_power$datetime, type="l",
     xlab="datetime", ylab = "Voltage")


##---------
## PLOT3
##---------

plot(february_power$Sub_metering_1 ~ february_power$datetime, type="l", xlab="", ylab ="Energy sub metering")
lines(february_power$Sub_metering_2 ~ february_power$datetime, type="l", col="red")
lines(february_power$Sub_metering_3 ~ february_power$datetime, type="l", col="blue")
legend("topright",lty=c(1,1,1), bty="n", col = c("black","red","blue"),xjust = 1, cex = 0.8,
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))


##---------
## PLOT4
##---------

plot(february_power$Global_reactive_power ~ february_power$datetime, type="l",
     xlab="datetime", ylab = "Global_reactive_power")

##--------------------------------------------------------------------
## SAVE THE PLOT TO A PNG FILE OF SPECIFIED WIDTH CALLED 'PLOT4'
##--------------------------------------------------------------------

dev.copy(png, file = "plot4.png",width=480, height = 480)
dev.off()
