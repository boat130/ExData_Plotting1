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

#Plot1
hist(as.numeric(file2$Global_active_power), col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()