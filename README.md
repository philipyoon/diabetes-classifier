# Diabetes Forecasting

Based on certain diagnostic measurements like BMI, blood pressure, and glucose levels, would one be able to predict whether an individual has diabetes or not? Being able to identify and predict this disease would be the first step towards stopping its progression and recommending preventative measures for those of highest risk.
In this project I test classification methods of SVM with linear and radial kernels, logistic regression, and kNN to predict diabetes diagnosis based on data from the [National Institute of Diabetes and Digestive and Kidney Diseases](https://www.kaggle.com/uciml/pima-indians-diabetes-database) 

# Conclusion

Our final model was a logistic regression fit with probability threshold 0.29 and test error of 0.2844. In our limited testing set only 71.5596% predicted a diabetes diagnosis accurately. Since all the models performed comparably, we can conclude the main lack of accuracy is from the data itself, and tweaking hyperparameters would only go so far to improve each model. The diagnosis is likely linearly separable because the linear SVM performed better than the radial SVM. The final model was highly interpretable as logistic regression showed us how significant certain predictors were to others. Some of the challenges that negatively affected our ability to fit a better model included:
-  Size: This is a relatively small dataset with only 768 original observations and after removing observations due to missing data only 724 observations remained. With a 70/30 test/train split we only had 537 training observations and 231 test observations.
-  Missing Data: The original dataset contained 8 numerical predictions; however, two of these SkinThick- ness and Insulin were missing from a large number of observations. Therefore listwise would’ve resulted in a far smaller dataset, so we elected instead to remove the variables. These variables could have been significant in a diabetes diagnosis so it contributed to a weaker model.
-  Number of variables: With the complexities of the human body, it is almost impossible to use only 6 measurements to diagnose diabetes. Perhaps there would have been other measurements that could have greatly improved our accuracy rate.
This classifier indicated the closest linked variables to diabetes are glucose and BMI. These specific predictors can be focused on to find a physiological link; meanwhile, this classifier could be used to indicate risk of possible diabetes diagnosis.

