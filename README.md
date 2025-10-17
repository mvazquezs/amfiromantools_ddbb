---
output: github_document
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
      'data/00_data_exemple/01_data_exemple_golvin.csv', 
      dec = '.') %>%
    as_tibble()

### Mostrem les primeres files i les dimensions del dataframe
  head(df_golvin, 10)
#> Warning in knit_print.huxtable(ht): Unrecognized output format "github". Using `to_screen` to print huxtables.
#> Set options("huxtable.knitr_output_format") manually to "latex", "html", "rtf", "docx", "pptx", "md", "typst" or "screen".
```

  ┌──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
  │ index_id   nom        provinci   pais      amplada_   alcada_a   amplada_   alcada_g   nombre_p   amplada_   ratio_ar   ratio_ge   superfic  
  │                       a_romana                arena       rena    general     eneral      laces      cavea        ena      neral   ie_arena  
  ├──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
  │ #010       CARMO      hispania   spain         58.8                   131      111        24195       36.2                  1.18             
  │                       _baetica                                                                                                               
  │ #011       UCUBI      hispania   spain         35                                                                                            
  │                       _baetica                                                                                                               
  │ #031       TOMEN Y    britania   wales         35         28           52       46         2772        8.5   1.25           1.13   770       
  │            MUR                                                                                                                               
  │ #032       CHARTERH   britania   england       35         24           50       39         2179        7.5   1.46           1.28   660       
  │            OUSE                                                                                                                              
  │ #033       CORINIUM   britania   england       49         41           89       81        10210       20     1.2            1.1    1.58e+03  
  │            DOBUNNOR                                                                                                                          
  │            UM                                                                                                                                
  │ #034       DURNOVAR   britania   england       58         47           88       77         7952       15     1.23           1.14   2.14e+03  
  │            IA                                                                                                                                
  │ #035       NOV.       britania   england       56         47           88                                    1.19                  2.07e+03  
  │            REGENSIU                                                                                                                          
  │            M                                                                                                                                 
  │ #040       CALLEVA    britania   england       49         40           80       70         7147       15.5   1.22e+03       1.14   1.54e+03  
  │            ATREBATU                                                                                                                          
  │            M                                                                                                                                 
  │ #077       EMERITA    hispania   spain         64.5       41.2        126      103        20225       30.9   1.57           1.23   2.09e+03  
  │            AUGUSTA    _lusitan                                                                                                               
  │                       ia                                                                                                                     
  │ #088       SEGOBRIG   hispania   spain         40.5       34           75       68.5       7383       17.2   1.19           1.09   1.08e+03  
  │            A          _tarraco                                                                                                               
  │                       nensis                                                                                                                 
  └──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Column names: index_id, nom, provincia_romana, pais, amplada_arena, alcada_arena, amplada_general, alcada_general, nombre_places, amplada_cavea,
ratio_arena, ratio_general, superficie_arena, superficie_general, superficie_cavea, perimetre_arena, perimetre_general, ratio_cavea, bib

13/19 columns shown.

``` r


### Carreguem les dades de Vàzquez-Santiago des del fitxer d'exemple
  df_vazquez <- read.csv2(
      'data/00_data_exemple/02_data_exemple_vazquez.csv', 
      dec = '.') %>%
    as_tibble()

### Mostrem les primeres files i les dimensions del dataframe
  head(df_vazquez, 10)
#> Warning in knit_print.huxtable(ht): Unrecognized output format "github". Using `to_screen` to print huxtables.
#> Set options("huxtable.knitr_output_format") manually to "latex", "html", "rtf", "docx", "pptx", "md", "typst" or "screen".
```

      ┌──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
      │ place   phase   nom     hackett_   index_id   vasa_cla   t_buildi   dinasty_   amplada_   alcada_g   overall_   amplada_   alcada_a  
      │                         class                 ss         ng         gr          general     eneral         m2      arena       rena  
      ├──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
      │ carmo           CARMO   hispb#02   #010       hisbae#0   amphithe   caesarea        108         98                  58.8       38.6  
      │                                               2          ater       n                                                                
      │ carmo           CARMO   hispb#02   #010       hisbae#0   amphithe   caesarea        130        111                  58.8       38.6  
      │                                               2          ater       n                                                                
      │ carmo           CARMO   hispb#02   #010       hisbae#0   amphithe   caesarea                                        58.8       39    
      │                                               2          ater       n                                                                
      │ carmo           CARMO   hispb#02   #010       hisbae#0   amphithe   caesarea        131        111                  58         39    
      │                                               2          ater       n                                                                
      │ carmo           CARMO   hispb#02   #010       hisbae#0   amphithe   caesarea        108         98                  58.8       38.6  
      │                                               2          ater       n                                                                
      │ carmo           CARMO   hispb#02   #010       hisbae#0   amphithe   caesarea        108         98                  58         39    
      │                                               2          ater       n                                                                
      │ carmo           CARMO   hispb#02   #010       hisbae#0   amphithe   caesarea         90                             58         39    
      │                                               2          ater       n                                                                
      │ carmo           CARMO   hispb#02   #010       hisbae#0   amphithe   caesarea        131        111                  58         39    
      │                                               2          ater       n                                                                
      │ carmo           CARMO   hispb#02   #010       hisbae#0   amphithe   caesarea        131        111   1.15e+04                        
      │                                               2          ater       n                                                                
      │ carmo           CARMO   hispb#02   #010       hisbae#0   amphithe   caesarea                                                         
      │                                               2          ater       n                                                                
      └──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Column names: place, phase, nom, hackett_class, index_id, vasa_class, t_building, dinasty_gr, amplada_general, alcada_general, overall_m2,
amplada_arena, alcada_arena, arena_m2, amplada_cavea, cavea_height, cavea_m2, nombre_places, pais, lat, long, elevation_m, bib, provincia_romana,
ratio_arena, ratio_general, superficie_arena, superficie_general, superficie_cavea, perimetre_arena, perimetre_general, ratio_cavea

13/32 columns shown.

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
