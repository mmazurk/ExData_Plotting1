
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

# Plot 1 Screen #### 

hist(final.data$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")

# Plot 1 PNG ####
png(filename = "plot1.png")

hist(final.data$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")

dev.off()




