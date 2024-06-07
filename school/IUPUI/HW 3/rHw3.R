library(nycflights13)
library(tidyr)
library(tidyverse)


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
mean
sd = sd(flights$dep_delay)
N = nrow(flights)
# standard error
se = sd/sqrt(N)

# Assuming 5% significance level
Tc = 1.96

me = Tc*se

## Upper and Lower Bound
Lower = mean - me
Upper = mean + me

View(flights)

### 4- 
# https://www.youtube.com/watch?v=xE3KGVT6VLE
nrow(flights)
fl_bs=numeric(10000)
Nr=nrow(flights)

for(i in 1:1000){
  flights_copy = flights[sample(Nr, Nr, replace=T),]
  fl_bs[i]=mean(flights_copy$dep_delay)
}

quantile(fl_bs,.95)

fl_bs
View(fl_bs)


### 5
data = read.csv("Beerwings.csv")
gender = data$Gender
hw = data$Hotwings
beer = data$Beer

head(data)
linearMod <- lm(beer ~ hw + gender, data)
print(linearMod)
summary(linearMod)


### 6
nrow(data)
bw_bs_max = numeric(100)
bw_bs_min = numeric(100)
bw_bs = numeric(100)
Nr=nrow(data)

?sample
bw_copy %>% filter(Gender == "M")
bw_copy = data[sample(Nr, Nr, replace = T), ]
View(bw_copy)

# max
for(i in 1:100){
  bw_copy = data[sample(Nr, Nr, replace = T), ]
  if(!bw_copy$Gender == "M" & !bw_copy$Hotwings == 12 ){
    bw_bs_max[i] = NA
  } else {
    bw_bs_max[i] = bw_copy$Beer
  }
}

View(bw_bs_max)

# min
for(i in 1:100){
  bw_copy = data[sample(Nr, Nr, replace=T),]
  if(!bw_copy$Gender == "M" & !bw_copy$Hotwings == 12 ){
    bw_bs_min[i] = NA
  } else {
    bw_bs_min[i] = bw_copy$Beer
  }
}
View(bw_bs_min) 
bw_bs_min
