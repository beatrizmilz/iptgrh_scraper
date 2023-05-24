## code to prepare `DATASET` dataset goes here
devtools::load_all()
# Download da versão mais recente
# devtools::install_github("beatrizmilz/ComitesBaciaSP", force = TRUE)

# Scripts para preparar os dados -----
caminho_arquivos <- base_html_validacao |>
  dplyr::filter(html_valido) |>
  dplyr::mutate(nome_arquivo = fs::path_file(value),
                caminho = value) |>
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
  purrr::map(eval_parse, .progress = TRUE)


beepr::beep(1)

# atas --------
atas_completo <- unificar_base("atas")

salvar_dados_piggyback(atas_completo)


atas_agencia_completo <- unificar_base("atas", agencia = TRUE)

salvar_dados_piggyback(atas_agencia_completo)


# representantes -----
representantes_completo <- unificar_base("representantes")

salvar_dados_piggyback(representantes_completo)


# agenda -----
agenda_completo <- unificar_base("agenda") |>
  limpar_datas_agenda()

salvar_dados_piggyback(agenda_completo)

# deliberacoes  -----
deliberacoes_completo <- unificar_base("deliberacoes")

salvar_dados_piggyback(deliberacoes_completo)

# documentos  -----
documentos_completo <- unificar_base("documentos")

salvar_dados_piggyback(documentos_completo)


