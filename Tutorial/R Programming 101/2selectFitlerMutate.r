library(tidyverse)

# comes with tidyverse package
View(starwars)

# Task : Calculate the average BMI for only human males and females

starwars %>% 
  select(gender, mass, height, species) %>%
  filter(species == "Human") %>%
  na.omit() %>% 
  mutate(height = height / 100) %>%
  mutate(BMI = mass / height^2) %>% 
  group_by(gender) %>% 
  summarise(Average_BMI = mean(BMI))
  