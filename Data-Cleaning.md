## Details some of the Data cleaning we went through on our dataset

convert all ?'s to NA

```
census[census == "?"] <-NA

```

convert the income brackets, sex, and native.country to numeric values

```
cenus$income<-as.numeric(census$income)
census$sex <-as.numeric(census$sex)
census$sex <-as.numeric(census$native.country)

```
<br>
Income Bracket | Number
-------------- | -----
0->50,000 | 1
50,001+ | 2


Sex | Number
--- | -----
F | 1
M | 2

Country               | Number 
--------------------- | ------
Cambodia | 2
Canada | 3
China | 4
Columbia | 5
Cuba | 6
Dominican-Republic| 7
Ecuador | 8
El-Salvador | 9 
England | 10
France | 11
Germany | 12
Greece | 13
Guatemala | 14
Haiti | 15
Holand-Netherlands | 16
Honduras | 17
Hong | 18
Hungary | 19
India | 20
Iran | 21
Ireland | 22
Italy | 23  
Jamaica | 24 
Japan | 25
Laos | 26
Mexico | 27
Nicaragua | 28
Outlying-US(Guam-USVI-etc) | 29
Peru | 30
Philippines | 31
Poland | 32
Portugal | 33
Puerto-Rico | 34
Scotland |35
South | 36
Taiwan | 37
Thailand | 38
United-States | 40
Vietnam | 41
Yugoslavia | 42
