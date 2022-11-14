devtools::load_all()
base_arquivos_baixados <- list.files("inst/dados_html",
                                     recursive = TRUE,
                                     full.names = TRUE) |>
  tibble::as_tibble() |>
  dplyr::mutate(sem_path = stringr::str_remove_all(value, "inst/dados_html/|.html"),) |>

  tidyr::separate(
    col = sem_path,
    into = c("ano", "mes", "infos_pag"),
    sep = "/"
  ) |>
  tidyr::separate(
    col = infos_pag,
    into = c("comite", "tipo_info", "data_extracao"),
    sep = "-",
    extra = "merge"
  )

base_html_validacao_original <- base_html_validacao

base_html_validada <- base_arquivos_baixados |>
  dplyr::filter(!value %in% base_html_validacao_original$value) |>
  dplyr::mutate(html_valido = purrr::map_lgl(value, html_valido))

base_html_validacao <-
  dplyr::bind_rows(base_html_validacao_original,
                   base_html_validada) |>
  dplyr::distinct()


usethis::use_data(base_html_validacao, overwrite = TRUE)
