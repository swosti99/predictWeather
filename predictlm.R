predictUsingLm <- function(error = TRUE, plot = FALSE) {
  mformula <- paste0(toPredict, '~')
  # print(mformula)
  # print(predictors)
  for(col in predictors) {
    mformula <-paste0(mformula, col) 
    # print(col)
    if(col != predictors[length(predictors)]) {
      mformula <- paste0(mformula, '+')
    }
  }
  
  # print(mformula)
  lmout <- lm(mformula,data=trainData)
  # print(mean(abs(lmout$residuals)))
  predictions <- predict.lm(object = lmout, newdata = testData[predictors])
  # print(intClasses == toPredict)
  if(sum(intClasses == toPredict) > 0) {
    predictions <- round(predictions)
  }
  error <- mean(abs(testData[,toPredict] - predictions))/mean(testData[,toPredict])
  # plot(1:length(lmout), 100*error, "h") # to plot out erros
  # print(error)
  # correct <- (sum((testData[,toPredict] - lmout)/lmout < 0.05 ))
  # print(correct)
  # print(nrow(testData))
  # error <- 1 - correct/nrow(testData)
  # plot should look close to y = x if working correctly
  if(plot) {
    plot(predictions,testData[,toPredict],"p", xlab = 'ground truth', ylab = 'linear prediction', 
         main = 'linear model performance ', sub = paste0('Error (%) : ',error))
  }
  
  # plot(predictions,testData[,toPredict],"p", xlab = 'ground truth', ylab = 'linear prediction', 
       # main = 'linear model performance ', sub = paste0('Error (%) : ',error))
  return(list(lmout, error))
}
