
library(dplyr)
df <- data.frame(Origin = character(0),
                 Destination = character(0),
                 Distance = numeric(0))

citylist <- colnames(as.matrix(eurodist))

for(city in colnames(as.matrix(eurodist))){
  df <- rbind(df, data.frame(Origin = city,
                             Destination = citylist,
                             Distance = as.numeric(as.matrix(eurodist)[city, citylist])))
  citylist <- citylist[citylist!=city]
}

df <- df %>%
  filter(Distance != 0)
write.csv(df, "eurodistances.csv", row.names = FALSE)

