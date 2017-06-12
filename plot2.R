setwd("C:/Users/Karakatsougkas/Dropbox/Data Analysis material/Exploratory Data Analysis")

power0 <- read.table("household_power_consumption.txt", sep = ";", na.strings = "?", 
                     skip = tail(grep("[0-9]+/1/2007", readLines("household_power_consumption.txt")), n=1), 
                     nrows = max(grep("^(2/2/2007)", readLines("household_power_consumption.txt")))
                     - tail(grep("[0-9]+/1/2007", readLines("household_power_consumption.txt")), n=1), 
                     stringsAsFactors = FALSE)
power <- power0
names(power) <- read.table("household_power_consumption.txt", sep = ";", stringsAsFactors = FALSE, nrows = 1)
#Merge Date and Time together, to avoid clashes with conversion of Time alone (which adds today's date automatically).
Sys.setlocale("LC_TIME", "C")
power$Date <- paste(power$Date, power$Time)
power <- power[,-2]  #removes Time col
power$Date <- as.POSIXct(power$Date, format = "%d/%m/%Y %H:%M:%S")  #Use POSIXct class to plot dates.

#Plot 2:
#par("pty" = "s")
#par("cex" = 0.7)
plot(Global_active_power ~ Date, data = power, ylab = "Global Active Power (kilowatts)", 
     xlab = "", pty = "s", type = "l" ) #'type' draws line!!

#Print
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()