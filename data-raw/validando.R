  RelatoriosTransparenciaAguaSP::documentos_completo|>
  dplyr::filter( stringr::str_detect(data_coleta_dados, "2022")) |>
  dplyr::count(comite) |>
  dplyr::filter(n < 10) |>
    View()

  # verificar se a URL está correta
  # agenda ------------

  # Baixo Tietê - ok, só tem 1 mesmo.


  # atas -------------

  # Paraíba do Sul - ok, comecaram a colocar agora

  # Pontal do Paranapanema - errado! arrumar.

  # documentos -------

  # Serra da Mantiqueira - não tem uma página de documentos

