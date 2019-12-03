predictUsingKNN <- function() {
  knnbasic <- basicKNN(trainData[,predictors], trainData[,toPredict], testData[,predictors], 4)
  return(mean(l1(testData[, toPredict], knnbasic$regests))/mean(abs(testData[,toPredict])))
}