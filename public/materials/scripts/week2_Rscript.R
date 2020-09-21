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
