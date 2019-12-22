
# Provide codebook for the DHS calendar
# Based on:
# https://www.dhsprogram.com/data/calendar-tutorial/#references

# Also includes alternative recodings as modern/traditional
# according to DHS3 or DHS6 (LAM and SDM recalssified as modern)

dhs_calendar_codebook <- read.csv("../DHScalendar_codebook.csv",
                                  stringsAsFactors = FALSE)

usethis::use_data(dhs_calendar_codebook,
                  overwrite = TRUE,
                  compress = "xz")
