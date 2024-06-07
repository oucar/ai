library(tidyverse)
library(nycflights13)

# can do this in one line with apply or map_chr
planes$manufacturer2=""
for(i in 1:nrow(planes)){
  planes$manufacturer2[i]=unlist(strsplit(planes$manufacturer[i]," ")[[1]][1])
}

# 1 write a function
name_split<-function(st){
  return(strsplit(st," ")[[1]][1])
}

# 2 use map_chr to get name from  planes$manufacuturer
planes$manufacturer2=map_chr(planes$manufacturer,name_split)


flights %>% left_join(planes,by="tailnum") %>%
        group_by(manufacturer2) %>% summarise(total_distance=sum(distance)) %>%
        arrange(desc(total_distance))

sum_square<-function(x){
  sq_sum=0
  for(i in 1:length(x)){
    sq_sum=sq_sum+x[i]*x[i]
  }
  return(sq_sum)
}

library(Rcpp)

cppFunction("int add(int x, int y, int z){int sum = x + y + z;return sum;}")

flight_new=flights %>% mutate(lag_delay=lag(dep_delay))



cppFunction("double sumC(NumericVector x) {
  int n = x.size();
  double total = 0;
  for(int i = 0; i < n; ++i) {
    total += x[i]*x[i];
  }
  return total;
}")
