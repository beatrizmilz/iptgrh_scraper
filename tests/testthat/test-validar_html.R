test_that("funcao de validacao do HTML", {

  arquivos_invalidos <- c(
    "inst/dados_html/2021/10/mp-representantes-01-10-2021.html",
    "inst/dados_html/2021/10/mp-representantes-15-10-2021.html",
    "inst/dados_html/2021/10/pp-atas-01-10-2021.html",
    "inst/dados_html/2021/10/pp-atas-15-10-2021.html",
    "inst/dados_html/2021/10/pp-representantes-01-10-2021.html",
    "inst/dados_html/2021/10/pp-representantes-15-10-2021.html",
    "inst/dados_html/2021/10/smg-representantes-01-10-2021.html",
    "inst/dados_html/2021/10/smg-representantes-15-10-2021.html",
    "inst/dados_html/2021/11/mp-representantes-01-11-2021.html",
    "inst/dados_html/2021/11/mp-representantes-15-11-2021.html",
    "inst/dados_html/2021/11/pp-atas-01-11-2021.html",
    "inst/dados_html/2021/11/pp-atas-15-11-2021.html",
    "inst/dados_html/2021/11/pp-representantes-01-11-2021.html",
    "inst/dados_html/2021/11/pp-representantes-15-11-2021.html",
    "inst/dados_html/2021/11/smg-representantes-01-11-2021.html",
    "inst/dados_html/2021/11/smg-representantes-15-11-2021.html",
    "inst/dados_html/2021/12/mp-representantes-01-12-2021.html",
    "inst/dados_html/2021/12/mp-representantes-15-12-2021.html",
    "inst/dados_html/2021/12/pp-atas-01-12-2021.html",
    "inst/dados_html/2021/12/pp-atas-15-12-2021.html",
    "inst/dados_html/2021/12/pp-representantes-01-12-2021.html",
    "inst/dados_html/2021/12/pp-representantes-15-12-2021.html",
    "inst/dados_html/2021/12/smg-representantes-01-12-2021.html",
    "inst/dados_html/2021/12/smg-representantes-15-12-2021.html",
    "inst/dados_html/2021/3/mp-representantes-18-03-2021.html",
    "inst/dados_html/2021/3/pp-atas-18-03-2021.html",
    "inst/dados_html/2021/3/pp-representantes-18-03-2021.html",
    "inst/dados_html/2021/4/mp-representantes-01-04-2021.html",
    "inst/dados_html/2021/4/mp-representantes-15-04-2021.html",
    "inst/dados_html/2021/4/pp-atas-01-04-2021.html",
    "inst/dados_html/2021/4/pp-atas-15-04-2021.html",
    "inst/dados_html/2021/4/pp-representantes-01-04-2021.html",
    "inst/dados_html/2021/4/pp-representantes-15-04-2021.html",
    "inst/dados_html/2021/4/smg-representantes-01-04-2021.html",
    "inst/dados_html/2021/4/smg-representantes-15-04-2021.html",
    "inst/dados_html/2021/5/mp-representantes-01-05-2021.html",
    "inst/dados_html/2021/5/mp-representantes-15-05-2021.html",
    "inst/dados_html/2021/5/pp-atas-01-05-2021.html",
    "inst/dados_html/2021/5/pp-atas-15-05-2021.html",
    "inst/dados_html/2021/5/pp-representantes-01-05-2021.html",
    "inst/dados_html/2021/5/pp-representantes-15-05-2021.html",
    "inst/dados_html/2021/5/smg-representantes-01-05-2021.html",
    "inst/dados_html/2021/5/smg-representantes-15-05-2021.html",
    "inst/dados_html/2021/6/mp-representantes-01-06-2021.html",
    "inst/dados_html/2021/6/mp-representantes-15-06-2021.html",
    "inst/dados_html/2021/6/pp-atas-01-06-2021.html",
    "inst/dados_html/2021/6/pp-atas-15-06-2021.html",
    "inst/dados_html/2021/6/pp-representantes-01-06-2021.html",
    "inst/dados_html/2021/6/pp-representantes-15-06-2021.html",
    "inst/dados_html/2021/6/smg-representantes-01-06-2021.html",
    "inst/dados_html/2021/6/smg-representantes-15-06-2021.html",
    "inst/dados_html/2021/7/mp-representantes-23-07-2021.html",
    "inst/dados_html/2021/7/pp-atas-23-07-2021.html",
    "inst/dados_html/2021/7/pp-representantes-23-07-2021.html",
    "inst/dados_html/2021/7/smg-representantes-23-07-2021.html",
    "inst/dados_html/2021/8/mp-representantes-01-08-2021.html",
    "inst/dados_html/2021/8/mp-representantes-15-08-2021.html",
    "inst/dados_html/2021/8/pp-atas-01-08-2021.html",
    "inst/dados_html/2021/8/pp-atas-15-08-2021.html",
    "inst/dados_html/2021/8/pp-representantes-01-08-2021.html",
    "inst/dados_html/2021/8/pp-representantes-15-08-2021.html",
    "inst/dados_html/2021/8/smg-representantes-01-08-2021.html",
    "inst/dados_html/2021/8/smg-representantes-15-08-2021.html",
    "inst/dados_html/2021/9/mp-representantes-03-09-2021.html",
    "inst/dados_html/2021/9/mp-representantes-15-09-2021.html",
    "inst/dados_html/2021/9/pp-atas-03-09-2021.html",
    "inst/dados_html/2021/9/pp-atas-15-09-2021.html",
    "inst/dados_html/2021/9/pp-representantes-03-09-2021.html",
    "inst/dados_html/2021/9/pp-representantes-15-09-2021.html",
    "inst/dados_html/2021/9/smg-representantes-03-09-2021.html",
    "inst/dados_html/2021/9/smg-representantes-15-09-2021.html",
    "inst/dados_html/2022/1/mp-representantes-01-01-2022.html",
    "inst/dados_html/2022/1/mp-representantes-16-01-2022.html",
    "inst/dados_html/2022/1/pp-atas-01-01-2022.html",
    "inst/dados_html/2022/1/pp-atas-16-01-2022.html",
    "inst/dados_html/2022/1/pp-representantes-01-01-2022.html",
    "inst/dados_html/2022/1/pp-representantes-16-01-2022.html",
    "inst/dados_html/2022/1/smg-representantes-01-01-2022.html",
    "inst/dados_html/2022/1/smg-representantes-16-01-2022.html",
    # novos?
    "inst/dados_html/2021/6/sm-documentos-15-06-2021.html",
    "inst/dados_html/2021/10/sm-atas-01-10-2021.html",
    "inst/dados_html/2021/10/sm-atas-15-10-2021.html",
    "inst/dados_html/2021/10/sm-documentos-01-10-2021.html",
    "inst/dados_html/2021/10/sm-documentos-15-10-2021.html",
    "inst/dados_html/2021/11/sm-atas-01-11-2021.html",
    "inst/dados_html/2021/11/sm-atas-15-11-2021.html",
    "inst/dados_html/2021/11/sm-documentos-01-11-2021.html",
    "inst/dados_html/2021/11/sm-documentos-15-11-2021.html",
    "inst/dados_html/2021/12/sm-atas-01-12-2021.html",
    "inst/dados_html/2021/12/sm-atas-15-12-2021.html",
    "inst/dados_html/2021/12/sm-documentos-01-12-2021.html",
    "inst/dados_html/2021/12/sm-documentos-15-12-2021.html",
    "inst/dados_html/2021/3/sm-documentos-18-03-2021.html",
    "inst/dados_html/2021/4/sm-documentos-01-04-2021.html",
    "inst/dados_html/2021/4/sm-documentos-15-04-2021.html",
    "inst/dados_html/2021/5/sm-documentos-01-05-2021.html",
    "inst/dados_html/2021/5/sm-documentos-15-05-2021.html",
    "inst/dados_html/2021/6/sm-documentos-01-06-2021.html",
    "inst/dados_html/2021/7/sm-documentos-23-07-2021.html",
    "inst/dados_html/2021/8/sm-documentos-01-08-2021.html",
    "inst/dados_html/2021/8/sm-documentos-15-08-2021.html",
    "inst/dados_html/2021/9/sm-atas-03-09-2021.html",
    "inst/dados_html/2021/9/sm-atas-15-09-2021.html",
    "inst/dados_html/2021/9/sm-documentos-03-09-2021.html",
    "inst/dados_html/2021/9/sm-documentos-15-09-2021.html",
    "inst/dados_html/2022/1/sm-atas-01-01-2022.html",
    "inst/dados_html/2022/1/sm-documentos-01-01-2022.html",
    "inst/dados_html/2022/1/sm-documentos-16-01-2022.html",
    "inst/dados_html/2022/10/sm-documentos-01-10-2022.html",
    "inst/dados_html/2022/10/sm-documentos-15-10-2022.html",
    "inst/dados_html/2022/11/sm-documentos-01-11-2022.html",
    "inst/dados_html/2022/2/sm-documentos-01-02-2022.html",
    "inst/dados_html/2022/2/sm-documentos-15-02-2022.html",
    "inst/dados_html/2022/3/sm-documentos-01-03-2022.html",
    "inst/dados_html/2022/3/sm-documentos-15-03-2022.html",
    "inst/dados_html/2022/4/sm-documentos-01-04-2022.html",
    "inst/dados_html/2022/4/sm-documentos-15-04-2022.html",
    "inst/dados_html/2022/5/sm-documentos-01-05-2022.html",
    "inst/dados_html/2022/5/sm-documentos-15-05-2022.html",
    "inst/dados_html/2022/6/sm-documentos-01-06-2022.html",
    "inst/dados_html/2022/6/sm-documentos-15-06-2022.html",
    "inst/dados_html/2022/7/sm-documentos-01-07-2022.html",
    "inst/dados_html/2022/7/sm-documentos-15-07-2022.html",
    "inst/dados_html/2022/8/sm-documentos-03-08-2022.html",
    "inst/dados_html/2022/8/sm-documentos-15-08-2022.html",
    "inst/dados_html/2022/9/sm-documentos-01-09-2022.html",
    "inst/dados_html/2022/9/sm-documentos-15-09-2022.html"
    )

# arquivos que sao invalidos:
  testando_arquivos_invalidos <- arquivos_invalidos |>
  #  purrr::set_names() |>
    purrr::map_lgl(html_valido)

  expect_equal(testando_arquivos_invalidos,
               rep(FALSE, length(testando_arquivos_invalidos)))

  # arquivos validos

  todos_arquivos <- list.files("inst/dados_html", recursive = TRUE, full.names = TRUE)


 arquivos_validos <- todos_arquivos[!todos_arquivos %in% arquivos_invalidos]

 set.seed(345134)

 testando_arquivos_validos <- arquivos_validos |>
   #purrr::set_names() |>
   sample(30) |>
   purrr::map_lgl(html_valido)


 expect_equal(testando_arquivos_validos,
              rep(TRUE, length(testando_arquivos_validos)))

})
