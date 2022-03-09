library(tidyverse)
crime=read_csv("mvt.csv")

# scatter plot over google map
library(ggmap)

# note you need a google api key for this
indymap <- get_map("Indianapolis, IN", zoom = 11, color = "bw")

ggmap(indymap)+
  geom_point(data=crime,aes(x=Longitude,y=Latitude),
             color="blue",alpha=.3)


# kernel density heat map
p=ggmap(indymap)+stat_density2d(data=crime,
                aes(x = Longitude, y = Latitude, 
                    fill = ..level..,alpha=..level..),
               bins = 20,h=.025,
               geom = "polygon")+
  scale_fill_gradientn(colours=c("yellow","orange","red"))+
  guides(fill="none",alpha="none")

ggsave("heatmap.pdf",p,width=6,height=6)

# how can we see how "robust" this map is to noise?
crime_sample=crime[sample(nrow(crime),
                          nrow(crime),T),]

p=ggmap(indymap)+stat_density2d(data=crime_sample,
                                aes(x = Longitude, y = Latitude, 
                                    fill = ..level..,alpha=..level..),
                                bins = 20,h=.025,
                                geom = "polygon")+
  scale_fill_gradientn(colours=c("yellow","orange","red"))+
  guides(fill="none",alpha="none")

ggsave("heatmap_sample.pdf",p,width=6,height=6)


# K function 
# decides if the data is random
library(spatstat)
Xcoord=as.ppp(as.matrix(crime[,c("Longitude","Latitude")]),
              c(min(crime$Longitude),max(crime$Longitude),
                min(crime$Latitude),max(crime$Latitude)))
# 100 times
Kfun <- envelope(Xcoord, fun= Kest, nsim= 100, verbose=F)
plot(Kfun)



# get census data on owners with 1 vehicle, population
library(tidycensus)

acs_indy <- get_acs(geography = "block group",
                  variables = c("B25044_004","B02001_001"),
                  state = "IN",
                  county="Marion",
                  geometry = TRUE,
                  output = "wide",year=2019,
                  survey = "acs5")

# 1` vehicle`
acs_indy %>% ggplot(aes(fill = B25044_004E)) +
  geom_sf(color = "gray",size=.1) +
  scale_fill_gradient(low = "white", high = "red")+theme_void()

# population
acs_indy %>% ggplot(aes(fill = B02001_001E)) +
  geom_sf(color = "gray",size=.1) +
  scale_fill_gradient(low = "white", high = "red")+theme_void()

# join with crime data

DT_sf = st_as_sf(crime, 
                 coords = c("Longitude", "Latitude"),
                 crs=st_crs(acs_indy))

acs_crime_join <- DT_sf %>% st_join(acs_indy)

indy_mvt_sum=acs_crime_join %>% group_by(GEOID) %>% summarise(mvt=n()) 

acs_indy %>% st_join(indy_mvt_sum,by="GEOID") %>% ggplot(aes(fill = mvt)) +
  geom_sf(color = "gray",size=.1) +
  scale_fill_gradient(low = "white", high = "red")+theme_void()

