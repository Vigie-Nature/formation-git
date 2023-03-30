compter_les_piafs <- function(data_piafs) {
  data_piafs %>%
    group_by(NAME_SPECIES) %>%
    summarise(nb_occurence = n()) %>%
    arrange(nb_occurence)
}