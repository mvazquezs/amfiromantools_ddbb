---
output: github_document
---

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
# Carreguem les dades de Golvin
df_golvin <- load_dimensions_golvin()
#> i  Les dades ha estat carregat correctament

# Mostrem les primeres files de les dades de Golvin amb un format net
df_golvin %>%
  select(index_id, nom, pais, amplada_arena, alcada_arena, amplada_general, alcada_general, nombre_places) %>%
  head(10) %>%
  knitr::kable(caption = "Primers 10 registres de les dades de Golvin")
```



Table: Primers 10 registres de les dades de Golvin

|index_id |nom               |pais  | amplada_arena| alcada_arena| amplada_general| alcada_general| nombre_places|
|:--------|:-----------------|:-----|-------------:|------------:|---------------:|--------------:|-------------:|
|#001     |CUMAE             |italy |              |             |                |               |              |
|#002     |POMPEI            |italy |          66.0|         34.5|           134.0|          102.5|         22497|
|#003     |ABELLA            |italy |              |             |            79.0|           53.0|              |
|#004     |TEANUM CALES      |italy |              |             |                |               |              |
|#005     |PUTEOLI P. AMPHI. |italy |          69.0|         35.0|           130.0|           95.0|         19507|
|#006     |TELESIA           |italy |          68.0|         46.0|            99.0|           77.0|          8825|
|#007     |PAESTUM 1         |italy |          36.8|         34.4|            77.3|           54.8|          4480|
|#008     |SUTRIUM           |italy |          50.0|             |            85.0|           75.0|          8590|
|#009     |FERENTIUM         |italy |              |             |            67.5|           40.0|              |
|#010     |CARMO             |spain |          58.8|             |           131.2|          111.4|         24195|



### 3. Anàlisi Descriptiva

La funció `tab_summary()` permet generar ràpidament estadístiques descriptives per a les variables d'interès, agrupant-les si és necessari.


``` r
# Calculem estadístiques descriptives per a les dimensions principals, agrupant per país
resum_per_pais <- tab_summary(
  df = df_golvin,
  seleccio_variables = c(amplada_general, alcada_general, nombre_places),
  grup_by = pais
)
#> Error: object 'pais' not found

# Mostrem el resultat en una taula formatada
resum_per_pais %>%
  knitr::kable(
    caption = "Resum estadístic de dimensions per país",
    digits = 1 # Arrodonim els decimals per a més claredat
  )
#> Error: object 'resum_per_pais' not found
```

### 4. Imputació de valors perduts (Exemple futur)

El paquet també inclourà eines per a la gestió de valors perduts.


``` r
# NOTA: Aquesta funció encara no existeix al paquet.
# Un cop creada, es podrà executar aquest exemple.

# # Imputar valors perduts utilitzant la mitjana per grup
# resultat_imputacio <- imputacio_estadistics(
#   df = df_golvin,
#   seleccio_variables = c(amplada_general, alcada_general),
#   grup_by = pais,
#   metode_imputacio = 'aritmetica'
# )
# 
# df_imputat <- resultat_imputacio$imputed_df
# print(df_imputat)
```

## Llicència

Aquest projecte es distribueix sota la llicència Apache 2.0. Consulteu el fitxer `LICENSE` per a més detalls.

## Com contribuir

Si trobeu algun error o teniu suggeriments de millora, si us plau, obriu una issue a GitHub.

## Citació

Per citar `amfiromantools_ddbb` en publicacions, podeu utilitzar:


```
#> Vázquez, M. (2024). amfiromantools_ddbb: Eines per a l'anàlisi de dades d'amfiteatres romans. R package version 0.0.0.9000. https://github.com/mvazquezs/amfiromantools_ddbb
```
