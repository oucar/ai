# we will use dplyr inside tidyverse
# https://genomicsclass.github.io/book/pages/dplyr_tutorial.html
library(dplyr)
library(ggplot2)
library(tidyr)
library(tidyverse)
library(nycflights13)

# 1 - Use pivot longer to turn the tibble
# DOCS: https://cran.r-project.org/web/packages/tidyr/vignettes/pivot.html
wide_data=tibble(car=c("toyota1","honda1","toyota2"),
                 miles_2019=c(2000,5000,1000),
                 miles_2020=c(6000,4000,2000))
# into a long format tibble with columns car, year, miles
wide_data
long_data = wide_data %>% pivot_longer(cols = c("miles_2019", "miles_2020"),
                           names_to = "year", values_to="miles")
long_data
long_data$year=str_replace(long_data$year, "miles_","")
long_data

# final code --> all in one line
long_data = wide_data %>% pivot_longer(cols = c("miles_2019", "miles_2020"),
                                       names_to = "year", values_to="miles") %>%
                                       mutate(year=str_replace(year,"miles_",""))

# 2 - join the tibbles planes and flights to sum the number of miles per manufacturer.
# which manufacturer had the most miles? try to write a single line of code for the solution.
flights %>% left_join(planes, by="tailnum") %>%
    group_by(manufacturer) %>% summarise(total_distance=sum(distance)) %>%
    arrange(desc(total_distance))
