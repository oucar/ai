library(tidyverse)
library(tidytext)

# word2vec example
# decides whether the given pair would work together or not
# cat sits -> positive sample
# cat flies -> negative sample

songs=read.csv("~/Dropbox/cs489/songdata.csv")
songs$text=as.character(songs$text)
songs$song=as.character(songs$song)
songs$artist=as.character(songs$artist)


#convert into tidy format data frame
songs=as.tibble(songs)
song_text <- songs %>% dplyr::select(lyrics = text, song, artist)

# create word2vec model
library(word2vec)
set.seed(1)
model <- word2vec(x = song_text$lyrics, type = "cbow", dim = 15, iter = 20)

wvlove <- predict(model, newdata = c("love"), type = "embedding")


predict(model, newdata = wvlove, type = "nearest", top_n = 10)


# part of speech tagging
library(spacyr)
#spacy_download_langmodel("en_core_web_md")
spacy_initialize("en_core_web_md") # or spacy_initialize("en_core_web_ld") 
txt <- "Robert threw the ball to his dog."
out <- spacy_parse(txt)

#nltk, liwc, gensim also good nlp libraries


