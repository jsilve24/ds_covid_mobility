library(tidyverse)
library(COVID19)

set.seed(590184)


# load data ---------------------------------------------------------------

dat <- covid19(country="United States", level=2) 

# Lets exclude a few locals that have less reliable data / sparse data that 
# will only complicate our analysis.
dat <- dat %>% 
  filter(!(administrative_area_level_2 %in% c("Northern Mariana Islands", 
                                              "Guam", 
                                              "Puerto Rico", 
                                              "Virgin Islands", 
                                              "American Samoa")))

# make a new variable called new_confirmed and new_deaths
dat <- dat %>% 
  mutate(new_confirmed = confirmed - lag(confirmed), 
         new_deaths = deaths - lag(deaths))

# analysis ----------------------------------------------------------------

# example plot
dat %>% 
  ggplot(aes(x=date, y=new_deaths)) +
  geom_line() +
  facet_wrap(~administrative_area_level_2) +
  theme_bw()+
  theme(axis.title.x=element_blank())

# Note this data is not perfect. Why TF are there negative deaths in penssylvania in April?
# Obviously someone revised the counts down and the data was not similarly updated. 
# For the moment we can ignore this but subsequent analyses will have to clean this up. 

