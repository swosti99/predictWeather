# _________________________________________________________________________________________________
# *************************************************************************************************
# Refer to README for documentation of this code
# *************************************************************************************************

# TODO : a function to show correlations between different features of data
# TODO : check if clustering works to detect season or month info without explicit y labels
#        (x = data[-"season"], y = data"season")
# TODO : check collinearity among the variables and also graph the correlation matrix
# TODO : analysis of the data
# TODO : make a markov model to predict weather based on data from i days 
#        to predict tomorrow's weather
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

runtests <- function(option) {
  if(option == 'kdays') {
    source('predictfromkdays.R')
  } else if(option == 'sameday'){
    source('predictfromsameday.R')
  } else {
    print('Option can be "kdays" or "sameday"')
  }
}