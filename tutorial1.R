library(tidyverse)
library(dplyr)
videos <- read.csv("video_view.csv")

#what are total impressions and average watch rate per creator?
creator_stats <- videos %>% group_by(creator_id) %>% 
  summarize(
  impressions_total = sum(impressions_n, na.rm = TRUE),
  avg_watchrate = mean(watch_rate, na.rm = TRUE))
  
creator_stats %>% arrange(desc(impressions_total))
creator_stats %>% arrange(desc(avg_watchrate))

#Count videos with watch_rate >= 0.8
videos %>% count(watch_rate >= 0.8)
videos %>% filter(watch_rate >= 0.8) %>% nrow()

#Show only video_id, creator_id, watch_rate
videos %>% select(video_id, creator_id, watch_rate)

#needed to change something

