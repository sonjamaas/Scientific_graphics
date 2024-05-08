setwd("C:/Users/sonja/Documents/Dokumente/Studium/Master/scientific_graphics")
emperors <- read.csv("emperors.csv")

library(ggplot2)
library(dplyr)
library(forcats)
library(lubridate)

# question: how long did the roman emperors reign?
#           what was the most common killer?
#           how old where they when they got killed/what was the most dangerous age?

# plot name vs. age
ggplot(emperors, aes(x=name, y=year(as.period(interval(birth, death)))))+ geom_col()

# group by age
age_counts <- emperors%>%
  mutate(age = year(as.period(interval(birth, death))))%>%
  group_by(age)%>%
  summarize(count =n())

ggplot(age_counts, aes(x=age,y=count))+
  geom_col()


# group them in groups of five years
age_group_counts <- emperors%>%
  mutate(age = year(as.period(interval(birth, death))))%>%
  mutate(age_group = cut(age, breaks = seq(0, 80, by = 5), labels = FALSE))%>%
  group_by(age_group)%>%
  summarize(count =n())

ggplot(age_group_counts, aes(x=age_group,y=count))+
  geom_col()


# make the x axis show the middle of each age group and not the age group number
age_group_midpoints <- age_group_counts %>%
  mutate(age_midpoint = (age_group * 5) - 2.5)

age_group_counts <- emperors%>%
  mutate(age = year(as.period(interval(birth, death))))%>%
  mutate(age_group = cut(age, breaks = seq(0, 80, by = 5), labels = FALSE))%>%
  group_by(age_group)%>%
  summarize(count =n())

ggplot(age_group_midpoints, aes(x=age_midpoint,y=count))+
  geom_col()+
  scale_x_continuous(breaks=unique(age_group_midpoints$age_midpoint),labels = unique(age_group_midpoints$age_midpoint))


# make the x axis show the beginning of each age group and not the age group number
age_group_start <- age_group_counts %>%
  mutate(age_start = (age_group * 5) - 5)

age_group_counts <- emperors%>%
  mutate(age = year(as.period(interval(birth, death))))%>%
  mutate(age_group = cut(age, breaks = seq(0, 80, by = 5), labels = FALSE))%>%
  group_by(age_group)%>%
  summarize(count =n())

ggplot(age_group_start, aes(x=age_start,y=count))+
  geom_col()+
  scale_x_continuous(breaks=unique(age_group_start$age_start),labels = unique(age_group_start$age_start))


# labeling and title
age_group_start <- age_group_counts %>%
  mutate(age_start = (age_group * 5) - 5)

age_group_counts <- emperors%>%
  mutate(age = year(as.period(interval(birth, death))))%>%
  mutate(age_group = cut(age, breaks = seq(0, 80, by = 5), labels = FALSE))%>%
  group_by(age_group)%>%
  summarize(count =n())

ggplot(age_group_start, aes(x=age_start,y=count))+
  geom_col()+
  scale_x_continuous(breaks=unique(age_group_start$age_start),labels = unique(age_group_start$age_start))+
  xlab("Age (+5 years)")+
  ylab("Number")+
  geom_text(aes(label = age_group_counts$count),
            color = "white",
            size = 5,
            hjust = 1,
            nudge_y = -.5)+
theme(
  axis.line.y=element_blank(),
  legend.position ="none",
  panel.grid = element_blank(),
  plot.title = element_text(size=18, lineheight = 0.9))+
ggtitle("Roman Emperors, Age of Death", subtitle = paste0("(data of ", count(emperors), " emperors)"))

# highlight the highest bars
age_group_start <- age_group_counts %>%
  mutate(age_start = (age_group * 5) - 5)

age_group_counts <- emperors%>%
  mutate(age = year(as.period(interval(birth, death))),
         age_group = cut(age, breaks = seq(0, 80, by = 5), labels = FALSE))%>%
  group_by(age_group)%>%
  summarize(count =n())

ggplot(age_group_start, aes(x=age_start,y=count, fill = count))+
  geom_col()+
  scale_x_continuous(breaks=unique(age_group_start$age_start),labels = unique(age_group_start$age_start))+
  xlab("Age (in groups of 5 years)")+
  ylab("Number")+
  geom_text(aes(label = age_group_counts$count),
            color = "white",
            size = 5,
            hjust = 1,
            nudge_y = -.5)+
  theme(
    axis.line.y=element_blank(),
    legend.position ="none",
    panel.grid = element_blank(),
    plot.title = element_text(size=18, lineheight = 0.9))+
  ggtitle("Roman Emperors, Age of Death", subtitle = paste0("(data of ", count(emperors), " emperors)"))


# record the process
install.packages("camcorder")
library(camcorder)

gg_record(
  dir = file.path("C:/Users/sonja/Documents/Dokumente/Studium/Master/scientific_graphics", "recording"),
  device = "png", # we need to set the Cairo device
  width = 8,
  height = 5
)

gg_playback(
  name = file.path("C:/Users/sonja/Documents/Dokumente/Studium/Master/scientific_graphics", "recording", "RomanEmperorsAge.gif"),
  first_image_duration = 4,
  last_image_duration = 12,
  frame_duration = .5,
  image_resize = 900,
  width = 800,
  height = 800
)

gg_stop_recording()
