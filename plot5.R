## =====================================================================
## Function:	plot5.R function()
## ---------------------------------------------------------------------
## Assignment Description:
#
# Using NEI data for 1999, 2002, 2005 and 2008 - address the following 
# question
#
#	"Have emissions from motor vehicle sources changed from 1999 
#	to 2008 in Baltimire City? 
#
# Plot is to be saved as png named "plot5.png"
#
## ---------------------------------------------------------------------
plot5 <- function() {
	
	# Read the RDS files.  Only need NEI, since this is by year from 
	# all sources and I will later subset location to only Baltimore 
	# City, Maryland.
	
	NEI <- readRDS("summarySCC_PM25.rds")

	# subset to just Baltimore City
	# type= "ONROAD" was taken to mean motor vehicles, so the 
	# data are subsetted on that as well
	baltcity.NEI <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",]
	
	# use melt(tapply()) to reshape to sum by year
	sumbySource <- melt(tapply(baltcity.NEI$Emissions, 
				    baltcity.NEI$year, sum))
	
	# Give the columns nicer names than "Var1" etc
	names(sumbySource) <- c("Year", "Emissions")
	
	# open png graphic device
	png(filename = "plot5.png", 
	    width = 640, height = 400, units = "px",
	    type = "quartz")

	# ggplot system build up the graph(s)
	p5 <- ggplot(sumbySource, aes(Year, Emissions))	
	p5 <- p5 + geom_point(size=4)
	p5 <- p5 + geom_line()
	p5 <- p5 + labs(title = "Motor Vehicle Pollutant Emissions, Baltimore City, MD 1999-2008")
	p5 <- p5 + labs(y = "Total Annual Emissions (tons)")
	print(p5)
	
	# done with the plot; output the file by closing graphic device
	dev.off()
	
	# added this just to remove the cryptic message automatically 
	# echoed to console when dev.off() executes.
	paste("File plot5.png created in directory", getwd(), sep=" ")
}