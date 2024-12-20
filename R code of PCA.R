library(worldfootballR)
library(dplyr)
library(ggplot2)
library(tidyr)
library(lubridate)
library(ggthemes)
library(skimr)
library(dplyr) 
library(tidyr)


big5_player_shooting <- fb_big5_advanced_season_stats(season_end_year= c(2019:2024), stat_type= "shooting", team_or_player= "player")
big5_player_shooting <- big5_player_shooting %>% filter(Pos != "MF,DF" & Pos != "DF,MF" & Pos != "DF,FW")
big5_player_shooting <- big5_player_shooting %>% filter(Age <= 25)
big5_player_shooting <- big5_player_shooting %>% filter(Gls_Standard != 0)
big5_player_shooting <- big5_player_shooting %>% filter(Pos != "GK" & Pos != "DF" & Pos != "MF")

dplyr::glimpse(big5_player_shooting)
skim(big5_player_shooting)
head(big5_player_shooting)


attach(big5_player_shooting)

big5_player_shooting_topfive<-data.frame(Mins_Per_90, Sh_per_90_Standard, SoT_per_90_Standard, npxG_Expected, FK_Standard)

head(big5_player_shooting_topfive)
any(is.na(big5_player_shooting_topfive))

attach(big5_player_shooting_topfive)
library(factoextra)
library(FactoMineR)

pca <- prcomp(big5_player_shooting_topfive, center = T, scale.unit = T)
summary(pca)
fviz_pca_var(pca)

resvar <- get_pca_var(pca)

fviz_contrib(pca, choice = "var", axes = 1)
fviz_contrib(pca, choice = "var", axes = 1:2)

fviz_pca_var(pca, col.var = "contrib")
