# deletar <- list.files(path = "inst/dados_rds/",
#            recursive = TRUE, full.names = TRUE) |>
#   tibble::enframe() |>
#   dplyr::filter(stringr::str_detect(value, "representantes")) #|>
#   #dplyr::filter(stringr::str_detect(value, "pp"))
#
# fs::file_delete(deletar$value)
