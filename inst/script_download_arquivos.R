data <- Sys.Date()
ano <- lubridate::year(data)
mes <- lubridate::month(data)
caminho <- glue::glue("inst/dados_html/{ano}/{mes}")

ComitesBaciaSP::download_html(path = caminho)
