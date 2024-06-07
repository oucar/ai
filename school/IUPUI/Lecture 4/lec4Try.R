library(tidyverse)
library(nycflights13)

# can do this in one line with apply or map_chr
planes$manufacturer2=""
for(i in 1:nrow(planes)){
  planes$manufacturer2[i]=unlist(strsplit(planes$manufacturer[i]," ")[[1]][1])
}


############ 1 ##############
### WRITE A FUNCTION THAT TAKES A STRING
### AND SPLITS AT THE SPACES AND RETURNS THE
### FIRST SUBSTRING (e.g. “Airbus Industry” -> “Airbus”)

name_split <- function(st){
  st <- str_split(st, " ")[[1]][1]
  return(st)
}
name_split("Merhaba Onur")
name_split("Airbus Industry")
name_split("I think this is an edge case but idk.")


############ 2 ##############
### use map_chr to apply “name_split” to the manufacturer column
### of the planes data frame
### MAP: Apply a function to each element of a vector
planes$manufacturer2 = map_chr(planes$manufacturer,name_split)


sum_square<-function(x){
  sq_sum = 0
  for(i in 1:length(x)){
    sq_sum = sq_sum + x[i] * x[i]
  }
  return(sq_sum)
}

# 1 + 4 + 9
sum_square(c(1:3))
# 1 + 4 + 9 + ...
sum_square(c(1:15))
# 1 + 4
sum_square(c(1:2))
