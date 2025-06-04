#Q3 -- Which airport is the least frequented destination for flights departing from JFK?

q3 <- flights %>%
  #filter for flights from JFK
  filter(origin=="JFK") %>%
  #group by the destination (airport)
  group_by(dest) %>%
  #count # flights
  summarize(n_flights = n()) %>%
  #ungroup the data
  ungroup() %>%
  #join "airports" to get the 'airport_name'
  inner_join(airports, by=c("dest"="faa")) %>%
  #select variables of interest
  select(dest:n_flights, airport_name=name) %>%
  #get the row with the fewest # flights
  slice_min(n_flights, n=1)

least <- q3$airport_name
least
  #is a character string -- GOOD
#OUTPUT (tibble):
  #"Eagle County Regional Airport"