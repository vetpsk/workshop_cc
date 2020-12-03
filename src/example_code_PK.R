##################### Dummy code for Reproducible code workshop #######################

# check directory and project source
getwd()

# libraries required for this code: data.table, dplyr, lme4
library(data.table)
library(dplyr)
library(lme4)

# read data, its structure and summary
df1 <- fread(file = "./data/raw/simulated_df.csv", header = T,
             nThread = 2)

str(df1)
summary(df1)

# class changes for vars: years and HerdIdentifier
df1$year <- as.character(df1$year)
df1$HerdIdentifier <- as.factor(df1$HerdIdentifier)
str(df1)

# save summary of data in txt file for future reference

sink("results/output/summary_df.txt")
paste("summary of df")
summary(df1)
sink()

# investigate distribution of dependent vars
hist(df1$numberculled)
qqnorm(df1$numberculled)

# save figures
jpeg(filename = "./results/figures/Rplot_histogram_dependentvar.jpeg",
          width = 480, height = 480, units = "px", pointsize = 12,
          quality = 75,
          bg = "white", res = NA)
hist(df1$numberculled)
dev.off()

jpeg(filename = "./results/figures/Rplot_qqplot_dependentvar.jpeg",
     width = 480, height = 480, units = "px", pointsize = 12,
     quality = 75,
     bg = "white", res = NA)
qqnorm(df1$numberculled)
dev.off()


# check correlations between independent vars
df2 <- as.matrix(df1[, c(6, 8, 10, 12)])
cor(df2, use = "complete.obs")
sink("./results/output/correlation of independent variables.txt")
cor(df2)
sink()

# fit models, na.action = DEFAULT

# model 1: linear model with only fixed effects
lm1 <- lm(numberculled ~ lifeprodnculled + numberproductiondaysculled +
            fatculled + proteinculled + numberheifers +
            year, data = df1, model = TRUE)

# model 2: non-linear model with poisson log link, only fixed effects
lm2 <- glm(numberculled ~ lifeprodnculled + numberproductiondaysculled +
             fatculled + proteinculled + numberheifers +
             year, data = df1, family = poisson(link = "log"))

# model 3: linear mixed effects model with only Herd random effect
lm3 <- lmer(numberculled ~ lifeprodnculled + numberproductiondaysculled +
              fatculled + proteinculled + numberheifers +
              year + (1 | HerdIdentifier), data = df1)

# model 4: linear mixed effects model with herd and year random effects
lm4 <- lmer(numberculled ~ lifeprodnculled + numberproductiondaysculled +
              fatculled + proteinculled + numberheifers +
              (1 | HerdIdentifier) + (1 | year), data = df1)

# model 5: non-linear mixed model with herd, year random and poisson log-link
lm5 <- glmer(numberculled ~ lifeprodnculled + numberproductiondaysculled +
               fatculled + proteinculled + numberheifers +
               (1 | HerdIdentifier) + (1 | year), data = df1,
             family = poisson(link = "log"))

# model outputs and statistics
ModelList <- as.list(paste0("lm", 1:5))

lapply(ModelList, function(x)AIC(get(x)))
lapply(ModelList, function(x)summary(get(x)))
lapply(ModelList, function(x)anova(get(x)))

# save model results to text file

sink("./results/output/model_output.txt")
cat("Model names as they appear in output")
ModelList
cat("AIC")
lapply(ModelList, function(x)AIC(get(x)))
cat("summaries")
lapply(ModelList, function(x)summary(get(x)))
cat("anova tables")
lapply(ModelList, function(x)anova(get(x)))
sink()
