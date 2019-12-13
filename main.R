# _________________________________________________________________________________________________
# *************************************************************************************************
# Refer to README for documentation of this code
# *************************************************************************************************

# TODO : a function to show correlations between different features of data
# TODO : check if clustering works to detect season or month info without explicit y labels
#        (x = data[-"season"], y = data"season")
# TODO : check collinearity among the variables and also graph the correlation matrix
# TODO : analysis of the data
# *windspeed may be important
# TODO : attempt to define what the coefficients mean
# TODO : k-crossfold validation
# TODO :error rate graph when k changes

# _________________________________________________________________________________________________
# *************************************************************************************************
# The main code starts
# *************************************************************************************************
# loading regtools and our own functions 
library(regtools)
library(corrplot)
source("datasplit.R")
source("predictlm.R")
source("handleresults.R")
source("predictknn.R")
source("predict.R")

# clear all open devices 
if(length(dev.list())) {
  for (i in dev.list()[1]:dev.list()[length(dev.list())]) {
    dev.off()
  }
}

# load the dataset
data(day1)

# select the columns that are relevant in our task (we will give reasons for ignoring rest)
dataset <- day1[c('mnth', 'season', 'weathersit',  'temp', 'hum', 'windspeed')]

# columns that are best predicted using multi-class binary classification
intClasses <- c('season' ,'yr', 'mnth', 'weathersit')

# names of the dataset columns 
nd <- names(dataset)

# we wil consider  data from previous k days
k <- 3

# margin for the plots
mar=c(0,0,6,0)
# to print correlation matrix for the full day1 data and the columns we picked specifically
jpeg(file=paste0(getwd(),'/CorrelationData/ourcorrelationmatrix.jpeg'))
corrplot(cor(dataset), method = "circle", type = "lower", title = 'our dataset', mar = mar)
dev.off()
jpeg(file=paste0(getwd(), '/CorrelationData/origcorrelationmatrix.jpeg'))
corrplot(cor(day1[,-2]), method = "circle", type = "lower", title = 'original dataset', mar = mar)
dev.off()

# correlation data may be more useful if viewed for each season separately
for(s in 1:4) {
  jpeg(file=paste0(getwd(),'/CorrelationData/PerSeason/corseason',s,'.jpeg'))
  corrplot(cor(dataset[dataset$season == s, -2]), method = "circle", type = "lower", title = paste0('season ',s),, mar = mar)
  dev.off()
}


errorsVSk <- function(max = 10) { # check 0-10 by default
  lmavgerr <<- c()
  knnavgerr <<- c()
  resPath <<- paste0(getwd(), '/manyk')
  for(k in 1:max) {
    dataset <<- day1[c('mnth', 'season', 'weathersit',  'temp', 'hum', 'windspeed')]
    # add data from k days to each row
    addPrevDaysData(k)
    startTest()
  }
  # now print the errors as a function of k
  for(i in 1:length(nd)) {
    jpeg(file=paste0(getwd(),'/ErrorChangingK/lm/',nd[i],'.jpeg'))
    plot(x = 1:max, y = lmavgerr[,i], type = "b", xlab = k, ylab = paste0("Error for ", nd[i]))
    dev.off()
    jpeg(file=paste0(getwd(),'/ErrorChangingK/knn/',nd[i],'.jpeg'))
    plot(x = 1:max, y = knnavgerr[,i], type = "b", xlab = k, ylab = paste0("Error for ", nd[i]))
    dev.off()
  }
}


runtests <- function(option) {
  if(option == 'kdays') {
    # add data from k days to each row
    addPrevDaysData(k)
    # save results to its own folder
    resPath <<- paste0(getwd(), '/PrevDays')
  } else if(option == 'sameday'){
    # save results to its own folder
    resPath <<- paste0(getwd(), '/SameDay')
  }else {
    print('Option can be "kdays" or "sameday"')
  }
  startTest()
}
