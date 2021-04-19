listar_arquivos <- function(path = "inst/dados_html/",
                        ano_buscar = 2021,
                        mes_buscar = 1:12,
                        pagina_buscar = "atas") {
  df_arquivos <-
    tibble::tibble(arquivo = fs::dir_ls(
      path,
      recurse = TRUE,
      type = "file",
      regexp = ".html"
    ))

  df_limpo <- df_arquivos %>%
    dplyr::mutate(
      nome_arquivo = fs::path_file(arquivo),
      ano = stringr::str_extract(arquivo, "\\d{4}"),
      mes = stringr::str_extract(arquivo, "\\/\\d{1}\\/"),
      mes = stringr::str_extract(mes, "\\d{1}"),
      comite = stringr::str_extract(nome_arquivo, "^\\X{2,5}\\-"),
      comite = stringr::str_remove_all(comite, "-"),
      pagina = stringr::str_extract(nome_arquivo, "\\-\\X{4,15}\\-"),

      pagina = stringr::str_remove_all(pagina, "[:digit:]"),
      pagina = stringr::str_remove_all(pagina, "-"),
      data = stringr::str_extract(
        nome_arquivo,
        "[:digit:]{2}\\-[:digit:]{2}\\-[:digit:]{4}"
      )
    )

  df_limpo %>%
    dplyr::filter(ano %in% ano_buscar,
                  mes %in% mes_buscar,
                  pagina %in% pagina_buscar)


}
