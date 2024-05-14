#install.packages("remotes")
#remotes::install_github("davidsjoberg/ggsankey")
# library(ggsankey)
# install.packages("ggplot2")
library(ggplot2)
# install.packages("dplyr")
# library(dplyr) # Also needed
# library(tidyr)
install.packages("plotly")
library(plotly)

# df <- mtcars %>%
#   make_long(cyl, vs, am, gear, carb)
#
# ggplot(df, aes(x = x,
#                next_x = next_x,
#                node = node,
#                next_node = next_node,
#                fill = factor(node),
#                label = node)) +
#   geom_sankey() +
#   geom_sankey_label() +
#   theme_sankey(base_size = 16)

# with own data
# make data
data <- data.frame(
  income = c("Parents", "HiWi"),
  Rent = c(300, 0),
  Food = c(75, 75),
  TakeOut = c(10, 10),
  Gas = c(100, 25),
  DrinksAndCoffee = c(1, 40),
  IceCream = c(0, 25),
  Mensa = c(40, 10),
  Flowers = c(10, 10),
  Other = c(200, 5))

#df2 <- data %>%
#  make_long(Rent, Food, TakeOut, Gas, DrinksAndCoffee,IceCream, Mensa, Flowers, Other)
df3 <- data%>% pivot_longer(cols=c(Rent, Food, TakeOut, Gas, DrinksAndCoffee,IceCream, Mensa, Flowers, Other),names_to = 'SpentFor', values_to="amount")

# ggplot(df3, aes(x = income,
#                 next_x = next_x,
#                 node = node,
#                 next_node = next_node,
#                 fill = factor(node),
#                 label = node)) +
#   geom_sankey() +
#   geom_sankey_label() +
#   theme_sankey(base_size = 16)

# Sankey diagram with plotly
# make frequencies data frame
freq_table <- df3 %>% group_by(income, SpentFor, amount) %>%
  summarise(n = amount)
# create nodes data frame
nodes <- data.frame(name = unique(c(as.character(freq_table$income),
                                    as.character(freq_table$SpentFor),
                                    as.character(freq_table$amount))))
# create links data frame
links <- data.frame(source = match(freq_table$income, nodes$name) - 1,
                    target = match(freq_table$SpentFor, nodes$name) - 1,
                    value = freq_table$n,
                    stringsAsFactors = FALSE)


plot_ly(
  type = "sankey",
  orientation = "h",
  node = list(pad = 15,
              thickness = 20,
              line = list(color = "black", width = 0.5),
              label = nodes$name),
  link = list(source = links$source,
              target = links$target,
              value = links$value),
  textfont = list(size = 10),
  width = 720,
  height = 480
) %>%
  layout(title = "Sankey Diagram: Income vs what it is spend for",
         font = list(size = 14),
         margin = list(t = 40, l = 10, r = 10, b = 10))
