#Read the files in R
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Aggregate the total emissions by year
totalemmisions <- aggregate(Emissions ~ year,NEI, sum)

#Plot and save in PNG format
png(file="plot1.png", width = 480, height = 480, units = "px")
barplot(totalemmisions$Emissions, names.arg=totalemmisions$year,
        main="Total PM2.5 Emissions From All Sources in US",
        xlab="Year",
        ylab="PM2.5 Emissions (in tons)",
        col="blue")
dev.off()

