# loading regtools and our own functions 
source("traintestsplit.R")
library(regtools)

# load the dataset
data(day1)

model_options <- list(basicKNN, knnest)
# predictWeather <- function() {
#   
# }


# print(day1[floor(runif(10, 1, 100)),])

pe1 <- day1[c('temp', 'atemp', 'hum', 'windspeed', 'registered', 'tot')]
splitData(pe1, 0.7)
# pe1 <- day1
# print(peDumms[1:5, ])
# print(model(3))
# print(predictWeather())
# data(peDumms)
# pe1 <- peDumms[c('age','educ.14','educ.16','sex.1','wageinc','wkswrkd')]
lmout <- lm(temp ~ .,data=trainData)
lmout <- predict.lm(object = lmout, newdata = testData)
plot(testData, lmout)
knnTrain <- preprocessx(trainData[,],2)  # prep for k-NN, k <= 10
knnbasic <- basicKNN(trainData, trainData$temp, testData, 2)
# knnout <- knnest(knnTrain$temp,knnTrain,2)
# print(pe1$hum[1:5])
parvsnonparplot(knnout,knnout)
