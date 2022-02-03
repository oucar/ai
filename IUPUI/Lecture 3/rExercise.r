# we will use dplyr inside tidyverse
# https://genomicsclass.github.io/book/pages/dplyr_tutorial.html
library(dplyr)
library(ggplot2)
library(tidyr)
library(tidyverse)
library(XLConnect)
library(car)
library("ggpubr")
require(gridExtra)


data1 <- read.csv("/Users/onurucar/Desktop/Lab2/1.csv")
data1 <- na.omit(data1)

####################### 1 ##########################
# EXPERIMENT 1 

# data
time = data1$Time
acceleration = data1$Data.Set.4.Acceleration.m.s..
velocity = data1$Data.Set.4.Velocity.m.s.

# grouping
group <- as.factor(ifelse(data1$Data.Set.4.Acceleration.m.s..< 0, "g < 0", "g > 0"))

# acceleration
acc <- ggplot(data1, aes(x = time, y = acceleration, color = group)) +
  geom_point() + 
  geom_line() 
acc

# velocity
vel <- ggplot(data1, aes(x = time, y = velocity)) +
  geom_point() + 
  geom_line() 
vel

grid.arrange(vel, acc, ncol=2)

# EXPERIMENT 2
# data
time = data1$Time
acceleration = data1$Data.Set.5.Acceleration.m.s..
velocity = data1$Data.Set.5.Velocity.m.s.

# grouping
group <- as.factor(ifelse(acceleration < 0, "g < 0", "g > 0"))

# acceleration
acc <- ggplot(data1, aes(x = time, y = acceleration, color = group)) +
  geom_point() + 
  geom_line() 
acc

# velocity
vel <- ggplot(data1, aes(x = time, y = velocity)) +
  geom_point() + 
  geom_line() 
vel

grid.arrange(vel, acc, ncol=2)


# EXPERIMENT 3 
time = data1$Time
acceleration = data1$Data.Set.6.Acceleration.m.s..
velocity = data1$Data.Set.6.Velocity.m.s.

# grouping
group <- as.factor(ifelse(acceleration < 0, "g < 0", "g > 0"))

# acceleration
acc <- ggplot(data1, aes(x = time, y = acceleration, color = group)) +
  geom_point() + 
  geom_line() 
acc

# velocity
vel <- ggplot(data1, aes(x = time, y = velocity)) +
  geom_point() + 
  geom_line() 
vel

grid.arrange(vel, acc, ncol=2)

# EXPERIMENT 4
time = data1$Time
acceleration = data1$Data.Set.7.Acceleration.m.s..
velocity = data1$Data.Set.7.Velocity.m.s.

# grouping
group <- as.factor(ifelse(acceleration < 0, "g < 0", "g > 0"))

# acceleration
acc <- ggplot(data1, aes(x = time, y = acceleration, color = group)) +
  geom_point() + 
  geom_line() 
acc

# velocity
vel <- ggplot(data1, aes(x = time, y = velocity)) +
  geom_point() + 
  geom_line() 
vel

grid.arrange(vel, acc, ncol=2)

# EXPERIMENT 5
time = data1$Time
acceleration = data1$Data.Set.8.Acceleration.m.s..
velocity = data1$Data.Set.8.Velocity.m.s.

# grouping
group <- as.factor(ifelse(acceleration < 0, "g < 0", "g > 0"))

# acceleration
acc <- ggplot(data1, aes(x = time, y = acceleration, color = group)) +
  geom_point() + 
  geom_line() 
acc

# velocity
vel <- ggplot(data1, aes(x = time, y = velocity)) +
  geom_point() + 
  geom_line() 
vel

grid.arrange(vel, acc, ncol=2)

# EXPERIMENT 6
time = data1$Time
acceleration = data1$Data.Set.9.Acceleration.m.s..
velocity = data1$Data.Set.9.Velocity.m.s.

# grouping
group <- as.factor(ifelse(acceleration < 0, "g < 0", "g > 0"))

# acceleration
acc <- ggplot(data1, aes(x = time, y = acceleration, color = group)) +
  geom_point() + 
  geom_line() 
acc

# velocity
vel <- ggplot(data1, aes(x = time, y = velocity)) +
  geom_point() + 
  geom_line() 
vel

grid.arrange(vel, acc, ncol=2)


# ERROR STUFF!
theory_value = 1.19
acc_1 = 1.037
acc_2 = 1.038
acc_3 = 1.037
acc_4 = 1.036
acc_5 = 1.038
acc_6 = 1.032

error_data <- data.frame(
  runs = c(1:6),
  mean_acceleration = c(acc_1, acc_2, acc_3, acc_4, acc_5, acc_6)
)

ggplot(error_data, aes(x=error_data$runs, y=error_data$mean_acceleration, label=mean_acceleration)) +
  geom_point() +
  geom_text(hjust=-0.33, vjust=0) +
  geom_hline(aes(yintercept = theory_value, linetype ="Theorical value = (1.19)"), color="blue") +
  labs(title="Error Analysis", y="acceleration", x="number of runs") +
  theme(legend.position = "right") +
  theme(legend.title = element_blank()) +
  theme(axis.text.x = element_text(angle = 0, vjust = 0.5)) +
  scale_x_continuous(labels = as.character(error_data$runs), breaks = error_data$runs) +
  scale_y_continuous(limits = c(0, 3), breaks = seq(0, 3))

####################### 2 ##########################
data2 <- read.csv("/Users/onurucar/Desktop/Lab2/2.csv")
data2 <- na.omit(data2)

# EXPERIMENT 1
# data
time = data2$Time
acceleration = data2$Data.Set.16.Acceleration.m.s..
velocity = data2$Data.Set.1.Velocity.m.s.

# grouping
group <- as.factor(ifelse(acceleration < 0, "g < 0", "g > 0"))
group

# acceleration
acc <- ggplot(data2, aes(x = time, y = acceleration, color = group)) +
  geom_point() + 
  geom_line() 
acc

# velocity
vel <- ggplot(data2, aes(x = time, y = velocity)) +
  geom_point() + 
  geom_line() 
vel

grid.arrange(vel, acc, ncol=2)


# ERROR STUFF!
theory_value = 9.8
acc_1 = 16.71
acc_2 = 13.07
acc_3 = 14.78
acc_4 = 11.01
acc_5 = 17.46
acc_6 = 11.08

error_data <- data.frame(
  runs = c(1:6),
  mean_acceleration = c(acc_1, acc_2, acc_3, acc_4, acc_5, acc_6)
)

ggplot(error_data, aes(x=error_data$runs, y=error_data$mean_acceleration, label=mean_acceleration)) +
  geom_point() +
  geom_text(hjust=-0.33, vjust=0) +
  geom_hline(aes(yintercept = theory_value, linetype ="Theorical value = (9.8)"), color="blue") +
  labs(title="Error Analysis", y="acceleration", x="number of runs") +
  theme(legend.position = "right") +
  theme(legend.title = element_blank()) +
  theme(axis.text.x = element_text(angle = 0, vjust = 0.5)) +
  scale_x_continuous(labels = as.character(error_data$runs), breaks = error_data$runs) +
  scale_y_continuous(limits = c(0, 18), breaks = seq(0, 18))


