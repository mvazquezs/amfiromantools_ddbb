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
    load_dimensions_vazquez(
      filtrar_edifici = 'amphitheater',
      filtrar_provincia = c('hispania', 'panonia'),
      seleccionar_columnes = c(contains('amplada'), contains('alcada'), -contains('cavea'), 'bib'))
```

i  Els paquets han estat carregats correctament
i  Les dades ha estat carregat correctament

```
#> Warning in to_md(structure(list(index_id = c("index_id", "#010", "#010", : Couldn't print whole table in max_width = 80 characters.
#> Printing 8/10 columns.
```

-------------------------------------------------------------------------
 **inde** **nom**  **t_bu** **prov** **pais** **ampl** **ampl** **alca** 
 **x_id**          **ildi** **inci**          **ada_** **ada_** **da_g** 
                   **ng**   **a_ro**          **gene** **aren** **ener** 
                            **mana**           **ral**    **a**   **al** 
--------- -------- -------- -------- -------- -------- -------- -------- 
 #010     CARMO    amphithe hispania spain         108     58.8       98 
                   ater     _baetica                                     
                                                                         
 #010     CARMO    amphithe hispania spain         130     58.8      111 
                   ater     _baetica                                     
                                                                         
 #010     CARMO    amphithe hispania spain                 58.8          
                   ater     _baetica                                     
                                                                         
 #010     CARMO    amphithe hispania spain         131       58      111 
                   ater     _baetica                                     
                                                                         
 #010     CARMO    amphithe hispania spain         108     58.8       98 
                   ater     _baetica                                     
                                                                         
 #010     CARMO    amphithe hispania spain         108       58       98 
                   ater     _baetica                                     
                                                                         
 #010     CARMO    amphithe hispania spain          90       58          
                   ater     _baetica                                     
                                                                         
 #010     CARMO    amphithe hispania spain         131       58      111 
                   ater     _baetica                                     
                                                                         
 #010     CARMO    amphithe hispania spain         131               111 
                   ater     _baetica                                     
                                                                         
 #010     CARMO    amphithe hispania spain                               
                   ater     _baetica                                     
                                                                         
 #010     CARMO    amphithe hispania spain                   55          
                   ater     _baetica                                     
                                                                         
 #011     UCUBI    amphithe hispania spain                   35          
                   ater     _baetica                                     
                                                                         
 #077     AUGUSTA  amphithe hispania spain         126     64.5      103 
          EMERITA  ater     _lusitan                                     
                            ia                                           
                                                                         
 #077     AUGUSTA  amphithe hispania spain         126     64.5      103 
          EMERITA  ater     _lusitan                                     
                            ia                                           
                                                                         
 #077     AUGUSTA  amphithe hispania spain         126               103 
          EMERITA  ater     _lusitan                                     
                            ia                                           
                                                                         
 #077     AUGUSTA  amphithe hispania spain         126       65      103 
          EMERITA  ater     _lusitan                                     
                            ia                                           
                                                                         
 #077     AUGUSTA  amphithe hispania spain                               
          EMERITA  ater     _lusitan                                     
                            ia                                           
                                                                         
 #077     AUGUSTA  amphithe hispania spain                               
          EMERITA  ater     _lusitan                                     
                            ia                                           
                                                                         
 #077     AUGUSTA  amphithe hispania spain                 64.5          
          EMERITA  ater     _lusitan                                     
                            ia                                           
                                                                         
 #077     AUGUSTA  amphithe hispania spain         126               103 
          EMERITA  ater     _lusitan                                     
                            ia                                           
                                                                         
 #077     AUGUSTA  amphithe hispania spain         126       64      102 
          EMERITA  ater     _lusitan                                     
                            ia                                           
                                                                         
 #077     AUGUSTA  amphithe hispania spain         126     64.5      103 
          EMERITA  ater     _lusitan                                     
                            ia                                           
                                                                         
 #077     AUGUSTA  amphithe hispania spain         126       64      102 
          EMERITA  ater     _lusitan                                     
                            ia                                           
                                                                         
 #088     SEGOBRIG amphithe hispania spain          74     41.7     66.2 
          A        ater     _tarraco                                     
                            nensis                                       
                                                                         
 #088     SEGOBRIG amphithe hispania spain          74     41.7     66.2 
          A        ater     _tarraco                                     
                            nensis                                       
                                                                         
 #088     SEGOBRIG amphithe hispania spain          75       41       69 
          A        ater     _tarraco                                     
                            nensis                                       
                                                                         
 #088     SEGOBRIG amphithe hispania spain                               
          A        ater     _tarraco                                     
                            nensis                                       
                                                                         
 #088     SEGOBRIG amphithe hispania spain                               
          A        ater     _tarraco                                     
                            nensis                                       
                                                                         
 #088     SEGOBRIG amphithe hispania spain          75              68.5 
          A        ater     _tarraco                                     
                            nensis                                       
                                                                         
 #088     SEGOBRIG amphithe hispania spain          75       47       64 
          A        ater     _tarraco                                     
                            nensis                                       
                                                                         
 #088     SEGOBRIG amphithe hispania spain          75       40          
          A        ater     _tarraco                                     
                            nensis                                       
                                                                         
 #093     EMPORIAE amphithe hispania spain          93              44.1 
                   ater     _tarraco                                     
                            nensis                                       
                                                                         
 #093     EMPORIAE amphithe hispania spain          93              44.1 
                   ater     _tarraco                                     
                            nensis                                       
                                                                         
 #093     EMPORIAE amphithe hispania spain          88       75       56 
                   ater     _tarraco                                     
                            nensis                                       
                                                                         
 #093     EMPORIAE amphithe hispania spain                               
                   ater     _tarraco                                     
                            nensis                                       
                                                                         
 #093     EMPORIAE amphithe hispania spain                               
                   ater     _tarraco                                     
                            nensis                                       
                                                                         
 #093     EMPORIAE amphithe hispania spain          88                56 
                   ater     _tarraco                                     
                            nensis                                       
                                                                         
 #093     EMPORIAE amphithe hispania spain          86       71       54 
                   ater     _tarraco                                     
                            nensis                                       
                                                                         
 #101     CONIMBRI amphithe hispania portugal       98       48       86 
          GA       ater     _lusitan                                     
                            ia                                           
                                                                         
 #101     CONIMBRI amphithe hispania portugal       94       54       80 
          GA       ater     _lusitan                                     
                            ia                                           
                                                                         
 #101     CONIMBRI amphithe hispania portugal                            
          GA       ater     _lusitan                                     
                            ia                                           
                                                                         
 #101     CONIMBRI amphithe hispania portugal       94                80 
          GA       ater     _lusitan                                     
                            ia                                           
                                                                         
 #101     CONIMBRI amphithe hispania portugal       94       54       80 
          GA       ater     _lusitan                                     
                            ia                                           
                                                                         
 #101     CONIMBRI amphithe hispania portugal       98                86 
          GA       ater     _lusitan                                     
                            ia                                           
                                                                         
 #139     TARRACO  amphithe hispania spain         130       62      102 
                   ater     _tarraco                                     
                            nensis                                       
                                                                         
 #139     TARRACO  amphithe hispania spain         130       62      102 
                   ater     _tarraco                                     
                            nensis                                       
                                                                         
 #139     TARRACO  amphithe hispania spain         110     61.5     86.5 
                   ater     _tarraco                                     
                            nensis                                       
                                                                         
 #139     TARRACO  amphithe hispania spain         148     84.5      119 
                   ater     _tarraco                                     
                            nensis                                       
                                                                         
 #139     TARRACO  amphithe hispania spain         148       84      119 
                   ater     _tarraco                                     
                            nensis                                       
                                                                         
 #139     TARRACO  amphithe hispania spain                               
                   ater     _tarraco                                     
                            nensis                                       
                                                                         
 #139     TARRACO  amphithe hispania spain                               
                   ater     _tarraco                                     
                            nensis                                       
                                                                         
 #139     TARRACO  amphithe hispania spain         148               119 
                   ater     _tarraco                                     
                            nensis                                       
                                                                         
 #139     TARRACO  amphithe hispania spain          95       62     69.5 
                   ater     _tarraco                                     
                            nensis                                       
                                                                         
 #139     TARRACO  amphithe hispania spain         130               102 
                   ater     _tarraco                                     
                            nensis                                       
                                                                         
 #175     ITALICA  amphithe hispania spain         156               134 
                   ater     _baetica                                     
                                                                         
 #175     ITALICA  amphithe hispania spain         153               128 
                   ater     _baetica                                     
                                                                         
 #175     ITALICA  amphithe hispania spain         152               128 
                   ater     _baetica                                     
                                                                         
 #175     ITALICA  amphithe hispania spain         153     70.6      131 
                   ater     _baetica                                     
                                                                         
 #175     ITALICA  amphithe hispania spain         156     71.2      134 
                   ater     _baetica                                     
                                                                         
 #175     ITALICA  amphithe hispania spain         157       72      134 
                   ater     _baetica                                     
                                                                         
 #175     ITALICA  amphithe hispania spain                               
                   ater     _baetica                                     
                                                                         
 #175     ITALICA  amphithe hispania spain                               
                   ater     _baetica                                     
                                                                         
 #175     ITALICA  amphithe hispania spain         156               134 
                   ater     _baetica                                     
                                                                         
 #175     ITALICA  amphithe hispania spain         160       70      136 
                   ater     _baetica                                     
                                                                         
 #175     ITALICA  amphithe hispania spain         160               137 
                   ater     _baetica                                     
                                                                         
 #175     ITALICA  amphithe hispania spain         156               134 
                   ater     _baetica                                     
                                                                         
          ASTIGI   amphithe hispania spain         133       73      106 
                   ater     _baetica                                     
                                                                         
          ASTIGI   amphithe hispania spain         130     70.9      107 
                   ater     _baetica                                     
                                                                         
          ASTIGI   amphithe hispania spain         130               107 
                   ater     _baetica                                     
                                                                         
          BARCINO  amphithe hispania spain         117       60       93 
                   ater     _tarraco                                     
                            nensis                                       
                                                                         
          BARCINO  amphithe hispania spain         117       65       93 
                   ater     _tarraco                                     
                            nensis                                       
                                                                         
          BARCINO  amphithe hispania spain         117       65       93 
                   ater     _tarraco                                     
                            nensis                                       
                                                                         
          BARCINO  amphithe hispania spain         117                98 
                   ater     _tarraco                                     
                            nensis                                       
                                                                         
          BOBADELA amphithe hispania portugal              49.5          
                   ater     _lusitan                                     
                            ia                                           
                                                                         
          BOBADELA amphithe hispania portugal                            
                   ater     _lusitan                                     
                            ia                                           
                                                                         
          BOBADELA amphithe hispania portugal                            
                   ater     _lusitan                                     
                            ia                                           
                                                                         
          BOBADELA amphithe hispania portugal                            
                   ater     _lusitan                                     
                            ia                                           
                                                                         
          BOBADELA amphithe hispania portugal                50          
                   ater     _lusitan                                     
                            ia                                           
                                                                         
          BRACARA  amphithe hispania portugal      132              82.5 
          AUGUSTA  ater     _tarraco                                     
                            nensis                                       
                                                                         
          BRACARA  amphithe hispania portugal      132                83 
          AUGUSTA  ater     _tarraco                                     
                            nensis                                       
                                                                         
          BRACARA  amphithe hispania portugal      132              82.5 
          AUGUSTA  ater     _tarraco                                     
                            nensis                                       
                                                                         
          CARTHAGO amphithe hispania spain        96.6     56.5     77.8 
          NOVA     ater     _tarraco                                     
                            nensis                                       
                                                                         
          CARTHAGO amphithe hispania spain        96.6     56.5     77.8 
          NOVA     ater     _tarraco                                     
                            nensis                                       
                                                                         
          CARTHAGO amphithe hispania spain                               
          NOVA     ater     _tarraco                                     
                            nensis                                       
                                                                         
          CARTHAGO amphithe hispania spain                               
          NOVA     ater     _tarraco                                     
                            nensis                                       
                                                                         
          CARTHAGO amphithe hispania spain                               
          NOVA     ater     _tarraco                                     
                            nensis                                       
                                                                         
          CARTHAGO amphithe hispania spain                   69          
          NOVA     ater     _tarraco                                     
                            nensis                                       
                                                                         
          CARTHAGO amphithe hispania spain                               
          NOVA     ater     _tarraco                                     
                            nensis                                       
                                                                         
          CARTHAGO amphithe hispania spain                               
          NOVA     ater     _tarraco                                     
                            nensis                                       
                                                                         
          CASTULO  amphithe hispania spain                               
                   ater     _tarraco                                     
                            nensis                                       
                                                                         
          CORDUBA  amphithe hispania spain         178               154 
                   ater     _baetica                                     
                                                                         
          CORDUBA  amphithe hispania spain         178       96      154 
                   ater     _baetica                                     
                                                                         
          CORDUBA  amphithe hispania spain                   62          
                   ater     _baetica                                     
                                                                         
          CORDUBA  amphithe hispania spain         178               147 
                   ater     _baetica                                     
                                                                         
          CORDUBA  amphithe hispania spain         100                   
                   ater     _baetica                                     
                                                                         
          CORDUBA  amphithe hispania spain                               
                   ater     _baetica                                     
                                                                         
          CORDUBA  amphithe hispania spain         178               140 
                   ater     _baetica                                     
                                                                         
          CORDUBA  amphithe hispania spain         178               140 
                   ater     _baetica                                     
                                                                         
          EBORA    amphithe hispania portugal       80       45       65 
                   ater     _lusitan                                     
                            ia                                           
                                                                         
          EBORA    amphithe hispania portugal       80                65 
                   ater     _lusitan                                     
                            ia                                           
                                                                         
          FLAVIUM  amphithe hispania spain                               
          CAPARENS ater     _lusitan                                     
          E                 ia                                           
                                                                         
          FLAVIUM  amphithe hispania spain          69                51 
          CAPARENS ater     _lusitan                                     
          E                 ia                                           
                                                                         
          GADES    amphithe hispania spain                               
                   ater     _baetica                                     
                                                                         
          HISPALIS amphithe hispania spain                               
                   ater     _baetica                                     
                                                                         
          IULIA    amphithe hispania spain          72                65 
          UGULTUNI ater     _baetica                                     
          A                                                              
                                                                         
          IULIA    amphithe hispania spain                   69          
          VIRTUS   ater     _baetica                                     
                                                                         
          LEGIO    amphithe hispania spain          90       60       70 
                   ater     _tarraco                                     
                            nensis                                       
                                                                         
          LEGIO    amphithe hispania spain          90                70 
                   ater     _tarraco                                     
                            nensis                                       
                                                                         
          SISAPO   amphithe hispania spain                   65          
                   ater     _baetica                                     
                                                                         
          VERGIS   amphithe hispania spain                               
                   ater     _baetica                                     
-------------------------------------------------------------------------


