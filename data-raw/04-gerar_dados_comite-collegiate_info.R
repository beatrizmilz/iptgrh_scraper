devtools::load_all()

arquivos_distintos <- base_html_validacao |>
  dplyr::filter(html_valido == TRUE) |>
  dplyr::select(value, ano, mes, comite) |>
  dplyr::distinct(ano, mes, comite, .keep_all = TRUE)

infos_comite_bruto <- arquivos_distintos |>
  tibble::rowid_to_column() |>
  dplyr::group_split(rowid) |>
  purrr::map(~extrair_infos_comite(.x$value), .progress = TRUE)

infos_comite_completo <- infos_comite_bruto |>
  purrr::list_rbind() |>
  dplyr::select(-pagina) |>
  dplyr::arrange(ano, mes, sigla_comite)

salvar_dados_piggyback(infos_comite_completo)
