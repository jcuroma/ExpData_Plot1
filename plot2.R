## Exploratory Data Analysis -- Project 1 - Plot2.R 
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


# Change the Global_active_power variable into numeric
sub_project1$Global_active_power <- as.numeric(sub_project1$Global_active_power)


# Create a line plot (datetime & Global active power)
png("plot2.png", width = 480, height = 480)
plot(sub_project1$DateTime, sub_project1$Global_active_power, type="l", yaxt="n",
              xlab="", ylab="Global Active Power (kilowatts)")
         axis(side=2, at=seq(0,3000, 1000), labels=seq(0,6,2))
dev.off()
