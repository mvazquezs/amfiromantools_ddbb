# tests/testthat/00_test_load_dimensions_golvin.R

# Carrega les llibreries necessàries per als tests
library(testthat)
library(dplyr)
library(tibble)

# Assegura't que la funció a provar estigui disponible
# Normalment, això es gestiona amb devtools::load_all() o similar en un entorn de paquet
source('../../R/00_dimensions_amfiteatres_golvin.R')

# Inici del bloc de tests per a la funció load_dimensions_golvin

# Carreguem les dades una vegada per a tots els tests
df_golvin <- load_dimensions_golvin()

test_that('La funció retorna un tibble no buit', {
  expect_s3_class(df_golvin, 'tbl_df')
  expect_true(nrow(df_golvin) > 0)
  expect_equal(ncol(df_golvin), 19) # Nombre esperat de columnes
})

# Test 2: Assegurar que la modificació de dades és correcta
test_that('Les columnes calculades i els tipus de dades són correctes', {
  # Comprova l'existència de columnes calculades
  expect_true('ratio_arena' %in% names(df_golvin))
  expect_true('superficie_general' %in% names(df_golvin))
  
  # Comprova que les columnes numèriques siguin del tipus correcte
  expect_type(df_golvin$ratio_arena, 'double')
  expect_type(df_golvin$superficie_general, 'double')
  expect_type(df_golvin$nombre_places, 'double')
  
  # Comprova que les columnes de caràcter siguin del tipus correcte
  expect_type(df_golvin$nom, 'character')
  expect_type(df_golvin$provincia_romana, 'character')
})

# Test 3: Assegurar que el filtratge de dades funciona
test_that('El filtratge per província funciona', {
  df_hispania <- load_dimensions_golvin(filtrar_provincia = 'hispania')
  
  # Comprova que totes les files pertanyen a províncies d'Hispania
  expect_true(all(grepl('hispania', unique(df_hispania$provincia_romana))))
  expect_true(nrow(df_hispania) > 0)
  expect_false(nrow(df_hispania) == nrow(df_golvin)) # El subconjunt ha de ser més petit
})

test_that('El filtratge per país funciona', {
  df_italy <- load_dimensions_golvin(filtrar_pais = 'italy')
  
  # Comprova que totes les files pertanyen a Itàlia
  expect_equal(unique(df_italy$pais), 'italy')
  expect_true(nrow(df_italy) > 0)
  expect_false(nrow(df_italy) == nrow(df_golvin)) # El subconjunt ha de ser més petit
})

test_that('La selecció de columnes funciona', {
  df_seleccionat <- load_dimensions_golvin(seleccionar_columnes = c(amplada_arena, alcada_arena))
  
  # Comprova que les columnes seleccionades existeixen, a més de les clau
  expect_true(all(c('index_id', 'nom', 'provincia_romana', 'pais', 'amplada_arena', 'alcada_arena') %in% names(df_seleccionat)))
  expect_equal(ncol(df_seleccionat), 6)
})
