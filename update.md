#Project process#

###Take R as the tool for this project###

1. Load the dataset. Package "readr"
  1. can also use fread
  2. read.csv is also fine, but would be slow

2. convert the categorical data to numeric value, this is mainly for visualizing NAs. (optional for Xgboost)
  - The code in R is below:
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

4. use correlation filter method to find some highly correlated variables
5. 




