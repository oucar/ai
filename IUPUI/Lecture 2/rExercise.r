# we will use dplyr inside tidyverse
# https://genomicsclass.github.io/book/pages/dplyr_tutorial.html
library(dplyr)
library(ggplot2)
library(tidyr)


data <- read.csv("/Users/onurucar/Desktop/Github/Data-Science/IUPUI/Lecture 2/IMDB-MovieData.csv")

# example of filter
metaScoreGreaterThan90 <- filter(data, Metascore >= 90)

# Q1: Make a bar plot of the average revenue vs year
# Hint: use group_by and summarise
# na.rm removes the NA values
# ggplot --> https://datacarpentry.org/R-ecology-lesson/04-visualization-ggplot2.html
data  %>% group_by(Year) %>% summarise(average_revenue=mean(Revenue..Millions., na.rm = TRUE)) %>%
    ggplot(aes(x=Year, y=average_revenue)) + geom_point()
  

# Which movie genre in the data has the longest avarage runtime?
# Hint: analyze the first listed genre, which you can extract using “separate”. 
# Then use group_by and summarise
# Bar plot -> for visualization purposes
data %>% separate(Genre, c("G1", "G2", "G3"), sep=",") %>% 
  group_by(G1) %>%
  summarise(average_runtime=mean(Runtime..Minutes., na.rm=T)) %>%
  ggplot(aes(x=G1, y=average_runtime)) + geom_bar(stat='identity')

# print the longest avarage runtime
secondData = data %>% separate(Genre, c("G1", "G2", "G3"), sep=",") %>% 
  group_by(G1) %>%
  summarise(average_runtime = mean(Runtime..Minutes., na.rm=T)) %>%
  summarise(maximum_runtime = max(average_runtime, na.rm=T)) %>%
  print(secondData$maximum_runtime)
  

# Which director in the data has worked in most number of (different) years?
# You can use select, distinct, group_by, summarise, arrange
