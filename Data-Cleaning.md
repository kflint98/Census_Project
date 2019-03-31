## Details some of the Data cleaning we went through on our dataset

convert all ?'s to NA

```
census[census == "?"] <-NA

```

convert the income brackets and sex to numeric values

```
cenus$income<-as.numeric(census$income)
census$sex <-as.numeric(census$sex)

```
the income changed to 1 for less than or equal to 50K and 2 for greater than 50k
the sex changed to 1 for female and 2 for male
