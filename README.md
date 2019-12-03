
# predictWeather  
predicting different aspects in "day1" dataset using regtools package in R.

For information on label representation in dataset, go to:
[dataset documentation](https://rstudio-pubs-static.s3.amazonaws.com/98995_27868fd8b4994930833443c7ae31fce6.html)
## Global variables :
<pre><code>
<b>day1</b>       : the entire dataset for this task  
<b>dataset</b>    : day1 dataset, but only with relevant columns kept  
<b>predictors</b> : the names of the columns to be used as predictors  
<b>toPredict</b>  : the name of the column to predict  
<b>intClasses</b> : the columns that contain integer data,
           : we use this to round off predictions for those columns  
<b>trainData</b>  : the dataset to train the models on  
<b>testData</b>   : the datatset to test the models' performance(s)  
</pre></code>
## Functions :

<pre><code>
<b>splitData(dataSet, splitRatio)</b> 
    randomly splits the data in 'dataSet' into 'trainData' and 'testData' with ratio 'splitRatio


<b>predictFromTo(featureCols, predcitCol)</b>
    predicts the column predictCol using columns featureCols
        featureCols : the columns to be used as predictors  
        predictCol  : the column to be predicted

<b>predictUsingLm(SHOW = FALSE)</b>
    gets predictions using linear model (lm()) and handles all associated tasks
        SHOW        : controls whether a plot should be printed  

<b>predictUsingKNN(SHOW = FALSE)</b>
    gets predictions using clusetering model (basicKNN()) and handles all associated tasks
        SHOW        : controls whether a plot should be printed  

</pre></code>
