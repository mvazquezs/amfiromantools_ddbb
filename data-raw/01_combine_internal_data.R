# data-raw/01_combine_internal_data.R

# Aquest script combina i guarda les dades internes generades per altres scripts.

# Carrega les llibreries necessàries
library(usethis)

# Executa els scripts que generen els objectes de dades
# Assegura't que els camins són correctes respecte a l'arrel del paquet
# Es fa servir suppressPackageStartupMessages per evitar els missatges de càrrega de paquets
suppressPackageStartupMessages({
  source('data-raw/00_prepare_data_vazquez.R')
  source('data-raw/00_prepare_data_golvin.R')
})

# Guarda ambdós objectes (l_df_ori i l_df_ori_88) en el fitxer sysdata.rda
# La crida 'overwrite = TRUE' és segura aquí, ja que és l'única que es farà per a sysdata.rda
usethis::use_data(
  l_df_ori, 
  l_df_ori_88, 
  internal = TRUE, 
  overwrite = TRUE)