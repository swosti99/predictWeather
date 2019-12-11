startTest <- function() {
    # file path to store the pdf containing plots of linear model
    PDFpath <<- paste0(resPath, '/LinearResults/')

    

    predictFromTo <- function(featureCols, predictCol) {
      predictors <<- featureCols
      toPredict <<- predictCol
      return(modelToUse())
    }

    predictAll <- function() {
      # split the dataset into trainData and testData (global variables)
      splitData(0.6)
      allcols <- nd
      outcome <-  c()
      for(i in allcols) {
        featureCols <- names(dataset)[names(dataset) != i]
        predictCol <- i
        outcome <- rbind(outcome, predictFromTo(featureCols = featureCols, predictCol = predictCol))
      }
      if(modelName == 'predictUsingLm') {
        colnames(outcome) <- c('lmout', 'error')
        outcome[,'error'] <- signif(as.numeric(outcome[,'error']), digits = 2)
      }
      return (outcome)
    }
    
    modelName <<- 'predictUsingLm'
    modelToUse <<- get(modelName)
    
    lmresults <- replicate(100, predictAll())

    print("________________________________________________________________")
    print("                    Errors using linear model                   ")
    print("________________________________________________________________")

    handleResults(lmresults)

    print("________________________________________________________________")
    print("                     Errors using KNN                           ")
    print("________________________________________________________________")

    modelName <<- 'predictUsingKNN'
    modelToUse <<- get(modelName)
    # file path to store the pdf containing plots of clustering model
    PDFpath <<- paste0(resPath, '/KNNResults/')
    knnresults <- replicate(100, predictAll())
    handleResults(knnresults)
}
