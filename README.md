---
---

<!-- README.md is generated from README.Rmd. Please edit that file -->



# amfiromantools_ddbb

**Projecte `devtools` per a la càrrega, gestió i anàlisi de dades d'amfiteatres romans.**

`amfiromantools_ddbb` és un paquet de R dissenyat per facilitar el treball amb dades d'amfiteatres romans. Proporciona un conjunt d'eines per automatitzar tasques comunes com la càrrega de dades, la generació de resums estadístics, la imputació de valors perduts i la realització d'anàlisis estadístiques.

## Característiques principals

*   **Càrrega de dades flexible:** Llegeix dades de múltiples formats (Excel, CSV) i organitza la informació de manera eficient.
*   **Anàlisi descriptiva:** Genera taules de resum completes amb estadístiques descriptives clau.
*   **Imputació de dades:** Ofereix mètodes d'imputació estadístics i basats en machine learning (missForest) per tractar els valors perduts.
*   **Configuració del projecte:** Ajuda a estandarditzar l'estructura de directoris i la gestió de dependències.

## Instal·lació

Per instal·lar el paquet directament des de GitHub, podeu utilitzar el paquet `devtools`:

```r
### Installació des de GitHub

  if (!require('devtools')) { install.packages('devtools') }

  devtools::install_github('https://github.com/mvazquezs/amfiromantools_ddbb')

```

*Nota: Reemplaceu `https://github.com/mvazquezs/amfiromantools_ddbb` amb la URL real del repositori un cop estigui disponible a GitHub.*

## Ús

A continuació es mostren alguns exemples de com utilitzar les funcions principals del paquet.

### 1. Configuració inicial

Per començar, podeu configurar l'entorn de treball i carregar les llibreries necessàries.


``` r
### Carrega el paquet
library(amfiromantools_ddbb)

### Configura l'estructura de directoris del projecte
### Aquesta funció crearà els directoris 'data', 'R', 'output', i 'capitols'.
### Si ja existeixen, mostrarà un missatge informatiu per a cada un.
  amphi_setup_dirs()
#> El directori ja existeix: C:/Users/my_annamiquel/Documents/git/amfiromantools_ddbb/data
#> El directori ja existeix: C:/Users/my_annamiquel/Documents/git/amfiromantools_ddbb/R
#> El directori ja existeix: C:/Users/my_annamiquel/Documents/git/amfiromantools_ddbb/output
#> El directori ja existeix: C:/Users/my_annamiquel/Documents/git/amfiromantools_ddbb/capitols


### Carrega tots els paquets necessaris per a l'anàlisi
  amphi_load_packages()
#> i  Els paquets han estat carregats correctament
```

### 2. Càrrega de dades

Llegim les dades d'exemple des dels fitxers CSV que hem generat prèviament.


``` r
### Carreguem les dades de Golvin des del fitxer d'exemple
  df_golvin <- read.csv2(
      'data/00_data_exemple/df_golvin.csv', 
      dec = '.')
#> Warning in file(file, "rt"): no es pot obrir el fitxer «data/00_data_exemple/df_golvin.csv»: No such file or directory
#> Error in file(file, "rt"): cannot open the connection

### Mostrem les primeres files del dataframe amb un format net
  knitr::kable(head(df_golvin))
```



|index_id |nom                 |provincia_romana |pais    | amplada_arena| alcada_arena| amplada_general| alcada_general| nombre_places| amplada_cavea| ratio_arena| ratio_general| superficie_arena| superficie_general| superficie_cavea| perimetre_arena| perimetre_general| ratio_cavea|bib         |
|:--------|:-------------------|:----------------|:-------|-------------:|------------:|---------------:|--------------:|-------------:|-------------:|-----------:|-------------:|----------------:|------------------:|----------------:|---------------:|-----------------:|-----------:|:-----------|
|#010     |CARMO               |hispania_baetica |spain   |          58.8|           NA|           131.2|          111.4|         24195|          36.2|          NA|      1.177738|               NA|          11479.128|               NA|              NA|          381.0752|          NA|1988_golvin |
|#011     |UCUBI               |hispania_baetica |spain   |          35.0|           NA|              NA|             NA|            NA|            NA|          NA|            NA|               NA|                 NA|               NA|              NA|                NA|          NA|1988_golvin |
|#031     |TOMEN Y MUR         |britania         |wales   |          35.0|           28|            52.0|           46.0|          2772|           8.5|    1.250000|      1.130435|         769.6902|           1878.672|         1108.982|        98.96017|          153.9380|   0.4096990|1988_golvin |
|#032     |CHARTERHOUSE        |britania         |england |          35.0|           24|            50.0|           39.0|          2179|           7.5|    1.458333|      1.282051|         659.7345|           1531.526|          871.792|        92.67698|          139.8009|   0.4307692|1988_golvin |
|#033     |CORINIUM DOBUNNORUM |britania         |england |          49.0|           41|            89.0|           81.0|         10210|          20.0|    1.195122|      1.098765|        1577.8649|           5661.935|         4084.070|       141.37167|          267.0354|   0.2786794|1988_golvin |
|#034     |DURNOVARIA          |britania         |england |          58.0|           47|            88.0|           77.0|          7952|          15.0|    1.234043|      1.142857|        2140.9954|           5321.858|         3180.863|       164.93361|          259.1814|   0.4023022|1988_golvin |



``` r


### Carreguem les dades de Vàzquez-Santiago des del fitxer d'exemple
  df_vazquez <- read.csv2(
    'data/00_data_exemple/df_vazquez.csv', 
    dec = '.')
#> Warning in file(file, "rt"): no es pot obrir el fitxer «data/00_data_exemple/df_vazquez.csv»: No such file or directory
#> Error in file(file, "rt"): cannot open the connection

### Mostrem les primeres files del dataframe
  knitr::kable(head(df_vazquez))
```



|place |phase |nom   |hackett_class |index_id |vasa_class |t_building   |dinasty_gr | amplada_general| alcada_general| overall_m2| amplada_arena| alcada_arena| arena_m2| amplada_cavea| cavea_height| cavea_m2| nombre_places|pais  |lat      |long     | elevation_m|bib                   |provincia_romana | ratio_arena| ratio_general| superficie_arena| superficie_general| superficie_cavea| perimetre_arena| perimetre_general| ratio_cavea|
|:-----|:-----|:-----|:-------------|:--------|:----------|:------------|:----------|---------------:|--------------:|----------:|-------------:|------------:|--------:|-------------:|------------:|--------:|-------------:|:-----|:--------|:--------|-----------:|:---------------------|:----------------|-----------:|-------------:|----------------:|------------------:|----------------:|---------------:|-----------------:|-----------:|
|carmo |NA    |CARMO |hispb#02      |#010     |hisbae#02  |amphitheater |caesarean  |           108.0|           98.0|         NA|          58.8|         38.6|       NA|            NA|           NA|     7442|         18605|spain |37469587 |-5650787 |         220|2015_jimenez          |hispania_baetica |    1.523316|      1.102041|         1782.603|           8312.654|         6530.052|        152.9956|          323.5840|   0.2144444|
|carmo |NA    |CARMO |hispb#02      |#010     |hisbae#02  |amphitheater |caesarean  |           130.0|          111.0|         NA|          58.8|         38.6|       NA|            NA|           NA|       NA|            NA|spain |37469587 |-5650787 |         220|2014_gonzalez         |hispania_baetica |    1.523316|      1.171171|         1782.603|          11333.295|         9550.693|        152.9956|          378.5619|   0.1572890|
|carmo |NA    |CARMO |hispb#02      |#010     |hisbae#02  |amphitheater |caesarean  |              NA|             NA|         NA|          58.8|         39.0|       NA|            NA|           NA|       NA|            NA|spain |37469587 |-5650787 |         220|2014_gonzalez         |hispania_baetica |    1.507692|            NA|         1801.075|                 NA|               NA|        153.6239|                NA|          NA|
|carmo |NA    |CARMO |hispb#02      |#010     |hisbae#02  |amphitheater |caesarean  |           131.2|          111.4|         NA|          58.0|         39.0|       NA|            NA|           NA|       NA|            NA|spain |37469587 |-5650787 |         220|2014_golvin           |hispania_baetica |    1.487180|      1.177738|         1776.571|          11479.128|         9702.558|        152.3672|          381.0752|   0.1547653|
|carmo |NA    |CARMO |hispb#02      |#010     |hisbae#02  |amphitheater |caesarean  |           108.0|           98.0|         NA|          58.8|         38.6|       NA|          29.6|           NA|       NA|         18350|spain |37469587 |-5650787 |         220|2011_amphitheatrum_de |hispania_baetica |    1.523316|      1.102041|         1782.603|           8312.654|         6530.052|        152.9956|          323.5840|   0.2144444|
|carmo |NA    |CARMO |hispb#02      |#010     |hisbae#02  |amphitheater |caesarean  |           108.0|           98.0|         NA|          58.0|         39.0|       NA|          29.6|           NA|       NA|         18350|spain |37469587 |-5650787 |         220|2011_amphitheatrum_de |hispania_baetica |    1.487180|      1.102041|         1776.571|           8312.654|         6536.084|        152.3672|          323.5840|   0.2137188|



### 3. Generar una taula de resum

Obteniu estadístiques descriptives de les variables numèriques.


``` r
# NOTA: Aquesta funció encara no existeix al paquet.
# Un cop creada, es podrà executar aquest exemple.

# # Calcular estadístiques descriptives per les dimensions, agrupant per país
# resum <- tab_summary(
#   df = df_golvin,
#   seleccio_variables = c(starts_with('amplada'), starts_with('alcada')),
#   grup_by = 'pais')
# 
# print(resum)
```

### 4. Imputació de valors perduts

Si les vostres dades tenen valors perduts, podeu imputar-los utilitzant diferents mètodes.


``` r
# NOTA: Aquesta funció encara no existeix al paquet.
# Un cop creada, es podrà executar aquest exemple.

# # Utilitzem el mateix data.frame amb valors NA
# # Imputar utilitzant la mitjana aritmètica per grup
# resultat_imputacio <- imputacio_estadistics(
#   df = df_golvin,
#   seleccio_variables = c(starts_with('amplada'), starts_with('alcada')),
#   grup_by = pais,
#   metode_imputacio = 'aritmetica'
# )
# 
# df_imputat <- resultat_imputacio$imputed_df
# print(df_imputat)
```

## Llicència

Aquest projecte es distribueix sota la llicència Apache License (>= 2). Consulteu el fitxer `LICENSE` per a més detalls.
