# _________________________________________________________________________________________________
# *************************************************************************************************
# Refer to README for documentation of this code
# *************************************************************************************************
# TODO : predictUsingKNN()
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

# loading regtools and our own functions 
source("datasplit.R")
source("predictlm.R")
source("handleresults.R")
# source("predictknn.R")
library(regtools)
intClasses <- c('season' ,'yr', 'mnth', 'weathersit')

# load the dataset
data(day1)
# select the columns that are relevant in our task (we will give reasons for ignoring rest)
dataset <- day1[c('mnth', 'season', 'weathersit',  'temp', 'hum', 'windspeed')]
# file path to store the pdf containing plots
PDFpath <- '/Users/swosti/Desktop/ecs132/predictWeather/results'
# names of the columns of dataset
nd <- names(dataset)

predictFromTo <- function(featureCols, predictCol) {
  predictors <<- featureCols
  toPredict <<- predictCol
  lmErr <- predictUsingLm()
  return(lmErr)
}

predictAll <- function() {
  # split the dataset into trainData and testData (global variables)
  splitData(dataset, 0.8)
  allcols <- 1:length(names(dataset))
  results <-  c()
  # print(results$error)
  for(i in allcols) {
    featureCols <- names(dataset)[allcols[allcols != i]]
    predictCol <- names(dataset)[i]
    results <- rbind(results, predictFromTo(featureCols = featureCols, predictCol = predictCol))
  }
  colnames(results) <- c('lmout', 'error')
  results[,'error'] <- signif(as.numeric(results[,'error']), digits = 2)
  return (results)
}
results <- replicate(300, predictAll())
handleResults(results)

print("________________________________________________________________")
dataset <- day1[c('mnth', 'season', 'weathersit',  'temp', 'atemp', 'hum', 'windspeed')]

badresults <- replicate(300, predictAll())
handleResults(badresults)

