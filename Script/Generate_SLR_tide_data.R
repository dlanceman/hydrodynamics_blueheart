# this script generates SLR-adjusted versions of the tide data.

# 1. get packages
library(tidyverse)
library(here)

# 2. get data
tide_default <- readLines(here("Data/PicnicPoint_resampled_and_smoothed_2023.tgr"))
head(tide_default)

# 3. modify data for sea level rise scenarios.

# first, create a function to modify the input to SLR and output
SLR_mod <- function(input, SLR_m){ # input is the input file; SLR_m is the amount of sea level rise, in metres
  output <- input
  # don't need to modify lines 1, 2 or 15695, as they don't contain data

  for(i in c(3:15694)){ # Sprintf is used to format as width 6, 3 decimals, right-aligned, space-padded on the left
    output[i] <- paste0(substr(input[i],1,18),sprintf("%6.3f",as.numeric(substr(input[i],19,24)) + SLR_m)) 
    # this adds the designated amount of sea level rise to the last 6 characters of each line, which contain the current tide level.
    }
  #output #this is if you want to generate a local character vector in R, then turn off the below line and turn this on
  writeLines(output, here(paste0("Output/SLR_WLs/TidesPicnicPoint",SLR_m,".tgr")))
} 

# now, implement the function for each designated tide level
SLR0.1 <- SLR_mod(tide_default, 0.1)
head(SLR0.1)
SLR0.2 <- SLR_mod(tide_default, 0.2)
SLR0.3 <- SLR_mod(tide_default, 0.3)
SLR0.4 <- SLR_mod(tide_default, 0.4)
SLR0.5 <- SLR_mod(tide_default, 0.5)
  
