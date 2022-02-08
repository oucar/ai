### Quiz
quizData = read.csv("house_price.csv")
quizData

mean(quizData$price[quizData$bathrooms==3])

quizData = quizData %>% mutate(perSQ = price/sqft)
thatHouse = quizData %>% filter(perSQ == max(perSQ))
thatHouse


mean = mean(quizData$price)
mean
sd = sd(quizData$price)
N = nrow(quizData)
# standard error
se = sd/sqrt(N)

# Assuming 5% significance level
Tc = 1.96

me = Tc*se

## Upper and Lower Bound
Lower = mean - me
Upper = mean + me
Lower
Upper

quiz_model = glm(price ~ sqft + bedrooms + bathrooms,
                 data = quizData, family = "gaussian")
quiz_model

quiz_prediction = predict(quiz_model, data.frame(sqft = 2000, bedrooms = 4, bathrooms = 3))
quiz_prediction


## Function question
## 1/(1^2) + 1/(2^2)
myFunc <- function(n){
  total = 0
  for(i in 1:n){
    total = total + (1/(i^2))
  }
  return(total)
}
myFunc(1)
myFunc(2)


### mpg question
library(tidyverse)
library(ggplot2)
mpg

mpg_quiz_data <- mpg %>% filter(manufacturer == "ford") 
mpg_quiz_data

mpg_quiz_data_grouped <- mpg_quiz_data %>% group_by(model) %>% summarise(mean_cty = mean(cty), cyl)
mpg_quiz_data_grouped
ggplot(data = mpg_quiz_data_grouped, aes(x = cyl, y = mean_cty, color=model)) +
  geom_point()