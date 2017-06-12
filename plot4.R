rm(list=ls(all=TRUE))
setwd("C:/Users/Karakatsougkas/Dropbox/Data Analysis material/Exploratory Data Analysis")

power0 <- read.table("household_power_consumption.txt", sep = ";", na.strings = "?", 
                     skip = tail(grep("[0-9]+/1/2007", readLines("household_power_consumption.txt")), n=1), 
                     nrows = max(grep("^(2/2/2007)", readLines("household_power_consumption.txt")))
                     - tail(grep("[0-9]+/1/2007", readLines("household_power_consumption.txt")), n=1), 
                     stringsAsFactors = FALSE)
power <- power0
names(power) <- read.table("household_power_consumption.txt", sep = ";", stringsAsFactors = FALSE, nrows = 1)
#Merge Date and Time together, to avoid clashes with conversion of Time alone (which adds today's date automatically).
power$Date <- paste(power$Date, power$Time)
power <- power[,-2]  #removes Time col
power$Date <- as.POSIXct(power$Date, format = "%d/%m/%Y %H:%M:%S")  #Use POSIXct class to plot dates.


#Plot 4:
par(mfrow = c(2,2))
par(pty = "m")
par(cex = 0.45)
with(power, {
        source("plot2.R")
        plot(Voltage ~ Date, type = "l", xlab = "datetime", ylab = "Voltage" )
        source("plot3.R")
        plot(Global_reactive_power ~ Date, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
})



#Print
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()


