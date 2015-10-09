## Exploratory Data Analysis -- Project 1 - Plot4.R 
# Read the file into R and call it "project1"
project1 <- read.table("./household_power_consumption.txt", header=T, sep=";")


# Date changed into Year-month-day format
project1$Date <- as.Date(project1$Date, "%d/%m/%Y")


# Subset the data set containing Feb 1st and 2nd of 2007 only.
sub_project1 <- subset(project1, Date == "2007-02-01" | Date =="2007-02-02")


# Combine Date and Time and create a variable called DateTime
x <- paste(sub_project1$Date, sub_project1$Time)
sub_project1$DateTime <- strptime(x, "%Y-%m-%d %H:%M:%S")


# Find the day of the week by using the DateTime variable ("weekdays" function)
sub_project1$day <- weekdays(as.Date(sub_project1$DateTime))
sub_project1$day <- as.factor(sub_project1$day)


# Change a few variables into numeric
sub_project1$Sub_metering_1      <- as.numeric(sub_project1$Sub_metering_1, na.rm=T)
sub_project1$Sub_metering_2      <- as.numeric(sub_project1$Sub_metering_2, na.rm=T)
sub_project1$Global_active_power <- as.numeric(sub_project1$Global_active_power, na.rm=T)
sub_project1$Voltage             <- as.numeric(sub_project1$Voltage, na.rm=T)


# Simplify the variable names
x1 <- sub_project1$DateTime
y1 <- sub_project1$Sub_metering_1
y2 <- sub_project1$Sub_metering_2
y3 <- sub_project1$Sub_metering_3
y4 <- sub_project1$Global_active_power
y5 <- sub_project1$Voltage
y6 <- sub_project1$Global_reactive_power


## Create 4 plots on the same plane (2 by 2)
png("plot4.png", width = 480, height = 480)
par(mfrow=c(2,2), mar=c(4,4,2,2))

# Create a plot (Global active power)
plot(x1, y4, type="l", yaxt="n",
     xlab="", ylab="Global Active Power (kilowatts)")
axis(side=2, at=seq(0,3000, 1000), labels=seq(0,6,2))

# Create a plot (datetime and Voltage)
plot(x1, y5, type="l", yaxt="n", 
     xlab="datetime", ylab="Voltage")
axis(side=2, at=seq(800,2200, 200), labels=seq(234,248,2))

# Create a plot (Energy Sub metering)
plot(x1, y1, type="l", col="black", ylim = c(0,40),
     yaxt="n", xlab="", ylab="Energy sub metering")
axis(side=2, at=seq(0,30, 10), labels=seq(0,30,10))
lines(x1, y2, col = "red")
lines(x1, y3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=c(1,1,1), col=c("black", "red", "blue"), bty="n", cex=0.75)

# Create a histogram (Global_reactive_power)
plot(x1, y6, type="l", yaxt="n", col="black", xlab="datetime", ylab="Global_reactive_power")
axis(side=2, at=seq(0,250, 50), labels=seq(0.0,0.5,0.1))

dev.off()
