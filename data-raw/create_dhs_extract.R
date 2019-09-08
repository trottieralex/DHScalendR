# code to prepare `dhs_extract` dataset goes here

# Create a datasets to quickly test package functions

# Based on dummy dataset from DHS:
#    https://www.dhsprogram.com/data/calendar-tutorial/
# Downloaded: September 4, 2019
# zzir62fl.sav (dummy, individual recode, Phase 6 (~2008-2013))
# Using the SPSS file --IMPORTANT, name vars specific--


library(foreign)
library(dplyr)

# Read original DHS model dataset
dat <- read.spss("../ZZIR62FL.SAV",
                 to.data.frame = TRUE,
                 use.value.labels = TRUE )

# Select variables of interest
dd <- dat %>%
    select(V005, V008, V011, V017, V025,
           V211, V223, V501, V509,
           VCAL.1) %>%
    mutate_if(is.factor, as.character)

# Select 100 random rows
set.seed(7)
dhs_extract <- dd[sample(1:nrow(dd), 100), ]


usethis::use_data(dhs_extract,
                  overwrite = TRUE)
