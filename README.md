<!-- README.md is generated from README.Rmd. Please edit that file -->



# amphidata <a href="https://amphidata.r-lib.org/"><img src="man/figures/amphi_logo.png" align="right" height="300" alt=""/></a>

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

  knitr::kable(df_ori_88)
```



|index_id |nom             |provincia_romana       |pais     | amplada_arena| amplada_general| alcada_arena| alcada_general|bib         |
|:--------|:---------------|:----------------------|:--------|-------------:|---------------:|------------:|--------------:|:-----------|
|#010     |CARMO           |hispania_baetica       |spain    |          58.8|           131.2|             |          111.4|1988_golvin |
|#011     |UCUBI           |hispania_baetica       |spain    |          35.0|                |             |               |1988_golvin |
|#077     |EMERITA AUGUSTA |hispania_lusitania     |spain    |          64.5|           126.3|         41.2|          102.6|1988_golvin |
|#088     |SEGOBRIGA       |hispania_tarraconensis |spain    |          40.5|            75.0|         34.0|           68.5|1988_golvin |
|#093     |EMPORIAE        |hispania_tarraconensis |spain    |          75.0|            88.0|         43.0|           56.0|1988_golvin |
|#101     |CONIMBRIGA      |hispania_lusitania     |portugal |          54.0|            94.0|         40.0|           80.0|1988_golvin |
|#139     |TARRACO         |hispania_tarraconensis |spain    |          84.4|           148.1|         55.2|          118.9|1988_golvin |
|#175     |ITALICA         |hispania_baetica       |spain    |          71.5|           156.5|         49.0|          134.0|1988_golvin |




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


