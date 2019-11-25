# loading regtools and our own functions 
source("traintestsplit.R")
library(regtools)

# load the dataset
data(day1)

# TODO : a function to test and compare two models
# TODO : a function to graph data about two models
# TODO : a function to show correlations between different features of data
# TODO : check if clustering works to detect season or month info 
#       (x = data[-"season"], y = data"season")
model_options <- list(basicKNN, knnest)


# print(day1[floor(runif(10, 1, 100)),])

predictWeather <- function() {
  pe1 <- day1[c('temp', 'atemp', 'hum', 'windspeed', 'registered', 'tot')]
  splitData(pe1, 0.8)
  lmout <- lm(temp ~ .,data=trainData)
  # plot(lmout)
  lmout <- predict.lm(object = lmout, newdata = testData[-1])
  error <- (mean( abs((testData[,"temp"] - lmout)/lmout) ))
  # plot(1:length(lmout), testData[, "temp"] - lmout, "h") # to plot out erros
  
  # plot should look close to y = x if working correctly
  plot(testData[,"temp"], lmout,"p", xlab = 'ground truth', ylab = 'linear prediction', main = 'linear model performance ', sub = paste0('Error (%) : ',error))
  knnTrain <- preprocessx(trainData[,],2)  # prep for k-NN, k <= 10
  knnbasic <- basicKNN(trainData, testData$temp, testData, 4)
}

predictWeather()
