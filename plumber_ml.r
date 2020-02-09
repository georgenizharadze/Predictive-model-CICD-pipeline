linear_model <- readRDS("linear_moel.rds")

#' @apiTitle Boston house price prediction API

#' Show model R-squared
#' @get /r_squared
function(){
  summary(linear_model)$r.squared
}

#' Predict house price
#' @param crim:numeric per capita crime rate by town
#' @param zn:numeric proportion of residential land zoned for lots over 25,000 sq.ft.
#' @param indus:numeric proportion of non-retail business acres per town
#' @param chas:int Charles River dummy variable, 1 if tract bounds river; 0 otherwise
#' @param nox:numeric nitric oxides concentration, parts per 10 million
#' @param rm:numeric average number of rooms per dwelling
#' @param age:numeric proportion of owner-occupied units built prior to 1940
#' @param dis:numeric weighted distances to five Boston employment centres
#' @param rad:numeric index of accessibility to radial highways
#' @param tax:numeric full-value property-tax rate per $10,000
#' @param ptratio:numeric pupil-teacher ratio by town
#' @param b:numeric 1000(Bk - 0.63)^2 where Bk is the proportion of blacks by town
#' @param lstat:numeric % lower status of the population
#' @get /predict_price
function(crim, zn, indus, chas, nox, rm, age, dis, rad, tax, ptratio, b, lstat){
  df_features <- data.frame(crim, zn, indus, chas, nox, rm, age, dis, rad, tax, 
                            ptratio, b, lstat, stringsAsFactors = F)
  df_features <- as.data.frame(t(sapply(df_features, as.numeric)))
  df_features$chas <- as.factor(df_features$chas)
  predict(linear_model, newdata = df_features)
}
