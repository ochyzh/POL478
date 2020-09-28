rm(list=ls())
library(classdata)
data("terr_attacks.wide")

install.packages("ggplot2")
library(ggplot2)

ggplot(data=terr_attacks.wide,
       aes(x=log10(`Armed Assault`+1),y=log10(`Bombing/Explosion`+1)))+
       geom_point()

ggplot(data=terr_attacks.wide, aes(x=`Armed Assault`+1,y=`Bombing/Explosion`+1))+
  geom_point()+scale_x_log10("Armed Assaults", breaks=c(1,11,101),labels=c("0","10","100"))+
  scale_y_log10("Bombings", breaks=c(1,11,101),labels=c("0","10","100"))

terr_attacks.wide$dem<-"Autocracy"
terr_attacks.wide$dem[terr_attacks.wide$polity2>7]<-"Democracy"

#Create a vector rather than a variable
dem<-rep("Autocracy",length=nrow(terr_attacks.wide))
dem[terr_attacks.wide$polity2>7]<-"Democracy"

ggplot(data=terr_attacks.wide, 
       aes(x=`Armed Assault`+1,y=`Bombing/Explosion`+1,colour=dem))+
  geom_point()+scale_x_log10("Armed Assaults", breaks=c(1,11,101),labels=c("0","10","100"))+
  scale_y_log10("Bombings", breaks=c(1,11,101,1001),labels=c("0","10","100","1000"))+
  scale_colour_discrete(name="Regime Type")

ggplot(data=terr_attacks.wide, 
       aes(x=`Armed Assault`+1,y=`Bombing/Explosion`+1,colour=dem))+
  geom_point()+scale_x_log10("Armed Assaults", breaks=c(1,11,101),labels=c("0","10","100"))+
  scale_y_log10("Bombings", breaks=c(1,11,101,1001),labels=c("0","10","100","1000"))+
  scale_colour_grey(name="Regime Type")

#Shape
ggplot(data=terr_attacks.wide, 
       aes(x=`Armed Assault`+1,y=`Bombing/Explosion`+1,shape=dem))+
  geom_point()+scale_x_log10("Armed Assaults", breaks=c(1,11,101),labels=c("0","10","100"))+
  scale_y_log10("Bombings", breaks=c(1,11,101,1001),labels=c("0","10","100","1000"))+
  scale_shape_manual(name="Regime Type", values=c(1,3))

cbPalette<-c("#999999", "#E69F00")
ggplot(data=terr_attacks.wide, 
       aes(x=`Armed Assault`+1,y=`Bombing/Explosion`+1,colour=dem))+
  geom_point()+scale_x_log10("Armed Assaults", breaks=c(1,11,101),labels=c("0","10","100"))+
  scale_y_log10("Bombings", breaks=c(1,11,101,1001),labels=c("0","10","100","1000"))+
  scale_colour_manual(name="Regime Type",values=cbPalette)+
  theme_bw()

theme_set(theme_grey()+
            theme(panel.background = element_rect(fill=NA, 
            color="black"))+
            theme(axis.text=element_text(size=10), 
                  axis.title=element_text(size=12, face="bold")))
  
ggplot(data=terr_attacks.wide, 
       aes(x=`Armed Assault`+1,y=`Bombing/Explosion`+1,colour=dem))+
  geom_point()+scale_x_log10("Armed Assaults", breaks=c(1,11,101),labels=c("0","10","100"))+
  scale_y_log10("Bombings", breaks=c(1,11,101,1001),labels=c("0","10","100","1000"))+
  scale_colour_manual(name="Regime Type",values=cbPalette)

ggplot(data=terr_attacks.wide, 
       aes(x=`Armed Assault`+1,y=`Bombing/Explosion`+1,colour=dem, size=GDPpc))+
  geom_point()+scale_x_log10("Armed Assaults", breaks=c(1,11,101),labels=c("0","10","100"))+
  scale_y_log10("Bombings", breaks=c(1,11,101,1001),labels=c("0","10","100","1000"))+
  scale_colour_manual(name="Regime Type",values=cbPalette)

terr_attacks.wide$region<-NA
terr_attacks.wide$region[terr_attacks.wide$ccode<200]<-"The Americas"
terr_attacks.wide$region[terr_attacks.wide$ccode>=200 &
                           terr_attacks.wide$ccode<401 ]<-"Europe"
terr_attacks.wide$region[terr_attacks.wide$ccode>=401 &
                           terr_attacks.wide$ccode<599 ]<-"Africa"
terr_attacks.wide$region[terr_attacks.wide$ccode>=600 &
                           terr_attacks.wide$ccode<699 ]<-"Middle East"
terr_attacks.wide$region[terr_attacks.wide$ccode>=700 &
                           terr_attacks.wide$ccode<899 ]<-"Asia"
terr_attacks.wide$region[terr_attacks.wide$ccode>=900]<-"Australia and Oceania"

table(terr_attacks.wide$region)

ggplot(data=terr_attacks.wide, 
       aes(x=`Armed Assault`+1,y=`Bombing/Explosion`+1,colour=dem, size=GDPpc))+
  geom_point()+
  facet_wrap(~region)+
  scale_x_log10("Armed Assaults", breaks=c(1,11,101),labels=c("0","10","100"))+
  scale_y_log10("Bombings", breaks=c(1,11,101,1001),labels=c("0","10","100","1000"))+
  scale_colour_manual(name="Regime Type",values=cbPalette)


ggplot(data=terr_attacks.wide, 
       aes(x=`Armed Assault`+1,y=`Bombing/Explosion`+1,colour=dem, size=GDPpc))+
  geom_point()+
  facet_grid(dem~region)+
  scale_x_log10("Armed Assaults", breaks=c(1,11,101),labels=c("0","10","100"))+
  scale_y_log10("Bombings", breaks=c(1,11,101,1001),labels=c("0","10","100","1000"))+
  scale_colour_manual(name="Regime Type",values=cbPalette)


data("terr_attacks")
summary(terr_attacks[c("num_attacks","polity2")])
