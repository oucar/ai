library(nycflights13)
library(tidyr)
data = read.csv("Beerwings.csv")
head(data)

### 1 -
g1_convert = 123/500
g2_convert = 63/300

res <- prop.test(x = c(123, 63), n = c(500, 300))
# p > a 
res

### 3-
# Sum of NA in the column Dep_Delay = 8255
sum(is.na(flights$dep_delay))

# remove NA from the column Dep_Delay
flights <- flights %>% drop_na(dep_delay)

# Sum of NA in the column Dep_Delay = 0
sum(is.na(flights$dep_delay))

# Calculating 95% CI for the Dep_Delay 
mean = mean(flights$dep_delay)
sd = sd(flights$dep_delay)
N = nrow(flights)
# standard error
se = sd/sqrt(N)

# Assuming 5% significance level
Tc = 1.96

me = Tc*se

## Upper and Lower Bound
Lower = mean - me
Lower

Upper = mean + me
Upper


### 4- 
