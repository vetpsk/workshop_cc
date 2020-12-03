getwd()


library(data.table)
library(dplyr)

df1 <- fread(file = "./data/raw/simulated_df.csv", header = T,
             nThread = 2)

str(df1)
summary(df1)

df1$year <- as.character(df1$year)
df1$HerdIdentifier <- as.factor(df1$HerdIdentifier)

sink("results/output/summary_df.txt")
paste("summary of df")
summary(df1)
sink()

hist(df1$numberculled)
qqnorm(log(df1$numberculled))

df2 <- as.matrix(df1[, c(6, 8, 10, 12, 14, 15)])
cor(df2)

lm1 <- lm(numberculled ~ lifeprodnculled + numberproductiondaysculled +
            fatculled + proteinculled + numberheifers +
            year, data = df1, model = TRUE)
summary(lm1)
anova(lm1)

lm2 <- glm(numberculled ~ lifeprodnculled + numberproductiondaysculled +
             fatculled + proteinculled + numberheifers +
             year, data = df1, family = poisson(link = "log"))
summary(lm2)
anova(lm2)

library(lme4)

lm3 <- lmer(numberculled ~ lifeprodnculled + numberproductiondaysculled +
              fatculled + proteinculled + numberheifers +
              year + (1 | HerdIdentifier), data = df1, )
summary(lm3)
anova(lm3)

lm4 <- lmer(numberculled ~ lifeprodnculled + numberproductiondaysculled +
              fatculled + proteinculled + numberheifers +
              (1 | HerdIdentifier) + (1 | year), data = df1)
summary(lm4)
anova(lm4)

lm5 <- glmer(numberculled ~ lifeprodnculled + numberproductiondaysculled +
               fatculled + proteinculled + numberheifers +
               (1 | HerdIdentifier) + (1 | year), data = df1,
             family = poisson(link = "log"))

summary(lm5)
anova(lm5)

AIC(lm1)
AIC(lm2)
AIC(lm3)
AIC(lm4)
AIC(lm5)
