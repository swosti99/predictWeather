# starting the project
source("knn.R")
source("linear.R")
library(regtools)
model_options <- list(test, cluster)
predictWeather <- function() {
  n <- 0
  while(n > 2 || n < 1) {
    n <- as.integer(readline("Model choice ( KNN/linear [1/2] ) ? :"))
  }
  model <- model_options[[n]]
  print(model(4))
}

data(day1)
# print(day1[floor(runif(10, 1, 100)),])
pe1 <- day1[c('temp', 'atemp', 'hum', 'windspeed', 'registered', 'tot')]
# pe1 <- day1
# print(peDumms[1:5, ])
# print(model(3))
# print(predictWeather())
# data(peDumms)
# pe1 <- peDumms[c('age','educ.14','educ.16','sex.1','wageinc','wkswrkd')]
lmout <- lm(temp ~ .,data=pe1)
# print(lmout)
xd <- preprocessx(pe1[,-5],2)  # prep for k-NN, k <= 10
knnbasic <- basicKNN(pe1, pe1$temp, pe1, 2)
knnout <- knnest(pe1$temp,xd,2)
# print(pe1$hum[1:5])
parvsnonparplot(knnbasic,knnout)
?parvsnonparplot