#Read the files in R
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Emissions from coal combustion-related sources 
coalcombust  <- grepl("coal", SCC$Short.Name, ignore.case=TRUE)
coalcombustSCC <- SCC[coalcombust, ]$SCC
coalcombustNEI <- NEI[NEI$SCC %in% coalcombustSCC, ]

#Plot and save in PNG format
png(file="plot4.png", width = 640, height = 480, units = "px")

library(ggplot2)
g <- ggplot(coalcombustNEI,aes(factor(year),Emissions)) +
    geom_bar(stat="identity") +
    theme_bw() +  guides(fill=FALSE) +
    labs(x="year", y=expression("Total PM2.5 Emission (in tons)")) + 
    labs(title=expression("PM2.5 Emissions from Coal Combustion-Related Sources Across US from 1999 to 2008"))

print(g)
dev.off()
