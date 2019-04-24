## Details some of the Data cleaning we went through on our dataset

Here is a link to download our cleaned version of the data set: [Cleaned Data Set](https://austinatchley1.github.io/Data-Science-Team-Project/adult_cleaned.csv)

"?" Conversion to "NA". We ended up having 2,400 entries with atleast one "?" value. Later, we had to remove these entries to do proper analysis.

Old | New
----|-----
? | NA

<br> 
We had to convert quite a few values into numeric values so they could be used with KNN and Logistical Regression. Each conversion followed this format:

```
cenus$income<-as.numeric(census$income)
```

Workclass conversion.

Workclass | NumericalWorkclass
----------|-------------------
Federal-Gov | 2
Local-Gov | 3
NeverWorked | 4
Private | 5
Self-Imp-Inc | 6
Self-ImpNot-Inc| 7
State-Gov | 8
Without-Pay | 9

<br>

Marital Status conversion.
 
MaritalStatis | NumericalMaritalStatus
-------------|-------------------
Divorced | 1
Married-AF-spouse | 2
Married-civ-spouse | 3
Married-Spouse-Absent | 4
Never-Married | 5
Separated | 6
Widowed | 7


<br>

Occupation Conversion.

Occupation | NumericalOccupation
-------------|-------------------
Adm-clerical | 2
Armed-Forces | 3
Craft-Repair | 4
Exec-Managerial| 5
Farming-Fishing | 6
Handlers-cleaners | 7
Machine-op-inspct | 8
Other-Service | 9
Priv-House-Serv | 10
Prof-Specialty | 11
Protective-Serv |12
Sales | 13
Tech-Support | 14
Transport-Moving | 15

<br>

Relationship Conversion.

Relationship | NumericalRelationship
-------------|-------------------
Husband | 1
Not-In-Family | 2
Other-Relative | 3
Own-Child | 4
Unmarried | 5
Wife | 6

<br>

Race Conversion.

Relationship | NumericalRelationship
-------------|-------------------
 Amer-Indian-Eskimo | 1
Asian-Pac-Islander | 2
Black | 3
Other | 4
White | 5

<br>

Income bracker conversion.

Income Bracket | Number
-------------- | -----
0->50,000 | 1
50,001+ | 2

<br>


Sex conversion.

Sex | Number
--- | -----
F | 1
M | 2

<br>


Native country conversion.

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
Holland-Netherlands | 16
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
