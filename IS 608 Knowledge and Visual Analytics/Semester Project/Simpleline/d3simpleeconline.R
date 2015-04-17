library(ggplot2)
library(ggthemes)
library(dplyr)

setwd("E:/Downloads/Courses/CUNY/SPS/Git/IS 608 Knowledge and Visual Analytics/Semester Project")

agent <- read.csv("agentdataprop.csv")

econ <- read.csv("econdataprop.csv")

econ$Date <- strptime(econ$Date, format="%m/%d/%Y")

agent02 <- agent %>%
  select(ActualDateDisplay, ExportScore) %>%
  group_by(ActualDateDisplay) %>%
  summarize(MeanCVS = mean(ExportScore))

agent02$ActualDateDisplay <- strptime(agent02$ActualDateDisplay, format="%m/%d/%Y")

agent02 <- agent02[order(agent02$ActualDateDisplay),]

colnames(agent02) <- c("Date", "MeanCVS")

econ <- econ[1:20,]

econ$Date <- as.character(econ$Date)

agent02$Date <- as.character(agent02$Date)

combined <- merge(econ, agent02, by="Date")

combined$Date <- strptime(combined$Date, format="%Y-%m-%d")

setwd("E:/Downloads/Courses/CUNY/SPS/Git/IS 608 Knowledge and Visual Analytics/Semester Project/simpleline")

write.csv(select(combined, Date, Exports, MeanCVS),"d3econdata.csv", row.names=FALSE)
