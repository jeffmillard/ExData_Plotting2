## =============================================================================
## Function:	plot1.R function()
## -----------------------------------------------------------------------------
## Assignment Description:
#
# Using NEI data for 1999, 2002, 2005 and 2008 - address the following question
#
#	"Have total emissions from PM2.5 decreased in the United States from 1999 
#	to 2008? Using the base plotting system, make a plot showing the total
#	PM2.5 emission from all sources for each of the years 1999, 2002, 2005
#	and 2008."
#
# Plot is to be saved as png named "plot1.png"
#
## -----------------------------------------------------------------------------
plot1 <- function() {
	
	# Read the RDS files.  Only need NEI, since this is by year from all
	# sources and at all locations.  Note that every entry is for PM2.5
	
	# Useful note, if file is present "summarySCC_PM25.rds" %in% dir() is TRUE
	
	NEI <- readRDS("summarySCC_PM25.rds")
	# SCC <- readRDS("Source_Classification_Code.rds")

	meanbyYear <- tapply(NEI$Emissions, NEI$year, mean)
	
	png(filename = "plot1.png",
	    width = 640, height = 480, units = "px",
	    bg = "white",  type = "quartz")

	plot(names(meanbyYear), meanbyYear, type='b', col="blue",
	     pch=15, main="Total Annual PM2.5 Emissions",
	     xlab="Year", ylab="Emissions (millions of tons)")	
	
	# done with the plot; output the file by closing graphic device
	dev.off()
	
	# added this just to remove the cryptic message automatically 
	# echoed to console when dev.off() executes.
	paste("File plot1.png created in directory", getwd(), sep=" ")
}