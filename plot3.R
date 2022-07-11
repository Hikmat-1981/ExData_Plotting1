
# First I need to read the <txt> file into R and load required libraries--
# To build a histogram of variable I need only one variable / one data series --

# Frequency series is calculated automatically by programming Language like an R --
# However -- If I do believe this variable is dependent 2nd variable that is 0k--

# If the 2nd variable can be factor variable,numerical(integer) and so on.
# If the second variable in factor/chr that means I am 2 group the variable/data series on R--

# The same applies for 2 dimensional data just like scatter plot -- relationship between 2
# If third variable is <chr/factor> then means I am 2 group the relationship based on it --

library(hms)
library(lubridate)

# I do set working directory and compute memory size for the file 2 be downloaded --

setwd("C:/Users/SAMSUNG/Desktop/RStudo_CFA")
object.size("./household_power_consumption.txt")

# Here I read the file into R and have a look at its dimension (rows and cols)
# header=T means first row in file should be read as col heading, separated by ; and ? converted to NA

hpc<-read.table("./household_power_consumption.txt",header = TRUE,sep=";",na.strings = "?")
dim(hpc);hpc<-tibble::tibble(hpc) 

# Here I do subset the data frame for 2 days since I am going to need 2 day consumption only --
# Call the subset file as <hpc_subset>--
hpc_subset<-subset(hpc,Date=="1/2/2007"|Date=="2/2/2007")

# Then convert Date column format from <chr> in hpc_subset data frame into date format --
# To do this I use as.Date()command -- and convert <ddtime> using striptime()command 

hpc_subset$Time <- strptime(paste(hpc_subset$Date, hpc_subset$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
hpc_subset$Date<-as.Date(hpc_subset$Date,"%d/%m/%Y")

# First I do open new png file 2 store a histogram I am 2 build off --
png(filename="plot3.png",width=480,height = 480)

# Building a histogram based on 2 day every minute measurements --
with(hpc_subset,plot(Time,Sub_metering_1,type="n",ylab="Global active power(kilowatts)"))

with(hpc_subset,lines(Time,Sub_metering_1))
with(hpc_subset,lines(Time,Sub_metering_2,col="red"))
with(hpc_subset,lines(Time,Sub_metering_3,col="blue"))

legend("topleft",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","blue","red"),pch=19)

# Now closing the file containing the scatterplot
dev.off()

