## GGPLOT2 and TIDYVERSE
library(tidyverse)


## Do cars with big engines use more fuel than cars with small engines?
# ?mpg

# displ: a car's engine size, in litres
# hwy: a car's fuel efficieny on the highway
mpg %>% ggplot() + geom_point(mapping = aes(x = displ, y = hwy))

mpg %>% ggplot() + geom_point(mapping = aes(x = displ, y = hwy, color = class))

# doable, but not a good practice.
mpg %>% ggplot() + geom_point(mapping = aes(x = displ, y = hwy, size = class))

mpg %>% ggplot() + geom_point(mapping = aes(x = displ, y = hwy, alpha = class))

# suvs are gone. ggplot2 will only use six shapes at a time, 7th one is unmarked.
mpg %>% ggplot() + geom_point(mapping = aes(x = displ, y = hwy, shape = class))

mpg %>% ggplot() + geom_point(mapping = aes(x = displ, y = hwy, color = "red"))


## FACETS
# useful for categorical variables -> splits your plot into facets
mpg %>% ggplot() + geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~ class, nrow = 2)

## GEOMS
# scatter plot
mpg %>% ggplot() + geom_point(mapping = aes(x = displ, y = hwy))

# smooth 
mpg %>% ggplot() + geom_smooth(mapping = aes(x = displ, y = hwy))

# more advanced smooth, grouped by drivetrain.
mpg %>% ggplot() + geom_smooth(mapping = aes(x = displ, y = hwy, group = drv, color = drv))

# multiple geoms in the same ggplot
mpg %>% ggplot() +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

# in order to avoid code duplications
mpg %>% ggplot(mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) + 
  geom_smooth()

# geom smooth overrides the global data argument -> subcompact
mpg %>% ggplot(mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE)


## STATISTICAL TRANSFORMATIONS
# more diamonds are available with high quality cuts than with low quality cuts
# count was not a variable in the data set!
diamonds %>% ggplot() + geom_bar(mapping = aes(x = cut))



