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

data(peDumms)
print(peDumms[1:10,"age"])
# print(model(3))
# print(predictWeather())
# data(peDumms)
# pe1 <- peDumms[c('age','educ.14','educ.16','sex.1','wageinc','wkswrkd')]
# lmout <- lm(wageinc ~ .,data=pe1)
# xd <- preprocessx(pe1[,-5],10)  # prep for k-NN, k <= 10
# knnout <- knnest(pe1$wageinc,xd,10)
# parvsnonparplot(lmout,knnout)