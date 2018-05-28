# Johns Hopkins University Coursera Data Science Specialization
# Exploratory Data Analysis course, Project 1
# Andy Tinkham, May 27, 2018

# Retrieve the data if it doesn't already exist in the working directory
if (!file.exists("./household_powerconsumption.zip")) {
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileUrl, destfile = "household_powerconsumption.zip",
                      method = "curl")

        # Unzip the data. Overwrite any files that might already exist with the
        # same names to make sure we're using the latest data we just downloaded
        unzip("./household_powerconsumption.zip", overwrite = TRUE)

        # To keep the environment clean, I'll remove variables when I'm finished
        # with them throughout this script
        rm(fileUrl)
}

fulldata <- read.table("./household_power_consumption.txt", header = TRUE,
                       sep = ";", na.strings = "?")

# Per the project instructions, we only want data from Feb 1, 2007 and Feb 2, 2007
working_data <- subset(fulldata, Date == "1/2/2007" | Date == "2/2/2007")

rm(fulldata)

# Combine the date & time fields into a timestamp
working_data$DateTime <- strptime(paste(working_data$Date, working_data$Time),
                                  "%d/%m/%Y %H:%M:%S")

# default width & height already match assignment instructions of 480 each
png(file = "./plot4.png")
par(mfrow = c(2,2))

# First graph - same as Plot 2 with different y-axis label
plot(working_data$DateTime, working_data$Global_active_power, type = "l",
     ylab = "Global Active Power", xlab = "")

# Second graph
plot(working_data$DateTime, working_data$Voltage, type = "l", xlab = "datetime",
     ylab = "Voltage")

# Third graph - same as Plot 3, but with smaller legend & no box around legend
plot(working_data$DateTime, working_data$Sub_metering_1, type = "l",
     col = "black", xlab = "", ylab = "Energy sub metering")
lines(working_data$DateTime, working_data$Sub_metering_2, col = "red")
lines(working_data$DateTime, working_data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lwd = 1, bty = "n")
# For plotting within RStudio, set cex = 0.65 in above legend call to make
# legend appear correct size. Not needed when plotting to png directly for some
# reason.

# Fourth graph
plot(working_data$DateTime, working_data$Global_reactive_power, type = "l",
     xlab = "datetime", ylab = "Global_reactive_power")

dev.off()
