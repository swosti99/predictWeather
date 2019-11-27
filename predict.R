# Refer to README for documentation of this code
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
# file path to store the pdf containing plots
PDFpath <- '/Users/swosti/Desktop/ecs132/predictWeather/results'

predictFromTo <- function(featureCols, predictCol) {
  predictors <<- featureCols
  toPredict <<- predictCol
  lmErr <- predictUsingLm(z)
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
  results[,'error'] <- signif(100*as.numeric(results[,'error']), digits = 2)
  return (results)
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

savePDF <- function(models) {
  path <- paste0(PDFpath,'.pdf')
  pdf(file=path)
  for(m in models) {
    plot(m)
  }
  dev.off()
}
results <- replicate(300, predictAll())


errors <- apply(results[,'error',], 2,as.numeric)
# get indices of the best performing model for eaach category
minIdx <- apply(errors, 1, which.min)
# save the best performing models for each category
bestModels <- c()
for(i in 1:nrow(errors)) {
  bestModels[i] = results[i,'lmout',minIdx[i]]
}
savePDF(bestModels)
showErrors(rowMeans(errors))
