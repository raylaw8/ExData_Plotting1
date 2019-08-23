# UC Irvine Machine Learning Repository, a popular repository for machine learning datasets. 
# In particular, we will be using the "Individual household electric power consumption Data Set" which I have made available on the course web site: 
#
# Description: Measurements of electric power consumption in one household with a one-minute sampling rate over a period of almost 4 years. Different electrical quantities and some sub-metering values are available.
#
# The following descriptions of the 9 variables in the dataset are taken from the UCI web site:
#  
# Date: Date in format dd/mm/yyyy
# Time: time in format hh:mm:ss
# Global_active_power: household global minute-averaged active power (in kilowatt)
# Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
# Voltage: minute-averaged voltage (in volt)
# Global_intensity: household global minute-averaged current intensity (in ampere)
# Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
# Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
# Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.
#
# Loading the data
# When loading the dataset into R, please consider the following:
# The dataset has 2,075,259 rows and 9 columns. First calculate a rough estimate of how much memory the dataset will require in memory before reading into R. 
# Make sure your computer has enough memory (most modern computers should be fine).
# We will only be using data from the dates 2007-02-01 and 2007-02-02. 
# One alternative is to read the data from just those dates rather than reading in the entire dataset and subsetting to those dates.
#
# You may find it useful to convert the Date and Time variables to Date/Time classes in R using the strptime() and as.Date() functions.
# Note that in this dataset missing values are coded as ?.
#
# Making Plots
# Our overall goal here is simply to examine how household energy usage varies over a 2-day period in February, 2007. 
# Your task is to reconstruct the following plots below, all of which were constructed using the base plotting system.
#
# For each plot you should
# Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
# Name each of the plot files as plot1.png, plot2.png, etc.
# Create a separate R code file (plot1.R, plot2.R, etc.) that constructs the corresponding plot, 
# i.e. code in plot1.R constructs the plot1.png plot. 
# Your code file should include code for reading the data so that the plot can be fully reproduced. 
# You should also include the code that creates the PNG file.
# Add the PNG file and R code file to your git repository
# When you are finished with the assignment, push your git repository to GitHub so that the GitHub version of your repository is up to date. 
# There should be four PNG files and four R code files.
#
##########################################################################################################
# Clean up workspace
rm(list=ls())
# 
#set working directory 
setwd("D:\\Documents\\Course4project1");

# Unzip of data
#outDir="D:\\Documents\\Course4project1\\data"
#unzip("./data/exdata_data_household_power_consumption.zip",exdir=outDir)

# Read in the data from files
power = read.table("./data/household_power_consumption.txt",header=TRUE,sep=";"); #imports power.txt

#filter date and get global_active_power
sub_global_active_power = subset(power, power$Date=="1/2/2007" | power$Date=="2/2/2007" )

#convert to numeric
conv_global_active_power = as.numeric(as.character(sub_global_active_power$Global_active_power))
conv_global_reactive_power = as.numeric(as.character(sub_global_active_power$Global_reactive_power))
conv_sub_metering_1 = as.numeric(as.character(sub_global_active_power$Sub_metering_1))
conv_sub_metering_2 = as.numeric(as.character(sub_global_active_power$Sub_metering_2))
conv_sub_metering_3 = as.numeric(as.character(sub_global_active_power$Sub_metering_3))

#convert to date
datetime = as.POSIXlt(paste(sub_global_active_power$Date, sub_global_active_power$Time, sep=" "),format="%d/%m/%Y %H:%M:%S")

#setup 2x2 plot

par(mfrow=c(2,2),cex=0.5, mai=c(0.5,0.5,0.5,0.5))

#histogram
plot(datetime,conv_global_active_power,type="l",xlab="", ylab="Global Active Power")

#voltage
conv_voltage = as.numeric(as.character(sub_global_active_power$Voltage))
plot(datetime,conv_voltage,type="l", ylab="Voltage", xlab="datetime")

#plot Energy Sub Metering
plot(datetime,conv_sub_metering_1,type="l",col="black", ylab="Energy sub metering")
lines(datetime,conv_sub_metering_2,type="l",col="red", lty=1)
lines(datetime,conv_sub_metering_3,type="l",col="blue", lty=1)
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("red","black","blue"), cex=0.25, pt.cex=0.25, lty=1)

#plot global reactive power
plot(datetime,conv_global_reactive_power,type="l",xlab="datetime", ylab="Global_Reactive_Power")


#save to png file
dev.copy(png,"plot4.png")
dev.off()