#load in libraries
library(tidyverse)
library(dplyr)
library(readr)
library(ggplot2)
library(stringr)

#import the data
flights <- read_csv("flights2022-h2.csv")
airlines <- read_csv("airlines.csv")
airports <- read_csv("airports.csv")

#Q1 -- Which airline and airport pair receives the most flights from NYC and what is the average duration of that flight?

q1 <- flights %>%
  #join "airlines" to get the 'airline_name'
  left_join(airlines, by="carrier") %>%
  #join "airports" to get the 'airport_name'
  left_join(airports, by=c("dest"="faa")) %>%
  #select columns of interest
  select(carrier, airline_name=name.x, dest, airport_name=name.y, air_time) %>%
  group_by(airline_name, airport_name) %>%
  #calculate # flights & avg 'air_time' per airline-airport pair
  summarize(n_flights = n(), avg_dur = mean(air_time, na.rm=TRUE)) %>%
  #ungroup the data
  ungroup() %>%
  #condense for the largest 'n_flights' value
  slice_max(n_flights, n =1)

frequent <- q1
frequent
#OUTPUT (tibble):
  #'airline_name': Delta Air Lines inc.
  #'airport_name': Hartsfield Jackson Atlanta International Airport
  #'n_flights': 5,264
  #'avg_dur': 109.2121