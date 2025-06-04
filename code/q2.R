#Q2 -- Find the airport that has the longest average flight duration (in hours) from NYC. What is the name of this airport?

q2 <- flights %>%
  #join "airlines" to get 'airline_name'
  left_join(airlines, by="carrier") %>%
  #join "airports" to get 'airport_name'
  left_join(airports, by=c("dest"="faa")) %>%
  #convert 'air_time' from minutes to hours
  mutate(air_time_hr = air_time/60) %>%
  #condense data to variables of interest
  select(carrier, airline_name=name.x, dest, airport_name=name.y, air_time_hr) %>%
  group_by(airline_name, airport_name) %>%
  #get avg 'air_time' per airline-airport pair
  summarize(avg_dur_hr = mean(air_time_hr)) %>%
  #ungroup the data
  ungroup() %>%
  #get the row with the largest avg_dur_hr
  slice_max(avg_dur_hr, n=1)

longest <- q2
longest
#OUTPUT (tibble):
  #'airline_name': Delta Air Lines inc.
  #'airport_name': Daniel K Inouye International Airport
  #'avg_dur_hr': 10.7167