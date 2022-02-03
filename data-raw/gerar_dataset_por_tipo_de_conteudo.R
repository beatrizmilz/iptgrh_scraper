## code to prepare `DATASET` dataset goes here
devtools::load_all()
# Download da versão mais recente
# devtools::install_github("beatrizmilz/ComitesBaciaSP", force = TRUE)

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
    orgao = dplyr::case_when(
      stringr::str_detect(conteudo_da_pagina, "agencia") ~ "agencia",
      stringr::str_detect(comite, "crh") ~ "crh",
      TRUE ~ "cbh"
    ),
    conteudo_da_pagina = stringr::str_remove_all(conteudo_da_pagina, "_agencia"),
    caminho_salvar_rds =  stringr::str_replace(caminho, ".html$", ".Rds"),
    caminho_salvar_rds =  stringr::str_replace(caminho_salvar_rds, "dados_html", "dados_rds"),
    funcao_utilizar = dplyr::case_when(
      conteudo_da_pagina %in% c("atas", "representantes", "agenda", "deliberacoes", "documentos") ~ "ComitesBaciaSP::raspar_pagina_sigrh",
    ),
    glue_executar = dplyr::case_when(
      !is.na(funcao_utilizar) ~
        glue::glue(
          "{funcao_utilizar}(sigla_do_comite = '{comite}', online = FALSE, path_arquivo = '{caminho}', conteudo_pagina = '{conteudo_da_pagina}', orgao = '{orgao}') |> readr::write_rds(file = '{caminho_salvar_rds}')"
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

beepr::beep(1)

# atas --------
atas_completo <- unificar_base("atas")
usethis::use_data(atas_completo, overwrite = TRUE)

atas_agencia_completo <- unificar_base("atas", agencia = TRUE)
usethis::use_data(atas_agencia_completo, overwrite = TRUE)


# representantes -----
representantes_completo <- unificar_base("representantes")
usethis::use_data(representantes_completo, overwrite = TRUE)


# agenda -----
agenda_completo <- unificar_base("agenda") |>
  limpar_datas_agenda()
usethis::use_data(agenda_completo, overwrite = TRUE)


# deliberacoes  -----
deliberacoes_completo <- unificar_base("deliberacoes")
usethis::use_data(deliberacoes_completo, overwrite = TRUE)


# documentos  -----
documentos_completo <- unificar_base("documentos")
usethis::use_data(documentos_completo, overwrite = TRUE)



