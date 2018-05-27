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

png(file = "./Plot1.png")
hist(working_data$Global_active_power, main = "Global Active Power", col = "red",
     xlab = "Global Active Power (kilowatts)")
dev.off()
