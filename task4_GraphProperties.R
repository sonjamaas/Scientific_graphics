library(ggplot2)
data()
View(Orange)


# Create plots with different themes:

ggplot(data = Orange, aes(x = age, y = circumference, colour = Tree))+
  geom_point(size = 5)+
  geom_line()+
  ylab("Circumference [mm]")+
  xlab("Tree Age [Days since 1968/12/31 ")+
  ggtitle("Growth of Orange Trees")+
  theme_linedraw()

ggplot(data = Orange, aes(x = age, y = circumference, colour = Tree))+
  geom_point(size = 5)+
  geom_line()+
  ylab("Circumference [mm]")+
  xlab("Tree Age [Days since 1968/12/31 ")+
  ggtitle("Growth of Orange Trees")+
  theme_minimal()

ggplot(data = Orange, aes(x = age, y = circumference, colour = Tree))+
  geom_point(size = 5)+
  geom_line()+
  ylab("Circumference [mm]")+
  xlab("Tree Age [Days since 1968/12/31 ")+
  ggtitle("Growth of Orange Trees")+
  theme_test(base_size = 15)

ggplot(data = Orange, aes(x = age, y = circumference, colour = Tree))+
  geom_point(size = 5)+
  geom_line()+
  ylab("Circumference [mm]")+
  xlab("Tree Age [Days since 1968/12/31 ")+
  ggtitle("Growth of Orange Trees")+
  theme_void(base_size = 15)


# Various shapes/line types

ggplot(data = Orange, aes(x = age, y = circumference, colour = Tree))+
  geom_point(aes(shape = Tree, size = 5))+
  geom_line()+
  ylab("Circumference [mm]")+
  xlab("Tree Age [Days since 1968/12/31 ")+
  ggtitle("Growth of Orange Trees")+
  theme_test(base_size = 15)



