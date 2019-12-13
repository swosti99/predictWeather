startTest <- function(SHOW = FALSE) {
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
      allcols <- setdiff(names(dataset), nd)
      outcome <-  c()
      for(i in nd) {
        featureCols <- allcols
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
    
    lmresults <<- replicate(5, predictAll())

    modelName <<- 'predictUsingKNN'
    modelToUse <<- get(modelName)
    knnresults <- replicate(5, predictAll())
    
    if(SHOW) {
      print("________________________________________________________________")
      print("                    Errors using linear model                   ")
      print("________________________________________________________________")
      handleResults(lmresults)
      print("________________________________________________________________")
      print("                     Errors using KNN                           ")
      print("________________________________________________________________")
      # file path to store the pdf containing plots of clustering model
      PDFpath <<- paste0(resPath, '/KNNResults/')
      handleResults(knnresults)
    } else {
      lmavgerr <<- rbind(lmavgerr, rowMeans(100*apply(lmresults[,'error',], 2,as.numeric)))
      knnavgerr <<- rbind(knnavgerr, rowMeans((apply(knnresults, 3, as.numeric))))
    }
}
