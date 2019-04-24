First we need to load a library used later.
```
library(InformationValue)
```
Then we need to split the data set into training and test sets.
Keep in mind we need to account for bias.
```
input_ones <- adult_cleaned[which(adult_cleaned$income == 1),]
input_twos <- adult_cleaned[which(adult_cleaned$income == 2),]
input_ones_training_rows <- sample(1:nrow(input_ones), 0.7*nrow(input_ones))
input_twos_training_rows <- sample(1:nrow(input_twos), 0.7*nrow(input_twos))
training_ones <- input_ones[input_ones_training_rows, ]
training_twos <- input_twos[input_twos_training_rows, ]
train <- rbind(training_ones, training_twos)

test_ones <- input_ones[-input_ones_training_rows, ]
test_twos <- input_twos[-input_ones_training_rows, ]

test <- rbind(test_ones, test_twos)
```
In order to run the glm function we need to adjust the income column so that it is between 0 and 1.
```
train$income <- train$income / 2
test$income <- test$income / 2
```
Now we can rum the general linear model to assign weights to the features.
```
logitMod <- glm(income ~ age + workclass + fnlwgt + education.num + marital.status + occupation + relationship + race + sex + capital.gain + capital.loss + hours.per.week + native.country, data = train, family = binomial(link='logit'))

(Intercept) | -1.430069e+00
age | 9.934648e-03
workclass | -2.307790e-02
fnlwgt | 1.663859e-07
education.num | 9.775032e-02
marital.status | -4.720031e-02
occupation | 3.855465e-03
relationship | -3.168257e-02
race | 3.381686e-02
sex | 2.286772e-01
capital.gain | 1.875236e-04
capital.loss | 3.470100e-04
hours.per.week | 7.127751e-03
native.country | -1.183745e-03
```

```
predicted <- predict(logitMod, test, type="response")

optCutOff <- optimalCutoff(test$income, predicted)

misClassError(test$income, predicted)
[1] 0.3895
misClassError(test$income, predicted, threshold = optCutOff)
[1] 0.2517
```
