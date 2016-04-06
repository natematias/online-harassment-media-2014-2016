library(ggplot2)
library(lme4)
library(lmerTest)
library(glmmADMB)
library(stargazer)

weeks <- read.csv("Online-Harassment-Sentences-01-JAN-2014-to-31-MAR-2016-US-UK-DGITIAL-MediaCloud.csv")
weeks$Total.Media <- weeks$Digital.Media + weeks$US.Media + weeks$UK.Media
weeks$week <- as.Date(weeks$date)
weeks$day = weeks$week - min(weeks$week)

## REMOVE THE LAST WEEK FROM THE DATASET
## SINCE IT'S ONLY PARTIAL
weeks <- weeks[!weeks$week == max(weeks$week), ]

## CREATE MONTH COVARIATE
weeks$weeknum = weeks$day/7
weeks$monthnum = weeks$day/30.416
#as.integer((max(weeks$week) - min(weeks$week)))

## UNIVARIATE STATISTICS
summary(weeks$Total.Media)
summary(weeks$UK.Media)
summary(weeks$US.Media)
summary(weeks$Digital.Media)


plot(density(weeks$Total.Media))
plot(density(weeks$UK.Media))
plot(density(weeks$US.Media))
plot(density(weeks$Digital.Media))

## BIVARIATE STATISTICS

plot(weeks$monthnum, weeks$Total.Media)
plot(weeks$monthnum, weeks$UK.Media)
plot(weeks$monthnum, weeks$US.Media)
plot(weeks$monthnum, weeks$Digital.Media)

####### MODEL BUILDING #########
summary(nb1 <- glm.nb(Total.Media ~ monthnum, data = weeks))
summary(nb2 <- glm.nb(UK.Media ~ monthnum, data = weeks))
summary(nb3 <- glm.nb(US.Media ~ monthnum, data = weeks))
summary(nb4 <- glm.nb(Digital.Media ~ monthnum, data = weeks))

stargazer(nb1,nb2,nb3,nb4, type="text")
