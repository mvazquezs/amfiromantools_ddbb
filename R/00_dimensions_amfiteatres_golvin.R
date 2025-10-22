#' @title Extracció, estructuració i fusió de dades d'amfiteatres romans
#' 
#' @description Aquesta funció processa dades d'amfiteatres romans i republicans extretes de taules,
#' calcula mètriques derivades i fusiona les dades en un únic dataframe.
#' 
#' @details La funció realitza els següents passos:
#' 1. Extreu les dades de les taules originals de Golvin (1988).
#' 2. Calcula mètriques derivades com ràtios, superfícies i perímetres.
#' 3. Fusiona totes les taules en un únic `tibble`.
#' 4. Permet filtrar, seleccionar i transformar les dades.
#' 
#' @param filtrar_provincia Lògic. Accepta noms de provincies altimperials.
#' @param filtrar_pais Lògic. Accepta noms de païssos moderns en anglès.
#' @param seleccionar_columnes Selecciona les columnes desitjades per la sortida del dataframe.
#' @param format_llarg Lògic. Si és TRUE, el dataframe de sortida es retorna en format llarg (pivotat).
#' 
#' @return Un `tibble` amb les dades fusionades i estructurades.
#'
#' @import dplyr
#' @import tibble
#' @import rlang
#' @importFrom magrittr %>%
#' @importFrom purrr map
#' @importFrom tidyr pivot_longer
#' @importFrom crayon bold blue
#' @seealso \code{\link[dplyr]{mutate}}
#' @seealso \code{\link[tidyr]{pivot_longer}}
#' 
#' @examples
#' # Carregar totes les dades
#' df_complet <- load_dimensions_golvin()
#'
#' # Carregar dades filtrant per província i seleccionant columnes
#' df_hispania <- load_dimensions_golvin(
#'   filtrar_provincia = 'hispania',
#'   seleccionar_columnes = c(nom, pais, amplada_general, alcada_general))
#'
#' # Carregar dades en format llarg
#' df_llarg <- load_dimensions_golvin(
#'   seleccionar_columnes = c(amplada_arena, alcada_arena),
#'   format_llarg = TRUE)
#'
#' @rdname load_dimensions_golvin
#' @export
load_dimensions_golvin <- function(
  filtrar_provincia = NULL,
  filtrar_pais = NULL,
  seleccionar_columnes = NULL,
  format_llarg = FALSE) {

### Double Check 01
  if(!is.null(filtrar_provincia) && !is.null(filtrar_pais)) {
  
     warning(
      'Ambdues combinacions son incompatibles.')
  
  }

  seleccionar_columnes <- rlang::enquo(seleccionar_columnes)
  filtrar_provincia_quo <- rlang::enquo(filtrar_provincia)
  filtrar_pais_quo <- rlang::enquo(filtrar_pais)

### Carrega de fitxers
  base::load('R/sysdata.rda')[2]

### Argumentari de la funció    
  for(i in seq_along(l_df_ori_88)) {
 
    ### Argument 'filtrar_provincia'
      if(!is.null(filtrar_provincia) & is.null(filtrar_pais)) {

        l_df_ori_88[[i]] <- l_df_ori_88[[i]] %>%
          dplyr::filter(
            stringr::str_detect(.data$provincia_romana, paste(filtrar_provincia, collapse = '|'))) %>%
            droplevels()
  
      }

    ### Argument 'filtrar_pais'
      if(!is.null(filtrar_pais) & is.null(filtrar_provincia)) {

        l_df_ori_88[[i]] <- l_df_ori_88[[i]] %>%
          dplyr::filter(
            stringr::str_detect(.data$pais, paste(filtrar_pais, collapse = '|'))) %>%
            droplevels()
  
      }

      ### Argument 'seleccionar_columnes'
        if(!rlang::quo_is_null(seleccionar_columnes)) {

          l_df_ori_88[[i]] <- l_df_ori_88[[i]] %>%
            dplyr::select(.data$index_id, .data$nom, .data$provincia_romana, .data$pais, !!seleccionar_columnes)

        }
    }

### Transforma format_ample en format_llarg
   if(isTRUE(format_llarg) & !rlang::quo_is_null(seleccionar_columnes)) {
    
    l_df_ori_88 <- purrr::map(l_df_ori_88, ~ .x %>%
        tidyr::pivot_longer(
          cols = c(!!seleccionar_columnes) & where(is.numeric),
          names_to = 'variable',
          values_to = 'valor',
          values_drop_na = FALSE))
    
    } else if (isTRUE(format_llarg) & rlang::quo_is_null(seleccionar_columnes)) {
      
    ### Double check 02
      stopifnot(all(sapply(l_df_ori_88, ncol) == 19))

      l_df_ori_88 <- purrr::map(l_df_ori_88, ~ .x %>%
        tidyr::pivot_longer(
          cols = where(is.numeric),
          names_to = 'variable',
          values_to = 'valor',
          values_drop_na = FALSE))

    ### Double check 03
      stopifnot(all(sapply(l_df_ori_88, ncol) == 7))

    } else {

      l_df_ori_88
    
    }

### Fusió de les dues taules per la columna 'nom' i 'original_id'
  df_ori_88 <- dplyr::bind_rows(l_df_ori_88) %>%
    tibble::as_tibble() %>%
    dplyr::arrange(.data$index_id, .data$nom,  .data$provincia_romana, .data$pais)


### missatge
  cat(
    crayon::bold(crayon::blue('i')),
    crayon::black(' Les dades han estat carregades correctament\n'))

    return(df_ori_88)

}