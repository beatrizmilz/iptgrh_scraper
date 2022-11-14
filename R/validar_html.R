html_valido <- function(arquivo) {
  elemento_h1 <- arquivo |>
    xml2::read_html() |>
    xml2::xml_find_all("body") |>
    rvest::html_element("h1") |>
    rvest::html_text()

  erro_404 <- !elemento_h1 %in% c("Pagina nÃ£o encontrada")

  erro_404
}
