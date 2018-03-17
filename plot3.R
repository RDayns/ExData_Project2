#Read the files in R
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Get data on Baltimore City only
baltimore <- NEI[NEI$fips=="24510",]

# Aggregate the total emissions by year and type
baltimoreTE <- aggregate(Emissions ~ year ,baltimore, sum)

#Plot using GGPLOT2 and save in PNG format
png(file="plot3.png", width = 480, height = 480, units = "px")

library(ggplot2)
g <- ggplot(baltimore,aes(factor(year),Emissions,fill=type)) +
    geom_bar(stat="identity") +
    theme_bw() + guides(fill=FALSE)+
    facet_grid(.~type) + 
    labs(x="year", y=expression("Total PM2.5 Emission (in tons)")) + 
    labs(title=expression("PM2.5 Emissions in Baltimore City from 1999 to 2008 by Source Type"))
print(g)
dev.off()
