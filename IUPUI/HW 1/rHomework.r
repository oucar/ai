# we will use dplyr inside tidyverse
# https://genomicsclass.github.io/book/pages/dplyr_tutorial.html
library(dplyr)
library(ggplot2)
library(tidyr)
library(nycflights13)
library(tidyverse)

## QUESTION 1
## Categorical variables in R are called characters. They are stored as strings
## Continuous varibles in R are called doubles or integers.
class(mpg$displ)
class(mpg$cty)
class(mpg$class)

## QUESTION 2
table(mpg$year)

## QUESTION 3
ggplot(data=mpg)+geom_histogram(aes(x=displ))
ggplot(data=mpg)+geom_bar(aes(x=displ))
ggplot(data=mpg)+geom_density(aes(x=displ))
ggplot(data=mpg)+geom_boxplot(aes(x=displ))

## QUESTION 4
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy),position = "jitter")

## QUESTION 5
diamonds %>% ggplot()+geom_point(aes(x=carat,y=price,color=color))+facet_wrap(~cut)

## QUESTION 6
str(flights)
str(flights$dep_delay, rm.na=T)
flights %>% group_by(month) %>% summarise(average_dep_delay = mean(dep_delay, na.rm=T))

## QUESTION 7
flights %>% group_by(year, month, day) %>% summarise(flights = n()) %>% print(n=365)

## QUESTION 8
q8Data <- flights %>% group_by(tailnum) %>% summarise(worst = max(arr_delay)) 
q8Data[order(q8Data$worst, decreasing = T),]

## QUESTION 9
q9Data <- flights %>% group_by(hour) %>% summarise(min_delay = min(dep_delay, na.rm=T))
q9Data[order(q9Data$min_delay, decreasing = F),]


## QUESTION 10
flights %>% 
  group_by(origin) %>% 
  mutate(prev_flight_dep_delay = lag(dep_delay)) %>%

                   