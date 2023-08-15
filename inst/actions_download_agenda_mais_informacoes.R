devtools::load_all()

arquivos_baixados <-
  fs::dir_ls("inst/dados_html_agenda_complemento/", glob = "*.html") |>
  tibble::as_tibble() |>
  dplyr::mutate(
    id = stringr::str_remove(value, "-data_download_.*.html") |>
      stringr::str_remove("inst/dados_html_agenda_complemento/id-")
  )


piggyback::pb_download(
  repo = "beatrizmilz/RelatoriosTransparenciaAguaSP",
  tag = "dados",
  file = "agenda_completo.rds"
)


agenda_completo <- readr::read_rds("agenda_completo.rds")


arquivos_completo <- agenda_completo |>
  dplyr::mutate(
    nome_mais_info = stringr::str_remove(link_mais_informacoes, "https://sigrh.sp.gov.br/") |>
      stringr::str_replace_all(pattern = "/", "_") ,
    caminho_baixar = glue::glue(
      "inst/dados_html_agenda_complemento/id-{nome_mais_info}-data_download_{Sys.Date()}.html"
    )
  ) |>
  dplyr::select(link_mais_informacoes, caminho_baixar) |>
  dplyr::distinct(link_mais_informacoes, .keep_all = TRUE)


arquivos_baixar <- arquivos_completo |>
  dplyr::filter(!stringr::str_detect(caminho_baixar, paste0(arquivos_baixados$id, collapse = "|"))) |>
  tibble::rowid_to_column() |>
  dplyr::group_split(rowid)


possibly_download_html <- purrr::possibly(download_html, otherwise = "ERRO")

purrr::map(
  arquivos_baixar,
  ~ possibly_download_html(
    url = .x$link_mais_informacoes,
    caminho_salvar = .x$caminho_baixar
  ),
  .progress = TRUE
)


