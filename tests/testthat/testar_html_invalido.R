testthat::skip()

test_that("Testando HTML inválido", {

  # O seguinte vetor foi construído manualmente,
  # no arquivo data-raw/arquivos_html_invalidos: ----
  # arquivos_html_invalidos

  # Copiamos os arquivos para uma pasta de dados para testes -----
  # arquivos_invalidos_copy <- arquivos_invalidos |>
  #   stringr::str_replace(
  #     "dados_html/[0-9]{4}/[0-9]{1,2}/",
  #     "dados_testes/html_invalido/"
  #   )

  # fs::dir_create("inst/dados_testes/html_invalido/")
  # fs::file_copy(arquivos_invalidos, arquivos_invalidos_copy, overwrite = TRUE)

  # Construindo o vetor de arquivos invalidos
  arquivos_invalidos_copy <-
    fs::dir_ls(here::here("inst/dados_testes/html_invalido/"))

  # Aplicando a função que verifica se um HTML é válido
  testando_arquivos_invalidos <- arquivos_invalidos_copy |>
    here::here() |>
    purrr::map_lgl(html_valido)

  # Verificando se todos os arquivos são classificados como
  expect_equal(testando_arquivos_invalidos,
               rep(FALSE, length(testando_arquivos_invalidos)))

})
