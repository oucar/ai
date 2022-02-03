library(tidyverse)

sw <- starwars %>%
  select(name, height, mass, gender) %>%
  rename(weight = mass) %>%
  na.omit() %>% 
  mutate(height = height / 100)


# Filtering data
data <- msleep %>%
  select(name, order, bodywt, sleep_total) %>%
  filter(order == "Primates" | bodywt > 20)
