library(WDI)
library(reshape2)
library(ggplot2)
library(ggthemes)
library(psychometric)
library(plm)

wb <- WDI(country="all", indicator=c("DT.ODA.ODAT.PC.ZS","SH.TBS.INCD","SE.ADT.LITR.ZS",
                                     "SP.DYN.LE00.IN"),
          start=2005, end=2015, extra=TRUE)
wb <- filter(wb, income == 'Low income')

wbcastODA <- dcast(country ~ year, data=wb, value.var = 'DT.ODA.ODAT.PC.ZS')

wbcastODA <- wbcastODA[!is.na(wbcastODA[,'2005']),]

wbcastODA$country <- factor(wbcastODA$country)

countrylist <- levels(wbcastODA$country)

wbcastTUB <- dcast(country ~ year, data=wb, value.var='SH.TBS.INCD')

wb <- wb %>%
  filter(country %in% countrylist)

wbmodel <- wb %>%
  filter(year %in% 2005:2014) %>%
  dplyr::select(country, year, DT.ODA.ODAT.PC.ZS, SH.TBS.INCD, SE.ADT.LITR.ZS,
                SP.DYN.LE00.IN)

colnames(wbmodel) <- c('Country', 'Year', 'AidPerCapita', 'IncidenceTuberculosis',
                       'AdultLiteracy', 'LifeExpectancy')

ggplot(wbmodel, aes(x=Year, y=LifeExpectancy)) + geom_line() + 
  facet_wrap( ~ Country) + theme_tufte()

ggplot(wbmodel, aes(x=year, y=SH.TBS.INCD, group=country)) + geom_line() + 
  theme_tufte()

w <- lm(SH.TBS.INCD ~ as.factor(country), data=wbmodel)
summary(w)$r.squared

anova(w)

tmp <- aov(SH.TBS.INCD ~ as.factor(country), data=wbmodel)

summary(tmp)

ICC1(tmp)

## Fixed Effects

plm.wbmodel <- plm.data(wbmodel, index=c('country', 'year'))
m3 <- plm(SH.TBS.INCD ~ DT.ODA.ODAT.PC.ZS, data=plm.wbmodel, method='within')

summary(m3)

testlm <- lm(SH.TBS.INCD ~ DT.ODA.ODAT.PC.ZS, data=wbmodel)
