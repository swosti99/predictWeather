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

# _________________________________________________________________________________________________
# *************************************************************************************************
# The main code starts
# *************************************************************************************************
# loading regtools and our own functions 
library(regtools)
source("datasplit.R")
source("predictlm.R")
source("handleresults.R")
source("predictknn.R")
source("predict.R")

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

# to print correlation matrix
pdf(file=paste0(getwd(),'/correlationmatrix.pdf'))
corrplot(cor(dataset), method = "circle", type = "lower")
corrplot(cor(day1[,-2]), method = "circle", type = "lower")
dev.off()

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
