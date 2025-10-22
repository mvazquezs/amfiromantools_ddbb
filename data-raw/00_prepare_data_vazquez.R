library(dplyr)
library(tibble)
library(stringr)
library(usethis)
library(purrr)
library(janitor)

### Defineix els mapatges de columnes (com a load_dimensions_vazquez)
  cols_ori_88 <- c(
    'index_id', 'nom',
    'amplada_arena', 'alcada_arena', 'amplada_general', 'alcada_general',
    'nombre_places', 'amplada_cavea')

  cols_ori <- c(
    'golvin_class', 'golvin_name',
    'arena_max', 'arena_min', 'overall_max', 'overall_min',
    'seat_est', 'cavea_wide')

  cols <- stats::setNames(cols_ori, cols_ori_88)

### Defineix les columnes numèriques i de caràcter per a la conversió de tipus
  cols_num <- c(
    'amplada_arena', 'alcada_arena', 'amplada_general', 'alcada_general',
    'nombre_places', 'amplada_cavea',
    'arena_max', 'arena_min', 'overall_max', 'overall_min',
    'seat_est', 'cavea_wide', 'cavea_height',
    'arena_m2', 'overall_m2', 'cavea_m2',
    'ratio_arena', 'ratio_general', 'ratio_cavea',
    'superficie_arena', 'superficie_general',
    'nombre_places', 'elevation_m',
    'perimetre_arena', 'perimetre_general', 'valor')

  cols_chr <- c(
    'place', 'phase', 'nom', 'hackett_class',
    'index_id', 'vasa_class', 't_building', 'dinasty_gr',
    'pais', 'lat', 'long', 'provincia_romana', 'variable', 'bib')

### --- Càrrega de dades i processament inicial ---
### Aquest script assumeix que s'executa des de l'arrel del paquet.
### Els CSVs originals es troben a inst/extdata/01_data_orui.
  l_dir <- file.path('inst', 'extdata', '01_data_ori')

if (!dir.exists(l_dir)) {
  
  stop('Directori de dades originals `inst/extdata/02_data_ori` no trobat. Assegura la ubicació dels arxius originals.')

}

  l_fitxers <- list.files(
    path = l_dir, 
    recursive = TRUE, 
    pattern = '\\.csv$', 
    full.names = TRUE)[-1]

### Carrega les dades utilitzant la funció exportada del paquet.
### Cal assegurar-se que el paquet està carregat (p.ex. amb devtools::load_all()).
  l_data_ori <- amphi_read_data(
    l_files = l_fitxers,
    type_file = 'csv',
    sep = ';',
    dec = '.',
    skip_rows = 0,
    na_strings = NULL,
    clean_names = TRUE)

### Assigna noms als elements de la llista (p. ex., 'hispania', 'panonia')
  l_names <- stringr::str_sub(
    l_fitxers,
    start = nchar(l_dir) + 17, # +17 per evitar ruta i data del nom dels arxius
    end = -5) # -5 per a '.csv'
  
  names(l_data_ori) <- l_names

### Aplica les transformacions inicials (canvi de nom, càlcul de columnes derivades, conversió de tipus)
### Aquesta part es mou de load_dimensions_vazquez.R
  l_df_ori <- purrr::map2(
    l_data_ori, 
    names(l_data_ori), function(df, name) {
      df %>%
        dplyr::rename(!!!cols, pais = mod_country) %>%
        dplyr::mutate(
          provincia_romana = name, # Utilitza el nom de la llista aquí
          ratio_arena = .data$amplada_arena / .data$alcada_arena,
          ratio_general = .data$amplada_general / .data$alcada_general,
          superficie_arena = (.data$amplada_arena / 2) * (.data$alcada_arena / 2) * pi,
          superficie_general = (.data$amplada_general / 2) * (.data$alcada_general / 2) * pi,
          superficie_cavea = .data$superficie_general - .data$superficie_arena,
          perimetre_arena = pi * (.data$amplada_arena / 2 + .data$alcada_arena / 2),
          perimetre_general = pi * (.data$amplada_general / 2 + .data$alcada_general / 2),
          ratio_cavea = .data$superficie_arena / .data$superficie_general) %>%
        dplyr::mutate(
          across(any_of(cols_num), as.double)) %>%
        dplyr::mutate(
          across(any_of(cols_chr), as.character))
  
  })