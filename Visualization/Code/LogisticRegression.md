First we need to load a library used later
```
library(InformationValue)
```
Then we need to split the data set into training and test sets

Keep in mind we need to account for bias
```
input_ones <- adult_cleaned[which(adult_cleaned$income == 1),]
input_twos <- adult_cleaned[which(adult_cleaned$income == 2),]
input_ones_training_rows <- sample(1:nrow(input_ones), 
  0.7*nrow(input_ones))
input_twos_training_rows <- sample(1:nrow(input_twos), 
  0.7*nrow(input_twos))
training_ones <- input_ones[input_ones_training_rows, ]
training_twos <- input_twos[input_twos_training_rows, ]
train <- rbind(training_ones, training_twos)

test_ones <- input_ones[-input_ones_training_rows, ]
test_twos <- input_twos[-input_ones_training_rows, ]

test <- rbind(test_ones, test_twos)
```
In order to run the glm function we need to adjust the income column so that it is between 0 and 1
```
train$income <- train$income / 2
test$income <- test$income / 2
```
Now we can run the general linear model to assign weights to the features
```
logitMod <- glm(income ~ age + workclass + fnlwgt + education.num + 
  marital.status + occupation + relationship + race + sex + 
  capital.gain + capital.loss + hours.per.week + native.country, 
  data = train, family = binomial(link='logit'))
```

The table below shows the weights of the coefficients as calulated by the glm

I have bolded what appear to be the three most significant features

Feature | Weight(SciNot) | Weight(RegNot)
------- | -------------- | --------------
(Intercept) | -1.430069e+00 | -1.430069
age | 9.934648e-03 | 0.009934648
workclass | -2.307790e-02 | -0.02307790
fnlwgt | 1.663859e-07 | 0.0000001663859
**education.num** | **9.775032e-02** | **0.097750323**
**marital.status** | **-4.720031e-02** | **-0.04720031**
occupation | 3.855465e-03 | 0.003855465
relationship | -3.168257e-02 | -0.03168257
race | 3.381686e-02 | 0.03381686
**sex** | **2.286772e-01** | **0.2286772**
capital.gain | 1.875236e-04 | 0.0001875236
capital.loss | 3.470100e-04 | 0.0003470100
hours.per.week | 7.127751e-03 | 0.007127751
native.country | -1.183745e-03 | -0.001183745

Now we need to run this model and make predictions on our test set
```
pred_vals <- predict(logitMod, test, type="response")
```
Now we can test to see where the optimal cutoff point for the model is
```
optimal <- optimalCutoff(test$income, pred_vals)
```
For the final part we can calculate the missclassification rates
```
misClassError(test$income, pred_vals)
[1] 0.3895
misClassError(test$income, pred_vals, threshold = optimal)
[1] 0.2517
```
The first missclassification rate represents what happens when we stop at the default threshold of 0.5

Based on this misclassification rate we can see that the approximate accuracy of our model is 74.83%
