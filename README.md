<!-- README.md is generated from README.Rmd. Please edit that file -->



# amphidata<a href="https://amphidata.r-lib.org/"><img src="man/figures/amphi_logo.png" align="right" height="138" alt=""/></a>

<!-- badges: start -->
[![License: Apache 2.0](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://www.apache.org/licenses/LICENSE-2.0)
<!-- badges: end -->

**Projecte `devtools` per a la càrrega, gestió i anàlisi de dades d'amfiteatres romans.**

`amfiromantools_ddbb` és un paquet de R dissenyat per facilitar el treball amb dades d'amfiteatres romans. Proporciona un conjunt d'eines per automatitzar tasques comunes com la càrrega de dades, la generació de resums estadístics, la imputació de valors perduts i la realització d'anàlisis estadístiques.

## Instal·lació

Podeu instal·lar la versió de desenvolupament des de GitHub amb:


``` r
if (!require("devtools")) install.packages("devtools")
devtools::install_github("mvazquezs/amfiromantools_ddbb")
```

## Ús

A continuació es mostren alguns exemples de com utilitzar les funcions principals del paquet.

### 1. Configuració inicial

Primer, carreguem el paquet. Les funcions `amphi_setup_dirs()` i `amphi_load_packages()` són útils per configurar l'entorn, però no són necessàries per a l'ús bàsic del paquet un cop instal·lat.


``` r

### Càrrega de paquet
  library(amfiromantools_ddbb)
#> Error in library(amfiromantools_ddbb): no hi ha cap paquet anomenat 'amfiromantools_ddbb'

### Càrrega de paquets necessaris
  amphi_load_packages(
    update_packages = FALSE)
#> Error in amphi_load_packages(update_packages = FALSE): could not find function "amphi_load_packages"
```

### 2. Càrrega de dades

El paquet inclou funcions per carregar conjunts de dades estandarditzats.


``` r
### Carreguem les dades de Vàzquez-Santiago
  df <- load_dimensions_vazquez(
      filtrar_edifici = 'amphitheater',
      filtrar_provincia = c('hispania', 'panonia'),
      seleccionar_columnes = c(contains('amplada'), contains('alcada'), -contains('cavea'), 'bib'))
#> Error in load_dimensions_vazquez(filtrar_edifici = "amphitheater", filtrar_provincia = c("hispania", : could not find function "load_dimensions_vazquez"
```
