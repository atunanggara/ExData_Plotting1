# I used the power of sql using sqldf library
library(sqldf)
# here, I read the .txt file, then have an sql command where I subsetted
# the data for the first and second February of 2007. Since I know it's 
# dd/mm/yyyy format, I put 1/2/2007 and 2/2/2007 as the date that I want.
# I also say in the .txt that the separation between each column is by a semicolon
# Therefore, I added the command, sep = ";" 
dataset<-read.csv.sql("household_power_consumption.txt",sql="select * from file WHERE Date IN ('1/2/2007','2/2/2007')",sep=";")
# Now, I open up a png as my graphic devices with 480x480 pixels as specified
# in the assignment. I realized that 480x480 is the default, but it is good 
# practice to specify them, regardless. 
png("plot1.png",width=480,heigh=480)
# Here I created a histogram of Global active power subset from the data 
# I specified the color to be red, I labeled my x axis as Global Active Power
# and I put the title using main as Global Active Power. 
hist(dataset$Global_active_power,col="red",xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()
