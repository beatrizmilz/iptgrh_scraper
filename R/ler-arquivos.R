ler_arquivos <- function(df) {
  if (unique(df$pagina) == "atas") {
    obter_atas <- function(x) {
      ComitesBaciaSP::obter_tabela_atas_comites(
        sigla_do_comite = NULL,
        online = FALSE,
        path_arquivo = x
      )
    }
    purrr::map_dfr(.x = df$arquivo,
                   .f = obter_atas)


  }
}
