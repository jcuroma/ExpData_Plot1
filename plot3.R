## Exploratory Data Analysis -- Project 1 - Plot3.R 
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


# Change the Energy Sub_metering_1 to _2 into Numeric
str(sub_project1)
sub_project1$Sub_metering_1 <- as.numeric(sub_project1$Sub_metering_1, na.rm=T)
sub_project1$Sub_metering_2 <- as.numeric(sub_project1$Sub_metering_2, na.rm=T)


# Simplify the variable names
y1 <- sub_project1$Sub_metering_1
y2 <- sub_project1$Sub_metering_2
y3 <- sub_project1$Sub_metering_3
x1 <- sub_project1$DateTime


# Create a line plot
png("plot3.png", width = 480, height = 480)
plot(x1, y1, type="l", col="black", ylim = c(0,40),
     yaxt="n", xlab="", ylab="Energy sub metering")
axis(side=2, at=seq(0,30, 10), labels=seq(0,30,10))
lines(x1, y2, col = "red")
lines(x1, y3, col = "blue")
legend('topright', c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=c(1,1,1), col=c("black", "red", "blue"))
dev.off()


