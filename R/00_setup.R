#' @title Configura els directoris i carrega els paquets del projecte
#' @description Aquest script s'encarrega de la configuració inicial del projecte, 
#' incloent la creació de directoris i la càrrega de paquets necessaris.

# --- Configuració de Directoris ---

#' @title Configura els directoris del projecte
#' @description Aquesta funció comprova si existeixen els directoris clau del projecte i els crea si no existeixen.
#' @param base_path La ruta base del projecte. Per defecte, el directori de treball actual.
#' @param dirs_to_create Un vector de caràcters amb els noms dels directoris a crear.
#' @return No retorna cap valor, però mostra un missatge per cada directori creat.
#' @export
#' @examples
#' # Executar amb els directoris per defecte
#' # amphi_setup_dirs()
amphi_setup_dirs <- function(base_path = getwd(), dirs_to_create = c("data", "R", "output", "capitols")) {
  
  for (dir in dirs_to_create) {
    dir_path <- file.path(base_path, dir)
    if (!dir.exists(dir_path)) {
      dir.create(dir_path, recursive = TRUE)
      message(paste("Directori creat:", dir_path))
    } else {
      message(paste("El directori ja existeix:", dir_path))
    }
  }
}

# --- Càrrega de Paquets ---

#' @title Carrega i instal·la els paquets necessaris
#' @description Aquesta funció utilitza el paquet 'pacman' per comprovar, instal·lar (si cal) i carregar totes les dependències de R per a l'anàlisi. També configura algunes opcions globals de la sessió.
#' @param update_packages Lògic. Si és `TRUE`, intenta actualitzar tots els paquets a la seva darrera versió. Per defecte és `FALSE`.
#' @return No retorna cap valor, però carrega els paquets a l'entorn global.
#' @import pacman
#' @importFrom utils install.packages
#' @importFrom crayon bold blue
#' @seealso \code{\link[pacman]{p_load}}
#' @export
#' @examples
#' # Carregar tots els paquets necessaris
#' # amphi_load_packages()
#' 
#' # Carregar i forçar l'actualització
#' # amphi_load_packages(update_packages = TRUE)
amphi_load_packages <- function(update_packages = FALSE) {

  # Assegura que 'pacman' estigui instal·lat i carregat
  if (!requireNamespace('pacman', quietly = TRUE)) {
  
    utils::install.packages('pacman')
  
  }

  # Configura el repositori de CRAN
  local({
    r <- getOption('repos')
    r['CRAN'] <- 'https://cloud.r-project.org/'
    options(repos = r)
  })

  # Llista de paquets a carregar
  packages_to_load <- c(
    'devtools', 'usethis', 'crayon', 'janitor',
    'dplyr', 'tibble', 'readxl', 'data.table', 'stringr',
    'rlang', 'purrr', 'tidyr', 'missForest', 'psych',
    'DT', 'htmltools', 'knitr', 'webshot', 'webshot2', 'shiny',
    'gtsummary', 'gt', 'gtExtras', 'flextable', 'huxtable',
    'rstatix', 'Hmisc',
    'hexSticker', 'showtext', 'extrafont', 'extrafontdb',
    'sysfonts', 'ggplot2')

  # Carrega o instal·la els paquets amb pacman
  pacman::p_load(
    char = packages_to_load,
    install = TRUE,
    update = update_packages)
  
  # Opcions addicionals de la sessió
  options(width = getOption('width'))

  # missatge
  cat(
    crayon::bold(crayon::blue('i')),
    crayon::black(' Els paquets han estat carregats correctament\n'))

}


#' @title Genera un Hex Sticker per al Paquet 'amphidata'
#' @description Crea un 'hex sticker' personalitzat per al paquet 'amphidata', combinant les paraules 'amphi' i 'data' amb un disseny i colors específics.
#' @details La funció utilitza `ggplot2` per crear el disseny intern de l'hexàgon, que inclou les paraules 'amphi' i 'data' amb fonts personalitzades ('LM Roman' i 'Dancing Script', que es carreguen automàticament des de Google Fonts si no estan disponibles localment). Posteriorment, el paquet `hexSticker` s'encarrega de renderitzar el gràfic en el format hexagonal final. La funció permet una àmplia personalització dels elements visuals com posicions, colors, mides de font i dimensions de sortida.
#' @seealso \code{\link[hexSticker]{sticker}}, \code{\link[ggplot2]{ggplot}}, \code{\link[showtext]{font_add_google}}
#' @rdname amphidata_sticker
#' 
#' @param x_amphi_pos Coordenada X (entre -1 i 1) per a 'amphi'. Valor per defecte: -0.15.
#' @param y_amphi_pos Coordenada Y (entre -1 i 1) per a 'amphi'. Valor per defecte: 0.1.
#' @param x_data_pos Coordenada X (entre -1 i 1) per a 'data'. Valor per defecte: 0.45.
#' @param y_data_pos Coordenada Y (entre -1 i 1) per a 'data'. Valor per defecte: -0.1.
#' @param font1_family Família de la font per a 'amphi'. Valor per defecte: 'LM Roman'.
#' @param font2_family Família de la font per a 'data'. Valor per defecte: 'data_font'.
#' @param color1 Color principal del fons de l'hexàgon. Valor per defecte: `#8E1F2F`.
#' @param color2 Color secundari del text i la vora. Valor per defecte: `#F0BC42`.
#' @param size1_geom Mida (geom size) per a la paraula 'amphi'. Valor per defecte: 35.
#' @param size2_geom Mida (geom size) per a la paraula 'data'. Valor per defecte: 28.
#' @param output_format Format de sortida: 'svg' o 'png'. Valor per defecte: 'png'.
#' @param output_width Amplada del fitxer de sortida (en polzades). Valor per defecte: 4.
#' @param output_height Alçada del fitxer de sortida (en polzades). Valor per defecte: 4.
#' @param filename Nom del fitxer de sortida (sense extensió). Valor per defecte: "hexsticker_amphidata_final".
#' @return Desa un fitxer a la carpeta de treball i retorna de manera invisible el nom del fitxer creat.
#' @export
#'
#' @import hexSticker
#' @import showtext
#' @import sysfonts
#' @import ggplot2
#' @examples
#' \dontrun{
#' # Genera la imatge final de 4x4 polzades (amb els valors per defecte)
#' crear_amphidata_sticker() 
#' }
amphidata_sticker <- function(
    x_amphi_pos = -0.15,
    y_amphi_pos = 0.10,
    x_data_pos = 0.45,
    y_data_pos = -0.10,
    font1_family = "LM Roman",
    font2_family = "data_font",
    color1 = "#8E1F2F",
    color2 = "#F0BC42",
    size1_geom = 35,
    size2_geom = 28,
    output_format = "png",
    output_width = 4, 
    output_height = 4, 
    filename = "amphi_logo") {
  
  # ... (Omissió de la càrrega de fonts i dades de l'hexàgon per concisió)
  if (!("LM Roman" %in% font_families())) {
    tryCatch({font_add(family = "LM Roman", regular = "lmroman10-regular.otf", bold = "lmroman10-bold.otf")}, error = function(e) {warning("LM Roman no s'ha trobat. Utilitzant alternativa de Google Fonts."); font_add_google("Crimson Text", "LM Roman", regular.wt = 400, bold.wt = 700)})
  }
  if (!("data_font" %in% font_families())) {
    font_add_google("Dancing Script", "data_font") 
  }
  showtext_auto()
  
  hex_coords <- data.frame(
    x = c(0.866, 0, -0.866, -0.866, 0, 0.866, 0.866),
    y = c(0.5, 1, 0.5, -0.5, -1, -0.5, 0.5)
  )

  # ... (Omissió de la creació del ggplot p_final_hex per concisió)
  p_final_hex <- ggplot() +
    geom_polygon(data = hex_coords, aes(x = x, y = y), fill = color1, color = color2, linewidth = 2) +
    geom_text(aes(x = x_amphi_pos, y = y_amphi_pos), label = "amphi", family = font1_family, fontface = "bold", color = color2, size = size1_geom, hjust = 0.5, vjust = 0.5) +
    geom_text(aes(x = x_data_pos, y = y_data_pos), label = "data", family = font2_family, color = color2, size = size2_geom, hjust = 0.5, vjust = 0.5) +
    theme_void() +
    theme(panel.background = element_rect(fill = "transparent", color = NA), plot.background = element_rect(fill = "transparent", color = NA)) +
    coord_equal()
  
  # 3. Generar l'Hex Sticker
  # ----------------------------------------------------------------------
  
  if (output_width != output_height) {
    warning("Per evitar la desproporció dels elements (hexàgon), s'ha forçat output_height a ser igual a output_width.")
    output_height <- output_width 
  }
  
  final_filename <- paste0(filename, ".", output_format)
  
  if (tolower(output_format) == "svg") {
    sticker(subplot = p_final_hex, package = "", h_fill = "transparent", h_color = "transparent", 
            s_width = 1.0, s_height = 1.0, s_x = 1.0, s_y = 1.0, dpi = 900,
            filename = final_filename, device = "svg",
            width = output_width, height = output_height)
  } else {
    sticker(subplot = p_final_hex, package = "", h_fill = "transparent", h_color = "transparent", 
            s_width = 1.0, s_height = 1.0, s_x = 1.0, s_y = 1.0, dpi = 900, 
            filename = final_filename,
            width = output_width, height = output_height)
  }
  
  return(invisible(final_filename))
}