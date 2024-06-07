library(tidyverse)
library(tidytext)
library(tidyr)

data = read.csv("imdb.csv")

data$Description = as.character(data$Description)

data = as.tibble(data)
data_text <- data %>% dplyr::select(lyrics = Description)

data_words = data %>% unnest_tokens(word, Description)

data(stop_words)

data_words_no_stop <- data_words %>% anti_join(stop_words)
data_words_no_stop

# Most occuring word
sort(table(data_words_no_stop$word),decreasing=TRUE)[1:3]

data <- data %>% drop_na(Revenue..Millions.)

# GLM
dwayne = grepl("Dwayne Johnson", data$Actors)
action = grepl("Action", data$Genre)
comedy = grepl("Comedy", data$Genre)
dwayne <- as.integer(dwayne)
action <- as.integer(action)
comedy <- as.integer(comedy)

glm_model = glm(Revenue..Millions. ~ Runtime..Minutes. + Rating + Votes + dwayne + action + comedy,
                  data = data, family = "gaussian")
coef(summary(glm_model))

# Moana with Dwayne Johnson
glm_prediction = predict(glm_model, data.frame(Runtime..Minutes. = 107, Rating = 7.7, Votes = 118151, dwayne = 1, action = 0, comedy = 1))
# 106.3897
glm_prediction

# Moana without Dwayne Johnson
glm_prediction_without_dwayne = predict(glm_model, data.frame(Runtime..Minutes. = 107, Rating = 7.7, Votes = 118151, dwayne = 0, action = 0, comedy = 1))
# 43.03029
glm_prediction_without_dwayne
