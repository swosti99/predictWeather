handleResults <- function(errors) {
  colnames(results) <- c('lmout', 'error')
  results[,'error',] <- signif(100*as.numeric(results[,'error',]), digits = 2)
  errors <- apply(results[,'error',], 2,as.numeric)
  # print the histograms
  histPath <- paste(PDFpath, 'Hist.pdf')
  pdf(file = histPath)
  for(i in 1:6) {
    hist(as.numeric(errors[i,]), xlab = paste('error for ', nd[i], collapse = ''),
         main = paste('Histogram of errors for "', nd[i],'"', collapse = ''))
  }
  dev.off()
  # get indices of the best performing model for eaach category
  minIdx <- apply(errors, 1, which.min)
  # save the best performing models for each category
  bestModels <- c()
  for(i in 1:nrow(errors)) {
    bestModels[i] = results[i,'lmout',minIdx[i]]
  }
  savePDF(bestModels)
  showErrors(rowMeans(errors))
}

showErrors <- function(err) {
  features <- names(dataset)
  featuresLen <-nchar(features)
  maxLen <- max(featuresLen)
  for(i in 1:length(features)) {
    spaces <- paste(rep(' ', maxLen - featuresLen[i]), collapse = '')
    cat(paste0('Error for predicting "', features[i],'"', spaces, ' : ', err[i]), '\n')
  }
}

savePDF <- function(models) {
  path <- paste0(PDFpath,'.pdf')
  pdf(file=path)
  for(m in models) {
    plot(m)
  }
  dev.off()
}
