predictWeather  
predicting different aspects in "day1" dataset using regtools package in R  
# Global variables :
__day1__       : the entire dataset for this task  
__dataset__    : day1 dataset, but only with relevant columns kept  
__predictors__ : the names of the columns to be used as predictors  
__toPredict__  : the name of the column to predict  
__intClasses__ : the columns that contain integer data,  
               : we use this to round off predictions for those columns  
__trainData__  : the dataset to train the models on  
__testData__   : the datatset to test the models' performance(s)  

# Functions :
  
__splitData(dataSet, splitRatio)__  
|randomly splits the data in 'dataSet' into 'trainData' and 'testData' with ratio 'splitRatio'|  
  
__predictFromTo(featureCols, predcitCol)__
|predicts the column predictCol using columns featureCols|  
  __featureCols__ :- the columns to be used as predictors  
  __predictCol__  :- the column to be predicted  

__predictUsingLm(SHOW = FALSE)__ 
|gets predictions using linear model (lm()) and handles all associated tasks|  
|SHOW controls whether a plot should be printed|  


__predictUsingKNN(SHOW = FALSE)__ 
*  
*  
*  
*************************************************************************************************  
