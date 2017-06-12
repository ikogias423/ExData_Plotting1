setwd("C:/Users/Karakatsougkas/Dropbox/Data Analysis material/Exploratory Data Analysis")


#Reading the data
power0 <- read.table("household_power_consumption.txt", sep = ";", na.strings = "?", 
                     skip = tail(grep("[0-9]+/1/2007", readLines("household_power_consumption.txt")), n=1), 
                     nrows = max(grep("^(2/2/2007)", readLines("household_power_consumption.txt")))
                     - tail(grep("[0-9]+/1/2007", readLines("household_power_consumption.txt")), n=1), 
                     stringsAsFactors = FALSE)
power <- power0 #creates safe copy

#Adds names to variables
names(power) <- read.table("household_power_consumption.txt", sep = ";", stringsAsFactors = FALSE, nrows = 1)
#Convert dates from to Date calss
Sys.setlocale("LC_TIME", "C")
power$Date <- paste(power$Date, power$Time)
power <- power[,-2]  #removes Time col
power$Date <- as.POSIXct(power$Date, format = "%d/%m/%Y %H:%M:%S")  #Use POSIXct class to plot dates.


#Plot 1:
par("cex" = 0.75)
hist(power$Global_active_power, col = "red", main = "Global Active Power",  
     xlab = "Global Active Power (kilowatts)",ylab = "Frequency", ylim = c(0,1200), tck = -0.03
)
#Print
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()
