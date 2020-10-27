canada_le<-read.table("canada_le_long.txt", header=T)

myurl<-"https://raw.githubusercontent.com/ochyzh/POLS478/master/public/materials/canada_le_long.txt"
canada_le<-read.table(myurl, header=T)

canada_le.wide<-canada_le %>% pivot_wider(names_from=year, values_from=life_exp)
canada_le %>% spread(key=year, value=life_exp)

canada_le.wide %>%
  pivot_longer(cols=2:6,names_to="year",values_to="life_exp")

canada_le.wide %>%
  gather(key="year", value="life_exp",-province)

data("terr_attacks")
data("terr_attacks.wide")
terr_attacks %>%
  pivot_wider(names_from=type, values_from=num_attacks) %>%
  select(country, year, `Armed Assault`,Assassination, everything())
terr_attacks.wide %>%
  pivot_longer(cols=`Armed Assault`:`Hostage Taking (Barricade Incident)`,names_to="type",values_to="num_attacks")

d<-terr_attacks %>% select(country, year, type, num_attacks) %>% pivot_wider(names_from=year, values_from=num_attacks) %>%
  select(country, `2001`,`2002`, everything())

d1<-terr_attacks %>%
  pivot_wider(names_from=year, values_from=c(num_attacks,population, GDPpc,
                                             tradeofgdp,polity2))
