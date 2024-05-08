setwd("C:/Users/sonja/OneDrive/Dokumente/EAGLE_Msc/Semester2/Scientific_graphs")
task1 <- read.csv("task1_data.csv")

library(ggplot2)
ggplot(task1, aes(x=x,y=y))+geom_point()
