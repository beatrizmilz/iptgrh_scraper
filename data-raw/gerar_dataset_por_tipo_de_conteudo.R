## code to prepare `DATASET` dataset goes here

# Download da versão mais recente
# devtools::install_github("beatrizmilz/ComitesBaciaSP")

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
    caminho_salvar_rds =  stringr::str_replace(caminho_salvar_rds, "dados_html", "dados_rds"),
    funcao_utilizar = dplyr::case_when(
      conteudo_da_pagina == "atas" ~ "ComitesBaciaSP::obter_tabela_atas_comites",
      conteudo_da_pagina == "representantes" ~ "ComitesBaciaSP::obter_tabela_representantes_comites",
      conteudo_da_pagina == "agenda" ~ "ComitesBaciaSP::obter_tabela_agenda_comites",
    ),
    glue_executar = dplyr::case_when(
      !is.na(funcao_utilizar) ~
        glue::glue(
          "{funcao_utilizar}(sigla_do_comite = '{comite}', online = FALSE, path_arquivo = '{caminho}') |> readr::write_rds(file = '{caminho_salvar_rds}')"
        )
    )
  )

# criar as pastas (se necessário)
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

# caminho de arquivos não lidos
caminho_arquivos_nao_lidos <- caminho_arquivos |>
  dplyr::filter(!caminho_salvar_rds %in% arquivos_lidos)


# caminho de arquivos para transformar em RDS
arquivos_transformar_em_rds <- caminho_arquivos_nao_lidos |>
  tidyr::drop_na(glue_executar)

# transformar em rds
arquivos_transformar_em_rds$glue_executar |>
  purrr::map(safe_eval_parse)

# atas --------
atas_completo <- unificar_base("atas")
usethis::use_data(atas_completo, overwrite = TRUE)

# representantes -----
representantes_completo <- unificar_base("representantes")
usethis::use_data(representantes_completo, overwrite = TRUE)


# agenda -----
agenda_completa <- unificar_base("agenda") |>
  limpar_datas_agenda()
usethis::use_data(agenda_completo, overwrite = TRUE)
