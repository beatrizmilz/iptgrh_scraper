devtools::load_all()

arquivos_eventos <- list.files("inst/dados_html_agenda_complemento/",
           recursive = TRUE,
           full.names = TRUE) |>
  tibble::as_tibble()


caminho_arquivo <- arquivos_eventos |>
  dplyr::slice_sample(n = 1) |>
  dplyr::pull(value)
