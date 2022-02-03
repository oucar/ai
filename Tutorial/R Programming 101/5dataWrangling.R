library(tidyverse)

# View Data
?msleep
glimpse(msleep)
View(msleep) 

# Rename a variable
msleep %>% 
  rename("conserv" = "conservation") %>% 
  glimpse()

# Reorder variables
msleep %>% 
  select(vore, name, everything())

# Select variables to work with
msleep %>% select(2:4, awake, starts_with("sleep"), contains("wt")) %>% 
  names()

# Filter and arrange data
unique(msleep$order)

msleep %>% filter((order == "Carnivora" | order == "Primates") & sleep_total > 8) %>% 
  select(name, order, sleep_total) %>% 
  arrange(-sleep_total)
View(msleep)

# Change observations using mutate
msleep %>% mutate(brainwt_in_grams = brainwt * 1000)
View(mSleep)

# Conditional changes (if_else)
## logical vector based on a condition
size_of_brain <- msleep %>% 
  select(name, brainwt) %>% 
  drop_na(brainwt) %>% 
  mutate(brain_size = if_else(brainwt > 0.01, "large", "small"))
View(size_of_brain)


##### SUPER IMPORTANT!!! #####
# Reshape the data from wide to long or long to wide!!
library(gapminder)
View(gapminder)

# simplify the dataset
# multiple year records for the same country, might not be exactly what we want :(
# This is called long data.
data <- select(gapminder, country, year, lifeExp)
View(data)

wide_data <- data %>% 
  pivot_wider(names_from = "year", values_from = "lifeExp")
View(wide_data)

# back to normal
long_data <- wide_data %>% 
  pivot_longer(2:13, names_to = "year", values_to = "lifeExp")
View(long_data)

