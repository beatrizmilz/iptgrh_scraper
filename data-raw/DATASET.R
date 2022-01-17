## code to prepare `DATASET` dataset goes here
# devtools::load_all("../ComitesBaciaSP/")
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

arquivos_transformar_em_rds <- caminho_arquivos_nao_lidos |>
  tidyr::drop_na(glue_executar)

eval_parse <- function(caminho_arquivo_para_ler) {
  eval(parse(text = caminho_arquivo_para_ler))
}

safe_eval_parse <- purrr::safely(eval_parse, "erro")


arquivos_transformar_em_rds$glue_executar |>
  purrr::map(safe_eval_parse)
# ERRO AQUI! APENAS PARA O COMITE DE MP

# Unificar e exportar bases
unificar_base <- function(conteudo) {
  arquivos_completos <-
    list.files(
      "inst/dados_rds",
      pattern = ".Rds",
      full.names = TRUE,
      recursive = TRUE
    ) |>
    tibble::enframe() |>
    dplyr::filter(stringr::str_detect(value, conteudo))

  arquivos_completos$value |>
    purrr::map_dfr(readr::read_rds)
}

# atas
atas_completo <- unificar_base("atas")
usethis::use_data(atas_completo, overwrite = TRUE)

# representantes
representantes_completo <- unificar_base("representantes")
usethis::use_data(representantes_completo, overwrite = TRUE)


# agenda
agenda_completo <- unificar_base("agenda")
usethis::use_data(agenda_completo, overwrite = TRUE)
