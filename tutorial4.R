library(tidyverse)
library(dplyr)
library(ggplot2)
video_view <- read_csv("video_view.csv")
user_view <- read_csv("user_view.csv")
videos <- read_csv("videos.csv")
creators <- read_csv("creators.csv")
users <- read_csv("users.csv")
impressions <- read_csv("impressions.csv")
watch_events <- read_csv("watch_events.csv")
sessions <- read_csv("sessions.csv")

#Example code
video_simple <- video_view %>%
  mutate(
    watch_rate_rank = rank(-watch_rate),
    high_quality = avg_watch_share >= 0.40
  ) %>%
  distinct(video_id, .keep_all = TRUE)

#Extra's
video_ranked <- video_view %>%
  mutate(
    watch_rate_rank = rank(-watch_rate, na.last = "keep",
                           ties.method = "min"))
#New exercise: start from video_view
#2. create watch_rate_rank = rank(-watch_rate)
#3. create reach_band (Low, Medium, High from impressions_n)
#4. create high_quality (avg_watch_share >= 0.40)
#5. keep unique video_id rows with distinct()
#6. save output: write_csv(video_features, "temp/video_features.csv")
#Show top 10 rows sorted by watch_rate_rank

video_features <- video_view %>% 
  mutate(watch_rate_rank = rank(-watch_rate),
         reach_band = case_when(impressions_n < 40 ~ "Low",
                                impressions_n < 60 ~ "Medium",
                                TRUE ~ "High"),
         high_quality = avg_watch_share >= 0.40) %>% 
  distinct(video_id, .keep_all = TRUE)

#Example code aggregation
creator_example <- video_view %>%
  group_by(creator_id) %>%
  summarise(
    impressions_total = sum(impressions_n, na.rm = TRUE),
    avg_watch_rate = mean(watch_rate, na.rm = TRUE)
  ) %>%
  arrange(desc(impressions_total))

creator_summary <- video_view %>% 
  group_by(creator_id) %>% 
  summarise(
    videos_n = n(),
    impressions_total = sum(impressions_n),
    watched_total = sum(watched_n),
    avg_watch_rate = mean(watch_rate, na.rm = TRUE),
    median_watch_seconds = median(total_watch_seconds)) %>% 
  arrange(desc(impressions_total))

#Example trying to join datasets
video_with_creators <- video_view %>%
  left_join(creators, by = "creator_id")

watched_only <- impressions %>%
  inner_join(watch_events, by = "impression_id")

#Let's try ourselves
video_enriched <- video_features %>% 
  left_join(videos, by = c("video_id", "creator_id")) %>% 
  left_join(creators, by = "creator_id") %>% 
  select(video_id, creator_id, creator_name, 
         impressions_n, watch_rate, watch_rate_rank, 
         quality, posting_rate, publish_time)

#Example code date/time
watch_log <- impressions %>%
  left_join(watch_events, by = c("impression_id", "session_id", "user_id",
                                 "video_id", "creator_id")) %>% 
  left_join(sessions, by = c("session_id", "user_id"))

watch_log <- watch_log %>%
  left_join(videos, by = c("video_id", "creator_id")) %>%
  left_join(creators, by = "creator_id")
  

watched_only <- impressions %>%
  inner_join(watch_events, by = "impression_id")

watch_time_preview <- watch_log %>%
  mutate(
    shown_ts = as.POSIXct(shown_at,
                          format = "%Y-%m-%dT%H:%M:%SZ",
                          tz = "UTC"),
    shown_day = as.Date(shown_ts)
  ) %>%
  select(impression_id, creator_id, shown_at, shown_ts, shown_day) %>%
  head(8)

creator_daily <- watch_log %>%
  mutate(shown_ts = as.POSIXct(shown_at, format = "%Y-%m-%dT%H:%M:%SZ", tz = "UTC"),
         shown_day = as.Date(shown_ts)) %>% 
           count(creator_id, shown_day, name = "impressions_n") %>% 
           group_by(creator_id) %>% 
           arrange(shown_day) %>% 
           mutate(impressions_lag1 = lag(impressions_n),
                  impressions_change = impressions_n - impressions_lag1)


