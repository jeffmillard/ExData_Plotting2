## =====================================================================
## Function:	plot6.R function()
## ---------------------------------------------------------------------
## Assignment Description:
#
# Using NEI data for 1999, 2002, 2005 and 2008 - address the following 
# question
#
#	"Compare emissions from motor vehicle sources in Baltimore City
#	with emissions from motor vehicle sources in Los Angeles County,
#	California (fips="06037").  Which city has seen greater changes
#	over time in motor vehicle emissions?
#
# Plot is to be saved as png named "plot6.png"
#
## ---------------------------------------------------------------------
plot6 <- function() {
	
	# ----------------------------------------------------------------
	# Read the NEI RDS file, and subset to Baltimore City & LA
	# and only ON-ROAD sources
	# ----------------------------------------------------------------
	NEI <- readRDS("summarySCC_PM25.rds")

	# subset to just Baltimore City and Los Angelese
	balt.la.NEI <- NEI[NEI$fips %in% c("24510","06037") 
				 & NEI$type=="ON-ROAD",]
	
	# make the factors have more descriptive names
	balt.la.NEI$fips <- as.factor(balt.la.NEI$fips)
	
	levels(balt.la.NEI$fips) <- gsub("24510", 
			"Baltimore City", levels(balt.la.NEI$fips))

	levels(balt.la.NEI$fips) <- gsub("06037", 
			"Los Angeles", levels(balt.la.NEI$fips))
	
	# ----------------------------------------------------------------
	# Summarize and prepare the data for plotting
	# ----------------------------------------------------------------	
	# tapply to sum data
	temp <- tapply(balt.la.NEI$Emissions, 
			   list(balt.la.NEI$year, 
			        balt.la.NEI$fips), 	   
			   sum)
	
	# Now normalize plots to 1999 = 100% so we can see changes,
	# not just absolute value
	
	temp[,"Los Angeles"] <-100*test[,"Los Angeles"]/test["1999",1]
	temp[,"Baltimore City"] <-100*test[,"Baltimore City"]/test["1999",2]
	
	sumbySource <- melt(temp)

	# Give the columns nicer names than "Var1" etc
	names(sumbySource) <- c("Year", "City", "Emissions")

	# ---------------------------------------------------------------
	# Create plot
	# ---------------------------------------------------------------
	# open png graphic device
	png(filename = "plot6.png", 
	    width = 800, height = 400, units = "px",
	    type = "quartz")

	# ggplot system build up the graph(s)
	p6 <- ggplot(sumbySource, aes(Year, Emissions))	
	p6 <- p6 + geom_point(aes(color = City), size=4) 
	p6 <- p6 + geom_line(aes(color = City))
	p6 <-	p6 + facet_grid(. ~ City)
	p6 <- p6 + labs(title = "Change in Motor Vehicle Emissions, 1999-2008")
	p6 <- p6 + labs(y = "Relative Motor Vehicle Annual Emissions (%)")
	print(p6)
	
	# done with the plot; output the file by closing graphic device
	dev.off()
	
	# added this just to remove the cryptic message automatically 
	# echoed to console when dev.off() executes.
	paste("File plot3.png created in directory", getwd(), sep=" ")
}