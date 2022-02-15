library(tidyverse)
library(ggplot2)

data <- read.csv(
  file = "new_data.csv",
  dec = ".",
  colClasses = 
  )

View(data)

################# ACTIVITY I #################
time = data$Time..s.
acc_z = data$Acceleration.z..m.s.2.
acc_abs = data$Absolute.acceleration..m.s.2.

subscript = expression(paste("Accelaration in z-axis (",m/s^2,")"))


# Graph 1
act1_g1 <- data %>% ggplot(aes(x = time, y = acc_z)) + geom_line() + coord_cartesian(xlim=c(0, 18)) + scale_x_continuous(expand = c(0, 0), limits = c(0, NA))
act1_g1 + xlab("time (seconds)") + ylab(subscript) + scale_y_continuous(breaks=-20:10)

# Graph 2
act1_g2 <- data %>% ggplot(aes(x = time, y = acc_z)) + geom_line() + coord_cartesian(xlim=c(13, 18)) + scale_x_continuous(expand = c(0, 0), limits = c(0, NA))
act1_g2 + xlab("time (seconds)") + ylab(subscript) + scale_y_continuous(breaks=-20:10)


################# ACTIVITY II #################
time = data$Time..s.
acc_z = data$Acceleration.z..m.s.2.
velocity = data$Velocity

act2_g1 <- data %>% ggplot(aes(x = time, y = velocity)) + geom_line() + coord_cartesian(xlim=c(15.5, 17.5)) + scale_x_continuous(expand = c(0, 0), limits = c(0, NA))
act2_g1 + xlab("time (seconds)") + ylab("velocity (m/s)")

View(data)

# 1595 - 1665
act2_g2 <- ggplot(data=data.frame( x=c(0, 0.7),y=c(0,-3.5) ), aes(x=x,y=y)) + 
  geom_point(aes(x=0.7, y=-3.06), shape = 1) +
  geom_abline(slope = -4.37, col="red") +
  geom_hline(yintercept = 0) +
  geom_vline(xintercept = 0) +
  geom_vline(xintercept = 0.7, linetype="dashed", color="blue") +
  scale_y_continuous(breaks = scales::pretty_breaks(n = 10)) +
  scale_x_continuous(breaks = scales::pretty_breaks(n = 10)) 
act2_g2 + xlab("time (seconds)") + ylab("velocity (m/s)")


##################### ERROR ANALYSIS ################
time1 = 0.5
acc1 = -8.565984898
displcement1 = -1.07

time2 = 0.6
acc2 = -8.481069848
displacement2 = -1.52

time3 = 0.6
acc3 = -7.471530556
displacement3 = -1.34

time4 = 0.6
acc4 = -7.18
displacement4 = -1.29

time5 = 0.7
acc5 = -6.19
displacement5 = -1.51

## graphing Velocity - time
actVar <- ggplot(data=data.frame( x=c(0, 2),y=c(0,-10) ), aes(x=x, y=y)) + 
  geom_point(aes(x=1, y=-3.06), shape = 1) +
  geom_abline(slope = -5.5715, col="red") +
  geom_hline(yintercept = 0) +
  geom_vline(xintercept = 0) +
  geom_vline(xintercept = 0.8, linetype="dashed", color="blue") +
  scale_y_continuous(breaks = scales::pretty_breaks(n = 10)) +
  scale_x_continuous(breaks = scales::pretty_breaks(n = 10)) 
actVar + xlab("time (seconds)") + ylab("velocity (m/s)")

## Graphing the error analysis
accData <- read.csv("acc_data.csv")
expectedAcc = -9.8
expectedDispl = -1

accErr <- accData %>% ggplot(aes(x = number, y = acc)) + geom_point() +
  geom_hline(yintercept = -9.8, color = "blue") + 
  geom_label(
    label="-9.8", 
    x=3.1,
    y=-9.8,
    color = "black"
  ) +
  geom_point() +
  geom_text(
    label=accData$acc, 
    nudge_x = 0.2, nudge_y = 0.1, 
    check_overlap = T
  ) +
  ylim(-15, 0) 


subscript = expression(paste("Average accelaration in z-axis (",m/s^2,")"))
accErr + xlab("Number of runs") + ylab(subscript) + theme(legend.text = element_text(color="blue"))

## displacement
accErr <- accData %>% ggplot(aes(x = number, y = disp)) + geom_point() +
  geom_hline(yintercept = -1, color = "blue") + 
  geom_label(
    label="-1", 
    x=3.1,
    y=-1,
    color = "black"
  ) +
  geom_point() +
  geom_text(
    label=accData$disp, 
    nudge_x = 0.2, nudge_y = 0.1, 
    check_overlap = T
  ) +
  ylim(-2, 0) 

accErr + xlab("Number of runs") + ylab("Displacement (m)") + theme(legend.text = element_text(color="blue"))
                   