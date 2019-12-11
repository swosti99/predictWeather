handleResults <- function(results) {
  if(modelName == 'predictUsingLm') {
    colnames(results) <- c('lmout', 'error')
    results[,'error',] <- signif(100*as.numeric(results[,'error',]), digits = 2)
    errors <- apply(results[,'error',], 2,as.numeric)
    # only save best models for linear case
    saveBestModels(results, errors)
  } else {
    errors <- apply(results, 3, as.numeric)
  }
  # save (as PDF) the histograms of errors for each category
  saveErrorHist(errors)
  # show the mean errors for each categor on the console
  showErrors(rowMeans(errors))
}

showErrors <- function(err) {
  # for consistent spacing 
  features <- nd
  featuresLen <-nchar(features)
  maxLen <- max(featuresLen)
  for(i in 1:length(features)) {
    spaces <- paste(rep(' ', maxLen - featuresLen[i]), collapse = '')
    cat(paste0('Error for predicting "', features[i],'"', spaces, ' : ', err[i]), '\n')
  }
}

saveErrorHist <- function(errors) {
  # print the histograms
  histPath <- paste0(PDFpath, 'ErrorsHistogram.pdf', collapse = '')
  pdf(file = histPath)
  for(i in 1:length(nd)) {
    hist(as.numeric(errors[i,]), xlab = paste('error for ', nd[i], collapse = ''),
         main = paste('Histogram of errors for "', nd[i],'"', collapse = ''))
  }
  dev.off()
}

saveBestModels <- function(results, errors) {
  # get indices of the best performing model for eaach category
  minIdx <- apply(errors, 1, which.min)
  # save the best performing models for each category
  bestModels <- c()
  for(i in 1:nrow(errors)) {
    bestModels[i] = results[i,'lmout',minIdx[i]]
  }
  # now we print to PDF
  path <- paste0(PDFpath,'BestModels.pdf')
  pdf(file=path)
  for(m in bestModels) {
    plot(m)
  }
  dev.off()
}
