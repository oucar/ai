library(tidyverse)


# plot hwy miles vs displacement colored by class
# aes allows you to change marker shape, size, color

ggplot(data=mpg)+geom_point(aes(x=displ,y=hwy,color=class))
ggplot(data=mpg)+geom_point(aes(x=displ,y=hwy,color=class))+
  theme_bw()# prob should remove gray background
ggplot(data=mpg)+geom_point(aes(x=displ,y=hwy,shape=class))
ggplot(data=mpg)+geom_point(aes(x=displ,y=hwy,size=year,
                                color=class))


# sometimes aesthetics for 3 or more variables (eg color, shape) on one plot looks
# cluttered.  Consider making separate plots with facets

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)

# there are different geoms (visual object to represent data) for differnt types
# of visualization

ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy,span=.001))


ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut))

# note that the above visualizations aren't simply plotting data, they are first 
# transforming the data.  Smoothing averages points locally in the plot to remove
# noise, where as the bar plot is counting the number of diamonds of each type

table(diamonds$cut) # could also do this


# position adjustments

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity)) # stacked bar plot isn't very good

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge") #this is better

# sometimes its useful to flip coordinates

ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot()

ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot() +
  coord_flip()
  
# ggplot and tidy are great for many types of data 

library(maps)
nz <- map_data("nz")

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black") +
  coord_quickmap()+
  theme_bw()

# real example, ggplot allows layering different elements and text
library(lubridate)
library(rio)

data = rio::import("https://hub.mph.in.gov/dataset/6b57a4f2-b754-4f79-a46b-cff93e37d851/resource/46b310b9-2f29-4a51-90dc-3886d9cf4ac1/download/covid_report.xlsx")

data$date=ymd(data$DATE) # lubridate is useful for working with dates 

data=data[data$COUNTY_NAME=="Marion",] #subsetting

data$week=week(data$date) # lubridate is useful 

agg_dat=aggregate(COVID_COUNT~AGEGRP+date,data=data,FUN=sum) #counting data by groups

ggplot(agg_dat[agg_dat$AGEGRP!="Unknown"&agg_dat$date<ymd("2020-12-01"),])+
  stat_smooth(aes(x=date,y=COVID_COUNT,color=AGEGRP),span=.1)+ 
  annotate(geom="text",label="Indy Bars/Nightclubs\n Open", x = as.Date("2020-06-10"), y = 120)+
  theme_bw()+ylab("New Daily Cases")+xlab("Date")+
  geom_vline(xintercept = as.Date("2020-06-19"),color="black",size=1,linetype="dashed")+
  annotate(geom="text",label="Indy Bars/Nightclubs\n Close", x = as.Date("2020-07-20"), y = 200)+
  geom_vline(xintercept = as.Date("2020-07-23"),color="black",size=1,linetype="dashed")

ggsave("ind_cov_age.pdf",p,width=7,height=3) # can save the plot

ggplot(agg_dat[agg_dat$AGEGRP!="Unknown",])+
  stat_smooth(aes(x=date,y=COVID_COUNT,color=AGEGRP),span=.1)+ 
  theme_bw()+ylab("New Daily Cases")+xlab("Date")


