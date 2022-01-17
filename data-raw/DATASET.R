## code to prepare `DATASET` dataset goes here

caminho_arquivos <- tibble::tibble(caminho = list.files("inst/dados_html", pattern = ".html", full.names = TRUE, recursive = TRUE),
                                   nome_arquivo = list.files("inst/dados_html", pattern = ".html", recursive = TRUE)) |>
  dplyr::mutate(nome_arquivo = fs::path_file(nome_arquivo)) |>
  tidyr::separate(
    nome_arquivo,
    c("comite", "conteudo_de_pagina", "dia", "mes", "ano"),
    sep = "-",
    remove = FALSE,
    extra = "drop"
  ) |>
  dplyr::mutate(ano = stringr::str_remove_all(ano, ".html"))

# criar as pastas
dirname(caminho_arquivos$caminho) |>
  stringr::str_replace("dados_html", "dados_rds") |>
  fs::dir_create()

# filtrar por atas
atas_ler <- caminho_arquivos |>
  dplyr::filter(conteudo_de_pagina == "atas") |> head()

obter_tabela_atas_comites_modificado <- function(base){
#
#   base <- atas_ler|>
#     dplyr::group_split(caminho) |>
#     purrr::pluck(1)


  base_complementar <- base |>
    dplyr::mutate(caminho_salvar =  stringr::str_replace(caminho, ".html$", ".Rds$"),
                  caminho_salvar =  stringr::str_replace(caminho_salvar, "dados_html", "dados_rds"))

   base_lida <- ComitesBaciaSP::obter_tabela_atas_comites(
    sigla_do_comite = base_complementar$comite[1],
    online = FALSE,
    path_arquivo = base_complementar$caminho[1]
  )

  base_lida |> readr::write_rds(file = base_complementar$caminho_salvar[1])
}


atas_ler |>
  dplyr::group_split(caminho) |>
  purrr::map(obter_tabela_atas_comites_modificado)



# atas_lido <-
#   purrr::map2_dfr(
#     .x = atas_ler$comite,
#     .y = atas_ler$caminho,
#     .f = ~ ComitesBaciaSP::obter_tabela_atas_comites(
#       sigla_do_comite = .x,
#       online = FALSE,
#       path_arquivo = .y
#     )
#   )



usethis::use_data(atas_lido, overwrite = TRUE)
