#Project process#

###Take R as the tool for this project###

1. Load the dataset. Package "readr"
  1. can also use fread
  2. read.csv is also fine, but would be slow, only for small dataset

2. convert the categorical data to numeric value, this is mainly for visualizing NAs. (optional for Xgboost). 
  The code in R is below:
    ```
    for (f in names(train)) {
      if (class(train[[f]])=="character") { 
        levels <- unique(c(train[[f]], test[[f]]))
        train[[f]] <- factor(train[[f]], levels=levels)
        test[[f]]  <- factor(test[[f]],  levels=levels)
      }
    }
    ```
    
3. Visualizing NAs. Package "VIM", explore the structure of missing value. (Missing Not at Random)
  - Below is the source code on [Kaggle BNP script](https://www.kaggle.com/jpmiller/bnp-paribas-cardif-claims-management/visualizing-the-nas)


4. Do some exploratory data analysis
  1. [Analysis of duplicate variables](https://www.kaggle.com/c/bnp-paribas-cardif-claims-management/forums/t/19240/analysis-of-duplicate-variables-correlated-variables-large-post). However, this kind of manual method is not realistic if we have thousands of variables. 

5. Imputation and Feature engineering 
  1. use correlation filter method to find some highly correlated variables. Correlation method should be used for numeric values, this is mainly for find and remove redundant variables
  ```
  library(corrplot)
  library(caret)
  temp <- train.num[,-1:-2]
  corr.Matrix <- cor(, use="pairwise.complete.obs")  # mainly for NA values
  corr.75 <- findCorrelation(corr.Matrix, cutoff = 0.75)
  train.num.75 <- temp[, corr.75]
  corrplot(corr.Matrix, order = "hclust")
  ```





