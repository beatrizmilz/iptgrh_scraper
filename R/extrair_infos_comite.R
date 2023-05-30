extrair_infos_comite <- function(arquivo) {

  meta <- arquivo |>
    stringr::str_remove("inst/dados_html/") |>
    stringr::str_remove(".html") |>
    tibble::as_tibble() |>
    tidyr::separate(value,
                    into = c("ano", "mes", "comite"),
                    sep = "/") |>
    tidyr::separate(
      comite,
      into = c("sigla_comite", "pagina", "data_coleta"),
      sep = "-",
      extra = "merge"
    )

  dados_comite_brutos <- arquivo |>
    xml2::read_html(caminho_arquivo, encoding = "UTF-8") |>
    rvest::html_element("ul.committee_structure") |>
    rvest::html_elements("li") |>
    rvest::html_text()

  endereco <- dados_comite_brutos |>
    purrr::pluck(1) |>
    stringr::str_remove_all("\t|\r|\n") |>
    stringr::str_squish()

  tel_email_bruto <- dados_comite_brutos |>
    purrr::pluck(2) |>
    stringr::str_split_1("\\|") |>
    stringr::str_squish() |>
    tibble::as_tibble()

  telefone <- tel_email_bruto |>
    dplyr::filter(stringr::str_detect(value, "Tel|tel")) |>
    dplyr::pull(value)

  fax <- tel_email_bruto |>
    dplyr::filter(stringr::str_detect(value, "Fax")) |>
    dplyr::pull(value)

  email <- tel_email_bruto |>
    dplyr::filter(stringr::str_detect(value, "@")) |>
    dplyr::pull(value)

  tibble::tibble(
    meta,
    arquivo = tratar_vazio(arquivo),
    endereco = tratar_vazio(endereco),
    telefone = tratar_vazio(telefone),
    fax = tratar_vazio(fax),
    email = tratar_vazio(email)
  )
}
