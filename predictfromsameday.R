
intClasses <- c('season' ,'yr', 'mnth', 'weathersit')

# load the dataset
data(day1)

# select the columns that are relevant in our task (we will give reasons for ignoring rest)
dataset <- day1[c('mnth', 'season', 'weathersit',  'temp', 'hum', 'windspeed')]

# names of the columns of dataset
nd <- names(dataset)

# we wil consider  data from previous k days
k <- 3

# file path to store the pdf containing plots of linear model
PDFpath <- paste0(getwd(), '/LinearResults/')

modelName <- 'predictUsingLm'
modelToUse <- get(modelName)

predictFromTo <- function(featureCols, predictCol) {
  predictors <<- featureCols
  toPredict <<- predictCol
  return(modelToUse())
}

predictAll <- function() {
  # names of the columns of dataset
  nd <<- names(dataset)
  # split the dataset into trainData and testData (global variables)
  splitData(dataset, 0.6)
  allcols <- 1:length(nd)
  outcome <-  c()
  for(i in allcols) {
    featureCols <- nd[allcols[allcols != i]]
    predictCol <- nd[i]
    outcome <- rbind(outcome, predictFromTo(featureCols = featureCols, predictCol = predictCol))
  }
  if(modelName == 'predictUsingLm') {
    colnames(outcome) <- c('lmout', 'error')
    outcome[,'error'] <- signif(as.numeric(outcome[,'error']), digits = 2)
  }
  return (outcome)
}
lmresults <- replicate(100, predictAll())

print("________________________________________________________________")
print("                    Errors using linear model                   ")
print("________________________________________________________________")

handleResults(lmresults)

print("________________________________________________________________")
print("                     Errors using KNN                           ")
print("________________________________________________________________")

modelName <- 'predictUsingKNN'
modelToUse <- get(modelName)
# file path to store the pdf containing plots of clustering model
PDFpath <- paste0(getwd(), '/KNNResults/')
knnresults <- replicate(100, predictAll())
handleResults(knnresults)

