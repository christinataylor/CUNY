
workingDirectory <- "C:/Users/Charley/Downloads/Courses/CUNY/SPS/git/IS 607 Data Acquisition and Management/Week 4/Meetup Materials"
setwd(workingDirectory)

jury.data <- read.csv(file="partida-jury-info.csv",header=T)

library(reshape2)

jury.data2 <- melt(jury.data, id="juryid",na.rm=F)

colnames(jury.data2) <- c("juryid","juror","ancestry")

jury.data3 <- jury.data2[order(jury.data2$juryid, jury.data2$juror),]
row.names(jury.data3) <- NULL

jury.data3$flag <- ifelse(jury.data3$ancestry=="Mexican",1,0)

jury.composition1 <- aggregate(x=jury.data3$flag,by=list(jury.data3$juryid),FUN=mean)
colnames(jury.composition1) <- c("juryid","percent")

jury.composition2 <- aggregate(x=jury.data3$flag,by=list(jury.data3$juryid),FUN=sum)
colnames(jury.composition2) <- c("juryid","count")

jury.composition <- merge(jury.composition1,jury.composition2,by="juryid")

table(jury.composition$count)

table(jury.data3$ancestry)/sum(table(jury.data3$ancestry))


round(table(jury.composition$count)/sum(table(jury.composition$count)),3)

barplot(table(jury.composition$count), col="darkblue", main="Jury Composition Analysis (70 Juries)", ylim=c(0,20),
        xlab="Jurors of Mexican Ancestry",ylab="Number of Juries")

x <- as.vector(table(jury.composition$count))
x

mean(jury.composition$count)
sd(jury.composition$count)

