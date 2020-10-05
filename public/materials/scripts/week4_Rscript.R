rm(list=ls())
library(classdata)
data("terr_attacks")

terr_attacks$dem<-"Autocracy"
terr_attacks$dem[terr_attacks$polity2>7]<-"Democracy"

#install.packages("tidyverse")
library(tidyverse)
library(magrittr)

attks1<-terr_attacks %>% group_by(country) %>% 
  summarise(tot_attks=sum(num_attacks), 
            mean_attks=mean(num_attacks), .groups="keep")

attks2<-terr_attacks %>% group_by(year) %>% 
  summarise(tot_attks=sum(num_attacks), 
            mean_attks=mean(num_attacks), .groups="keep")

attks3<-terr_attacks %>% group_by(dem) %>% 
  summarise(tot_attks=sum(num_attacks), 
            mean_attks=mean(num_attacks),numobs=n(), .groups="keep")

ggplot(data=attks3, aes(x=dem,y=mean_attks, fill=dem))+
  geom_bar(stat="identity")+ylab("Ave Num Attks")+
  xlab("Regime")+coord_flip()

d<-terr_attacks %>% group_by(country) %>% 
  summarise(tot_attks=median(GDPpc, na.rm=T), 
            mean_attks=mean(GDPpc, na.rm=T), .groups="keep")

attks4<-terr_attacks %>% group_by(dem,type) %>% 
  summarise(tot_attks=sum(num_attacks), 
            mean_attks=mean(num_attacks),numobs=n(), .groups="keep")

#Plot number attacks by regime type. Facet by the type of attack.
attks4$type<-recode(attks4$type,"Bombing/Explosion"="Explosion",
      "Facility/Infrastructure Attack"="Facility Attack")

ggplot(data=attks4, aes(x=dem,y=mean_attks,fill=dem))+
  geom_bar(stat="identity")+facet_wrap(~type, scale="free")+ylab("Ave Num Attks")+
  xlab("Regime")+coord_flip()+theme(legend.position="bottom")

