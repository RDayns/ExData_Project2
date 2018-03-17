#Read the files in R
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Emissions from motor vehicle sources 
vehicles  <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[vehicles, ]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC, ]

#Get data on Baltimore City only
baltimore <- vehiclesNEI[vehiclesNEI$fips=="24510",]

#Plot and save in PNG format
png("plot5.png",width=640,height=480,units="px")

library(ggplot2)

g <- ggplot(baltimore,aes(factor(year),Emissions)) +
    geom_bar(stat="identity", fill="goldenrod") +
    theme_grey() +  guides(fill=FALSE) +
    labs(x="year", y=expression("Total PM2.5 Emission (in tons)")) + 
    labs(title=expression("PM2.5 Emissions from Motor Vehicle Sources in Baltimore City, Maryland from 1999 to 2008"))

print(g)
dev.off()