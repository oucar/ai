library(readr)
library(lubridate)
library(dplyr)
library(tidyverse)
library(usethis) 
usethis::edit_r_environ()



train <- read_csv("train.csv")
test <- read_csv("test.csv")

# remove na
train <-  na.omit(train)

# Removing 0:00 (removing the last 5 characters, including the space)
train$BEGDATE <- substr(train$BEGDATE,1,nchar(train$BEGDATE)-5)

# turn character into date (mdy)
train$BEGDATE <- mdy(train$BEGDATE)

# add year, month and day from the date to the table
train <- train %>% mutate(BEGDATE_YEAR = as.numeric(format(train$BEGDATE, format="%Y")))
train <- train %>% mutate(BEGDATE_MONTH = as.numeric(month(train$BEGDATE)))
train <- train %>% mutate(BEGDATE_DAY = as.numeric(day(train$BEGDATE)))

# use  tibble for NARRATIVE
train
str(train)

##### GLM MODEL ##### 

## YOU HAVE TO USE 0 AND 1 FOR CRIMETYPE
glm_model=glm(CRIMETYPE ~ BEGDATE_MONTH, data=train)



# test$prediction=predict(glm_model, test)
# test$category=“BURG”
# If prediction is 1, set to BTFV
# write.csv(test[,c(“id”,”category”)],”filename.csv”)
# set.seed(123)