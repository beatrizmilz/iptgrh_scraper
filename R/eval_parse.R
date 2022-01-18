# Função eval parse
eval_parse <- function(caminho_arquivo_para_ler) {
  eval(parse(text = caminho_arquivo_para_ler))
}
safe_eval_parse <- purrr::safely(eval_parse, "erro")
