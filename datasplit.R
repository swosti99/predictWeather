# function that returns training data and testing data based on split ratio
splitData <- function(dataSet, splitRatio) {
  trainSize <- floor(splitRatio*nrow(dataSet))
  trainIndices <- sample(seq_len(nrow(dataSet)), size = trainSize)
  trainData <<- dataSet[trainIndices,]
  testData <<- dataSet[-trainIndices,]
}
