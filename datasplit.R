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
    dataset <<- dataset[(k+1):nrow(dataset),]
}