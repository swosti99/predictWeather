# loading regtools and our own functions 
source("traintestsplit.R")
source("predicttemp.R")
source("predictseason.R")
library(regtools)

# load the dataset
data(day1)
pe1 <- day1[c('season' ,'yr', 'mnth', 'weathersit',  'temp', 'atemp', 'hum', 'windspeed')]


# TODO : a function to test and compare two models
# TODO : a function to graph data about two models
# TODO : a function to show correlations between different features of data
# TODO : check if clustering works to detect season or month info 
#        (x = data[-"season"], y = data"season")
# TODO : check collinearity among the variables and also graph
#        the correlation matrix
# TODO : analysis of the data
# TODO : make a markov model to predict weather based on data from i days 
#        to predict tomorrow's weather
# *windspeed may be important
# TODO : attempt to define what the coefficients mean
# TODO : make a function predictFromTo(featuresCols,predcitCol)
#        featureCols :  indices of columns to use as features
#        predictCol  :  index of column to predict

model_options <- list(basicKNN, knnest)


# predictTemp()
predictSeason(pe1)




