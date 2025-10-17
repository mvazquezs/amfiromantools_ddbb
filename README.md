<!-- README.md is generated from README.Rmd. Please edit that file -->



# amfiromantools_ddbb

<!-- badges: start -->
[![R-CMD-check](https://github.com/mvazquezs/amfiromantools_ddbb/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/mvazquezs/amfiromantools_ddbb/actions/workflows/R-CMD-check.yaml)
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
library(amfiromantools_ddbb)
library(dplyr) # El carreguem per a l'exemple
```

### 2. Càrrega de dades

El paquet inclou funcions per carregar conjunts de dades estandarditzats.


``` r
### Carreguem les dades de Vàzquez-Santiago
  df_ample_vazq <- load_dimensions_vazquez(
      filtrar_edifici = 'amphitheater',
      filtrar_provincia = c('hispania', 'panonia'),
      seleccionar_columnes = c(contains('amplada'), contains('alcada'), -contains('cavea'), 'bib')) %>%
    head(10)
```

i  Els paquets han estat carregats correctament
i  Les dades ha estat carregat correctament

``` r
   

  print(as_tibble(df_ample_vazq))
```

# A tibble: 10 × 10
   index_id nom   t_building   provincia_romana pais  amplada_general amplada_arena alcada_general alcada_arena bib                  
   <chr>    <chr> <chr>        <chr>            <chr>           <dbl>         <dbl>          <dbl>        <dbl> <chr>                
 1 #010     CARMO amphitheater hispania_baetica spain            108           58.8            98          38.6 2015_jimenez         
 2 #010     CARMO amphitheater hispania_baetica spain            130           58.8           111          38.6 2014_gonzalez        
 3 #010     CARMO amphitheater hispania_baetica spain             NA           58.8            NA          39   2014_gonzalez        
 4 #010     CARMO amphitheater hispania_baetica spain            131.          58             111.         39   2014_golvin          
 5 #010     CARMO amphitheater hispania_baetica spain            108           58.8            98          38.6 2011_amphitheatrum_de
 6 #010     CARMO amphitheater hispania_baetica spain            108           58              98          39   2011_amphitheatrum_de
 7 #010     CARMO amphitheater hispania_baetica spain             90           58              NA          39   2007_welch           
 8 #010     CARMO amphitheater hispania_baetica spain            131           58             111          39   2016_stelius         
 9 #010     CARMO amphitheater hispania_baetica spain            131.          NA             111.         NA   2019_hackett         
10 #010     CARMO amphitheater hispania_baetica spain             NA           NA              NA          NA   2016_sfsheath_com    
