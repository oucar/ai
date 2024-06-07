library("tidyverse")

my_data <- read.csv("friends.csv")

# View Data
head(my_data)
tail(my_data)
my_data$p.name

# Start your analysis
my_data %>% 
  select(p.name, colleagues) %>%
  filter(colleagues < 3)
