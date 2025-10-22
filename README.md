<!-- README.md is generated from README.Rmd. Please edit that file -->
---
output:
  github_document:
    html_preview: false
---

<!-- README.md is generated from README.Rmd. Please edit that file -->



# amphidata <a href="https://amphidata.r-lib.org/"><img src="man/figures/amphi_logo.png" align="right" alt=""/></a>

<!-- badges: start -->
[![License: Apache 2.0](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://www.apache.org/licenses/LICENSE-2.0)
<!-- badges: end -->

## Prefaci
El projecte `amphidata` permet la càrrega, gestió i anàlisi de dades d'amfiteatres romans. Proporciona un conjunt d'eines per automatitzar tasques comunes com la càrrega de dades, la generació de resums estadístics, la imputació de valors perduts i la realització d'anàlisis estadístiques.

## Instal·lació

Podeu instal·lar la versió de desenvolupament des de GitHub amb:


``` r

if (!requireNamespace("devtools", quietly = TRUE)) install.packages("devtools")
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
#> [1m[34mi[39m[22m [30m Els paquets han estat carregats correctament
#> [39m
```

### 2. Càrrega de dades

El paquet inclou funcions per carregar conjunts de dades estandarditzats.


``` r

### Carreguem les dades de Vàzquez-Santiago
  df_ori_88 <- load_dimensions_golvin(
    filtrar_provincia = c('hispania', 'panonia'),
    seleccionar_columnes = c(contains('amplada'), contains('alcada'), -contains('cavea'), 'bib'))
#> [1m[34mi[39m[22m [30m Les dades han estat carregades correctament
#> [39m

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
#> [1m[34mi[39m[22m [30m Les dades han estat carregades correctament
#> [39m

  knitr::kable(head(df_ori, 5))
```



|index_id |nom   |t_building   |provincia_romana |pais  | amplada_general| amplada_arena| alcada_general| alcada_arena|bib                   |
|:--------|:-----|:------------|:----------------|:-----|---------------:|-------------:|--------------:|------------:|:---------------------|
|#010     |CARMO |amphitheater |hispania_baetica |spain |           108.0|          58.8|           98.0|         38.6|2015_jimenez          |
|#010     |CARMO |amphitheater |hispania_baetica |spain |           130.0|          58.8|          111.0|         38.6|2014_gonzalez         |
|#010     |CARMO |amphitheater |hispania_baetica |spain |                |          58.8|               |         39.0|2014_gonzalez         |
|#010     |CARMO |amphitheater |hispania_baetica |spain |           131.2|          58.0|          111.4|         39.0|2014_golvin           |
|#010     |CARMO |amphitheater |hispania_baetica |spain |           108.0|          58.8|           98.0|         38.6|2011_amphitheatrum_de |


