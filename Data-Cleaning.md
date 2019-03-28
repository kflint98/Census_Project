## Details some of the Data cleaning we went through on our dataset

```
//convert all ?'s to NA
census[census == "?"] <-NA

```

```
//convert the income brackets and sex to numeric values
cenus$income<-as.numeric(census$income)
census$sex <-as.numeric(census$sex)

```
