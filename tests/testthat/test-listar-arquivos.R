# test_that("Listar arquivos funciona", {
#   # Uso comum
#   expect_s3_class(listar_arquivos(), "data.frame")
#
#   # Ano de 2019: Não temos dados. Testar se retorna 0 linhas
#   expect_equal(nrow(listar_arquivos(ano_buscar = 2019)), 0)
#
#   # Mes de março para 2021, sei que tem 21 linhas
#   expect_equal(nrow(listar_arquivos(ano_buscar = 2021, mes_buscar = 3, pagina = "atas"))
# , 21)
#
#   expect_s3_class(listar_arquivos(ano_buscar = 2021, mes_buscar = 3, pagina = "atas"), "data.frame")
#
# })
