library(tidyverse)
library(dplyr)
library(ggplot2)
videos <- read.csv("video_view.csv")

#Basic plot
basic <- ggplot(data = videos, 
                aes(x = impressions_n,
                    y = watch_rate)) +
  geom_point()
basic

#let's make it nicer :)
nicer1 <- ggplot(data = videos, 
                aes(x = impressions_n,
                    y = watch_rate)) + 
  labs(title = "First graph on my own",
                x = "Number of Impressions",
                y = "Watch Rate") +
  geom_point(color = "slateblue")
nicer1

nicer2 <- ggplot(data = videos, 
                           aes(x = impressions_n,
                               y = watch_rate,
                               color = 'Creator')) + 
  labs(title = "First graph on my own",
       x = "Number of Impressions",
       y = "Watch Rate") +
  geom_point(color = "slateblue")
  nicer2

# Some extra plots to see what happens
 videos_plot <- videos %>%
    mutate(
      visibility_band = case_when(
        impressions_n < 20 ~ "Low visibility",
        impressions_n < 60 ~ "Medium visibility",
        TRUE ~ "High visibility"))
 ggplot(videos_plot, aes(impressions_n, watch_rate, color = visibility_band)) +
   geom_point(alpha = 0.7, size = 2) +
   labs(
     title = "Video quality vs reach",
     x = "Impressions",
     y = "Watch rate",
     color = "Visibility"
   ) +
   theme_minimal()
  videos_plot
  
#extra exercises
#Create a histogram of watch_rate
watch_rate_histogram <- ggplot(videos, aes(watch_rate))+
  labs(title = "Histogram of Watch Rate") +
  geom_histogram(bins = 20, colour = "lavender", fill = "lavender")+
  theme_minimal()

watch_rate_histogram  
  
  
  
  
  
  