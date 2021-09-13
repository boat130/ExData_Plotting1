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

#Plot3
plot(as.numeric(file2$Sub_metering_1) ~ file2$DateTime, type = "l", ylab = "Energy sub metering", xlab = "")
lines(as.numeric(file2$Sub_metering_2) ~ file2$DateTime, col = "red")
lines(as.numeric(file2$Sub_metering_3) ~ file2$DateTime, col = "blue")
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()