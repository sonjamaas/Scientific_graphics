setwd("C:/Users/sonja/OneDrive/Dokumente/EAGLE_Msc/Semester2/Scientific_graphs")
emperors <- read.csv("emperors.csv")

#what kind of data is available within this data set?
emperors

# first plot
library(ggplot2)
library(dplyr)
library(forcats)

ggplot(emperors, aes(x=name, y=cause))+ geom_col()

# improve readability, design, message
# our question: what killed emperors?
# combined data analysis and plotting

# plot of number vs. causes of death
emperors %>%
  count(cause)%>%
  arrange(n)%>%
  mutate(assassinated = ifelse(cause == "Assassination", TRUE, FALSE),
         cause = fct_inorder(cause)) %>%
  ggplot(aes(x=n,
             y=cause,
             fill = assassinated))+
  geom_col()+
  geom_text(aes(label = n,
                x = n - .25),
            color = "white",
            size = 5,
            hjust = 1) +
  xlab("number")+
  scale_fill_manual( name = NULL,
                     values = c("lightgray", "steelblue"))+
  theme(
    axis.line.y=element_blank(),
    legend.position ="none",
    panel.grid = element_blank(),
    plot.title = element_text(size=18, lineheight = 0.9))+
  ggtitle("Roman Emperors", subtitle = paste0("(data of ", count(emperors), " emperors)"))

