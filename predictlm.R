predictUsingLm <- function(error = TRUE, SHOW = FALSE) {
  mformula <- paste0(toPredict, '~')
  for(col in predictors) {
    mformula <-paste0(mformula, col) 
    if(col != predictors[length(predictors)]) {
      mformula <- paste0(mformula, '+')
    }
  }
  lmout <- lm(mformula,data=trainData)
  predictions <- predict.lm(object = lmout, newdata = testData[predictors])
  if(sum(intClasses == toPredict) > 0) {
    predictions <- round(predictions)
  }
  error <- mean(abs(testData[,toPredict] - predictions))/mean(abs(testData[,toPredict]))
  # plot should look close to y = x if working correctly
  if(SHOW) {
    plot(predictions,testData[,toPredict],"p", xlab = 'ground truth', ylab = 'linear prediction', 
         main = 'linear model performance ', sub = paste0('Error (%) : ',error))
  }
  return(list(lmout, error))
}
