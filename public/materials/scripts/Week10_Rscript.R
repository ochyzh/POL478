library(tidyverse)
library(magrittr)
library(rvest)

#Step 1
myurl<-"https://www.imdb.com/title/tt0068646/"

#Step 2
myhtml<-read_html(myurl)

#Step 4
mycast<-html_nodes(myhtml, "table") %>% html_table()

#Step 5
mydat<-mycast %>% extract2(1)

mydat<-mydat[-1,c(2,4)]

names(mydat)<-c("Actor","Role")

library(stringr)

mydat<- mydat %>% mutate(Role=str_squish(Role))



#Your Turn
#Step 1
mydat<-read_html("https://www.imdb.com/title/tt0032138/") %>%
html_nodes("table") %>%
  html_table() %>%
  extract2(1)
mydat<-mydat[-1,c(2,4)]
names(mydat)<-c("Actor","Role")
mydat<- mydat %>% mutate(Role=str_squish(Role))

#CN Tower

myurl<-"https://www.tripadvisor.ca/Attraction_Review-g155019-d155483-Reviews-CN_Tower-Toronto_Ontario.html"

read_html(myurl) %>%
  html_nodes(".cPQsENeY") %>%
  html_text()

#Election returns:
myurl<-"https://electionresults.utah.gov/elections/countyCount/399789495"
mytable<-read_html(myurl) %>%
  html_nodes("table") %>%
  html_table(header=T) %>%
  extract2(1)

mytable<-mytable[-c(1,2),c(1,4,9)]
names(mytable)<-c("county","trump","biden")


myurls<-c("https://electionresults.utah.gov/elections/countyCount/399792400",
          "https://electionresults.utah.gov/elections/countyCount/399794673",
          "https://electionresults.utah.gov/elections/countyCount/399794677",
          "https://electionresults.utah.gov/elections/countyCount/399794680")

#first dist
mydat<-read_html(myurls[1]) %>%
  html_nodes("table") %>%
  html_table(header=T) %>%
  extract2(1)

names(mydat)<-mydat[1,]

mydat<-mydat %>% slice(-c(1,2)) %>%
  select(County, "Rep"=contains("REP", ignore.case = F),
          "Dem"=contains("DEM", ignore.case = F))



mydata<-NULL
for (i in myurls) {
  d<-read_html(i) %>%
    html_nodes("table") %>%
    html_table(header=T) %>%
    extract2(1)

  names(d)<-d[1,]

  d<-d %>% slice(-c(1,2)) %>% slice(-c(1,2)) %>%
    select(County, "Rep"=contains("REP", ignore.case = F),
           "Dem"=contains("DEM", ignore.case = F))
mydata<-rbind.data.frame(mydata,d)
  }


