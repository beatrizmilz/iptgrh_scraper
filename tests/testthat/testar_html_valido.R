testthat::skip()

test_that("Testando HTML válido", {

  # Primeiro vamos buscar todos os arquivos possíveis: ----

  # todos_arquivos <- list.files("inst/dados_html",
  #                              recursive = TRUE,
  #                              full.names = TRUE)
  #
  # # Agora vamos buscar os arquivos inválidos: ----
  # arquivos_html_invalidos
  #
  # # Removendo os arquivos inválidos dos arquivos possíveis: ----
  # arquivos_validos <- todos_arquivos[!todos_arquivos %in% arquivos_html_invalidos] |>
  #   sample(30)


 # Fazendo uma cópia para a paste dados_testes/html_valido/
 # arquivos_validos_copy <- arquivos_validos |>
 #   stringr::str_replace(
 #     "dados_html/[0-9]{4}/[0-9]{1,2}/",
 #     "dados_testes/html_valido/"
 #   )
 #
    # Copiamos os arquivos para uma pasta de dados para testes ----------------
 # fs::dir_create("inst/dados_testes/html_valido")
 #
 # fs::file_copy(arquivos_validos, arquivos_validos_copy, overwrite = TRUE)
 #

  # Construindo o vetor de arquivos para testar
  arquivos_validos_copy <-
    fs::dir_ls(here::here("inst/dados_testes/html_valido/"))

  # Aplicando a função que verifica se um HTML é válido
  testando_arquivos_validos <- arquivos_validos_copy |>
    here::here() |>
    purrr::map_lgl(html_valido)

  # Verificando se todos os arquivos são classificados como válidos
  expect_equal(testando_arquivos_validos,
               rep(TRUE, length(testando_arquivos_validos)))

})
