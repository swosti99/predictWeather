# function that returns training data and testing data based on split ratio and k
splitData <- function(splitRatio) {
  # add columns of data from pask k days
  trainSize <- floor(splitRatio*nrow(dataset))
  trainIndices <- sample(seq_len(nrow(dataset)), size = trainSize)
  trainData <<- dataset[trainIndices,]
  testData <<- dataset[-trainIndices,]
}

# function that adds k-previous days' data to the dataset
# as a consequence, the first k rows cannot be used
addPrevDaysData <- function(k) {
    nd <- names(dataset)
    for(col in 1:length(nd)) {
      toadd <- vector()
      for(idx in (k+1):nrow(dataset)) {
        toadd <- rbind(toadd, dataset[(idx-k):idx,col])
      }
      for(prevday in 1 : k) {
        dataset[(k+1):nrow(dataset), paste0(nd[col], prevday)] <- toadd[,prevday]  
      }
    }
    # we add date here
    dataset[,'date'] <- sin(as.integer(substring(gsub("-", "", day1$dteday), 3)))
    dataset <<- dataset[(k+1):nrow(dataset),]
}
# dates12 = day1$dteday[dates > 120000]
# dates12_days = (as.integer(substr(dates12, start = 5, stop = 6))-1)*30 + as.integer(substr(dates12, start = 7, stop = 8))
# plot(dates12_days, max_temp*sin((3.14/365)*dates12_days) + min_temp) # real graph looks close
# plot(as.numeric(dates12), day1[idx2012,'temp']) # this is true temp plot