predictUsingKNN <- function() {
  
  # print(names(day1))
  # print(day1$dteday)
  lmout <- lm(temp ~ .,data=trainData)
  # plot(lmout)
  lmout <- predict.lm(object = lmout, newdata = testData[-1])
  error <- mean( abs(testData[,"temp"] - lmout)/lmout )
  plot(1:length(lmout), 100*(testData[, "temp"] - lmout)/lmout, "h") # to plot out erros
  
  # plot should look close to y = x if working correctly
  # plot(testData[,"temp"], lmout,"p", xlab = 'ground truth', ylab = 'linear prediction', main = 'linear model performance ', sub = paste0('Error (%) : ',error))
  knnTrain <- preprocessx(trainData,2)  # prep for k-NN, k <= 10
  knnbasic <- basicKNN(trainData, testData$temp, testData, 4)
}