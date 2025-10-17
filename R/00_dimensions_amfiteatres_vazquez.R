#' @title Carrega i combina múltiples dataframes de dades d'amfiteatres
#'
#' @description Aquesta funció cerca arxius de dades d'amfiteatres amb un patró específic
#'              en una carpeta donada, els llegeix com a dataframes amb un separador de punt i coma,
#'              i els combina en un sol `tibble` utilitzant `bind_rows`.
#'
#' @details La funció realitza els següents passos:
#'    1. Cerca arxius CSV amb un patró específic a una carpeta donada.
#'    2. Llegeix cada arxiu i els emmagatzema en una llista de dataframes.
#'    3. Renombra i homogeneïtza les columnes de cada dataframe.
#'    4. Calcula noves columnes derivades com la ràtio de l'arena, superfícies i perímetres.
#'    5. Aplica filtres opcionals per tipus d'edifici o selecció de columnes.
#'    6. Combina tots els dataframes de la llista en un únic 'tibble' ordenat.
#'
#' @param retornar_originals Lògic. Si és TRUE, retorna una llista amb els conjunts de dades orginals i el fusionat. Si és FALSE, retorna només el conjunt de dades fusionat.
#' @param filtrar_edifici Lògic. Accepta les següents opcions: amphitheater, arena_hippodrome, arena_stadium, gallo_roman, oval_structure i practice_arena.
#' @param filtrar_provincia Lògic. Accepta noms de provincies altimperials.
#' @param filtrar_pais Lògic. Accepta noms de païssos moderns en anglès.
#' @param seleccionar_columnes Selecciona les columnes desitjades per la sortida del dataframe.
#' @param format_llarg Lògic. Si és TRUE, el dataframe de sortida es retorna en format llarg (pivotat).
#'
#' @return Un dataframe de R (o una llista de dataframes) amb les dades fusionades i estructurades dels amfiteatres romans i republicans.
#'
#' @rdname load_dimensions_vazquez
#' 
#' @import dplyr
#' @import tibble
#' @import rlang
#' @importFrom magrittr %>%
#' @importFrom stats setNames
#' @importFrom purrr map
#' @importFrom tidyr pivot_longer
#' @importFrom crayon bold blue
#'
#' @seealso \code{\link[dplyr]{mutate}}, \code{\link[dplyr]{arrange}}
#' @seealso \code{\link[tibble]{tibble}}
#' @seealso \code{\link[rlang]{enquo}}

#' @examples
#' \dontrun{
#' # Carregar i fusionar tots els dataframes
#' df_complet <- load_dimensions_vazquez()
#'
#' # Carregar i filtrar per tipus d'edifici específic
#' df_filtrat <- load_dimensions_vazquez(
#'  filtrar_edifici = 'amphitheater')
#'
#' # Carregar i seleccionar columnes específiques
#' df_hispania_sel <- load_dimensions_vazquez(
#'  filtrar_edifici = 'amphitheater',
#'  filtrar_provincia = 'hispania',
#'  filtrar_pais = NULL,
#'  seleccionar_columnes = c(contains('amplada'), contains('alcada'), -contains('cavea'), 'bib'),
#'  retornar_originals = FALSE)
#'
#' # Carregar i pivotar les dades a format llarg
#' df_llarg <- load_dimensions_vazquez(format_llarg = TRUE)
#' }
#'
#' @export
load_dimensions_vazquez <- function(
  seleccionar_columnes = NULL,
  filtrar_edifici = NULL,
  filtrar_provincia = NULL,
  filtrar_pais = NULL,
  retornar_originals = FALSE,
  format_llarg = FALSE) 
{

### Double Check 01
  if (!is.null(filtrar_provincia) && !is.null(filtrar_pais)) {
  
    warning(
      "S'han proporcionat filtres per provincia i pais. Ambdues combinacions son incompatibles.")
  
  }

  # Captura d'expressions amb rlang
  seleccionar_columnes <- rlang::enquo(seleccionar_columnes)
  filtrar_provincia_quo <- rlang::enquo(filtrar_provincia)
  filtrar_pais_quo <- rlang::enquo(filtrar_pais)

### Carrega de fitxers
### Obtenir el camí al directori de dades dins del paquet instal·lat
  data_path <- system.file("extdata", "02_data_vazquez", package = "amphidata")
  
### Comprovar si el directori existeix
  if (data_path == "") {
    stop("El directori de dades 'inst/extdata/02_data_vazquez' no s'ha trobat. Assegura't que el paquet esta instal\u00b7lat correctament.")
  }
  
  l_fitxers <- list.files(path = data_path, recursive = TRUE, pattern = 'csv', full.names = TRUE)

### Carrega de dades
  l_data_vazquez <- amphi_read_data(
    l_files = l_fitxers,
    type_file = 'csv',
    sep = ';',
    dec = '.',
    skip_rows = 0,
    na_strings = NULL,
    clean_names = TRUE)

### Assignar noms de cada fitxer
  # Extreu el nom del fitxer per utilitzar-lo com a nom a la llista
  names(l_data_vazquez) <- stringr::str_sub(
    l_fitxers, 
    start = nchar(data_path) + 2, # +2 per la barra '/' i el primer caràcter
    end = -5)
    
  columnes_golvin <- c(
    'index_id', 'nom', 
    'amplada_arena', 'alcada_arena', 'amplada_general', 'alcada_general',
    'nombre_places', 'amplada_cavea')

  columnes_vazquez <- c(
    'golvin_class', 'golvin_name',
    'arena_max', 'arena_min', 'overall_max', 'overall_min',
    'seat_est', 'cavea_wide')

  columnes <- stats::setNames(columnes_vazquez, columnes_golvin)

### Definir aquelles columnes númeriques

  cols_num <- c(
    'amplada_arena', 'alcada_arena', 'amplada_general', 'alcada_general',
    'nombre_places', 'amplada_cavea',  
    'arena_max', 'arena_min', 'overall_max', 'overall_min',
    'seat_est', 'cavea_wide', 'cavea_height', 
    'arena_m2', 'overall_m2', 'cavea_m2',
    'ratio_arena', 'ratio_general', 'ratio_cavea',
    'superficie_arena', 'superfie_general',
    'nombre_places', 'elevation_m',
    'perimetre_arena', 'perimetre_general', 'valor')

  cols_chr <- c(
    'place', 'phase', 'nom', 'hackett_class', 
    'index_id', 'vasa_class', 't_building', 'dinasty_gr', 
    'pais', 'lat', 'long', 'provincia_romana', 'variable', 'bib')

  for(i in seq_along(l_data_vazquez)) {

    l_data_vazquez[[i]] <- l_data_vazquez[[i]] %>%
      dplyr::rename(!!!columnes, pais = .data$mod_country) %>%
      dplyr::mutate(
        provincia_romana = names(l_data_vazquez)[[i]],
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

    # Argument 'filtrar_edifici'
    if (!is.null(filtrar_edifici)) {
      
      l_data_vazquez[[i]] <- l_data_vazquez[[i]] %>%
        dplyr::filter(.data$t_building %in% filtrar_edifici) %>%
        droplevels()
    }

    # Argument 'filtrar_provincia'
    if (!rlang::quo_is_null(filtrar_provincia_quo) && rlang::quo_is_null(filtrar_pais_quo)) {
      
      filter_expr <- filtrar_provincia_quo
      
      if (is.character(rlang::quo_get_expr(filter_expr))) {
        
        pattern <- paste(filtrar_provincia, collapse = '|')
        filter_expr <- rlang::quo(stringr::str_detect(.data$provincia_romana, !!pattern))
      
      }
      
      l_data_vazquez[[i]] <- l_data_vazquez[[i]] %>%
        dplyr::filter(!!filter_expr) %>% 
        droplevels()
    
    }

    # Argument 'filtrar_pais'
    if (!rlang::quo_is_null(filtrar_pais_quo) && rlang::quo_is_null(filtrar_provincia_quo)) {
      
      filter_expr <- filtrar_pais_quo
      
      if (is.character(rlang::quo_get_expr(filter_expr))) {
        
        pattern <- paste(filtrar_pais, collapse = '|')
        filter_expr <- rlang::quo(stringr::str_detect(.data$pais, !!pattern))
      
      }
      
      l_data_vazquez[[i]] <- l_data_vazquez[[i]] %>% 
        dplyr::filter(!!filter_expr) %>% 
        droplevels()
    
    }

    # Argument 'seleccionar_columnes'
    if (!rlang::quo_is_null(seleccionar_columnes)) {
      
      l_data_vazquez[[i]] <- l_data_vazquez[[i]] %>%
        dplyr::select(.data$index_id, .data$nom, .data$t_building, .data$provincia_romana, .data$pais, !!seleccionar_columnes)
    
    }
  }

### Assegura la classe de les columnes clau
  

### Transforma format_ample en format_llarg
    if(isTRUE(format_llarg) & !rlang::quo_is_null(seleccionar_columnes)) {
    # Pivota només les columnes de la selecció de l'usuari que siguin numèriques,
    # evitant errors en intentar combinar diferents tipus de dades.
    l_data_vazquez <- purrr::map(l_data_vazquez, ~ .x %>%
        tidyr::pivot_longer(
          cols = c(!!seleccionar_columnes) & where(is.numeric),
          names_to = 'variable',
          values_to = 'valor',
          values_drop_na = FALSE))
    
    } else if (isTRUE(format_llarg) & rlang::quo_is_null(seleccionar_columnes)) {

      # Double check 02
      stopifnot(all(sapply(l_data_vazquez, ncol) == 32))

      l_data_vazquez <- purrr::map(l_data_vazquez, ~ .x %>%
        tidyr::pivot_longer(
          cols = where(is.numeric),
          names_to = 'variable',
          values_to = 'valor',
          values_drop_na = FALSE))

      # Double check 03
      stopifnot(all(sapply(l_data_vazquez, ncol) == 15))

    } else {

      l_data_vazquez

    }

### 'bind_rows' de la llista
  df_data_vazquez <- data.table::rbindlist(l_data_vazquez) %>%
    tibble::as_tibble() %>%
    dplyr::arrange(.data$index_id, .data$nom, .data$provincia_romana, .data$pais)

  if (retornar_originals) {

    # missatge
    cat(
      crayon::bold(crayon::blue('i')),
      crayon::black(' El llistat de dades ha estat carregat correctament\n'))

    return(list(df_fusionat = df_data_vazquez, l_originals = l_data_vazquez))

  } else {

    # missatge
    cat(
      crayon::bold(crayon::blue('i')),
      crayon::black(' Les dades han estat carregades correctament\n'))
    
    return(df_data_vazquez)
  
  }
}