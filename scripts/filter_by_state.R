# how to filter by state (geographic location)
# charles thrift
# 19 september 2026


library(sf)
library(dplyr)
library(rnaturalearth)

df <- occurrence_data

# convert data to spatial object (lat and long columns turn into one "geometry" column)
df_sf <- st_as_sf(df,
               coords = c("decimalLongitude", "decimalLatitude"),
               crs = 4326,
               remove = FALSE)

# define your area to clip to
area_of_interest <- ne_states(country = "United States of America",
                  returnclass = "sf") %>% 
  filter(name %in% c("California","Arizona"))

# clip the occurrence data to the area
df_clipped <- df_sf %>% 
  st_filter(area_of_interest)
