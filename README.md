<h1>&emsp;&emsp;&emsp;Austin Atchley | Houston Shearin<br>&emsp;&emsp;&emsp;&emsp;&nbsp;&nbsp;&nbsp;&nbsp;Drew Hall | Kris Flint</h1>

  This page details what our team did for our final project in CSC 3220 Fundamentals of Data Science at Tennessee Tech University. The dataset we used can be obtained from the following link: [adult-census-income](https://www.kaggle.com/uciml/adult-census-income)


The main goal of this project was to use different classification techniques to find which one had the highest accuracy in predicting which income bracket the individual would fall into based on his or her other features. In order to do this we had to do some data cleaning. The first step in our data cleaning was to get rid of any people that had left values empty. Then in order to allow our classifications to use all of the columns in our data set we began converting them into numeric data types, essentially assigning categorical numbers to each response for each column. The associated number values for each column as well as the download for our cleaned data set can be found [here](https://austinatchley1.github.io/Data-Science-Team-Project/Data-Cleaning.html).

The first method of classification that we used was K-NN. When we initially created our K-NN function we partitioned the training, validation, and test sets randomly through the data set. We then ran a function that randomly selected ks that seemed to be the most optimal based on the training and testing on the validation set. We then recieved and accuracy based on testing on the test set. We ran this function ten times picking the optimal k each time and testing against each test set. After this we would compare the accuracies and identify the optimal k. The average highest accuracy was around 70% and the optimal k value tended to be 21. The code and outputs that we got for knn can be found [here](https://austinatchley1.github.io/Data-Science-Team-Project/Visualization/K-NN.hmtl).

