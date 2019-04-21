After splitting the data into a test set, with even number of >50k and <50k to account for class bias,
we ran logitMod to produce a logistic regression.
```
logitMod <- glm(income ~ age+workclass+fnlwgt+education.num+marital.status+occupation+
relationship+race+sex+capital.gain+capital.loss+hours.per.week+native.country, 
data=trainingData, family=binomial(link='logit'), na.action = na.exclude)
```
Note: must treat income as factor
```
> summary(logitMod)

Call:
glm(formula = income ~ age + workclass + fnlwgt + education.num + 
    marital.status + occupation + relationship + race + sex + 
    capital.gain + capital.loss + hours.per.week + native.country, 
    family = binomial(link = "logit"), data = trainingData, na.action = na.exclude)

Deviance Residuals: 
    Min       1Q   Median       3Q      Max  
-4.7420  -0.7873   0.0000   0.8076   3.0019  

Coefficients:
                 Estimate Std. Error z value Pr(>|z|)    
(Intercept)    -7.597e+00  3.686e-01 -20.610  < 2e-16 ***
age             4.114e-02  2.227e-03  18.474  < 2e-16 ***
workclass      -8.928e-02  2.062e-02  -4.330 1.49e-05 ***
fnlwgt          4.064e-07  2.327e-07   1.746  0.08073 .  
education.num   3.431e-01  1.138e-02  30.156  < 2e-16 ***
marital.status -2.726e-01  1.962e-02 -13.897  < 2e-16 ***
occupation     -1.940e-03  6.123e-03  -0.317  0.75135    
relationship   -7.291e-02  2.136e-02  -3.414  0.00064 ***
race            1.054e-01  3.251e-02   3.241  0.00119 ** 
sex             8.841e-01  8.058e-02  10.972  < 2e-16 ***
capital.gain    2.985e-04  1.733e-05  17.230  < 2e-16 ***
capital.loss    6.446e-04  5.761e-05  11.188  < 2e-16 ***
hours.per.week  3.074e-02  2.383e-03  12.904  < 2e-16 ***
native.country  4.118e-03  4.203e-03   0.980  0.32714    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

    Null deviance: 14300.1  on 10317  degrees of freedom
Residual deviance:  9894.6  on 10304  degrees of freedom
  (658 observations deleted due to missingness)
AIC: 9922.6

Number of Fisher Scoring iterations: 7
```
