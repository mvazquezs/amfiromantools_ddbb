# tests/testthat/test_00_amphi_load_packages.R

library(testthat)

# Font de la funció a provar
source('../../R/00_setup.R')

test_that('amphi_load_packages funciona sense errors i carrega paquets', {
  
  # Prova 1: Executar la funció i comprovar que no hi ha errors
  # Capturem la sortida per evitar que el missatge aparegui a la consola de tests
  output <- capture.output({
    expect_no_error(amphi_load_packages())
  }, type = 'message')
  
  # Comprovar que el missatge de confirmació s'ha mostrat
  # Usem `any(grepl(...))` perquè el format pot incloure codis de color ANSI
  expect_true(any(grepl('Els paquets han estat carregats correctament', output)))
  
  # Prova 2: Comprovar si alguns paquets clau estan carregats a la sessió
  # Aquesta prova assumeix que els paquets ja estan instal·lats.
  # `pacman` els carregarà a l'entorn.
  
  # Després de cridar la funció, comprovem si alguns paquets estan a la llista
  # de paquets carregats.
  loaded_packages <- .packages()
  
  # Comprovem alguns paquets importants de la llista
  expect_true('dplyr' %in% loaded_packages)
  expect_true('ggplot2' %in% loaded_packages)
  expect_true('pacman' %in% loaded_packages) # El propi pacman ha d'estar carregat
  
})

test_that('amphi_load_packages gestiona actualització de paquets', {
  
  # Prova 3: Comprovar argument `update_packages` accepta
  # No podem provar si actualització realment passa, ja que seria lent i invasiu,
  # però podem assegurar-nos que la funció executa sense errors amb largument.
  output_update <- capture.output({
    expect_no_error(amphi_load_packages(update_packages = TRUE))
  }, type = 'message')
  
  # El missatge de confirmació també hauria d'aparèixer aquí
  expect_true(any(grepl('Els paquets han estat carregats correctament', output_update)))
  
})
