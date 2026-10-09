library(tidyverse)
url <- paste0(
  "https://raw.githubusercontent.com/hannesdatta/course-dprep/",
  "refs/heads/main/material/tutorials/r-bootcamp-rev/video_view.csv"
)
if (!file.exists("/../video_view.csv")) download.file(url, "/../video_view.csv")
videos <- read_csv("video_view.csv")
ggplot(videos, aes(impressions_n, watch_rate)) +
  geom_point(color = "steelblue", alpha = 0.7)
ggsave("mkdir/plot_week3.png", width = 7, height = 4) 
