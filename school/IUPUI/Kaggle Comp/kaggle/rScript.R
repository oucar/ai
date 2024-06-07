library(readr)
library(lubridate)
library(dplyr)
library(tidyverse)
library(tidytext)

train <- read_csv("train.csv")
test <- read_csv("test.csv")

# remove na
train <-  na.omit(train)

# Removing 0:00 (removing the last 5 characters, including the space)
train$BEGDATE <- substr(train$BEGDATE,1,nchar(train$BEGDATE)-5)
test$BEGDATE <- substr(test$BEGDATE,1,nchar(test$BEGDATE)-5)

# turn character into date (mdy)
train$BEGDATE <- mdy(train$BEGDATE)
test$BEGDATE <- mdy(test$BEGDATE)


# add year, month and day from the date to the table
train <- train %>% mutate(BEGDATE_YEAR = as.numeric(format(train$BEGDATE, format="%Y")))
train <- train %>% mutate(BEGDATE_MONTH = as.numeric(month(train$BEGDATE)))
train <- train %>% mutate(BEGDATE_DAY = as.numeric(day(train$BEGDATE)))

test <- test %>% mutate(BEGDATE_YEAR = as.numeric(format(test$BEGDATE, format="%Y")))
test <- test %>% mutate(BEGDATE_MONTH = as.numeric(month(test$BEGDATE)))
test <- test %>% mutate(BEGDATE_DAY = as.numeric(day(test$BEGDATE)))

# use  tibble for NARRATIVE
library(word2vec)
library(textdata)
set.seed(31)
train = as.tibble(train)

words = train %>% unnest_tokens(word, NARRATIVE)
words_no_stop <- words %>% anti_join(stop_words)

model_text <- word2vec(x = train$NARRATIVE, type = "cbow", dim = 15, iter = 20)
model_burg <- predict(model_text, newdata = c("BURG"), type = "embedding")
burg_related <- predict(model_text, newdata = model_burg, type = "nearest", top_n = 100)
View(burg_related$BURG)

burg_related$BURG
train$NARRATIVE[which(train$NARRATIVE %in% burg_related$BURG$term)]
train

## deneme
train <- train %>% unnest_tokens(word, NARRATIVE)
train <- train %>% anti_join(stop_words)

train$word[which(train$word %in% burg_related$BURG$term)]
View(train)
# location

##### GLM MODEL ##### 

## YOU HAVE TO USE 0 AND 1 FOR CRIMETYPE
train$CRIMETYPE[train$CRIMETYPE == "BTFV"] <- 1
train$CRIMETYPE[train$CRIMETYPE == "BURG"] <- 0
train$CRIMETYPE <- as.numeric(train$CRIMETYPE)

View(train)

glm_model=glm(CRIMETYPE ~ BEGDATE_MONTH + BEGDATE_YEAR + BEGDATE_DAY, data=train)
summary(glm_model)

predict <- predict(glm_model, newdata = test, type='response')
summary(predict)
predict <- ifelse(predict > 0.567, "BTFV", "BURG")

test$CRIMETYPE <- predict
View(test)

write.csv(test[,c("id","CRIMETYPE")],
          "Sth.csv")
