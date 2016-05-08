library(WDI)
library(reshape2)
library(ggplot2)
library(ggthemes)
library(psychometric)
library(plm)
library(dplyr)
library(lattice)

data = WDI(country="all", indicator = c(
'IT.NET.USER.P2',
'SP.DYN.AMRT.FE',
'SP.DYN.AMRT.MA',
'SP.DYN.IMRT.IN',
'SP.DYN.IMRT.FE.IN',
'SP.DYN.IMRT.MA.IN',
'SH.DYN.NMRT',
'SH.DYN.MORT',
'SH.DYN.MORT.FE',
'SH.DYN.MORT.MA',
'SP.DYN.LE00.FE.IN',
'SP.DYN.LE00.MA.IN',
'SP.DYN.LE00.IN',
'SI.DST.04TH.20',
'SI.DST.10TH.10',
'SI.DST.05TH.20',
'SI.DST.FRST.10',
'SI.DST.FRST.20',
'SI.DST.02ND.20',
'SI.DST.03RD.20',
'GB.XPD.RSDV.GD.ZS',
'SP.POP.SCIE.RD.P6',
'TX.VAL.TECH.MF.ZS',
'TX.VAL.TECH.CD',
'BX.GSR.CMCP.ZS',
'BM.GSR.CMCP.ZS',
'NY.GDP.PCAP.KD.ZG',
'NY.GDP.PCAP.PP.KD'
), start = 2005, end=2015, extra = TRUE)


tech = data[!is.na(data$IT.NET.USER.P2), ]
sapply(tech,function(x) sum(is.na(x)))

gdp = dcast(country ~ year, data=tech, value.var = 'NY.GDP.PCAP.KD.ZG') #gdp data
gdp = gdp %>% na.omit()
gdp$country <- factor(gdp$country)
countries = levels(gdp$country)

tech_mod = tech %>%
  filter(country %in% countries) %>%
  filter(region != 'Aggregates')

plot = dplyr::arrange(tech_mod, country, year)

print(xyplot(IT.NET.USER.P2 ~ year | country,
data=plot,
scales=list(y=list(cex=.35),x=list(cex=.35)),
strip=strip.custom(par.strip.text=list(cex=.5)),
xlab="Year",
ylab="Internet Users/100 Ppl",
type="l")
)

within = lm(IT.NET.USER.P2 ~ as.factor(country), data = plot)
summary(within)$r.squared
