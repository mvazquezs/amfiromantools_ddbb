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
   

  df_ample_vazq
#> Warning in to_md(structure(list(index_id = c("index_id", "#010", "#010", : Couldn't print whole table in max_width = 80 characters.
#> Printing 8/10 columns.
```

------------------------------------------------------------------------
 **inde** **nom** **t_bu** **prov** **pais** **ampl** **ampl** **alca** 
 **x_id**         **ildi** **inci**          **ada_** **ada_** **da_g** 
                  **ng**   **a_ro**          **gene** **aren** **ener** 
                           **mana**           **ral**    **a**   **al** 
--------- ------- -------- -------- -------- -------- -------- -------- 
 #010     CARMO   amphithe hispania spain         108     58.8       98 
                  ater     _baetica                                     
                                                                        
 #010     CARMO   amphithe hispania spain         130     58.8      111 
                  ater     _baetica                                     
                                                                        
 #010     CARMO   amphithe hispania spain                 58.8          
                  ater     _baetica                                     
                                                                        
 #010     CARMO   amphithe hispania spain         131       58      111 
                  ater     _baetica                                     
                                                                        
 #010     CARMO   amphithe hispania spain         108     58.8       98 
                  ater     _baetica                                     
                                                                        
 #010     CARMO   amphithe hispania spain         108       58       98 
                  ater     _baetica                                     
                                                                        
 #010     CARMO   amphithe hispania spain          90       58          
                  ater     _baetica                                     
                                                                        
 #010     CARMO   amphithe hispania spain         131       58      111 
                  ater     _baetica                                     
                                                                        
 #010     CARMO   amphithe hispania spain         131               111 
                  ater     _baetica                                     
                                                                        
 #010     CARMO   amphithe hispania spain                               
                  ater     _baetica                                     
------------------------------------------------------------------------


