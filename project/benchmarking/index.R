library(conflicted)
library(tidyverse)
conflict_prefer_all("dplyr")
library(wesanderson)
library(fpp3)
library(scales)
library(clock)
library(usedthese)

conflict_scout()

theme_set(theme_bw())

(cols <- wes_palette(name = "IsleofDogs2"))
