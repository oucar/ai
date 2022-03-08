library(tidytext)
library(tidyverse)
library(dplyr)
library(ggplot2)
library(textdata)

songs=read.csv("~/Dropbox/cs489/songdata.csv")
songs$text=as.character(songs$text)
songs$song=as.character(songs$song)
songs$artist=as.character(songs$artist)


#convert into tidy format data frame
songs=as.tibble(songs)
song_text <- songs %>% dplyr::select(lyrics = text, song, artist)

#need to analyze words...un-nest
song_words = songs %>%
  unnest_tokens(word, text)

#reduce dimension and keep informative words by removing stop words like the
data(stop_words)

song_words_no_stop <- song_words %>%
  anti_join(stop_words)

#now we can maybe start analyzing this data

# song frequency by artist in dataset
songs %>% 
  dplyr::count(artist,sort=T) %>% 
  print(n = 20)

# frequent words by Nirvana
song_words_no_stop %>% 
  filter(artist=="Nirvana") %>%
  dplyr::count(word,sort=T) %>% 
  print(n = 20)

# frequency of word by artist
frequency = song_words_no_stop %>% 
  filter(artist %in% c("Nirvana","Taylor Swift")) %>%
  dplyr::count(artist, word) %>%
  group_by(artist) %>%
  mutate(proportion = n / sum(n)) %>% 
  dplyr::select(-n) %>%
  spread(artist,proportion) 

# plot freq of nirvana words against swift
frequency[is.na(frequency)]=0
names(frequency)[3]="Swift"
ggplot(frequency,aes(x=Nirvana,y=Swift)) + 
  geom_abline()+
  geom_text(aes(label=word),check_overlap=T)+
  scale_x_log10() +
  scale_y_log10() 

# sentiments of words
song_words_sentiment <- song_words_no_stop %>%
  inner_join(get_sentiments("afinn")) 