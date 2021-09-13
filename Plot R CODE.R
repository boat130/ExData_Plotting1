rm(list = ls())
dev.off(dev.list()["RStudioGD"])
cat("\014")
library(tidyverse)
library(lubridate)

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","File.zip")
unzip("File.zip")
file <- read.table("household_power_consumption.txt",header = TRUE, sep = ";")

file2 <- file %>% filter(Date %in% c('1/2/2007','2/2/2007'))
file2 <- file2 %>% mutate(DateTime = as.POSIXct(strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S")))
par(mfrow = c(1,1))

#Plot1
hist(as.numeric(file2$Global_active_power), col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
#Plot2
plot(as.numeric(file2$Global_active_power) ~ file2$DateTime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
#Plot3
plot(as.numeric(file2$Sub_metering_1) ~ file2$DateTime, type = "l", ylab = "Energy sub metering", xlab = "")
lines(as.numeric(file2$Sub_metering_2) ~ file2$DateTime, col = "red")
lines(as.numeric(file2$Sub_metering_3) ~ file2$DateTime, col = "blue")
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
#plot4
par(mfrow = c(2,2))
plot(as.numeric(file2$Global_active_power) ~ file2$DateTime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
plot(as.numeric(file2$Voltage) ~ file2$DateTime, type = "l", ylab = "Voltage", xlab = "datetime")
plot(as.numeric(file2$Sub_metering_1) ~ file2$DateTime, type = "l", ylab = "Energy sub metering", xlab = "")
lines(as.numeric(file2$Sub_metering_2) ~ file2$DateTime, col = "red")
lines(as.numeric(file2$Sub_metering_3) ~ file2$DateTime, col = "blue")
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")
plot(as.numeric(file2$Global_reactive_power) ~ file2$DateTime, type = "l", ylab = "Global_reactive_power", xlab = "datetime")
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()





unlink(c("File.zip","household_power_consumption.txt"))

