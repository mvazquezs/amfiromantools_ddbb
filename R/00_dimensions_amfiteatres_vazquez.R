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
#' @param filtrar_edifici Lògic. Accepta les següents opcions: amphitheater, arena_hippodrome, arena_stadium, gallo_roman, oval_structure i practice_arena.
#' @param filtrar_provincia Lògic. Accepta noms de provincies altimperials.
#' @param filtrar_pais Lògic. Accepta noms de païssos moderns en anglès.
#' @param seleccionar_columnes Selecciona les columnes desitjades per la sortida del dataframe.
#' @param format_llarg Lògic. Si és TRUE, el dataframe de sortida es retorna en format llarg (pivotat).
#'
#' @return Un dataframe de R amb les dades fusionades i estructurades dels amfiteatres romans i republicans.
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
#'  seleccionar_columnes = c(contains('amplada'), contains('alcada'), -contains('cavea'), 'bib'))
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
  format_llarg = FALSE,
  retornar_originals = FALSE)
  
{

### Double Check 01
  if (!is.null(filtrar_provincia) && !is.null(filtrar_pais)) {
  
    warning(
      'Ambdues combinacions son incompatibles.')
  
  }

### Captura d'expressions amb rlang
  seleccionar_columnes <- rlang::enquo(seleccionar_columnes)
  filtrar_provincia_quo <- rlang::enquo(filtrar_provincia)
  filtrar_pais_quo <- rlang::enquo(filtrar_pais)

### Carrega de fitxers
  base::load('R/sysdata.rda')[1]


### Arguments de filtratge
  for(i in seq_along(l_df_ori)) {
  
    ### Argument 'filtrar_edifici'
      if (!is.null(filtrar_edifici)) {
      
        l_df_ori[[i]] <- l_df_ori[[i]] %>%
          dplyr::filter(.data$t_building %in% filtrar_edifici) %>%
          droplevels()
      
      }

    ### Argument 'filtrar_provincia'
      if (!rlang::quo_is_null(filtrar_provincia_quo) && rlang::quo_is_null(filtrar_pais_quo)) {
      
        filter_expr <- filtrar_provincia_quo
      
        if (is.character(rlang::quo_get_expr(filter_expr))) {
          
          pattern <- paste(filtrar_provincia, collapse = '|')
          filter_expr <- rlang::quo(stringr::str_detect(.data$provincia_romana, !!pattern))
        
        }
      
        l_df_ori[[i]] <- l_df_ori[[i]] %>%
          dplyr::filter(!!filter_expr) %>% 
          droplevels()
      
      }

    ### Argument 'filtrar_pais'
      if (!rlang::quo_is_null(filtrar_pais_quo) && rlang::quo_is_null(filtrar_provincia_quo)) {
        
        filter_expr <- filtrar_pais_quo
        
        if (is.character(rlang::quo_get_expr(filter_expr))) {
          
          pattern <- paste(filtrar_pais, collapse = '|')
          filter_expr <- rlang::quo(stringr::str_detect(.data$pais, !!pattern))
        
        }
        
        l_df_ori[[i]] <- l_df_ori[[i]] %>% 
          dplyr::filter(!!filter_expr) %>% 
          droplevels()
      
      }

    ### Argument 'seleccionar_columnes'
      if (!rlang::quo_is_null(seleccionar_columnes)) {
        
        l_df_ori[[i]] <- l_df_ori[[i]] %>%
          dplyr::select(.data$index_id, .data$nom, .data$t_building, .data$provincia_romana, .data$pais, !!seleccionar_columnes)
      
      }
  }

### Transforma format_ample en format_llarg
  if(isTRUE(format_llarg) & !rlang::quo_is_null(seleccionar_columnes)) {
  
    l_df_ori <- purrr::map(l_df_ori, ~ .x %>%
        tidyr::pivot_longer(
          cols = c(!!seleccionar_columnes) & where(is.numeric),
          names_to = 'variable',
          values_to = 'valor',
          values_drop_na = FALSE))
    
    } else if (isTRUE(format_llarg) & rlang::quo_is_null(seleccionar_columnes)) {

    ### Double check 02
      stopifnot(all(sapply(l_df_ori, ncol) == 32))

      l_df_ori <- purrr::map(l_df_ori, ~ .x %>%
        tidyr::pivot_longer(
          cols = where(is.numeric),
          names_to = 'variable',
          values_to = 'valor',
          values_drop_na = FALSE))

      ### Double check 03
      stopifnot(all(sapply(l_df_ori, ncol) == 15))

    } else {

      l_df_ori

    }

### 'bind_rows' de la llista
  df_ori <- data.table::rbindlist(l_df_ori) %>%
    tibble::as_tibble() %>%
    dplyr::arrange(.data$index_id, .data$nom, .data$provincia_romana, .data$pais)

### missatge
  cat(
    crayon::bold(crayon::blue('i')),
    crayon::black(' Les dades han estat carregades correctament\n'))
    
  return(df_ori)
  
}