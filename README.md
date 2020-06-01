# Diabetes Forecasting
Testing different classification models to predict diabetes diagnosis.

Tested a variety of models and decided upon kNN classifier finding k using LOOCV. For a relatively small dataset, LOOCV was chosen over something like 10-fold cross validation as it won't be computationally expensive and it allows us to train the model using all of the few observations we have. 

Deployed as a R Shiny web app to use for classification and prediction.
