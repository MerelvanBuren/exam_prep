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

# Alright but let's actually start some stuff
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
    