# Unificar e exportar bases
unificar_base <- function(conteudo, agencia = FALSE) {
  arquivos_completos <-
    list.files(
      "inst/dados_rds",
      pattern = ".Rds",
      full.names = TRUE,
      recursive = TRUE
    ) |>
    tibble::enframe() |>
    dplyr::filter(stringr::str_detect(value, conteudo))

  if (agencia == TRUE) {
    arquivos_completos_filtrados <- arquivos_completos |>
      dplyr::filter(stringr::str_detect(value, "agencia"))
  } else{
    arquivos_completos_filtrados <- arquivos_completos |>
      dplyr::filter(!stringr::str_detect(value, "agencia"))
  }

  arquivos_completos_filtrados$value |>
    purrr::map_dfr(readr::read_rds)
}
