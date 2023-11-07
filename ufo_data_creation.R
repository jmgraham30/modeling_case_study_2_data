library(tidyverse)
library(tidymodels)
library(forcats)

theme_set(theme_minimal(base_size=12))

tidymodels_prefer()

ufo_sightings <- read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-06-20/ufo_sightings.csv')
places <- read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-06-20/places.csv')

glimpse(ufo_sightings)
glimpse(places)

table(ufo_sightings$shape)

ufo_sightings <- ufo_sightings %>%
  filter(!is.na(shape) & country_code == "US")

ufo_sightings$shape <- fct_collapse(ufo_sightings$shape,geometric = c("chevron","cigar","circle","cone","cross","cube","cylinder","diamond","disk","egg","orb","oval","rectangle","sphere","star","teardrop","triangle"),
               dynamic = c("changing","fireball","flash","formation","light","other","unknown")) 

table(ufo_sightings$shape)

ufo_df <- left_join(ufo_sightings,places,by=c("city"="city","state"="state"),relationship =
                      "many-to-many")


glimpse(ufo_df)

ufo_df <- ufo_df %>%
  select(shape,duration_seconds,day_part,latitude,longitude,population,elevation_m) 

glimpse(ufo_df)

ufo_df$day_part <- fct_collapse(ufo_df$day_part,morning = c("morning","astronomical dawn","civil dawn","nautical dawn"),
                                afternoon = c("afternoon"),
                                night = c("night","astronomical dusk","civil dusk","nautical dusk"))

table(ufo_df$day_part)


