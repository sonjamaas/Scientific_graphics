install.packages("ggstream")
library(ggstream)

#blockbusters

# install.packages("ggstream")
#library(ggstream)
# install.packages("ggplot2")
library(ggplot2)

cols <- c("#FFB400", "#FFC740", "#C20008", "#FF020D", "#13AFEF")

ggplot(blockbusters, aes(x = year, y = box_office, fill = genre)) +
  geom_stream(extra_span = 0.2) +
  geom_stream(extra_span = 0.2, true_range = "none",
              alpha = 0.3) +
  scale_fill_manual(values = cols) +
  theme_minimal()+
  guides(fill = guide_legend(title = "Genres"))+
  xlab("Year")+
  ylab("Box office")+
  ggtitle("Box office per Genre 1977 - 2017", subtitle = ("Dataset Blockbusters"))

