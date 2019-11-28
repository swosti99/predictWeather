predictWeather  
predicting different aspects in "day1" dataset using regtools package in R  
_________________________________________________________________________________________________  
*************************************************************************************************  
__Global variables :__
*************************************************************************************************  
day1       : the entire dataset for this task  
dataset    : day1 dataset, but only with relevant columns kept  
predictors : the names of the columns to be used as predictors  
toPredict  : the name of the column to predict  
intClasses : the columns that contain integer data,  
           : we use this to round off predictions for those columns  
trainData  : the dataset to train the models on  
testData   : the datatset to test the models' performance(s)  
_________________________________________________________________________________________________  
*************************************************************************************************  
__Functions :__  
*************************************************************************************************  
splitData(dataSet, splitRatio)  
|randomly splits the data in 'dataSet' into 'trainData' and 'testData' with ratio 'splitRatio'|  
*************************************************************************************************  
predictFromTo(featureCols, predcitCol)
|predicts the column predictCol using columns featureCols|  
  featureCols :- the columns to be used as predictors  
  predictCol  :- the column to be predicted  
*************************************************************************************************
predictUsingLm(SHOW = TRUE)  
|gets predictions using linear model (lm()) and handles all associated tasks|  
|a plot is shown by default|  
*************************************************************************************************  
predictUsingKNN(plot = TRUE)  
*  
*  
*  
*************************************************************************************************  
