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


# Plot 4
# To represent the 4 graphics in a distribution of 2 rows and 2 columns I will need to apply the function 'par()'
# with the function 'par()' then apply the layout with the function 'mfrow()' or 'mfcol()' 
# In this case I will apply 'mfrow()' to represent the graphics in order by rows
par(mfrow = c(2, 2), mar = c(2, 5, 1, 1), oma = c(0, 0, 1, 0))
with(datesgroup, {
  plot(Global_active_power ~ datetime, data = datesgroup, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
  plot(Voltage ~ datetime, data = datesgroup, type = "l", ylab = "Voltage", xlab = "datetime")
  plot(datesgroup$datetime, datesgroup$Sub_metering_1, type = "n", ylab = "Energy sub meterin", xlab = "")
  with(datesgroup, lines(datetime, Sub_metering_1, col = "black"))
  with(datesgroup, lines(datetime, Sub_metering_2, col = "red"))
  with(datesgroup, lines(datetime, Sub_metering_3, col = "blue"))
  legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)
  plot(Global_reactive_power ~ datetime, data = datesgroup, type = "l", ylab = "Global_reactive_power", xlab = "datetime")
})

# save the graphics
dev.copy(png, file = "plot4.png", height = 480, width = 480)
dev.off()