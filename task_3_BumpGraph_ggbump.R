# Load packages and get some data with rank:

devtools::install_github("davidsjoberg/ggbump")
install.packages("wesanderson")
library(ggbump)
library(tidyverse)
library(cowplot)
library(wesanderson)

df <- tibble(name = c("Sonja", "Sonja", "Sonja", "Sonja", "Sonja", "Sonja",
                      "Alena", "Alena", "Alena", "Alena", "Alena", "Alena",
                      "Kristin", "Kristin", "Kristin", "Kristin", "Kristin", "Kristin",
                      "Paul", "Paul", "Paul", "Paul", "Paul", "Paul",
                      "Hauke", "Hauke", "Hauke", "Hauke", "Hauke", "Hauke"),
             BaSemester = c(1, 2, 3, 4, 5, 6,
                            1, 2, 3, 4, 5, 6,
                            1, 2, 3, 4, 5, 6,
                            1, 2, 3, 4, 5, 6,
                            1, 2, 3, 4, 5, 6),
             motivation = c(9, 8, 5, 6, 8, 8,
                            3, 4, 4, 3, 6, 7,
                            8, 7, 7, 6, 3, 6,
                            5, 6, 5, 5, 8, 9,
                            7, 8, 9, 10, 7, 8))

knitr::kable(head(df))

# To create a ranking column we use rank from base R.
# We specify ties.method = "random" to make sure that each country have different rankings
# if they have the same value.

df <- df %>%
  group_by(BaSemester) %>%
  mutate(rank = rank(motivation,
                     ties.method = "random")) %>%
  ungroup()

knitr::kable(head(df))

# most simple use case
ggplot(df, aes(BaSemester,
               rank,
               color = name)) +
  geom_bump()

# Improve the bump chart by adding a legend, colours, points,
# remove grid, add the axis texts and text labels for the names
ggplot(df, aes(BaSemester,
               rank,
               color = name)) +
  geom_point(size = 7)+
  geom_text(data = df %>% filter(BaSemester == min(BaSemester)),
            aes(x = BaSemester - .1,
                label = name),
            size = 5,
            hjust = 1) +
  geom_text(data = df %>% filter(BaSemester == max(BaSemester)),
           aes(x = BaSemester + .1,
               label = name),
           size = 5,
           hjust = 0) +
  geom_bump(size = 2, smooth = 8)+
  scale_x_continuous(breaks = c(1,2,3,4,5,6)) +
  theme_minimal_grid(font_size = 14,
                     line_size = 0) +
  theme(panel.grid.major = element_blank()) +
  labs(y = "Motivation",
       x = "BA Semester")+
  scale_color_manual(values = wes_palette(n = 5,
                                          name = "Royal2"))+
  ggtitle("Bump Graph of the Motivation of Bachelor Students from Semester 1 to 6")
