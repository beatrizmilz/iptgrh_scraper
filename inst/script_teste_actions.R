data <- Sys.Date()
ano <- lubridate::year(data)
mes <- lubridate::month(data)
caminho <- glue::glue("inst/dados_teste/{ano}/{mes}")

ComitesBaciaSP::download_pagina_sigrh(path = caminho,
                              sigla_do_comite = "AT",
                              pagina = "atas")
