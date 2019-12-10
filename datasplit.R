# function that returns training data and testing data based on split ratio and k
splitData <- function(dataSet, splitRatio) {
  # add columns of data from pask k days
  trainSize <- floor(splitRatio*nrow(dataSet))
  trainIndices <- sample(seq_len(nrow(dataSet)), size = trainSize)
  trainData <<- dataSet[trainIndices,]
  testData <<- dataSet[-trainIndices,]
}
