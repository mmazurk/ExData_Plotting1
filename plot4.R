
# Mazurk3
# Project #1 of Exploratory Data Analysis
# Set the current working directory

setwd("~")

# Grab just a few rows so we can look at the dataset
sample.file <- read.table(file = "/Users/Mazurk/Downloads/household_power_consumption.txt", nrows = 100, sep = ";", header = TRUE, na.strings = "", stringsAsFactors = FALSE)

# Begin Actual Code ####

# Look at what we have
names(sample.file)

# In order to read just the subset of data we want, we will have to somehow tell it just to grab the Date column where the values equal to 02-01-2007 to 02-02-2007. This dataset is also in DAY/MONTH/YEAR format.

# Find out the class of the current Date column ... it's character
class(sample.file$Date)

# Here is how you convert things into dates
as.Date(sample.file$Date)

# So let's try this again, but only pull the rows we need
# First let's grep the datafile to see which rows have the dates we want
rows.we.want <- grep("^(1|2)/2/2007", readLines("/Users/Mazurk/Downloads/household_power_consumption.txt"))

# readLines() includes the header, so we have to subtact it out if we want to use this to specify which rows of data we want
rows.we.really.want <- rows.we.want - 1

# Now we can just read in the data we want

# First let's get the headers
headers <- read.table(file = "/Users/Mazurk/Downloads/household_power_consumption.txt", nrows = 1, sep = ";", header = FALSE, stringsAsFactors = FALSE)

# Make headers into a character vector instead of a data frame
headers <- as.character(headers)

# Now let's grab our data
final.data <- read.table(file = "/Users/Mazurk/Downloads/household_power_consumption.txt", skip = (rows.we.really.want[1]), nrows = length(rows.we.really.want), sep = ";", header = FALSE, na.strings = "", stringsAsFactors = FALSE)

# And put the headers back on top of our data set
names(final.data) <- headers

# Plot 4 Screen ####

par(mfrow = c(2,2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))

# Graph 1

final.data$Weekday <- weekdays(as.Date(final.data$Date, format = "%d/%m/%Y"))
plot(final.data$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "", xaxt = "n")
axis(1, at = c(0, 1441, 2881), labels = c("Thu", "Fri", "Sat"))  

# Graph 2

plot(final.data$Voltage, type = "l", ylab = "Voltage", xlab = "datetime", xaxt = "n")
axis(1, at = c(0, 1441, 2881), labels = c("Thu", "Fri", "Sat"))

# Graph 3

plot(final.data$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "", xaxt = "n")

points(final.data$Sub_metering_2, type = "l", col = "red")
points(final.data$Sub_metering_3, type = "l", col = "blue")

axis(1, at = c(0, 1441, 2881), labels = c("Thu", "Fri", "Sat"))

legend(x = "topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, bty = "n")

# Graph 4

plot(final.data$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime", xaxt = "n")
axis(1, at = c(0, 1441, 2881), labels = c("Thu", "Fri", "Sat"))

# Section Graphics to PNG ####

# Now let's make PNG files

# Plot 4 PNG ####

png(filename = "plot4.png")

par(mfrow = c(2,2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))

# Graph 1

final.data$Weekday <- weekdays(as.Date(final.data$Date, format = "%d/%m/%Y"))
plot(final.data$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "", xaxt = "n")
axis(1, at = c(0, 1441, 2881), labels = c("Thu", "Fri", "Sat"))  

# Graph 2

plot(final.data$Voltage, type = "l", ylab = "Voltage", xlab = "datetime", xaxt = "n")
axis(1, at = c(0, 1441, 2881), labels = c("Thu", "Fri", "Sat"))

# Graph 3

plot(final.data$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "", xaxt = "n")

points(final.data$Sub_metering_2, type = "l", col = "red")
points(final.data$Sub_metering_3, type = "l", col = "blue")

axis(1, at = c(0, 1441, 2881), labels = c("Thu", "Fri", "Sat"))

legend(x = "topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, bty = "n")

# Graph 4

plot(final.data$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime", xaxt = "n")
axis(1, at = c(0, 1441, 2881), labels = c("Thu", "Fri", "Sat"))

dev.off()



