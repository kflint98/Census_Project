## Details some of the Data cleaning we went through on our dataset

```
//convert all ?'s to NA
census[census == "?"] <-NA

```

```
//convert the income brackets to numeric values
cenus$income<-as.numeric(census$income)

```
