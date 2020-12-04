##################### Dummy code for Reproducible code workshop #######################

# check directory and project source
getwd()

# libraries required for this code: data.table, dplyr, lme4
library(data.table)
library(dplyr)
library(lme4)
library(docstring)

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
# declare functions
form1 <- as.formula(numberculled ~ lifeprodnculled + numberproductiondaysculled +
                      fatculled + proteinculled + numberheifers +
                      year)
form2 <- as.formula(numberculled ~ lifeprodnculled + numberproductiondaysculled +
                      fatculled + proteinculled + numberheifers +
                      year + (1 | HerdIdentifier))
form3 <- as.formula(numberculled ~ lifeprodnculled + numberproductiondaysculled +
                      fatculled + proteinculled + numberheifers +
                      (1 | HerdIdentifier) + (1 | year))
form_list <- list(form1, form2, form3)

modelfunc <- function(df, formula_list) {
  #' Fit different models
  list(lm(formula = form_list[[1]] , data = df), 
       glm(formula=form_list[[1]], data = df),
       lmer(formula=form_list[[2]], data = df),
       glmer(formula=form_list[[2]], data = df,
             family = poisson(link = "log")),
       lmer(formula=form_list[[3]], data = df),
       glmer(formula=form_list[[3]], data = df,
             family = poisson(link = "log")))
}
# model list with names
model_list <- list(modelfunc(df1, form_list))
model_list<- unlist(model_list, recursive = FALSE)
names(model_list) <- c("lm", "glm", "lmer1", "lmer2", "glmer1", "glmer2")


# model outputs and statistics

aic_model <- lapply(model_list, AIC)
summaries_model <- lapply(model_list, summary)
anova_model <- lapply(model_list, anova)

# save model results to text file

sink("./results/output/model_output.txt")
"model names as they appear in output"
names(model_list)
aic_model
summaries_model
anova_model
sink()
