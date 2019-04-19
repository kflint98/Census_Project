clusters <- kmeans(na.omit(census), 2)

temp<-data.frame(na.omit(census), cluster=factor(clusters$cluster))

ggplot(temp, aes(x=fnlwgt, y=capital.loss, color=cluster))+geom_point()

![KMeans Graph](https://austinatchley1.github.io/Data-Science-Team-Project/Visualization/KMeansK=2.png)
