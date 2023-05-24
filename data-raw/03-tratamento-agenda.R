devtools::load_all()

arquivos_eventos <- list.files("inst/dados_html_agenda_complemento/",
           recursive = TRUE,
           full.names = TRUE) |>
  tibble::as_tibble()


agenda_eventos <- arquivos_eventos |>
  tibble::rowid_to_column() |>
  dplyr::group_split(rowid) |>
  purrr::map(.f = ~ extrair_dados_agenda(.x$value),
             .progress = TRUE)

agenda_detalhada_completo <- agenda_eventos |>
  purrr::list_rbind()

salvar_dados_piggyback(agenda_detalhada_completo)
