# Unificar e exportar bases
unificar_base <- function(conteudo) {
  arquivos_completos <-
    list.files(
      "inst/dados_rds",
      pattern = ".Rds",
      full.names = TRUE,
      recursive = TRUE
    ) |>
    tibble::enframe() |>
    dplyr::filter(stringr::str_detect(value, conteudo))

  arquivos_completos$value |>
    purrr::map_dfr(readr::read_rds)
}
