# _________________________________________________________________________________________________
# *************************************************************************************************
# Global variables :
# *************************************************************************************************
# day1       : the entire dataset for this task
# dataset    : day1 dataset, but only with relevant columns kept
# predictors : the names of the columns to be used as predictors
# toPredict  : the name of the column to predict
# intClasses : the columns that contain integer data, 
#            : we use this to round off predictions for those columns
# trainData  : the dataset to train the models on
# testData   : the datatset to test the models' performance(s)
# _________________________________________________________________________________________________
# *************************************************************************************************
# Functions :
# *************************************************************************************************
# splitData(dataSet, splitRatio)
# |randomly splits the data in 'dataSet' into 'trainData' and 'testData' with ratio 'splitRatio'|
# *************************************************************************************************
# predictFromTo(featureCols, predcitCol) 
# |predicts the column predictCol using columns featureCols|
#   featureCols :- the columns to be used as predictors
#   predictCol  :- the column to be predicted
# *************************************************************************************************
# predictUsingLm(plot = TRUE)
# |gets predictions using linear model (lm()) and handles all associated tasks|
# |a plot is shown by default|
# *************************************************************************************************
# predictUsingKNN(plot = TRUE)
# *
# *
# *
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
# source("predictknn.R")
library(regtools)
intClasses <- c('season' ,'yr', 'mnth', 'weathersit')

# load the dataset
data(day1)
# select the columns that are relevant in our task (we will give reasons for ignoring rest)
dataset <- day1[c('mnth', 'season', 'weathersit',  'temp', 'hum', 'windspeed')]
# dataset <- scale(dataset)
predictFromTo <- function(featureCols, predictCol) {
  predictors <<- featureCols
  toPredict <<- predictCol
  # print(toPredict)
  # knnPred <- predictUsingKNN()
  lmErr <- predictUsingLm()
  return(lmErr)
}

predictAll <- function() {
  # split the dataset into trainData and testData (global variables)
  splitData(dataset, 0.8)
  allcols <- 1:length(names(dataset))
  errors <- c()
  for(i in allcols) {
    featureCols <- names(dataset)[allcols[allcols != i]]
    predictCol <- names(dataset)[i]
    errors <- c(errors, predictFromTo(featureCols = featureCols, predictCol = predictCol))
  }
  errors <- signif(100*errors, digits = 2)
  return (errors)
}

showErrors <- function(err) {
  features <- names(dataset)
  featuresLen <-nchar(features)
  maxLen <- max(featuresLen)
  for(i in 1:length(features)) {
    spaces <- paste(rep(' ', maxLen - featuresLen[i]), collapse = '')
    cat(paste0('Error for predicting "', features[i],'"', spaces, ' : ', err[i]), '\n')
  }
}
errors <- replicate(500, predictAll())
showErrors(rowMeans(errors))


