# Review the directory
getwd()

# Read the document and save it in a object called 'document'
# Remove the missing values coded as '?', applying the function na.string = "?"
document <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

# brief analysis of the data
head(document)
class(document)
dim(document)
View(document)
str(document)
summary(document)

# Select the dates from 01/02/2007 to 02/02/2007
datesgroup <- subset(document, document$Date == "1/2/2007" | document$Date == "2/2/2007")
class(datesgroup$Date)

# Change the class of the variable 'Date' from factor to Date
datesgroup$Date <- as.Date(datesgroup$Date, format = "%d/%m/%Y")
class(datesgroup$Date)

# Convert dates and times, and create a new object called 'datetime'
datesgroup$datetime <- strptime(paste(datesgroup$Date, datesgroup$Time), "%Y-%m-%d %H:%M:%S")
datesgroup$datetime <- as.POSIXct(datesgroup$datetime)

# Review the object 'datesgroup'
View(datesgroup)


# Plot 2
plot(Global_active_power ~ datetime, data = datesgroup, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

# save the plot in png file
dev.copy(png, file = "plot2.png", height = 480, width = 480)
dev.off()
