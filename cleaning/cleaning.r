setwd("~/GitHub/KaggleBNP")

library(readr)

cat("reading data, including train and test\n")
train <- read_csv("train.csv")
test <- read_csv("test.csv")

cat("check missing value percentile\n")
mean(is.na(train)) ## overall missing value
mean(is.na(test))
missing_train <- apply(train, 2, function(x) sum(is.na(x))/length(x))
missing_test <- apply(test, 2, function(x) sum(is.na(x))/length(x))

cat("remove constant\n")
col.const <- sapply(train, function(x) length(unique(x))==1)
table(col.const) # no constant columns 

cat("remove duplicated columns\n")
table(duplicated(as.list(train))) # no duplicated columns 

cat("separate numeric and non numeric columns\n")
train.num <- train[, sapply(train, is.numeric)]
train.char <- train[, sapply(train, is.character)]
test.num <- test[, sapply(test, is.numeric)]
test.char <- test[, sapply(test, is.character)]

cat("coerce character variables to factor\n")
## train.char <- as.data.frame(lapply(train.char, as.factor))
## test.char <- as.data.frame(lapply(test.char, as.factor))
## summary(train.char)
char.names <- names(train.char)
for (f in char.names) {
      levels <- unique(c(train.char[[f]], test.char[[f]]))
      # train.char[[f]] <- as.integer(factor(train.char[[f]], levels=levels)) # use for xgboost
      # test.char[[f]]  <- as.integer(factor(test.char[[f]],  levels=levels))
      train.char[[f]] <- factor(train.char[[f]], levels=levels)
      test.char[[f]]  <- factor(test.char[[f]],  levels=levels)
}
rm(char.names, f, levels)