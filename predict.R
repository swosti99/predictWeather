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
# predictWeather <- function() {
#   
# }


# print(day1[floor(runif(10, 1, 100)),])

pe1 <- day1[c('temp', 'atemp', 'hum', 'windspeed', 'registered', 'tot')]
splitData(pe1, 0.7)
lmout <- lm(temp ~ .,data=trainData)
lmout <- predict.lm(object = lmout, newdata = testData[-1])
plot(testData[,"temp"], lmout)
knnTrain <- preprocessx(trainData[,],2)  # prep for k-NN, k <= 10
knnbasic <- basicKNN(trainData, testData$temp, testData, 4)
# knnout <- knnest(knnTrain$temp,knnTrain,2)
# parvsnonparplot(knnbasic,knnout)
# print(knnbasic)
# plot(knnbasic[1][c('temp')], knnbasic[2][c('temp')])
