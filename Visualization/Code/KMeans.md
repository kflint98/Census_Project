clusters <- kmeans(na.omit(census), 2)

temp<-data.frame(na.omit(census), cluster=factor(clusters$cluster))

ggplot(temp, aes(x=race, y=income, color=cluster))+geom_point()
