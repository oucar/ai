# Cleaning, manipulating the data 

# Find and deal with missing data
# Recording values, dealign with the variable types you need etc
library(tidyverse) 
view(starwars)


## Variable Types
glimpse(starwars)
class(starwars$gender)
unique(starwars$gender)

## Factor -> categorical variable (order matters)
starwars$gender <- as.factor(starwars$gender)
class(starwars$gender)
glimpse(starwars)

# feminine comes first, but we can change it
levels(starwars$gender)
starwars$gender <- factor((starwars$gender),
                          levels = c("masculine", "feminine"))

## Shift + CTRL + M to %>% 
starwars %>% 
  select(name, height, ends_with("color")) %>% 
  filter(hair_color %in% c("blond", "brown") & (height < 180)) 

## Dealing with the missing data
# R programming language doesn't know what to do with the missing data
mean(starwars$height, na.rm = T)

# Best way to deal with the missing data!!
# try not to use na.omit()!
# Only omits if height is na.
starwars %>% 
  select(name, gender, hair_color, height) %>% 
  filter(!complete.cases(.)) %>% 
  drop_na(height) %>% 
  mutate(hair_color = replace_na(hair_color, "none"))
