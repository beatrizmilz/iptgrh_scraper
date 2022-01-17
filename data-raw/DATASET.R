## code to prepare `DATASET` dataset goes here

# Scripts para preparar os dados -----

caminho_arquivos <-
  tibble::tibble(
    caminho = list.files(
      "inst/dados_html",
      pattern = ".html",
      full.names = TRUE,
      recursive = TRUE
    ),
    nome_arquivo = list.files("inst/dados_html", pattern = ".html", recursive = TRUE)
  ) |>
  dplyr::mutate(nome_arquivo = fs::path_file(nome_arquivo)) |>
  tidyr::separate(
    nome_arquivo,
    c("comite", "conteudo_da_pagina", "dia", "mes", "ano"),
    sep = "-",
    remove = FALSE,
    extra = "drop"
  ) |>
  dplyr::mutate(ano = stringr::str_remove_all(ano, ".html")) |>
  dplyr::mutate(
    caminho_salvar_rds =  stringr::str_replace(caminho, ".html$", ".Rds"),
    caminho_salvar_rds =  stringr::str_replace(caminho_salvar_rds, "dados_html", "dados_rds")
  )

# criar as pastas
dirname(caminho_arquivos$caminho) |>
  stringr::str_replace("dados_html", "dados_rds") |>
  fs::dir_create()

# ver arquivos já lidos

arquivos_lidos <-
  list.files(
    "inst/dados_rds",
    pattern = ".Rds",
    full.names = TRUE,
    recursive = TRUE
  )

caminho_arquivos_nao_lidos <- caminho_arquivos |>
  dplyr::filter(!caminho_salvar_rds %in% arquivos_lidos)

unique(caminho_arquivos$conteudo_da_pagina)

# LER ATAS ------------------------------------
# Função --------
obter_tabela_atas_comites_modificado <- function(base) {
  base_lida <- ComitesBaciaSP::obter_tabela_atas_comites(
    sigla_do_comite = base$comite[1],
    online = FALSE,
    path_arquivo = base$caminho[1]
  )

  base_lida |> readr::write_rds(file = base$caminho_salvar_rds[1])
}
# filtrar por atas
atas_ler <- caminho_arquivos_nao_lidos |>
  dplyr::filter(conteudo_da_pagina == "atas")

# ler atas
atas_ler |>
  dplyr::group_split(caminho) |>
  purrr::map(obter_tabela_atas_comites_modificado)

# unificar base de atas
atas_completas <-
  list.files(
    "inst/dados_rds",
    pattern = ".Rds",
    full.names = TRUE,
    recursive = TRUE
  ) |>
  purrr::map_dfr(readr::read_rds)

# exportar base de atas
usethis::use_data(atas_completas, overwrite = TRUE)


# PRÓXIMO: REPRESENTANTES
