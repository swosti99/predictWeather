predictSeason <- function(pe1) {
  splitData(pe1, 0.8)
  # print(names(day1))
  # print(day1$dteday)
  # lmout <- lm(temp ~ .,data=trainData)
  # plot(lmout)
  # lmout <- predict.lm(object = lmout, newdata = testData[-1])
  # error <- mean( abs(testData[,"temp"] - lmout)/lmout )
  # plot(1:length(lmout), testData[, "temp"] - lmout, "h") # to plot out erros
  
  # plot should look close to y = x if working correctly
  # plot(testData[,"temp"], lmout,"p", xlab = 'ground truth', ylab = 'linear prediction', main = 'linear model performance ', sub = paste0('Error (%) : ',error))
  knnTrain <- preprocessx(trainData[,-1], 4)  # prep for k-NN, k <= 10
  # print(knnTrain)
  # print(names(knnTrain))
  # print(knnTrain["idxs"])
  s <- c()
  for(i in 1:4) {
    s <- cbind(s, knnTrain$idxs[,i])
    # print(s)
    print(mean(trainData[s[,i], "season"]))
    print('_____________________________')
  }
  
  
  # knnpred <- knnest(knnTrain$season, knnTrain[-1], 4)
  # print(knnpred)
  
}
