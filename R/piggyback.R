salvar_dados_piggyback <- function(objeto){

  caminho <- glue::glue("data-raw/arquivos_completos/{substitute(objeto)}.rds")

  readr::write_rds(objeto, caminho)

  piggyback::pb_upload(caminho,
                       repo = "beatrizmilz/iptgrh_scraper",
                       tag = "dados")

}
