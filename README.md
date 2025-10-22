<!-- README.md is generated from README.Rmd. Please edit that file -->



# amphidata <a href="https://amphidata.r-lib.org/"><img src="man/figures/amphi_logo.png" align = "right" height = "400" alt=""/></a>

<!-- badges: start -->
[![License: Apache 2.0](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://www.apache.org/licenses/LICENSE-2.0)
<!-- badges: end -->

**Projecte `devtools` per a la càrrega, gestió i anàlisi de dades d'amfiteatres romans.**

`amfiromantools_ddbb` és un paquet de R dissenyat per facilitar el treball amb dades d'amfiteatres romans. Proporciona un conjunt d'eines per automatitzar tasques comunes com la càrrega de dades, la generació de resums estadístics, la imputació de valors perduts i la realització d'anàlisis estadístiques.

## Instal·lació

Podeu instal·lar la versió de desenvolupament des de GitHub amb:


``` r

if (!require('devtools') install.packages('devtools'))
devtools::install_github('mvazquezs/amphidata')

```

## Ús

A continuació es mostren alguns exemples de com utilitzar les funcions principals del paquet.

### 1. Configuració inicial

Primer, carreguem el paquet. Les funcions `amphi_setup_dirs()` i `amphi_load_packages()` són útils per configurar l'entorn, però no són necessàries per a l'ús bàsic del paquet un cop instal·lat.


``` r

### Càrrega de paquet
  library('amphidata')

### Càrrega de paquets necessaris
  amphi_load_packages(
    update_packages = FALSE)
#> i  Els paquets han estat carregats correctament
```

### 2. Càrrega de dades

El paquet inclou funcions per carregar conjunts de dades estandarditzats.


``` r

### Carreguem les dades de Vàzquez-Santiago
  df_ori_88 <- load_dimensions_golvin(
    filtrar_provincia = c('hispania', 'panonia'),
    seleccionar_columnes = c(contains('amplada'), contains('alcada'), -contains('cavea'), 'bib'))
```

i  Les dades han estat carregades correctament

``` r


  head(df_ori_88, 5) 
#> Warning in to_md(structure(list(index_id = c("index_id", "#010", "#011", : Couldn't print whole table in max_width = 80 characters.
#> Printing 8/9 columns.
```

-------------------------------------------------------------------------
 **inde** **nom**  **prov** **pais** **ampl** **ampl** **alca** **alca** 
 **x_id**          **inci**          **ada_** **ada_** **da_a** **da_g** 
                   **a_ro**          **aren** **gene** **rena** **ener** 
                   **mana**             **a**  **ral**            **al** 
--------- -------- -------- -------- -------- -------- -------- -------- 
 #010     CARMO    hispania spain        58.8      131               111 
                   _baetica                                              
                                                                         
 #011     UCUBI    hispania spain          35                            
                   _baetica                                              
                                                                         
 #077     EMERITA  hispania spain        64.5      126     41.2      103 
          AUGUSTA  _lusitan                                              
                   ia                                                    
                                                                         
 #088     SEGOBRIG hispania spain        40.5       75       34     68.5 
          A        _tarraco                                              
                   nensis                                                
                                                                         
 #093     EMPORIAE hispania spain          75       88       43       56 
                   _tarraco                                              
                   nensis                                                
-------------------------------------------------------------------------




``` r

### Carreguem les dades de Vàzquez-Santiago
  df_ori <- load_dimensions_vazquez(
    filtrar_edifici = 'amphitheater',
    filtrar_provincia = c('hispania', 'panonia'),
    seleccionar_columnes = c(contains('amplada'), contains('alcada'), -contains('cavea'), 'bib'))
```

i  Les dades han estat carregades correctament

``` r

  head(df_ori, 5)
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
------------------------------------------------------------------------


