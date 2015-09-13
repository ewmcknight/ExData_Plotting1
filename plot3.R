# E.W. McKnight
# 9/12/2015
#
# For course "Exploratory Data Analysis", Roger D. Peng, PhD, et al
#       Johns Hopkins Bloomberg School of Public Health
#       Coursera "Data Science Specialization"
#
# Data: “Individual household electric power consumption Data Set”
#       https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#       Courtesy of UC Irvine Machine Learning Repository, http://archive.ics.uci.edu/ml/
#
# Plots Sub_metering_1, _2, _3 vs time between 2007-02-01 and 2007-02-02
#

library(dplyr)

# Important data is located within the first 70,000 rows.
data = read.table("household_power_consumption.txt", header = TRUE, sep = ";", 
                  na.strings="?", dec = ".", fill = TRUE, nrows = 70000)

data <- data %>%
    mutate(Date_Time = as.POSIXct(paste(as.Date(Date, "%d/%m/%Y"),Time))) %>%
    filter(Date_Time >= as.POSIXct("2007-02-01 00:00"), 
           Date_Time <= as.POSIXct("2007-02-02 23:59")) %>%
    select(Date_Time, Global_active_power: Sub_metering_3)

png(file = "plot3.png", width = 480, height = 480)
plot(data$Sub_metering_1~data$Date_Time, type = "l",
     xlab = "",
     ylab="Energy sub metering",
     main="")
lines(data$Sub_metering_2~data$Date_Time, col = "red")
lines(data$Sub_metering_3~data$Date_Time, col = "blue")
legend("topright",
       col = c("black", "red", "blue"),
       lty = c(1, 1, 1),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()