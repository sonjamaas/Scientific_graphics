library(ggplot2)
library(gridExtra)
data()
View(msleep)

# normal scale
normalScale <- ggplot(msleep, aes(x = bodywt, y = sleep_total))+
  geom_point(aes(colour = vore),
             size = 2)+
  xlab("Bodyweight in kg (log scale)")+
  ylab("Total amount of sleep in h/day")+
  ggtitle("Sleeping hours of mammals")


logScale <- ggplot(msleep, aes(x = bodywt, y = sleep_total))+
  geom_point(aes(colour = vore),
             size = 2)+
  # geom_text(data = subset(msleep, name == "Lesser short-tailed shrew" |
  #                           name == "African elephant"),
  #           aes(label = name),
  #           color = "black",
  #           nudge_y = -1)+
  xlab("Bodyweight in kg (log scale)")+
  ylab("Total amount of sleep in h/day")+
  scale_x_continuous(trans="log10")+
  ggtitle("Sleeping hours of mammals")

grid.arrange(normalScale,logScale, ncol=2)
