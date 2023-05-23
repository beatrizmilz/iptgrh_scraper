extrair_dados_agenda <- function(caminho_arquivo) {
  nome_arquivo <- basename(caminho_arquivo)

  id_arquivo <- stringr::str_extract(nome_arquivo, "id-.*-data") |>
    stringr::str_remove_all("id-|-data")

  data_download <-
    stringr::str_extract(nome_arquivo, "-data.*.html") |>
    stringr::str_remove_all("-data|.html|_download_") |>
    as.Date()

  conteudo_html <-
    xml2::read_html(caminho_arquivo, encoding = "UTF-8") |>
    rvest::html_nodes("div.col_right") |>
    purrr::pluck(1)

  # titulo do evento
  evento_titulo <- conteudo_html |>
    rvest::html_nodes("h1") |>
    rvest::html_text()

  conteudo_txt <- conteudo_html |>
    rvest::html_text() |>
    tibble::as_tibble() |>
    dplyr::mutate(value = stringr::str_split(value, pattern = "\\n")) |>
    tidyr::unnest(cols = c(value)) |>
    dplyr::mutate(value = stringr::str_remove_all(value, "\r")) |>
    dplyr::filter(value != "")

  # data_do_evento
 evento_data <- conteudo_txt |>
    dplyr::filter(stringr::str_detect(value, "Data")) |>
    dplyr::slice(1) |>
    dplyr::pull(value)

  # local_do_evento
  evento_local <- conteudo_txt |>
    dplyr::filter(stringr::str_detect(value, "Local")) |>
    dplyr::slice(1) |>
    dplyr::pull(value)


  # horário
  evento_horario <- conteudo_txt |>
    dplyr::filter(stringr::str_detect(value, "Horário")) |>
    dplyr::slice(1) |>
    dplyr::pull(value)


  # descricao
  evento_descricao <- conteudo_txt |>
    dplyr::filter(stringr::str_detect(value, "Descrição")) |>
    dplyr::slice(1) |>
    dplyr::pull(value)

# anexos
  evento_arquivos <- conteudo_html |>
    rvest::html_nodes("a") |>
    rvest::html_attr("href") |>
    tibble::as_tibble() |>
    dplyr::filter(!stringr::str_detect(value, "sharelinkemails?"),
                  value != "https://twitter.com/share") |>
    dplyr::slice(-dplyr::n()) |>
    dplyr::mutate(
      value = dplyr::if_else(stringr::str_starts(value, "/public/"),
                             paste0("https://sigrh.sp.gov.br/", value),
                             value)
    ) |>
    dplyr::rename(arquivos = value) |>
    tidyr::nest(arquivos = arquivos)


  # tabela final
  tibble::tibble(caminho_arquivo,
                 id_arquivo,
                 data_download,
                 evento_titulo,
                 evento_data,
                 evento_horario,
                 evento_local,
                 evento_descricao,
                 evento_arquivos)
}
