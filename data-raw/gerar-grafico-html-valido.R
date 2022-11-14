library(ggplot2)


base_trabalhada <- base_html_validacao |>
  dplyr::mutate(data_extracao = readr::parse_date(data_extracao, "%d-%m-%Y")) |>
  dplyr::group_by(ano, mes, comite, data_extracao) |>
  dplyr::filter(tipo_info != "atas_agencia", comite != "crh") |>
  dplyr::summarise(cat_validacao = sum(html_valido)) |>
  dplyr::ungroup() |>
  dplyr::mutate(
    cat = dplyr::case_when(
      cat_validacao == 5 ~ "completo",
      cat_validacao >= 1 & cat_validacao < 5 ~ "incompleto",
      cat_validacao == 0 ~ "não coletado"
    )
  ) |>
  tidyr::complete(ano, mes, comite,
                  fill = list(cat_validacao = 0, cat = "não coletado")) |>
  dplyr::group_by(ano, mes, comite) |>
  dplyr::filter(data_extracao == min(data_extracao) |
                  is.na(data_extracao)) |>
  dplyr::ungroup() |>
  dplyr::mutate(
    data_extracao = dplyr::if_else(is.na(data_extracao), as.Date(paste0(ano, "-", mes, "-01")),
                                   data_extracao),
    data2 = as.character(data_extracao)
  ) |>
  dplyr::filter(data_extracao >= "2022-02-01",
                 # "2021-03-01",
                data_extracao <
                  Sys.Date()) |>
  dplyr::mutate(comite = stringr::str_to_upper(comite))


  base_trabalhada |>
  ggplot() +
  aes(x = data_extracao, y = comite, fill = cat) +
  geom_tile() +
  theme(legend.position = "bottom") +
  scale_fill_brewer(type = "div")  +
  scale_x_date(date_breaks = "2 months")
