predictUsingKNN <- function() {
  knnbasic <- basicKNN(trainData[,predictors], trainData[,toPredict], testData[,predictors], 8)
  return(100 * mean(l1(testData[, toPredict], knnbasic$regests))/mean(abs(testData[,toPredict])))
}
