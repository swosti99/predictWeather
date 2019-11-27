
# function that returns training data and testing data based on split ratio
splitData <- function(data_set, split_ratio) {
  trainSize <- floor(split_ratio*nrow(data_set))
  trainIndices <- sample(seq_len(nrow(data_set)), size = trainSize)
  trainData <<- data_set[trainIndices,]
  testData <<- data_set[-trainIndices,]
}
