library(tidyverse)
library(magrittr)

library(devtools)
install_github("ochyzh/classdata")
library(classdata)

data("covid_daily")
str(covid_daily)

library(lubridate)
x<-"16-11-2020"
x
class(x)

x1<-dmy(x)
class(x1)

y<-"I had dinner at 7:00 pm"
y1<-hm(y)
class(y1)

class(covid_daily$date)
covid_daily$date1<-ymd(covid_daily$date)
class(covid_daily$date1)

summary(covid_daily$date)
summary(covid_daily$date1)

covid_daily$month<-month(covid_daily$date1, label=T)

now()
yday(now())
wday(now(), label=T)


mdy("10-16-2020")-mdy("10-02-2020")
mdy("10-16-2020")+weeks(1)

data("covid_daily")
covid_daily$date1<-ymd(covid_daily$date)

covid_daily %>%
  mutate(month=month(date1, label=T)) %>%
  group_by(month) %>%
  summarise(sum_cases=sum(new_confirmed, na.rm=T), .groups="keep") %>%
  ggplot(aes(x=month,y=sum_cases)) + geom_bar(stat="identity")+theme_bw()

covid_daily %>%
  ggplot(aes(x=month(date1, label=T), weight=new_confirmed))+
  geom_bar()


library(zoo)
covid_daily %>% group_by(date1) %>%
  summarise(sum_cases=sum(new_confirmed, na.rm=T), .groups="keep")%>%
  ungroup() %>%
  arrange(date1) %>%
  mutate(mean_cases7=zoo::rollmean(sum_cases,k=7,fill=NA)/1000) %>%
  ggplot(aes(x=date1,y=mean_cases7))+geom_line()+theme_bw()+scale_x_date("")
