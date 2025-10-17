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

```r
### Carrega el paquet
library(amfiromantools_ddbb)

### Configura l'estructura de directoris del projecte
### Aquesta funció crearà els directoris 'data', 'R', 'output', i 'capitols'.
### Si ja existeixen, mostrarà un missatge informatiu per a cada un.
  amphi_setup_dirs()


### Carrega tots els paquets necessaris per a l'anàlisi
  amphi_load_packages()
```

### 2. Càrrega de dades

Llegiu les dades dels amfiteatres des dels fitxers corresponents.

```r

```

### 3. Generar una taula de resum

Obteniu estadístiques descriptives de les variables numèriques.

```r
# Creem un data.frame d'exemple basat en dades reals


# Calcular estadístiques descriptives
resum <- tab_summary(
  df = amfiteatres_romans_exemples,
  seleccio_variables = starts_with('dimensions'),
  grup_by = 'pais')

print(resum)
```

### 4. Imputació de valors perduts

Si les vostres dades tenen valors perduts, podeu imputar-los utilitzant diferents mètodes.

```r
# Utilitzem el mateix data.frame d'exemple amb valors NA
# Imputar utilitzant la mitjana aritmètica per grup
resultat_imputacio <- imputacio_estadistics(
  df = amfiteatres_romans_exemples,
  seleccio_variables = starts_with('dimensions'),
  grup_by = pais,
  metode_imputacio = 'aritmetica'
)

df_imputat <- resultat_imputacio$imputed_df
print(df_imputat)
```

## Llicència

Aquest projecte es distribueix sota la llicència Apache License (>= 2). Consulteu el fitxer `LICENSE` per a més detalls.