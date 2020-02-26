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


# Plot 3
# Create a plot with the frame empty. Only including the names of the axis and indicate the data
# Then, with the function 'with()' add step by step each line from the variable we want include, assign a color
# Finally apply the function 'legend()' to include the description of each line in the topright of the frame
plot(datesgroup$datetime, datesgroup$Sub_metering_1, type = "n", ylab = "Energy sub meterin", xlab = "")
with(datesgroup, lines(datetime, Sub_metering_1, col = "black"))
with(datesgroup, lines(datetime, Sub_metering_2, col = "red"))
with(datesgroup, lines(datetime, Sub_metering_3, col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)

# Save the graphic in a png document
dev.copy(png, file = "plot3.png", height = 480, width = 480)
dev.off()