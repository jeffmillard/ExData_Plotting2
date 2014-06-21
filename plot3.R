## =====================================================================
## Function:	plot3.R function()
## ---------------------------------------------------------------------
## Assignment Description:
#
# Using NEI data for 1999, 2002, 2005 and 2008 - address the following 
# question
#
#	"Of the four types of sources indicted by the "type" (point, 
#	nonnpoint, onroad, offraod) variable,, which of these four 
#	sources have seen decreases in emissions from 1999 to 2008 for
#	Baltimire City?  Whcih have seen increases in emissions from
#	1999-2008? 
#
# 	Use the ggplot2 plotting system to make a plot answering this
#	question."
#
# Plot is to be saved as png named "plot3.png"
#
## ---------------------------------------------------------------------
plot3 <- function() {
	
	# Read the RDS files.  Only need NEI, since this is by year from 
	# all sources and I will later subset location to only Baltimore 
	# City, Maryland.
	
	NEI <- readRDS("summarySCC_PM25.rds")

	# subset to just Baltimore City
	baltcity.NEI <- NEI[NEI$fips=="24510",]
	
	# use melt(tapply()) to reshape to sum by year for each source
	sumbySource <- melt(tapply(baltcity.NEI$Emissions, 
				    list(baltcity.NEI$year, baltcity.NEI$type), 
				    sum))
	# Give the columns nicer names than "Var1" etc
	names(sumbySource) <- c("Year", "Type", "Emissions")
	
	# *** Fun facts - alternative approach is to use aggregate(): ***
	# aggr.sumbySrc <- aggregate(Emissions ~ year + type, 
	#					baltcity.NEI, sum)
	# but melt(tapply()) is way faster
	#
	# Example applied to entire NEI dataframe (one test only)
	#				user  	system 	elapsed 
	# melt(tapply())		3.395   	0.379   	3.790 
	# aggregate()		63.077   	1.214  	72.122 
	# ***           		End of fun facts                      ***
	
	# open png graphic device
	png(filename = "plot3.png", 
	    width = 800, height = 400, units = "px",
	    type = "quartz")

	# ggplot system build up the graph(s)
	p3 <- ggplot(sumbySource, aes(Year, Emissions))	
	p3 <- p3 + geom_point(aes(color = Type), size=4) 
	p3 <- p3 + geom_line(aes(color = Type))
	p3 <-	p3 + facet_grid(. ~ Type)
	p3 <- p3 + labs(title = "Pollutant Emissions by Source Type, Baltimore City, MD 1999-2008")
	p3 <- p3 + labs(y = "Total Annual Emissions (tons)")
	print(p3)
	
	# done with the plot; output the file by closing graphic device
	dev.off()
	
	# added this just to remove the cryptic message automatically 
	# echoed to console when dev.off() executes.
	paste("File plot3.png created in directory", getwd(), sep=" ")
}