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

#Plot2
plot(as.numeric(file2$Global_active_power) ~ file2$DateTime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()