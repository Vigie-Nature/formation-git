# Compare dplyr and data.table on a 1.1 gb file

# load packages
library(data.table)
library(dplyr)
library(microbenchmark)
library(ggplot2)

# import data as data.table and transform to tibble
test_data.table <- data.table::fread("data_oiseaux.txt")
test_tibble <- tibble(test_data.table)

# importer la fonction de comptate avec dplyr
source("compter_les_piafs.R")

# comparer les performances en fonction des packages 
# et des types d'objet
speed <- microbenchmark(
  "dplyr_tibble" = {
    res <- compter_les_piafs(test_tibble)
  },
  "dplyr_data.table" = {
    res <- compter_les_piafs(test_data.table)
  },
  "data.table_data.table" = {
    res <- test_data.table[, .(nb_occurence = .N), by = .(NAME_SPECIES)]
    res <- res[order(nb_occurence, decreasing=TRUE), ]
  }, times = 2)

autoplot(speed)
